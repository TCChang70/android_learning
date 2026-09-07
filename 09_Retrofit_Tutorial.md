# Retrofit 教學 — Android 用 Retrofit 串接 Spring Boot REST API（含完整程式與講解）

> 對象：已完成 Day 1–3（會 Activity、Intent、RecyclerView、Room、lambda），熟 Swing/JFrame 的 Java 開發者。
> 本篇是「有程式 + 有解釋」的完整教學（對照 `07` 那份是「讓 AI 產程式」的提示指南，兩者可搭配）。
> 前端技術棧：**Java + XML**。後端：**Spring Boot (Java) + Maven**。
> 與 JFrame 的對照會用 ⚡ 標記。

---

## 目錄

- [0. 這一篇在做什麼](#0-這一篇在做什麼)
- [1. 背景知識：HTTP、JSON、REST](#1-背景知識)
- [2. 先做後端：Spring Boot BMI REST API](#2-後端-spring-boot)
- [3. Android 端：加依賴與設定](#3-android-加依賴與設定)
- [4. Retrofit 三件套：資料類別 / API 介面 / 單例](#4-retrofit-三件套)
- [5. 完整範例：BMI 串後端](#5-完整範例-bmi-串後端)
- [6. 非同步與主執行緒限制](#6-非同步與主執行緒限制)
- [7. 進階：POST + 傳 JSON、處理列表與圖片](#7-進階)
- [8. 除錯檢查清單](#8-除錯檢查清單)

---

## 0. 這一篇在做什麼

到目前為止（Day 1–3），你的 App 資料都存在**手機內部**（SharedPreferences / Room）。
這篇要教你踏入「**手機 ↔ 伺服器**」的世界：Android 透過 **Retrofit** 這個函式庫，
去呼叫一支執行在你的電腦（或雲端）上的 **Spring Boot REST API**，把資料從伺服器抓回來或傳上去。

⚡ 對照理解：Retrofit 之於 Android，就像 **HttpClient 之於 Java desktop** —— 都是「發 HTTP 請求拿回應」，
只是 Retrofit 幫你把「網址 + 參數 + JSON 轉換 + 背景執行緒」都包裝好了。

最終成果：一支 App，輸入身高體重，送給後端計算，回傳 BMI 與分類顯示在畫面。

---

## 1. 背景知識

### 1-1 HTTP 四大動作
| 動作 | 用途 | 像 |
|---|---|---|
| **GET** | 取資料（帶參數在網址） | 查詢 |
| **POST** | 送資料建立資源（帶 JSON body） | 新增 |
| **PUT** | 更新 | 修改 |
| **DELETE** | 刪除 | 移除 |

### 1-2 JSON
後端回傳給你的「資料文字格式」，可巢狀、有型別：
```json
{ "bmi": 20.76, "category": "正常" }
```
Android 端用 **Gson** 把它自動轉成 Java 物件（`BmiResult`）。

### 1-3 REST API 端點
一組「網址 + 動作」。例如：
```
GET  http://localhost:8080/api/bmi?height=170&weight=60
```
- base URL：`http://localhost:8080/`
- 路徑：`api/bmi`
- 查詢參數：`?height=170&weight=60`

### 1-4 什麼是「序列化 / 反序列化」
- **序列化**：Java 物件 → JSON（傳給後端）
- **反序列化**：JSON → Java 物件（後端回傳 → 你的 class）
- Gson 靠「欄位名稱」對應，所以**你的 class 欄位名必須和 JSON 欄位名一致**。

---

## 2. 後端：Spring Boot BMI REST API

先做後端，Android 才有東西連。用 Spring Initializr（start.spring.io）或你熟悉的 Maven 建立專案。

### 2-1 `pom.xml`（關鍵依賴）
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

### 2-2 回傳用的資料類別 `BmiResult.java`
```java
package com.example.bmibackend;

public class BmiResult {
    private double bmi;
    private String category;

    // 必須有無參數建構子（Gson/Jackson 反序列化需要）
    public BmiResult() {}

    public BmiResult(double bmi, String category) {
        this.bmi = bmi;
        this.category = category;
    }

    public double getBmi() { return bmi; }
    public void setBmi(double bmi) { this.bmi = bmi; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}
```

### 2-3 控制器 `BmiController.java`
```java
package com.example.bmibackend;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class BmiController {

    @GetMapping("/bmi")          // GET /api/bmi?height=170&weight=60
    public BmiResult calc(@RequestParam double height,
                          @RequestParam double weight) {
        double m = height / 100.0;        // 公分轉公尺
        double bmi = weight / (m * m);    // BMI = 公斤 / 公尺^2
        bmi = Math.round(bmi * 100.0) / 100.0;   // 取小數 2 位

        String category;
        if (bmi < 18.5)      category = "過輕";
        else if (bmi < 24)   category = "正常";
        else if (bmi < 27)   category = "過重";
        else                 category = "肥胖";

        return new BmiResult(bmi, category);
    }
}
```

**啟動與測試**
```bash
mvn spring-boot:run
```
瀏覽器開：
```
http://localhost:8080/api/bmi?height=170&weight=60
```
應回傳：
```json
{"bmi":20.76,"category":"正常"}
```

> ✅ 後端完成。接下來 Android 端就是「呼叫這支 API」。

---

## 3. Android 加依賴與設定

### 3-1 `build.gradle`（Module 層級，Groovy 寫法）
```gradle
dependencies {
    implementation 'com.squareup.retrofit2:retrofit:2.11.0'
    implementation 'com.squareup.retrofit2:converter-gson:2.11.0'
}
```

### 3-2 `AndroidManifest.xml` 加權限
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- 必須：允許網路 -->
    <uses-permission android:name="android.permission.INTERNET" />
    ...
    <!-- 開發用：允許明文 HTTP（Android 9+ 預設禁止），上線建議改 HTTPS -->
    <application
        android:usesCleartextTraffic="true"
        ...>
    </application>
</manifest>
```

> ⚠️ 沒加 `INTERNET` 權限 → 連不上；沒加 `usesCleartextTraffic` → 連 `http://` 會被系統擋掉。

### 3-3 連本機後端：用 `10.0.2.2` 不是 `localhost`
Android **模擬器**裡，`localhost` 指的是模擬器自己，不是你的電腦。
要連到「你開發機上的 Spring Boot」，必須用特殊位址 **`10.0.2.2`**：

```java
// 模擬器連本機後端
Retrofit retrofit = new Retrofit.Builder()
        .baseUrl("http://10.0.2.2:8080/")
        ...
```
> 實機（手機）則改用你電腦的區網 IP，例如 `http://192.168.1.5:8080/`。

---

## 4. Retrofit 三件套

### 4-1 資料類別 `BmiResult.java`（Android 端，欄位名對應後端）
```java
package com.example.bmiapp;

public class BmiResult {
    private double bmi;      // 欄位名必須和後端 JSON 一致
    private String category;

    public BmiResult() {}    // Gson 反序列化需要無參數建構子

    public double getBmi() { return bmi; }
    public void setBmi(double bmi) { this.bmi = bmi; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}
```

### 4-2 API 介面 `BmiApi.java`
```java
package com.example.bmiapp;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Query;

public interface BmiApi {
    // GET /api/bmi?height=...&weight=...
    @GET("api/bmi")
    Call<BmiResult> getBmi(@Query("height") double height,
                           @Query("weight") double weight);
}
```
- `@GET("api/bmi")`：路徑（會接在 baseUrl 後面）
- `@Query("height")`：把它變成 `?height=...`
- 回傳 `Call<BmiResult>`：代表「尚未執行的請求」，之後用 `enqueue` 去執行

⚡ 這就像定義一個「你會用到的 API 方法的簽名」，Retrofit 在背後幫你實作了 HTTP 細節。

### 4-3 單例 `RetrofitClient.java`
```java
package com.example.bmiapp;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitClient {
    private static RetrofitClient instance;
    private final BmiApi api;

    private RetrofitClient() {
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("http://10.0.2.2:8080/")          // 模擬器連本機後端
                .addConverterFactory(GsonConverterFactory.create()) // JSON <-> 物件
                .build();
        api = retrofit.create(BmiApi.class);               // 產生介面的實作
    }

    public static synchronized RetrofitClient getInstance() {
        if (instance == null) {
            instance = new RetrofitClient();
        }
        return instance;
    }

    public BmiApi getApi() { return api; }
}
```
- **單例**：全 App 只建立一次 Retrofit，避免浪費
- `synchronized`：多執行緒同時呼叫時只建一次（雙重檢查鎖定可進一步優化）
- `GsonConverterFactory`：讓 Gson 自動把回傳 JSON 轉成 `BmiResult`

---

## 5. 完整範例：BMI 串後端

### 5-1 `activity_main.xml`
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center_horizontal"
    android:padding="24dp">

    <EditText
        android:id="@+id/etHeight"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="身高 (cm)"
        android:inputType="number" />

    <EditText
        android:id="@+id/etWeight"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="體重 (kg)"
        android:inputType="numberDecimal" />

    <Button
        android:id="@+id/btnCalc"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="計算 BMI" />

    <TextView
        android:id="@+id/tvResult"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="結果"
        android:textSize="20sp" />
</LinearLayout>
```

### 5-2 `MainActivity.java`
```java
package com.example.bmiapp;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainActivity extends AppCompatActivity {

    private EditText etHeight, etWeight;
    private TextView tvResult;
    private final BmiApi api = RetrofitClient.getInstance().getApi();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etHeight = findViewById(R.id.etHeight);
        etWeight = findViewById(R.id.etWeight);
        tvResult = findViewById(R.id.tvResult);
        Button btnCalc = findViewById(R.id.btnCalc);

        btnCalc.setOnClickListener(v -> calcBmi());
    }

    private void calcBmi() {
        // 解析輸入，處理非數字
        double height, weight;
        try {
            height = Double.parseDouble(etHeight.getText().toString());
            weight = Double.parseDouble(etWeight.getText().toString());
        } catch (NumberFormatException e) {
            Toast.makeText(this, "請輸入有效數字", Toast.LENGTH_SHORT).show();
            return;
        }

        // enqueue: 背景執行請求，完成後回主執行緒
        api.getBmi(height, weight).enqueue(new Callback<BmiResult>() {
            @Override
            public void onResponse(Call<BmiResult> call, Response<BmiResult> response) {
                if (response.isSuccessful() && response.body() != null) {
                    BmiResult r = response.body();
                    tvResult.setText(String.format("BMI %.2f（%s）", r.getBmi(), r.getCategory()));
                } else {
                    Toast.makeText(MainActivity.this,
                            "伺服器錯誤：" + response.code(), Toast.LENGTH_SHORT).show();
                }
            }

            @Override
            public void onFailure(Call<BmiResult> call, Throwable t) {
                // 網路沒通 / 連不到後端才會走到這裡
                Toast.makeText(MainActivity.this,
                        "連線失敗：" + t.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
    }
}
```

**逐行解說重點**
- `RetrofitClient.getInstance().getApi()`：拿單例裡的 API 實作
- `.enqueue(new Callback<BmiResult>() {...})`：
  - **背景執行緒**發請求，不 block 主執行緒
  - 完成後**自動切回主執行緒**呼叫回呼 ✅
  - `Callback` 有 `onResponse` 和 `onFailure` **兩個**方法 → 所以**不能用 lambda**（多方法介面），要 anonymous class
- `onResponse`：
  - 伺服器「有回應」就進來（不代表成功！）
  - `response.isSuccessful()`：檢查 HTTP 200–299
  - `response.body()`：Gson 已轉好的 `BmiResult`
- `onFailure`：**連不到**（網路斷、後端沒開、timeout）才進來

### 5-3 驗證
1. 先啟動後端（`mvn spring-boot:run`）
2. 在模擬器跑 App
3. 輸入 170 / 60 → 點計算 → 顯示「BMI 20.76（正常）」
4. **把後端停掉**再點 → 出現「連線失敗」Toast（驗證 onFailure 分支）

> ⚡ 這個 `Callback` 是不是很像你熟悉的 `ActionListener`？都是「完成後叫我」的 callback 模式：
> - `addActionListener(e -> ...)` → 使用者點按鈕
> - `.enqueue(callback)` → 網路回應完成

---

## 6. 非同步與主執行緒限制

### 6-1 為什麼不能在主執行緒做網路
Android 的 **主執行緒（UI thread）** 只管畫畫面、處理輸入。若你在主執行緒等待網路回應，
畫面會卡住 → 系統判定「App 無回應」→ **ANR（Application Not Responding）**。
而且 Android 會直接拋 `NetworkOnMainThreadException` 防止你這樣做。

⚡ 這點和 Swing 的 **Event Dispatch Thread (EDT)** 很像：不能在 EDT 上做長時間工作。

### 6-2 Retrofit 的 `enqueue` 幫你做完了
`enqueue` 內部：
1. 在**背景執行緒**發 HTTP 請求
2. 收到回應後，**切回主執行緒**呼叫 `onResponse` / `onFailure`

所以你**不用自己開 thread**，只要提供回呼。這就是為什麼用 Retrofit 最省事。

### 6-3 若不用 Retrofit、要自己處理背景
可用 Java 的 `ExecutorService`（背景）＋ `runOnUiThread()`（切回主執行緒）：
```java
ExecutorService executor = Executors.newSingleThreadExecutor();
executor.execute(() -> {
    // 背景：做耗時工作
    String result = doNetworkCall();
    // 切回主執行緒更新 UI
    runOnUiThread(() -> tvResult.setText(result));
});
```
> `AsyncTask` 是舊時代產物，**已被官方淘汰**，新專案不要用它。

---

## 7. 進階：POST + 傳 JSON、處理列表與圖片

### 7-1 POST 傳 JSON（帶 `@Body`）
後端：
```java
@PostMapping("/bmi")
public BmiResult calcByPost(@RequestBody BmiRequest req) { ... }
```

Android 端需多一個「可序列化送出的」request class：
```java
public class BmiRequest {
    public double height, weight;   // 送出去，要能序列化
    public BmiRequest(double h, double w) { height = h; weight = w; }
}
```
API 介面改為：
```java
@POST("api/bmi")
Call<BmiResult> calcByPost(@Body BmiRequest request);
```
呼叫：
```java
api.calcByPost(new BmiRequest(170, 60)).enqueue(new Callback<BmiResult>() {...});
```
> 關鍵差異：GET 用 `@Query`（參數在網址），POST 用 `@Body`（參數在 JSON body）。

### 7-2 抓取列表（`List<User>`）
後端回傳陣列：
```json
[ {"id":1,"name":"小明","avatarUrl":"http://.../a.png"}, {...} ]
```
Android API：
```java
@GET("api/users")
Call<List<User>> getUsers();
```
> Gson 會自動把 JSON 陣列轉成 `List<User>`，`User` class 欄位名要對應。

### 7-3 用 Glide 載入圖片
加依賴：
```gradle
implementation 'com.github.bumptech.glide:glide:4.16.0'
```
RecyclerView 的 `onBindViewHolder` 裡：
```java
Glide.with(itemView.getContext())
     .load(user.getAvatarUrl())   // 傳 URL
     .into(holder.ivAvatar);
```
配合你 Day 2 學的 RecyclerView + ViewHolder，即可做出「串後端列表 + 圖片」的完整畫面。

---

## 8. 除錯檢查清單

| 症狀 | 檢查 |
|---|---|
| `NetworkOnMainThreadException` 崩潰 | 忘了用 `enqueue`，直接 `execute()` 又在主執行緒 |
| 連不上後端 | 模擬器要用 `10.0.2.2`（不是 localhost）；確認後端有開 |
| 顯示「Cleartext not permitted」 | `AndroidManifest` 沒加 `android:usesCleartextTraffic="true"` |
| `IO`/`Security` 錯誤 | 沒加 `<uses-permission android:name="android.permission.INTERNET"/>` |
| `onResponse` 但 `body()` 是 null / 欄位 null | 你的 class 欄位名和後端 JSON 不一致 |
| HTTP 4xx/5xx 你以為失敗其實是 onResponse | 要檢查 `response.isSuccessful()`；`onFailure` 只在「連不到」時 |
| import 不過 | `build.gradle` 沒加 Retrofit / converter-gson，加完要 **Sync** |

---

## 總結

- **Retrofit** 把「發 HTTP + JSON 轉換 + 背景執行緒」包裝成「呼叫 Java 介面方法」
- 三件套：**資料類別（對應 JSON）+ API 介面（@GET/@POST）+ 單例 Retrofit**
- **`enqueue(new Callback)`** 是非同步正確用法；`Callback` 兩方法 → 用 anonymous class 不能 lambda
- 模擬器連本機後端用 **`10.0.2.2`**；記得 `INTERNET` 權限 + `usesCleartextTraffic`
- 資料流：`UI(event) → api.enqueue → 背景執行 → 回主執行緒 onResponse/onFailure → 更新 UI`

> 下一步：把這支 BMI App 的資料流用 **MVVM（ViewModel + LiveData + Repository）**整理起來 → 見 `08_AI_Prompt_Guide_MVVM.md`。
> 想讓 AI 幫你生出程式碼：見 `07_AI_Prompt_Guide_Retrofit.md`（同樣這套範例的提示版）。
