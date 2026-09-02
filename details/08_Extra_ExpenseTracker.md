# 額外完整範例：記帳 App（Expense Tracker）

> 這是一支**比三天專案更完整**的 App，整合了 Day 1～Day 3 所有已學技能：
> XML 佈局、View 綁定、RecyclerView + Adapter、Room 持久化、SharedPreferences、lambda。
> 全部檔案可直接編譯執行。套件名範例：`com.example.expenseapp`。

---

## 功能需求

- 記錄每一筆帳：項目名稱、金額、類別（收入 / 支出）
- 用 RecyclerView 顯示帳目清單
- 用 Room 永久保存每一筆帳
- 用 SharedPreferences 記住「上次輸入的類別」與「累計總額」快取
- 點擊 / 長按列可刪除

---

## 1. 依賴 `app/build.gradle`

```groovy
dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.recyclerview:recyclerview:1.3.0'
    implementation 'androidx.room:room-runtime:2.6.1'
    annotationProcessor 'androidx.room:room-compiler:2.6.1'
}
```

---

## 2. Entity：`Expense.java`

```java
package com.example.expenseapp;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "expense")
public class Expense {

    @PrimaryKey(autoGenerate = true)
    public int id;

    public String title;

    public double amount;

    public int type;   // 0 = 支出, 1 = 收入

    public Expense() {
    }

    public Expense(String title, double amount, int type) {
        this.title = title;
        this.amount = amount;
        this.type = type;
    }
}
```

---

## 3. DAO：`ExpenseDao.java`

```java
package com.example.expenseapp;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

@Dao
public interface ExpenseDao {

    @Insert
    void insert(Expense expense);

    @Delete
    void delete(Expense expense);

    @Query("SELECT * FROM expense ORDER BY id DESC")
    List<Expense> getAll();

    // 計算總額：SUM(支出) - SUM(收入)，用 COALESCE 處理空表回傳 0
    @Query("SELECT" +
            "  IFNULL(SUM(CASE WHEN type = 0 THEN amount END), 0)" +
            " - IFNULL(SUM(CASE WHEN type = 1 THEN amount END), 0)" +
            " FROM expense")
    double getTotal();
}
```

---

## 4. Database：`AppDatabase.java`

```java
package com.example.expenseapp;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

@Database(entities = {Expense.class}, version = 1)
public abstract class AppDatabase extends RoomDatabase {

    private static volatile AppDatabase instance;

    public abstract ExpenseDao expenseDao();

    public static AppDatabase getInstance(Context context) {
        if (instance == null) {
            synchronized (AppDatabase.class) {
                if (instance == null) {
                    instance = Room.databaseBuilder(
                            context.getApplicationContext(),
                            AppDatabase.class,
                            "expense.db"
                    ).build();
                }
            }
        }
        return instance;
    }
}
```

---

## 5. 單列佈局：`row_expense.xml`

路徑：`app/src/main/res/layout/row_expense.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:gravity="center_vertical"
    android:padding="16dp">

    <LinearLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:orientation="vertical">

        <TextView
            android:id="@+id/tvTitle"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textSize="16sp"
            android:textStyle="bold" />

        <TextView
            android:id="@+id/tvType"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textSize="12sp" />
    </LinearLayout>

    <TextView
        android:id="@+id/tvAmount"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:textSize="18sp"
        android:textStyle="bold" />

</LinearLayout>
```

---

## 6. Adapter：`ExpenseAdapter.java`

```java
package com.example.expenseapp;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;

public class ExpenseAdapter extends RecyclerView.Adapter<ExpenseAdapter.ExpenseViewHolder> {

    public interface OnItemClick {
        void onItemClick(Expense expense);
    }

    private final List<Expense> expenseList = new ArrayList<>();
    private final OnItemClick listener;

    public ExpenseAdapter(OnItemClick listener) {
        this.listener = listener;
    }

    @SuppressWarnings("NotifyDataSetChanged")
    public void setExpenses(List<Expense> newList) {
        expenseList.clear();
        expenseList.addAll(newList);
        notifyDataSetChanged();
    }

    @NonNull
    @Override
    public ExpenseViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.row_expense, parent, false);
        return new ExpenseViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ExpenseViewHolder holder, int position) {
        Expense expense = expenseList.get(position);
        holder.tvTitle.setText(expense.title);
        holder.tvType.setText(expense.type == 1 ? "收入" : "支出");

        String sign = expense.type == 1 ? "+" : "-";
        holder.tvAmount.setText(String.format("%s%,.0f", sign, expense.amount));
        // 支出顯示紅色、收入顯示綠色
        holder.tvAmount.setTextColor(holder.itemView.getContext()
                .getColor(expense.type == 1 ? android.R.color.holo_green_dark : android.R.color.holo_red_dark));

        // lambda：單一方法介面 OnItemClick → 可寫成 lambda
        holder.itemView.setOnClickListener(v -> listener.onItemClick(expense));
    }

    @Override
    public int getItemCount() {
        return expenseList.size();
    }

    static class ExpenseViewHolder extends RecyclerView.ViewHolder {
        TextView tvTitle;
        TextView tvType;
        TextView tvAmount;

        ExpenseViewHolder(@NonNull View itemView) {
            super(itemView);
            tvTitle = itemView.findViewById(R.id.tvTitle);
            tvType = itemView.findViewById(R.id.tvType);
            tvAmount = itemView.findViewById(R.id.tvAmount);
        }
    }
}
```

> 💡 這裡的 `OnItemClick` 只有一個方法，所以是 functional interface，可用 lambda。
> 又強調一次：RecyclerView 的 `onBindViewHolder`、`onCreateViewHolder`、`getItemCount` 是**方法覆寫**，不是 lambda。

---

## 7. 主畫面佈局：`activity_main.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <TextView
        android:id="@+id/tvTotal"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:textSize="24sp"
        android:textStyle="bold"
        android:text="總額： 0" />

    <EditText
        android:id="@+id/etTitle"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="項目名稱" />

    <EditText
        android:id="@+id/etAmount"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="金額"
        android:inputType="numberDecimal" />

    <RadioGroup
        android:id="@+id/radioGroup"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal">

        <RadioButton
            android:id="@+id/rbExpense"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="支出"
            android:checked="true" />

        <RadioButton
            android:id="@+id/rbIncome"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="收入" />
    </RadioGroup>

    <Button
        android:id="@+id/btnAdd"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="新增帳目" />

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/recyclerView"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_marginTop="16dp" />

</LinearLayout>
```

---

## 8. 主程式：`MainActivity.java`

```java
package com.example.expenseapp;

import android.app.AlertDialog;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    private EditText etTitle;
    private EditText etAmount;
    private RadioGroup radioGroup;
    private TextView tvTotal;
    private ExpenseDao dao;
    private ExpenseAdapter adapter;

    private static final String PREFS_NAME = "expense_prefs";
    private static final String KEY_LAST_TYPE = "last_type";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etTitle = findViewById(R.id.etTitle);
        etAmount = findViewById(R.id.etAmount);
        radioGroup = findViewById(R.id.radioGroup);
        tvTotal = findViewById(R.id.tvTotal);
        Button btnAdd = findViewById(R.id.btnAdd);
        RecyclerView recyclerView = findViewById(R.id.recyclerView);

        dao = AppDatabase.getInstance(this).expenseDao();

        // 從 SharedPreferences 讀回「上次選擇的類別」，恢復成預設選項
        SharedPreferences prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE);
        int lastType = prefs.getInt(KEY_LAST_TYPE, 0);
        radioGroup.check(lastType == 1 ? R.id.rbIncome : R.id.rbExpense);

        // 單一方法介面 → lambda
        adapter = new ExpenseAdapter(expense -> showDeleteDialog(expense));

        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);

        loadData();

        btnAdd.setOnClickListener(v -> addExpense());
    }

    private void loadData() {
        List<Expense> list = dao.getAll();
        adapter.setExpenses(list);

        double total = dao.getTotal();
        tvTotal.setText(String.format(Locale.TAIWAN, "總額：%,.0f 元", total));
    }

    private void addExpense() {
        String title = etTitle.getText().toString().trim();
        String amountStr = etAmount.getText().toString().trim();

        if (title.isEmpty() || amountStr.isEmpty()) {
            Toast.makeText(this, "請填寫項目與金額", Toast.LENGTH_SHORT).show();
            return;
        }

        double amount;
        try {
            amount = Double.parseDouble(amountStr);
        } catch (NumberFormatException e) {
            Toast.makeText(this, "金額格式錯誤", Toast.LENGTH_SHORT).show();
            return;
        }

        int selectedId = radioGroup.getCheckedRadioButtonId();
        RadioButton selected = findViewById(selectedId);
        int type = (selected.getId() == R.id.rbIncome) ? 1 : 0;

        // 用 SharedPreferences 記住這次選擇，下次開啟自動帶回
        getSharedPreferences(PREFS_NAME, MODE_PRIVATE)
                .edit()
                .putInt(KEY_LAST_TYPE, type)
                .apply();

        dao.insert(new Expense(title, amount, type));

        etTitle.setText("");
        etAmount.setText("");
        loadData();
    }

    private void showDeleteDialog(Expense expense) {
        new AlertDialog.Builder(this)
                .setTitle("刪除")
                .setMessage("確定要刪除「" + expense.title + "」嗎？")
                .setPositiveButton("刪除", (dialog, which) -> {
                    dao.delete(expense);
                    loadData();
                })
                .setNegativeButton("取消", null)
                .show();
    }
}
```

---

## 9. 建立與執行步驟

1. 依 Day 1 建立 **Empty Views Activity** 專案（Language = **Java**）
2. 依第 1 節加入 Room + RecyclerView 依賴，Sync
3. 新增 4 個 Java class：`Expense`、`ExpenseDao`、`AppDatabase`、`ExpenseAdapter`
4. 新增 `row_expense.xml` 與替換 `activity_main.xml`
5. 替換 `MainActivity.java`
6. Run 到模擬器

---

## 10. 測試流程與預期結果

| 步驟 | 操作 | 預期結果 |
|---|---|---|
| 1 | 輸入「午餐」、100、選「支出」→ 新增 | 列表出現「支出 午餐 -100」(紅色)，總額 = -100 |
| 2 | 輸入「薪水」、3000、選「收入」→ 新增 | 列表出現「收入 薪水 +3,000」(綠色)，總額 = 2,900 |
| 3 | 重開 App | 資料仍在，且「收入」按鈕已自動選中（SharedPreferences 生效） |
| 4 | 點任一列 | 跳出刪除確認框，確定後該列移除、總額更新 |

> ✅ 這支 App 用到了：**Room（持久化）+ RecyclerView（列表）+ SharedPreferences（記住設定）+ lambda + Adapter 模式**，
> 可以當作你自己的「三天學習總成果」專案，繼續擴充下去。

---

## 11. 可以繼續擴充（挑戰）

- 增加「日期」欄位，用 `@Query` 依月份篩選
- 用 `LiveData<Double>` 讓總額「自動」更新，不需要手動 `loadData()`
- 改成清單可用 DatePickerDialog 選日期
- 匯出成 CSV 檔寫入內部儲存
- 用 ItemTouchHelper 做滑動刪除動畫