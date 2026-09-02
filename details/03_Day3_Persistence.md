# Day 3 — 資料持久化：SQLite / Room 資料庫 + SharedPreferences

> 目標：把資料永久存起來，學會 SharedPreferences、內部儲存、SQLite、Room
> 時間：約 6–8 小時
> 完成實作：**備忘錄 (Memo) 完整 CRUD App + SQLite/Room 持久化**
> ⚡ = 與 JFrame 對照

---

## 概觀：三種資料儲存方式

| 方式 | 適合 | JFrame 對照 | Day 3 項目 |
|---|---|---|---|
| `SharedPreferences` | 小型 key-value（設定、使用者偏好） | Properties 檔案 | ★ |
| 內部儲存 (File) | 檔案讀寫（文字、圖片） | `FileWriter` / `FileReader` | ★ |
| `SQLite / Room` | 結構化、多筆資料 CRUD | JDBC + 資料庫 | ★★★ |

> 先決：JFrame 用 JDBC + MySQL/檔案。Android 無法直接用 JDBC 連外部 DB，而是用內建的 **SQLite**（單一檔案資料庫），且官方強烈建議用 **Room** 封裝。

---

## 1. SharedPreferences（輕量 key-value）

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

常見用途：記住登入狀態、上次選的選項、計數器。

---

## 2. 內部儲存（File 讀寫）

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

> JFrame 的 `new FileWriter(...)` 對應到 `openFileOutput(...)`，好處是不用管絕對路徑，Android 自動放到 App 私有區。

---

## 3. SQLite（直接寫 SQL）

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

> ⚡ 這與你在 JFrame 用 JDBC `Statement`/`PreparedStatement` 很類似，只是 db 是內建的、SQLite 語法，且用 `?` 參數。

### 3.3 Cursor 是什麼？

`Cursor` 像 JDBC 的 `ResultSet`，`moveToNext()` 像 `next()`，`getString/getInt` 依欄位索引取值。

---

## 4. Room（官方推薦的 ORM）

原生 SQLite 要手動寫 SQL 與 Cursor，容易出錯。**Room** 用註解自動產生程式碼，像 JPA / Hibernate 的概念。

> ⚡ **對照**：Room 對你猶如 JPA 對 JDBC——靠註解 + 介面方法，少寫 SQL。

### 4.1 在 build.gradle 加入依賴

```groovy
dependencies {
    implementation "androidx.room:room-runtime:2.6.1"
    annotationProcessor "androidx.room:room-compiler:2.6.1"
}
```

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

> 注意：Room 在正式環境建議用 **LiveData / Flow** + background thread。Day 3 為了先求理解，範例用同步方式，但會提示非同步的重要性。

---

## 5. 小實作：備忘錄 (Memo) 完整 CRUD App

完整程式碼見 `05_Example_MemoApp.md`。

功能需求：
- `RecyclerView` 顯示所有備忘錄
- 新增：EditText + 按鈕，寫入資料庫
- 刪除：長按或滑動刪除，用 AlertDialog 確認
- 修改：點擊開啟編輯畫面（可選）
- 資料用 **Room** 永久保存，重開 App 資料仍在

### Day 3 完整範例清單（每一步都可直接編譯執行）

| 範例 | 檔案 | 重點技能 |
|---|---|---|
| 備忘錄 App | `05_Example_MemoApp.md` | Room CRUD + RecyclerView |
| 使用者設定 | `14_Day3_UserSettings.md` | SharedPreferences + 內部儲存檔案讀寫 |
| 活動報名名單 | `15_Day3_SignUpApp.md` | 純 SQLite（SQLiteOpenHelper + Cursor + SQL）CRUD |

> 一起做：先做備忘錄（Room，最常用），再做活動報名（純 SQLite，懂底層 SQL），最後做使用者設定（非資料庫的 SharedPreferences/檔案）。外加 `08_Extra_ExpenseTracker.md` 是把三天全部技能整合的總成果專案。

---

## 6. 自我測驗

1. SharedPreferences、檔案、SQLite 各適合什麼場景？
2. SQLite 中 `?` 佔位符的用途是什麼？為什麼不用直接拼字串？
3. Cursor 與 JDBC 的 ResultSet 有何相似？
4. Room 的 Entity、DAO、Database 三者各自角色為何？
5. 為什麼官方建議用 Room 而非純 SQLite？

（解答在 `06_Quiz_Answers.md`）

---

## 三天總結

| 天 | 主題 | 完成小專案 |
|---|---|---|
| Day 1 | 環境、佈局、元件、事件 | BMI 計算機 |
| Day 2 | Intent 跳轉、傳值、列表 | 待辦清單（記憶體） |
| Day 3 | SharedPreferences、檔案、SQLite/Room | 備忘錄 CRUD（持久化） |

恭喜完成 Android 三天入門！接下來可以往：Jetpack Compose、ViewModel、LiveData、網路請求 (Retrofit)、MVVM 架構前進。
