# 完整範例 04：顏色選擇器（Day 2 應用 · Intent + RecyclerView + Adapter）

> 套件名範例：`com.example.colorpick`
> 用到技能：多個 Activity、Intent 跳轉、RecyclerView + Adapter、`putExtra`/`getExtra` 回傳
> 目的：把 Day 2 的「列表 + 跳轉 + 回傳」三個重點一次練完整。

---

## 功能需求

- 畫面 A：顯示目前選中的顏色名稱與色塊，按「選顏色」跳去畫面 B
- 畫面 B：用 **RecyclerView** 顯示一串現成顏色，點某一列 → 把該顏色名稱與色碼回傳給 A
- 畫面 A 收到後更新顯示

---

## Step 1　建立專案

**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.colorpick`。

接著新增畫面 B：右鍵套件 → **New → Activity → Empty Views Activity**，名稱 `ColorListActivity`。

在 `app/build.gradle` 加入 recyclerview 依賴 (如果專案未預設包含)：

```groovy
dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.recyclerview:recyclerview:1.3.0'
}
```

按 **Sync Now**。

---

## Step 2　畫面 A 佈局 `activity_main.xml`

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

> `View` 標籤可用來畫一個純色方塊（這裡當色塊）。`android:background="#888888"` 是十六進位顏色。

---

## Step 3　單列佈局 `row_color.xml`

右鍵 `res/layout` → **New → Layout Resource File**，名稱 `row_color`：

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

---

## Step 4　資料模型 `ColorData.java`

右鍵套件 → **New → Java Class**，名稱 `ColorData`：

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

---

## Step 5　Adapter `ColorAdapter.java`

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

> `OnColorClick` 只有一個方法，所以是 functional interface，可以用 lambda（見 Step 6 用法）。

---

## Step 6　畫面 B `activity_color_list.xml`

**取代精靈產生的** `activity_color_list.xml`：

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

---

## Step 7　畫面 A 程式 `MainActivity.java`

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

    // 新版 Result API：接收 ColorListActivity 回傳的結果
    ActivityResultLauncher<Intent> resultLauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            result -> {
                if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                    String name = result.getData().getStringExtra("name");
                    String hex = result.getData().getStringExtra("hex");
                    colorBlock.setBackgroundColor(Color.parseColor(hex));
                    tvName.setText(name + "  (" + hex + ")");
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

---

## Step 8　畫面 B 程式 `ColorListActivity.java`

```java
package com.example.colorpick;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

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

> 若記得在上註冊顏色前 `Toast`，可在此 `onCreate` 後補一行，例如按下沒選到時。
> 本範例重點是「點列 → setResult + finish 回 A」。

---

## Step 9　執行與驗證

1. Run，畫面 A 顯示灰色塊與「尚未選擇」
2. 按「選擇顏色」→ 畫面 B 列出 6 種顏色
3. 點「紅色」→ 回到 A，色塊變紅，文字變「紅色 (#FF0000)」✓

> ✅ 完成。你已一口氣練習：RecyclerView + Adapter、單一方法介面 lambda、Intent 跳轉、雙向傳值、setResult/finish。

---

## 可練習擴充
- 改成畫面 B 同時顯示名稱與色碼
- 用 `RadioButton` 開頭直接給訂一組預設色
- 把選色結果存進 SharedPreferences，下次開啟仍是上次的顏色