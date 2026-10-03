---
marp: true
theme: default
paginate: true
size: 16:9
header: 'Day 2：頁面跳轉與列表（多畫面 App）+ AI 互動指南'
style: |
    section { font-size: 18px; padding: 24px 44px; }
    h1 { font-size: 30px; }
    h2 { font-size: 25px; }
    h3 { font-size: 20px; }
    pre { font-size: 9.5px; line-height: 1.2; padding: 5px 9px; }
    pre code { white-space: pre-wrap; word-break: break-word; }
    table { font-size: 14px; }
    blockquote { font-size: 15px; }
    li { margin: 2px 0; }
---

<!--
使用方式：
1. VS Code 安裝 Marp for VS Code 外掛
2. 開啟本檔 → 右上角「Marp: Preview / 匯出 PDF / 匯出 HTML / 匯出 PPTX」
3. 分頁符號為 `---`
4. 「AI 動手做」章節穿插在各教學主題之後，跟著看、跟著做
-->

# Day 2 合併版投影片

## 頁面跳轉與列表：多畫面 App

### 教學內容 + AI 提示互動指南（穿插版）

---

# 本講內容

- 對象：具備 Java / JFrame 經驗，**已完成 Day 1**
- 時間：約 6–8 小時
- 今天會學到：
  - Activity 多畫面、`Intent` 跳轉
  - 畫面間 `putExtra` / `getExtra` 傳值、回傳結果（新舊兩套 API）
  - 系統功能 Intent（撥號、開網頁）
  - 常用系統互動畫面：日期/時間選擇、`Spinner`、單選/多選、`PickVisualMedia` / `OpenDocument` / `TakePicture`（選擇器家族）
  - `ListView` / `RecyclerView` 列表 + `ArrayAdapter`、`ArrayList` 動態容器
  - `AlertDialog` 彈窗
  - 三支完整整合範例：Todo App、商品編輯傳值、顏色選擇器
- ⚡ 與 JFrame 的對照會用 ⚡ 標記

---

# Day 2 內容優化建議（同步教材版）

1. 先做最小可執行 Demo，再回頭拆原理，降低卡關率
2. 命名規範統一：`btnXxx`、`etXxx`、`tvXxx`、`lvXxx`
3. 每章固定「常見錯誤」區塊：Manifest、id 綁定、`notifyDataSetChanged()`
4. 新舊 API 成對教學：`startActivityForResult` vs `registerForActivityResult`
5. ListView 章節升級為「自訂動態列」而非只顯示字串
6. 每支完整範例都附「操作 -> 預期結果」驗收表
7. 章末練習採漸進式：改文案 -> 改資料結構 -> 改互動
8. 結尾先說明「記憶體資料會消失」，銜接 Day 3 持久化

> 這一頁可當助教授課 checklist。

---

# AI 動手做｜與 AI 互動提醒（指南 §0）

| 提醒 | 說明 |
|---|---|
| **背後的陷阱** | 新版 `registerForActivityResult` 用 lambda 回呼；舊 `onActivityResult` 是**方法覆寫，不能用 lambda** |
| **多檔案** | 有的範例要 4 支檔（2 XML + 2 Java），一次跟 AI 要完整才不會對不上 |
| **給套件名** | 不同範例套件名不同，務必指定，避免 id 或 class 對不上 |
| **驗證每一支** | 每個範例照貼後 Run 一次，確認跳轉、傳值、列表都正常 |

> 橘色 `[ ... ]` 是你要自己填的部分；凡是我給的範例提示都可直接複製。

---

# 第 1 章　認識 Activity（多個畫面）

一個 Activity = 一個畫面。要建第二個畫面：

1. 右鍵套件 → **New → Activity → Empty Views Activity**
2. 命名 `SecondActivity` → 自動產生 `SecondActivity.java` + `activity_second.xml`

> ⚡ `SecondActivity` 就等於你另外設計的第二個 `JFrame`。

## 1.1 AndroidManifest.xml 必須註冊 Activity

```xml
<activity android:name=".SecondActivity" />
```

- `android:name=".SecondActivity"`：`.` 開頭 = 「目前套件底下」，等同 `套件名 + .SecondActivity`
- Manifest 是 App 的「身分證」；**手動建 class 忘了註冊會跳錯**（精靈會自動註冊）

---

# 🔧 第 1 章　建立 SecondActivity 完整操作步驟

**在 Android Studio 中：**

1. 左側 `Project` 面板 → 展開 `app > java > com.example.[你的套件]`
2. **右鍵點擊套件名** → `New` → `Activity` → `Empty Views Activity`
3. `Activity Name` 填入 `SecondActivity` → 點 `Finish`
4. 系統自動產生兩支檔案：
   - `app/java/com.example.xxx/SecondActivity.java`
   - `app/res/layout/activity_second.xml`
5. 自動在 `AndroidManifest.xml` 加入 `<activity android:name=".SecondActivity" />`

**驗證**：開啟 `app/src/main/AndroidManifest.xml`，確認 `<application>` 區塊內有：

```xml
<activity android:name=".SecondActivity" />
```

> ⚠️ 若使用 `New > Java Class` 而非 `New > Activity`，Manifest **不會自動更新**，需手動補上這行。

---

# AI 動手做｜建立第二個 Activity（指南 §1）

**建立過程通常不需要 AI**：照精靈做，Android Studio 會自動註冊到 `AndroidManifest.xml`。

但可以用 AI 確認「為什麼要註冊、忘了會怎樣」：

```
我用 Android Studio 建立了 SecondActivity，但它不小心沒被註冊到 AndroidManifest.xml，
請用 JFrame 的角度跟我解釋：1) AndroidManifest.xml 是甚麼？ 2) 沒註冊會發生什麼錯誤？
3) 怎麼手動補上 <activity android:name=".SecondActivity" />？
```

> 之後的範例都循「New Project → 新增第二個 Activity」的流程，先會跳轉，再學傳值。

---

# 第 2 章　Intent：啟動新的 Activity

```java
Button btnGo = findViewById(R.id.btnGo);
btnGo.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this, SecondActivity.class);
    startActivity(intent);   // 啟動並跳轉
});
```

- `new Intent(出發點, 目的地)`：第一參數 `MainActivity.this`（從哪）、第二參數 `SecondActivity.class`（到哪）
- `startActivity(intent)`：把意圖交給系統，系統啟動新畫面
- ⚡ JFrame 用 `new SecondFrame().setVisible(true)` 直接建物件；Android 是「描述要去哪裡」交給系統

## 2.1 為什麼用 `MainActivity.this`？

- lambda / anonymous class 裡面的 `this` 指的是**匿名類別自己**，不是 Activity
- 用「**類別名稱.this**」明確指向 `MainActivity` 實體，才能當作 Intent 的出發點

---

# ⭐ 第 2 章　完整範例：兩頁面跳轉 App（jumpdemo）

套件 `com.example.jumpdemo`，共 4 支檔案。

**檔案結構：**
```
app/
├── res/layout/
│   ├── activity_main.xml      ← 畫面 A
│   └── activity_second.xml    ← 畫面 B
└── java/com.example.jumpdemo/
    ├── MainActivity.java      ← 畫面 A 邏輯
    └── SecondActivity.java    ← 畫面 B 邏輯
```

**Step 1**：New Project → `Empty Views Activity`，Package name = `com.example.jumpdemo`
**Step 2**：右鍵套件 → `New > Activity > Empty Views Activity` → 命名 `SecondActivity`

---

# ⭐ jumpdemo｜activity_main.xml（畫面 A）

```xml
<!-- 檔案：app/res/layout/activity_main.xml -->
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="這是第一個畫面"
        android:textSize="20sp"
        android:layout_marginBottom="24dp"/>

    <Button
        android:id="@+id/btnGo"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="點我跳到第二畫面"/>

</LinearLayout>
```

---

# ⭐ jumpdemo｜activity_second.xml（畫面 B）

```xml
<!-- 檔案：app/res/layout/activity_second.xml -->
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="這是第二畫面"
        android:textSize="24sp"/>

</LinearLayout>
```

---

# ⭐ jumpdemo｜MainActivity.java（含 import）

```java
// 檔案：app/java/com.example.jumpdemo/MainActivity.java
package com.example.jumpdemo;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button btnGo = findViewById(R.id.btnGo);
        btnGo.setOnClickListener(v -> {
            // new Intent(從哪個 Activity, 去哪個 Activity.class)
            Intent intent = new Intent(MainActivity.this, SecondActivity.class);
            startActivity(intent);   // 啟動 SecondActivity
        });
    }
}
```

---

# ⭐ jumpdemo｜SecondActivity.java（含 import）

```java
// 檔案：app/java/com.example.jumpdemo/SecondActivity.java
package com.example.jumpdemo;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;

public class SecondActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);   // 顯示 activity_second.xml
        // 畫面 B 不需要額外邏輯，只顯示佈局即可
    }
}
```

| 執行 | 預期結果 |
|---|---|
| 點「點我跳到第二畫面」 | 切換到「這是第二畫面」 |
| 按返回鍵 ⌫ | 回到第一個畫面 |

> ⚠️ 若跳到 B 崩潰，先確認 Manifest 有 `<activity android:name=".SecondActivity" />`。

---

# AI 動手做｜提示 1：兩頁面跳轉 App（指南 §2）

```
我是 Swing Java 開發者，已完成 Day 1，正在學 Android（Java + XML）。
請幫我完成「兩頁面跳轉 App」，套件 com.example.jumpdemo，共 4 支檔案：

1. activity_main.xml：垂直 LinearLayout、置中、一支 TextView「這是第一個畫面」、一支按鈕 btnGo「點我跳到第二畫面」
2. MainActivity.java：findViewById 綁定 btnGo，點擊後 new Intent(MainActivity.this, SecondActivity.class) 再 startActivity，用 lambda
3. activity_second.xml：一支置中 TextView「這是第二畫面」
4. SecondActivity.java：setContentView(R.layout.activity_second)

請用 lambda，並用 JFrame 的 new SecondFrame().setVisible(true) 對照說明。
```

**用戶端自我驗證**：點按鈕跳 B、按返回鍵回 A。

---

# 第 3 章　畫面間傳遞資料（putExtra / getExtra）

**3.1 A 端 putExtra（塞進行李袋）**

```java
Intent intent = new Intent(MainActivity.this, SecondActivity.class);
intent.putExtra("name", "張三");
intent.putExtra("age", 30);          // int
intent.putExtra("isStudent", true);  // boolean
startActivity(intent);
```

**3.2 B 端 getExtra（從行李袋拿出）**

```java
String name = getIntent().getStringExtra("name");
int age = getIntent().getIntExtra("age", 0);
boolean isStudent = getIntent().getBooleanExtra("isStudent", false);
```

- `Intent` 像行李袋；`putExtra` 一件件塞、`getExtra` 一件件拿（key 兩邊要相同）
- **`getIntExtra` 第二個參數是「預設值」**——沒拿到該 key 就回傳它，不崩潰

---

# ⭐ 第 3 章　完整範例：A → B 傳值 App（senddata）

套件 `com.example.senddata`，**4 支檔案**。

**Step 1**：New Project → Package = `com.example.senddata`　　**Step 2**：新增 `SecondActivity`（精靈）

**activity_main.xml**（輸入頁）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:gravity="center" android:padding="24dp">
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="傳資料給 B" android:textSize="22sp" android:layout_marginBottom="20dp"/>
    <EditText android:id="@+id/etName" android:layout_width="match_parent"
        android:layout_height="wrap_content" android:hint="請輸入姓名" android:layout_marginBottom="12dp"/>
    <EditText android:id="@+id/etAge" android:layout_width="match_parent"
        android:layout_height="wrap_content" android:hint="請輸入年齡"
        android:inputType="number" android:layout_marginBottom="20dp"/>
    <Button android:id="@+id/btnSend" android:layout_width="wrap_content"
        android:layout_height="wrap_content" android:text="傳送並跳到 B"/>
</LinearLayout>
```

---

# ⭐ senddata｜activity_second.xml + SecondActivity.java

**activity_second.xml**（顯示頁）：
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:gravity="center" android:padding="24dp">
    <TextView android:id="@+id/tvShow"
        android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="尚未收到資料" android:textSize="20sp"/>
</LinearLayout>
```

**SecondActivity.java**（含 import）：
```java
package com.example.senddata;
import android.os.Bundle; import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
public class SecondActivity extends AppCompatActivity {
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        TextView tvShow = findViewById(R.id.tvShow);
        String name = getIntent().getStringExtra("name");
        int age = getIntent().getIntExtra("age", -1);   // 預設 -1，拿不到時看得出來
        tvShow.setText("你好，" + name + "，今年 " + age + " 歲");
    }
}
```
| 張三/30 → 傳送 | B 顯示「你好，張三，今年 30 歲」 |
|---|---|
| 只填姓名不填年齡 | B 顯示「年齡 -1」（預設值生效，不崩潰） |

---

# ⭐ senddata｜MainActivity.java（putExtra 送出，含 import）

```java
// 檔案：app/java/com.example.senddata/MainActivity.java
package com.example.senddata;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EditText etName = findViewById(R.id.etName);
        EditText etAge  = findViewById(R.id.etAge);
        Button btnSend  = findViewById(R.id.btnSend);

        btnSend.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, SecondActivity.class);
            intent.putExtra("name", etName.getText().toString().trim());
            String ageText = etAge.getText().toString().trim();
            // 空白時送 0，避免 parseInt 拋例外
            intent.putExtra("age", ageText.isEmpty() ? 0 : Integer.parseInt(ageText));
            startActivity(intent);
        });
    }
}
```

> ⚡ 對照 Swing：`showInputDialog` 同步卡住等輸入；Android 改為「A 送出、B 接收」非同步拆兩邊。

---

# AI 動手做｜提示 2：A → B 傳值 App（指南 §3）

```
請幫我完成「A→B 傳值 App」，套件 com.example.senddata，共 4 支檔案：

1. activity_main.xml：標題「傳資料給 B」、EditText etName(姓名)、EditText etAge(inputType="number")、按鈕 btnSend「傳送並跳到 B」
2. MainActivity.java：按鈕點擊時 intent.putExtra("name", 姓名)、putExtra("age", 年齡 int)，再 startActivity
3. activity_second.xml：一支置中 TextView tvShow「尚未收到資料」
4. SecondActivity.java：用 getIntent().getStringExtra("name") 拿姓名、getIntExtra("age", -1) 拿年齡，setText 顯示「你好，xxx，今年 x 歲」

重點：getIntExtra 的第二個參數是「預設值」。請用 lambda。
```

**驗證**：只填姓名不填年齡 → B 顯示「年齡 -1」。

---

# 第 4 章　回傳結果給前一個畫面（舊寫法）

```java
// A 端：啟動並等待結果
btnPick.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this, SecondActivity.class);
    startActivityForResult(intent, 1001);   // 1001 = request code
});

@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == 1001 && resultCode == RESULT_OK) {
        String result = data.getStringExtra("result");
        tvResult.setText("收到：" + result);
    }
}
```

```java
// B 端：回傳並關閉
Intent data = new Intent();
data.putExtra("result", "這是回傳的資料");
setResult(RESULT_OK, data);   // 設定結果（還沒送出）
finish();                     // 關閉 B → 系統把結果送回 A
```

- `requestCode`：分辨「是哪次要求」；`resultCode`：B 回的狀態（`RESULT_OK`）
- ⚠️ **`onActivityResult` 是方法覆寫 → 不能用 lambda**（只能 override）

---

# ⭐ resultdemo｜MainActivity.java（A 端，含 import）

```java
package com.example.resultdemo;
import android.content.Intent; import android.os.Bundle;
import android.widget.Button; import android.widget.TextView;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    TextView tvResult;
    // ★ 欄位層宣告，不能在 onCreate 內部建立（IllegalStateException）
    ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            result -> {   // 單一方法介面 → 可用 lambda
                if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                    String value = result.getData().getStringExtra("result");
                    tvResult.setText("收到（新版）：" + value);
                }
            });
```

---

# ⭐ resultdemo｜MainActivity.java（接續：onCreate + 舊版回呼）

```java
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tvResult = findViewById(R.id.tvResult);
        Button btnNew = findViewById(R.id.btnLaunchNew);
        Button btnOld = findViewById(R.id.btnLaunchOld);
        btnNew.setOnClickListener(v ->
            resultLauncher.launch(new Intent(this, SecondActivity.class)));
        btnOld.setOnClickListener(v ->
            startActivityForResult(new Intent(this, SecondActivity.class), 1001));
    }

    // ⚠️ onActivityResult 是「覆寫既有方法」→ 必須 @Override，不能 lambda
    @Override
    protected void onActivityResult(int req, int res, Intent data) {
        super.onActivityResult(req, res, data);
        if (req == 1001 && res == RESULT_OK && data != null)
            tvResult.setText("收到（舊版）：" + data.getStringExtra("result"));
    }
}
```

---

# ⭐ resultdemo｜activity_main.xml（A 端佈局）

```xml
<!-- 檔案：app/res/layout/activity_main.xml -->
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:gravity="center" android:padding="24dp">
    <Button android:id="@+id/btnLaunchNew" android:layout_width="wrap_content"
        android:layout_height="wrap_content" android:text="新版 API 啟動 B"
        android:layout_marginBottom="8dp"/>
    <Button android:id="@+id/btnLaunchOld" android:layout_width="wrap_content"
        android:layout_height="wrap_content" android:text="舊版 API 啟動 B"
        android:layout_marginBottom="20dp"/>
    <TextView android:id="@+id/tvResult" android:layout_width="wrap_content"
        android:layout_height="wrap_content" android:text="尚未收到回傳" android:textSize="18sp"/>
</LinearLayout>
```

**activity_second.xml**（B 端）：EditText `etFeedback` + Button `btnSendBack`「回傳給 A 並關閉」

---

# ⭐ resultdemo｜SecondActivity.java（B 端回傳，含 import）

```java
package com.example.resultdemo;
import android.content.Intent; import android.os.Bundle;
import android.widget.Button; import android.widget.EditText;
import androidx.appcompat.app.AppCompatActivity;

public class SecondActivity extends AppCompatActivity {
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        EditText etFeedback = findViewById(R.id.etFeedback);
        Button btnSendBack  = findViewById(R.id.btnSendBack);
        btnSendBack.setOnClickListener(v -> {
            Intent data = new Intent();   // 空袋，只裝資料
            data.putExtra("result", etFeedback.getText().toString().trim());
            setResult(RESULT_OK, data);   // 設好結果
            finish();                     // 關閉 B → 系統觸發 A 的回呼
        });
    }
}
```

| 操作 | 預期結果 |
|---|---|
| 點「新版」→ B 輸入「Hello」→ 回傳 | A 顯示「收到（新版）：Hello」 |
| 點「舊版」→ B 輸入「Hi」→ 回傳 | A 顯示「收到（舊版）：Hi」 |

> 🔑 **新版**：`OnActivityResult` 是**單一方法介面** → 可 lambda；**舊版**：覆寫既有方法 → 只能 `@Override`。

---

# AI 動手做｜提示 3：回傳結果、新舊寫法（指南 §4）

```
請幫我完成「A↔B 回傳結果 App」，套件 com.example.resultdemo，共 4 支檔案。
要同時示範「新版 registerForActivityResult」和「舊 startActivityForResult」兩支按鈕：

1. activity_main.xml：標題、兩個按鈕 btnLaunchNew(新版) 和 btnLaunchOld(舊寫法)、結果 TextView tvResult
2. MainActivity.java：
   - 新版：ActivityResultLauncher<Intent> lasResult = registerForActivityResult(new ActivityResultContracts.StartActivityForResult(), result -> {...}，用 lambda 接結果
   - 舊版：onActivityResult 覆寫方法，檢查 requestCode == 1001 && resultCode == RESULT_OK（此方法不能用 lambda，請用 @Override）
3. activity_second.xml：標題、EditText etFeedback、按鈕 btnSendBack「回傳給 A 並關閉」
4. SecondActivity.java：空 Intent new Intent() + putExtra("result", ...) + setResult(RESULT_OK, data) + finish()

請特別講解：為什麼新版能 lambda、舊版不能（覆寫方法 vs 單一方法介面）。
```

> 這是 Day 2 最容易混淆的地方：**兩顆按鈕各跑一次**比較，再問 AI 講一次差異。

---

# 第 5 章　Intent 的其它用法（呼叫系統功能）

```java
// 撥號：只開啟撥號介面，不會真的播出
Intent dial = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678"));
startActivity(dial);

// 開啟網頁：交給系統挑瀏覽器
Intent web = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com"));
startActivity(web);
```

- `Intent.ACTION_DIAL` / `ACTION_VIEW`：**動作（action）**——「我想做什麼」
- `Uri.parse(...)`：把文字包成 Android URI（`tel:`、`https:`）
- 程式**不指定用哪個 App**——系統自動挑選能處理的應用程式
- ⚡ 對照 Swing 只能自己 `Desktop.open(uri)`；Android 更靈活

---

# ⭐ sysints｜activity_main.xml（完整）

```xml
<!-- 檔案：app/res/layout/activity_main.xml -->
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:gravity="center" android:padding="24dp">
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="呼叫系統功能" android:textSize="22sp"
        android:layout_marginBottom="24dp"/>
    <Button android:id="@+id/btnDial" android:layout_width="wrap_content"
        android:layout_height="wrap_content" android:text="撥號（Dial）"
        android:layout_marginBottom="12dp"/>
    <Button android:id="@+id/btnWeb" android:layout_width="wrap_content"
        android:layout_height="wrap_content" android:text="開啟網頁（View）"/>
</LinearLayout>
```

---

# ⭐ sysints｜MainActivity.java（含 import）

```java
package com.example.sysints;
import android.content.Intent;
import android.net.Uri;          // ← 常忘記！Uri.parse 需要這個
import android.os.Bundle;
import android.widget.Button;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button btnDial = findViewById(R.id.btnDial);
        Button btnWeb  = findViewById(R.id.btnWeb);
        btnDial.setOnClickListener(v ->   // ACTION_DIAL：不需要 CALL_PHONE 權限
            startActivity(new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678"))));
        btnWeb.setOnClickListener(v ->    // ACTION_VIEW：系統選瀏覽器開啟
            startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com"))));
    }
}
```

| 執行 | 預期結果 |
|---|---|
| 按「撥號（Dial）」 | 開啟系統撥號介面，號碼已帶入（不必真撥出） |
| 按「開啟網頁（View）」 | 開啟瀏覽器載入 Google |

> ⚠️ 常見錯誤：忘記 `import android.net.Uri;` → 編譯時 `Uri cannot be resolved`。

---

# AI 動手做｜提示 4：系統功能 App（指南 §5）

```
請幫我完成「呼叫系統功能」App，套件 com.example.sysints，一支 Activity：
1. activity_main.xml：標題、btnDial「撥號」、btnWeb「開啟網頁」
2. MainActivity.java：
   - btnDial：new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678")) 再 startActivity
   - btnWeb：new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com")) 再 startActivity
   請用 lambda，並 import android.net.Uri。
```

> 現在你已會「跳轉 / 傳值 / 回傳 / 呼叫系統」。接著認識「挑選系統資產」，再進入**列表**。

---

# 第 5.5 章　常用系統互動畫面（選擇器家族）

| 需求 | 用法 |
|---|---|
| 日期選擇 | `DatePickerDialog` |
| 時間選擇 | `TimePickerDialog` |
| 下拉選單 | `Spinner` + `ArrayAdapter` |
| 單選清單 | `AlertDialog.setSingleChoiceItems` |
| 多選清單 | `AlertDialog.setMultiChoiceItems` |
| 選圖 | `PickVisualMedia`（新版） |
| 選檔案 | `OpenDocument` |
| 拍照 | `TakePicture` + `FileProvider` |

> 第 5 章是「呼叫系統」，這一章是「挑選系統資產」。

---

# 5.5 核心觀念：Activity Result API

- 用「合約（Contract）」描述要做什麼：`PickVisualMedia`、`OpenDocument`、`TakePicture`…
- 用 `registerForActivityResult(...)` 註冊 `ActivityResultLauncher`，結果回到 callback

> ⚠️ **最重要規則**：`registerForActivityResult(...)` 必須在生命週期進入 `RESUMED` **之前**完成註冊 → 一律寫成**欄位**。

```java
// 欄位層：建構階段即完成註冊
private final ActivityResultLauncher<PickVisualMediaRequest> pickMediaLauncher =
    registerForActivityResult(new PickVisualMedia(), uri -> {
        if (uri != null) ivPhoto.setImageURI(uri);
    });
```

> 寫在按鈕點擊內才註冊 → `IllegalStateException: ... while current state is RESUMED`。

---

# 5.5｜選圖：PickVisualMedia（新版 Photo Picker）

- Android 13（API 33）Photo Picker，AndroidX 向下支援，**不需要** `READ_MEDIA_IMAGES` 權限
- 依賴：`androidx.activity:activity >= 1.7.0`（建議 1.9.3+）

```java
// 舊機備援
private final ActivityResultLauncher<String> getContentLauncher =
    registerForActivityResult(new GetContent(), uri -> {
        if (uri != null) ivPhoto.setImageURI(uri);
    });

btnPick.setOnClickListener(v -> {
    if (PickVisualMedia.isPhotoPickerAvailable(this)) {
        pickMediaLauncher.launch(new PickVisualMediaRequest.Builder()
            .setMediaType(PickVisualMedia.ImageOnly.INSTANCE).build());
    } else {
        getContentLauncher.launch("image/*");
    }
});
```

| 合約 | 啟動參數 | 回傳 | 權限 |
|---|---|---|---|
| `PickVisualMedia` | `PickVisualMediaRequest` | `Uri?` | 免權限 |

---

# 5.5｜選檔案：OpenDocument

```java
private final ActivityResultLauncher<String[]> openDocLauncher =
    registerForActivityResult(new OpenDocument(), uri -> {
        if (uri != null) {
            getContentResolver().takePersistableUriPermission(
                uri, Intent.FLAG_GRANT_READ_URI_PERMISSION);
            tvFile.setText("已選擇：\n" + uri);
        }
    });

btnOpen.setOnClickListener(v ->
    openDocLauncher.launch(new String[]{"application/pdf", "image/*"}));
```

- 啟動參數是 **`String[]`（MIME types）**：`application/pdf`、`image/*`、`*/*`
- 重開 App 仍要能讀 → 呼叫 `takePersistableUriPermission`

| 比較 | PickVisualMedia | OpenDocument |
|---|---|---|
| 目的 | 挑照片/影片 | 挑任意文件 |
| 輸入 | `PickVisualMediaRequest` | `String[]`（MIME） |
| 持久權限 | 系統處理 | 可 `takePersistableUriPermission` |

---

# 5.5｜拍照：TakePicture + FileProvider

1. 建立 `res/xml/file_paths.xml`
2. `AndroidManifest.xml` 註冊 `<provider>`
3. 建暫存檔 → `FileProvider.getUriForFile` → `TakePicture`
4. callback 用該 Uri 顯示圖片

```xml
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-files-path name="my_images" path="Pictures/" />
</paths>

<provider
    android:name="androidx.core.content.FileProvider"
    android:authorities="com.example.takepicturedemo.fileprovider"
    android:exported="false" android:grantUriPermissions="true">
    <meta-data android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/file_paths" />
</provider>
```

```java
File photoFile = File.createTempFile("IMG_", ".jpg",
    getExternalFilesDir(Environment.DIRECTORY_PICTURES));
pendingPhotoUri = FileProvider.getUriForFile(
    this, "com.example.takepicturedemo.fileprovider", photoFile);
takePictureLauncher.launch(pendingPhotoUri);
```

> ⚠️ `android:authorities` 必須與 `getUriForFile(..., "此字串", ...)` **完全一致**。

---

# 5.5｜常見錯誤排查 + 驗收清單

| 症狀 | 原因 | 解法 |
|---|---|---|
| `register while RESUMED` | 點擊內才註冊 | 改欄位宣告 |
| `Failed to find configured root` | `file_paths.xml` 沒對應目錄 | 補正確標籤 |
| 拍照 `IllegalArgumentException` | authorities 不一致 | Manifest ↔ 程式字串一致 |
| 選不到圖片 | 無 Photo Picker 又沒備援 | `isPhotoPickerAvailable` 切換 `GetContent` |
| 重開讀不到檔 | 未取持久權限 | `takePersistableUriPermission` |
| `FileUriExposedException` | 用了 `Uri.fromFile` | 改用 `FileProvider` |

**驗收**：選圖（13+ Photo Picker / 舊機退 `GetContent`）、選檔（顯示 `content://`）、拍照（照片顯示於 `ImageView`）、無 `IllegalStateException` / `FileUriExposedException`。

---

# AI 動手做｜5.5 選擇器家族提示（指南 §5.5）

**提示 4-1：Activity Result API 規則**
```
我在學 Android 的 Activity Result API（registerForActivityResult）。
請用 JFrame 的角度解釋：為什麼要改用 Activity Result API？為什麼 ActivityResultLauncher
必須宣告成欄位、不能寫在 onCreate() 或按鈕點擊裡？寫在 onCreate() 會出現什麼錯誤？
請附一段「選圖」的最小可編譯範例。
```

**提示 4-2：預約表單 App（`com.example.formdemo`）**
```
請幫我完成「預約表單 App」，套件 com.example.formdemo：
btnDate→DatePickerDialog、btnTime→TimePickerDialog、spPeople→Spinner、btnMeal→AlertDialog.setSingleChoiceItems。
注意 Calendar.MONTH 是 0 起始、顯示要 +1；Spinner 的 setSelection 要放在 setAdapter 之後。用 lambda 並加中文註解。
```

**提示 4-3：個人頭像挑選 App（`com.example.avatarpicker`）**
```
請幫我完成「個人頭像挑選 App」，套件 com.example.avatarpicker：
三個 launcher 都宣告成欄位——PickVisualMedia（舊機備援 GetContent）、OpenDocument（takePersistableUriPermission）、
TakePicture + FileProvider（附 file_paths.xml 與 AndroidManifest provider，authorities 要與 getUriForFile 一致）。
用 lambda 並加中文註解。
```

> 完整提示見 `05_AI_Prompt_Guide_Day2.md` §5.5。

---

# 第 6 章　顯示列表：ListView + ArrayAdapter

**6.1 XML 加入 ListView**（`layout_height="0dp"` + `layout_weight="1"` 讓它填滿剩餘空間）

```xml
<ListView android:id="@+id/listView"
    android:layout_width="match_parent"
    android:layout_height="0dp"
    android:layout_weight="1"/>
```

**6.2 用 ArrayAdapter 顯示文字陣列**

```java
String[] items = {"蘋果", "香蕉", "柳橙", "葡萄"};
// ArrayAdapter<>(Context, 每列的系統內建佈局, 資料來源)
ArrayAdapter<String> adapter = new ArrayAdapter<>(
        this, android.R.layout.simple_list_item_1, items);
listView.setAdapter(adapter);   // ≈ JList.setModel(...)

// setOnItemClickListener 的 lambda 固定 4 個參數，不能省略
listView.setOnItemClickListener((parent, view, position, id) ->
        Toast.makeText(this, "你選了：" + items[position], Toast.LENGTH_SHORT).show());
```

- `android.R.layout.simple_list_item_1`：**系統內建單行文字樣式**，不用自建 row XML
- `(parent, view, position, id)` **4 個參數缺一不可**，`position` 是最常用的
- ⚡ `setAdapter` ≈ `JList.setModel(...)`

---

# ⭐ 第 6 章　完整範例：基礎水果清單（listdemo，含 import）

```java
// 檔案：app/java/com.example.listdemo/MainActivity.java
package com.example.listdemo;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ListView listView = findViewById(R.id.listView);
        String[] items = {"蘋果", "香蕉", "柳橙", "葡萄", "西瓜"};

        ArrayAdapter<String> adapter = new ArrayAdapter<>(
                this,
                android.R.layout.simple_list_item_1,   // 系統內建單行樣式
                items);
        listView.setAdapter(adapter);

        listView.setOnItemClickListener((parent, view, position, id) ->
                Toast.makeText(this, "你選了：" + items[position],
                        Toast.LENGTH_SHORT).show());
    }
}
```

**activity_main.xml** 關鍵結構：垂直 LinearLayout → `TextView`（標題）→ `ListView`（`0dp + weight=1`）。

---

# AI 動手做｜提示 5：學習 ListView 概念（指南 §6）

```
請用 JFrame 的角度解釋 Android 的 ListView 與 ArrayAdapter：
- ListView 對照 JList 的哪部分？
- ArrayAdapter 對照 Swing 的哪個（ListModel / ListCellRenderer）？
- setAdapter / notifyDataSetChanged 分別做什麼？
給我一支迷你範例（String 陣列 + ArrayAdapter + setOnItemClickListener 用 4 參數 lambda）。
```

> 對照 `02_Day2_Complete.md` 第 6、8 章。先把「資料 ↔ Adapter ↔ 列表」三者的關係搞懂。

---

# 第 6 章加強：ListView 自訂動態清單（實務版）

目標：把「字串清單」升級成「每列含標題/副標題/狀態」的真實型態。

資料流：

1. `TaskItem`：每列資料模型
2. `row_task.xml`：每列 UI 外觀
3. `TaskAdapter`：把 TaskItem 綁到列 View
4. `ArrayList<TaskItem>`：動態增刪改資料
5. `notifyDataSetChanged()`：通知 ListView 刷新

---

# 自訂動態清單｜Step 1：TaskItem.java

```java
public class TaskItem {
    public String title;
    public String subtitle;
    public boolean done;

    public TaskItem(String title, String subtitle, boolean done) {
        this.title = title;
        this.subtitle = subtitle;
        this.done = done;
    }
}
```

> 重點：把「一列需要的欄位」集中管理，避免多個平行陣列。

---

# 自訂動態清單｜Step 2：row_task.xml

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical"
    android:padding="12dp">

    <TextView android:id="@+id/tvTitle" android:layout_width="match_parent"
        android:layout_height="wrap_content" android:textStyle="bold" android:textSize="16sp"/>

    <TextView android:id="@+id/tvSubtitle" android:layout_width="match_parent"
        android:layout_height="wrap_content" android:layout_marginTop="4dp" android:textSize="13sp"/>

    <TextView android:id="@+id/tvStatus" android:layout_width="wrap_content"
        android:layout_height="wrap_content" android:layout_marginTop="6dp" android:textSize="12sp"/>
</LinearLayout>
```

> 重點：一列三欄位，後續可再加 icon、deadline、priority。

---

# 自訂動態清單｜Step 3：TaskAdapter.java（ViewHolder）

```java
public class TaskAdapter extends BaseAdapter {
    private final Context context;
    private final ArrayList<TaskItem> data;

    public TaskAdapter(Context context, ArrayList<TaskItem> data) {
        this.context = context;
        this.data = data;
    }

    @Override public int getCount() { return data.size(); }
    @Override public Object getItem(int position) { return data.get(position); }
    @Override public long getItemId(int position) { return position; }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder;
        if (convertView == null) {
            convertView = LayoutInflater.from(context).inflate(R.layout.row_task, parent, false);
            holder = new ViewHolder();
            holder.tvTitle = convertView.findViewById(R.id.tvTitle);
            holder.tvSubtitle = convertView.findViewById(R.id.tvSubtitle);
            holder.tvStatus = convertView.findViewById(R.id.tvStatus);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }

        TaskItem item = data.get(position);
        holder.tvTitle.setText(item.title);
        holder.tvSubtitle.setText(item.subtitle);
        holder.tvStatus.setText(item.done ? "已完成" : "進行中");
        return convertView;
    }

    static class ViewHolder { TextView tvTitle, tvSubtitle, tvStatus; }
}
```

---

# 自訂動態清單｜Step 4：MainActivity 動態操作

```java
ArrayList<TaskItem> tasks = new ArrayList<>();
tasks.add(new TaskItem("完成 Day2 筆記", "Intent + ListView", false));
tasks.add(new TaskItem("練習回傳結果", "Result API", true));

ListView listView = findViewById(R.id.listView);
TaskAdapter adapter = new TaskAdapter(this, tasks);
listView.setAdapter(adapter);

// 新增
tasks.add(new TaskItem("補完作業", "自訂 Adapter", false));
adapter.notifyDataSetChanged();

// 點擊切換狀態
listView.setOnItemClickListener((p, v, position, id) -> {
    TaskItem item = tasks.get(position);
    item.done = !item.done;
    adapter.notifyDataSetChanged();
});

// 長按刪除
listView.setOnItemLongClickListener((p, v, position, id) -> {
    tasks.remove(position);
    adapter.notifyDataSetChanged();
    return true;
});
```

口訣：改 `tasks` 後一定 `notifyDataSetChanged()`。

---

# 自訂動態清單｜驗收與教學重點

| 操作 | 預期結果 |
|---|---|
| 新增任務 | ListView 立刻出現新列 |
| 點擊列 | `進行中 / 已完成` 可切換 |
| 長按列 | 該列被刪除且畫面即時更新 |

課堂提醒：

- 若資料量變大，下一步遷移 RecyclerView
- 若要重開仍保留資料，Day 3 接 SQLite / Room

---

# 第 7 章　顯示列表：RecyclerView（現代進階做法）

ListView 較舊、效能不佳 → 現代 App 用 **RecyclerView**（彈性大、效能好、官方建議）。

**Step 0：加入 build.gradle 依賴**（加完後按右上角「Sync Now」）

```groovy
// app/build.gradle（Module level）的 dependencies {} 區塊加這行：
implementation 'androidx.recyclerview:recyclerview:1.3.2'
```

**6 個步驟**：

| 步驟 | 動作 | 重點 |
|---|---|---|
| 1 | XML 加入 `<RecyclerView>` | 只是容器，不排列 |
| 2 | 建立 `row_item.xml`（New > Layout Resource File） | 每列外觀 |
| 3 | 建立 `ViewHolder` class | 記住每列 View 參考 |
| 4 | 建立 `Adapter`（繼承 `RecyclerView.Adapter`） | 資料 → View |
| 5 | `setLayoutManager` + `setAdapter` | **最易忘 Step 5！** |
| 6 | （選配）`ItemTouchHelper` | 滑動刪除 |

> ⚠️ 最常見錯誤：**忘記呼叫 `setLayoutManager`** → RecyclerView 顯示空白（不崩潰）。

---

# AI 動手做｜提示 6：RecyclerView 六步驟（指南 §7）

```
我是 Android Java 初學者，請用 Step by Step 教我 RecyclerView 的 6 個步驟：
1. XML 放 <RecyclerView>
2. 建立單列佈局 row_item.xml
3. 建立 ViewHolder
4. 建立 Adapter（繼承 RecyclerView.Adapter）
5. 主程式 setLayoutManager(new LinearLayoutManager(this)) + setAdapter
6. （選配）ItemTouchHelper 滑動刪除

請解釋 onCreateViewHolder / onBindViewHolder / getItemCount 各自何時被呼叫，
並說明為何 onBindViewHolder 是「方法覆寫」不能用 lambda。
用一支「顯示水果清單」的最小可編譯範例示範（記得要加 recyclerview 依賴）。
```

> Day 2 先熟概念；完整 RecyclerView 實作在第 12 章顏色選擇器、Day 3 記帳 App。

---

# ⭐ 第 7 章　範例實作：RecyclerView 水果清單（基礎）

目標：完成第一支可執行 RecyclerView。

1. 建立 `activity_main.xml`（放 RecyclerView）
2. 建立 `row_item.xml`（每列一個 TextView）
3. 建立 `FruitAdapter`（含 ViewHolder）
4. 在 `MainActivity` 設 `setLayoutManager` + `setAdapter`

> 套件建議：`com.example.recyclerbasic`。

---

# recyclerbasic｜activity_main.xml + row_item.xml

```xml
<!-- activity_main.xml -->
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:padding="16dp">
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:text="RecyclerView 入門" android:textSize="22sp" android:textStyle="bold"/>
    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/recyclerView" android:layout_width="match_parent"
        android:layout_height="0dp" android:layout_weight="1"
        android:layout_marginTop="12dp"/>
</LinearLayout>
```

```xml
<!-- row_item.xml -->
<TextView xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/tvName" android:layout_width="match_parent"
    android:layout_height="wrap_content" android:padding="14dp" android:textSize="18sp"/>
```

---

# recyclerbasic｜FruitAdapter.java（核心）

```java
public class FruitAdapter extends RecyclerView.Adapter<FruitAdapter.FruitViewHolder> {
    private final List<String> data;
    public FruitAdapter(List<String> data) { this.data = data; }

    @NonNull @Override
    public FruitViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_item, parent, false);
        return new FruitViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull FruitViewHolder holder, int position) {
        String name = data.get(position);
        holder.tvName.setText(name);
        holder.itemView.setOnClickListener(v ->
                Toast.makeText(v.getContext(), "你點了：" + name, Toast.LENGTH_SHORT).show());
    }

    @Override public int getItemCount() { return data.size(); }

    static class FruitViewHolder extends RecyclerView.ViewHolder {
        TextView tvName;
        FruitViewHolder(@NonNull View itemView) {
            super(itemView);
            tvName = itemView.findViewById(R.id.tvName);
        }
    }
}
```

---

# recyclerbasic｜MainActivity.java + 驗收

```java
RecyclerView recyclerView = findViewById(R.id.recyclerView);
ArrayList<String> fruits = new ArrayList<>();
fruits.add("蘋果"); fruits.add("香蕉"); fruits.add("柳橙"); fruits.add("葡萄");

recyclerView.setLayoutManager(new LinearLayoutManager(this));
recyclerView.setAdapter(new FruitAdapter(fruits));
```

| 操作 | 預期結果 |
|---|---|
| 啟動 App | 顯示 4 筆水果 |
| 點擊任一列 | 顯示 Toast「你點了：水果名」 |
| 忘記 `setLayoutManager` | 列表空白（最常見初學錯誤） |

---

# 第 8 章　資料容器：ArrayList（取代陣列）

```java
ArrayList<String> todoList = new ArrayList<>();
todoList.add("寫 Day2 筆記");
todoList.add("練習 Intent");

// 改動資料後 → 通知畫面重繪
adapter.notifyDataSetChanged();
```

- `ArrayList` 可動態增刪、方便與 `ArrayAdapter` 搭配，是清單 App 的主角
- **記憶口訣：「改容器 → `notifyDataSetChanged()`」**——不管新增或刪除，最後都要呼叫，畫面才會更新
- ⚡ 對照 Swing `DefaultListModel.add()` 後自動更新；Android 要**手動**呼叫

---

# ⭐ 第 8 章　完整範例：可增刪的待辦清單（arraydemo）

套件 `com.example.arraydemo`，**2 支檔案**。

**activity_main.xml**（水平輸入列 + ListView）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:padding="8dp">
    <!-- 水平列：EditText 撐滿剩餘寬度，按鈕靠右 -->
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="horizontal">
        <EditText android:id="@+id/etInput"
            android:layout_width="0dp" android:layout_height="wrap_content"
            android:layout_weight="1" android:hint="輸入待辦事項"/>
        <Button android:id="@+id/btnAdd" android:layout_width="wrap_content"
            android:layout_height="wrap_content" android:text="新增"/>
    </LinearLayout>
    <ListView android:id="@+id/listView"
        android:layout_width="match_parent" android:layout_height="0dp"
        android:layout_weight="1"/>
</LinearLayout>
```

---

# ⭐ 第 8 章　完整範例：arraydemo MainActivity

**MainActivity.java**（含 import）：

```java
package com.example.arraydemo;
import android.os.Bundle; import android.widget.*;
import androidx.appcompat.app.AlertDialog; import androidx.appcompat.app.AppCompatActivity;
import java.util.ArrayList;
public class MainActivity extends AppCompatActivity {
    final ArrayList<String> data = new ArrayList<>();
    ArrayAdapter<String> adapter;
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState); setContentView(R.layout.activity_main);
        EditText etInput  = findViewById(R.id.etInput);
        Button btnAdd     = findViewById(R.id.btnAdd);
        ListView listView = findViewById(R.id.listView);
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, data);
        listView.setAdapter(adapter);
        btnAdd.setOnClickListener(v -> {
            String text = etInput.getText().toString().trim();
            if (text.isEmpty()) { Toast.makeText(this,"請先輸入文字",Toast.LENGTH_SHORT).show(); return; }
            data.add(text); adapter.notifyDataSetChanged(); etInput.setText("");
        });
        listView.setOnItemLongClickListener((parent, view, position, id) -> {
            new AlertDialog.Builder(this).setTitle("確認刪除")
                .setMessage("確定要刪除「" + data.get(position) + "」嗎？")
                .setPositiveButton("確定",(d,w)->{data.remove(position);adapter.notifyDataSetChanged();})
                .setNegativeButton("取消",null).show();
            return true;
        });
    }
}
```

---

# ⭐ 第 8 章　範例實作：ArrayList 三步驟（基礎）

```java
ArrayList<String> data = new ArrayList<>();
data.add("第一筆");
data.add("第二筆");

ArrayAdapter<String> adapter = new ArrayAdapter<>(
        this, android.R.layout.simple_list_item_1, data);
listView.setAdapter(adapter);

btnAdd.setOnClickListener(v -> {
    data.add("新資料");
    adapter.notifyDataSetChanged();
});

listView.setOnItemLongClickListener((parent, view, position, id) -> {
    data.remove(position);
    adapter.notifyDataSetChanged();
    return true;
});
```

重點口訣：改 `ArrayList` 後，必須 `notifyDataSetChanged()`。

---

# 第 9 章　Dialog：AlertDialog（取代 JOptionPane 彈窗）

```java
new AlertDialog.Builder(this)
        .setTitle("確認")
        .setMessage("確定要刪除嗎？")
        .setPositiveButton("確定", (dialog, which) -> {
            // 按確定要做的事
        })
        .setNegativeButton("取消", null)
        .show();
```

- **流式（Builder）寫法**：一行串一行「組裝」，最後 `.show()` 才彈出
- `setPositiveButton("確定", (dialog, which) -> {...})`：第二參數是 `DialogInterface.OnClickListener`（**單一方法介面 → lambda**）
- `setNegativeButton("取消", null)`：`null` = 按下直接關閉、不做任何事
- ⚡ ≈ Swing 的 `JOptionPane`

---

# AI 動手做｜提示 7：學習 AlertDialog（指南 §8）

```
請用 JFrame 的 JOptionPane 對照，教我 Android 的 AlertDialog：
- Builder 流式寫法（setTitle / setMessage / setPositiveButton / setNegativeButton / show）
- setPositiveButton 的回呼為什麼能用 lambda（DialogInterface.OnClickListener 是單一方法介面）
- setNegativeButton("取消", null) 的 null 代表甚麼
給我一個「確認刪除」的迷你範例。
```

> 現在你已備齊所有元件：跳轉、傳值、回傳、列表、彈窗。接著是三支整合範例。

---

# 第 10 章　完整範例一：待辦事項 Todo App（todoapp）

> 套件 `com.example.todoapp`，**2 支檔案**。整合「ArrayList + ArrayAdapter + AlertDialog」

**功能需求**：
- `EditText` + `Button` 新增待辦；`ListView` 顯示
- **點擊待辦 → `AlertDialog` 確認後刪除**；空輸入 → `Toast` 提示
- 資料存記憶體（重開 App 會消失，Day 3 用 Room 解決）

**activity_main.xml**：
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="match_parent"
    android:orientation="vertical" android:padding="8dp">
    <TextView android:layout_width="match_parent" android:layout_height="wrap_content"
        android:text="待辦事項" android:textSize="22sp" android:padding="12dp"
        android:background="#E3F2FD" android:layout_marginBottom="8dp"/>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content"
        android:orientation="horizontal" android:layout_marginBottom="8dp">
        <EditText android:id="@+id/etTodo" android:layout_width="0dp"
            android:layout_height="wrap_content" android:layout_weight="1"
            android:hint="輸入待辦事項…"/>
        <Button android:id="@+id/btnAdd" android:layout_width="wrap_content"
            android:layout_height="wrap_content" android:text="新增"/>
    </LinearLayout>
    <ListView android:id="@+id/listView" android:layout_width="match_parent"
        android:layout_height="0dp" android:layout_weight="1"/>
</LinearLayout>
```

---

# ⭐ todoapp｜MainActivity.java（完整含 import）

```java
package com.example.todoapp;
import android.os.Bundle;
import android.widget.ArrayAdapter; import android.widget.Button;
import android.widget.EditText; import android.widget.ListView; import android.widget.Toast;
import androidx.appcompat.app.AlertDialog; import androidx.appcompat.app.AppCompatActivity;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private final ArrayList<String> todoList = new ArrayList<>();
    private ArrayAdapter<String> adapter;

    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState); setContentView(R.layout.activity_main);
        EditText etTodo  = findViewById(R.id.etTodo);
        Button btnAdd    = findViewById(R.id.btnAdd);
        ListView listView= findViewById(R.id.listView);
        // ★ 把 todoList 交給 Adapter 管理（同一份引用）
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, todoList);
        listView.setAdapter(adapter);

        btnAdd.setOnClickListener(v -> {
            String text = etTodo.getText().toString().trim();
            if (text.isEmpty()) {
                Toast.makeText(this, "請先輸入文字", Toast.LENGTH_SHORT).show(); return;
            }
            todoList.add(text);
            adapter.notifyDataSetChanged();   // ★ 告訴 Adapter 資料變了，重新繪製
            etTodo.setText("");
        });

        listView.setOnItemClickListener((parent, view, position, id) ->
            new AlertDialog.Builder(this).setTitle("確認刪除")
                .setMessage("確定要刪除「" + todoList.get(position) + "」嗎？")
                .setPositiveButton("確定", (dialog, which) -> {
                    todoList.remove(position); adapter.notifyDataSetChanged();
                })
                .setNegativeButton("取消", null).show());
    }
}
```

---

# ⭐ todoapp｜驗收重點

| 測試 | 預期 |
|---|---|
| 輸入「買牛奶」→ 新增 | 清單出現「買牛奶」 |
| 輸入空白 → 新增 | Toast「請先輸入文字」 |
| 點擊「買牛奶」 | 跳出確認 AlertDialog |
| 確認刪除 | 清單移除；重開 App 資料**消失**（Day 3 解決） |

---

# AI 動手做｜9-1 待辦事項 Todo App 提示（指南 §9-1）

```
我學到「待辦事項 Todo App」，套件 com.example.todoapp，請幫我產出 2 支檔案：

1. activity_main.xml：上方水平列（EditText etTodo 用 0dp+weight=1 + 按鈕 btnAdd「新增」），下方 ListView listView
2. MainActivity.java：
   - private final ArrayList<String> todoList；adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, todoList)
   - 新增按鈕：檢查空白→todoList.add→adapter.notifyDataSetChanged→清空輸入框（lambda）
   - 點擊列：setOnItemClickListener 4 參數 lambda，用 AlertDialog 確認刪除，setPositiveButton 裡 todoList.remove + notifyDataSetChanged
請用 lambda。
```

**練習擴充**：`請幫 Todo App 加上「長按列刪除」（setOnItemLongClickListener）替代點擊刪除。`

**驗證**：新增空白會 Toast、新增會出現、點列可刪、**重開 App 資料會消失**（Day 3 解決）。

---

# 第 11 章　完整範例二：商品編輯傳值（shopapp）

> 套件 `com.example.shopapp`，**4 支檔案**。練習「A 開 B、B 回傳、A 顯示」**雙向閉環**。

**閉環流程**：`A putExtra 帶初值` → `B getStringExtra 填欄位` → `B 改完 → setResult + finish` → `A resultLauncher 收到 → 更新顯示`

**🔧 建立步驟**：① New Project → `com.example.shopapp` ② 右鍵套件 → `New > Activity` → 命名 `EditActivity`

**MainActivity.java**（A 端，含 import）：
```java
package com.example.shopapp;
import android.content.Intent; import android.os.Bundle;
import android.widget.Button; import android.widget.TextView;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;
public class MainActivity extends AppCompatActivity {
    String goodsName = "手機", goodsPrice = "9999";
    TextView tvInfo;
    // ★ 欄位層宣告（不能在 onCreate 裡建立，會拋 IllegalStateException）
    ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(
        new ActivityResultContracts.StartActivityForResult(),
        result -> {
            if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                goodsName  = result.getData().getStringExtra("name");
                goodsPrice = result.getData().getStringExtra("price");
                tvInfo.setText("商品：" + goodsName + " / 價格：" + goodsPrice);
            }
        });
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState); setContentView(R.layout.activity_main);
        tvInfo = findViewById(R.id.tvInfo);
        Button btnEdit = findViewById(R.id.btnEdit);
        btnEdit.setOnClickListener(v -> {
            Intent intent = new Intent(this, EditActivity.class);
            intent.putExtra("name", goodsName); intent.putExtra("price", goodsPrice);
            resultLauncher.launch(intent);
        });
    }
}
```

---

# ⭐ shopapp｜EditActivity.java + 佈局（B 端）

**activity_edit.xml**（B 端輸入）：
```xml
<LinearLayout ... android:orientation="vertical" android:gravity="center" android:padding="24dp">
    <EditText android:id="@+id/etName" android:layout_width="match_parent"
        android:layout_height="wrap_content" android:hint="商品名稱" android:layout_marginBottom="12dp"/>
    <EditText android:id="@+id/etPrice" android:layout_width="match_parent"
        android:layout_height="wrap_content" android:hint="價格" android:inputType="number"
        android:layout_marginBottom="20dp"/>
    <Button android:id="@+id/btnSave" android:layout_width="wrap_content"
        android:layout_height="wrap_content" android:text="儲存並返回"/>
</LinearLayout>
```

**EditActivity.java**（B 端邏輯，含 import）：
```java
package com.example.shopapp;
import android.content.Intent; import android.os.Bundle;
import android.widget.Button; import android.widget.EditText; import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
public class EditActivity extends AppCompatActivity {
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState); setContentView(R.layout.activity_edit);
        EditText etName = findViewById(R.id.etName); EditText etPrice = findViewById(R.id.etPrice);
        Button btnSave  = findViewById(R.id.btnSave);
        String initName = getIntent().getStringExtra("name");
        String initPrice= getIntent().getStringExtra("price");
        if (initName  != null) etName.setText(initName);   // ★ 用 A 的初值填充
        if (initPrice != null) etPrice.setText(initPrice);
        btnSave.setOnClickListener(v -> {
            String name  = etName.getText().toString().trim();
            String price = etPrice.getText().toString().trim();
            if (name.isEmpty() || price.isEmpty()) {
                Toast.makeText(this,"請填寫所有欄位",Toast.LENGTH_SHORT).show(); return;
            }
            Intent data = new Intent(); data.putExtra("name", name); data.putExtra("price", price);
            setResult(RESULT_OK, data); finish();   // 關閉 B → 觸發 A 的 resultLauncher
        });
    }
}
```

| 測試 | 預期 |
|---|---|
| 按「編輯商品」→ 改「平板/12900」→ 儲存 | A 顯示「商品：平板 / 價格：12900」 |
| B 端清空欄位 → 儲存 | Toast「請填寫所有欄位」，不關閉 |

---

# AI 動手做｜9-2 商品編輯傳值提示（指南 §9-2）

```
我學到「商品編輯傳值」，套件 com.example.shopapp，請幫我產出 4 支檔案：

1. activity_main.xml：TextView tvInfo「商品：手機 / 價格：9999」、按鈕 btnEdit「編輯商品」
2. MainActivity.java：
   - 欄位 goodsName="手機"、goodsPrice="9999"
   - 用新版 Result API：ActivityResultLauncher resultLauncher 接收 EditActivity 回傳的 name、price，更新 tvInfo
   - openEdit()：intent.putExtra("name", goodsName)、putExtra("price", goodsPrice)，resultLauncher.launch
3. activity_edit.xml：EditText etName(商品名稱)、etPrice(inputType="number")、按鈕 btnSave「儲存並返回」
4. EditActivity.java：
   - getIntent().getStringExtra("name"/"price") 初始化欄位（若非 null）
   - 按儲存：檢查空白→new Intent() 空袋 putExtra 回傳→setResult(RESULT_OK, data)→finish()
請用 lambda，並說明「A→B 帶初值、B→A 回修改」的完整閉環。
```

**驗證**：A 顯示「手機/9999」→ 編輯改「平板/12900」→ A 更新。

---

# 第 12 章　完整範例三：顏色選擇器（RecyclerView + 回傳）

> 套件 `com.example.colorpick`，**5 支 Java + 3 個 layout**。需加 recyclerview 依賴。

**🔧 加依賴**：開啟 `app/build.gradle` → `dependencies {}` 加入 → 點「Sync Now」：
```groovy
implementation 'androidx.recyclerview:recyclerview:1.3.2'
```

**ColorData.java**（資料模型）：
```java
package com.example.colorpick;
public class ColorData {
    public final String name, hex;
    public ColorData(String name, String hex) { this.name = name; this.hex = hex; }
}
```

**row_color.xml**（單列樣式，New > Layout Resource File）：
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent" android:layout_height="wrap_content"
    android:orientation="horizontal" android:padding="16dp" android:gravity="center_vertical">
    <View android:id="@+id/swatch" android:layout_width="40dp" android:layout_height="40dp"
        android:layout_marginEnd="16dp"/>
    <TextView android:id="@+id/tvColorName"
        android:layout_width="wrap_content" android:layout_height="wrap_content"
        android:textSize="18sp"/>
</LinearLayout>
```

---

# ⭐ colorpick｜ColorAdapter.java（完整）

```java
package com.example.colorpick;
import android.graphics.Color; import android.view.*;
import android.widget.TextView;
import androidx.annotation.NonNull; import androidx.recyclerview.widget.RecyclerView;
import java.util.List;

public class ColorAdapter extends RecyclerView.Adapter<ColorAdapter.ColorViewHolder> {
    // ★ 自訂函式型介面（單一方法 → 可用 lambda 傳入）
    public interface OnColorClick { void onColorClick(ColorData color); }

    private final List<ColorData> colors;
    private final OnColorClick listener;
    public ColorAdapter(List<ColorData> colors, OnColorClick listener) {
        this.colors = colors; this.listener = listener;
    }
    @Override
    public ColorViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.row_color, parent, false);
        return new ColorViewHolder(v);
    }
    @Override
    public void onBindViewHolder(@NonNull ColorViewHolder holder, int position) {
        ColorData c = colors.get(position);
        holder.tvColorName.setText(c.name + " (" + c.hex + ")");
        holder.swatch.setBackgroundColor(Color.parseColor(c.hex));
        holder.itemView.setOnClickListener(v -> listener.onColorClick(c));
    }
    @Override public int getItemCount() { return colors.size(); }

    static class ColorViewHolder extends RecyclerView.ViewHolder {
        View swatch; TextView tvColorName;
        ColorViewHolder(@NonNull View v) {
            super(v);
            swatch = v.findViewById(R.id.swatch);
            tvColorName = v.findViewById(R.id.tvColorName);
        }
    }
}
```

---

# ⭐ colorpick｜ColorListActivity.java + MainActivity.java

**ColorListActivity.java**（B 端，含 import）：
```java
package com.example.colorpick;
import android.content.Intent; import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager; import androidx.recyclerview.widget.RecyclerView;
import java.util.Arrays; import java.util.List;
public class ColorListActivity extends AppCompatActivity {
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState); setContentView(R.layout.activity_color_list);
        List<ColorData> colors = Arrays.asList(
            new ColorData("紅色","#FF0000"), new ColorData("橙色","#FF8C00"),
            new ColorData("黃色","#FFD700"), new ColorData("綠色","#228B22"),
            new ColorData("藍色","#1E90FF"), new ColorData("紫色","#8A2BE2"));
        RecyclerView rv = findViewById(R.id.recyclerView);
        rv.setLayoutManager(new LinearLayoutManager(this));   // ★ 不能忘！
        rv.setAdapter(new ColorAdapter(colors, color -> {
            Intent data = new Intent();
            data.putExtra("name", color.name); data.putExtra("hex", color.hex);
            setResult(RESULT_OK, data); finish();
        }));
    }
}
```

**MainActivity.java** A 端：欄位宣告 `colorLauncher = registerForActivityResult(...)`，收到回傳後 `Color.parseColor(hex)` 設色塊背景色。

| 測試 | 預期 |
|---|---|
| 啟動 → 灰塊「尚未選擇」 | ✅ |
| 選「紅色」→ 回 A | 色塊變紅，顯示「紅色 (#FF0000)」 |

---

# AI 動手做｜9-3 顏色選擇器提示（指南 §9-3）

```
我學到「顏色選擇器」，套件 com.example.colorpick，需要 recyclerview 依賴，請幫我產出 5 支 Java + 3 個 layout：

1. build.gradle 依賴：androidx.recyclerview:recyclerview
2. activity_main.xml：標籤「目前選色：」、View colorBlock(80dp 背景 #888888)、TextView tvName「尚未選擇」、按鈕 btnPick「選擇顏色」
3. row_color.xml：水平 LinearLayout，View swatch(40dp) + TextView tvColorName
4. ColorData.java：public final String name / hex，建構子填值
5. ColorAdapter.java：繼承 RecyclerView.Adapter
   - 自訂 interface OnColorClick { void onColorClick(ColorData color); }（單一方法→functional interface）
   - onCreateViewHolder inflate row_color、onBindViewHolder setText + setBackgroundColor + itemView.setOnClickListener(lambda)、getItemCount
   - 內部 static ColorViewHolder
6. activity_color_list.xml：只放一個 RecyclerView
7. MainActivity.java：新版 Result API 接收 name/hex 更新色塊與文字
8. ColorListActivity.java：準備 6 個 ColorData、setLayoutManager、new ColorAdapter(colors, color -> {...}) lambda 回傳 setResult + finish
```

**驗證**：A 灰塊「尚未選擇」→ 選「紅色」→ 回 A 色塊變紅、文字「紅色 (#FF0000)」。

---

# AI 動手做｜遇到錯誤，讓 AI 幫你除錯（指南 §10）

| 常見錯誤 | 自我檢查 | 你可以這樣問 AI |
|---|---|---|
| 跳到 B 黑屏 / 崩潰 | 確認 Manifest 有 `<activity android:name=".SecondActivity"/>` | 「SecondActivity 崩潰，Logcat 錯誤是 [貼上]，幫我查」 |
| `onActivityResult` 編譯錯 | 確認是 `@Override` 而非 lambda | 「onActivityResult 報錯，我誤用 lambda，請改回 @Override 寫法」 |
| `getIntExtra` 拿到 0 | 確認 A/B 兩端 key 名稱完全相同 | 「B 端 getIntExtra 拿到預設值 0，A 明明有 putExtra，key 有問題嗎？」 |
| RecyclerView 空白 | 有沒有呼叫 `setLayoutManager`？ | 「RecyclerView 空白不顯示，getItemCount 回傳 5，哪裡錯了？」 |
| `ActivityResultLauncher` 報錯 | 是否在 `onCreate` 裡建立？ | 「registerForActivityResult 報 IllegalStateException，我是在 onCreate 裡建的，怎麼改？」 |
| `Uri cannot be resolved` | 有沒有 `import android.net.Uri;` | 「Uri.parse 編譯錯誤 cannot be resolved，需要什麼 import？」 |
| RecyclerView 依賴找不到 | `build.gradle` 有沒有加 + Sync Now | 「RecyclerView class 找不到，build.gradle 要加什麼 implementation？」 |

> 貼上**完整 Logcat 錯誤**與**你的程式碼**，AI 才能精準除錯。

---

# 第 13 章　自我測驗（先寫再對答案）

1. `startActivity(intent)` 和 `startActivityForResult(intent, code)` 差別在哪？
2. `getIntExtra("age", 0)` 的第二個參數 `0` 是什麼意思？
3. `onActivityResult` 的 `requestCode` 與 `resultCode` 分別代表什麼？
4. Adapter 在 ListView 中扮演什麼角色？對照 Swing 是哪個元件？
5. 為什麼用 RecyclerView 取代 ListView？RecyclerView 哪個步驟最容易忘記？
6. `onActivityResult(...)` 為什麼「不能」寫成 lambda？那 `setOnClickListener(v -> ...)` 為什麼可以？
7. `ActivityResultLauncher` 為何不能在 `onCreate()` 內部建立？
8. 改了 `ArrayList` 資料後，不呼叫 `notifyDataSetChanged()` 會怎樣？
9. 「選圖」與「選檔案」分別該用哪個 API？什麼情況該選用哪一個？
10. 使用 `FileProvider` 拍照時，`AndroidManifest.xml` 的 `authorities` 與程式碼哪一處必須一致？
11. 用 `DatePickerDialog` 取得的月份為何要 `+1`？年份需要嗎？
12. 用 `Spinner` 顯示預設選項時，`setSelection()` 該放在 `setAdapter()` 之前還是之後？為什麼？

---

# 測驗解答

| # | 解答 |
|---|---|
| 1 | `startActivity`：fire-and-forget 不等結果；`startActivityForResult`：等待回傳（新版用 `registerForActivityResult`） |
| 2 | **預設值**——找不到該 key 就回傳 `0`，避免 null 崩潰 |
| 3 | `requestCode`：發送端自訂辨識碼（如 1001）；`resultCode`：B 端 `setResult(RESULT_OK,...)` 的狀態 |
| 4 | 資料與 UI 的橋樑——把資料轉成列 View（≈ Swing `ListModel` + `ListCellRenderer`） |
| 5 | ViewHolder 回收 + LayoutManager，效能更好；**最易忘：`setLayoutManager()`**（忘了列表顯示空白但不崩潰） |
| 6 | `onActivityResult` 是 Activity **已定義的方法**，只能 `@Override`；`OnClickListener` 是**單一抽象方法介面**，可用 lambda |
| 7 | 必須在 Activity 進入 `RESUMED` 前完成註冊（生命週期限制）；在 `onCreate` 裡建立（Activity 已 `RESUMED`）會拋 `IllegalStateException` |
| 8 | 資料已改但 UI **不更新**（顯示舊資料），不崩潰但視覺 bug |
| 9 | 選圖→`PickVisualMedia`（只挑照片/影片、免權限）；選檔→`OpenDocument`（任意文件、可指定 MIME，需要時 `takePersistableUriPermission`） |
| 10 | 必須與 `FileProvider.getUriForFile(context, authorities, file)` 的第二個參數**完全一致**（慣例 `<套件名>.fileprovider`），否則拋 `IllegalArgumentException` |
| 11 | `Calendar.MONTH` 是 **0 起始**（0=一月、11=十二月），顯示要 `+1`；年份是正常西元年，**免加** |
| 12 | 放在 `setAdapter()` **之後**——`Spinner` 必須先有 Adapter（資料）才能定位到指定索引 |

> 判斷準則：**要覆寫既有方法 → 只能寫方法；要實作單一方法的介面 → 可用 lambda**。

---

# AI 動手做｜提示寫作重點回顧 + 複習流程（指南 §11）

| 重點 | 做法 |
|---|---|
| 多 Activity 要講清楚 | 每個畫面的 XML 和 Java 分開描述、指定檔案名 |
| 套件名要指定 | `com.example.resultdemo` 等，避免 `<activity>` 註冊對不上 |
| 指定新版 / 舊版 | 明確說要用 `registerForActivityResult` 還是 `onActivityResult` |
| lambda 界線 | 明確要求「只有單一方法介面用 lambda，覆寫方法用 @Override」 |
| 提醒依賴 | 用到 RecyclerView 要提醒 AI 附上 build.gradle 依賴 |

**複習流程**：自己實作 → 用提示讓 AI 產生同一支 → 比對差異（新舊/API、lambda vs anonymous）→ 故意灌錯考 AI → 用擴充提示加功能。

> 下一篇：Day 3（Room / SQLite / SharedPreferences 持久化 + 記帳 App 總成果）。

---

# 本日小結

今天你完成了：

- **`Intent` 啟動新 Activity**（含完整 XML + Java + import）
- **`putExtra`/`getExtra` 傳值**（senddata 4 支完整檔案）
- **回傳結果**（新版 `registerForActivityResult` + 舊 `onActivityResult` 對照，含 import）
- **系統功能 Intent**（撥號、開網頁，記得 `import android.net.Uri`）
- **第 5.5 章 常用系統互動畫面**（日期/時間選擇、`Spinner`、單選/多選、`PickVisualMedia` / `OpenDocument` / `TakePicture` + `FileProvider`）
- **`ListView` + `ArrayAdapter`**（listdemo 完整含 import）
- **`RecyclerView`**（build.gradle 依賴 + 6 步驟 + 完整 Adapter + 最易忘 `setLayoutManager`）
- **`ArrayList`**（動態容器；改資料後呼叫 `notifyDataSetChanged()`）
- **`AlertDialog`**（Builder 流式 + `setPositiveButton` lambda 原理）
- **4 支小範例**（jumpdemo / senddata / resultdemo / sysints，每支含完整 XML + Java + import）
- **3 支整合範例**（todoapp / shopapp / colorpick，每支含所有檔案的完整可貼代碼）

**本日重點操作清單**：
1. 新增 Activity → 右鍵套件 → `New > Activity > Empty Views Activity`
2. 宣告 `ActivityResultLauncher` → **欄位層**，不在 `onCreate` 裡
3. 改 `ArrayList` 後 → 一定呼叫 `notifyDataSetChanged()`
4. RecyclerView → 別忘 `setLayoutManager()` + `build.gradle` 依賴

**明天（Day 3）**：用 SharedPreferences、SQLite/Room 把資料「永久存起來」，完成記帳 App。

> 延伸閱讀：`Appendix_B_Lambda.md`（Lambda 對照）、`Appendix_G_Lifecycle.md`（生命週期）、`Appendix_H_Swing_vs_Android.md`。
