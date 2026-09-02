# 完整範例 02：登入表單（Day 1 應用）

> 套件名範例：`com.example.loginform`
> 用到技能：EditText（含密碼/單行）、CheckBox、Button、條件判斷、AlertDialog、清空輸入
> 目的：練「核取方塊」「密碼輸入」「有條件的提示警示」，並熟悉 `inputType`。

---

## 功能需求

- 帳號欄（單行文字）、密碼欄（密碼型態，能看到可選）
- 一個 CheckBox「顯示密碼」
- 按下「登入」判斷帳號密碼是否為 `admin / 1234`
- 成功：Toast + 顯示歡迎訊息
- 失敗：AlertDialog 彈出錯誤

---

## Step 1　建立專案

**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.loginform`。

---

## Step 2　替換佈局 `activity_main.xml`

> 預期結果：畫面含 帳號、密碼、顯示密碼勾選、登入按鈕。

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

---

## Step 3　替換 `MainActivity.java`

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

### 程式重點解說
- **CheckBox 事件**：`OnCheckedChangeListener` 只有一個方法 `onCheckedChanged(...)`，是 functional interface，所以可用 lambda `(buttonView, isChecked) -> {...}`。
- `etPassword.setInputType(...)` 可在程式內動態切換「明文 / 密碼」顯示。
- 帳號用 `.trim()` 去空白，密碼保留原樣（密碼不應去空白）。
- `AlertDialog.Builder` 的 `.setPositiveButton("確定", null)`：null 表示「按確定只關閉視窗，不做其他事」。

---

## Step 4　執行與驗證

| 操作 | 預期結果 |
|---|---|
| 帳號 `admin`、密碼 `1234`、登入 | Toast「登入成功」，訊息變「歡迎登入：admin」 |
| 帳號 `admin`、密碼 `123`、登入 | AlertDialog「登入失敗」 |
| 勾選「顯示密碼」 | 密碼欄明文顯示；取消勾選則回到 ●●● |

> ✅ 完成。你已練習：CheckBox 切換、密碼 inputType、AlertDialog 錯誤提示、條件分支。

---

## 可練習擴充
- 用 SharedPreferences 記住「是否顯示密碼」與上次帳號
- 登入三次失敗鎖定按鈕
- 密碼欄按下回車 (Enter) 也觸發登入