# Day 1 合併版 — 環境建置與基礎：建立你的第一個 Android App

> 本檔是 **Day 1 一天的完整教材**，將原分散的「教學 + 範例 + 測驗」整合為一個可一次讀完的文件。
> 對象：具備 Java 程式開發經驗，熟悉 JFrame 視窗程式開發。
> 路徑：**Java + XML 佈局** + **資料庫 / 檔案存取**。
> 時間：約 6–8 小時。
> 與 JFrame 的對照會用 ⚡ 標記。

---

# 第 0 章　為什麼從 JFrame 遷移到 Android 不會太難

如果你熟悉 Swing/JFrame，你會發現 Android 的元件導向思維是共通的：

| JFrame 概念 | Android 對應 | 說明 |
|---|---|---|
| `JFrame`（主視窗） | `Activity` | 一個畫面 = 一個 Activity |
| `JButton` / `JTextField` / `JLabel` | `Button` / `EditText` / `TextView` | UI 元件（View） |
| `setLayout(...)` + 元件定位 | `XML 佈局` + LayoutManager | 宣告式佈局描述 |
| `addActionListener(...)` | `setOnClickListener(...)` | 事件監聽 |
| `JPanel`（容器） | `LinearLayout` / `RelativeLayout` / `FrameLayout` | 容器 ViewGroup |
| 自訂 class 存資料 | `SQLite / Room`、`SharedPreferences` | 資料持久化 |

> 關鍵差異：**佈局改為宣告式 XML**，且 Android 有完整的**生命週期 (Lifecycle)** 概念，
> 這是與 JFrame 最大的不同（JFrame 沒有「被系統回收再重建」的機制）。

### 先備知識清單（你應該已具備）

- ✅ Java 基本語法（類別、方法、變數、迴圈、if/else）
- ✅ 繼承、介面、Listener 事件模型
- ✅ 建立 GUI 元件與佈局的觀念
- ✅ (加分) 基本 SQL 語法（SELECT / INSERT / UPDATE / DELETE）

### 第一個小提醒（JFrame 使用者最容易犯的錯）

```java
// ❌ 錯誤：JFrame 習慣直接 new 元件之後去找
// Android 的元件必須「先寫在 XML」，再在程式用 findViewById 綁定

// ✅ 正確寫法（本章會學到）
TextView tvTitle = findViewById(R.id.tvTitle);
Button btnSubmit = findViewById(R.id.btnSubmit);
btnSubmit.setOnClickListener(v -> {
    tvTitle.setText("你按了按鈕");
});
```

**逐行說明**：
- `TextView tvTitle = findViewById(R.id.tvTitle);`：**從 XML 佈局中「找到」元件並綁定**。`R.id.tvTitle` 是 Android 為你在 `activity_main.xml` 裡 `@+id/tvTitle` 自動產生的資源代號。`findViewById` 回傳的型別是 `View`，需指定「目標型別」`TextView` 才能呼叫 `setText` 等方法。
- `Button btnSubmit = findViewById(R.id.btnSubmit);`：同上，綁定按鈕。
- `btnSubmit.setOnClickListener(v -> { tvTitle.setText("你按了按鈕"); });`：**掛上「點擊事件」**。`v` 是事件參數（這裡用不到）；按下按鈕後執行 `tvTitle.setText(...)` 改文字的內容。
- 重點：在 Android「**先有 XML 才有元件**」，程式只是拿參考 + 綁事件，不能像 Swing 一樣 `new JButton` 後自己加進畫面。

> Android **沒有 `new JButton("文字")` 這種寫法**。文字通常先在 XML 設定，程式只負責「取得參考 + 綁定事件」。

順帶一提：上面的 `v -> { ... }` 是 **lambda**（Java 8+）。它的原本面貌跟你熟悉的 Swing 完全一樣：

```java
// 兩種寫法完全等價：
// 傳統（跟你 Swing 的 addActionListener 一模一樣）
btnSubmit.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        tvTitle.setText("你按了按鈕");
    }
});

// lambda（只需要設定文字時，一行也行）
btnSubmit.setOnClickListener(v -> tvTitle.setText("你按了按鈕"));
```

**逐行說明（傳統寫法）**：
- `new View.OnClickListener() { ... }`：建立一個**匿名類別**（anonymous class）——`View.OnClickListener` 是一個介面，用 `new` + 實作來建立。
- `@Override public void onClick(View v)`：**覆寫**介面的唯一抽象方法 `onClick`，裡面寫按下後要做的事。
- 這跟你熟悉的 Swing `addActionListener(new ActionListener() { ... })` 結構**完全一樣**。

**lambda 寫法**：
- `v -> tvTitle.setText("你按了按鈕")`：因為 `View.OnClickListener` **只有一個抽象方法**（functional interface），可用 lambda 縮寫。`v` 是方法的參數，`->` 後面是方法內容，一行時可省略 `{}`。
- **兩者完全等價**，just 文法不同。

### 後續怎麼準備環境？

在開始 Day 1 之前，請先安裝：

1. **Android Studio**（官方 IDE，建議下載最新穩定版）→ https://developer.android.com/studio
2. 安裝時勾選 **Android Virtual Device (AVD)** 建立模擬器
3. 不需要實體手機也能學（用模擬器即可）

---

# 第 1 章　安裝環境

### 1.1 安裝 Android Studio

下載最新穩定版：https://developer.android.com/studio

安裝步驟（以 Windows 為例）：
1. 執行安裝程式，安裝到預設位置即可
2. 安裝元件如超過 500MB，耐心等待完成
3. 第一次啟動會下載 **SDK (Software Development Kit)**，這就是 Android 版的 JDK+工具鏈

> Android Studio 基於 IntelliJ IDEA，如果你用過 IntelliJ / Eclipse 會很快上手。

### 1.2 建立虛擬裝置 (Emulator)

Android Studio 頂部工具列 → **Device Manager** → **Create device**
1. 選一台手機型號（建議 Pixel 系列）
2. 下載一個 System Image（例如 API 34 的 Android 14）
3. 完成後點 ▶ 啟動模擬器

> ⚡ **對照**：模擬器就像是你在本機跑的 Java 虛擬機 (JVM)，但它是完整的手機系統。

---

# 第 2 章　建立第一個專案

1. **File → New → New Project**
2. 選 **Empty Views Activity**（注意：不是 Compose，因為我們用 XML）
3. Project name：`MyFirstApp`，Language 選 **Java**，Minimum SDK 選 API 24 以上

---

# 第 3 章　Android 專案結構（對照 JFrame 專案）

| 資料夾 / 檔案 | 用途 | JFrame 對照 |
|---|---|---|
| `app/src/main/java/...` | Java 原始碼 | `src/` |
| `app/src/main/res/layout/activity_main.xml` | 畫面佈局 | `setContentPane(...)` + 拉元件 |
| `app/src/main/res/values/strings.xml` | 字串資源 | 硬編碼字串（建議資源化） |
| `app/src/main/AndroidManifest.xml` | 宣告 Activity、權限 | 沒有直接對照（類似設定檔） |
| `app/build.gradle` | 專案設定 / 依賴 | `pom.xml` / `build.gradle` |

> 最重要的一點：**Android 的畫面 (UI) 預設用 XML 描述，Java 程式只做邏輯與綁定。**
> 建立專案的詳細精靈步驟可參見 `Appendix_A_Project_Creation.md`。

---

# 第 4 章　第一個畫面：activity_main.xml

開啟 `res/layout/activity_main.xml`，這是預設畫面。切到 **Code** 標籤，輸入：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <TextView
        android:id="@+id/tvTitle"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="我的第一個 App"
        android:textSize="24sp"
        android:textStyle="bold" />

    <EditText
        android:id="@+id/etInput"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="請輸入文字" />

    <Button
        android:id="@+id/btnShow"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="顯示輸入" />

    <TextView
        android:id="@+id/tvResult"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="結果："
        android:textSize="18sp" />

</LinearLayout>
```

**佈局說明（activity_main.xml＝第一支畫面佈局）**：

**根元素 `<LinearLayout>`**（容器）：
- `xmlns:android`：宣告 Android 命名空間，之後所有 `android:` 開頭屬性都要用它。
- `android:orientation="vertical"`：**垂直排列**——子元件由上到下依序堆疊。
- `android:layout_width/height="match_parent"`：填滿父容器（整個畫面）。
- `android:padding="16dp"`：四邊留 16dp 內距，讓內容不要貼邊。

**四個子元件（由上看下）**：
1. `tvTitle`（標題）：`layout_width="wrap_content"`（寬度只包住文字內容）、文字 24sp 加粗。
2. `etInput`（輸入框）：`match_parent` 佔滿寬度；`android:hint="請輸入文字"` 是在空方框內顯示的灰色提示（不是真正的文字）。
3. `btnShow`（按鈕）：`match_parent` 佔滿寬度，顯示「顯示輸入」。
4. `tvResult`（結果文字）：`wrap_content`，初始顯示「結果：」。

> 這些 `@+id/xxx` 就是程式裡 `findViewById(R.id.xxx)` 抓的 id，名字必須對得上。

### 4.1 理解 LinearLayout

`LinearLayout` 就像 `BoxLayout`（Swing 的縱向/橫向排列）。
- `android:orientation="vertical"` → 垂直排列（由上到下）
- `android:layout_width` / `layout_height` 的兩種值：
  - `wrap_content`：跟著內容大小（類似 Swing 的 preferred size）
  - `match_parent`：填滿父容器（類似 fill）

### 4.2 尺寸單位

| 單位 | 用途 |
|---|---|
| `dp` | 密度無關像素（排版用，推薦） |
| `sp` | 縮放像素（文字用） |
| `px` | 實際像素（通常不用） |

> ⚡ **對照**：Swing 用 `setSize`/`setPreferredSize` 像素，Android 用 `dp`，會依螢幕密度自動縮放。

---

# 第 5 章　綁定元件與事件（最高興的一步）

開啟 `MainActivity.java`（在 `java/你的套件名/` 下）。

```java
package com.example.myfirstapp;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);   // 載入 XML 佈局

        // 1. 綁定元件（取代 new JButton + 加入 container）
        TextView tvTitle = findViewById(R.id.tvTitle);
        EditText etInput = findViewById(R.id.etInput);
        Button btnShow = findViewById(R.id.btnShow);
        TextView tvResult = findViewById(R.id.tvResult);

        // 2. 綁定事件（取代 addActionListener）
        btnShow.setOnClickListener(v -> {
            String input = etInput.getText().toString();
            tvResult.setText("結果：" + input);
            Toast.makeText(this, "你輸入了：" + input, Toast.LENGTH_SHORT).show();
        });
    }
}
```

**程式說明（MainActivity＝第一個能互動的畫面）**：
- `extends AppCompatActivity`：繼承 Android 的「相容性 Activity」基底類別（等同你的主視窗）。
- `onCreate(Bundle savedInstanceState)`：**Activity 被建立時系統自動呼叫**的方法（等同 `main` 的切入點）。`savedInstanceState` 存上一次狀態（本範例不用）。
- `super.onCreate(savedInstanceState);`：一定要先呼叫父類別的實作，系統才完成初始化。
- `setContentView(R.layout.activity_main);`：**告訴系統「畫面用哪支 XML」**——這一步把佈局載入。
- **綁定元件**：四個 `findViewById(R.id.xxx)` 依 id 拿到 XML 裡的元件參考。
- **綁定事件**：`btnShow.setOnClickListener(v -> { ... })`——按鈕掛點擊監聽。
  - `etInput.getText().toString()`：取出輸入框的文字（`getText()` 回傳 Editable，需 `toString()` 轉成 String）。
  - `tvResult.setText("結果：" + input)`：把結果顯示到文字標籤。
  - `Toast.makeText(this, "...", Toast.LENGTH_SHORT).show()`：彈出短暫的訊息（下方詳述）。

### 5.1 findViewById 是什麼？

`findViewById(R.id.tvTitle)` 在載入的 XML 中尋找 `android:id="@+id/tvTitle"` 的元件並回傳參考。

> ⚡ **對照**：Swing 是先 `new JButton()` 再 `add()`；Android 是**先宣告 XML，再用 `findViewById` 拿參考**。這是兩者最大的思維差異。

### 5.2 事件處理：lambda 與傳統寫法對照

`setOnClickListener()` 收的是 `View.OnClickListener` 介面，這個介面**只有一個抽象方法** `onClick(View)`。
像這樣「只有一個方法的介面」叫 **functional interface（函式介面）**，所以可以直接用 **lambda** 簡寫。

```java
// ====== 傳統寫法：anonymous class（類似 Swing 的 addActionListener）=======
btnShow.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        String input = etInput.getText().toString();
        tvResult.setText("結果：" + input);
    }
});

// ====== lambda 寫法（Java 8+，Android 支援，推薦）======
// v 就是 onClick(View v) 的參數
btnShow.setOnClickListener(v -> {
    String input = etInput.getText().toString();
    tvResult.setText("結果：" + input);
});

// 只有一行動作時，連大括號與 return 都可省略
btnShow.setOnClickListener(v -> tvResult.setText("已按下"));
```

**逐行說明（傳統寫法）**：
- `new View.OnClickListener() { ... }`：建立實作 `View.OnClickListener` 介面的**匿名類別**。
- `@Override public void onClick(View v)`：覆寫唯一抽象方法 `onClick`，`v` 是「被點擊的 View」參數。
- 方法體裡做的事：讀輸入、設結果。這整段就是你熟悉的 Swing anonymous ActionListener。

**lambda 寫法**：
- `v -> { ... }`：把「單一方法的 anonymous class」縮寫。`v` 是參數（型別自動推斷），`->` 後是方法體。
- 多行時用 `{ ... }`；**只有一行動作**時可連大括號都省略：`v -> tvResult.setText("已按下")`。
- **兩者完全等價**，只是語法糖。

**兩種寫法的等價關係（一步一步看）：**

| 傳統 anonymous class | lambda |
|---|---|
| `new View.OnClickListener() { @Override public void onClick(View v) { ... } }` | `v -> { ... }` |
| 參數型別 `(View v)` | 型別可省略，自動推斷，只留 `v` |
| 方法體 `{ ... }` | 箭頭 `->` 後的區塊 |
| 必須 new + 覆寫（多行樣板） | 單一方法直接縮寫 |

> **結論**：如果你會寫 Swing 的 `new ActionListener() { public void actionPerformed(...) {...} }`，
> 那一整套樣板就是在 Android 用 `v -> { ... }` 取代。

**條件提醒：**
- Lambda 需要 **Java 8+**。Android Studio 預設支援，無需額外設定（會自動做 desugaring）。
- 只有 **functional interface（單一抽象方法）**才可用 lambda。多個方法的介面仍需 anonymous class
  （Day 3 的 MemoAdapter 會示範）。完整對照見 `Appendix_B_Lambda.md`。
- 若同一段匿名類別方法體「同時要複用」，才考慮改用具名方法參考 `this::someMethod`：

```java
// 方法參考（更精簡，做法：把動作獨立成一個 private 方法）
private void showInput() { ... }
btnShow.setOnClickListener(v -> showInput());
// 或直接
btnShow.setOnClickListener(this::showInput);
// 兩者等價，後者是「方法參考 (method reference)」，適合動作已寫成方法時
```

**說明**：
- 當「動作」已經是**一個具名方法**（例如 `private void showInput()`）時，不需要再寫 `v -> showInput()`。
- `this::showInput` 稱作**方法參考（method reference）**——直接把方法當成監聽器傳入，比 lambda 更精簡。
- `v -> showInput()` 與 `this::showInput` **完全等價**。當方法體只有「呼叫另一方法」這一行時，值得改成方法參考，程式更乾淨。

---

# 第 6 章　Toast 與 Log（取代 JOptionPane）

```java
// Toast：螢幕下方短暫訊息（取代 JOptionPane.showMessageDialog）
Toast.makeText(this, "訊息內容", Toast.LENGTH_SHORT).show();

// Toast.LENGTH_SHORT 短（~2秒） / Toast.LENGTH_LONG 長（~3.5秒）
```

**逐行說明**：`Toast.makeText(context, "訊息內容", 顯示時間).show()`——四個動作一次完成：
- 第一個參數 `this`：**Context（環境）**，通常是目前的 Activity。
- 第二個參數：要顯示的文字。
- 第三個參數：顯示時間長短——`Toast.LENGTH_SHORT`（約 2 秒）或 `Toast.LENGTH_LONG`（約 3.5 秒）。
- `.show()`：**真正顯示**在螢幕底部，停留片刻後自動消失，不會阻斷程式（非同步）。

```java
import android.util.Log;
// Log：類似 System.out.println，但顯示在 Logcat 視窗
Log.d("TAG", "這是除錯訊息");
```

**逐行說明**：
- `import android.util.Log;`：匯入 Log 工具類。
- `Log.d("TAG", "這是除錯訊息")`：**寫一筆 Log 到 Logcat 視窗**（Android Studio 底部的 Logcat 面板），不影響畫面。
- 第一個參數是 **TAG（標籤）**——慣例用類別名，方便在 Logcat 過濾。第二個參數是訊息內容。
- **層級**：`Log.v`(verbose) / `Log.d`(debug) / `Log.i`(info) / `Log.w`(warn) / `Log.e`(error)，由低到高，Logcat 可依層級過濾。

> Android 沒有 `JOptionPane` 那類同步彈窗。若真的要對話框，用 `AlertDialog`（Day 2 會提到）。

### 6.1 互動範例：Toast 訊息 + Log 日誌 展示 App

> 套件名範例：`com.example.toastlog`
> 目的：把第 6 章教的 Toast 與 Log **實際做成一支可互動 App**：
> - 點不同的按鈕，看到「短 Toast」vs「長 Toast」的差別
> - 點按鈕把不同層級的 Log（v/d/i/w/e）寫進 Logcat，並在畫面上顯示「我剛寫了哪一行 Log」
> - 用一個 `EditText` 當訊息內容，讓 Toast 與 Log 都顯示你的自訂文字

#### 6.1.1 功能需求

- 一支 `EditText` 輸入要顯示的訊息
- 一支「短 Toast」按鈕、一支「長 Toast」按鈕、一支「Toast 顯示在畫面中央」按鈕
- 五支按鈕對應 Log 的五個層級：`v` (verbose)、`d` (debug)、`i` (info)、`w` (warn)、`e` (error)
- 一支 `TextView` 顯示「最後一個動作」的說明，方便你對照 Logcat

> Log 層級由低到高：**`v` 最低 → `d` → `i` → `w` → `e` 最高**。Logcat 可以依層級過濾，所以你寫 `Log.e` 的錯誤、`Log.v` 的細節會區分開。

#### 6.1.2 替換佈局 `activity_main.xml`

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
        android:text="Toast 與 Log 展示"
        android:textSize="26sp"
        android:textStyle="bold" />

    <EditText
        android:id="@+id/etMessage"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:hint="請輸入要顯示的訊息"
        android:inputType="text" />

    <Button
        android:id="@+id/btnToastShort"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="短 Toast（2 秒）" />

    <Button
        android:id="@+id/btnToastLong"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp"
        android:text="長 Toast（3.5 秒）" />

    <Button
        android:id="@+id/btnToastCenter"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp"
        android:text="Toast 顯示在螢幕中央" />

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="20dp"
        android:text="— 寫入 Logcat 的層級 —"
        android:textStyle="bold" />

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_marginTop="8dp">

        <!-- 五支按鈕用水平排列，每一支 weight=1 均分寬度 -->
        <Button
            android:id="@+id/btnLogV"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="V" />
        <Button
            android:id="@+id/btnLogD"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="D" />
        <Button
            android:id="@+id/btnLogI"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="I" />
        <Button
            android:id="@+id/btnLogW"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="W" />
        <Button
            android:id="@+id/btnLogE"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:text="E" />
    </LinearLayout>

    <TextView
        android:id="@+id/tvResult"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="20dp"
        android:text="最後動作會顯示在此"
        android:textSize="16sp" />

</LinearLayout>
```

> 佈局小技巧：那五支 Log 按鈕用 `layout_weight="1"` 均分寬度，是 `LinearLayout` 常用的「等寬分割」寫法。

#### 6.1.3 替換 `MainActivity.java`

```java
package com.example.toastlog;

import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    // Log 的 TAG：慣例用類別名稱，方便在 Logcat 中用「套件 Tag」過濾
    private static final String TAG = "ToastLogDemo";

    private EditText etMessage;
    private TextView tvResult;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etMessage = findViewById(R.id.etMessage);
        tvResult = findViewById(R.id.tvResult);
        Button btnToastShort = findViewById(R.id.btnToastShort);
        Button btnToastLong = findViewById(R.id.btnToastLong);
        Button btnToastCenter = findViewById(R.id.btnToastCenter);
        Button btnLogV = findViewById(R.id.btnLogV);
        Button btnLogD = findViewById(R.id.btnLogD);
        Button btnLogI = findViewById(R.id.btnLogI);
        Button btnLogW = findViewById(R.id.btnLogW);
        Button btnLogE = findViewById(R.id.btnLogE);

        // —— Toast：短 / 長 / 置中（單一方法介面 → lambda）——
        btnToastShort.setOnClickListener(v -> showToast(Toast.LENGTH_SHORT, Gravity.BOTTOM));
        btnToastLong.setOnClickListener(v -> showToast(Toast.LENGTH_LONG, Gravity.BOTTOM));
        btnToastCenter.setOnClickListener(v -> showToast(Toast.LENGTH_SHORT, Gravity.CENTER));

        // —— Log：五個層級，各自寫一行到 Logcat ——
        btnLogV.setOnClickListener(v -> {
            Log.v(TAG, "這是一條 verbose：" + getMessage());
            showResult("Log.v — verbose（最低層級）已寫入");
        });
        btnLogD.setOnClickListener(v -> {
            Log.d(TAG, "這是一條 debug：" + getMessage());
            showResult("Log.d — debug 已寫入");
        });
        btnLogI.setOnClickListener(v -> {
            Log.i(TAG, "這是一條 info：" + getMessage());
            showResult("Log.i — info 已寫入");
        });
        btnLogW.setOnClickListener(v -> {
            Log.w(TAG, "這是一條 warn：" + getMessage());
            showResult("Log.w — warn 已寫入");
        });
        btnLogE.setOnClickListener(v -> {
            Log.e(TAG, "這是一條 error：" + getMessage());
            showResult("Log.e — error（最高層級）已寫入");
        });
    }

    private String getMessage() {
        String msg = etMessage.getText().toString().trim();
        return msg.isEmpty() ? "（未輸入，使用預設文字）" : msg;
    }

    private void showToast(int duration, int gravity) {
        String msg = getMessage();
        Toast toast = Toast.makeText(this, msg, duration);
        toast.setGravity(gravity, 0, 0);   // 預設是螢幕下方；可改置中
        toast.show();

        String where = (gravity == Gravity.CENTER) ? "置中" : "下方";
        String len = (duration == Toast.LENGTH_LONG) ? "長(3.5s)" : "短(2s)";
        Log.i(TAG, "Toast 已顯示，位置=" + where + "，長度=" + len + "：" + msg);
        showResult("已顯示" + where + "的" + len + " Toast：" + msg);
    }

    private void showResult(String text) {
        tvResult.setText(text);
    }
}
```

#### 6.1.4 程式與語法重點解說

- **Toast 兩種建法**：`Toast.makeText(context, msg, duration)` 會回傳一個 `Toast` 物件，最後要 **`.show()`** 才會顯示。
- **`Toast.LENGTH_SHORT` / `Toast.LENGTH_LONG`**：控制顯示時間（約 2 秒 / 3.5 秒）。
- **`toast.setGravity(Gravity.CENTER, 0, 0)`**：可改變 Toast 出現的位置（這裡示範置中）。第二、三參數是 X / Y 偏移量。
- **Log 五個層級**：
  - `Log.v`（verbose，最詳細、最低層級）
  - `Log.d`（debug，除錯）
  - `Log.i`（info，一般資訊）
  - `Log.w`（warn，警告）
  - `Log.e`（error，錯誤）
- **`Log.d(TAG, message)` 兩個參數**：第一參數是 **TAG**（過濾標籤，慣例用類別名稱），第二參數才是內容。
- **如何在 Logcat 看結果**：Run 到模擬器後，下方 **Logcat** 視窗可以
  1. 用左上角下拉選 **Debug / Info / Warn / Error** 層級過濾；
  2. 在搜尋框輸入 `ToastLogDemo`（我們的 TAG）只顯示本 App 的行。

#### 6.1.5 執行與驗證

| 操作 | 畫面上 | Logcat（搜尋 `ToastLogDemo`） |
|---|---|---|
| 輸入「Hello」→ 短 Toast | 下方跳出「Hello」約 2 秒 | `I` 一行「Toast 已顯示…下方…短」 |
| 長 Toast | 下方跳出約 3.5 秒 | `I` 一行（長度=長） |
| 中央 Toast | **螢幕中央**跳出 | `I` 一行（位置=置中） |
| 按 **D** 按鈕 | 顯示「Log.d 已寫入」 | `D` 一行「這是一條 debug：…」 |
| 按 **E** 按鈕 | 顯示「Log.e 已寫入」 | `E` 一行「這是一條 error：…」（會顯示成紅色） |

> ✅ 完成。你已實際操作 Toast 的長短與位置、以及 Log 的五個層級，並學會用 TAG 在 Logcat 中過濾你的日誌。

---

# 第 7 章　常用 View 元件一覽

| 元件 | XML 標籤 | 用途 | 常用屬性 |
|---|---|---|---|
| 文字 | `<TextView>` | 顯示文字 | `text` `textSize` `textColor` |
| 輸入框 | `<EditText>` | 輸入 | `hint` `inputType` |
| 按鈕 | `<Button>` | 點擊 | `text` |
| 圖片 | `<ImageView>` | 顯示圖片 | `src` |
| 勾選 | `<CheckBox>` | 複選 | `checked` |
| 單選 | `<RadioButton>` | 單選 | `checked`（需 RadioGroup）|
| 下拉 | `<Spinner>` | 選單 | Adapter 提供 |

### inputType 範例
```xml
<EditText
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:hint="輸入數字"
    android:inputType="number" />
```
**XML 說明**：`android:inputType="number"` 設定輸入框「只能輸入數字」，會自動跳出數字鍵盤。其他常見值：`text`（一般文字）、`textEmailAddress`（信箱）、`textPassword`（密碼，會遮蔽）、`phone`（電話）、`numberDecimal`（含小數點的數字）。調整輸入類型可同時改變「鍵盤樣式」與「資料格式限制」。

---

# 第 8 章　頁面跳轉預告

Day 2 會教你用 `Intent` 開新畫面。先記住觀念：

```java
startActivity(new Intent(this, SecondActivity.class));
```

**說明**：`new Intent(this, SecondActivity.class)` 建立一個「意圖」——第一參數 `this`（從哪個畫面出發，即目前 Activity），第二參數 `SecondActivity.class`（要到哪個畫面）。`startActivity(...)` 把這個意圖交給系統，系統就會**開啟新的 Activity（畫面）**並切換過去。

> ⚡ `Intent` 類似「開新 JFrame 並 setVisible(true)」，但它攜帶「想去哪、帶什麼資料、想做什麼」的資訊。

---

# 第 9 章　完整範例一：BMI 計算機

這是一個可以直接照貼、編譯執行的完整專案。
路徑對照：`app/src/main/java/你的套件名/` 與 `app/src/main/res/layout/`。套件名範例：`com.example.bmicalc`。

### 9-1 佈局檔案 `activity_main.xml`

路徑：`app/src/main/res/layout/activity_main.xml`

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
        android:text="BMI 計算機"
        android:textSize="28sp"
        android:textStyle="bold" />

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="身高 (cm)"
        android:textSize="16sp" />

    <EditText
        android:id="@+id/etHeight"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="請輸入身高，例如 170"
        android:inputType="numberDecimal" />

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="體重 (kg)"
        android:textSize="16sp" />

    <EditText
        android:id="@+id/etWeight"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="請輸入體重，例如 60"
        android:inputType="numberDecimal" />

    <Button
        android:id="@+id/btnCalc"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="計算 BMI" />

    <TextView
        android:id="@+id/tvResult"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="結果顯示在下方"
        android:textSize="20sp" />

</LinearLayout>
```

**佈局說明（BMI 畫面，垂直堆疊）**：
- 標題 `TextView`「BMI 計算機」（28sp 粗體）。
- 「身高 (cm)」標籤 → `etHeight` 數字輸入框（`inputType="numberDecimal"` 可輸小數）。
- 「體重 (kg)」標籤 → `etWeight` 數字輸入框。
- `btnCalc`：計算按鈕。
- `tvResult`：結果顯示區（20sp）。
- 用 `label TextView + EditText` 成對出現，是常見的「欄位式」表單排版。

### 9-2 Java 程式 `MainActivity.java`

路徑：`app/src/main/java/com/example/bmicalc/MainActivity.java`

```java
package com.example.bmicalc;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private EditText etHeight;
    private EditText etWeight;
    private TextView tvResult;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 綁定元件
        etHeight = findViewById(R.id.etHeight);
        etWeight = findViewById(R.id.etWeight);
        tvResult = findViewById(R.id.tvResult);
        Button btnCalc = findViewById(R.id.btnCalc);

        // 綁定事件
        btnCalc.setOnClickListener(v -> calculateBMI());
        // ↑ lambda 寫法：等價於下列匿名類別寫法
        // btnCalc.setOnClickListener(new View.OnClickListener() {
        //     @Override
        //     public void onClick(View v) {
        //         calculateBMI();
        //     }
        // });
    }

    private void calculateBMI() {
        String heightStr = etHeight.getText().toString().trim();
        String weightStr = etWeight.getText().toString().trim();

        // 檢查是否為空
        if (heightStr.isEmpty() || weightStr.isEmpty()) {
            Toast.makeText(this, "請輸入身高與體重", Toast.LENGTH_SHORT).show();
            return;
        }

        double heightCm = Double.parseDouble(heightStr);
        double weightKg = Double.parseDouble(weightStr);

        if (heightCm <= 0 || weightKg <= 0) {
            Toast.makeText(this, "身高體重需大於 0", Toast.LENGTH_SHORT).show();
            return;
        }

        // BMI = 體重(kg) / 身高(m)^2
        double heightM = heightCm / 100.0;
        double bmi = weightKg / (heightM * heightM);

        // 分類
        String category;
        if (bmi < 18.5) {
            category = "過輕";
        } else if (bmi < 24) {
            category = "正常";
        } else if (bmi < 27) {
            category = "過重";
        } else {
            category = "肥胖";
        }

        String result = String.format("BMI = %.1f\n分類：%s", bmi, category);
        tvResult.setText(result);
    }
}
```

**程式說明（MainActivity＝BMI 計算邏輯）**：

**onCreate**：載入佈局 → `findViewById` 綁定三個元件 → `btnCalc.setOnClickListener(v -> calculateBMI())` 掛點擊事件（單一方法 → lambda，甚至可直接寫 `v -> calculateBMI()` 一行）。

**calculateBMI()（點擊後執行的核心計算）**：
- `etHeight.getText().toString().trim()`：取身高文字並去除前後空白。
- **空值檢查**：任一為空 → `Toast` 提示並 `return`（中止後續）。
- `Double.parseDouble(...)`：把「文字」轉成 `double` 數字。
- **數值檢查**：身高或體重 ≤ 0 → Toast「需大於 0」。
- **計算**：
  - `heightM = heightCm / 100.0`：**公分轉公尺**（除以 100）。
  - `bmi = weightKg / (heightM * heightM)`：BMI 公式 = 體重 ÷ 身高²。
- **分類**：多段 `if / else if / else`——`<18.5` 過輕、`<24` 正常、`<27` 過重、否則肥胖。（這是 Model 端的資料，也可對照 JFrame 的業務邏輯）
- `String.format("BMI = %.1f\n分類：%s", bmi, category)`：`%.1f` 格式化 BMI 只留 1 位小數，`\n` 換行。最後 `tvResult.setText(result)` 顯示結果。

### 9-3 執行方式

1. 依第 2 章步驟建立 **Empty Views Activity** 專案，語言選 Java
2. 把上述 XML 覆蓋 `activity_main.xml`
3. 把上述 Java 覆蓋 `MainActivity.java`（套件名記得改成你的）
4. 啟動模擬器，點 ▶ Run 執行

### 9-4 可以練習擴充

- 新增「Reset」按鈕清空輸入
- 用 `SharedPreferences` 記住上次輸入的身高體重（Day 3 技能）
- 顯示標準體重範圍

---

# 第 10 章　完整範例二：溫度轉換器

> 套件名範例：`com.example.tempconvert`
> 用到技能：XML 佈局、EditText、RadioButton/RadioGroup、Button、TextView、事件處理、lambda
> 目的：在 BMI 之外，再加練「單選 + 條件轉換 + 數字驗證」。

### 10-1 功能需求

- 輸入一個溫度數值
- 用 RadioButton 選擇「C→F」或「F→C」轉換方向
- 按下按鈕，顯示轉換結果（保留 2 位小數）
- 輸入空白時用 Toast 提示

換算公式：
- C → F：`F = C × 9 / 5 + 32`
- F → C：`C = (F − 32) × 5 / 9`

### 10-2 步驟

**Step 1 建立專案**：**File → New → New Project → Empty Views Activity**，Language 選 **Java**，Package `com.example.tempconvert`。

**Step 2 替換佈局 `activity_main.xml`**（設計畫面：標題、輸入框、單選列、轉換按鈕、結果文字）：

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
        android:text="溫度轉換器"
        android:textSize="26sp"
        android:textStyle="bold" />

    <EditText
        android:id="@+id/etTemp"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:hint="請輸入溫度數值"
        android:inputType="numberDecimal|numberSigned" />

    <RadioGroup
        android:id="@+id/radioGroup"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:orientation="horizontal">

        <RadioButton
            android:id="@+id/rbToF"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:checked="true"
            android:text="攝氏 → 華氏" />

        <RadioButton
            android:id="@+id/rbToC"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="華氏 → 攝氏" />
    </RadioGroup>

    <Button
        android:id="@+id/btnConvert"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="轉換" />

    <TextView
        android:id="@+id/tvResult"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="結果："
        android:textSize="20sp" />

</LinearLayout>
```

**佈局重點解說**：
- 標題 `TextView`「溫度轉換器」→ `etTemp` 溫度輸入框 → `RadioGroup`（轉換方向）→ `btnConvert` 按鈕 → `tvResult` 結果文字。
- `RadioGroup` 是**容器**，包住 `RadioButton`。同一個 RadioGroup 內的選項「互相排斥」（只會選中一個）。
- `android:checked="true"` 讓「攝氏→華氏」預設被選中。
- `android:orientation="horizontal"`：讓兩個選項並排成同一列。
- `inputType="numberDecimal|numberSigned"`：以 `|` 組合兩種能力——**允許小數 + 允許負號**（可輸入 `-5.5`）。單一 `number` 不能輸負數與小數。

**Step 3 替換 `MainActivity.java`**：

```java
package com.example.tempconvert;

import android.os.Bundle;
import android.text.TextUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private EditText etTemp;
    private RadioGroup radioGroup;
    private TextView tvResult;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etTemp = findViewById(R.id.etTemp);
        radioGroup = findViewById(R.id.radioGroup);
        tvResult = findViewById(R.id.tvResult);
        Button btnConvert = findViewById(R.id.btnConvert);

        btnConvert.setOnClickListener(v -> convert());   // lambda
    }

    private void convert() {
        String input = etTemp.getText().toString().trim();

        if (TextUtils.isEmpty(input)) {
            Toast.makeText(this, "請輸入溫度數值", Toast.LENGTH_SHORT).show();
            return;
        }

        double value = Double.parseDouble(input);
        double result;

        int checkedId = radioGroup.getCheckedRadioButtonId();
        if (checkedId == R.id.rbToF) {
            result = value * 9.0 / 5.0 + 32;      // C -> F
        } else {
            result = (value - 32) * 5.0 / 9.0;    // F -> C
        }

        tvResult.setText(String.format("結果：%.2f", result));
    }
}
```

**程式說明（MainActivity＝溫度轉換邏輯）**：

**onCreate**：載入佈局 → 綁定 `etTemp`（輸入）、`radioGroup`（方向單選）、`tvResult`（結果）、`btnConvert`（按鈕）。`btnConvert.setOnClickListener(v -> convert())` 掛點擊（單一方法 → lambda）。

**convert()（核心轉換）**：
- 取輸入字串並 `trim()`。
- **空值檢查**：`TextUtils.isEmpty(input)`——比 `"".equals(input)` 更嚴謹，**連 `null` 一起擋掉**。空 → Toast 提示並 `return`。
- `double value = Double.parseDouble(input);`：文字轉數字。
- `int checkedId = radioGroup.getCheckedRadioButtonId();`：**取得目前被選中的 RadioButton 的資源 id**。
- 依 `checkedId` 判斷方向：
  - `== R.id.rbToF` → `C × 9/5 + 32`（攝氏轉華氏）。
  - 否則（`rbToC`）→ `(F − 32) × 5/9`（華氏轉攝氏）。
- `String.format("結果：%.2f", result)`：`%.2f` **四捨五入到 2 位小數**，`setText` 顯示。

> 程式重點解說補充：`TextUtils.isEmpty()` 判斷是否空白；`radioGroup.getCheckedRadioButtonId()` 取被選中的選項；`String.format("%.2f", result)` 格式化到兩位小數（類似 Swing 的 `System.out.printf`）。

**Step 4 執行與驗證**：

| 輸入 | 選項 | 預期結果 |
|---|---|---|
| `100` | 攝氏→華氏 | `212.00` |
| `32` | 華氏→攝氏 | `0.00` |
| `-40` | 攝氏→華氏 | `-40.00` |
| （空白） | 任意 | Toast「請輸入溫度數值」 |

> ✅ 完成。你已練習：RadioGroup 單選、條件分支、數字輸入驗證、`String.format`。

**可練習擴充**：改用 `Spinner` 取代 RadioButton 選方向、同時顯示「轉換成兩種刻度」的結果、把上次輸入的數值存進 `SharedPreferences`。

---

# 第 11 章　完整範例三：登入表單

> 套件名範例：`com.example.loginform`
> 用到技能：EditText（含密碼/單行）、CheckBox、Button、條件判斷、AlertDialog、清空輸入
> 目的：練「核取方塊」「密碼輸入」「有條件的提示警示」，並熟悉 `inputType`。

### 11-1 功能需求

- 帳號欄（單行文字）、密碼欄（密碼型態，能看到可選）
- 一個 CheckBox「顯示密碼」
- 按下「登入」判斷帳號密碼是否為 `admin / 1234`
- 成功：Toast + 顯示歡迎訊息
- 失敗：AlertDialog 彈出錯誤

### 11-2 步驟

**Step 1 建立專案**：**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.loginform`。

**Step 2 替換佈局 `activity_main.xml`**（畫面含 帳號、密碼、顯示密碼勾選、登入按鈕）：

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
        android:text="會員登入"
        android:textSize="26sp"
        android:textStyle="bold" />

    <EditText
        android:id="@+id/etAccount"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:hint="帳號"
        android:inputType="text" />
    <!-- inputType="text" 可再換成 textEmailAddress, textPassword 等 -->

    <EditText
        android:id="@+id/etPassword"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:hint="密碼"
        android:inputType="textPassword" />
    <!-- textPassword：輸入內容以 ●●● 顯示 -->

    <CheckBox
        android:id="@+id/cbShow"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="8dp"
        android:text="顯示密碼" />

    <Button
        android:id="@+id/btnLogin"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="登入" />

    <TextView
        android:id="@+id/tvMessage"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="20dp"
        android:text="尚未登入"
        android:textSize="18sp" />

</LinearLayout>
```

**佈局說明（登入表單，垂直堆疊）**：
- 標題「會員登入」。
- `etAccount`（帳號輸入框，`inputType="text"` 一般文字）。
- `etPassword`（密碼輸入框，**`inputType="textPassword"`** → 輸入內容會以 `●●●` 遮蔽，是密碼欄的關鍵屬性）。
- `cbShow`（CheckBox「顯示密碼」）— 勾選時要切換密碼的明文/隱藏（邏輯在 Java）。
- `btnLogin`（登入按鈕）。
- `tvMessage`（狀態訊息，初始「尚未登入」）。

**Step 3 替換 `MainActivity.java`**：

```java
package com.example.loginform;

import android.app.AlertDialog;
import android.os.Bundle;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private EditText etAccount;
    private EditText etPassword;
    private CheckBox cbShow;
    private TextView tvMessage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etAccount = findViewById(R.id.etAccount);
        etPassword = findViewById(R.id.etPassword);
        cbShow = findViewById(R.id.cbShow);
        tvMessage = findViewById(R.id.tvMessage);
        Button btnLogin = findViewById(R.id.btnLogin);

        // CheckBox 切換 → 切換密碼顯示/隱藏
        cbShow.setOnCheckedChangeListener((buttonView, isChecked) -> {
            int type = isChecked
                    ? android.text.InputType.TYPE_CLASS_TEXT
                    : android.text.InputType.TYPE_CLASS_TEXT
                            | android.text.InputType.TYPE_TEXT_VARIATION_PASSWORD;
            etPassword.setInputType(type);
        });

        btnLogin.setOnClickListener(v -> login());
    }

    private void login() {
        String account = etAccount.getText().toString().trim();
        String password = etPassword.getText().toString();

        // 硬編碼的驗證（正式 App 應查資料庫，Day 3 會講）
        if (account.equals("admin") && password.equals("1234")) {
            tvMessage.setText("歡迎登入：" + account);
            Toast.makeText(this, "登入成功", Toast.LENGTH_SHORT).show();
        } else {
            // 失敗 → AlertDialog（取代 JOptionPane 彈窗）
            new AlertDialog.Builder(this)
                    .setTitle("登入失敗")
                    .setMessage("帳號或密碼錯誤")
                    .setPositiveButton("確定", null)
                    .show();
        }
    }
}
```

**程式說明（MainActivity＝登入表單邏輯）**：

**onCreate**：綁定 `etAccount`、`etPassword`、`cbShow`、`tvMessage`、`btnLogin`。

**CheckBox 切換密碼顯示（重點）**：
- `cbShow.setOnCheckedChangeListener((buttonView, isChecked) -> {...})`：勾選狀態改變時觸發。`CompoundButton.OnCheckedChangeListener` 只有一個方法 → 可用 lambda。
- 依 `isChecked` 決定 `etPassword.setInputType(...)`：
  - 勾選（`isChecked == true`）→ `TYPE_CLASS_TEXT`（**明文**）。
  - 未勾選 → `TYPE_CLASS_TEXT | TYPE_TEXT_VARIATION_PASSWORD`（**密碼遮蔽**）。用 `|` 組合「一般文字」與「密碼」兩個旗標。
- 這樣就能動態切換密碼欄的「明文 / ●●●」。

**login()（登入驗證）**：
- `account = ...trim()` **去空白**；`password = ...` **保留原樣**（密碼不該去空白，保持精確比對）。
- **驗證**：帳號 `admin` 且密碼 `1234`（硬編碼，正式應查資料庫）：
  - 成功 → `tvMessage.setText("歡迎登入：...")` + Toast「登入成功」。
  - 失敗 → **`AlertDialog`**：`.setTitle/.setMessage/.setPositiveButton("確定", null).show()`。`setPositiveButton` 的第二參數 `null` 表示「按確定只關閉視窗」，不做其他事（取代 JFrame 的 `JOptionPane`）。

> 程式重點解說補充：`OnCheckedChangeListener` 單一方法 → lambda；`setInputType` 動態切換明文/密碼；帳號 `trim`、密碼保留；`setPositiveButton("確定", null)` 的 null = 只關掉不動作。

**Step 4 執行與驗證**：

| 操作 | 預期結果 |
|---|---|
| 帳號 `admin`、密碼 `1234`、登入 | Toast「登入成功」，訊息變「歡迎登入：admin」 |
| 帳號 `admin`、密碼 `123`、登入 | AlertDialog「登入失敗」 |
| 勾選「顯示密碼」 | 密碼欄明文顯示；取消勾選則回到 ●●● |

> ✅ 完成。你已練習：CheckBox 切換、密碼 inputType、AlertDialog 錯誤提示、條件分支。

**可練習擴充**：用 SharedPreferences 記住「是否顯示密碼」與上次帳號、登入三次失敗鎖定按鈕、密碼欄按下回車 (Enter) 也觸發登入。

---

# 第 12 章　完整範例四：常用 View 元件互動展示

> 套件名範例：`com.example.viewdemo`
> 用到技能：把第 7 章「常用 View 元件」一次通通變成**可互動、看得到結果**的展示。
> 目的：前面三支範例練習了 `TextView`/`EditText`/`Button`/`RadioButton`/`CheckBox`、本範例補齊 **`ImageView`、`Spinner`、`ToggleButton`、`SeekBar`、`RatingBar`**，
> 並示範「多種元件讀取值、寫進同一個 `TextView`」的整合寫法。

### 12-1 功能需求

- 一個 `ImageView`：可顯示內建的 Android 圖片，加「換圖」按鈕切換兩張
- 一個 `Spinner`（下拉清單）：選一個選項，即時顯示選擇結果
- 一個 `Switch`：開 / 關，開關狀態即時顯示
- 一個 `SeekBar`（進度條）：拖動到某個值，即時顯示目前數值
- 一個 `RatingBar`（星等）：按星星打分，即時顯示幾顆星
- 一個 `Button`：「全部更新」，把以上所有元件的目前值一次寫進一支 `TextView`

> Switch 讀取的是 `boolean`、SeekBar / RatingBar 讀取的是 `int`，這支範例能讓你一次看懂「不同 View 用不同方法取值」。

### 12-2 步驟

**Step 1 建立專案**：**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.viewdemo`。

**Step 2 替換佈局 `activity_main.xml`**：

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
        android:text="常用 View 元件展示"
        android:textSize="26sp"
        android:textStyle="bold" />

    <!-- ImageView：顯示圖片，預設 Android 內建圖片 ic_launcher -->
    <ImageView
        android:id="@+id/imgDemo"
        android:layout_width="120dp"
        android:layout_height="120dp"
        android:layout_marginTop="16dp"
        android:src="@android:drawable/ic_menu_gallery"
        android:contentDescription="圖片展示" />

    <Button
        android:id="@+id/btnSwapImage"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="換圖" />

    <!-- Spinner：下拉清單 -->
    <Spinner
        android:id="@+id/spinner"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp" />

    <!-- Switch：開關 -->
    <Switch
        android:id="@+id/switchDemo"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="開關狀態" />

    <!-- SeekBar：進度條（0–100，預設 50） -->
    <SeekBar
        android:id="@+id/seekBar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:max="100"
        android:progress="50" />

    <!-- RatingBar：星等（預設 5 顆星，評 3 顆） -->
    <RatingBar
        android:id="@+id/ratingBar"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:numStars="5"
        android:rating="3" />

    <Button
        android:id="@+id/btnShowAll"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="全部更新" />

    <TextView
        android:id="@+id/tvResult"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:textSize="16sp"
        android:text="狀態會顯示在此" />

</LinearLayout>
```

佈局重點解說：
- `<ImageView android:src="@android:drawable/ic_menu_gallery">` 用的是 **Android 內建圖庫**，不需自己放圖檔。換圖時在程式用 `setImageResource(...)`。`android:contentDescription` 是給無障礙用的圖片描述。
- `<Spinner>` 跟 `ListView` 一樣需要 **Adapter** 提供選項清單（見下方 Java）。
- `<Switch>`：**開關**，有內建布林狀態（`isChecked()`）。
- `<SeekBar>`：**進度條**，`android:max="100"` 最大 100、`android:progress="50"` 目前 50，讀值用 `getProgress()`（int）。
- `<RatingBar>`：**星等**，`android:numStars="5"` 共 5 顆、`android:rating="3"` 目前 3 顆，讀值用 `getRating()`（float，可含半顆）。
- 所有元件值最後由「全部更新」按鈕一次匯入 `tvResult`。

**Step 3 替換 `MainActivity.java`**：

```java
package com.example.viewdemo;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RatingBar;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private ImageView imgDemo;
    private Spinner spinner;
    private Switch switchDemo;
    private SeekBar seekBar;
    private RatingBar ratingBar;
    private TextView tvResult;

    private boolean useGallery = true;   // 記錄目前顯示哪張圖

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        imgDemo = findViewById(R.id.imgDemo);
        spinner = findViewById(R.id.spinner);
        switchDemo = findViewById(R.id.switchDemo);
        seekBar = findViewById(R.id.seekBar);
        ratingBar = findViewById(R.id.ratingBar);
        tvResult = findViewById(R.id.tvResult);
        Button btnSwapImage = findViewById(R.id.btnSwapImage);
        Button btnShowAll = findViewById(R.id.btnShowAll);

        // ---------- Spinner：用 ArrayAdapter 提供選項 ----------
        List<String> options = new ArrayList<>();
        options.add("蘋果");
        options.add("香蕉");
        options.add("柳橙");
        ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<>(
                this, android.R.layout.simple_spinner_item, options);
        spinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(spinnerAdapter);

        // 選項改變 → 即時顯示（單一方法介面 → lambda）
        spinner.setOnItemSelectedListener(new android.widget.AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(android.widget.AdapterView<?> parent,
                                       android.view.View view, int position, long id) {
                tvResult.setText("Spinner 選了：" + options.get(position));
            }

            @Override
            public void onNothingSelected(android.widget.AdapterView<?> parent) {
            }
        });
        // ↑ 註：OnItemSelectedListener 有「兩個方法」，所以這裡只能寫 anonymous class，不能寫成 lambda。

        // 換圖按鈕（單一方法介面 → lambda）
        btnSwapImage.setOnClickListener(v -> {
            if (useGallery) {
                imgDemo.setImageResource(android.R.drawable.ic_menu_camera);
                Toast.makeText(this, "切到相機圖示", Toast.LENGTH_SHORT).show();
            } else {
                imgDemo.setImageResource(android.R.drawable.ic_menu_gallery);
                Toast.makeText(this, "切到圖庫圖示", Toast.LENGTH_SHORT).show();
            }
            useGallery = !useGallery;
        });

        // 開關切換 → 即時顯示（單一方法介面 → lambda）
        switchDemo.setOnCheckedChangeListener((buttonView, isChecked) ->
                tvResult.setText("Switch：" + (isChecked ? "開啟" : "關閉")));

        // 進度條拖動 → 即時顯示（單一方法介面 → lambda）
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                tvResult.setText("SeekBar 目前值：" + progress);
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
            }
        });
        // ↑ 註：OnSeekBarChangeListener 也有三個方法，所以用 anonymous class。

        // 星等打分 → 即時顯示（單一方法介面 → lambda）
        ratingBar.setOnRatingBarChangeListener((bar, rating, fromUser) ->
                tvResult.setText("RatingBar：[半顆 ★] x " + rating));

        // 全部更新：一次把各種 View 的目前值寫進 tvResult（注意不同方法的回傳型別）
        btnShowAll.setOnClickListener(v -> {
            String imageName = useGallery ? "gallery" : "camera";
            String selected = (String) spinner.getSelectedItem();

            // Switch → isChecked() 回傳 boolean
            String switchState = switchDemo.isChecked() ? "開啟" : "關閉";

            // SeekBar → getProgress() 回傳 int（0–100）
            int progress = seekBar.getProgress();

            // RatingBar → getRating() 回傳 float（可含半顆）
            float rating = ratingBar.getRating();

            String result = "圖片=" + imageName
                    + "\nSpinner=" + selected
                    + "\nSwitch=" + switchState
                    + "\nSeekBar=" + progress
                    + "\nRatingBar=" + rating;
            tvResult.setText(result);
        });
    }
}
```

程式重點解說（MainActivity＝一次整合多種 View）：

**onCreate 前半部（綁定元件）**：`findViewById` 綁定 `imgDemo`、`spinner`、`switchDemo`、`seekBar`、`ratingBar`、`tvResult`、按鈕們。

**Spinner（下拉選單）設定**：
- `List<String> options` 準備選項（蘋果/香蕉/柳橙）。
- `new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, options)` 建立橋接器——用系統內建單行樣板。
- `setDropDownViewResource(...)` 設定「下拉展開時」每列用的樣板。
- `spinner.setAdapter(spinnerAdapter)` 接上。
- `setOnItemSelectedListener(new ... { ... })`：選項改變觸發 `onItemSelected`，顯示「Spinner 選了：…」。**因 `OnItemSelectedListener` 有兩個方法**（`onItemSelected` + `onNothingSelected`）→ **只能寫 anonymous class，不能 lambda**。

**換圖按鈕**：`btnSwapImage` 依 `useGallery` 旗標切換 `imgDemo.setImageResource(...)`（camera ⇄ gallery 兩張內建圖），並 `useGallery = !useGallery` 翻轉狀態。單一方法 → lambda。

**Switch（開關）**：`setOnCheckedChangeListener((buttonView, isChecked) -> ...)` 即時顯示開/關。單一方法 → lambda。

**SeekBar（進度條）**：`setOnSeekBarChangeListener(new ... { ... })` 的 `onProgressChanged` 顯示「目前值」。**因有三個方法** → anonymous class。

**RatingBar（星等）**：`setOnRatingBarChangeListener((bar, rating, fromUser) -> ...)` 即時顯示。單一方法 → lambda。

**全部更新按鈕**：一次讀取所有 View 目前值：
- `spinner.getSelectedItem()` → 回傳 `Object`，**需轉型成 `(String)`**。
- `switchDemo.isChecked()` → `boolean`。
- `seekBar.getProgress()` → `int`（0–100）。
- `ratingBar.getRating()` → `float`（可為 3.5 半顆星）。
- 組合成多行字串寫進 `tvResult`。

**lambda vs anonymous class 總整理**：
- 單一方法：`setOnClickListener`、`setOnCheckedChangeListener`、`setOnRatingBarChangeListener` → lambda。
- 多方法：`setOnItemSelectedListener`（兩方法）、`setOnSeekBarChangeListener`（三方法）→ **只能 anonymous class**。
- 用 `android.R.drawable.xxx` / `android.R.layout.xxx` 開頭代表**系統內建資源**，免自建檔。

**Step 4 執行與驗證**：

| 操作 | 預期結果 |
|---|---|
| 按「換圖」 | 圖片在圖庫/相機兩張圖示間切換，並跳出 Toast |
| 選 Spinner「香蕉」 | 顯示「Spinner 選了：香蕉」 |
| 切 **Switch** 開/關 | 顯示「Switch：開啟 / 關閉」 |
| 拖動 **SeekBar** | 顯示「SeekBar 目前值：50、51…」 |
| 點 **RatingBar** 星星 | 顯示「RatingBar：[半顆 ★] x 3.0…」 |
| 按「全部更新」 | 一次顯示五種元件的目前值 |

> ✅ 完成。你已實際操作了第 7 章列的常用 View，並看懂「每種 View 的取值方法與回傳型別」。

**可練習擴充**：
- 把 `Switch` 換成 `ToggleButton`、`CheckBox` 三種「開關」一起比較
- 把 `SeekBar` 接上 `TextView` 顯示當前進度百分比
- 加一支 `ProgressBar`（捲動進度圈），點按鈕時讓它轉
- 把選取的圖片用 `Spinner` 來選（練習把 Spinner + 條件分支結合）

---

# 第 13 章　自我測驗與解答

先自己作答，再看解答。有些題目沒有唯一答案，參考解答即可。

## Day 1 測驗題

1. `android:layout_width="match_parent"` 和 `"wrap_content"` 分別是什麼意思？
2. `findViewById(R.id.btnShow)` 的 `R.id.btnShow` 指的是什麼？
3. Android 為什麼要建議文字用 `sp` 而不是 `px`？
4. `onCreate` 方法在何時被呼叫？裡面一定要做什麼事？
5. Toast 和 JOptionPane 的主要差異是什麼？
6. 什麼情況下可以用 lambda？使用 lambda 有哪些限制？
7. `Switch`、`SeekBar`、`RatingBar` 取得目前值的方法各回傳什麼型別？為何要用各自的取值方法？

### Day 1 測驗解答

**1. `match_parent` 和 `wrap_content` 分別是什麼意思？**

- `match_parent`：寬/高等於父容器的寬/高（填滿）。
- `wrap_content`：寬/高等於內容所需的大小（包住內容）。
- 對照 Swing：`match_parent` ≈ Fill，`wrap_content` ≈ Preferred Size。

**2. `findViewById(R.id.btnShow)` 的 `R.id.btnShow` 指的是什麼？**

`R` 是 Android 編譯時自動產生的資源類別。`R.id.btnShow` 是佈局中 `android:id="@+id/btnShow"` 這個元件對應的唯一整數 ID。`findViewById` 透過這個 ID 在已載入的佈局中尋找該 View 並回傳參考。

**3. Android 為什麼要建議文字用 `sp` 而不是 `px`？**

- `sp` (Scaled Pixel) 會依系統字型設定縮放，尊重使用者的無障礙字型偏好。
- `px` 是固定像素，在不同密度 (density) 螢幕上大小不一致，且不會跟隨系統字型。
- 排版距離用 `dp`，文字大小用 `sp`。

**4. `onCreate` 方法在何時被呼叫？裡面一定要做什麼事？**

- Activity 首次被建立時第一個被呼叫的生命週期方法。
- 一定要呼叫 `super.onCreate(savedInstanceState)` 且至少呼叫一次 `setContentView(R.layout.xxx)` 設定畫面。

**5. Toast 和 JOptionPane 的主要差異是什麼？**

- Toast 是非同步、不阻塞的短暫提示，自動消失，無法取得使用者回饋。
- JOptionPane 是同步對話框，會阻塞程式直到使用者回應，且可取得回傳值。
- Android 要用 `AlertDialog` 才類似 JOptionPane 的彈窗。

**6. 什麼情況下可以用 lambda？使用 lambda 有哪些限制？**

- 只有「單一抽象方法」的介面（functional interface）才能用 lambda。例如 `View.OnClickListener`、`DialogInterface.OnClickListener` 都只有一個方法，所以可以寫成 `v -> {...}`。
- 多個抽象方法的介面不行（例如 Day 3 的 `MemoAdapter.OnMemoClickListener` 有兩個方法，只能寫 anonymous class）。
- 方法覆寫（override 已存在的方法，例如 `onActivityResult`）也不能用 lambda。
- 需 Java 8+（Android Studio 預設支援）。

**7. `Switch`、`SeekBar`、`RatingBar` 取得目前值的方法各回傳什麼型別？為何要用各自的取值方法？**

- `Switch.isChecked()` 回傳 `boolean`（開 / 關）。
- `SeekBar.getProgress()` 回傳 `int`（0 到 max 的整數）。
- `RatingBar.getRating()` 回傳 `float`（可能帶半顆星，例如 3.5）。
- 因為每個 View 的「狀態型別」天生不同（布林 vs 整數 vs 小數），所以 Android 依各元件設計了對應的取值方法。
- 反例：`spinner.getSelectedItem()` 回傳的是 `Object`（因為選項內容型別不定），需自己轉型成 `String` 等型別。

---

# 本日小結

今天你完成了：
- 安裝環境與建立模擬器
- 認識 Android 專案結構（`app/`、`MainActivity`、`AndroidManifest.xml`）
- `LinearLayout` 佈局與 `dp`/`sp` 單位
- `findViewById` 綁定元件
- `setOnClickListener` + lambda 事件處理
- Toast 訊息
- 四支可編譯的完整範例：**BMI 計算機**、**溫度轉換器**、**登入表單**、**常用 View 元件互動展示**

明天（Day 2）將學習用 `Intent` 跳轉多個畫面、畫面間傳值、以及 ListView/RecyclerView 列表。

> 相關延伸閱讀：`Appendix_A_Project_Creation.md`（建專案）、`Appendix_B_Lambda.md`（Lambda 對照）、`Appendix_F_XML_Attrs.md`（XML 屬性速查）、`Appendix_H_Swing_vs_Android.md`（JFrame→Android 對照）。