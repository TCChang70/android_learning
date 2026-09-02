# 完整範例 06：活動報名名單（Day 3 應用 · 純 SQLite CRUD）

> 套件名範例：`com.example.signupapp`
> 用到技能：`SQLiteOpenHelper`、`SQLiteDatabase`、`Cursor`、SQL 的 INSERT/SELECT/DELETE、ListView + Adapter
> 目的：專欄練習**不使用 Room、直接寫 SQLite** 的完整 CRUD，補足你對底層 SQL 的掌握（與 Day 3 教材第 3 節對照）。

---

## 功能需求

- 輸入「姓名」與「電話」，按下「報名」寫入資料庫
- 用 ListView 顯示目前所有報名者
- 長按某一列 → AlertDialog 確認後刪除
- 重開 App，資料仍存在（真正的持久化）

---

## Step 1　建立專案

**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.signupapp`。

（此範例不需額外依賴，純 SDK 即可。）

---

## Step 2　佈局 `activity_main.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <EditText
        android:id="@+id/etName"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="姓名" />

    <EditText
        android:id="@+id/etPhone"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:hint="電話"
        android:inputType="phone" />

    <Button
        android:id="@+id/btnSignUp"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:text="報名" />

    <TextView
        android:id="@+id/tvCount"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="12dp"
        android:text="目前報名人數：0" />

    <ListView
        android:id="@+id/listView"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_marginTop="12dp" />

</LinearLayout>
```

---

## Step 3　資料庫助手 `DBHelper.java`

右鍵套件 → **New → Java Class**，名稱 `DBHelper`：

```java
package com.example.signupapp;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DBHelper extends SQLiteOpenHelper {

    private static final String DB_NAME = "signup.db";
    private static final int DB_VERSION = 1;

    public DBHelper(Context context) {
        super(context, DB_NAME, null, DB_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // 資料表只在資料庫第一次建立時執行
        db.execSQL("CREATE TABLE signup (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "name TEXT NOT NULL, " +
                "phone TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS signup");
        onCreate(db);
    }
}
```

---

## Step 4　`MainActivity.java`

```java
package com.example.signupapp;

import android.app.AlertDialog;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private DBHelper dbHelper;
    private EditText etName;
    private EditText etPhone;
    private TextView tvCount;
    private final ArrayList<String> displayList = new ArrayList<>();
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etName = findViewById(R.id.etName);
        etPhone = findViewById(R.id.etPhone);
        tvCount = findViewById(R.id.tvCount);
        Button btnSignUp = findViewById(R.id.btnSignUp);
        ListView listView = findViewById(R.id.listView);

        dbHelper = new DBHelper(this);

        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, displayList);
        listView.setAdapter(adapter);

        refreshList();

        btnSignUp.setOnClickListener(v -> signUp());

        // 長按列 → 刪除（OnItemLongClickListener，單一方法介面 → lambda）
        listView.setOnItemLongClickListener((parent, view, position, id) -> {
            confirmDelete(id);   // id = 該列在資料庫的主鍵
            return true;
        });
    }

    private void signUp() {
        String name = etName.getText().toString().trim();
        String phone = etPhone.getText().toString().trim();

        if (name.isEmpty()) {
            Toast.makeText(this, "請輸入姓名", Toast.LENGTH_SHORT).show();
            return;
        }

        SQLiteDatabase db = dbHelper.getWritableDatabase();
        // ? 佔位符：避免 SQL injection（對照 JDBC 的 PreparedStatement）
        db.execSQL("INSERT INTO signup (name, phone) VALUES (?, ?)",
                new Object[]{name, phone});
        db.close();

        etName.setText("");
        etPhone.setText("");
        refreshList();
    }

    private void refreshList() {
        displayList.clear();
        int count = 0;

        SQLiteDatabase db = dbHelper.getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT name, phone FROM signup ORDER BY id ASC", null);
        while (cursor.moveToNext()) {
            String name = cursor.getString(0);       // 第 0 欄 = name
            String phone = cursor.getString(1);      // 第 1 欄 = phone
            displayList.add(name + "  (" + phone + ")");
            count++;
        }
        cursor.close();
        db.close();

        adapter.notifyDataSetChanged();
        tvCount.setText("目前報名人數：" + count);
    }

    private void confirmDelete(long id) {
        new AlertDialog.Builder(this)
                .setTitle("取消報名")
                .setMessage("確定要刪除此筆嗎？")
                .setPositiveButton("刪除", (dialog, which) -> {
                    SQLiteDatabase db = dbHelper.getWritableDatabase();
                    db.execSQL("DELETE FROM signup WHERE id = ?", new Object[]{id});
                    db.close();
                    refreshList();
                })
                .setNegativeButton("取消", null)
                .show();
    }
}
```

### 程式重點解說
- `dbHelper.getReadableDatabase()` / `getWritableDatabase()` 取得資料庫物件。
- `Cursor` 很像 JDBC 的 ResultSet：`moveToNext()` + `getString(欄位索引)`。
- `db.execSQL("... ? ...", new Object[]{...})` 用 `?` 參數做置換，安全性較佳。
- `setOnItemLongClickListener` 只有一個方法，是 functional interface，所以 `(parent, view, position, id) -> {...}` 可用 lambda，須回傳 `true` 表示「已處理，不再觸發點擊事件」。

---

## Step 5　執行與驗證

| 操作 | 預期結果 |
|---|---|
| 姓名「王小明」電話「0912」→ 報名 | 列表出現「王小明 (0912)」，人數變 1 |
| 再報名「陳大華」 | 列表兩列，人數 2 |
| 重開 App | 資料仍在，人數 2（資料庫持久化 ✓） |
| 長按第一列 → 刪除 | 該列消失，人數 1 |

> ✅ 完成。你用純 SQLite 走完完整 CRUD（本範例含 Create、Read、Delete；Update 可參考 `UPDATE ... SET ... WHERE id = ?`）。

---

## 與 Room 對照（幫助你理解為何官方推 Room）

| 事項 | 純 SQLite（本範例） | Room |
|---|---|---|
| 建表 | 手寫 SQL 字串 | `@Entity` 註解自動產生 |
| 新增 | 手寫 INSERT | `@Insert void insert(...)` |
| 查詢 | Cursor + 手動迴圈 | `@Query` 回傳 `List<Memo>` |
| SQL 檢查時機 | 執行時期 | 編譯時期查錯 |
| 程式碼量 | 較多 | 較少 |

> 兩種你都懂了之後，就知道：「Room 只是幫你把上面這些 SQL/Cursor 樣板自動化」，底層仍是 SQLite。

---

## 可練習擴充
- 加「修改電話」：查該 id 後用 `UPDATE`
- 用 `SELECT COUNT(*)` 顯示人數（取代自己在 Java 計數）
- 加入搜尋姓名：`WHERE name LIKE ?`