# 完整範例 03：商品編輯傳值（Day 2 應用 · Intent + putExtra/getExtra）

> 套件名範例：`com.example.shopapp`
> 用到技能：多個 Activity、Intent 跳轉、`putExtra` / `getStringExtra`、new Activity 自動註冊
> 目的：練習「畫面 A 開畫面 B，B 回傳資料給 A 顯示」。

---

## 功能需求

- 畫面 A（MainActivity）：顯示一個商品，點「編輯」跳去畫面 B
- 畫面 B（EditActivity）：可修改商品名稱與價格
- 畫面 B 按「儲存」，把資料 **putExtra** 傳回 A 並顯示

---

## Step 1　建立專案

**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.shopapp`。

---

## Step 2　新增第二個 Activity（畫面 B）

在套件資料夾右鍵：**New → Activity → Empty Views Activity**
- 名稱：`EditActivity`

自動產生 `EditActivity.java` 與 `activity_edit.xml`，並且已在 `AndroidManifest.xml` 註冊。

> ☝️ 若你看到 Android Studio 下方的 Activity 範本選單，選最簡單的 Empty Views Activity 即可。

---

## Step 3　畫面 A 的佈局 `activity_main.xml`

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

---

## Step 4　畫面 B 的佈局 `activity_edit.xml`

**直接取代**精靈產生的 `activity_edit.xml`：

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

---

## Step 5　畫面 A 的程式 `MainActivity.java`

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

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvInfo = findViewById(R.id.tvInfo);
        Button btnEdit = findViewById(R.id.btnEdit);

        btnEdit.setOnClickListener(v -> openEdit());
    }

    // 用來接收 EditActivity 回傳結果的 launcher
    // (新版 Result API，取代舊的 onActivityResult)
    //   註冊契約 + 用 lambda result -> {...} 接收結果
    ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            result -> {
                if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                    goodsName = result.getData().getStringExtra("name");
                    goodsPrice = result.getData().getStringExtra("price");
                    tvInfo.setText("商品：" + goodsName + " / 價格：" + goodsPrice);
                }
            });

    private void openEdit() {
        Intent intent = new Intent(MainActivity.this, EditActivity.class);
        // 可把目前資料帶過去，讓編輯頁有初始值
        intent.putExtra("name", goodsName);
        intent.putExtra("price", goodsPrice);
        resultLauncher.launch(intent);
    }
}
```

> 💡 說明：上面註冊的寫法直接把 `resultLauncher` 欄位初始化。你也可以把欄位宣告放到 `onCreate` 之前，做法請對照你的 Android Studio 版本（新版支援欄位初始化）。

---

## Step 6　畫面 B 的程式 `EditActivity.java`

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

---

## Step 7　執行與驗證

1. Run，畫面 A 顯示「商品：手機 / 價格：9999」
2. 按「編輯商品」→ 跳去畫面 B，欄位已帶入「手機」「9999」
3. 改成「平板」「12900」→ 按「儲存並返回」
4. 回到畫面 A，顯示「商品：平板 / 價格：12900」✓

> ✅ 完成。你已練習：Intent 跳轉、雙向傳值（A→B、B→A）、setResult/finish。

---

## 兩種接收結果寫法的對照

| 寫法 | 適用 | 備註 |
|---|---|---|
| `registerForActivityResult(...)` | **新版推薦** | 用 lambda `result -> {...}`，本範例使用 |
| 舊 `onActivityResult(...)` | 較舊專案 | 是方法覆寫，**不能**用 lambda |

> 你教材 `02` 裡的 `onActivityResult` 是舊寫法；本範例用的是新版 Result API，兩者概念相同。