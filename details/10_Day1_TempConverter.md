# 完整範例 01：溫度轉換器（Day 1 應用）

> 套件名範例：`com.example.tempconvert`
> 用到技能：XML 佈局、EditText、RadioButton/RadioGroup、Button、TextView、事件處理、lambda
> 目的：在 BMI 之外，再加練「單選 + 條件轉換 + 數字驗證」。

---

## 功能需求

- 輸入一個溫度數值
- 用 RadioButton 選擇「C→F」或「F→C」轉換方向
- 按下按鈕，顯示轉換結果（保留 2 位小數）
- 輸入空白時用 Toast 提示

換算公式：
- C → F：`F = C × 9 / 5 + 32`
- F → C：`C = (F − 32) × 5 / 9`

---

## Step 1　建立專案

**File → New → New Project → Empty Views Activity**，Language 選 **Java**，Package `com.example.tempconvert`。

---

## Step 2　替換佈局 `activity_main.xml`

> 預期結果：設計畫面由上到下為 標題、輸入框、單選列、轉換按鈕、結果文字。

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

### 佈局重點解說
- `RadioGroup` 是**容器**，包住 `RadioButton`。同一個 RadioGroup 內的選項「互相排斥」。
- `android:checked="true"` 讓「攝氏→華氏」預設被選中。
- `inputType="numberDecimal|numberSigned"` 允許負數與小數（可輸入 -5.5）。

---

## Step 3　替換 `MainActivity.java`

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

### 程式重點解說
- `TextUtils.isEmpty()` 判斷是否空白（比 `""` 更嚴謹，也擋 null）。
- `radioGroup.getCheckedRadioButtonId()` 取得「目前被選中的 RadioButton 的資源 id」。
- `String.format("%.2f", result)` 四捨五入到 2 位小數（類似 Swing 的 `System.out.printf`）。

---

## Step 4　執行與驗證

| 輸入 | 選項 | 預期結果 |
|---|---|---|
| `100` | 攝氏→華氏 | `212.00` |
| `32` | 華氏→攝氏 | `0.00` |
| `-40` | 攝氏→華氏 | `-40.00` |
| （空白） | 任意 | Toast「請輸入溫度數值」 |

> ✅ 完成。你已練習：RadioGroup 單選、條件分支、數字輸入驗證、`String.format`。

---

## 可練習擴充
- 改用 `Spinner`（下拉清單）取代 RadioButton 選方向
- 同時顯示「轉換成兩種刻度」的結果
- 把上次輸入的數值存進 `SharedPreferences`