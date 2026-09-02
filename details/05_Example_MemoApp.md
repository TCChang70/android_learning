# 範例專案：備忘錄 Memo App（Day 3 完整 CRUD + Room）

> 這是一個整合 Day 2（RecyclerView）+ Day 3（Room）的完整可編譯專案。
> 套件名範例：`com.example.memoapp`
> 功能：新增 / 顯示 / 編輯 / 刪除備忘錄，資料用 Room 永久保存。

> ⚠️ 注意：此範例為了簡化教學，DAO 呼叫在主執行緒 (synchronous)。正式 App 建議使用 `LiveData` + background thread。本範例在小資料量下可正常運作。

---

## 1. 依賴 `app/build.gradle`

在 `dependencies` 區塊加入：

```groovy
dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.recyclerview:recyclerview:1.3.0'

    // Room
    implementation 'androidx.room:room-runtime:2.6.1'
    annotationProcessor 'androidx.room:room-compiler:2.6.1'
}
```

> 若使用 Java 就加 `annotationProcessor`；若用 Kotlin 才需 `kapt`。

---

## 2. Entity：`Memo.java`

路徑：`app/src/main/java/com/example/memoapp/Memo.java`

```java
package com.example.memoapp;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "memo")
public class Memo {

    @PrimaryKey(autoGenerate = true)
    public int id;

    public String title;

    public String content;

    public Memo() {
    }

    public Memo(String title, String content) {
        this.title = title;
        this.content = content;
    }
}
```

---

## 3. DAO：`MemoDao.java`

```java
package com.example.memoapp;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

@Dao
public interface MemoDao {

    @Insert
    void insert(Memo memo);

    @Update
    void update(Memo memo);

    @Delete
    void delete(Memo memo);

    @Query("SELECT * FROM memo ORDER BY id DESC")
    List<Memo> getAll();
}
```

---

## 4. Database：`AppDatabase.java`

```java
package com.example.memoapp;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

@Database(entities = {Memo.class}, version = 1)
public abstract class AppDatabase extends RoomDatabase {

    private static volatile AppDatabase instance;

    public abstract MemoDao memoDao();

    public static AppDatabase getInstance(Context context) {
        if (instance == null) {
            synchronized (AppDatabase.class) {
                if (instance == null) {
                    instance = Room.databaseBuilder(
                            context.getApplicationContext(),
                            AppDatabase.class,
                            "memo.db"
                    ).build();
                }
            }
        }
        return instance;
    }
}
```

---

## 5. 單列佈局：`row_memo.xml`

路徑：`app/src/main/res/layout/row_memo.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="vertical"
    android:padding="16dp">

    <TextView
        android:id="@+id/tvTitle"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:textSize="18sp"
        android:textStyle="bold" />

    <TextView
        android:id="@+id/tvContent"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:textSize="14sp" />

</LinearLayout>
```

---

## 6. Adapter：`MemoAdapter.java`

```java
package com.example.memoapp;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;

public class MemoAdapter extends RecyclerView.Adapter<MemoAdapter.MemoViewHolder> {

    public interface OnMemoClickListener {
        void onMemoClick(Memo memo, int position);
        void onMemoLongClick(Memo memo, int position);
    }

    private final List<Memo> memoList = new ArrayList<>();
    private final OnMemoClickListener listener;

    public MemoAdapter(OnMemoClickListener listener) {
        this.listener = listener;
    }

    // 用來更新整個列表資料
    @SuppressWarnings("NotifyDataSetChanged")
    public void setMemos(List<Memo> newList) {
        memoList.clear();
        memoList.addAll(newList);
        notifyDataSetChanged();
    }

    @NonNull
    @Override
    public MemoViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.row_memo, parent, false);
        return new MemoViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull MemoViewHolder holder, int position) {
        Memo memo = memoList.get(position);
        holder.tvTitle.setText(memo.title);
        holder.tvContent.setText(memo.content);

        holder.itemView.setOnClickListener(v ->
                listener.onMemoClick(memo, holder.getBindingAdapterPosition()));
        holder.itemView.setOnLongClickListener(v -> {
            listener.onMemoLongClick(memo, holder.getBindingAdapterPosition());
            return true;
        });
    }

    @Override
    public int getItemCount() {
        return memoList.size();
    }

    static class MemoViewHolder extends RecyclerView.ViewHolder {
        TextView tvTitle;
        TextView tvContent;

        MemoViewHolder(@NonNull View itemView) {
            super(itemView);
            tvTitle = itemView.findViewById(R.id.tvTitle);
            tvContent = itemView.findViewById(R.id.tvContent);
        }
    }
}
```

### 6.1 Lambda 對照：為什麼這裡的 listener「不能」用 lambda？

上面 `MemoAdapter.OnMemoClickListener` 介面**有兩個方法**（`onMemoClick` + `onMemoLongClick`），
它**不是「單一抽象方法」的 functional interface**，所以 **不能用 lambda 縮寫**，只能寫 anonymous class。

```java
// ❌ 無法編譯：因為 OnMemoClickListener 有兩個方法，lambda 無法表達「兩個」動作
// adapter = new MemoAdapter((memo, position) -> showEditDialog(memo));  // 錯！有兩個方法

// ✅ 正確：anonymous class（介面有數個方法時的唯一寫法）
adapter = new MemoAdapter(new MemoAdapter.OnMemoClickListener() {
    @Override
    public void onMemoClick(Memo memo, int position) { showEditDialog(memo); }

    @Override
    public void onMemoLongClick(Memo memo, int position) { showDeleteDialog(memo); }
});
```

**若要使用 lambda**，可把介面拆成**兩個單一方法介面**（Day 5 後的 clean code 技巧）：

```java
// 改成兩個函式介面（各自單一方法 → 都可用 lambda）
public interface OnMemoClick { void onClick(Memo memo, int position); }
public interface OnMemoLongClick { void onLongClick(Memo memo, int position); }

// 使用時（寫法直接、清楚）
adapter = new MemoAdapter(
        (memo, position) -> showEditDialog(memo),    // OnMemoClick
        (memo, position) -> showDeleteDialog(memo)); // OnMemoLongClick
```

> **重點總結**
> - 單一抽象方法介面 → 可用 lambda（`setOnClickListener`、`OnMemoClick`...）
> - 多個抽象方法介面 → 只能 anonymous class（`OnMemoClickListener`...）
> - lambda 的本質就是「單一方法匿名類別的語法糖」

> 另外，Adapter 內部 `onBindViewHolder` 的兩行（`v -> {...}`、`v -> {...}`）是**單一方法介面**，所以可以放心用 lambda（見上方程式碼）。

---

## 7. 主畫面佈局：`activity_main.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <EditText
        android:id="@+id/etTitle"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="標題" />

    <EditText
        android:id="@+id/etContent"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="內容" />

    <Button
        android:id="@+id/btnAdd"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="新增備忘錄" />

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
package com.example.memoapp;

import android.app.AlertDialog;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

public class MainActivity extends AppCompatActivity {

    private EditText etTitle;
    private EditText etContent;
    private MemoAdapter adapter;
    private MemoDao dao;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etTitle = findViewById(R.id.etTitle);
        etContent = findViewById(R.id.etContent);
        Button btnAdd = findViewById(R.id.btnAdd);
        RecyclerView recyclerView = findViewById(R.id.recyclerView);

        dao = AppDatabase.getInstance(this).memoDao();

        adapter = new MemoAdapter(new MemoAdapter.OnMemoClickListener() {
            @Override
            public void onMemoClick(Memo memo, int position) {
                showEditDialog(memo);   // 點擊 → 編輯
            }

            @Override
            public void onMemoLongClick(Memo memo, int position) {
                showDeleteDialog(memo); // 長按 → 刪除
            }
        });

        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);

        loadMemos();

        btnAdd.setOnClickListener(v -> addMemo());
        // ↑ lambda：等價於 new View.OnClickListener() { @Override public void onClick(View v) { addMemo(); } }
    }

    private void loadMemos() {
        List<Memo> memos = dao.getAll();
        adapter.setMemos(memos);
    }

    private void addMemo() {
        String title = etTitle.getText().toString().trim();
        String content = etContent.getText().toString().trim();

        if (title.isEmpty()) {
            Toast.makeText(this, "請輸入標題", Toast.LENGTH_SHORT).show();
            return;
        }

        Memo memo = new Memo(title, content);
        dao.insert(memo);
        etTitle.setText("");
        etContent.setText("");
        loadMemos();   // 重新載入
    }

    private void showEditDialog(Memo memo) {
        // 用兩個 EditText 的編輯對話框省略，可直接簡化為修改標題
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("編輯");

        final EditText input = new EditText(this);
        input.setText(memo.title);
        builder.setView(input);

        builder.setPositiveButton("儲存", (dialog, which) -> {
            memo.title = input.getText().toString();
            dao.update(memo);
            loadMemos();
        });

        // ↑ lambda 對照：等價於
        // builder.setPositiveButton("儲存", new DialogInterface.OnClickListener() {
        //     @Override
        //     public void onClick(DialogInterface dialog, int which) {
        //         memo.title = input.getText().toString();
        //         dao.update(memo);
        //         loadMemos();
        //     }
        // });
        builder.setNegativeButton("取消", null);
        builder.show();
    }

    private void showDeleteDialog(Memo memo) {
        new AlertDialog.Builder(this)
                .setTitle("刪除")
                .setMessage("確定要刪除「" + memo.title + "」嗎？")
                .setPositiveButton("刪除", (dialog, which) -> {
                    dao.delete(memo);
                    loadMemos();
                })
                .setNegativeButton("取消", null)
                .show();
        // ↑ 這裡的 (dialog, which) -> {...} 與上面「儲存」按鈕一樣，都是
        //   DialogInterface.OnClickListener 的 lambda（單一方法介面）
    }
}
```

---

## 9. 測試流程

1. 依 Day 1 建立 Empty Views Activity 專案（Java）
2. 貼上上述 8 個檔案（調整套件名）
3. 加入 Room 依賴
4. Run 到模擬器
5. 新增幾筆 → 關掉 App 重開 → 資料還在（持久化成功 ✓）
6. 點項目編輯、長按刪除

---

## 10. 可練習擴充

- 用 `TextView` 顯示資料筆數
- 加入「編輯內容」欄位（目前只編輯標題）
- 改用 `LiveData<List<Memo>>` 自動更新畫面（Room 官方建議）
- 加入搜尋功能 `@Query("... WHERE title LIKE :keyword")`
- 滑動刪除（ItemTouchHelper）
