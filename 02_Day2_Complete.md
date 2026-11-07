# Day 2 合併版 — 頁面跳轉與列表：多畫面 App

> 本檔是 **Day 2 一天的完整教材**，將原分散的「教學 + 範例 + 測驗」整合為一個可一次讀完的文件。
> 對象：具備 Java 程式開發經驗，熟悉 JFrame 視窗程式開發（已完成 Day 1）。
> 時間：約 6–8 小時。
> 與 JFrame 的對照會用 ⚡ 標記。

---

# 第 1 章　認識 Activity（多個畫面）

一個 Activity = 一個畫面。要建第二個畫面：

1. 在套件資料夾按右鍵 → **New → Activity → Empty Views Activity**
2. 命名 `SecondActivity` → 會自動產生 `SecondActivity.java` + `activity_second.xml`

> ⚡ **對照**：`SecondActivity` 就等於你另外設計的第二個 `JFrame`。

### 1.1 AndroidManifest.xml 必須註冊 Activity

```xml
<activity android:name=".SecondActivity" />
```

**逐行說明**：
- `<activity>`：宣告「這個 App 有一個畫面（Activity）」的標籤。
- `android:name=".SecondActivity"`：指出該畫面的 class 名稱。開頭的 `.` 表示「目前套件底下的」，等同「套件名 + `.SecondActivity`」。`AndroidManifest.xml` 是 App 的「身分證」，所有畫面都要在這登錄一次，系統才知道「有哪幾個畫面可跳」。

> Android Studio 建立 Activity 時會**自動註冊**到 `AndroidManifest.xml`，但你自己手動建 class 時別忘了註冊，否則會跳錯。
> 相關排解見 `Appendix_C_Troubleshooting.md`。

---

# 第 2 章　Intent：啟動新的 Activity

```java
// 在 MainActivity.java 中
Button btnGo = findViewById(R.id.btnGo);
btnGo.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this, SecondActivity.class);
    startActivity(intent);   // 啟動並跳轉
});
```

**逐行說明**：
- `Button btnGo = findViewById(R.id.btnGo);`：透過 id 找到 XML 裡那顆按鈕，指定給 `btnGo`。`R.id.btnGo` 是 Android 為你自動產生的資源代號。
- `btnGo.setOnClickListener(v -> {...});`：為按鈕掛上「點擊監聽」。lambda 的 `v` 是事件物件（這裡用不到，只是符合介面簽名）。
- `Intent intent = new Intent(MainActivity.this, SecondActivity.class);`：**建立跳轉意圖**。括號裡第一個參數指「從哪裡出發」（MainActivity），第二個參數指「要到哪去」（SecondActivity 的 class）。
- `startActivity(intent);`：把這個意圖交給系統，系統就會啟動 `SecondActivity`，畫面因此切換。

> ⚡ 重點：`Intent` 是 Android「移動畫面」的唯一鑰匙。JFrame 用 `new SecondFrame().setVisible(true)` 直接建物件；Android 則是「描述要去哪裡」的 `Intent` 交給系統執行。

### 2.1 為什麼用 `MainActivity.this`？

因為在匿名/button 回呼中，`this` 可能不是 Activity。用 `MainActivity.this` 明確指定。

> 說明：lambda／anonymous class 裡面的 `this` 指的是「匿名類別自己」而不是你的 Activity。要取得外面的 Activity 當成 `Intent` 的出發點，必須用「類別名稱.this」這種形式明確指向 `MainActivity` 這個實體。

> ⚡ **對照**：JFrame 是 `new SecondFrame().setVisible(true)`；Android 是 `startActivity(intent)`。

**Lambda 對照**：上面 `v -> { ... }` 的完整面貌（如果你還不習慣 lambda）是：

```java
// 等價的傳統寫法
btnGo.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        Intent intent = new Intent(MainActivity.this, SecondActivity.class);
        startActivity(intent);
    }
});
```

**逐段說明**：
- `new View.OnClickListener() { ... }`：建立一個「匿名類別」實作 `OnClickListener` 介面，這是一般 Java 的老寫法。
- `@Override public void onClick(View v)`：覆寫介面唯一的抽象方法 `onClick`，點擊時執行。
- 內部兩行與 lambda 版本完全相同。
- 差別只在語法糖：**lambda 只是把這整段「匿名類別 + 唯一方法」精簡成 `(參數) -> { 方法體 }`**，兩者可任意互換、行為一模一樣。

兩者完全等價。lambda 只是把「單一方法的匿名類別」縮寫：`(參數) -> { 方法體 }`，參數型別自動推斷。

---

## ⭐ 第 2 章　完整可直接執行範例：兩頁面跳轉 App

> 目的：把上面「開新畫面」的觀念做成一支**可直接執行、立刻看到跳轉結果**的小 App。
> 套件名：`com.example.jumpdemo`。共 4 支檔案：兩份 XML + 兩支 Java。

**Step 1 建立專案**：**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.jumpdemo`，名稱 `jumpdemo`。

**Step 2 新增第二個畫面**：右鍵套件 → **New → Activity → Empty Views Activity**，名稱 `SecondActivity`。
（精靈會自動處理 `AndroidManifest.xml` 的註冊與 `activity_second.xml`。）

**Step 3 畫面 A 佈局 `activity_main.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="24dp">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="這是第一個畫面"
        android:textSize="22sp"
        android:textStyle="bold" />

    <Button
        android:id="@+id/btnGo"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="點我跳到第二畫面" />

</LinearLayout>
```

**佈局說明（`activity_main.xml` 是畫面 A 的長相）**：
- `<LinearLayout ...>`：根容器，把所有子元件**由上往下垂直排列**（`android:orientation="vertical"`）。
  - `android:layout_width/height="match_parent"`：填滿父容器（整面銀幕）。
  - `android:gravity="center"`：子元件在容器內**居中**。
  - `android:padding="24dp"`：內容距離邊緣留 24dp，避免貼邊。
- `<TextView>`：顯示標題文字「這是第一個畫面」，`22sp` 是字體大小、`bold` 是粗體。
- `<Button android:id="@+id/btnGo"...>`：畫面 A 唯一的按鈕，指定 id 為 `btnGo`（`@+id/` 表示「新增並命名一個 id」），這樣 Java 才能用 `R.id.btnGo` 找到它。

**Step 4 畫面 A 程式 `MainActivity.java`**：

```java
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
            // 邀請 SecondActivity 登場
            Intent intent = new Intent(MainActivity.this, SecondActivity.class);
            startActivity(intent);   // 啟動並跳轉（不帶任何資料）
        });
    }
}
```

**程式說明（`MainActivity.java` 是畫面 A 的邏輯）**：
- `package com.example.jumpdemo;`：宣告這個 class 所屬的套件。
- `import ...`：匯入要用到的類別（`Intent` 準備跳轉、`Bundle` 是生命週期參數型別、`Button` 是按鈕類別、`AppCompatActivity` 是產生畫面該繼承的基底類別）。
- `public class MainActivity extends AppCompatActivity`：**繼承** `AppCompatActivity`，這代表「它是一個可顯示的畫面」，並取得系統給的完整生命週期能力。
- `@Override protected void onCreate(Bundle savedInstanceState)`：**覆寫**畫面「建立」時會觸發的方法——這是 App 啟動後最先生成 UI 的地方。
  - `super.onCreate(savedInstanceState);`：先呼叫父類別做初始化，**必須放在第一行**。
  - `setContentView(R.layout.activity_main);`：把剛剛設計的佈局套到這個畫面上，畫面 A 的「長相」才會出現。
- `Button btnGo = findViewById(R.id.btnGo);`：從這個佈局中「靠 id 抓出」按鈕物件。
- `btnGo.setOnClickListener(...)`：給按鈕掛監聽；點擊時建立 `Intent`（A → B）並 `startActivity` 跳轉。

**Step 5 畫面 B 佈局 `activity_second.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="24dp">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="這是第二畫面"
        android:textSize="22sp"
        android:textStyle="bold" />

</LinearLayout>
```

**佈局說明（`activity_second.xml` 是畫面 B 的長相）**：
- 結構跟 A 幾乎相同：一個垂直 `LinearLayout` 包著一支置中的 `TextView`。
- 差的只是文字內容「這是第二畫面」——因為 B 這支範例只負責「被跳過去」，所以不需要任何按鈕或輸入框。
- `wrap_content`：元件寬高「跟內容一樣大」，不像 `match_parent` 填滿。

**Step 6 畫面 B 程式 `SecondActivity.java`**（只要把畫面設為 `activity_second` 即可）：

```java
package com.example.jumpdemo;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

public class SecondActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
    }
}
```

**程式說明（`SecondActivity.java` 是畫面 B 的邏輯）**：
- 整體與 MainActivity 同款，**差別只在 `setContentView(R.layout.activity_second)`** 指定套用的是 B 的佈局。
- 它沒有任何監聽器，因為 B 只要「顯示出來」即可——接收、回傳資料的功能會在第 3、4 章再加。
- `extends AppCompatActivity` 讓它能被 `startActivity(intent)` 啟動。

**Step 7 執行**：
| 操作 | 預期結果 |
|---|---|
| 點「執行 ▶」並安裝 | App 顯示「這是第一個畫面」 |
| 點「點我跳到第二畫面」 | 畫面切換到「這是第二畫面」 |
| 按返回鍵 ⌫ | 回到第一個畫面 |

> ✅ 你已在 Android 上完成**第一個畫面跳轉**。這正是 `new SecondFrame().setVisible(true)` 的等價，只是改用 `startActivity(intent)`。
> 如果跳到 B 讓你寫在 B 裡看不到你要的結果，請確認 B 在 **AndroidManifest.xml** 有 `<activity android:name=".SecondActivity" />` 註冊。

---

# 第 3 章　畫面間傳遞資料（取代 showInputDialog 的回傳值）

### 3.1 傳資料過去（putExtra）

```java
// MainActivity 想傳名字給 SecondActivity
Intent intent = new Intent(MainActivity.this, SecondActivity.class);
intent.putExtra("name", "張三");
intent.putExtra("age", 30);          // int
intent.putExtra("isStudent", true);  // boolean
startActivity(intent);
```

**逐行說明**：
- `Intent intent = new Intent(MainActivity.this, SecondActivity.class);`：先建立「A → B」的跳轉意圖（沿用第 2 章）。
- `intent.putExtra("name", "張三");`：**在意圖上「附帶」一份資料**。第一個參數是「鑰匙（key）」，第二個是「值（value）」。習慣上 key 用英文、語意化名稱，B 端用同一個 key 就能拿回這個值。
- `intent.putExtra("age", 30);`：再附一份 `int` 型別的資料。`putExtra` 是**多載（overload）**，能分辨整數、字串、布林等各種型別。
- `intent.putExtra("isStudent", true);`：附一份布林資料。你可以想成：`Intent` 像一個「行李袋」，`putExtra` 就是一件件塞進去。
- `startActivity(intent);`：**帶著整袋行李**啟動 B。此時 A 身上的資料會跟著意圖一起「送」到 B。

> 記憶：`putExtra` 是「A 放」，`getExtra` 是「B 拿」，兩邊都要配合使用。

### 3.2 在 SecondActivity 接收（getExtra）

```java
// SecondActivity.java 的 onCreate 中
String name = getIntent().getStringExtra("name");
int age = getIntent().getIntExtra("age", 0);
boolean isStudent = getIntent().getBooleanExtra("isStudent", false);

TextView tvShow = findViewById(R.id.tvShow);
tvShow.setText("你好，" + name + "，今年 " + age + " 歲");
```

**逐行說明**：
- `getIntent()`：拿到「啟動我（B）的那支意圖」——也就是 A 送來的那個 `Intent` 行李袋。
- `getStringExtra("name")`：從袋中取出 key 為 `"name"` 的字串值，對應 A 的 `putExtra("name", ...)`。
- `getIntExtra("age", 0)`：取 `int` 值；**第二個參數 `0` 是「預設值」**——萬一 A 沒附 `"age"`，就回傳 `0` 而不是報錯。
- `getBooleanExtra("isStudent", false)`：取布林，同理預設 `false`。
- `findViewById(R.id.tvShow)`：抓出佈局裡的顯示文字 `TextView`。
- `tvShow.setText("你好，" + name + "，今年 " + age + " 歲");`：把收到的值組合成一句話顯示在畫面上。

> 注意 `getIntExtra` 第二個參數是**預設值**（若沒拿到該 key 時回傳）。

> 💡 **完整可直接執行範例**見下方「⭐ 第 3 章　完整範例」；另可參考第 11 章「商品編輯傳值」。

---

## ⭐ 第 3 章　完整可直接執行範例：A → B 傳值 App

> 目的：把上面的 putExtra / getExtra 做成**可直接執行**的範例——在 A 輸入姓名與年齡，跳到 B 並顯示。
> 套件名：`com.example.senddata`。共 4 支檔案：兩份 XML + 兩支 Java。

**Step 1 建立專案**：**New Project → Empty Views Activity**，Language **Java**，Package `com.example.senddata`。

**Step 2 新增第二個畫面**：右鍵套件 → **New → Activity → Empty Views Activity**，名稱 `SecondActivity`。

**Step 3 畫面 A 佈局 `activity_main.xml`**（輸入姓名、年齡 + 傳送鈕）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="傳資料給 B"
        android:textSize="24sp"
        android:textStyle="bold" />

    <EditText
        android:id="@+id/etName"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="20dp"
        android:hint="姓名" />

    <EditText
        android:id="@+id/etAge"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:hint="年齡"
        android:inputType="number" />

    <Button
        android:id="@+id/btnSend"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="傳送並跳到 B" />

</LinearLayout>
```

**佈局說明（畫面 A）**：
- 根容器是垂直 `LinearLayout`，由上而下排：標題 → 姓名輸入框 → 年齡輸入框 → 傳送按鈕。
- `<EditText>`：文字輸入框（取代 Swing 的 `JTextField`）。`android:hint` 是「未輸入時的灰色提示字」。
  - `etName`：姓名框，`android:hint="姓名"`。
  - `etAge`：年齡框，特別加了 `android:inputType="number"`，讓鍵盤只彈出數字、限制輸入數字。
- `<Button android:id="@+id/btnSend"... text="傳送並跳到 B">`：觸發跳轉的按鈕，Java 用 `btnSend` 綁定。

**Step 4 畫面 A 程式 `MainActivity.java`**（putExtra 送出資料）：

```java
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
        EditText etAge = findViewById(R.id.etAge);
        Button btnSend = findViewById(R.id.btnSend);

        btnSend.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, SecondActivity.class);
            intent.putExtra("name", etName.getText().toString().trim());   // String
            String ageText = etAge.getText().toString().trim();
            intent.putExtra("age", ageText.isEmpty() ? 0 : Integer.parseInt(ageText));  // int
            startActivity(intent);
        });
    }
}
```

**程式說明（畫面 A）**：
- `EditText etName = findViewById(R.id.etName);`：抓出兩個輸入框與按鈕，準備取使用者輸入的值。
- `btnSend.setOnClickListener(v -> {...})`：點「傳送并跳到 B」時執行。
  - `etName.getText().toString()`：取得輸入框**目前的文字**；`.trim()` 去掉首尾空白。
  - `intent.putExtra("name", ...)`：把姓名放進行李袋。
  - `String ageText = etAge.getText().toString().trim();`：先取年齡文字的**字串**。
  - `ageText.isEmpty() ? 0 : Integer.parseInt(ageText)`：**三元運算子**——若使用者沒填（空字串）就傳 `0`，否則用 `Integer.parseInt` 把字串轉成 `int`。（因為 `putExtra` 的 `int` 版本不接收字串。）
  - `startActivity(intent);`：帶著 name 與 age 兩份資料啟動 B。

> ⚡ 對照 Swing：`showInputDialog` 會「卡住等輸入」；Android 改成「A 主動 putExtra 送出、B 自己 getExtra 接收」，非同步、兩邊拆開，更適合手機操作。

**Step 5 畫面 B 佈局 `activity_second.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="24dp">

    <TextView
        android:id="@+id/tvShow"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:textSize="20sp"
        android:text="尚未收到資料" />

</LinearLayout>
```

**佈局說明（畫面 B）**：
- 只有一支 `TextView`（id `tvShow`），`gravity="center"` 讓它置中。
- 初始文字是「尚未收到資料」；等收到 A 的資料後，會被 Java 用 `setText` 覆蓋成真正的內容。
- `@+id/tvShow` 指定 id 給 Java 綁定。

**Step 6 畫面 B 程式 `SecondActivity.java`**（getExtra 讀取並顯示）：

```java
package com.example.senddata;

import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class SecondActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        TextView tvShow = findViewById(R.id.tvShow);

        // 讀取 A 用 putExtra 送來的資料（第二個參數 = 沒拿到時的回傳值）
        String name = getIntent().getStringExtra("name");
        int age = getIntent().getIntExtra("age", -1);

        if (name == null || name.isEmpty()) name = "訪客";   // 防呆：沒帶名字也能正常顯示

        tvShow.setText("你好，" + name + "，今年 " + age + " 歲");
    }
}
```

**程式說明（畫面 B）**：
- `setContentView(R.layout.activity_second);`：套用 B 的佈局。
- `TextView tvShow = findViewById(R.id.tvShow);`：抓出要顯示的元件。
- `String name = getIntent().getStringExtra("name");`：**從啟動我的意圖中**取出 A 送的姓名。
- `int age = getIntent().getIntExtra("age", -1);`：取年齡；這裡把預設值設成 `-1`——用意是「假如 A 沒附 age，B 顯示 -1 就知道沒拿到」，與 3.2 預設 `0` 不同，示範預設值可自由設定。
- `tvShow.setText("你好，" + name + "，今年 " + age + " 歲");`：把收到的資料組句顯示出來。

**Step 7 執行**：
| 操作 | 預期結果 |
|---|---|
| 輸入姓名「張三」、年齡「30」→ 按「傳送並跳到 B」 | 跳到 B，B 顯示「你好，張三，今年 30 歲」 |
| 只輸入姓名、不填年齡 → 傳送 | B 顯示「年齡 -1」（預設值生效） |

> ✅ 這就取代了 JFrame 用 `showInputDialog` 拿值的方式：Android 改由 A 用 `putExtra` 送出、B 用 `getExtra` 讀回。
> 想再多嘗試：`putExtra("isStudent", true)` → B 用 `getBooleanExtra("isStudent", false)` 讀出。

---

# 第 4 章　回傳結果給前一個畫面（startActivityForResult）

這是畫面間「溝通回應」的重點，也比 JFrame 的 modal dialog 更明確。

```java
// MainActivity：啟動並等待結果
btnPick.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this, SecondActivity.class);
    startActivityForResult(intent, 1001);   // 1001 是 request code
});

// 覆寫接收結果
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == 1001 && resultCode == RESULT_OK) {
        String result = data.getStringExtra("result");
        tvResult.setText("收到：" + result);
    }
}
```

**逐段說明（A 端）**：
- `startActivityForResult(intent, 1001);`：**「跳過去並等待結果」**。它比 `startActivity` 多一個 `request code`（這裡是 `1001`），用來分辨「是哪一次要求」的回傳。這是舊寫法的核心。
- `@Override protected void onActivityResult(int requestCode, int resultCode, Intent data)`：**覆寫**方法——當 B 關閉送回首傳時，系統會呼叫這裡，把三個資訊傳進來：
  - `requestCode`：對應你送出的 `1001`，可用來判斷「是哪次要求的結果」。
  - `resultCode`：B 設的結果狀態，通常比對 `RESULT_OK`（成功）。
  - `data`：B 附帶回傳的資料行李袋。
- `if (requestCode == 1001 && resultCode == RESULT_OK)`：雙重檢查——「確實是我的那次要求」且「B 成功回傳」，才處理資料，避免混亂。
- `data.getStringExtra("result")`：取出 B 用 `putExtra("result", ...)` 放的回傳值，顯示出來。

```java
// SecondActivity：把結果回傳並關閉
Button btnSendBack = findViewById(R.id.btnSendBack);
btnSendBack.setOnClickListener(v -> {
    Intent data = new Intent();
    data.putExtra("result", "這是回傳的資料");
    setResult(RESULT_OK, data);   // 設定回傳結果
    finish();                     // 關閉目前 Activity
});
```

**逐行說明（B 端）**：
- `Intent data = new Intent();`：**建立一支「空」的意圖**，注意這裡沒有指到任何 Activity——它只是當「回傳的行李袋」用。
- `data.putExtra("result", "這是回傳的資料");`：把要回傳的內容放進袋中。
- `setResult(RESULT_OK, data);`：**「設定」回傳結果**——告訴系統「我成功了，這袋資料拿回去」。它只把結果準備好，還不會真的交回。
- `finish();`：**關閉目前的 Activity**。關閉的一瞬間，系統才會把剛才 `setResult` 的結果帶回 A，並觸發 A 的 `onActivityResult`。

**Lambda 對照**：
- `btnPick` / `btnSendBack` 的 `setOnClickListener(v -> {...})` 一樣可以寫回 anonymous class（見 2.1）。
- 但 `onActivityResult(...)` 是 **Activity 生命週期的「方法覆寫 (override)」**，不是 listener 介面，
  **不能**用 lambda 簡寫。lambda 只能用在「單一抽象方法的介面/抽象類別」，不能用來覆寫「已定義好的方法」。

> ⚡ **對照**：類似 JOptionPane.showInputDialog 回傳使用者輸入，但 Android 拆成「發送端」與「接收端」兩邊，更靈活。
> 💡 **作法提醒**：舊寫法 `startActivityForResult` / `onActivityResult` 已被 **Activity Result API**（`registerForActivityResult`）取代。
> - 以下「⭐ 第 4 章　完整範例」會**同時示範新舊兩種寫法**，讓你親眼比較差別。
> - 新版寫法另可參考第 11 章「商品編輯傳值」與第 12 章「顏色選擇器」。

---

## ⭐ 第 4 章　完整可直接執行範例：A ↔ B 回傳結果 App

> 目的：把「回傳結果」做成**可直接執行**的範例——A 開啟 B，B 輸入一行文字後回傳，A 顯示收到的字。
> 套件名：`com.example.resultdemo`。共 4 支檔案：兩份 XML + 兩支 Java。
> 這支同時示範**新版 Result API**（推薦）與**舊 `startActivityForResult`**（對照用）。

**Step 1 建立專案**：**New Project → Empty Views Activity**，Language **Java**，Package `com.example.resultdemo`。

**Step 2 新增第二個畫面**：右鍵套件 → **New → Activity → Empty Views Activity**，名稱 `SecondActivity`。

**Step 3 畫面 A 佈局 `activity_main.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="回傳結果"
        android:textSize="24sp"
        android:textStyle="bold" />

    <Button
        android:id="@+id/btnLaunchNew"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="開啟 B：新版 Result API" />

    <Button
        android:id="@+id/btnLaunchOld"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:text="開啟 B：舊 startActivityForResult" />

    <TextView
        android:id="@+id/tvResult"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:textSize="18sp"
        android:text="尚未收到結果" />

</LinearLayout>
```

**佈局說明（畫面 A）**：
- 由上而下：標題 → 兩支按鈕（新版 / 舊寫法）→ 顯示結果的文字。
- `btnLaunchNew`：示範**新版** `registerForActivityResult`。
- `btnLaunchOld`：示範**舊** `startActivityForResult`。兩支按鈕都開同一個 B，用不同技術接結果，方便對照。
- `tvResult`：接收 B 回傳後顯示結果的地方。

**Step 4 畫面 A 程式 `MainActivity.java`**：

```java
package com.example.resultdemo;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private TextView tvResult;

    // 新版 Result API：宣告成欄位 → 在 Activity 進入 RESUMED 之前就完成註冊
    // （若在按鈕點擊事件裡才 register，會拋 IllegalStateException）
    private final ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            result -> {
                if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                    String value = result.getData().getStringExtra("result");
                    tvResult.setText("收到（新版）：" + value);
                }
            });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvResult = findViewById(R.id.tvResult);
        Button btnLaunchNew = findViewById(R.id.btnLaunchNew);
        Button btnLaunchOld = findViewById(R.id.btnLaunchOld);

        // -------- 新版 Result API（官方推薦）：registerForActivityResult --------
        btnLaunchNew.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, SecondActivity.class);
            resultLauncher.launch(intent);
        });

        // -------- 舊寫法（已被取代，但你在舊專案仍會看到）--------
        btnLaunchOld.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, SecondActivity.class);
            startActivityForResult(intent, 1001);   // 1001 = request code
        });
    }

    // 舊寫法：覆寫方法（方法覆寫 → 不能用 lambda，只能 override）
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1001 && resultCode == RESULT_OK && data != null) {
            String value = data.getStringExtra("result");
            tvResult.setText("收到（舊寫法）：" + value);
        }
    }
}
```

**程式說明（畫面 A，重點讀懂新舊兩套）**：
- `private TextView tvResult;`：宣告元件為**類別欄位**，因為除了 `onCreate`，等結果的兩處也都要用到它來更新顯示。
- 新版按鈕：點擊時 `resultLauncher.launch(intent)`——用預先註冊的 `resultLauncher` 啟動 B。
- 舊版按鈕：點擊時 `startActivityForResult(intent, 1001)`——這正是舊寫法。
- **新版 `private final ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(...)`**：
  - 他是「等待結果的啟動器」，用 `registerForActivityResult` 註冊。
  - **宣告成欄位**：確保註冊發生在 Activity 進入 `RESUMED` 之前；寫在點擊事件裡會直接崩潰（見第 5.5.2 節）。
  - 第一個參數 `new ActivityResultContracts.StartActivityForResult()`：指定「我要等的是『啟動一個 Activity 並收結果』」這個合約。
  - 第二個參數 `result -> {...}`：**回呼**，B 關閉時自動執行。因為這是**單一抽象方法的介面（functional interface）**，所以**可以用 lambda**。
  - `result.getResultCode() == RESULT_OK && result.getData() != null`：檢查成功且資料袋非空。
  - `result.getData().getStringExtra("result")`：取出 B 回傳的字串，更新 `tvResult`。
- **舊寫法 `@Override protected void onActivityResult(...)`**：**覆寫**方法，靠 `requestCode == 1001` 判斷是否自己的結果。

> 🔑 關鍵差異：新版用「lambda 回呼」接結果（能 lambda 化）；舊版是「覆寫 Activity 方法」接結果（**不能** lambda）。判斷準則就是——單一抽象方法介面 → lambda；覆寫既有方法 → 只能寫方法。

**Step 5 畫面 B 佈局 `activity_second.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="這是 B，輸入後回傳"
        android:textSize="20sp"
        android:textStyle="bold" />

    <EditText
        android:id="@+id/etFeedback"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:hint="要回傳的文字" />

    <Button
        android:id="@+id/btnSendBack"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="回傳給 A 並關閉" />

</LinearLayout>
```

**佈局說明（畫面 B）**：
- 標題 → 輸入框（`etFeedback`，要回傳的文字）→「回傳給 A 並關閉」按鈕（`btnSendBack`）。
- 這次是名副其實的「輸入文字然後送回去」。

**Step 6 畫面 B 程式 `SecondActivity.java`**：

```java
package com.example.resultdemo;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class SecondActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        EditText etFeedback = findViewById(R.id.etFeedback);
        Button btnSendBack = findViewById(R.id.btnSendBack);

        btnSendBack.setOnClickListener(v -> {
            String feedback = etFeedback.getText().toString().trim();
            if (feedback.isEmpty()) {
                Toast.makeText(this, "請輸入文字", Toast.LENGTH_SHORT).show();
                return;
            }
            Intent data = new Intent();
            data.putExtra("result", feedback);
            setResult(RESULT_OK, data);   // 告訴 A：成功，帶回資料
            finish();                     // 關閉 B，回到 A
        });
    }
}
```

**程式說明（畫面 B）**：
- `btnSendBack.setOnClickListener(v -> {...})`：按「回傳並關閉」時執行。
- `String feedback = etFeedback.getText().toString().trim();`：取出輸入文字。
- `if (feedback.isEmpty())`：若是空的，跳出 Toast「請輸入文字」並 `return`（**不**回傳也不關閉），形成「防呆」。
- `Intent data = new Intent();`：空意圖當行李袋。
- `data.putExtra("result", feedback);`：放進要回傳文字。
- `setResult(RESULT_OK, data);`：準備好「成功 + 資料」。
- `finish();`：關 B、跳回 A，系統把結果交到 A 的接結果處。

**Step 7 執行**：
| 操作 | 預期結果 |
|---|---|
| 點「開啟 B：新版 Result API」→ B 輸入「Hello」→ 回傳 | A 顯示「收到（新版）：Hello」 |
| 點「開啟 B：舊 startActivityForResult」→ B 輸入「Hi」→ 回傳 | A 顯示「收到（舊寫法）：Hi」 |
| B 沒輸入就按回傳 | 跳出 Toast「請輸入文字」，不會關閉 B |

> ✅ 兩種寫法達到**相同效果**。新版（`registerForActivityResult`）是 Google 現行推薦，精神上就是「等 B 回傳」的 Listener；舊寫法是早期版本的方式。
> 關鍵差別：`registerForActivityResult` 用的是「Listener（可 lambda 化）」，舊 `onActivityResult` 是「Activity 生命週期方法覆寫」，**不能**用 lambda。

---

# 第 5 章　Intent 的其它用法

```java
// 撥號
Intent dial = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678"));
startActivity(dial);

// 開啟網頁
Intent web = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com"));
startActivity(web);
```

**逐行說明**：
- `Intent dial = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:0912345678"));`：建立一支「**動作 = 撥號**」的 Intent。
  - `Intent.ACTION_DIAL`：**動作（action）** 常數，代表「我想撥號」。
  - `Uri.parse("tel:0912345678")`：把電話號碼字串包成 Android 的 URI 資料。`tel:` 前置字串告訴系統這是電話。
- `startActivity(dial);`：交給系統去執行撥號動作。
- `Intent web = new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.google.com"));`：動作改成 `ACTION_VIEW`（「我想檢視/開啟」），資料放網址。
- `startActivity(web);`：系統會自行挑選「能開啟網址的 App」（通常是瀏覽器）來處理。

這表示 `Intent` 不只是跳 Activity，也能呼叫系統功能。

### 5.1 常用系統 Intent 速查表

| 功能 | Action | 資料 / 額外參數 | 備註 |
|---|---|---|---|
| 開啟撥號盤 | `Intent.ACTION_DIAL` | `tel:0912345678` | 免權限 |
| 直接撥出 | `Intent.ACTION_CALL` | `tel:0912345678` | 需 `CALL_PHONE` + 執行時期權限 |
| 傳簡訊 | `Intent.ACTION_SENDTO` | `smsto:0912345678` + `"sms_body"` | 開啟簡訊 App |
| 寄 Email | `Intent.ACTION_SENDTO` | `mailto:a@b.com` + `EXTRA_SUBJECT` / `EXTRA_TEXT` | 開啟郵件 App |
| 分享文字 | `Intent.ACTION_SEND` | `setType("text/plain")` + `EXTRA_TEXT` | 建議包 `createChooser` |
| 開啟地圖 | `Intent.ACTION_VIEW` | `geo:25.0330,121.5654?q=台北101` | 開啟地圖 App |
| 開啟網頁 | `Intent.ACTION_VIEW` | `https://www.google.com` | 開啟瀏覽器 |
| App 設定頁 | `Settings.ACTION_APPLICATION_DETAILS_SETTINGS` | `package:你的套件名` | 引導使用者開權限 |

```java
// 傳簡訊（帶入號碼與內容，開啟簡訊 App）
Intent sms = new Intent(Intent.ACTION_SENDTO, Uri.parse("smsto:0912345678"));
sms.putExtra("sms_body", "你好");
startActivity(sms);

// 寄 Email
Intent email = new Intent(Intent.ACTION_SENDTO, Uri.parse("mailto:someone@example.com"));
email.putExtra(Intent.EXTRA_SUBJECT, "課程詢問");
email.putExtra(Intent.EXTRA_TEXT, "您好，我想了解課程內容。");
startActivity(email);

// 分享文字（用選擇器讓使用者挑 App）
Intent share = new Intent(Intent.ACTION_SEND);
share.setType("text/plain");
share.putExtra(Intent.EXTRA_TEXT, "推薦這個 Android 課程！");
startActivity(Intent.createChooser(share, "分享到"));

// 開啟地圖
startActivity(new Intent(Intent.ACTION_VIEW,
        Uri.parse("geo:25.0330,121.5654?q=台北101")));

// 開啟本 App 的系統設定頁（常用來引導使用者開權限）
Intent settings = new Intent(
        android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
        Uri.parse("package:" + getPackageName()));
startActivity(settings);
```

> ⚠️ 系統 Intent 不保證裝置上有 App 能處理。若希望「沒有 App 時不要崩潰」，可先檢查
> `intent.resolveActivity(getPackageManager()) != null`，或包在 `try { ... } catch (ActivityNotFoundException e) { ... }` 中。

---

## ⭐ 第 5 章　完整可直接執行範例：系統功能 App

> 目的：把上面的系統 Intent（撥號、開網頁、簡訊、Email、分享、地圖、App 設定頁）做成**可直接執行**的範例。只需一支 Activity，不需第二個畫面。
> 套件名：`com.example.sysints`。

**Step 1 建立專案**：**New Project → Empty Views Activity**，Language **Java**，Package `com.example.sysints`。

**Step 2 佈局 `activity_main.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:fillViewport="true">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:gravity="center"
        android:padding="24dp">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="呼叫系統功能"
            android:textSize="22sp"
            android:textStyle="bold" />

        <Button
            android:id="@+id/btnDial"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="24dp"
            android:text="撥號（Dial）" />

        <Button
            android:id="@+id/btnWeb"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="8dp"
            android:text="開啟網頁（View）" />

        <Button
            android:id="@+id/btnSms"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="8dp"
            android:text="傳簡訊（SendTo）" />

        <Button
            android:id="@+id/btnEmail"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="8dp"
            android:text="寄 Email（SendTo）" />

        <Button
            android:id="@+id/btnShare"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="8dp"
            android:text="分享文字（Send）" />

        <Button
            android:id="@+id/btnMap"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="8dp"
            android:text="開啟地圖（View）" />

        <Button
            android:id="@+id/btnSettings"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="8dp"
            android:text="本 App 設定頁" />

    </LinearLayout>
</ScrollView>
```

**佈局說明**：
- 用 `ScrollView` 包住垂直 `LinearLayout`，按鈕多時仍可捲動，小螢幕也不會被截掉。
- 七支按鈕各自對應一種系統 Intent：撥號、開網頁、簡訊、Email、分享、地圖、App 設定頁。
- 因為只是呼叫系統，不需要第二支 Activity。

**Step 3 程式 `MainActivity.java`**：

```java
package com.example.sysints;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.Settings;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button btnDial = findViewById(R.id.btnDial);
        Button btnWeb = findViewById(R.id.btnWeb);
        Button btnSms = findViewById(R.id.btnSms);
        Button btnEmail = findViewById(R.id.btnEmail);
        Button btnShare = findViewById(R.id.btnShare);
        Button btnMap = findViewById(R.id.btnMap);
        Button btnSettings = findViewById(R.id.btnSettings);

        // 1. 開啟撥號盤（不會真的播出）
        btnDial.setOnClickListener(v ->
                startActivity(new Intent(Intent.ACTION_DIAL,
                        Uri.parse("tel:0912345678"))));

        // 2. 用瀏覽器開網頁
        btnWeb.setOnClickListener(v ->
                startActivity(new Intent(Intent.ACTION_VIEW,
                        Uri.parse("https://www.google.com"))));

        // 3. 開啟簡訊 App，帶入號碼與內容
        btnSms.setOnClickListener(v -> {
            Intent sms = new Intent(Intent.ACTION_SENDTO,
                    Uri.parse("smsto:0912345678"));
            sms.putExtra("sms_body", "你好，這是預設簡訊內容");
            startActivity(sms);
        });

        // 4. 開啟郵件 App，帶入收件者、主旨與內容
        btnEmail.setOnClickListener(v -> {
            Intent email = new Intent(Intent.ACTION_SENDTO,
                    Uri.parse("mailto:someone@example.com"));
            email.putExtra(Intent.EXTRA_SUBJECT, "課程詢問");
            email.putExtra(Intent.EXTRA_TEXT, "您好，我想了解課程內容。");
            startActivity(email);
        });

        // 5. 分享文字（用選擇器讓使用者挑 App）
        btnShare.setOnClickListener(v -> {
            Intent share = new Intent(Intent.ACTION_SEND);
            share.setType("text/plain");
            share.putExtra(Intent.EXTRA_TEXT, "推薦這個 Android 課程！");
            startActivity(Intent.createChooser(share, "分享到"));
        });

        // 6. 用地圖 App 開啟指定座標
        btnMap.setOnClickListener(v ->
                startActivity(new Intent(Intent.ACTION_VIEW,
                        Uri.parse("geo:25.0330,121.5654?q=台北101"))));

        // 7. 開啟本 App 的系統設定頁（常用於引導使用者開權限）
        btnSettings.setOnClickListener(v -> {
            Intent settings = new Intent(
                    Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                    Uri.parse("package:" + getPackageName()));
            startActivity(settings);
        });
    }
}
```

**程式說明**：
- `import android.net.Uri;`：需要用 `Uri.parse(...)` 把文字包成 URI。
- `import android.provider.Settings;`：`Settings.ACTION_APPLICATION_DETAILS_SETTINGS` 用來開啟「本 App 的系統設定頁」。
- **撥號**：`ACTION_DIAL` 只開撥號畫面，**免權限**（要直接撥出請看下一節 `ACTION_CALL`）。
- **簡訊**：`ACTION_SENDTO` + `smsto:`，`"sms_body"` 是簡訊內容的 key。
- **Email**：`ACTION_SENDTO` + `mailto:`，主旨／內容用 `EXTRA_SUBJECT` / `EXTRA_TEXT`。
- **分享**：`ACTION_SEND` 必須 `setType("text/plain")`，再用 `createChooser` 讓使用者挑 App。
- **地圖**：`geo:緯度,經度?q=名稱`，交給地圖 App 處理。
- **設定頁**：`package:` + `getPackageName()` 指向自己，使用者可在這裡開關權限。
- 重點：程式完全不指定「用哪個 App」——**交給系統決定**，這正是系統 Intent 的威力。

**Step 4 執行**：
| 操作 | 預期結果 |
|---|---|
| 按「撥號（Dial）」 | 開啟系統撥號介面，號碼已帶入 0912345678（不需真播出） |
| 按「開啟網頁（View）」 | 開啟瀏覽器，載入 Google |
| 按「傳簡訊（SendTo）」 | 開啟簡訊 App，號碼與內容已帶入 |
| 按「寄 Email（SendTo）」 | 開啟郵件 App，收件者／主旨／內容已帶入 |
| 按「分享文字（Send）」 | 跳出系統分享選擇器 |
| 按「開啟地圖（View）」 | 開啟地圖 App 並定位到台北 101 |
| 按「本 App 設定頁」 | 開啟本 App 的系統資訊／權限頁 |

> 💡 若裝置上沒有能處理該 Intent 的 App，`startActivity` 會拋 `ActivityNotFoundException`。
> 正式專案可先以 `intent.resolveActivity(getPackageManager()) != null` 檢查，或加上 `try/catch`。

> ✅ 系統 Intent 的眉角：**只要 `startActivity`** 交給系統，系統會自動挑選「能處理這個 action 的 App」。這對照 Swing 只能自己 `Desktop.open(uri)`，Android 更靈活。

---

## ⭐ 第 5 章　進階範例：`ACTION_CALL` 直接撥號（執行時期權限）

> 目的：把上一節的 `ACTION_DIAL`（只開撥號畫面）升級成「一鍵直接撥出」。
> 這需要 `CALL_PHONE` 這個**危險權限（dangerous permission）**；Android 6.0（API 23）之後，除了在 Manifest 宣告，還必須在**執行時期**向使用者申請。

### 5.2 先搞懂：`ACTION_DIAL` 與 `ACTION_CALL` 差在哪？

| 比較項目 | `ACTION_DIAL` | `ACTION_CALL` |
|---|---|---|
| 行為 | 開啟系統撥號畫面，號碼已帶入，使用者自己按「撥出」 | 立刻撥出電話 |
| 權限 | **不需要** | 需要 `CALL_PHONE` |
| Manifest | 不用加 | 要加 `<uses-permission>` |
| 執行時期申請 | 不用 | **要**（API 23+） |
| 適用情境 | 教學示範、讓使用者確認號碼 | 客服一鍵撥號、緊急聯絡、外送電話 |

> 教學上建議先用 `ACTION_DIAL`（免權限、好除錯），確定 Intent 觀念通了，再換成 `ACTION_CALL` 練習權限流程。

### 5.3 步驟 1：AndroidManifest.xml 宣告權限

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- ① 放在 <manifest> 內、<application> 之前 -->
    <uses-permission android:name="android.permission.CALL_PHONE" />

    <application ...>
        ...
    </application>
</manifest>
```

- `<uses-permission>` 必須是 `<manifest>` 的**直接子元素**；放進 `<application>` 裡無效。
- 只宣告還不夠：`CALL_PHONE` 屬於**危險權限**，使用者可以事後隨時撤銷，所以每次撥號前都要確認。

### 5.4 步驟 2：完整 `MainActivity.java`（可直接貼）

```java
package com.example.sysints;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

public class MainActivity extends AppCompatActivity {

    // ① 自訂 requestCode：辨識「這是哪一次權限請求」
    private static final int PERMISSION_REQUEST_CALL_PHONE = 1;
    // ② tel: 開頭的 URI，ACTION_CALL 直接用它撥號
    private String phoneNumber = "tel:0931117807";   // 換成你想撥打的號碼

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button btnDial = findViewById(R.id.btnDial);
        Button btnWeb  = findViewById(R.id.btnWeb);

        // ③ 按下撥號 → 先檢查權限，再決定要不要撥
        btnDial.setOnClickListener(v -> checkAndMakeCall());

        btnWeb.setOnClickListener(v ->
                startActivity(new Intent(Intent.ACTION_VIEW,
                        Uri.parse("https://24h.pchome.com.tw"))));
    }

    /** 檢查權限：有 → 直接撥；沒有 → 跳出系統權限對話框 */
    private void checkAndMakeCall() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CALL_PHONE)
                != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,
                    new String[]{Manifest.permission.CALL_PHONE},
                    PERMISSION_REQUEST_CALL_PHONE);
        } else {
            makePhoneCall();
        }
    }

    /** 真正執行 ACTION_CALL */
    private void makePhoneCall() {
        Intent intent = new Intent(Intent.ACTION_CALL);
        intent.setData(Uri.parse(phoneNumber));

        // ④ ACTION_CALL 前一定要再確認一次，否則 lint 會標 MissingPermission
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.CALL_PHONE)
                == PackageManager.PERMISSION_GRANTED) {
            startActivity(intent);
        }
    }

    /** ⑤ 使用者在權限對話框按下「允許 / 拒絕」後，結果回到這裡 */
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions,
                                           @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        if (requestCode == PERMISSION_REQUEST_CALL_PHONE) {
            if (grantResults.length > 0
                    && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                makePhoneCall();          // 允許 → 撥出
            } else {
                Toast.makeText(this, "需要電話權限才能直接撥打電話",
                        Toast.LENGTH_SHORT).show();
            }
        }
    }
}
```

### 5.5 流程圖：一次點擊會發生什麼事？

```
按下 btnDial
   │
   ▼
checkAndMakeCall()
   │
   ├─ 已有 CALL_PHONE ─────────────► makePhoneCall() ─► startActivity(ACTION_CALL) ─► 撥出
   │
   └─ 尚未取得權限
        │
        ▼
   ActivityCompat.requestPermissions(..., 1)
        │  系統跳出「允許 / 拒絕」對話框（非同步，程式先返回）
        ▼
   onRequestPermissionsResult(requestCode = 1, ...)
        ├─ PERMISSION_GRANTED ─► makePhoneCall() ─► 撥出
        └─ PERMISSION_DENIED  ─► Toast「需要電話權限…」
```

### 5.6 逐段說明（API 細節）

1. **`PERMISSION_REQUEST_CALL_PHONE = 1`**
   - 自己定義的整數常數，用來在 `onRequestPermissionsResult` 辨識「這個結果是哪一次請求」。
   - 一支 Activity 若同時申請多種權限（相機、定位…），每個請求要用**不同的 requestCode**。

2. **`ContextCompat.checkSelfPermission(this, Manifest.permission.CALL_PHONE)`**
   - 回傳 `PackageManager.PERMISSION_GRANTED`（已授權）或 `PERMISSION_DENIED`（未授權）。
   - 用 `ContextCompat` 而不是 `Context.checkSelfPermission`，是為了相容 API 23 以前（舊版一律視為已授權）。

3. **`ActivityCompat.requestPermissions(this, new String[]{...}, requestCode)`**
   - **非同步**：呼叫後立刻返回，系統同時跳出權限對話框。
   - 一次可以傳多個權限（`String[]`），系統會依序詢問。
   - 結果**不會**用回傳值給你，而是在 `onRequestPermissionsResult` 回呼。

4. **`makePhoneCall()` 內為什麼還要再檢查一次？**
   - `ACTION_CALL` 是 Android Studio **lint 會檢查**的 API：沒先驗證權限就呼叫，會標紅 `MissingPermission`。
   - 也避免「使用者剛剛撤銷權限」的競態：真正 `startActivity` 前再確認一次最安全。

5. **`onRequestPermissionsResult(requestCode, permissions, grantResults)`**
   - 是 Activity 的**既有方法** → 只能 `@Override`，**不能寫成 lambda**。
   - 一定要先呼叫 `super.onRequestPermissionsResult(...)`（Fragment、AndroidX 元件會用到）。
   - `permissions[0]` 與 `grantResults[0]` 一一對應；本例只有一個權限，所以只看 index 0。

6. **`grantResults.length > 0` 的防呆**
   - 使用者按「返回鍵 / 點對話框外面」取消時，`grantResults` 可能是**空陣列**。
   - 直接寫 `grantResults[0]` 會拋 `ArrayIndexOutOfBoundsException`。

7. **被拒絕之後**
   - 下次再按按鈕會**再問一次**；若使用者勾了「不再詢問」，系統會直接回 `DENIED`。
   - 這時可用 `shouldShowRequestPermissionRationale()` 判斷，並引導到「設定 → 應用程式 → 權限 → 電話」手動開啟。

### 5.7 常見錯誤排查

| 症狀 | 原因 | 解法 |
|---|---|---|
| `SecurityException: Permission Denial: starting Intent { act=android.intent.action.CALL ... }` | Manifest 沒宣告 `CALL_PHONE`，或使用者拒絕後仍呼叫 | 補 `<uses-permission>`；`startActivity` 前先 `checkSelfPermission` |
| 按了按鈕完全沒反應 | `requestPermissions` 的 `requestCode` 與回呼比對的不一致 | 兩邊都使用 `PERMISSION_REQUEST_CALL_PHONE` |
| `onRequestPermissionsResult` 沒被呼叫 | 簽章打錯（參數型別、`@Override` 缺失） | 用 IDE「Generate → Override Methods」自動產生 |
| `ArrayIndexOutOfBoundsException` | 直接取 `grantResults[0]`，但陣列長度為 0 | 先判斷 `grantResults.length > 0` |
| 編譯過但 lint 標紅 `MissingPermission` | `ACTION_CALL` 前沒有權限檢查 | 在 `startActivity` 前加 `checkSelfPermission` 判斷 |
| 模擬器撥不出去 | 模擬器沒有電信服務（SIM） | 用實機測試；或先改用 `ACTION_DIAL` |
| 權限對話框不再出現 | 使用者勾了「不再詢問」 | 引導到系統設定開啟，或先說明為何需要此權限 |

### 5.8 驗收清單

| 操作 | 預期結果 |
|---|---|
| 首次按「撥號」 | 跳出「允許『系統功能』撥打電話嗎？」權限對話框 |
| 按「允許」 | 直接撥出 `0931117807`（實機） |
| 按「拒絕」 | Toast「需要電話權限才能直接撥打電話」，App 不崩潰 |
| 已授權後再按「撥號」 | 不再跳對話框，直接撥出 |
| 按「開啟網頁」 | 瀏覽器開啟 `https://24h.pchome.com.tw` |

> ✅ 記住判斷準則：**只是「帶號碼到撥號盤」→ `ACTION_DIAL`（免權限）；要「一鍵直接撥出」→ `ACTION_CALL` + 執行時期權限**。

---

# 第 5.5 章　常用系統互動畫面（選擇器家族）

> 放在第 5 章「Intent 的其它用法」之後，示範 Spinner、DatePickerDialog、TimePickerDialog、AlertDialog 單選、多選、PickVisualMedia、OpenDocument、TakePicture + FileProvider。

## 5.5.1 快速對照

| 需求 | 用法 | 章節 |
|---|---|---|
| 日期選擇 | `DatePickerDialog` | 5.5.4 |
| 時間選擇 | `TimePickerDialog` | 5.5.5 |
| 下拉選單 | `Spinner` + `ArrayAdapter` | 5.5.3 |
| 單選清單 | `AlertDialog.setSingleChoiceItems` | 5.5.6 |
| 多選清單 | `AlertDialog.setMultiChoiceItems` | 5.5.6 |
| 選圖 | `PickVisualMedia`（新版） | 5.5.7 |
| 選檔案 | `OpenDocument` | 5.5.8 |
| 拍照 | `TakePicture` + `FileProvider` | 5.5.9 |

> ⭐ 四合一完整 App：**5.5-1 預約表單**（Spinner + 日期 + 時間 + 單選）
> ⭐ 三合一完整 App：**5.5-2 個人頭像挑選**（選圖 + 選檔 + 拍照）

---

## 5.5.2 核心觀念：Activity Result API

現代 Android 用 **Activity Result API** 取代舊的 `startActivityForResult` + `onActivityResult`：

- 用「合約（Contract）」描述要做什麼，例如 `PickVisualMedia`、`OpenDocument`、`TakePicture`。
- 用 `registerForActivityResult(...)` 註冊一個 `ActivityResultLauncher`，結果會回到 callback。

> ⚠️ **最重要規則**：`registerForActivityResult(...)` **必須在生命週期進入 `RESUMED` 之前註冊**。
> 實務上就是在**欄位宣告**或 **`onCreate()`** 內建立。若在按鈕點擊事件裡才註冊，會拋出
> `IllegalStateException: LifecycleOwner ... is attempting to register while current state is RESUMED`。

```java
public class MainActivity extends AppCompatActivity {
    // 宣告成欄位 → 建構階段即完成註冊
    private final ActivityResultLauncher<PickVisualMediaRequest> pickMediaLauncher =
        registerForActivityResult(new ActivityResultContracts.PickVisualMedia(), uri -> {
            if (uri != null) { /* 使用 uri，例如 ivPhoto.setImageURI(uri); */ }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        // 按鈕只負責「啟動」，不負責「註冊」
        findViewById(R.id.btnPickImage).setOnClickListener(v ->
            pickMediaLauncher.launch(new PickVisualMediaRequest.Builder()
                .setMediaType(ActivityResultContracts.PickVisualMedia.ImageOnly.INSTANCE)
                .build()));
    }
}
```

> 記得 import `androidx.activity.result.PickVisualMediaRequest`。
> 上例的 `findViewById(R.id.btnPickImage)` 需要佈局中有對應 id；完整可執行版本見 5.5.7 節。

---

## 5.5.3 下拉選單：Spinner

### 用途

`Spinner` 是「下拉選單」（對照 Swing 的 `JComboBox`）。它本身**不存資料**，選項一樣交給 `ArrayAdapter` 提供。

### 佈局 `activity_main.xml`（片段）

```xml
<Spinner
    android:id="@+id/spPeople"
    android:layout_width="match_parent"
    android:layout_height="wrap_content" />
```

### 程式（放在 `onCreate` 內）

```java
Spinner spPeople = findViewById(R.id.spPeople);

String[] people = {"1 人", "2 人", "4 人", "6 人"};
ArrayAdapter<String> adapter = new ArrayAdapter<>(
        this,
        android.R.layout.simple_spinner_item,          // 收合時的樣子
        people);
adapter.setDropDownViewResource(
        android.R.layout.simple_spinner_dropdown_item); // 展開後每一列的樣子
spPeople.setAdapter(adapter);

// ⚠️ setSelection 一定要放在 setAdapter 之後，否則沒有資料可定位
spPeople.setSelection(1);   // 預設選第 2 項（索引從 0 開始）

// OnItemSelectedListener 有「兩個」方法 → 只能寫 anonymous class，不能用 lambda
spPeople.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        String selected = String.valueOf(parent.getItemAtPosition(position));
        Toast.makeText(MainActivity.this, "選了：" + selected, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {
        // 使用者沒有選任何項目時呼叫（很少用到，仍必須實作）
    }
});
```

**重點**：
- `simple_spinner_item` / `simple_spinner_dropdown_item` 都是系統內建佈局，不必自己寫 XML。
- `setSelection()` 必須在 `setAdapter()` **之後**；順序顛倒會無效。
- `OnItemSelectedListener` 是**兩個方法**的介面，不是 functional interface → **不能**用 lambda（與 Day 1 的結論一致）。
- `setAdapter()` 後系統會自動觸發一次 `onItemSelected`，這是正常現象；若只想在使用者真的操作時才做事，可加一個 `boolean isFirst = true` 的旗標略過第一次。

需要 import：

```java
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;
```

---

## 5.5.4 日期選擇：DatePickerDialog

### 用途

用系統內建的日期選擇對話框，回傳「年、月、日」。

### 佈局（片段）

```xml
<Button
    android:id="@+id/btnDate"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="選擇日期" />

<TextView
    android:id="@+id/tvDate"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="尚未選擇日期" />
```

### 程式（放在 `onCreate` 內）

```java
TextView tvDate = findViewById(R.id.tvDate);
Button btnDate = findViewById(R.id.btnDate);

// 用 Calendar 取得「今天」，當作對話框的預設值
Calendar calendar = Calendar.getInstance();
final int[] year  = {calendar.get(Calendar.YEAR)};
final int[] month = {calendar.get(Calendar.MONTH)};        // ⚠️ 0 = 一月
final int[] day   = {calendar.get(Calendar.DAY_OF_MONTH)};

btnDate.setOnClickListener(v -> {
    DatePickerDialog dialog = new DatePickerDialog(
            this,
            (view, y, m, d) -> {
                year[0] = y;
                month[0] = m;
                day[0] = d;
                // Calendar.MONTH 是 0 起始，顯示給人看要 +1；年份不用
                tvDate.setText(String.format(Locale.TAIWAN,
                        "日期：%04d/%02d/%02d", year[0], month[0] + 1, day[0]));
            },
            year[0], month[0], day[0]);
    dialog.show();
});
```

**重點**：
- `DatePickerDialog(this, listener, year, month, day)` 的 `month` 是 **0 起始**（0 = 一月、11 = 十二月），顯示時要 `+1`；**年份是西元年，不需要加減**。
- lambda 的三個參數 `(view, y, m, d)` 對應 `DatePickerDialog.OnDateSetListener.onDateSet(...)`。
- 上面用 `int[]` 而非 `int` 是為了讓 lambda 能修改外層變數（lambda 只能捕獲「有效 final」的區域變數）。

---

## 5.5.5 時間選擇：TimePickerDialog

### 佈局（片段）

```xml
<Button
    android:id="@+id/btnTime"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="選擇時間" />

<TextView
    android:id="@+id/tvTime"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="尚未選擇時間" />
```

### 程式（放在 `onCreate` 內）

```java
TextView tvTime = findViewById(R.id.tvTime);
Button btnTime = findViewById(R.id.btnTime);

Calendar calendar = Calendar.getInstance();
final int[] hour   = {calendar.get(Calendar.HOUR_OF_DAY)};  // 0~23
final int[] minute = {calendar.get(Calendar.MINUTE)};

btnTime.setOnClickListener(v -> {
    // 最後一個參數 true = 24 小時制；false = 12 小時制（AM/PM）
    TimePickerDialog dialog = new TimePickerDialog(
            this,
            (view, h, min) -> {
                hour[0] = h;
                minute[0] = min;
                tvTime.setText(String.format(Locale.TAIWAN,
                        "時間：%02d:%02d", hour[0], minute[0]));
            },
            hour[0], minute[0],
            true);
    dialog.show();
});
```

**重點**：
- `Calendar.HOUR_OF_DAY` 是 24 小時制（0~23）；若用 `Calendar.HOUR` 則為 12 小時制（0~11）。
- 最後一個參數 `true` 表示 24 小時制。
- 顯示格式用 `String.format("%02d:%02d", ...)` 可補零成 `09:05`。

---

## 5.5.6 單選 / 多選清單：AlertDialog

### 佈局（片段）

```xml
<Button
    android:id="@+id/btnSingle"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="單選：選擇餐點" />

<Button
    android:id="@+id/btnMulti"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="多選：選擇配料" />

<TextView
    android:id="@+id/tvChoice"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="尚未選擇" />
```

### 單選：`setSingleChoiceItems`

> 以下「單選」與「多選」兩段程式請接續放在同一個 `onCreate()` 內（共用同一個 `tvChoice`）。

```java
TextView tvChoice = findViewById(R.id.tvChoice);
Button btnSingle = findViewById(R.id.btnSingle);

final String[] meals = {"牛肉麵", "咖哩飯", "素食餐", "兒童餐"};

btnSingle.setOnClickListener(v -> {
    new AlertDialog.Builder(this)
            .setTitle("選擇餐點（單選）")
            .setSingleChoiceItems(meals, -1,          // -1 = 一開始都不選
                    (dialog, which) -> tvChoice.setText("餐點：" + meals[which]))
            .setPositiveButton("確定", null)          // 按確定才關閉
            .setNegativeButton("取消", null)
            .show();
});
```

**重點**：
- `setSingleChoiceItems(items, checkedItem, listener)`：點選項目只會**更新勾選狀態**，不會自動關閉；要按「確定」才關閉。
- `checkedItem` 傳 `-1` 表示預設不選；傳 `2` 表示預設勾選第 3 項。
- `setPositiveButton("確定", null)` 的 `null` 表示「按下就關閉，不需額外處理」；實際選到的值已經在 `listener` 中更新。

### 多選：`setMultiChoiceItems`

```java
Button btnMulti = findViewById(R.id.btnMulti);

final String[] toppings = {"起司", "培根", "蘑菇", "洋蔥", "鳳梨"};
final boolean[] checked = new boolean[toppings.length];   // 每一項的勾選狀態

btnMulti.setOnClickListener(v -> {
    new AlertDialog.Builder(this)
            .setTitle("選擇配料（多選）")
            .setMultiChoiceItems(toppings, checked,
                    (dialog, which, isChecked) -> checked[which] = isChecked)
            .setPositiveButton("確定", (dialog, which) -> {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < toppings.length; i++) {
                    if (checked[i]) sb.append(toppings[i]).append("、");
                }
                tvChoice.setText(sb.length() == 0
                        ? "未選擇配料"
                        : "配料：" + sb.substring(0, sb.length() - 1));
            })
            .setNegativeButton("取消", null)
            .show();
});
```

**重點**：
- `setMultiChoiceItems(items, checked, listener)`：第三個參數 lambda 有 **3 個參數** `(dialog, which, isChecked)`。
- `checked` 陣列要宣告在**點擊事件外面**（或欄位），否則每次開啟都會被重設；這裡因為要保留每次勾選結果，宣告在 `onCreate` 內、`setOnClickListener` 外。
- 按「取消」不會還原 `checked` 陣列；若需要「取消即還原」，可在開啟前先複製一份暫存陣列。

> 💡 `setSingleChoiceItems` / `setMultiChoiceItems` 的 listener 都是**單一抽象方法介面**（`DialogInterface.OnClickListener` / `OnMultiChoiceClickListener`），所以可以用 lambda。

---

## ⭐ 5.5-1　完整可直接執行範例：預約表單 App（四合一）

> 目的：把本節的 **Spinner + DatePickerDialog + TimePickerDialog + setSingleChoiceItems** 組成一支**可直接執行**的預約表單。
> 套件名：`com.example.formdemo`。共 2 支檔案：1 份 XML + 1 支 Java。

**Step 1 建立專案**：**New Project → Empty Views Activity**，Language **Java**，Package `com.example.formdemo`。

**Step 2 佈局 `activity_main.xml`**（整份取代）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="預約表單"
        android:textSize="24sp"
        android:textStyle="bold" />

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="20dp"
        android:text="用餐人數" />

    <Spinner
        android:id="@+id/spPeople"
        android:layout_width="match_parent"
        android:layout_height="wrap_content" />

    <Button
        android:id="@+id/btnDate"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="選擇日期" />

    <Button
        android:id="@+id/btnTime"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp"
        android:text="選擇時間" />

    <Button
        android:id="@+id/btnMeal"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp"
        android:text="選擇餐點" />

    <Button
        android:id="@+id/btnSubmit"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="送出預約" />

    <TextView
        android:id="@+id/tvSummary"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="20dp"
        android:textSize="18sp" />

</LinearLayout>
```

**Step 3 程式 `MainActivity.java`**（整份取代）：

```java
package com.example.formdemo;

import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import java.util.Calendar;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    private Spinner spPeople;
    private TextView tvSummary;

    // 目前選到的日期／時間（month 為 0 起始）
    private int year, month, day, hour, minute;
    private String meal = "尚未選擇";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        spPeople = findViewById(R.id.spPeople);
        tvSummary = findViewById(R.id.tvSummary);
        Button btnDate = findViewById(R.id.btnDate);
        Button btnTime = findViewById(R.id.btnTime);
        Button btnMeal = findViewById(R.id.btnMeal);
        Button btnSubmit = findViewById(R.id.btnSubmit);

        // 用「今天此刻」當預設值
        Calendar now = Calendar.getInstance();
        year = now.get(Calendar.YEAR);
        month = now.get(Calendar.MONTH);
        day = now.get(Calendar.DAY_OF_MONTH);
        hour = now.get(Calendar.HOUR_OF_DAY);
        minute = now.get(Calendar.MINUTE);

        // ---------- Spinner ----------
        String[] people = {"1 人", "2 人", "4 人", "6 人"};
        ArrayAdapter<String> peopleAdapter = new ArrayAdapter<>(
                this, android.R.layout.simple_spinner_item, people);
        peopleAdapter.setDropDownViewResource(
                android.R.layout.simple_spinner_dropdown_item);
        spPeople.setAdapter(peopleAdapter);

        // 兩個方法的介面 → 只能 anonymous class
        spPeople.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                updateSummary();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) { }
        });

        // setSelection 要在 setAdapter 之後
        spPeople.setSelection(1);

        // ---------- DatePickerDialog ----------
        btnDate.setOnClickListener(v -> new DatePickerDialog(
                this,
                (view, y, m, d) -> {
                    year = y;
                    month = m;
                    day = d;
                    updateSummary();
                },
                year, month, day).show());

        // ---------- TimePickerDialog ----------
        btnTime.setOnClickListener(v -> new TimePickerDialog(
                this,
                (view, h, min) -> {
                    hour = h;
                    minute = min;
                    updateSummary();
                },
                hour, minute,
                true).show());   // true = 24 小時制

        // ---------- 單選餐點 ----------
        btnMeal.setOnClickListener(v -> showMealDialog());

        // ---------- 送出 ----------
        btnSubmit.setOnClickListener(v ->
                Toast.makeText(this, tvSummary.getText(), Toast.LENGTH_LONG).show());

        updateSummary();
    }

    private void showMealDialog() {
        final String[] meals = {"牛肉麵", "咖哩飯", "素食餐", "兒童餐"};

        // 找出目前選項的索引，讓下次開啟時保持勾選
        int checked = -1;
        for (int i = 0; i < meals.length; i++) {
            if (meals[i].equals(meal)) {
                checked = i;
                break;
            }
        }

        new AlertDialog.Builder(this)
                .setTitle("選擇餐點（單選）")
                .setSingleChoiceItems(meals, checked, (dialog, which) -> {
                    meal = meals[which];
                    updateSummary();
                })
                .setPositiveButton("確定", null)
                .setNegativeButton("取消", null)
                .show();
    }

    private void updateSummary() {
        String summary = String.format(Locale.TAIWAN,
                "人數：%s\n日期：%04d/%02d/%02d\n時間：%02d:%02d\n餐點：%s",
                spPeople.getSelectedItem(),
                year, month + 1, day,      // month 是 0 起始，顯示要 +1
                hour, minute,
                meal);
        tvSummary.setText(summary);
    }
}
```

**Step 4 執行**：

| 操作 | 預期結果 |
|---|---|
| 啟動 App | 顯示預設人數「2 人」、今天日期、現在時間、餐點「尚未選擇」 |
| 展開人數下拉選單並選擇 | 下方摘要的人數同步更新 |
| 按「選擇日期」→ 選 2026/12/25 | 摘要顯示 `日期：2026/12/25` |
| 按「選擇時間」→ 選 18:30 | 摘要顯示 `時間：18:30` |
| 按「選擇餐點」→ 選「咖哩飯」→ 確定 | 摘要顯示 `餐點：咖哩飯` |
| 按「送出預約」 | 以 Toast 顯示完整摘要 |

> ✅ 這支範例同時驗證四個重點：`Spinner` 的 Adapter 與 `setSelection` 順序、`Calendar.MONTH` 要 `+1`、`TimePickerDialog` 的 24 小時制參數、`setSingleChoiceItems` 的「選取後按確定才關閉」。

---

## 5.5.7 選圖：PickVisualMedia（新版 Photo Picker）

### 用途

`PickVisualMedia` 是 Android 13（API 33）引入、並透過 AndroidX 向下支援的 **Photo Picker**。
使用者從系統挑選照片/影片，**App 不需要 `READ_MEDIA_IMAGES` 權限**。

### 環境需求

```gradle
dependencies {
    // 至少 1.7.0，建議 1.9.3 以上
    implementation "androidx.activity:activity:1.9.3"
}
```

### 完整程式碼（含舊機備援）

因 `registerForActivityResult` 必須在生命週期安全時註冊，**兩個 launcher 都要寫成欄位**，
點擊時再用 `isPhotoPickerAvailable` 決定啟動哪一個。

```java
package com.example.pickimagedemo;

import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.ImageView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.PickVisualMediaRequest;
import androidx.activity.result.contract.ActivityResultContracts.GetContent;
import androidx.activity.result.contract.ActivityResultContracts.PickVisualMedia;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private ImageView ivPhoto;

    // ① 新版 Photo Picker
    private final ActivityResultLauncher<PickVisualMediaRequest> pickMediaLauncher =
        registerForActivityResult(new PickVisualMedia(), uri -> {
            if (uri != null) ivPhoto.setImageURI(uri);
        });

    // ② 舊版備援（系統無 Photo Picker 時使用）
    private final ActivityResultLauncher<String> getContentLauncher =
        registerForActivityResult(new GetContent(), uri -> {
            if (uri != null) ivPhoto.setImageURI(uri);
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ivPhoto = findViewById(R.id.ivPhoto);
        Button btnPick = findViewById(R.id.btnPickImage);

        btnPick.setOnClickListener(v -> {
            if (PickVisualMedia.isPhotoPickerAvailable(this)) {
                pickMediaLauncher.launch(new PickVisualMediaRequest.Builder()
                    .setMediaType(PickVisualMedia.ImageOnly.INSTANCE)
                    .build());
            } else {
                getContentLauncher.launch("image/*");
            }
        });
    }
}
```

`activity_main.xml`：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="16dp">

    <Button
        android:id="@+id/btnPickImage"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="選一張圖片" />

    <ImageView
        android:id="@+id/ivPhoto"
        android:layout_width="220dp"
        android:layout_height="220dp"
        android:layout_marginTop="16dp"
        android:scaleType="centerCrop"
        android:background="#DDDDDD" />

</LinearLayout>
```

### 重點整理

| 項目 | 說明 |
|---|---|
| 合約 | `ActivityResultContracts.PickVisualMedia` |
| 啟動參數 | `PickVisualMediaRequest`（`ImageOnly` / `VideoOnly` / `ImageAndVideo`） |
| 回傳 | `Uri?`（未選取為 `null`） |
| 權限 | **不需要**讀取權限 |
| 備援 | `GetContent`（`"image/*"`） |
| 版本 | `androidx.activity:activity >= 1.7.0`（建議 1.9.3+） |

> 📌 版本註記：`PickVisualMedia.isPhotoPickerAvailable(Context)` 自 `activity 1.7.0` 起提供；**無參數版本已 deprecated**，請一律傳入 `Context`（範例中的 `this`）。

---

## 5.5.8 選檔案：OpenDocument

### 用途

`OpenDocument` 用於挑選**任意文件**（PDF、Word、圖片…），回傳可讀取的 `content://` Uri，
並可取得持久化存取權。

### 佈局 `activity_main.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp">

    <Button
        android:id="@+id/btnOpenDoc"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="選擇檔案（PDF / 圖片）" />

    <TextView
        android:id="@+id/tvFile"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="尚未選擇檔案"
        android:textSize="16sp" />

</LinearLayout>
```

### 完整程式碼

```java
package com.example.opendocdemo;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts.OpenDocument;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private TextView tvFile;

    // OpenDocument 的輸入型別是 String[]（MIME types）
    private final ActivityResultLauncher<String[]> openDocLauncher =
        registerForActivityResult(new OpenDocument(), uri -> {
            if (uri != null) {
                try {
                    // 取得持久化讀取權限；部分文件提供者不支援，失敗時忽略即可
                    getContentResolver().takePersistableUriPermission(
                        uri, Intent.FLAG_GRANT_READ_URI_PERMISSION);
                } catch (SecurityException e) {
                    e.printStackTrace();
                }
                tvFile.setText("已選擇：\n" + uri.toString());
            }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvFile = findViewById(R.id.tvFile);
        Button btnOpen = findViewById(R.id.btnOpenDoc);

        btnOpen.setOnClickListener(v ->
            openDocLauncher.launch(new String[]{"application/pdf", "image/*"}));
    }
}
```

### 重點整理

| 項目 | 說明 |
|---|---|
| 合約 | `ActivityResultContracts.OpenDocument` |
| 啟動參數 | `String[]`（MIME types，例如 `{"application/pdf"}`） |
| 回傳 | `Uri?`（未選取為 `null`） |
| 權限 | 不需權限；可選用 `takePersistableUriPermission` 持久化 |
| 常見 MIME | `application/pdf`、`image/*`、`text/plain`、`*/*` |

### PickVisualMedia 與 OpenDocument 的差異

| 比較 | PickVisualMedia | OpenDocument |
|---|---|---|
| 目的 | 挑照片/影片（媒體庫） | 挑任意文件 |
| 介面 | 系統 Photo Picker | 系統文件瀏覽器 |
| 輸入 | `PickVisualMediaRequest` | `String[]`（MIME） |
| 持久權限 | 由系統處理 | 可 `takePersistableUriPermission` |

---

## 5.5.9 拍照：TakePicture + FileProvider

### 步驟總覽

1. 建立 `res/xml/file_paths.xml`。
2. 在 `AndroidManifest.xml` 註冊 `<provider>`。
3. 建立暫存檔 → `FileProvider.getUriForFile` 取得 Uri → 啟動 `TakePicture`。
4. callback 用該 Uri 顯示圖片。

`res/xml/file_paths.xml`：

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- 對應 getExternalFilesDir(Environment.DIRECTORY_PICTURES) -->
    <external-files-path name="my_images" path="Pictures/" />
</paths>
```

`AndroidManifest.xml`：

```xml
<application ...>

    <provider
        android:name="androidx.core.content.FileProvider"
        android:authorities="com.example.takepicturedemo.fileprovider"
        android:exported="false"
        android:grantUriPermissions="true">
        <meta-data
            android:name="android.support.FILE_PROVIDER_PATHS"
            android:resource="@xml/file_paths" />
    </provider>

</application>
```

> ⚠️ `android:authorities` 必須與程式碼中 `FileProvider.getUriForFile(..., "此字串", ...)` **完全一致**，
> 否則會拋 `IllegalArgumentException: Failed to find configured root`。

### 佈局 `activity_main.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="16dp">

    <Button
        android:id="@+id/btnTakePhoto"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="拍照" />

    <ImageView
        android:id="@+id/ivPhoto"
        android:layout_width="220dp"
        android:layout_height="220dp"
        android:layout_marginTop="16dp"
        android:scaleType="centerCrop"
        android:background="#DDDDDD" />

</LinearLayout>
```

### 完整程式碼

```java
package com.example.takepicturedemo;

import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts.TakePicture;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;

import java.io.File;

public class MainActivity extends AppCompatActivity {

    private ImageView ivPhoto;
    private Uri pendingPhotoUri;   // 拍照要寫入的目標 Uri

    private final ActivityResultLauncher<Uri> takePictureLauncher =
        registerForActivityResult(new TakePicture(), success -> {
            if (success && pendingPhotoUri != null) {
                ivPhoto.setImageURI(pendingPhotoUri);
            } else {
                Toast.makeText(this, "未拍照或已取消", Toast.LENGTH_SHORT).show();
            }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ivPhoto = findViewById(R.id.ivPhoto);
        Button btnTake = findViewById(R.id.btnTakePhoto);

        btnTake.setOnClickListener(v -> {
            File dir = getExternalFilesDir(Environment.DIRECTORY_PICTURES);
            if (dir == null) {                       // 外部儲存空間可能不可用
                Toast.makeText(this, "找不到可儲存的圖片目錄", Toast.LENGTH_SHORT).show();
                return;
            }
            try {
                File photoFile = File.createTempFile("IMG_", ".jpg", dir);

                pendingPhotoUri = FileProvider.getUriForFile(
                    this,
                    "com.example.takepicturedemo.fileprovider",
                    photoFile);

                takePictureLauncher.launch(pendingPhotoUri);
            } catch (Exception e) {
                e.printStackTrace();
                Toast.makeText(this, "開啟相機失敗：" + e.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
    }
}
```

### 重點整理

| 項目 | 說明 |
|---|---|
| 合約 | `ActivityResultContracts.TakePicture` |
| 啟動參數 | `Uri`（照片輸出位置） |
| 回傳 | `boolean`（`true` 表拍照成功） |
| 必要設定 | `FileProvider` + `res/xml/file_paths.xml` |
| 一致性 | `android:authorities` ↔ `getUriForFile` 的 authorities |
| 存檔位置 | `getExternalFilesDir(Environment.DIRECTORY_PICTURES)` |

---

## ⭐ 5.5-2　完整可直接執行範例：個人頭像挑選 App（選圖 / 選檔 / 拍照三合一）

> 目的：把 5.5.7～5.5.9 的三個選擇器整合成一支**可直接執行**的 App。
> 套件名：`com.example.mediapickerdemo`。共 3 支檔案：1 份 XML、1 支 Java、1 份 `file_paths.xml`；另需在 `AndroidManifest.xml` 註冊 provider。

**Step 1 建立專案**：**New Project → Empty Views Activity**，Language **Java**，Package `com.example.mediapickerdemo`。

**Step 2 建立 `res/xml/file_paths.xml`**（內容與 5.5.9 相同）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-files-path name="my_images" path="Pictures/" />
</paths>
```

**Step 3 在 `AndroidManifest.xml` 註冊 FileProvider**（`authorities` 要改成這個專案的套件名）：

```xml
<provider
    android:name="androidx.core.content.FileProvider"
    android:authorities="com.example.mediapickerdemo.fileprovider"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/file_paths" />
</provider>
```

**Step 4 佈局 `activity_main.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center_horizontal"
    android:padding="16dp">

    <Button
        android:id="@+id/btnPickImage"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="選一張圖片" />

    <Button
        android:id="@+id/btnOpenDoc"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp"
        android:text="選擇檔案（PDF / 圖片）" />

    <Button
        android:id="@+id/btnTakePhoto"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp"
        android:text="拍照" />

    <ImageView
        android:id="@+id/ivPhoto"
        android:layout_width="220dp"
        android:layout_height="220dp"
        android:layout_marginTop="16dp"
        android:scaleType="centerCrop"
        android:background="#DDDDDD" />

    <TextView
        android:id="@+id/tvFile"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:text="尚未選擇檔案"
        android:textSize="14sp" />

</LinearLayout>
```

**Step 5 程式 `MainActivity.java`**（整份取代）：

```java
package com.example.mediapickerdemo;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.PickVisualMediaRequest;
import androidx.activity.result.contract.ActivityResultContracts.GetContent;
import androidx.activity.result.contract.ActivityResultContracts.OpenDocument;
import androidx.activity.result.contract.ActivityResultContracts.PickVisualMedia;
import androidx.activity.result.contract.ActivityResultContracts.TakePicture;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;

import java.io.File;

public class MainActivity extends AppCompatActivity {

    private ImageView ivPhoto;
    private TextView tvFile;
    private Uri pendingPhotoUri;

    private final ActivityResultLauncher<PickVisualMediaRequest> pickMediaLauncher =
        registerForActivityResult(new PickVisualMedia(), uri -> {
            if (uri != null) ivPhoto.setImageURI(uri);
        });

    private final ActivityResultLauncher<String> getContentLauncher =
        registerForActivityResult(new GetContent(), uri -> {
            if (uri != null) ivPhoto.setImageURI(uri);
        });

    private final ActivityResultLauncher<String[]> openDocLauncher =
        registerForActivityResult(new OpenDocument(), uri -> {
            if (uri != null) {
                try {
                    getContentResolver().takePersistableUriPermission(
                        uri, Intent.FLAG_GRANT_READ_URI_PERMISSION);
                } catch (SecurityException e) {
                    e.printStackTrace();
                }
                tvFile.setText("已選擇檔案：\n" + uri);
            }
        });

    private final ActivityResultLauncher<Uri> takePictureLauncher =
        registerForActivityResult(new TakePicture(), success -> {
            if (success && pendingPhotoUri != null) {
                ivPhoto.setImageURI(pendingPhotoUri);
            } else {
                Toast.makeText(this, "未拍照或已取消", Toast.LENGTH_SHORT).show();
            }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ivPhoto = findViewById(R.id.ivPhoto);
        tvFile  = findViewById(R.id.tvFile);

        findViewById(R.id.btnPickImage).setOnClickListener(v -> {
            if (PickVisualMedia.isPhotoPickerAvailable(this)) {
                pickMediaLauncher.launch(new PickVisualMediaRequest.Builder()
                    .setMediaType(PickVisualMedia.ImageOnly.INSTANCE).build());
            } else {
                getContentLauncher.launch("image/*");
            }
        });

        findViewById(R.id.btnOpenDoc).setOnClickListener(v ->
            openDocLauncher.launch(new String[]{"application/pdf", "image/*"}));

        findViewById(R.id.btnTakePhoto).setOnClickListener(v -> takePhoto());
    }

    private void takePhoto() {
        File dir = getExternalFilesDir(Environment.DIRECTORY_PICTURES);
        if (dir == null) {
            Toast.makeText(this, "找不到可儲存的圖片目錄", Toast.LENGTH_SHORT).show();
            return;
        }
        try {
            File photoFile = File.createTempFile("IMG_", ".jpg", dir);
            pendingPhotoUri = FileProvider.getUriForFile(
                this, "com.example.mediapickerdemo.fileprovider", photoFile);
            takePictureLauncher.launch(pendingPhotoUri);
        } catch (Exception e) {
            e.printStackTrace();
            Toast.makeText(this, "開啟相機失敗：" + e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }
}
```

> ✅ 三個 launcher 全部宣告成**欄位**，這是避免 `IllegalStateException` 的關鍵。
> 選圖在 Android 13+ 會開系統 Photo Picker，舊機自動退回 `GetContent`；選檔會顯示 `content://` Uri；拍照成功會直接把照片顯示在 `ImageView`。

---

## 5.5.10 常見錯誤排查表

| 症狀 | 可能原因 | 解法 |
|---|---|---|
| `IllegalStateException: register while RESUMED` | 在點擊事件內才註冊 launcher | 改為欄位宣告或於 `onCreate` 註冊 |
| `Failed to find configured root` | `file_paths.xml` 沒對應目錄 | 補上正確的 `<external-files-path>` 等標籤 |
| `IllegalArgumentException`（拍照） | authorities 不一致 | Manifest 與 `getUriForFile` 字串需完全相同 |
| 選不到圖片 | 裝置無 Photo Picker 且未做備援 | 用 `isPhotoPickerAvailable` 切換 `GetContent` |
| 重開 App 讀不到檔案 | 未取持久化權限 | 呼叫 `takePersistableUriPermission` |
| `FileUriExposedException` | 直接使用 `Uri.fromFile` | 改用 `FileProvider.getUriForFile` |

---

## 5.5.11 驗收清單

- [ ] 選圖按鈕：Android 13+ 顯示系統 Photo Picker，舊機種自動退回 `GetContent`
- [ ] 選檔案按鈕：可挑 PDF / 圖片，並顯示 `content://` Uri
- [ ] 拍照按鈕：相機開啟、拍完照片顯示於 `ImageView`
- [ ] `file_paths.xml` 與 `AndroidManifest.xml` 的 provider 設定正確
- [ ] 無任何 `IllegalStateException` / `FileUriExposedException`

---

# 第 6 章　列表顯示：ListView + ArrayAdapter



> ⚡ **對照**：ListView 類似 JList / JComboBox 的選項清單，但 Android 用 **Adapter** 串接資料與畫面。

### 6.1 在 XML 加入 ListView
```xml
<ListView
    android:id="@+id/listView"
    android:layout_width="match_parent"
    android:layout_height="match_parent" />
```

**說明**：在佈局放一支 `ListView`（捲動清單容器）。
- `@+id/listView`：給它一個 id，方便 Java 用 `findViewById(R.id.listView)` 抓出來。
- `match_parent`：讓它佔滿可用空間。名符其實後續就靠 Java 幫它「填空」。
- `ListView` 本身**只負責顯示與捲動**，並不直接存放資料——資料交給 `ArrayAdapter` 管理（見 6.2）。

### 6.2 用 ArrayAdapter 顯示文字陣列

```java
ListView listView = findViewById(R.id.listView);

String[] items = {"蘋果", "香蕉", "柳橙", "葡萄"};

ArrayAdapter<String> adapter = new ArrayAdapter<>(
        this,
        android.R.layout.simple_list_item_1,  // 內建單行樣式
        items);

listView.setAdapter(adapter);

// 點擊事件
listView.setOnItemClickListener((parent, view, position, id) -> {
    String selected = items[position];
    Toast.makeText(this, "你選了：" + selected, Toast.LENGTH_SHORT).show();
});
```

**逐段說明**：
- `ListView listView = findViewById(R.id.listView);`：抓出佈局裡的 ListView。
- `String[] items = {...};`：準備**資料**（一支字串陣列）。
- `new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, items);`：用 `ArrayAdapter` 把「字串陣列」變成「每列一個文字」的模型。
  - `this`：目前的畫面（Context）。
  - `android.R.layout.simple_list_item_1`：Android **內建**的「單行文字」版面樣式，不必自己寫 XML。
  - `items`：要顯示的資料來源。
- `listView.setAdapter(adapter);`：**把 Adapter 接上 ListView**。ListView 就會依照 Adapter 提供的資料逐列渲染——這是「資料 ↔ 畫面」的關鍵一步。
- `listView.setOnItemClickListener((parent, view, position, id) -> {...})`：為每一列掛點擊事件。
  - 4 個參數一一對應介面方法的 `parent`（ListView）、`view`（被點的那一列）、`position`（第幾列，從 0 起）、`id`（列 id）。
  - `items[position]`：用位置取出對應資料，`Toast` 顯示「你選了：…」。

> ⚡ 對照 Swing：`setAdapter` 很像 `JList.setModel(...)`；`ArrayAdapter` ≈「資料 + ListCellRenderer」的合體，決定「放進去的資料 + 每列長相」。

**Lambda 對照**：這裡的 lambda 有 **4 個參數**，與 `onItemClick(AdapterView<?> parent, View view, int position, long id)` 一一對應：

```java
// 等價的傳統寫法
listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        String selected = items[position];
        Toast.makeText(MainActivity.this, "你選了：" + selected, Toast.LENGTH_SHORT).show();
    }
});

// lambda 版本：參數型別可省略，但「參數個數與順序」必須完整對應
// 即使某個參數用不到，也要保留（可命名為 unused），不能只寫需要的幾個
listView.setOnItemClickListener((parent, view, position, id) ->
        Toast.makeText(this, "你選了：" + items[position], Toast.LENGTH_SHORT).show());
```

**說明**：匿名類別版要寫完整的方法簽名與參數型別（`AdapterView<?>`、`View`、`int`、`long`）；lambda 版則**省略型別、只留參數名**，但**參數個數與順序仍必須跟介面方法完全一致**——不能因為某個參數用不到就省略它。

> 重點：**參數個數與順序必須跟介面方法一致**，只是型別（`AdapterView<?>`、`View`、`int`、`long`）可以省略不寫。

# 第 7 章　顯示列表：RecyclerView（常用進階）

ListView 較舊、效能不佳。現代 App 用 **RecyclerView**（需要 ViewHolder，較多程式碼但彈性大）。

RecyclerView 步驟較多（6 步），稍後在範例中完整示範：

1. XML 加入 `<RecyclerView>`
2. 建立**單列佈局** `row_item.xml`
3. 建立 **ViewHolder** class
4. 建立 **Adapter** class（繼承 `RecyclerView.Adapter`)
5. 主程式設定 LayoutManager + setAdapter
6. **ItemTouchHelper** 可做滑動刪除（Day 3 範例用）

> 建議：Day 2 先用 ListView 熟概念，Day 3 範例再用 RecyclerView，兩者 Model-Adapter 思維一致。

---

# 第 8 章　資料容器：ArrayList（取代陣列）

`ArrayList` 可動態增刪、方便與 `ArrayAdapter` 搭配，是清單 App 的主角。

```java
ArrayList<String> todoList = new ArrayList<>();
todoList.add("寫 Day2 筆記");
todoList.add("練習 Intent");
```

**說明**：
- `ArrayList<String> todoList = new ArrayList<>();`：建立一個「只能放 String」的動態清單。`<>`（菱形）從右邊推斷型別。它不像固定陣列需先宣告長度，可無限增刪。
- `todoList.add("寫 Day2 筆記");`：**新增一筆**到清單尾巴。
- 用法與 Java 完全相同；Android 只是把它當成 Adapter 的資料來源，改動後要「通知畫面刷新」才看得到變化。

搭配 `ArrayAdapter` + `notifyDataSetChanged()` 更新畫面：

> ⚡ 這就像 Swing 的 `DefaultListModel.add()` 後自動更新，但 Android 要手動呼叫 `notifyDataSetChanged()`。

> 💡 完整的 `ArrayList + ListView + ArrayAdapter + AlertDialog` 執行範例就在下方「⭐ 第 8 章　完整範例」。

---

## ⭐ 第 8 章　完整可直接執行範例：可增刪的待辦清單 App

> 目的：把 `ArrayList`、`ArrayAdapter`、`notifyDataSetChanged()` 以及第 9 章的 `AlertDialog` 濃縮成一支**可直接執行**的小 App。
> 畫面：上方輸入框 +「新增」鈕，下方 `ListView` 列出清單；**長按某一列 → AlertDialog 確認後刪除**。
> 套件名：`com.example.arraydemo`。共 2 支檔案：1 份 XML + 1 支 Java。

**Step 1 建立專案**：**New Project → Empty Views Activity**，Language **Java**，Package `com.example.arraydemo`。

**Step 2 佈局 `activity_main.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="待辦清單（ArrayList 示範）"
        android:textSize="22sp"
        android:textStyle="bold" />

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:orientation="horizontal">

        <EditText
            android:id="@+id/etInput"
            android:layout_width="0dp"
            android:layout_weight="1"
            android:layout_height="wrap_content"
            android:hint="輸入待辦事項" />

        <Button
            android:id="@+id/btnAdd"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="新增" />
    </LinearLayout>

    <ListView
        android:id="@+id/listView"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:layout_marginTop="16dp" />

</LinearLayout>
```

**佈局說明**：
- 外層是垂直 `LinearLayout`：標題 → 水平列（輸入框+新增鈕）→ `ListView`。
- 內層那支 `LinearLayout` 設 `orientation="horizontal"`，把「輸入框」與「新增」按鈕**並排**。
  - `EditText` 設 `layout_width="0dp"` + `layout_weight="1"`：`weight=1` 表示「把剩餘空間全吃下」→ 輸入框**自動撐滿**剩餘寬度，而按鈕只需 `wrap_content`。這是「weight 分配寬度」的常見寫法。
- `ListView` 設 `layout_height="0dp"` + `layout_weight="1"`：垂直方向同樣用 weight 讓它**填滿下方剩餘空間**並可捲動。

**Step 3 程式 `MainActivity.java`**：

```java
package com.example.arraydemo;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private ArrayList<String> data;
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 資料容器：用 ArrayList 取代固定陣列
        data = new ArrayList<>();
        data.add("寫 Day2 筆記");
        data.add("練習 Intent");
        data.add("學會 ArrayList");

        // Adapter：把資料串接到畫面（第 6 章）
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, data);
        ListView listView = findViewById(R.id.listView);
        listView.setAdapter(adapter);

        EditText etInput = findViewById(R.id.etInput);
        Button btnAdd = findViewById(R.id.btnAdd);

        // 新增：加進 ArrayList → 通知畫面重繪
        btnAdd.setOnClickListener(v -> {
            String text = etInput.getText().toString().trim();
            if (text.isEmpty()) {
                Toast.makeText(this, "請先輸入文字", Toast.LENGTH_SHORT).show();
                return;
            }
            data.add(text);                // 加入 ArrayList
            adapter.notifyDataSetChanged(); // 通知畫面重新繪製
            etInput.setText("");           // 清空輸入框
        });

        // 長按某一列 → AlertDialog 確認後移除（第 9 章）
        listView.setOnItemLongClickListener((parent, view, position, id) -> {
            String item = data.get(position);
            new AlertDialog.Builder(this)
                    .setTitle("確認刪除")
                    .setMessage("確定要刪除「" + item + "」嗎？")
                    .setPositiveButton("確定", (dialog, which) -> {
                        data.remove(position);
                        adapter.notifyDataSetChanged();
                    })
                    .setNegativeButton("取消", null)
                    .show();
            return true;   // 已處理長按事件
        });
    }
}
```

**程式說明（重點：資料與畫面的「連結」）**：
- `private ArrayList<String> data;` 與 `private ArrayAdapter<String> adapter;`：宣告為**類別欄位**，因為新增、刪除的回呼都需要動到它們，不能只放在 `onCreate` 的區域變數。
- `data = new ArrayList<>();` + 三個 `data.add(...)`：建立預設 3 筆待辦。
- `adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, data);`：**ArrayAdapter 以 `data` 這支 ArrayList 當資料來源**。注意傳的是 `data`（同一份物件），所以之後 `data.add/remove` 就會同步反映到 adapter。
- `listView.setAdapter(adapter);`：接上 ListView。
- **新增**（`btnAdd` 點擊）：
  - `etInput.getText().toString().trim()` 拿輸入文字。
  - `if (text.isEmpty()) { Toast...; return; }`：空白就提示並 `return`，防呆。
  - `data.add(text);`：**往容器加資料**。
  - `adapter.notifyDataSetChanged();`：**關鍵！** 主動通知 ListView「資料變了，請重新繪製」，這樣新的一列才會出現在畫面上。
  - `etInput.setText("");`：清空輸入框，方便連續輸入。
- **長按刪除**（`setOnItemLongClickListener`）：
  - lambda 4 參數中取出 `position`，`data.get(position)` 拿到該列資料文字。
  - 用 `AlertDialog.Builder` 組宣告「確定要刪除…？」的對話框（第 9 章）。
  - `setPositiveButton("確定", ...)` 裡：`data.remove(position);` 接著 `adapter.notifyDataSetChanged();`——**先從容器移除，再通知畫面重繪**。
  - `return true;`：表示「這個長按事件我已處理」，避免系統再做預設動作。

> 記憶口訣：**「改容器 → notifyDataSetChanged()」**。不管新增或刪除，只要動了 ArrayList，最後都要呼叫 `notifyDataSetChanged()` 畫面才會更新。

**Step 4 執行**：
| 操作 | 預期結果 |
|---|---|
| 啟動 App | 列出 3 筆預設待辦 |
| 輸入「買牛奶」→ 按「新增」 | 清單下方多出「買牛奶」 |
| 輸入空白 → 按「新增」 | 跳出 Toast「請先輸入文字」，不會新增 |
| 長按某一列 | 跳出「確認刪除」AlertDialog |
| 按「確定」| 該列從清單消失；按「取消」則保留 |

> ✅ 這正是「可增刪的動態清單」。關鍵程式就三行：`data.add(...)`、`data.remove(...)`、`adapter.notifyDataSetChanged()`。
> 第 10 章「待辦事項 Todo App」是把同樣的 `ArrayList`+`ArrayAdapter` 思維再加上點擊處理、完整包裝成一支正式小專案，可一併參考。

> ⚡ 對照 Swing：Android 的 `notifyDataSetChanged()` ≈ Swing `DefaultListModel` 改動後自動觸發，差別在 Android 需要**手動**呼叫來更新畫面。

---

# 第 9 章　Dialog：AlertDialog（取代 JOptionPane 彈窗）

```java
new AlertDialog.Builder(this)
        .setTitle("確認")
        .setMessage("確定要刪除嗎？")
        .setPositiveButton("確定", (dialog, which) -> {
            // 按確定時
        })
        .setNegativeButton("取消", null)
        .show();
```

**逐行說明（Builder 流式寫法，每一行串在下一個）**：
- `new AlertDialog.Builder(this)`：建立一個「對話框建造者」，`this` 是要依附的畫面 Context。
- `.setTitle("確認")`：設定對話框標題。
- `.setMessage("確定要刪除嗎？")`：設定對話框正文訊息。
- `.setPositiveButton("確定", (dialog, which) -> { ... })`：加「確定」按鈕。第二參數是點擊時的回呼（lambda），可在花括號裡寫「按確定要做的事」。
  - 回呼收到兩個參數：`dialog`（該對話框）、`which`（哪顆按鈕被按）。
- `.setNegativeButton("取消", null)`：加「取消」鈕。第二參數給 `null` 表示「不做任何事，按下即關閉」。
- `.show()`：最後呼叫 `show()` 才真正把對話框**彈出來**。前面的方法都是「組裝」，`show()` 是「展示」。

> ⚡ 對照：`AlertDialog.Builder` ≈ Swing 的 `JOptionPane`（含按鈕、訊息），但 Android 用流式 API 一步步「組裝」對話框再秀出。

**Lambda 對照**：`setPositiveButton` 的第二個參數是 `DialogInterface.OnClickListener`（單一方法 `onClick(DialogInterface dialog, int which)`），所以可用 lambda：

```java
// 等價的傳統寫法
new AlertDialog.Builder(this)
        .setTitle("確認")
        .setMessage("確定要刪除嗎？")
        .setPositiveButton("確定", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                // 按確定時
            }
        })
        .setNegativeButton("取消", null)   // null = 按下後直接關閉，不做任何事
        .show();

// lambda 版本：兩個參數 (dialog, which)，用不到的參數仍要保留
.setPositiveButton("確定", (d, w) -> {
    // 按確定時
})
```

> 💡 AlertDialog 的完整實際使用見 **第 10 章「待辦事項 Todo App」**（點列確認刪除）與 **第 12 章「顏色選擇器」**。

---

# 第 10 章　完整範例一：待辦事項 Todo App（ListView + ArrayAdapter）

> 完整可編譯的兩支檔案。套件名範例：`com.example.todoapp`。

### 10-1 功能需求

- 一個 `EditText` + `Button` 新增待辦
- 一個 `ListView` 顯示清單
- 點擊待辦項目 → `AlertDialog` 確認後刪除
- 資料存在 `ArrayList`（記憶體，**重開 App 會消失**）
- Day 3 將改用資料庫持久化，讓重開 App 後資料還在

### 10-2 步驟

**Step 1 建立專案**：**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.todoapp`。

**Step 2 替換 `activity_main.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal">

        <EditText
            android:id="@+id/etTodo"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:hint="輸入待辦事項" />

        <Button
            android:id="@+id/btnAdd"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="新增" />
    </LinearLayout>

    <ListView
        android:id="@+id/listView"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:layout_marginTop="16dp" />
</LinearLayout>
```

**佈局說明**：
- 外層垂直 `LinearLayout`，內層水平 `LinearLayout` 放「輸入框 + 新增鈕」。
- `EditText`（`etTodo`）用 `layout_width="0dp"` + `layout_weight="1"`：把水平剩餘空間全部讓給輸入框，按鈕只佔 `wrap_content` 寬度。
- `ListView`（`listView`）用 `layout_height="0dp"` + `layout_weight="1"` 佔滿下方剩餘空間，負責捲動顯示待辦；這是垂直 `LinearLayout` 中「填滿剩餘高度」的標準寫法。

> 預期結果：上方水平排列「輸入框 + 新增鈕」，下方整片 ListView。

**Step 3 替換 `MainActivity.java`**：

```java
package com.example.todoapp;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private final ArrayList<String> todoList = new ArrayList<>();
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EditText etTodo = findViewById(R.id.etTodo);
        Button btnAdd = findViewById(R.id.btnAdd);
        ListView listView = findViewById(R.id.listView);

        // ArrayAdapter：把 ArrayList 的每一筆資料變成 ListView 的一列
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, todoList);
        listView.setAdapter(adapter);

        // 新增（lambda 對照：即 new View.OnClickListener(){ onClick() { ... } }）
        btnAdd.setOnClickListener(v -> {
            String text = etTodo.getText().toString().trim();
            if (text.isEmpty()) {
                Toast.makeText(this, "請輸入待辦內容", Toast.LENGTH_SHORT).show();
                return;
            }
            todoList.add(text);
            adapter.notifyDataSetChanged();   // 通知 ListView 重新繪製
            etTodo.setText("");
        });

        // 點擊列 → AlertDialog 確認刪除（lambda 對照：setOnItemClickListener 有 4 參數）
        listView.setOnItemClickListener((parent, view, position, id) -> {
            String item = todoList.get(position);
            new AlertDialog.Builder(this)
                    .setTitle("刪除")
                    .setMessage("確定要刪除「" + item + "」嗎？")
                    .setPositiveButton("刪除", (dialog, which) -> {
                        todoList.remove(position);
                        adapter.notifyDataSetChanged();
                    })
                    .setNegativeButton("取消", null)
                    .show();
        });
    }
}
```

**程式說明**：
- `import androidx.appcompat.app.AlertDialog;`：與第 8、9 章統一使用 **AppCompat 版本**，能搭配 `AppCompatActivity` 的 Material 主題；不要混用 `android.app.AlertDialog`，以免外觀不一致或遇到主題相容問題。
- `private final ArrayList<String> todoList = new ArrayList<>();`：**直接在宣告時建立**待辦容器，`final` 表示「這個變數參照不換」，內容仍可增刪。
- `adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, todoList);`：以 `todoList` 當資料來源建立 Adapter，再 `listView.setAdapter(adapter)` 接上畫面。
- **新增**（`btnAdd`）：
  - 檢查輸入是否空白 → 是則 Toast 提示並 `return`。
  - `todoList.add(text);` 塞資料；`adapter.notifyDataSetChanged();` 通知畫面重繪；`etTodo.setText("")` 清空輸入框。
- **點擊列刪除**（`setOnItemClickListener`，4 參數 lambda）：
  - `todoList.get(position)` 取出該列文字當作對話框訊息。
  - `setPositiveButton("刪除", ...)` 裡 `todoList.remove(position);` 後 `adapter.notifyDataSetChanged();`。
  - 思路與第 8 章 arraydemo 一模一樣，差異只在：這支用**點擊**列觸發刪除，arraydemo 用**長按**。

> ✅ 完整示範「資料 ⇄ Adapter ⇄ ListView」三者的協作，以及點擊列 → AlertDialog → 移除 → 重繪的完整流程。

### 10-3 執行與驗證

1. Run
2. 輸入「買牛奶」→ 新增 → 列表出現「買牛奶」
3. 再新增「寫作業」→ 兩列並排顯示
4. 點「買牛奶」→ 跳出確認對話框 → 按「刪除」→ 該列消失
5. 對焦新增：按「新增」但內容空白 → 出現 Toast

> ✅ 完成。驗證重點：Adapter 讓資料與畫面同步、點擊列刪除。
> 💡 提醒：資料只存在 `ArrayList`（記憶體）。**把 App 滑掉重開，資料會不見**——這就是 Day 3 要解決的「持久化」。

---

# 第 11 章　完整範例二：商品編輯傳值（Intent + putExtra/getExtra）

> 套件名範例：`com.example.shopapp`
> 用到技能：多個 Activity、Intent 跳轉、`putExtra` / `getStringExtra`、new Activity 自動註冊
> 目的：練習「畫面 A 開畫面 B，B 回傳資料給 A 顯示」。

### 11-1 功能需求

- 畫面 A（MainActivity）：顯示一個商品，點「編輯」跳去畫面 B
- 畫面 B（EditActivity）：可修改商品名稱與價格
- 畫面 B 按「儲存」，把資料 **putExtra** 傳回 A 並顯示

### 11-2 步驟

**Step 1 建立專案**：**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.shopapp`。

**Step 2 新增第二個 Activity（畫面 B）**：在套件資料夾右鍵：**New → Activity → Empty Views Activity**，名稱 `EditActivity`。自動產生 `EditActivity.java` 與 `activity_edit.xml`，並已在 `AndroidManifest.xml` 註冊。

> ☝️ 若你看到 Android Studio 下方的 Activity 範本選單，選最簡單的 Empty Views Activity 即可。

**Step 3 畫面 A 的佈局 `activity_main.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp">

    <TextView
        android:id="@+id/tvInfo"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="商品：手機 / 價格：9999"
        android:textSize="18sp" />

    <Button
        android:id="@+id/btnEdit"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="編輯商品" />

</LinearLayout>
```

**佈局說明（畫面 A）**：
- `tvInfo`：顯示「目前商品」的資訊文字（初始值「商品：手機 / 價格：9999」，之後被 Java 更新）。
- `btnEdit`：跳到畫面 B 的按鈕。
- 很簡單：一支顯示字 + 一支按鈕，沒有輸入框。

**Step 4 畫面 B 的佈局 `activity_edit.xml`**（直接取代精靈產生的）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp">

    <EditText
        android:id="@+id/etName"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="商品名稱" />

    <EditText
        android:id="@+id/etPrice"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:hint="價格"
        android:inputType="number" />

    <Button
        android:id="@+id/btnSave"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="儲存並返回" />

</LinearLayout>
```

**佈局說明（畫面 B）**：
- 兩支 `EditText`：`etName`（商品名稱）、`etPrice`（價格，`inputType="number"` 限制只能輸數字）。
- `btnSave`（"儲存並返回"）：把修改結果傳回 A。
- 這支範例展示了「A 傳值給 B 讓它初始化欄位，B 改完傳回給 A」的雙向溝通過程。

**Step 5 畫面 A 的程式 `MainActivity.java`**：

```java
package com.example.shopapp;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private TextView tvInfo;
    private String goodsName = "手機";
    private String goodsPrice = "9999";

    // 用來接收 EditActivity 回傳結果的 launcher（新版 Result API）
    // 宣告成欄位 → 在 Activity 進入 RESUMED 之前完成註冊
    private final ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            result -> {
                if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                    String name = result.getData().getStringExtra("name");
                    String price = result.getData().getStringExtra("price");
                    if (name != null) goodsName = name;
                    if (price != null) goodsPrice = price;
                    tvInfo.setText("商品：" + goodsName + " / 價格：" + goodsPrice);
                }
            });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvInfo = findViewById(R.id.tvInfo);
        Button btnEdit = findViewById(R.id.btnEdit);

        btnEdit.setOnClickListener(v -> openEdit());
    }

    private void openEdit() {
        Intent intent = new Intent(MainActivity.this, EditActivity.class);
        // 可把目前資料帶過去，讓編輯頁有初始值
        intent.putExtra("name", goodsName);
        intent.putExtra("price", goodsPrice);
        resultLauncher.launch(intent);
    }
}
```

**程式說明（畫面 A，示範新版 Result API 完整用法）**：
- 欄位 `goodsName = "手機"`、`goodsPrice = "9999"`：**App 目前的「來源資料」**，用字串暫存（也可用物件，此處簡化）。
- `btnEdit.setOnClickListener(v -> openEdit());`：點「編輯商品」呼叫 `openEdit()`。
- `private final ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(...)`：**註冊一個「等結果」的啟動器**（新版 API）：
  - **宣告成欄位**：確保在 Activity 進入 `RESUMED` 之前完成註冊，這是最安全也最推薦的寫法。
  - `new ActivityResultContracts.StartActivityForResult()`：指定等「啟動 Activity 收回傳」這類合約。
  - `result -> {...}`：**lambda 回呼**，B 關閉回傳時自動執行。
  - 回呼裡用 `result.getResultCode() == RESULT_OK` 判斷成功、`result.getData() != null` 判斷有資料；成功就取出 `name`、`price`（先檢查非 `null`）更新 `goodsName/goodsPrice` 並刷新 `tvInfo`。
- `openEdit()`：
  - 建立到 `EditActivity` 的 Intent。
  - `intent.putExtra("name", goodsName); intent.putExtra("price", goodsPrice);`：**把目前資料帶過去**，讓 B 的欄位有初始值（見 Step 6 的 `getStringExtra`）。
  - `resultLauncher.launch(intent);`：用已註冊的 launcher 啟動並等結果。

> 💡 註冊 launcher 的位置只有一個原則：**必須在 Activity 進入 `RESUMED` 之前**。寫成欄位（如本範例）或在 `onCreate()` 內註冊都可以；**不能**寫在按鈕點擊事件裡。

**Step 6 畫面 B 的程式 `EditActivity.java`**：

```java
package com.example.shopapp;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class EditActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit);

        EditText etName = findViewById(R.id.etName);
        EditText etPrice = findViewById(R.id.etPrice);
        Button btnSave = findViewById(R.id.btnSave);

        // 接收從 MainActivity 傳來的資料（第二參數是預設值）
        String name = getIntent().getStringExtra("name");
        String price = getIntent().getStringExtra("price");
        if (name != null) etName.setText(name);
        if (price != null) etPrice.setText(price);

        btnSave.setOnClickListener(v -> {
            String newName = etName.getText().toString().trim();
            String newPrice = etPrice.getText().toString().trim();

            if (newName.isEmpty() || newPrice.isEmpty()) {
                Toast.makeText(this, "請填寫完整", Toast.LENGTH_SHORT).show();
                return;
            }

            // 打包要回傳的資料
            Intent data = new Intent();
            data.putExtra("name", newName);
            data.putExtra("price", newPrice);
            setResult(RESULT_OK, data);   // 設定結果
            finish();                     // 關閉畫面 B，回畫面 A
        });
    }
}
```

**程式說明（畫面 B）**：
- `getIntent().getStringExtra("name")` 與 `getStringExtra("price")`：**接收 A 帶過來的初始值**；`if (x != null) etX.setText(x)`：只有拿得到才塞進欄位（沒拿到就保持空框）。
- `btnSave` 點擊時：
  - 取 `etName`、`etPrice` 的文字並 `trim`。
  - `if (newName.isEmpty() || newPrice.isEmpty())`：任一空白就 Toast「請填寫完整」並 `return`（不儲存）。
  - `Intent data = new Intent();` 空意圖當行李袋。
  - `data.putExtra("name", newName); data.putExtra("price", newPrice);` 塞進新的值。
  - `setResult(RESULT_OK, data);` 設定成功結果；`finish();` 關 B 回 A，A 的 `resultLauncher` 回呼便自動收到這些值。

> 🔑 完整「A→B 帶初值、B→A 回修改」閉環：A `putExtra` 送出 → B `getStringExtra` 初始化 → B 改完 `putExtra` → `setResult`+`finish` → A 的 `result` 回呼更新顯示。

**Step 7 執行與驗證**：

1. Run，畫面 A 顯示「商品：手機 / 價格：9999」
2. 按「編輯商品」→ 跳去畫面 B，欄位已帶入「手機」「9999」
3. 改成「平板」「12900」→ 按「儲存並返回」
4. 回到畫面 A，顯示「商品：平板 / 價格：12900」✓

> ✅ 完成。你已練習：Intent 跳轉、雙向傳值（A→B、B→A）、setResult/finish。

### 11-3 兩種接收結果寫法的對照

| 寫法 | 適用 | 備註 |
|---|---|---|
| `registerForActivityResult(...)` | **新版推薦** | 用 lambda `result -> {...}`，本範例使用 |
| 舊 `onActivityResult(...)` | 較舊專案 | 是方法覆寫，**不能**用 lambda |

> 第 4 章教的 `onActivityResult` 是舊寫法；本範例用的是新版 Result API，兩者概念相同。

---

# 第 12 章　完整範例三：顏色選擇器（RecyclerView + Adapter + Intent 回傳）

> 套件名範例：`com.example.colorpick`
> 用到技能：多個 Activity、Intent 跳轉、RecyclerView + Adapter、`putExtra`/`getExtra` 回傳
> 目的：把 Day 2 的「列表 + 跳轉 + 回傳」三個重點一次練完整。

### 12-1 功能需求

- 畫面 A：顯示目前選中的顏色名稱與色塊，按「選顏色」跳去畫面 B
- 畫面 B：用 **RecyclerView** 顯示一串現成顏色，點某一列 → 把該顏色名稱與色碼回傳給 A
- 畫面 A 收到後更新顯示

### 12-2 步驟

**Step 1 建立專案**：**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.colorpick`。

接著新增畫面 B：右鍵套件 → **New → Activity → Empty Views Activity**，名稱 `ColorListActivity`。

在 `app/build.gradle` 加入 recyclerview 依賴（如果專案未預設包含）：

```groovy
dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.recyclerview:recyclerview:1.3.0'
}
```

**說明**：`app/build.gradle` 用 `implementation` 宣告專案要**引用外部函式庫**（Maven 套件）。
- `androidx.appcompat`：提供與 Android 新舊版本相容的 API（必備基底）。
- `material`：Material Design 元件。
- `androidx.recyclerview`：**本範例的重點**——`RecyclerView` 依賴。沒加這行就無法 import RecyclerView。
- 改完記得按 **Sync Now**，Android Studio 才會下載並編譯這些依賴。

按 **Sync Now**。

**Step 2 畫面 A 佈局 `activity_main.xml`**：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="目前選色："
        android:textSize="18sp" />

    <View
        android:id="@+id/colorBlock"
        android:layout_width="match_parent"
        android:layout_height="80dp"
        android:layout_marginTop="8dp"
        android:background="#888888" />

    <TextView
        android:id="@+id/tvName"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp"
        android:text="尚未選擇"
        android:textSize="20sp" />

    <Button
        android:id="@+id/btnPick"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="選擇顏色" />

</LinearLayout>
```

**佈局說明（畫面 A）**：
- 依序：「目前選色：」標籤 → 色塊 → 顏色名稱 → 「選擇顏色」按鈕。
- `<View android:id="@+id/colorBlock" ... android:background="#888888" />`：`View` 標籤可當「純色方塊」；`android:background="#888888"` 是十六進位灰色，之後被 Java 改成選中的顏色。
- `tvName`：顯示顏色名稱文字（初始「尚未選擇」）。
- `btnPick`：跳去選色頁的按鈕。

> `View` 標籤可用來畫一個純色方塊（這裡當色塊）。`android:background="#888888"` 是十六進位顏色。

**Step 3 單列佈局 `row_color.xml`**（右鍵 `res/layout` → **New → Layout Resource File**，名稱 `row_color`）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:gravity="center_vertical"
    android:padding="16dp">

    <View
        android:id="@+id/swatch"
        android:layout_width="40dp"
        android:layout_height="40dp" />

    <TextView
        android:id="@+id/tvColorName"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="16dp"
        android:textSize="18sp" />

</LinearLayout>
```

**佈局說明（`row_color.xml`＝RecyclerView「單列」的藍圖）**：
- 這是**每一列**的長相：水平排列，左邊一個 `swatch` 色塊（40dp×40dp），右邊 `tvColorName` 顯示顏色名稱。
- `gravity="center_vertical"`：讓色塊與文字垂直對齊。
- RecyclerView 會依 Adapter 提供的資料**不斷重複套用這個佈局**來建立每一列（見 Step 5 的 `onCreateViewHolder`）。

**Step 4 資料模型 `ColorData.java`**（右鍵套件 → **New → Java Class**，名稱 `ColorData`）：

```java
package com.example.colorpick;

public class ColorData {
    public final String name;      // 顏色名稱
    public final String hex;       // 十六進位色碼，例如 #FF0000

    public ColorData(String name, String hex) {
        this.name = name;
        this.hex = hex;
    }
}
```

**程式說明（資料模型）**：
- `ColorData` 是「一支顏色」的**資料模型**：有 `name`（名稱）與 `hex`（色碼）兩個欄位。
- `final` 表示欄位建立後不可改——只讀資料，簡單又安全。
- 建構子 `ColorData(String name, String hex)` 用來「塞初始值」，例如 `new ColorData("紅色", "#FF0000")`。
- 這不是 Activity，不會顯示畫面，只負責**裝資料**，方便 Adapter 取用。

**Step 5 Adapter `ColorAdapter.java`**：

```java
package com.example.colorpick;

import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

// 單一方法介面 → Functional interface，可用 lambda
interface OnColorClick {
    void onColorClick(ColorData color);
}

public class ColorAdapter extends RecyclerView.Adapter<ColorAdapter.ColorViewHolder> {

    private final List<ColorData> colors;
    private final OnColorClick listener;

    public ColorAdapter(List<ColorData> colors, OnColorClick listener) {
        this.colors = colors;
        this.listener = listener;
    }

    @NonNull
    @Override
    public ColorViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.row_color, parent, false);
        return new ColorViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ColorViewHolder holder, int position) {
        ColorData color = colors.get(position);
        holder.tvName.setText(color.name);
        holder.swatch.setBackgroundColor(Color.parseColor(color.hex));

        // 單一方法介面 → lambda
        holder.itemView.setOnClickListener(v -> listener.onColorClick(color));
    }

    @Override
    public int getItemCount() {
        return colors.size();
    }

    static class ColorViewHolder extends RecyclerView.ViewHolder {
        View swatch;
        TextView tvName;

        ColorViewHolder(@NonNull View itemView) {
            super(itemView);
            swatch = itemView.findViewById(R.id.swatch);
            tvName = itemView.findViewById(R.id.tvColorName);
        }
    }
}
```

**程式說明（RecyclerView Adapter，重點）**：
- `interface OnColorClick { void onColorClick(ColorData color); }`：自訂的**單一抽象方法介面**，只有一個方法 → **functional interface**，因此能當 lambda 用（見 Step 7/8）。把「點到某色」的行為抽出來，讓畫面 (Activity) 決定要做什麼。
- `class ColorAdapter extends RecyclerView.Adapter<ColorAdapter.ColorViewHolder>`：Adapter 泛型指向自己定義的 `ColorViewHolder`。
- 欄位 `colors`（資料清單）、`listener`（點擊回呼），透過建構子注入。
- `onCreateViewHolder(...)`：**第一次要顯示某列「模板」時**呼叫——用 `LayoutInflater` 把單列佈局 `row_color` 轉成一個 `View`，再包成 `ColorViewHolder`。
  - `inflate(R.layout.row_color, parent, false)`：把 XML 佈局「變成 View 物件」；`parent` 是父容器、`false` 表示不立即掛上（交由 RecyclerView 管理）。
- `onBindViewHolder(holder, position)`：**每一列要顯示時**呼叫，把 `colors.get(position)` 的資料「綁」到該列的 ViewHolder 上。
  - `holder.tvName.setText(color.name);` 顯示名稱。
  - `holder.swatch.setBackgroundColor(Color.parseColor(color.hex));` 把色碼轉成顏色設定到色塊背景。
  - `holder.itemView.setOnClickListener(v -> listener.onColorClick(color));` 為這一列掛點擊，點下就呼叫 `listener`（lambda）。
- `getItemCount()`：回傳總共幾列（`colors.size()`）。
- `static class ColorViewHolder extends RecyclerView.ViewHolder`：**緩衝**每一列的內部元件參照（`swatch`、`tvName`），避免每次重新 `findViewById`，這是 RecyclerView 高效的主因。

> `OnColorClick` 只有一個方法，所以是 functional interface，可以用 lambda（見 Step 7 用法）。

**Step 6 畫面 B `activity_color_list.xml`**（取代精靈產生的）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="8dp">

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/recyclerView"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />

</LinearLayout>
```

**佈局說明（畫面 B）**：
- 整個畫面只有一個 `androidx.recyclerview.widget.RecyclerView`（id `recyclerView`），佔滿畫面。
- **注意**：XML 只放「容器」，存放的「每一列長相」由 `row_color.xml` 決定，排放的「方向」由 Java 的 LayoutManager 決定。三者分工清楚。

**Step 7 畫面 A 程式 `MainActivity.java`**：

```java
package com.example.colorpick;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private View colorBlock;
    private TextView tvName;

    // 新版 Result API：宣告成欄位，在進入 RESUMED 前完成註冊
    private final ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            result -> {
                if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                    String name = result.getData().getStringExtra("name");
                    String hex = result.getData().getStringExtra("hex");
                    if (name != null && hex != null) {
                        colorBlock.setBackgroundColor(Color.parseColor(hex));
                        tvName.setText(name + "  (" + hex + ")");
                    }
                }
            });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        colorBlock = findViewById(R.id.colorBlock);
        tvName = findViewById(R.id.tvName);
        Button btnPick = findViewById(R.id.btnPick);

        btnPick.setOnClickListener(v ->
                resultLauncher.launch(new Intent(MainActivity.this, ColorListActivity.class)));
    }
}
```

**程式說明（畫面 A）**：
- `resultLauncher`（新版 Result API）：**註冊「等選色頁回傳」的啟動器**。回呼裡收到 `name`、`hex` 後：
  - `colorBlock.setBackgroundColor(Color.parseColor(hex));` 把色塊背景換成選中的顏色。
  - `tvName.setText(name + "  (" + hex + ")");` 顯示「紅色 (#FF0000)」。
- `btnPick.setOnClickListener(v -> resultLauncher.launch(...))`：點「選擇顏色」就用 `resultLauncher` 啟動 `ColorListActivity` 並等它回傳。

**Step 8 畫面 B 程式 `ColorListActivity.java`**：

```java
package com.example.colorpick;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;

public class ColorListActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_color_list);

        // 準備資料清單
        List<ColorData> colors = new ArrayList<>();
        colors.add(new ColorData("紅色", "#FF0000"));
        colors.add(new ColorData("綠色", "#00FF00"));
        colors.add(new ColorData("藍色", "#0000FF"));
        colors.add(new ColorData("黃色", "#FFFF00"));
        colors.add(new ColorData("橘色", "#FFA500"));
        colors.add(new ColorData("黑色", "#000000"));

        RecyclerView recyclerView = findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        // 單一方法介面 → lambda：點到哪個顏色就把資料回傳並關閉
        ColorAdapter adapter = new ColorAdapter(colors, color -> {
            Intent data = new Intent();
            data.putExtra("name", color.name);
            data.putExtra("hex", color.hex);
            setResult(RESULT_OK, data);
            finish();
        });
        recyclerView.setAdapter(adapter);
    }
}
```

**程式說明（畫面 B，RecyclerView 三要素 + lambda 回傳）**：
- `List<ColorData> colors = new ArrayList<>();` + 6 個 `add(...)`：準備**資料**——六種顏色，每個 `ColorData` 含 `name` + `hex`。
- `recyclerView.setLayoutManager(new LinearLayoutManager(this));`：**設定方向**——`LinearLayoutManager` 表示「垂直直列」排放（等同 ListView 的習慣）。
- `new ColorAdapter(colors, color -> {...})`：建立 Adapter，第二參數 `color -> {...}` 就是 `OnColorClick` 的 **lambda 實作**（因為它是單一方法介面）。
  - lambda 收到被點的那支 `ColorData color`。
  - `Intent data = new Intent();` 空袋 → `putExtra("name", color.name); putExtra("hex", color.hex);` 塞入選色 → `setResult(RESULT_OK, data); finish();` 回傳並關閉 B。
- `recyclerView.setAdapter(adapter);`：把 Adapter 接上 RecyclerView，列表便依資料開始顯示。

> 本範例重點是「點列 → setResult + finish 回 A」。

**Step 9 執行與驗證**：

1. Run，畫面 A 顯示灰色塊與「尚未選擇」
2. 按「選擇顏色」→ 畫面 B 列出 6 種顏色
3. 點「紅色」→ 回到 A，色塊變紅，文字變「紅色 (#FF0000)」✓

> ✅ 完成。你已一口氣練習：RecyclerView + Adapter、單一方法介面 lambda、Intent 跳轉、雙向傳值、setResult/finish。

**可練習擴充**：改成畫面 B 同時顯示名稱與色碼、用 `RadioButton` 開頭直接給訂一組預設色、把選色結果存進 SharedPreferences。

---

# 第 13 章　自我測驗與解答

先自己作答，再看解答。有些題目沒有唯一答案，參考解答即可。

## Day 2 測驗題

1. `startActivity(intent)` 和 `startActivityForResult(intent, code)` 差別在哪？
2. `getIntExtra("age", 0)` 的第二個參數 `0` 是什麼意思？
3. `onActivityResult` 的 `requestCode` 與 `resultCode` 分別代表什麼？
4. Adapter 在 ListView 中扮演什麼角色？對照 Swing 是哪個元件？
5. 為什麼用 RecyclerView 取代 ListView？RecyclerView 哪個步驟最容易忘記？
6. `onActivityResult(...)` 為什麼「不能」寫成 lambda？那 `setOnClickListener(v -> ...)` 為什麼可以？
7. `ActivityResultLauncher` 為何不能在按鈕的點擊事件裡才建立？寫在 `onCreate()` 可以嗎？
8. 改了 `ArrayList` 資料後，不呼叫 `notifyDataSetChanged()` 會怎樣？
9. 「選圖」與「選檔案」分別該用哪個 API？什麼情況該選用哪一個？
10. 使用 `FileProvider` 拍照時，`AndroidManifest.xml` 的 `authorities` 與程式碼哪一處必須一致？
11. 用 `DatePickerDialog` 取得的月份為何要 `+1`？年份需要嗎？
12. 用 `Spinner` 顯示預設選項時，`setSelection()` 該放在 `setAdapter()` 之前還是之後？為什麼？

### Day 2 測驗解答

**1. `startActivity(intent)` 和 `startActivityForResult(intent, code)` 差別在哪？**

- `startActivity`：啟動新畫面，不去等待結果（fire-and-forget）。
- `startActivityForResult`：啟動新畫面並等待該畫面透過 `setResult` 回傳資料，結果在 `onActivityResult` 接收。更新的 API 是 `Activity Result API`（`registerForActivityResult`）。

**2. `getIntExtra("age", 0)` 的第二個參數 `0` 是什麼意思？**

- 預設值（default value）。若 Intent 中找不到 `"age"` 這個 key（例如沒傳、型別不符），就回傳 `0`，避免 null 崩潰。

**3. `onActivityResult` 的 `requestCode` 與 `resultCode` 分別代表什麼？**

- `requestCode`：發送端自己給的辨識碼（例如 `1001`），用來區分是哪一次跳轉的回應。
- `resultCode`：接收端用 `setResult(RESULT_OK, ...)` / `RESULT_CANCELED` 回應的結果狀態。

**4. Adapter 在 ListView 中扮演什麼角色？對照 Swing 是哪個元件？**

- Adapter 是資料與 UI 之間的橋樑。它把資料項目（陣列/List/Cursor）轉成畫面列的 View（並可做重複使用的效能優化）。類似 Swing 的 `ListModel` + `ListCellRenderer`。

**5. 為什麼用 RecyclerView 取代 ListView？RecyclerView 哪個步驟最容易忘記？**

- RecyclerView 有 ViewHolder 回收機制與 LayoutManager，捲動效能更好（只建立可見項目的 View）；內建動畫、多種佈局（Linear/Grid/Staggered），官方建議使用。
- **最易忘記：`setLayoutManager()`**（忘了列表顯示空白，但不會崩潰）。

**6. `onActivityResult(...)` 為什麼「不能」寫成 lambda？那 `setOnClickListener(v -> ...)` 為什麼可以？**

- `onActivityResult(...)` 是 Activity 類別裡**已經定義好**的方法，你用 `@Override` 去「覆寫」它。Lambda 只能用來實現「尚未被實現的單一抽象方法介面」，不能用來覆寫既有方法，所以只能寫方法簽名 + 大括號。
- `setOnClickListener` 收的是 `View.OnClickListener` 介面，它**只有一個抽象方法** `onClick(View)`，是 functional interface，所以可用 `v -> {...}` 直接當成該介面的實作。
- 判斷準則：**要覆寫既有方法 → 只能寫方法；要實作單一方法的介面 → 可用 lambda**。

**7. `ActivityResultLauncher` 為何不能在按鈕的點擊事件裡才建立？寫在 `onCreate()` 可以嗎？**

- `registerForActivityResult` 必須在 Activity 進入 `STARTED`／`RESUMED` 生命週期狀態**之前**完成註冊。按鈕被點擊時 Activity 早已在 `RESUMED`，此時才註冊會拋出 `IllegalStateException: LifecycleOwner ... is attempting to register while current state is RESUMED`。
- 寫在 `onCreate()` **可以**（此時狀態還是 `CREATED`）；官方最推薦寫成**類別欄位**，在 `onCreate` 之前就完成註冊，最不容易出錯。

**8. 改了 `ArrayList` 資料後，不呼叫 `notifyDataSetChanged()` 會怎樣？**

- 資料已改，但 UI **不更新**（畫面仍顯示舊資料）。不會崩潰，但會是視覺 bug。

**9. 「選圖」與「選檔案」分別該用哪個 API？什麼情況該選用哪一個？**

- **選圖**：用 `ActivityResultContracts.PickVisualMedia`（系統相片選擇器）。只挑照片／影片時用它，體驗最原生、免權限。
- **選檔案**：用 `ActivityResultContracts.OpenDocument`（可指定任意 MIME，如 `application/pdf`、`*/*`）。要挑非媒體檔（PDF、Word、任意文件）時用它；需要長期存取時再 `takePersistableUriPermission`。

**10. 使用 `FileProvider` 拍照時，`AndroidManifest.xml` 的 `authorities` 與程式碼哪一處必須一致？**

- 必須與 `FileProvider.getUriForFile(context, authorities, file)` 的第二個參數（authorities 字串）**完全一致**，慣例是 `<套件名>.fileprovider`；不一致會在執行期拋 `IllegalArgumentException: Couldn't find meta-data for provider`。

**11. 用 `DatePickerDialog` 取得的月份為何要 `+1`？年份需要嗎？**

- `DatePickerDialog`／`Calendar.MONTH` 的月份是 **0 起始**（0 = 一月、11 = 十二月），顯示給人看時要 `+1`；年份是正常的西元年，**不需**加減。

**12. 用 `Spinner` 顯示預設選項時，`setSelection()` 該放在 `setAdapter()` 之前還是之後？為什麼？**

- 要放在 `setAdapter()` **之後**。`Spinner` 必須先有 Adapter（資料）才能定位到指定索引；在 `setAdapter()` 之前呼叫 `setSelection()` 會因資料尚未綁定而無效。

---

# 本日小結

今天你完成了：

- 用 `Intent` 啟動新 Activity、畫面間 `putExtra`/`getExtra` 傳值
- 回傳結果給前一畫面（新版 `registerForActivityResult` + 舊 `startActivityForResult` 對照）
- 系統功能 Intent（撥號、開網頁）
- 第 5.5 章：常用系統互動畫面——`Spinner`、`DatePickerDialog`、`TimePickerDialog`、`setSingleChoiceItems`、`PickVisualMedia`（選圖）、`OpenDocument`（選檔）、`TakePicture` + `FileProvider`（拍照）
- `ListView` + `ArrayAdapter` 顯示列表
- `RecyclerView` + ViewHolder + Adapter（進階列表）
- `ArrayList` 動態資料容器（搭配 `notifyDataSetChanged()`）
- `AlertDialog` 彈窗
- 五支**直接在章節內可執行**的小範例：**兩頁面跳轉**（第 2 章）、**A→B 傳值**（第 3 章）、**A↔B 回傳結果**（第 4 章）、**系統功能（撥號／網頁／簡訊／Email／分享／地圖／設定頁）**（第 5 章）、**預約表單**（5.5-1）
- 五支可編譯的完整整合範例：**預約表單**（5.5-1）、**個人頭像挑選**（5.5-2）、**待辦事項 Todo App**（第 10 章）、**商品編輯傳值**（第 11 章）、**顏色選擇器**（第 12 章）

明天（Day 3）將學習用 SharedPreferences、檔案、SQLite/Room 把資料「永久存起來」。

> 相關延伸閱讀：`Appendix_B_Lambda.md`（Lambda 對照）、`Appendix_G_Lifecycle.md`（生命週期）、`Appendix_H_Swing_vs_Android.md`（JFrame→Android 對照）。

