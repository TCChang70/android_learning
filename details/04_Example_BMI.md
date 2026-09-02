# 範例專案：BMI 計算機（Day 1 完整程式碼）

> 這是一個可以直接照貼、編譯執行的完整專案。
> 路徑對照：`app/src/main/java/你的套件名/` 與 `app/src/main/res/layout/`
> 套件名範例：`com.example.bmicalc`

---

## 1. 佈局檔案 `activity_main.xml`

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

---

## 2. Java 程式 `MainActivity.java`

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

---

## 3. 執行方式

1. 依 Day 1 步驟建立 **Empty Views Activity** 專案，語言選 Java
2. 把上述 XML 覆蓋 `activity_main.xml`
3. 把上述 Java 覆蓋 `MainActivity.java`（套件名記得改成你的）
4. 啟動模擬器，點 ▶ Run 執行

---

## 4. 可以練習擴充

- 新增「Reset」按鈕清空輸入
- 用 `SharedPreferences` 記住上次輸入的身高體重（Day 3 技能）
- 顯示標準體重範圍
