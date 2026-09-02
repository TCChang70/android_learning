# 完整範例 05：使用者設定（Day 3 應用 · SharedPreferences + 內部儲存）

> 套件名範例：`com.example.usersettings`
> 用到技能：SharedPreferences 讀寫、內部儲存檔案寫入/讀取、EditText、AlertDialog
> 目的：把 Day 3 前兩種「非資料庫」持久化技巧實際跑一遍。

---

## 功能需求

- 填寫「名稱」與「喜好主題」（兩欄文字）
- 「儲存設定」：把名稱+主題存成 **SharedPreferences**（下次開啟自動帶回）
- 「寫入日誌」：把目前的設定內容**寫成一個檔案**到内部儲存
- 「讀取日誌」：讀回該檔案並用 AlertDialog 顯示

---

## Step 1　建立專案

**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.usersettings`。

---

## Step 2　佈局 `activity_main.xml`

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
        android:text="使用者設定"
        android:textSize="26sp"
        android:textStyle="bold" />

    <EditText
        android:id="@+id/etName"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:hint="名稱" />

    <EditText
        android:id="@+id/etTopic"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:hint="喜好主題" />

    <Button
        android:id="@+id/btnSavePrefs"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="24dp"
        android:text="儲存設定 (SharedPreferences)" />

    <Button
        android:id="@+id/btnWriteLog"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:text="寫入日誌 (檔案)" />

    <Button
        android:id="@+id/btnReadLog"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:text="讀取日誌 (檔案)" />

</LinearLayout>
```

---

## Step 3　`MainActivity.java`

```java
package com.example.usersettings;

import android.app.AlertDialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

public class MainActivity extends AppCompatActivity {

    private static final String PREFS_NAME = "user_prefs";
    private static final String KEY_NAME = "name";
    private static final String KEY_TOPIC = "topic";

    private static final String LOG_FILENAME = "user_log.txt";

    private EditText etName;
    private EditText etTopic;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etName = findViewById(R.id.etName);
        etTopic = findViewById(R.id.etTopic);
        Button btnSavePrefs = findViewById(R.id.btnSavePrefs);
        Button btnWriteLog = findViewById(R.id.btnWriteLog);
        Button btnReadLog = findViewById(R.id.btnReadLog);

        // 啟動時，從 SharedPreferences 讀回上次設定，填入輸入框
        loadPrefs();

        btnSavePrefs.setOnClickListener(v -> savePrefs());
        btnWriteLog.setOnClickListener(v -> writeLog());
        btnReadLog.setOnClickListener(v -> readLog());
    }

    // ---------- SharedPreferences ----------
    private void loadPrefs() {
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE);
        etName.setText(prefs.getString(KEY_NAME, ""));   // 第二參數為預設值
        etTopic.setText(prefs.getString(KEY_TOPIC, ""));
    }

    private void savePrefs() {
        String name = etName.getText().toString().trim();
        String topic = etTopic.getText().toString().trim();

        if (name.isEmpty() || topic.isEmpty()) {
            Toast.makeText(this, "請填寫名稱與主題", Toast.LENGTH_SHORT).show();
            return;
        }

        getSharedPreferences(PREFS_NAME, MODE_PRIVATE)
                .edit()
                .putString(KEY_NAME, name)
                .putString(KEY_TOPIC, topic)
                .apply();     // apply() 非同步；commit() 同步
        Toast.makeText(this, "設定已儲存", Toast.LENGTH_SHORT).show();
    }

    // ---------- 內部儲存（檔案） ----------
    private void writeLog() {
        String content = "名稱：" + etName.getText() + "\n主題：" + etTopic.getText();

        // openFileOutput 會把檔案寫到 App 私有的 files 目錄
        try (FileOutputStream fos = openFileOutput(LOG_FILENAME, Context.MODE_PRIVATE)) {
            fos.write(content.getBytes(StandardCharsets.UTF_8));
            Toast.makeText(this, "已寫入 " + LOG_FILENAME, Toast.LENGTH_SHORT).show();
        } catch (Exception e) {
            Toast.makeText(this, "寫入失敗：" + e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    private void readLog() {
        StringBuilder sb = new StringBuilder();
        // 讀回同一個檔案
        try (FileInputStream fis = openFileInput(LOG_FILENAME);
             BufferedReader reader = new BufferedReader(new InputStreamReader(fis, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line).append("\n");
            }
        } catch (Exception e) {
            Toast.makeText(this, "讀取失敗（尚未寫入？）", Toast.LENGTH_SHORT).show();
            return;
        }

        new AlertDialog.Builder(this)
                .setTitle("日誌內容")
                .setMessage(sb.toString())
                .setPositiveButton("確定", null)
                .show();
    }
}
```

> 提示：`apply()` 較推薦（非同步寫入，主執行緒不阻塞），`commit()` 是同步且回傳布林。

---

## Step 4　執行與驗證

| 操作 | 預期結果 |
|---|---|
| 填名稱「小明」、主題「程式」→ 儲存設定 | Toast「設定已儲存」 |
| 把整個 App 從多工關閉再重開 | 輸入框自動帶回「小明」「程式」（SharedPreferences ✓） |
| 按「寫入日誌」 | Toast「已寫入 user_log.txt」 |
| 按「讀取日誌」 | AlertDialog 顯示「名稱：小明\n主題：程式」 |

> ✅ 完成。你已練習 SharedPreferences 與內部儲存檔案兩種持久化，並確認重開 App 資料仍在。

---

## 可練習擴充
- 用 `PreferenceDataStore`（較新 API）取代舊 SharedPreferences
- 把寫入的檔案路徑顯示出來：`getFilesDir().getAbsolutePath()`
- 加「清除設定」按鈕（`prefs.edit().clear().apply()`）