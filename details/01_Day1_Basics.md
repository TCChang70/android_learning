# Day 1 — 環境建置與基礎：建立你的第一個 Android App

> 目標：安裝環境、認識專案結構、學會佈局與元件、綁定事件，完成 **BMI 計算機 App**
> 時間：約 6–8 小時
> 與 JFrame 的對照會用 ⚡ 標記

---

## 1. 安裝環境

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

## 2. 建立第一個專案

1. **File → New → New Project**
2. 選 **Empty Views Activity**（注意：不是 Compose，因為我們用 XML）
3. Project name：`MyFirstApp`，Language 選 **Java**，Minimum SDK 選 API 24 以上

---

## 3. Android 專案結構（對照 JFrame 專案）

| 資料夾 / 檔案 | 用途 | JFrame 對照 |
|---|---|---|
| `app/src/main/java/...` | Java 原始碼 | `src/` |
| `app/src/main/res/layout/activity_main.xml` | 畫面佈局 | `setContentPane(...)` + 拉元件 |
| `app/src/main/res/values/strings.xml` | 字串資源 | 硬編碼字串（建議資源化） |
| `app/src/main/AndroidManifest.xml` | 宣告 Activity、權限 | 沒有直接對照（類似設定檔） |
| `app/build.gradle` | 專案設定 / 依賴 | `pom.xml` / `build.gradle` |

> 最重要的一點：**Android 的畫面 (UI) 預設用 XML 描述，Java 程式只做邏輯與綁定。**

---

## 4. 第一個畫面：activity_main.xml

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

## 5. 綁定元件與事件（最高興的一步）

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

### 5.1 findViewById 是什麼？

`findViewById(R.id.tvTitle)` 在載入的 XML 中尋找 `android:id="@+id/tvTitle"` 的元件並回傳參考。

> ⚡ **對照**：Swing 是先 `new JButton()` 再 `add()`；Android 是**先宣告 XML，再用 `findViewById` 拿參考**。這是兩者最大的思維差異。

### 5.2 事件處理：lambda 與傳統寫法對照

`setOnClickListener()` 收的是 `View.OnClickListener` 介面，這個介面**只有一個抽象方法** `onClick(View)`。像這樣「只有一個方法的介面」叫 **functional interface（函式介面）**，所以可以直接用 **lambda** 簡寫。

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

**兩種寫法的等價關係（一步一步看）：**

| 傳統 anonymous class | lambda |
|---|---|
| `new View.OnClickListener() { @Override public void onClick(View v) { ... } }` | `v -> { ... }` |
| 參數型別 `(View v)` | 型別可省略，自動推斷，只留 `v` |
| 方法體 `{ ... }` | 箭頭 `->` 後的區塊 |
| 必須 new + 覆寫（多行樣板） | 單一方法直接縮寫 |

> **結論**：如果你會寫 Swing 的 `new ActionListener() { public void actionPerformed(...) {...} }`，那一整套樣板就是在 Android 用 `v -> { ... }` 取代。

**條件提醒：**
- Lambda 需要 **Java 8+**。Android Studio 預設支援，無需額外設定（會自動做 desugaring）。
- 只有 **functional interface（單一抽象方法）**才可用 lambda。多個方法的介面仍需 anonymous class（Day 5 的 MemoAdapter 會示範）。
- 若同一段匿名類別方法體「同時要複用」，才考慮改用具名方法參考 `this::someMethod`：

```java
// 方法參考（更精簡，做法：把動作獨立成一個 private 方法）
private void showInput() { ... }
btnShow.setOnClickListener(v -> showInput());
// 或直接
btnShow.setOnClickListener(this::showInput);
// 兩者等價，後者是「方法參考 (method reference)」，適合動作已寫成方法時
```

---

## 6. Toast 與 Log（取代 JOptionPane）

```java
// Toast：螢幕下方短暫訊息（取代 JOptionPane.showMessageDialog）
Toast.makeText(this, "訊息內容", Toast.LENGTH_SHORT).show();

// Toast.LENGTH_SHORT 短（~2秒） / Toast.LENGTH_LONG 長（~3.5秒）
```

```java
import android.util.Log;
// Log：類似 System.out.println，但顯示在 Logcat 視窗
Log.d("TAG", "這是除錯訊息");
```

> Android 沒有 `JOptionPane` 那類同步彈窗。若真的要對話框，用 `AlertDialog`（Day 2 會提到）。

---

## 7. 常用 View 元件一覽

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

---

## 8. 頁面跳轉預告

Day 2 會教你用 `Intent` 開新畫面。先記住觀念：

```java
startActivity(new Intent(this, SecondActivity.class));
```

> ⚡ `Intent` 類似「開新 JFrame 並 setVisible(true)」，但它攜帶「想去哪、帶什麼資料、想做什麼」的資訊。

---

## 9. 小實作：BMI 計算機 App

完整程式碼見 `04_Example_BMI.md`。

功能需求：
- 兩個 `EditText`：身高(cm)、體重(kg)
- 一個 `Button`：計算 BMI
- 顯示結果：`BMI = 體重 / (身高m)^2`
- 顯示分類：過輕 / 正常 / 過重 / 肥胖

### Day 1 完整範例清單（每一步都可直接編譯執行）

| 範例 | 檔案 | 重點技能 |
|---|---|---|
| BMI 計算機 | `04_Example_BMI.md` | 基本 View、findViewById、Button、Toast |
| 溫度轉換器 | `10_Day1_TempConverter.md` | RadioButton/RadioGroup、文字驗證、`String.format` |
| 登入表單 | `11_Day1_LoginForm.md` | EditText、CheckBox、密碼顯示切換、AlertDialog 錯誤提示 |

> 一起做：建議先做 BMI（最基礎），再做溫度轉換器（練單選），最後做登入表單（練核取方塊與警示）。

---

## 10. 自我測驗

1. `android:layout_width="match_parent"` 和 `"wrap_content"` 分別是什麼意思？
2. `findViewById(R.id.btnShow)` 的 `R.id.btnShow` 指的是什麼？
3. Android 為什麼要建議文字用 `sp` 而不是 `px`？
4. `onCreate` 方法在何時被呼叫？裡面一定要做什麼事？
5. Toast 和 JOptionPane 的主要差異是什麼？
6. 什麼情況下可以用 lambda？使用 lambda 有哪些限制？

（解答在 `06_Quiz_Answers.md`）

---

下一份文件 → [Day 2：頁面跳轉與列表](02_Day2_Navigation_Lists.md)
