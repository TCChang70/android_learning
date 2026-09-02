# Day 3 合併版 — 資料持久化：SQLite / Room 資料庫 + SharedPreferences

> 本檔是 **Day 3 一天的完整教材**，將原分散的「教學 + 範例 + 測驗」整合為一個可一次讀完的文件。
> 對象：具備 Java 程式開發經驗，熟悉 JFrame 視窗程式開發（已完成 Day 1、Day 2）。
> 時間：約 6–8 小時。
> 與 JFrame 的對照會用 ⚡ 標記。

---

# 第 0 章　概觀：三種資料儲存方式

| 方式 | 適合 | JFrame 對照 | Day 3 項目 |
|---|---|---|---|
| `SharedPreferences` | 小型 key-value（設定、使用者偏好） | Properties 檔案 | ★ |
| 內部儲存 (File) | 檔案讀寫（文字、圖片） | `FileWriter` / `FileReader` | ★ |
| `SQLite / Room` | 結構化、多筆資料 CRUD | JDBC + 資料庫 | ★★★ |

> 先決：JFrame 用 JDBC + MySQL/檔案。Android 無法直接用 JDBC 連外部 DB，而是用內建的 **SQLite**
> （單一檔案資料庫），且官方強烈建議用 **Room** 封裝。

---

# 第 1 章　SharedPreferences（輕量 key-value）

> ⚡ **對照**：就像在 JFrame App 旁放一個 `config.properties`，存「上次的設定」。

```java
// 1. 取得 SharedPreferences（取名 "memo_prefs"，MODE_PRIVATE 表示這個 App 自己用）
SharedPreferences prefs = getSharedPreferences("memo_prefs", MODE_PRIVATE);

// 2. 寫入（需要 Editor）
SharedPreferences.Editor editor = prefs.edit();
editor.putString("username", "張三");
editor.putInt("counter", 5);
editor.apply();   // apply() 非同步較推薦；commit() 同步

// 3. 讀取
String name = prefs.getString("username", "預設值");
int counter = prefs.getInt("counter", 0);
```

**逐行說明（這整段通常寫在 Activity 的方法裡）**：
- `getSharedPreferences("memo_prefs", MODE_PRIVATE)`：**取得（或建立）一支偏好設定**。
  - 第一個參數是「設定檔名稱」——不同名稱就是不同檔。
  - `MODE_PRIVATE`：只有這個 App 能讀寫，是最安全、最常用的模式。
  - 回傳的 `SharedPreferences prefs` 就是「已開好的設定檔」。
- **寫入過程**（SharedPreferences 不能直接寫，需透過 `Editor`）：
  - `prefs.edit()`：取得一個「編輯器」。
  - `editor.putString("username", "張三");`：用「key → value」把一筆字串設檔。key 就是索引，之後用同名 key 讀回。
  - `editor.putInt("counter", 5);`：再存一筆整數。
  - `editor.apply();`：**真正把資料寫入記憶體 + 磁碟**。
    - `apply()`：非同步、較快，官方推薦。
    - `commit()`：同步、會回傳 boolean 表示是否成功，較慢但可拿結果。
- **讀取過程**：
  - `prefs.getString("username", "預設值")`：依 key 讀字串；**第二參數是「key 不存在時回傳的預設值」**，避免空值。
  - `prefs.getInt("counter", 0)`：同上讀整數，預設 `0`。

常見用途：記住登入狀態、上次選的選項、計數器。

---

# 第 2 章　內部儲存（File 讀寫）

> Android 每個 App 有自己私有的 `files` 目錄，不需權限。

```java
// 寫檔
String filename = "mydata.txt";
String content = "這是檔案內容";
try (FileOutputStream fos = openFileOutput(filename, Context.MODE_PRIVATE)) {
    fos.write(content.getBytes());
} catch (IOException e) {
    e.printStackTrace();
}

// 讀檔
try (FileInputStream fis = openFileInput(filename);
     BufferedReader reader = new BufferedReader(new InputStreamReader(fis))) {
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = reader.readLine()) != null) {
        sb.append(line);
    }
    String text = sb.toString();
} catch (IOException e) {
    e.printStackTrace();
}
```

**逐行說明（寫檔）**：
- `String filename = "mydata.txt";`：檔名（不用寫絕對路徑，Android 自動放在 App 專屬的 `files` 目錄）。
- `String content = "這是檔案內容";`：要寫入的文字。
- `try (FileOutputStream fos = openFileOutput(...))`：**try-with-resources**——括號內開啟輸出串流，結束後自動關閉（不用手動 `close()`）。
  - `openFileOutput(filename, Context.MODE_PRIVATE)`：開啟（或建立）檔案的輸出串流；`MODE_PRIVATE` 表示私有。
  - `fos.write(content.getBytes());`：把字串轉成位元組後寫進檔案。
- `catch (IOException e) { e.printStackTrace(); }`：檔案操作可能失敗（如空間不足），抓到例外印出來。

**逐行說明（讀檔）**：
- `try (FileInputStream fis = openFileInput(filename); BufferedReader reader = ...)`：開啟輸入串流，再用 `BufferedReader` 包起來（能逐行讀）。
- `StringBuilder sb = new StringBuilder();`：累加每行內容的容器。
- `while ((line = reader.readLine()) != null)`：**讀到檔案尾（null）為止**，把每一行累加進 `sb`。
- `String text = sb.toString();`：把累加的內容組合回完整文字。
- `catch (IOException e) { e.printStackTrace(); }`：讀檔失敗時的例外處理。

> JFrame 的 `new FileWriter(...)` 對應到 `openFileOutput(...)`，好處是不用管絕對路徑，Android 自動放到 App 私有區。

---

# 第 3 章　SQLite（直接寫 SQL）

### 3.1 用 SQLiteOpenHelper 建立資料庫

```java
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DBHelper extends SQLiteOpenHelper {

    private static final String DB_NAME = "memo.db";
    private static final int DB_VERSION = 1;

    public DBHelper(Context context) {
        super(context, DB_NAME, null, DB_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // 建立資料表（只在資料庫第一次建立時執行）
        db.execSQL("CREATE TABLE memo (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "title TEXT NOT NULL, " +
                "content TEXT, " +
                "created_at TEXT DEFAULT CURRENT_TIMESTAMP)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // 版本升級時執行（例如新增欄位）
        db.execSQL("DROP TABLE IF EXISTS memo");
        onCreate(db);
    }
}
```

**程式說明（DBHelper ＝ 資料庫管理器）**：
- `extends SQLiteOpenHelper`：繼承 Android 內建的「SQLite 開啟輔助器」，它會管理資料庫的建立與版本。
- `DB_NAME = "memo.db"`：資料庫檔名。`DB_VERSION = 1`：資料庫版本號。
- `public DBHelper(Context context)`：建構子。`super(context, DB_NAME, null, DB_VERSION)` 呼叫父類別：
  - `context`（要用來開檔的環境）、`DB_NAME`（檔名）、`null`（可選的 CursorFactory，通常用 null）、`DB_VERSION`（版本）。
- `onCreate(SQLiteDatabase db)`：**資料庫「首次建立」時**只執行一次——這裡用 `execSQL` 執行 `CREATE TABLE` 建資料表。
  - `id INTEGER PRIMARY KEY AUTOINCREMENT`：自動遞增的主鍵。
  - `title TEXT NOT NULL`：必填欄位。
  - `content TEXT`：允許空的欄位。
  - `created_at TEXT DEFAULT CURRENT_TIMESTAMP`：預設塞「目前時間」字串。
- `onUpgrade(db, oldVersion, newVersion)`：**版本號變大時**執行（例如你改了表結構）。此處示範最簡單粗暴：先 `DROP` 刪掉舊表再重建（注意這會**遺失資料**，正式環境應做欄位遷移）。

### 3.2 CRUD 操作

```java
DBHelper helper = new DBHelper(this);
SQLiteDatabase db = helper.getWritableDatabase();

// CREATE（新增）
db.execSQL("INSERT INTO memo (title, content) VALUES (?, ?)",
        new Object[]{"標題", "內容"});   // ? 為參數，避免 SQL injection

// READ（查詢所有）
Cursor cursor = db.rawQuery("SELECT id, title FROM memo", null);
while (cursor.moveToNext()) {
    int id = cursor.getInt(0);
    String title = cursor.getString(1);
}
cursor.close();

// UPDATE（修改）
db.execSQL("UPDATE memo SET title = ? WHERE id = ?",
        new Object[]{"新標題", 1});

// DELETE（刪除）
db.execSQL("DELETE FROM memo WHERE id = ?", new Object[]{1});

db.close();
```

**逐段說明（這段「半成品」請放在 Activity 的方法內，`this` 就是該 Activity）**：
- `DBHelper helper = new DBHelper(this);`：建立資料庫管理器（`this` 指目前的 Activity，因為 SQLiteOpenHelper 需要 Context）。
- `SQLiteDatabase db = helper.getWritableDatabase();`：取得「可寫」的資料庫物件，之後所有 SQL 都由這個 `db` 執行。
- **CREATE**：`db.execSQL("INSERT INTO memo (title, content) VALUES (?, ?)", new Object[]{"標題", "內容"})`——用 `?` 當參數佔位，再用第二個引數陣列帶入實際值。**這是避免 SQL injection 的正確寫法**（如同 JDBC 的 `PreparedStatement`）。
- **READ**：
  - `db.rawQuery("SELECT id, title FROM memo", null)`：執行查詢，回傳一個 `Cursor`（指標，游標）。
  - `while (cursor.moveToNext())`：**逐列移動**，直到沒有下一列為止（類似 JDBC `next()`）。
  - `cursor.getInt(0)`、`cursor.getString(1)`：依**欄位索引**（從 0 起）取值。
  - `cursor.close()`：用完記得關閉，釋放資源。
- **UPDATE**：`UPDATE memo SET title = ? WHERE id = ?`——用 `?` 帶新標題與 `id`。
- **DELETE**：`DELETE FROM memo WHERE id = ?`——依 `id` 刪除。
- `db.close()`：**用完要關閉資料庫**，否則可能洩漏資源。

> ⚡ 這與你在 JFrame 用 JDBC `Statement`/`PreparedStatement` 很類似，只是 db 是內建的、SQLite 語法，且用 `?` 參數。

### 3.3 Cursor 是什麼？

`Cursor` 像 JDBC 的 `ResultSet`，`moveToNext()` 像 `next()`，`getString/getInt` 依欄位索引取值。

---

# 第 4 章　Room（官方推薦的 ORM）

原生 SQLite 要手動寫 SQL 與 Cursor，容易出錯。**Room** 用註解自動產生程式碼，像 JPA / Hibernate 的概念。

> ⚡ **對照**：Room 對你猶如 JPA 對 JDBC——靠註解 + 介面方法，少寫 SQL。

### 4.1 在 build.gradle 加入依賴

```groovy
dependencies {
    implementation "androidx.room:room-runtime:2.6.1"
    annotationProcessor "androidx.room:room-compiler:2.6.1"
}
```

**說明**：
- `implementation "androidx.room:room-runtime:2.6.1"`：**執行期**需要的 Room 函式庫。
- `annotationProcessor "androidx.room:room-compiler:2.6.1"`：**編譯期**的工具。Room 會掃描你的 `@Entity`/`@Dao`/`@Database` 註解，**自動產生**真正能跑的資料庫程式碼——這一步就是「ORM 魔法來源」。
- 加完記得 **Sync / Sync Now**。

> ⚠️ 若是 Java 專案請用 `annotationProcessor`，**不是** `kapt`（那是 Kotlin 用的）。詳見 `Appendix_D_Gradle_Setup.md`。

### 4.2 三個核心部分

**① Entity（資料表）**
```java
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "memo")
public class Memo {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public String title;
    public String content;
}
```

**程式說明（Entity＝一張資料表的模型）**：
- `@Entity(tableName = "memo")`：告訴 Room「這個類別對應資料表 `memo`」。
- `@PrimaryKey(autoGenerate = true) public int id;`：`id` 是**自動遞增的主鍵**（類似 SQLite 的 `AUTOINCREMENT`），新增時自動給值。
- `public String title;` `public String content;`：其他欄位；每個欄位對應資料表一個欄（名稱與欄位名相同）。
- Room 會自動建立資料表、欄位，完全不用你寫 `CREATE TABLE`。

**② DAO（資料操作介面）**
```java
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;
import androidx.room.Delete;
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

**程式說明（DAO＝資料操作介面，取代手寫 SQL 存取）**：
- `@Dao`：標記這是「資料存取物件」介面——**只寫方法簽名，不寫實作**，Room 自動產生實作。
- `@Insert void insert(Memo memo);`：新增。Room 自動寫好 `INSERT`。
- `@Update void update(Memo memo);`：依主鍵更新。
- `@Delete void delete(Memo memo);`：依主鍵刪除。
- `@Query("SELECT * FROM memo ORDER BY id DESC") List<Memo> getAll();`：**自訂查詢**——這支要寫查詢語法（因為有多種可能）。`ORDER BY id DESC` 讓最新一筆排最前面。

**③ Database（資料庫實例，單例）**
```java
import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import android.content.Context;

@Database(entities = {Memo.class}, version = 1)
public abstract class AppDatabase extends RoomDatabase {
    private static AppDatabase instance;

    public abstract MemoDao memoDao();

    public static AppDatabase getInstance(Context context) {
        if (instance == null) {
            instance = Room.databaseBuilder(context.getApplicationContext(),
                    AppDatabase.class, "memo.db").build();
        }
        return instance;
    }
}
```

**程式說明（Database＝資料庫入口，單例）**：
- `@Database(entities = {Memo.class}, version = 1)`：宣告「這個資料庫包含 `Memo` 這張表、版本 1」。
- `extends RoomDatabase`：是資料庫的抽象基底類別。
- `public abstract MemoDao memoDao();`：**抽象方法回傳 DAO**——Room 會實作，你呼叫它取得 DAO 來做事。
- **單例模式 `getInstance(context)`**：確保整個 App 只有「一個」資料庫實例，避免重複開檔。
  - `if (instance == null)`：第一次才建立。
  - `Room.databaseBuilder(...)`：用 Builder 建立資料庫，檔名 `memo.db`，`.build()` 完成。
  - 之後每次呼叫都回傳同一個 `instance`，省資源又安全。

### 4.3 使用 Room（CRUD）

```java
MemoDao dao = AppDatabase.getInstance(this).memoDao();

// 新增
Memo memo = new Memo();
memo.title = "第一個待辦";
memo.content = "練習 Room";
dao.insert(memo);

// 查詢
List<Memo> list = dao.getAll();

// 修改
memo.title = "更新後的標題";
dao.update(memo);

// 刪除
dao.delete(memo);
```

**逐段說明（這段「半成品」請放在 Activity 的方法內，`this` 即該 Activity）**：
- `AppDatabase.getInstance(this).memoDao()`：**取得單例資料庫 → 再取得 DAO**。之後所有資料操作都透過 `dao`。
- **新增**：`new Memo()` → 填入 `title`/`content` → `dao.insert(memo)`。Room 自動建表、自動給 `id`。
- **查詢**：`dao.getAll()` 回傳整包 `List<Memo>`，可直接交給 Adapter 顯示。
- **修改**：把 `memo.title` 改掉後 `dao.update(memo)`，Room 依主鍵找到那一筆更新。
- **刪除**：`dao.delete(memo)` 依主鍵刪除。

> 注意：Room 在正式環境建議用 **LiveData / Flow** + background thread。Day 3 為了先求理解，範例用同步方式，但會提示非同步的重要性。

---

# 第 5 章　完整範例一：備忘錄 Memo App（Room CRUD + RecyclerView）

> 這是一個整合 Day 2（RecyclerView）+ Day 3（Room）的完整可編譯專案。
> 套件名範例：`com.example.memoapp`。功能：新增 / 顯示 / 編輯 / 刪除備忘錄，資料用 Room 永久保存。

> ⚠️ 注意：此範例為了簡化教學，DAO 呼叫在主執行緒 (synchronous)。正式 App 建議使用 `LiveData` + background thread。本範例在小資料量下可正常運作。

### 5-1 依賴 `app/build.gradle`

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

**說明**：`recyclerview`（列表）、`material`（Material 元件）、`appcompat`（相容性 AppCompatActivity）為 UI 依賴；`room-runtime` + `room-compiler` 為資料持久化依賴（見第 4 章）。加完記得 **Sync**。

### 5-2 Entity：`Memo.java`

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

**程式說明（Memo＝資料表模型）**：
- `@Entity(tableName = "memo")`：對應資料表 `memo`。
- `@PrimaryKey(autoGenerate = true) public int id;`：自動遞增主鍵。
- `public String title;` / `public String content;`：兩個資料欄位。
- `Memo()`：**無參數建構子**——Room 反序列化（從資料庫讀回物件）時需要它，**不可省略**。
- `Memo(String title, String content)`：方便在新增時用 `new Memo(title, content)` 一次填入，`id` 交給 Room 自動指定。

### 5-3 DAO：`MemoDao.java`

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

**程式說明（MemoDao＝資料操作介面）**：
- `@Dao`：標記為資料存取物件，Room 自動產生實作程式碼。
- `@Insert void insert(Memo memo);`：新增一筆。
- `@Update void update(Memo memo);`：依主鍵更新一筆。
- `@Delete void delete(Memo memo);`：依主鍵刪除一筆。
- `@Query("SELECT * FROM memo ORDER BY id DESC") List<Memo> getAll();`：**自訂查詢**——抓全部並依 `id` 倒序（最新的在最上面），`List<Memo>` 可直接交給 Adapter 顯示。

### 5-4 Database：`AppDatabase.java`

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

**程式說明（AppDatabase＝資料庫入口）**：
- `@Database(entities = {Memo.class}, version = 1)`：包含 `Memo` 表、版本 1。
- `private static volatile AppDatabase instance;`：**單例欄位**。`volatile` 確保多執行緒下讀到的 `instance` 一定是最新的，不會看到「半建好的」物件。
- `public abstract MemoDao memoDao();`：抽象方法，Room 產生實作回傳 DAO。
- `getInstance(context)` 使用**「雙重檢查鎖定」（double-checked locking）**單例：
  - 外層 `if (instance == null)`：先快速判斷，避免每次都加鎖。
  - `synchronized (AppDatabase.class)`：只有第一次建立時才真正加鎖，確保只建立一個。
  - 內層再 `if (instance == null)`：**雙重檢查**——避免兩條執行緒同時進到鎖裡重複建立。
  - `context.getApplicationContext()`：用 App 全域 Context，避免持有 Activity 造成記憶體洩漏。
  - `.build()` 建立檔名 `memo.db` 的資料庫。
- 整個 App 只會有一個資料庫實例，省資源且避免資料競爭。

### 5-5 單列佈局：`row_memo.xml`

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

**佈局說明（RecyclerView 每一列的樣板）**：
- 根為「垂直」的 `LinearLayout`，`padding="16dp"` 讓每列文字留邊距。
- `tvTitle`：顯示標題，較大（18sp）且加粗。
- `tvContent`：顯示內容，較小（14sp）。
- 這支檔的作用：告訴 RecyclerView「每一列長什麼樣」。會被 `MemoAdapter` 的 `onCreateViewHolder` 用來 inflate。

### 5-6 Adapter：`MemoAdapter.java`

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

**程式說明（MemoAdapter＝RecyclerView 的「橋接器」與行列事件的對外窗口）**：
- `extends RecyclerView.Adapter<MemoViewHolder>`：固定要覆寫三個方法 `onCreateViewHolder` / `onBindViewHolder` / `getItemCount`。
- **自訂監聽介面 `OnMemoClickListener`**：定義「點擊」與「長按」兩個動作。Adapter 自己不處理業務邏輯，而是**交出通知**給 Activity 決定做什麼（新增/編輯/刪除）。
  - 注意它有**兩個方法** → 不是 functional interface → **無法用 lambda 建立**（下方有專節討論）。
- `private final List<Memo> memoList = new ArrayList<>();`：Adapter 內部保存要顯示的資料。
- `setMemos(newList)`：**更新整批資料**——先清空再 `addAll`，最後 `notifyDataSetChanged()` 叫 RecyclerView 重畫。
- `onCreateViewHolder(parent, viewType)`：**「建立」一個矩形的 ViewHolder**——用 `LayoutInflater` 把 `row_memo.xml` inflate 成 View，包進 `MemoViewHolder`。只會在「需要新的一列棒子」時才呼叫，不會每列都建。
- `onBindViewHolder(holder, position)`：**把資料「塞」進這列**——依 `position` 取出 `Memo`，寫進 `tvTitle`/`tvContent`。
  - 接著掛上整列的監聽：點擊 → `listener.onMemoClick(...)`；長按 → `listener.onMemoLongClick(...)` 且回 `true`（表示已處理，不觸發點擊）。
  - `holder.getBindingAdapterPosition()`：拿「目前位置」，比存進去的 `position` 更安全（資料變動時位置可能位移）。
- `getItemCount()`：回傳資料筆數。
- **`MemoViewHolder`（靜態內部類別）**：緩存每一列的 `TextView` 參考，避免每次 `findViewById` 重建，是 RecyclerView 高效能關鍵。`super(itemView)` 傳入整列根 View。

**Lambda 對照：為什麼這裡的 listener「不能」用 lambda？**

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

**若要使用 lambda**，可把介面拆成**兩個單一方法介面**（clean code 技巧）：

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

### 5-7 主畫面佈局：`activity_main.xml`

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

**佈局說明（主畫面）**：根為垂直 `LinearLayout`。
- `etTitle` / `etContent`：標題與內容兩個輸入框（用 `hint` 顯示灰底提示文字）。
- `btnAdd`：新增按鈕。
- `RecyclerView`：**資料列表佔滿剩餘空間**（`layout_height="match_parent"`），`marginTop` 與輸入區隔開。列表內容由程式中的 Adapter 動態填入。

### 5-8 主程式：`MainActivity.java`

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
    }
}
```

**程式說明（MainActivity＝主控程式）**：

**成員欄位**：`etTitle`/`etContent`（輸入框）、`adapter`（列表橋接器）、`dao`（資料操作介面——整支 App 的核心資料入口）。

**onCreate（畫面建立時執行一次）**：
- `setContentView(R.layout.activity_main);`：載入佈局。
- 四個 `findViewById(...)`：把 XML 元件與程式變數綁定。
- `dao = AppDatabase.getInstance(this).memoDao();`：**取得 DAO**，之後所有增刪改查都透過它。
- 建立 `adapter`：因為 `OnMemoClickListener` 是**兩個方法**的介面，必須用 **anonymous class**（不能用 lambda）：
  - `onMemoClick → showEditDialog(memo)`（點擊＝編輯）
  - `onMemoLongClick → showDeleteDialog(memo)`（長按＝刪除）
- 設定列表：`setLayoutManager(new LinearLayoutManager(this))`（垂直單欄排列）+ `setAdapter(adapter)`。
- `loadMemos();`：啟動就載入既有資料。
- `btnAdd.setOnClickListener(v -> addMemo());`：新增按鈕；**單一方法**介面 → 可用 lambda。

**loadMemos()**：`dao.getAll()` 抓全部 → `adapter.setMemos(memos)` 更新列表（會觸發重繪）。

**addMemo()（新增）**：
- `etTitle.getText().toString().trim()`：取出輸入文字並去除空白。
- 標題為空 → `Toast` 提示並 `return`（不做新增）。
- `new Memo(title, content)` → `dao.insert(memo)` 寫入資料庫。
- 清空輸入框 → `loadMemos()` 重新載入（新資料立刻出現）。

**showEditDialog(memo)（點擊編輯）**：
- 用一個**動態建立的 `EditText`** 當輸入框，`setView(input)` 放進對話框。
- 「儲存」按鈕：`(dialog, which) -> { memo.title = ...; dao.update(memo); loadMemos(); }`——因 `DialogInterface.OnClickListener` 只有一個方法，可 lambda。更新後重載列表。

**showDeleteDialog(memo)（長按刪除）**：流式（builder chain）建立 AlertDialog，確認後 `dao.delete(memo)` + 重新載入。

> 重點：主執行緒直接呼叫同步 DAO 是為教學簡化；正式 App 建議用 background thread + LiveData（見第 4 章提醒）。

### 5-9 測試流程

1. 建立 Empty Views Activity 專案（Java）
2. 貼上上述檔案（調整套件名），加入 Room 依賴
3. Run 到模擬器
4. 新增幾筆 → 關掉 App 重開 → 資料還在（持久化成功 ✓）
5. 點項目編輯、長按刪除

> 想親眼看到資料庫內容：**View → Tool Windows → App Inspection → 資料庫**，可瀏覽 `memo.db` 的 `memo` 資料表。

### 5-10 可練習擴充

- 用 `TextView` 顯示資料筆數
- 加入「編輯內容」欄位
- 改用 `LiveData<List<Memo>>` 自動更新畫面（Room 官方建議）
- 加入搜尋功能 `@Query("... WHERE title LIKE :keyword")`
- 滑動刪除（ItemTouchHelper）

---

# 第 6 章　完整範例二：使用者設定（SharedPreferences + 內部儲存）

> 套件名範例：`com.example.usersettings`
> 用到技能：SharedPreferences 讀寫、內部儲存檔案寫入/讀取、EditText、AlertDialog
> 目的：把 Day 3 前兩種「非資料庫」持久化技巧實際跑一遍。

### 6-1 功能需求

- 填寫「名稱」與「喜好主題」（兩欄文字）
- 「儲存設定」：把名稱+主題存成 **SharedPreferences**（下次開啟自動帶回）
- 「寫入日誌」：把目前的設定內容**寫成一個檔案**到内部儲存
- 「讀取日誌」：讀回該檔案並用 AlertDialog 顯示

### 6-2 步驟

**Step 1 建立專案**：**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.usersettings`。

**Step 2 佈局 `activity_main.xml`**：

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

**佈局說明**：根為垂直 `LinearLayout`。
- 大標題 `TextView`「使用者設定」。
- `etName` / `etTopic`：名稱與喜好主題兩個輸入框。
- `btnSavePrefs`：**儲存到 SharedPreferences**。
- `btnWriteLog`：**把設定寫成檔案**（內部儲存）。
- `btnReadLog`：**讀回檔案**顯示。

**Step 3 `MainActivity.java`**：

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

**程式說明（MainActivity＝一次整合 SharedPreferences 與內部儲存）**：

**常數定義**：
- `PREFS_NAME = "user_prefs"`：SharedPreferences 檔名。
- `KEY_NAME` / `KEY_TOPIC`：設定檔的 key（索引）。
- `LOG_FILENAME = "user_log.txt"`：內部儲存檔案名。

**onCreate**：綁定全部元件；呼叫 `loadPrefs()` 在啟動時讀回上次設定；三個按鈕各掛一個監聽（皆單一方法介面 → lambda）。

**SharedPreferences 部分**：
- `loadPrefs()`：`getSharedPreferences(PREFS_NAME, MODE_PRIVATE)` 開檔 → `prefs.getString(KEY_NAME, "")` **依 key 讀值，第二參數是預設值**（第一次開啟沒資料就給空字串）→ `setText` 填入輸入框。
- `savePrefs()`：取自輸入框的內容，檢查非空後，用「**流式串接**」`getSharedPreferences(...).edit().putString().putString().apply()` 一次存兩筆。`apply()` 非同步較推薦。

**內部儲存（檔案）部分**：
- `writeLog()`：組出「名稱：…\n主題：…」字串 → `openFileOutput(LOG_FILENAME, MODE_PRIVATE)` **開到 App 私有 files 目錄的檔** → `fos.write(content.getBytes(UTF_8))` 寫入（用 UTF-8 避免中文亂碼）。
- `readLog()`：`openFileInput` + `BufferedReader` **逐行讀**組回字串；若檔不存在（未寫過）→ catch 後 Toast「讀取失敗」並 `return`。最後用 AlertDialog 顯示內容。

> 提示：`apply()` 較推薦（非同步寫入，主執行緒不阻塞），`commit()` 是同步且回傳布林。

> 提示：`apply()` 較推薦（非同步寫入，主執行緒不阻塞），`commit()` 是同步且回傳布林。

**Step 4 執行與驗證**：

| 操作 | 預期結果 |
|---|---|
| 填名稱「小明」、主題「程式」→ 儲存設定 | Toast「設定已儲存」 |
| 把整個 App 從多工關閉再重開 | 輸入框自動帶回「小明」「程式」（SharedPreferences ✓） |
| 按「寫入日誌」 | Toast「已寫入 user_log.txt」 |
| 按「讀取日誌」 | AlertDialog 顯示「名稱：小明\n主題：程式」 |

> ✅ 完成。你已練習 SharedPreferences 與內部儲存檔案兩種持久化，並確認重開 App 資料仍在。

**可練習擴充**：用 `PreferenceDataStore`（較新 API）取代舊 SharedPreferences、把寫入的檔案路徑顯示出來：`getFilesDir().getAbsolutePath()`、加「清除設定」按鈕（`prefs.edit().clear().apply()`）。

---

# 第 7 章　完整範例三：活動報名名單（純 SQLite CRUD）

> 套件名範例：`com.example.signupapp`
> 用到技能：`SQLiteOpenHelper`、`SQLiteDatabase`、`Cursor`、SQL 的 INSERT/SELECT/DELETE、ListView + Adapter
> 目的：專欄練習**不使用 Room、直接寫 SQLite** 的完整 CRUD，補足你對底層 SQL 的掌握（對照第 3 章）。

### 7-1 功能需求

- 輸入「姓名」與「電話」，按下「報名」寫入資料庫
- 用 ListView 顯示目前所有報名者
- 長按某一列 → AlertDialog 確認後刪除
- 重開 App，資料仍存在（真正的持久化）

### 7-2 步驟

**Step 1 建立專案**：**File → New → New Project → Empty Views Activity**，Language **Java**，Package `com.example.signupapp`。（此範例不需額外依賴，純 SDK 即可。）

**Step 2 佈局 `activity_main.xml`**：

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

**佈局說明**：根為垂直 `LinearLayout`。
- `etName` / `etPhone`：姓名與電話輸入框（`inputType="phone"` 會彈出數字鍵盤）。
- `btnSignUp`：報名按鈕。
- `tvCount`：顯示「目前報名人數」的文字（預設 0）。
- `ListView`：**佔滿剩餘空間**的報名列表（用 Day 2 學會的 ArrayAdapter 方式）。

**Step 3 資料庫助手 `DBHelper.java`**（右鍵套件 → **New → Java Class**，名稱 `DBHelper`）：

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

**程式說明（DBHelper＝SQLite 的建立與版本管理）**（與第 3 章的 `DBHelper` 幾乎相同，只是表名前綴不同）：
- `extends SQLiteOpenHelper`：內建的「開啟輔助器」。
- `DB_NAME = "signup.db"`：資料庫檔名；`DB_VERSION = 1`：版本號。
- `onCreate`：**首次建立**時建 `signup` 表（`id` 自動遞增主鍵、`name` 必填、`phone` 可空）。
- `onUpgrade`：版本升級時先 `DROP` 再重建（示範用，會清空資料）。

**Step 4 `MainActivity.java`**：

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

程式重點解說（MainActivity＝純 SQLite CRUD 主控）：

**成員欄位**：`dbHelper`（資料庫管理器）、`etName`/`etPhone`（輸入框）、`tvCount`（人數文字）、`displayList`（給列表顯示的字串清單）、`adapter`（ListView 橋接器）。

**onCreate**：
- 綁定元件後 `dbHelper = new DBHelper(this);` **建立資料庫管理器**。
- `adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, displayList);`——用**內建單行樣板** `simple_list_item_1` 接上 `displayList`，再 `listView.setAdapter(adapter)`。
- `refreshList();` 啟動先載入資料。
- `btnSignUp.setOnClickListener(v -> signUp());`：報名按鈕（單一方法 → lambda）。
- `listView.setOnItemLongClickListener((parent, view, position, id) -> { confirmDelete(id); return true; });`：**長按每一列** → `confirmDelete(id)`。`id` 是該列在資料庫的主鍵。**回 `true`** 表示「已處理長按，不再觸發點擊」。

**signUp()（新增）**：
- 取姓名電話並檢查姓名非空。
- `SQLiteDatabase db = dbHelper.getWritableDatabase();` **取得可寫資料庫**。
- `db.execSQL("INSERT INTO signup (name, phone) VALUES (?, ?)", new Object[]{name, phone});`——用 `?` 佔位，**避免 SQL injection**（對照 JDBC `PreparedStatement`）。
- `db.close();` **用完要關**，清空輸入框，`refreshList()` 重載。

**refreshList()（查詢+刷新）**：
- 先 `displayList.clear()` 清空舊顯示。
- `dbHelper.getReadableDatabase()` 取得**唯讀**資料庫（效能較好）。
- `Cursor cursor = db.rawQuery("SELECT name, phone FROM signup ORDER BY id ASC", null);` 查詢全部。
- `while (cursor.moveToNext())`：逐列讀取，`getString(0)` 取 name、`getString(1)` 取 phone，組合成 `"姓名  (電話)"` 加進 `displayList`，並 `count++` 累計人數。
- `cursor.close(); db.close();` 用完關閉。
- `adapter.notifyDataSetChanged();` 通知 ListView 重繪；`tvCount.setText(...)` 更新人數標籤。

**confirmDelete(long id)（刪除）**：
- 用 AlertDialog 問使用者確認。
- 確認後：`getWritableDatabase()` → `db.execSQL("DELETE FROM signup WHERE id = ?", new Object[]{id})` → `close()` → `refreshList()`。

> 核心對照：`getReadableDatabase()`/`getWritableDatabase()` 拿資料庫物件；`Cursor` 像 JDBC `ResultSet`（`moveToNext()` + `getString(索引)`）；`?` 參數置換較安全；`setOnItemLongClickListener` 是單一方法 functional interface → 可用 lambda，須回 `true`。

**Step 5 執行與驗證**：

| 操作 | 預期結果 |
|---|---|
| 姓名「王小明」電話「0912」→ 報名 | 列表出現「王小明 (0912)」，人數變 1 |
| 再報名「陳大華」 | 列表兩列，人數 2 |
| 重開 App | 資料仍在，人數 2（資料庫持久化 ✓） |
| 長按第一列 → 刪除 | 該列消失，人數 1 |

> ✅ 完成。你用純 SQLite 走完完整 CRUD（本範例含 Create、Read、Delete；Update 可參考 `UPDATE ... SET ... WHERE id = ?`）。

### 7-3 與 Room 對照（幫助你理解為何官方推 Room）

| 事項 | 純 SQLite（本範例） | Room |
|---|---|---|
| 建表 | 手寫 SQL 字串 | `@Entity` 註解自動產生 |
| 新增 | 手寫 INSERT | `@Insert void insert(...)` |
| 查詢 | Cursor + 手動迴圈 | `@Query` 回傳 `List<Memo>` |
| SQL 檢查時機 | 執行時期 | 編譯時期查錯 |
| 程式碼量 | 較多 | 較少 |

> 兩種你都懂了之後，就知道：「Room 只是幫你把上面這些 SQL/Cursor 樣板自動化」，底層仍是 SQLite。

**可練習擴充**：加「修改電話」：查該 id 後用 `UPDATE`、用 `SELECT COUNT(*)` 顯示人數（取代自己在 Java 計數）、加入搜尋姓名：`WHERE name LIKE ?`。

---

# 第 8 章　總成果專案：記帳 App（Expense Tracker）

> 這是一支**比三天專案更完整**的 App，整合了 Day 1～Day 3 所有已學技能：
> XML 佈局、View 綁定、RecyclerView + Adapter、Room 持久化、SharedPreferences、lambda。
> 全部檔案可直接編譯執行。套件名範例：`com.example.expenseapp`。

### 8-1 功能需求

- 記錄每一筆帳：項目名稱、金額、類別（收入 / 支出）
- 用 RecyclerView 顯示帳目清單
- 用 Room 永久保存每一筆帳
- 用 SharedPreferences 記住「上次輸入的類別」與「累計總額」快取
- 點擊 / 長按列可刪除

### 8-2 依賴 `app/build.gradle`

```groovy
dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.recyclerview:recyclerview:1.3.0'
    implementation 'androidx.room:room-runtime:2.6.1'
    annotationProcessor 'androidx.room:room-compiler:2.6.1'
}
```

**說明**：與第 5 章 Memo App 相同的一組依賴——`recyclerview`（列表）、`material`/`appcompat`（UI），`room-runtime` + `room-compiler`（持久化）。加完 **Sync**。

### 8-3 Entity：`Expense.java`

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

**程式說明（Expense＝帳目資料表模型）**：
- `@Entity(tableName = "expense")`：對應資料表 `expense`。
- `id`：自動遞增主鍵。
- `title`：項目名稱。
- `amount`：金額（用 `double`）。
- `type`：**類別旗標**——`0 = 支出`、`1 = 收入`（用 int 比 String 好比較，也不易打錯）。
- `Expense()`：**無參數建構子**，Room 反序列化需要。
- `Expense(title, amount, type)`：新增時一次填入。

### 8-4 DAO：`ExpenseDao.java`

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

**程式說明（ExpenseDao＝帳目資料操作介面）**：
- `@Insert void insert(...);` / `@Delete void delete(...);`：沿用 Room 慣例。
- `@Query("SELECT * FROM expense ORDER BY id DESC") List<Expense> getAll();`：抓全部，最新在前。
- **`getTotal()`（計算淨額）**——這支是重點，用一段 SQL 完成加總：
  - `SUM(CASE WHEN type = 0 THEN amount END)`：把「所有 `type = 0`（支出）」的 `amount` 加總 → 得到**總支出**。
  - `SUM(CASE WHEN type = 1 THEN amount END)`：同上，加總**總收入**。
  - `IFNULL(..., 0)`：若該群沒有任何資料，`SUM` 會回 `NULL`，用 `IFNULL` 轉成 `0`，避免運算出 NULL。
  - 最後「**總支出 − 總收入**」就是淨額（負數代表淨支出）。
  - 回傳型別是 `double`，Room 會自動把 SQL 的數值結果轉成 Java `double`。

### 8-5 Database：`AppDatabase.java`

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

**程式說明**：與第 5 章 `AppDatabase` 完全同構的**「雙重檢查鎖定」單例**——`@Database(entities = {Expense.class}, version = 1)`、抽象 `expenseDao()`、`getInstance` 首次才 `Room.databaseBuilder(...).build()` 建立檔名 `expense.db` 的資料庫；`volatile` + `synchronized` 確保多執行緒安全。

### 8-6 單列佈局：`row_expense.xml`

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

**佈局說明（RecyclerView 每一列的樣板）**：
- 根為「**水平**」`LinearLayout`，`gravity="center_vertical"` 讓內容垂直置中。
- **左側內嵌垂直 `LinearLayout`**：包住 `tvTitle`（上方、16sp 粗體）與 `tvType`（下方、12sp），垂直堆疊。
  - `layout_width="0dp"` + `layout_weight="1"`：讓這塊「**撐滿剩餘寬度**」，把金額推到最右邊。
- `tvAmount`：金額（18sp 粗體），靠右顯示。
- 三欄資訊：**標題 / 類別（上到下），金額靠右**。

### 8-7 Adapter：`ExpenseAdapter.java`

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

**程式說明（ExpenseAdapter＝帳目列表的橋接器）**：
- **監聽介面 `OnItemClick`**：只有**一個**方法 `void onItemClick(Expense expense)` → 是 **functional interface** → **可用 lambda**（這點和第 5 章有兩個方法的 `OnMemoClickListener` 不同，詳見下方註）。
- 其餘沿用 RecyclerView 三件套：
  - `setExpenses(newList)`：換整批資料並 `notifyDataSetChanged()`。
  - `onCreateViewHolder`：inflate `row_expense.xml`。
  - `onBindViewHolder(holder, position)`：填資料進每一列。
- **onBindViewHolder 的顯示細節**：
  - `tvType.setText(expense.type == 1 ? "收入" : "支出")`：依型別顯示文字。
  - `String sign = expense.type == 1 ? "+" : "-";`：收入 `+`、支出 `-`。
  - `String.format("%s%,.0f", sign, expense.amount)`：`%.0f` 取整數、`,` 每三位加千分號，配合正負號。
  - **顏色**：收入綠色 `holo_green_dark`、支出紅色 `holo_red_dark`——一眼分辨。
  - `holder.itemView.setOnClickListener(v -> listener.onItemClick(expense));`：整列點擊交回監聽（lambda）。
- `getItemCount`：回傳筆數。
- `ExpenseViewHolder`：緩存三個 `TextView`。

> 💡 這裡的 `OnItemClick` 只有一個方法，所以是 functional interface，可用 lambda。
> 又強調一次：RecyclerView 的 `onBindViewHolder`、`onCreateViewHolder`、`getItemCount` 是**方法覆寫**，不是 lambda。

### 8-8 主畫面佈局：`activity_main.xml`

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

**佈局說明（主畫面）**：根為垂直 `LinearLayout`。
- `tvTotal`：**總額顯示**（24sp 粗體）。
- `etTitle` / `etAmount`：項目與金額輸入框（`inputType="numberDecimal"` 只能輸數字）。
- `RadioGroup`：**單選容器**，內含「支出」「收入」兩個 `RadioButton`；`rbExpense` 預設 `checked="true"`。
- `btnAdd`：新增按鈕。
- `RecyclerView`：帳目列表佔滿剩餘空間。

### 8-9 主程式：`MainActivity.java`

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

**程式說明（MainActivity＝記帳 App 主控，整合 Room + RecyclerView + SharedPreferences）**：

**成員與常數**：`etTitle`/`etAmount`（輸入）、`radioGroup`（支出/收入單選）、`tvTotal`（總額）、`dao`（資料操作）、`adapter`（列表）。`PREFS_NAME`/`KEY_LAST_TYPE` 是 SharedPreferences 的檔名與 key。

**onCreate（啟動流程）**：
- `dao = AppDatabase.getInstance(this).expenseDao();` 取得 DAO。
- **讀回上次偏好**：`prefs.getInt(KEY_LAST_TYPE, 0)` 讀「上次選的類別」→ `radioGroup.check(...)` 把對應的 RadioButton 設為選中。這是「記住使用者偏好」的示範。
- `adapter = new ExpenseAdapter(expense -> showDeleteDialog(expense));` ——因為 `OnItemClick` 只有一個方法（functional interface），**可直接用 lambda**（對照第 5、7 章需 anonymous class 的情況）。
- 設定列表、`loadData()` 載入資料、新增按鈕掛監聽。

**loadData()（刷新列表與總額）**：
- `dao.getAll()` → `adapter.setExpenses(list)` 顯示所有帳目。
- `double total = dao.getTotal();` 用 DAO 那段 SQL **一次算出淨額**（支出 − 收入）。
- `String.format(Locale.TAIWAN, "總額：%,.0f 元", total)`：`%,.0f` 加千分號且不留小數，並指定 `Locale.TAIWAN`。

**addExpense()（新增）**：
- 取出標題與金額字串，非空檢查。
- `Double.parseDouble(amountStr)` 轉成數字；**包 try/catch** 抓 `NumberFormatException`（輸入非數字時）→ Toast「金額格式錯誤」。
- 從 `radioGroup.getCheckedRadioButtonId()` 拿到被選中的按鈕 id，再 `findViewById` 取得該按鈕，判斷是否為「收入」→ 設 `type`。
- `getSharedPreferences(...).edit().putInt(KEY_LAST_TYPE, type).apply();` **記住這次選擇，下次開啟自動帶回**。
- `dao.insert(new Expense(title, amount, type));` 寫入資料庫 → 清空輸入 → `loadData()` 刷新。

**showDeleteDialog(expense)**：AlertDialog 確認後 `dao.delete(expense)` + `loadData()`。

> 這支把 Day 3 的三種概念都串起來：**Room 存資料、RecyclerView 顯示、SharedPreferences 記偏好**。

### 8-10 建立與執行步驟

1. 建立 **Empty Views Activity** 專案（Language = **Java**）
2. 加入 Room + RecyclerView 依賴，Sync
3. 新增 4 個 Java class：`Expense`、`ExpenseDao`、`AppDatabase`、`ExpenseAdapter`
4. 新增 `row_expense.xml` 與替換 `activity_main.xml`
5. 替換 `MainActivity.java`
6. Run 到模擬器

### 8-11 測試流程與預期結果

| 步驟 | 操作 | 預期結果 |
|---|---|---|
| 1 | 輸入「午餐」、100、選「支出」→ 新增 | 列表出現「支出 午餐 -100」(紅色)，總額 = -100 |
| 2 | 輸入「薪水」、3000、選「收入」→ 新增 | 列表出現「收入 薪水 +3,000」(綠色)，總額 = 2,900 |
| 3 | 重開 App | 資料仍在，且「收入」按鈕已自動選中（SharedPreferences 生效） |
| 4 | 點任一列 | 跳出刪除確認框，確定後該列移除、總額更新 |

> ✅ 這支 App 用到了：**Room（持久化）+ RecyclerView（列表）+ SharedPreferences（記住設定）+ lambda + Adapter 模式**，
> 可以當作你自己的「三天學習總成果」專案，繼續擴充下去。

### 8-12 可以繼續擴充（挑戰）

- 增加「日期」欄位，用 `@Query` 依月份篩選
- 用 `LiveData<Double>` 讓總額「自動」更新，不需要手動 `loadData()`
- 改成清單可用 DatePickerDialog 選日期
- 匯出成 CSV 檔寫入內部儲存
- 用 ItemTouchHelper 做滑動刪除動畫

---

# 第 9 章　自我測驗與解答

先自己作答，再看解答。有些題目沒有唯一答案，參考解答即可。

## Day 3 測驗題

1. SharedPreferences、檔案、SQLite 各適合什麼場景？
2. SQLite 中 `?` 佔位符的用途是什麼？為什麼不用直接拼字串？
3. Cursor 與 JDBC 的 ResultSet 有何相似？
4. Room 的 Entity、DAO、Database 三者各自角色為何？
5. 為什麼官方建議用 Room 而非純 SQLite？

### Day 3 測驗解答

**1. SharedPreferences、檔案、SQLite 各適合什麼場景？**

- SharedPreferences：小型 key-value 設定（登入狀態、偏好設定、計數器）。
- 檔案 (Internal Storage)：原始資料讀寫（文字檔、圖片、匯出/匯入）。
- SQLite/Room：多筆、結構化、需要查詢/排序/關聯的資料（例如備忘錄、訂單明細）。

**2. SQLite 中 `?` 佔位符的用途是什麼？為什麼不用直接拼字串？**

- `?` 是參數佔位符，執行時將物件陣列的值安全繫結（bind），可防止 **SQL injection** 攻擊，也避免字串拼接造成引號/特殊字元問題。
- 對照 JDBC 的 `PreparedStatement` 概念。

**3. Cursor 與 JDBC 的 ResultSet 有何相似？**

- 都是查詢結果的游標：`moveToNext()` ≈ `next()`，`getString/getInt(index)` ≈ `rs.getString/getInt(index)`，用 `getColumnIndex()` 可拿欄位名稱位置。

**4. Room 的 Entity、DAO、Database 三者各自角色為何？**

- **Entity**：對應一張資料表，欄位即資料行。
- **DAO**：定義資料操作（insert/update/delete/query），Room 自動產生實作。
- **Database**：資料庫整體，對外提供 DAO 實例；正規單例模式避免重複建立。

**5. 為什麼官方建議用 Room 而非純 SQLite？**

- 編譯時期檢查 SQL 語法錯誤（純 SQLite 的 SQL 執行時期才報錯）。
- 減少樣板程式碼（不必手寫 Cursor 迴圈/關閉/欄位對映）。
- 與 LiveData / Coroutines 整合，支援非同步與自動更新。
- 類似 JPA 帶給 JDBC 的便利性與型別安全。

---

# 三天總結

| 天 | 主題 | 完成小專案 |
|---|---|---|
| Day 1 | 環境、佈局、元件、事件 | BMI 計算機 |
| Day 2 | Intent 跳轉、傳值、列表 | 待辦清單（記憶體） |
| Day 3 | SharedPreferences、檔案、SQLite/Room | 備忘錄 CRUD（持久化） |

恭喜完成 Android 三天入門！接下來可以往：Jetpack Compose、ViewModel、LiveData、網路請求 (Retrofit)、MVVM 架構前進。

### 進階挑戰（選做）

1. 用 Room 的 `LiveData<List<Memo>>` 取代 `List<Memo>`，讓資料異動自動更新 UI，不需要手動 `loadMemos()`。
2. 把 BMI 計算結果用 SharedPreferences 儲存最近三次。
3. 在 MemoApp 加入搜尋：在 DAO 加 `@Query("SELECT * FROM memo WHERE title LIKE '%' || :keyword || '%'")`。
4. 用 `ViewHolder` + ItemTouchHelper 實現滑動刪除。
5. 把 App 換成 Jetpack Compose 的宣告式 UI（新的學習方向）。

> 相關延伸閱讀：`Appendix_C_Troubleshooting.md`（排錯）、`Appendix_D_Gradle_Setup.md`（Gradle）、`Appendix_E_Debugging.md`（除錯）、`Appendix_G_Lifecycle.md`（生命週期）。