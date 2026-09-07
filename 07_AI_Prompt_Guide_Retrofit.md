# 07 搭配 AI 的提示指南 — Retrofit 串接 Spring Boot REST API

> 使用前提：你已完成 Day 1–3（`01–03`），會 Activity、Intent、RecyclerView、Room、lambda。
> 目標：教你「讓 AI 產生」一支用 **Retrofit** 呼叫 Spring Boot 的 Android App。
> 心法同 `04–06`：**你決定需求，AI 寫程式，但你要看懂、能改、能驗證**。
> 本指南同時附**後端（Spring Boot）**與**前端（Android）**兩邊的提示，因為你起步就需要一支能測的 REST API。

---

## 目錄

- [0. 重點回顧與前置概念](#0-重點回顧與前置概念)
- [1. 建立一支 Spring Boot BMI 後端](#1-建立一支-spring-boot-bmi-後端)
- [2. Android 加 Retrofit 依賴](#2-android-加-retrofit-依賴)
- [3. Retrofit 三件套：API 介面 / Retrofit 實例 / 資料類別](#3-retrofit-三件套)
- [4. 讓 AI 產生「BMI 串後端」完整範例](#4-bmi-串後端完整範例)
- [5. 非同步與主執行緒限制](#5-非同步與主執行緒限制)
- [6. 練習擴充提示](#6-練習擴充提示)
- [7. 讓 AI 幫你除錯](#7-讓-ai-幫你除錯)
- [8. 提示寫作重點回顧（Retrofit）](#8-提示寫作重點回顧)

---

## 0. 重點回顧與前置概念

| 概念 | 對照你已懂的 |
|---|---|
| HTTP 四大動作 | GET/POST/PUT/DELETE（像呼叫方法） |
| JSON | 後端回傳的文字格式（像 properties 但可巢狀） |
| REST API 端點 | 一個網址 + 動作，例如 `GET api/bmi?h=170&w=60` |
| Retrofit | 把「呼叫 API」包成「呼叫一個 Java 介面方法」 |
| `enqueue` + `Callback` | 類似 `setOnClickListener` 的 listener，背景執行後回主執行緒 |
| **`10.0.2.2`** | 模擬器裡代表「你電腦的 localhost」，**不能用 `127.0.0.1` 或 `localhost`** |

> GUI 程式最大的差異是「**非同步**」：你不能在 UI 執行緒等網路回應，要交給背景、再回 UI 更新。

---

## 1. 建立一支 Spring Boot BMI 後端

先用 AI 生一支「後端可呼叫的 API」，Android 才有東西連。

**提示（後端）**
```
我是 Java 開發者，懂 Spring Boot 基本概念。請幫我建一支「BMI 計算」REST API 的 Spring Boot 專案：

1. 用 Maven，套件 com.example.bmibackend，name「bmi-backend」，Java 17
2. 依賴：spring-boot-starter-web
3. BmiController.java：@RestController
   - GET /api/bmi?height=170&weight=60
   - 用 @RequestParam double height、double weight
   - 回傳一個 JSON 物件，欄位：bmi(double, 取小數 2 位)、category(String: 過輕/正常/過重/肥胖)
   - category 用 if/else 判斷（BMI<18.5 過輕、<24 正常、<27 過重、其餘肥胖）
4. 一個 BmiResult class 用於回傳（bmi、category 兩欄位，getter/setter）
5. 告訴我怎麼啟動（mvn spring-boot:run）與測試（瀏覽器開 http://localhost:8080/api/bmi?height=170&weight=60）
請附完整程式碼與 pom.xml。
```

**驗證**：瀏覽器開上述網址，應回傳例如 `{"bmi":20.76,"category":"正常"}`。

> 前端要連本機後端時，**模擬器用 `http://10.0.2.2:8080/`**；實機要用你電腦的區網 IP。

---

## 2. Android 加 Retrofit 依賴

**提示**
```
我是 Android Java 開發者（用新版 Gradle / version catalog 或傳統 build.gradle 皆可）。
請告訴我，在 Android 專案加 Retrofit 需要哪些依賴，並考慮：若用 Groovy 的 build.gradle 要怎麼寫？
- retrofit:com.squareup.retrofit2:retrofit
- converter-gson:com.squareup.retrofit2:converter-gson
請同時提醒：連本機/明文 HTTP 需要在 AndroidManifest 加 android:usesCleartextTraffic="true" 與 INTERNET 權限。
```

> ⚠️ 沒加 `<uses-permission android:name="android.permission.INTERNET"/>` 會連不上；預設 Android 9+ 禁止明文 HTTP，需 `usesCleartextTraffic="true"`（僅開發用）。

---

## 3. Retrofit 三件套

**提示**
```
請用 JFrame 的角度，幫我建立 Retrofit 的三個基本元件，套件 com.example.bmiapp：

1. BmiResult.java：POJO，欄位 double bmi、String category，getter/setter，無參數建構子（給 Gson 反序列化用，欄位名要和後端一致）
2. BmiApi.java：interface
   - @GET("api/bmi")
   - Call<BmiResult> getBmi(@Query("height") double height, @Query("weight") double weight)
3. RetrofitClient.java：單例
   - private static RetrofitClient instance; private final BmiApi api;
   - 建構子：new Retrofit.Builder().baseUrl("http://10.0.2.2:8080/").addConverterFactory(GsonConverterFactory.create()).build()
   - getApi() 回傳 BmiApi
   - 用 synchronized 雙重檢查鎖定保證單例

請說明：Gson 為何需要無參數建構子、欄位名為何必須對上後端 JSON。
```

---

## 4. BMI 串後端完整範例

**需求提示**（`com.example.bmiapp`）
```
我學到「用 Retrofit 串 Spring Boot BMI 後端」，套件 com.example.bmiapp，請幫我產出完整檔案：

依賴：retrofit + converter-gson（build.gradle）；Manifest 加 INTERNET 權限與 usesCleartextTraffic="true"

1. BmiResult.java：POJO（bmi double、category String，無參數建構子 + getter/setter）
2. BmiApi.java：@GET("api/bmi") + @Query(height, weight) 回傳 Call<BmiResult>
3. RetrofitClient.java：雙重檢查鎖定單例，baseUrl("http://10.0.2.2:8080/")
4. activity_main.xml：EditText etHeight(身高 cm)、etWeight(體重 kg)、按鈕 btnCalc「計算 BMI」、TextView tvResult
5. MainActivity.java：
   - BmiApi api = RetrofitClient.getInstance().getApi()
   - btnCalc 點擊：解析身高體重（try/catch NumberFormatException）
   - api.getBmi(h, w).enqueue(new Callback<BmiResult>(){ ... })：
     - onResponse：if(response.isSuccessful() && response.body()!=null) → tvResult.setText(...)
     - onFailure：Toast 顯示錯誤訊息
   - 說明「為什麼用 anonymous class 而不是 lambda」—— Callback 介面有 onResponse 與 onFailure 兩個方法
請用 Java。
```

**用戶端自我驗證**
- 先確認後端在跑（瀏覽器可開）
- 輸入 170 / 60 → 點計算 → 結果顯示「BMI 20.76（正常）」
- 停掉後端再點 → 出現 onFailure 的 Toast（學到如何處理失敗）

---

## 5. 非同步與主執行緒限制

**提示（學習）**
```
請用 JFrame 的 SwingWorker 或 Event Dispatch Thread 對照，教我在 Android 非同步呼叫網路：
1. 為何不能在主執行緒呼叫 api.getBmi().execute()（阻塞會 ANR）
2. Retrofit 的 enqueue 做了什麼：背景執行請求和 → 自動切回主執行緒呼叫 onResponse/onFailure
3. Callback 的 onResponse / onFailure 兩個方法，為何不能用 lambda（多方法介面）
4. onFailure 會在哪些情況下觸發（網路沒通、timeout、伺服器 500 也會進 onFailure？）
請給簡短可跑的片段。
```

> 重點釐清：**HTTP 4xx/5xx 狀態碼會進 `onResponse`（但 isSuccessful()==false）**，真正「沒連到」才進 `onFailure`。很多人搞混。

---

## 6. 練習擴充提示

**擴充 1：POST 傳 JSON**
```
請把 BMI API 改成用 POST，A/B 兩邊都改：
- 後端：@PostMapping("/api/bmi")，@RequestBody 一個 BmiRequest{height, weight}
- Android：BmiApi 改 @POST("api/bmi")，參數 @Body BmiRequest，多建一個可序列化的 BmiRequest class
```

**擴充 2：串登入**
```
請教我整合 Day 2 的 Intent + 這個 Retrofit：做一個登入頁，POST 帳密到後端，
成功後用 Intent 跳到主頁並傳入使用者資訊。後端可先寫死一組正確帳密。
```

**擴充 3：列表 + 圖片**
```
請幫我做一支：從 GET /api/users 抓使用者 List<User>，用 RecyclerView + Glide 顯示頭像 (avatarUrl) 與名稱。
提醒我：List<User> 用 TypeToken、Glide 載入 URL、RecyclerView 設定。
```

---

## 7. 讓 AI 幫你除錯

| 常見錯誤 | 你可以這樣問 |
|---|---|
| `NetworkOnMainThreadException` | 「我直接呼叫 api.execute() 就崩了，是不是因為在主執行緒？該怎麼用 enqueue？」 |
| 連不上後端 | 「我用 localhost 連不上，是不是模擬器要用 10.0.2.2？還有是不是要 usesCleartextTraffic 和 INTERNET 權限？」 |
| 回傳 null / 資料對不上 | 「Gson 反序列化拿到 null，是不是我的欄位名和後端 JSON 不一致？幫我校對 BmiResult 和後端回傳格式」 |
| 狀態碼是錯誤的 | 「後端回我 500，但 onFailure 沒被呼叫，為什麼？該看 response.code() 和 response.errorBody() 嗎？」 |
| 編譯錯誤 (build.gradle) | 「我加了 retrofit 依賴但 import 不過，請告訴我完整的 build.gradle 依賴並呼叫 Sync」 |

> 貼上**完整錯誤訊息（含 Logcat）**與你的程式碼，AI 才精準。

---

## 8. 提示寫作重點回顧（Retrofit）

| 重點 | 做法 |
|---|---|
| **兩邊都要** | 純 Android 提示連不上，務必同時給後端提示 |
| **端點網址寫清楚** | 明確 `10.0.2.2`（模擬器）的 baseUrl，別寫 localhost |
| **Callback 用 anonymous class** | 明確要求，因為兩個方法不能 lambda |
| **欄位名要對上** | 提醒「Gson 欄位名 = 後端 JSON 欄位名」 |
| **附依賴 + 權限** | 每次都要 Retrofit 依賴、INTERNET 權限、cleartext |
| **POST/GET 分清楚** | 講明用 `@Query` 還是 `@Body` |

---

## 建議複習流程

1. **先照後端提示**生出一支可測的 BMI REST API
2. **再用前端提示**讓 AI 產出 Retrofit App
3. **照貼後跑通**（後端開著，模擬器連 `10.0.2.2`）
4. 故意停掉後端 → 確認 onFailure 分支有處理
5. 用擴充提示做 POST / 登入 / 列表+圖片
6. 最後回到 **`Phase2_Learning_Roadmap.md`** 的 MVVM 階段，把資料流整理乾淨

> 下一篇建議：`08_AI_Prompt_Guide_MVVM.md`（ViewModel / LiveData / Repository），把 Retrofit + Room 用 MVVM 包起來。
