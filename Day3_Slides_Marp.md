---
marp: true
theme: default
paginate: true
size: 16:9
header: 'Day 3：資料持久化（SQLite / Room + SharedPreferences）+ AI 互動指南'
style: |
  section { font-size: 24px; padding: 50px 70px; }
  h1 { font-size: 40px; }
  h2 { font-size: 30px; }
  h3 { font-size: 25px; }
  pre { font-size: 13.5px; line-height: 1.4; padding: 12px 16px; }
  table { font-size: 17px; }
  blockquote { font-size: 19px; }
  li { margin: 5px 0; }
---

<!--
使用方式：
1. VS Code 安裝 Marp for VS Code 外掛
2. 開啟本檔 → 右上角「Marp: Preview / 匯出 PDF / 匯出 HTML / 匯出 PPTX」
3. 分頁符號為 `---`
4. 「AI 動手做」章節穿插在各教學主題之後，跟著看、跟著做
-->

# Day 3 合併版投影片

## 資料持久化：SQLite / Room 資料庫 + SharedPreferences

### 教學內容 + AI 提示互動指南（穿插版）

---

# 本講內容

- 對象：具備 Java / JFrame 經驗，**已完成 Day 1、Day 2**
- 時間：約 6–8 小時
- 今天的主題：**把資料「永久存起來」**——三種方式
  - `SharedPreferences`（輕量 key-value 設定）
  - 內部儲存（檔案讀寫）
  - `SQLite / Room`（結構化資料庫 CRUD）
- 四個完整範例：**Memo App（Room）**、**使用者設定**、**活動報名（純 SQLite）**、**記帳 App（三天總成果）**
- ⚡ 對照：Properties 檔 / FileWriter / JDBC

---

# AI 動手做｜與 AI 互動提醒（指南 §0）

| 提醒 | 說明 |
|---|---|
| **Room 依賴要用 `annotationProcessor`** | Java 專案用 `annotationProcessor`，**不是** `kapt`（那是 Kotlin） |
| **Room 三大件一起要** | Entity + DAO + Database 缺一不可，一次請 AI 一起給 |
| **Database 是單例** | 提醒 AI 用「雙重檢查鎖定」單例 + `context.getApplicationContext()` |
| **注意 lambda 界線** | `MemoAdapter.OnMemoClickListener` 有兩個方法 → 只能用 anonymous class；單方法介面才用 lambda |
| **同步是為教學** | 教材用同步 DAO 是求理解；AI 若提到非同步/LiveData，先知道那是正式做法即可 |

> 橘色 `[ ... ]` 是你要自己填的部分；提示都是可複製的完整範例。

---

# 第 0 章　概觀：三種資料儲存方式

| 方式 | 適合 | JFrame 對照 | Day 3 項目 |
|---|---|---|---|
| `SharedPreferences` | 小型 key-value（設定、偏好） | Properties 檔案 | ★ |
| 內部儲存 (File) | 檔案讀寫（文字、圖片） | `FileWriter` / `FileReader` | ★ |
| `SQLite / Room` | 結構化、多筆 CRUD | JDBC + 資料庫 | ★★★ |

> 先決：JFrame 用 JDBC + MySQL/檔案；Android **無法直接用 JDBC 連外部 DB**，改用內建 **SQLite**（單一檔案資料庫），官方強烈建議用 **Room** 封裝。

---

# 第 1 章　SharedPreferences（輕量 key-value）

> ⚡ 就像在 JFrame App 旁放一個 `config.properties`，存「上次的設定」。

```java
// 1. 取得設定檔（MODE_PRIVATE = 只有本 App 能讀寫）
SharedPreferences prefs = getSharedPreferences("memo_prefs", MODE_PRIVATE);

// 2. 寫入需透過 Editor
SharedPreferences.Editor editor = prefs.edit();
editor.putString("username", "張三");
editor.putInt("counter", 5);
editor.apply();   // apply() 非同步較推薦；commit() 同步回傳 boolean

// 3. 讀取（第二參數 = key 不存在時的預設值）
String name = prefs.getString("username", "預設值");
int counter = prefs.getInt("counter", 0);
```

- `putXxx` 是「key → value」，讀取用同名 key；`apply()` 才真正寫入
- 常見用途：記住登入狀態、上次選的選項、計數器

---

# AI 動手做｜提示 1：SharedPreferences（指南 §1）

```
我是有 JDBC/Swing 經驗的 Java 開發者，正在學 Android。請教我 SharedPreferences：
1. 用 JFrame 的 config.properties / Properties 對照解釋
2. 給一小段可編譯程式：
   - getSharedPreferences("memo_prefs", MODE_PRIVATE) 取設定
   - editor.putString / putInt + apply() 寫入
   - prefs.getString(name, 預設值) / getInt(counter, 0) 讀取
3. 解釋 apply() vs commit() 的差別（何者非同步、何者回傳 boolean）
請用 Java，放進一個 Activity 的範例方法裡。
```

---

# 第 2 章　內部儲存（File 讀寫）

> Android 每個 App 有自己私有的 `files` 目錄，**不需權限**。

```java
// 寫檔：try-with-resources 自動關閉
String content = "這是檔案內容";
try (FileOutputStream fos = openFileOutput("mydata.txt", Context.MODE_PRIVATE)) {
    fos.write(content.getBytes());
} catch (IOException e) { e.printStackTrace(); }

// 讀檔：BufferedReader 逐行讀
try (FileInputStream fis = openFileInput("mydata.txt");
     BufferedReader reader = new BufferedReader(new InputStreamReader(fis))) {
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = reader.readLine()) != null) { sb.append(line); }
    String text = sb.toString();
} catch (IOException e) { e.printStackTrace(); }
```

- `openFileOutput/openFileInput` 會自動放到 App 私有 `files` 目錄，不用寫絕對路徑
- ⚡ JFrame 的 `new FileWriter(...)` 對應到 `openFileOutput(...)`

---

# AI 動手做｜提示 2：內部儲存（指南 §2）

```
請教我用 JFrame 的 FileWriter/FileReader 對照 Android 內部儲存：
1. 解釋 openFileOutput / openFileInput 與 private files 目錄（不需權限）
2. 給一小段可編譯程式：
   - 寫檔：try-with-resources + FileOutputStream + content.getBytes()，catch IOException
   - 讀檔：FileInputStream + BufferedReader 逐行讀，組回 StringBuilder
3. 提醒 try-with-resources 與 UTF-8（避免中文亂碼）
```

---

# 第 3 章　SQLite：用 SQLiteOpenHelper 建立資料庫

```java
public class DBHelper extends SQLiteOpenHelper {
    private static final String DB_NAME = "memo.db";
    private static final int DB_VERSION = 1;

    public DBHelper(Context context) { super(context, DB_NAME, null, DB_VERSION); }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // 資料庫「首次建立」時只執行一次
        db.execSQL("CREATE TABLE memo (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "title TEXT NOT NULL, " +
                "content TEXT, " +
                "created_at TEXT DEFAULT CURRENT_TIMESTAMP)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS memo");   // 示範用：會遺失資料
        onCreate(db);
    }
}
```

- `onCreate`：第一次建立時建表；`onUpgrade`：版本升級時執行（正式環境應做欄位遷移，不是直接 DROP）

---

# 第 3 章　SQLite：CRUD 操作 + Cursor

```java
DBHelper helper = new DBHelper(this);
SQLiteDatabase db = helper.getWritableDatabase();

// CREATE：? 為參數佔位，避免 SQL injection ≈ PreparedStatement
db.execSQL("INSERT INTO memo (title, content) VALUES (?, ?)", new Object[]{"標題", "內容"});

// READ：Cursor ≈ JDBC 的 ResultSet
Cursor cursor = db.rawQuery("SELECT id, title FROM memo", null);
while (cursor.moveToNext()) { int id = cursor.getInt(0); String title = cursor.getString(1); }
cursor.close();

// UPDATE / DELETE
db.execSQL("UPDATE memo SET title = ? WHERE id = ?", new Object[]{"新標題", 1});
db.execSQL("DELETE FROM memo WHERE id = ?", new Object[]{1});

db.close();   // 用完要關閉
```

- **`?` 佔位 + 物件陣列帶值**：防 SQL injection（正確寫法）
- `Cursor.moveToNext()` ≈ `ResultSet.next()`；`getString/getInt(索引)` 依欄位索引取值
- `db.close()`、`cursor.close()`：用完關閉釋放資源

---

# AI 動手做｜提示 3：SQLite 的 DBHelper + CRUD（指南 §3）

```
請教我用 JDBC + PreparedStatement 的經驗對照 Android SQLite：
1. 給我 DBHelper.java（繼承 SQLiteOpenHelper）：
   - DB name "memo.db"、version 1
   - onCreate 用 execSQL 建 memo 表（id 主鍵自動遞增、title NOT NULL、content、created_at 預設時間）
   - onUpgrade：DROP 後重建
2. 給我 Activity 內的 CRUD 範例：
   - getWritableDatabase() + execSQL INSERT with ? 佔位參數（對照 PreparedStatement 防 SQL injection）
   - rawQuery + Cursor（moveToNext / getInt / getString 依索引取值，用後 close）
   - UPDATE / DELETE
3. 解釋 Cursor 對照 ResultSet
```

---

# 第 4 章　Room（官方推薦的 ORM）

原生 SQLite 要手動寫 SQL 與 Cursor，容易出錯。**Room** 用註解自動產生程式碼，像 JPA / Hibernate。

> ⚡ Room 對你猶如 **JPA 對 JDBC**——靠註解 + 介面方法，少寫 SQL。

**依賴（Java 專案用 `annotationProcessor`，不是 `kapt`）**

```groovy
dependencies {
    implementation "androidx.room:room-runtime:2.6.1"
    annotationProcessor "androidx.room:room-compiler:2.6.1"
}
```

---

# 第 4 章　Room 三大件：① Entity + ② DAO

**① Entity（資料表模型）**

```java
@Entity(tableName = "memo")
public class Memo {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public String title;
    public String content;
}
```

**② DAO（資料操作介面，Room 自動產生實作）**

```java
@Dao
public interface MemoDao {
    @Insert void insert(Memo memo);
    @Update void update(Memo memo);
    @Delete void delete(Memo memo);
    @Query("SELECT * FROM memo ORDER BY id DESC") List<Memo> getAll();
}
```

- Entity 的欄位 = 資料表的欄；DAO 只寫方法簽名，不寫 SQL 樣板

---

# 第 4 章　Room 三大件：③ Database + 使用 CRUD

**③ Database（資料庫入口，單例）**

```java
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

**使用（CRUD）**

```java
MemoDao dao = AppDatabase.getInstance(this).memoDao();
dao.insert(new Memo());       // new Memo() → 填 title/content → insert
List<Memo> list = dao.getAll();
dao.update(memo);             // 改欄位後更新（依主鍵）
dao.delete(memo);
```

- **單例模式**：整個 App 只有一個資料庫實例（正式版再加 `volatile` + `synchronized` 雙重檢查）
- 正式環境建議 `LiveData` / Flow + background thread

---

# AI 動手做｜提示 4：Room 三大件（指南 §4）

```
我是 Java Android 開發者，請教我 Room（對照 JPA 對 JDBC）。給我完整的三個 class + 使用範例：

1. build.gradle 依賴：room-runtime + room-compiler（請用 annotationProcessor，因為是 Java，不是 kapt）
2. Memo.java（@Entity tableName="memo"）：@PrimaryKey(autoGenerate=true) int id、String title、String content、要有無參數建構子
3. MemoDao.java（@Dao 介面）：@Insert / @Update / @Delete / @Query("SELECT * FROM memo ORDER BY id DESC") List<Memo> getAll()
4. AppDatabase.java（@Database entities={Memo.class} version=1，抽象 class 繼承 RoomDatabase）：
   - 用 double-checked locking 單例 getInstance(Context)
   - Room.databaseBuilder(context.getApplicationContext(), AppDatabase.class, "memo.db").build()
5. Activity 內使用：AppDatabase.getInstance(this).memoDao() → dao.insert / getAll / update / delete

請說明 Entity / DAO / Database 三個角色，以及為何 Database 用單例。
```

---

# ⭐ 第 5 章　完整範例一：備忘錄 Memo App（Room + RecyclerView）

> 整合 Day 2（RecyclerView）+ Day 3（Room），套件 `com.example.memoapp`：新增 / 顯示 / 編輯 / 刪除，資料永久保存。

**依賴**：`appcompat` + `material` + `recyclerview` + `room-runtime`（`annotationProcessor room-compiler`）。

**四個檔（與第 4 章模式相同）**：

| 檔案 | 內容 |
|---|---|
| `Memo.java` | `@Entity` + 自動遞增 `id` + `title` + `content`；**無參數建構子不可省略**（Room 反序列化需要） |
| `MemoDao.java` | `@Insert` / `@Update` / `@Delete` / `@Query("... ORDER BY id DESC") List<Memo> getAll()` |
| `AppDatabase.java` | 雙重檢查鎖定單例（`volatile` + `synchronized` + `getApplicationContext()`） |
| `row_memo.xml` | 每列：垂直 LinearLayout，`tvTitle`(18sp 粗體) + `tvContent`(14sp) |

---

# ⭐ 第 5 章　Memo App：MemoAdapter（兩方法介面不能用 lambda）

```java
public class MemoAdapter extends RecyclerView.Adapter<MemoAdapter.MemoViewHolder> {
    public interface OnMemoClickListener {           // ⚠️ 有「兩個」方法
        void onMemoClick(Memo memo, int position);
        void onMemoLongClick(Memo memo, int position);
    }
    // onCreateViewHolder：inflate(R.layout.row_memo)
    // onBindViewHolder：setText 後，itemView 點擊→onMemoClick、長按→onMemoLongClick
    // getItemCount() { return memoList.size(); }
    static class MemoViewHolder extends RecyclerView.ViewHolder { ... }
}
```

**不是 functional interface → 只能用 anonymous class**

```java
adapter = new MemoAdapter(new MemoAdapter.OnMemoClickListener() {
    @Override public void onMemoClick(Memo memo, int position) { showEditDialog(memo); }
    @Override public void onMemoLongClick(Memo memo, int position) { showDeleteDialog(memo); }
});
```

> **若要 lambda**：把介面拆成兩個單一方法介面 `OnMemoClick` / `OnMemoLongClick`，各自就可寫 `(memo, position) -> ...`。
> 規則不變：**單一抽象方法 → lambda；多方法 → anonymous class**。

---

# ⭐ 第 5 章　Memo App：主畫面 + 主程式

**佈局 `activity_main.xml`**：`etTitle`(標題) + `etContent`(內容) + `btnAdd`「新增備忘錄」+ `RecyclerView`。

**程式 `MainActivity.java` 重點**：

```java
dao = AppDatabase.getInstance(this).memoDao();        // 資料入口

adapter = new MemoAdapter(new MemoAdapter.OnMemoClickListener() {
    @Override public void onMemoClick(Memo memo, int position) { showEditDialog(memo); }
    @Override public void onMemoLongClick(Memo memo, int position) { showDeleteDialog(memo); }
});
recyclerView.setLayoutManager(new LinearLayoutManager(this));
recyclerView.setAdapter(adapter);
loadMemos();
btnAdd.setOnClickListener(v -> addMemo());            // 單一方法 → lambda

private void addMemo() { /* 標題空檢查 → new Memo(title,content) → dao.insert → loadMemos() */ }
private void showEditDialog(Memo memo) { /* AlertDialog 內放動態 new EditText，儲存 → dao.update */ }
private void showDeleteDialog(Memo memo) { /* 確認 → dao.delete → loadMemos() */ }
```

**測試**：新增幾筆 → **關掉 App 重開 → 資料還在（持久化 ✓）**；點擊編輯、長按刪除。可用 **App Inspection** 瀏覽 `memo.db`。

**可練習擴充**：`LiveData<List<Memo>>` 自動更新、搜尋 `WHERE title LIKE :keyword`、`ItemTouchHelper` 滑動刪除。

---

# AI 動手做｜5-1 備忘錄 Memo App 提示（指南 §5-1）

```
我學到「備忘錄 Memo App」，整合 Day 2 的 RecyclerView + Day 3 的 Room，套件 com.example.memoapp，請幫我產出完整檔案：

依賴：appcompat、material、recyclerview、room-runtime + annotationProcessor room-compiler

1. Memo.java：@Entity + @PrimaryKey(autoGenerate=true) int id、String title、String content、無參數建構子 + (title, content) 建構子
2. MemoDao.java：@Insert / @Update / @Delete / @Query("SELECT * FROM memo ORDER BY id DESC") List<Memo> getAll()
3. AppDatabase.java：double-checked locking 單例 getInstance
4. row_memo.xml：垂直 LinearLayout，TextView tvTitle(18sp 粗體) + tvContent(14sp)
5. MemoAdapter.java：繼承 RecyclerView.Adapter
   - 注意：自訂 interface OnMemoClickListener 有「兩個」方法 onMemoClick + onMemoLongClick → 不是 functional interface，不能用 lambda
   - onCreateViewHolder inflate row_memo、onBindViewHolder setText + setOnClickListener / setOnLongClickListener
   - 內部 static MemoViewHolder、setMemos() 整批更新 + notifyDataSetChanged
6. activity_main.xml：EditText etTitle + etContent + 按鈕 btnAdd + RecyclerView
7. MainActivity.java：dao 取得、adapter 用 anonymous class（兩個方法）、新增/點擊編輯/長按刪除、loadMemos()
請特別標出：哪些用 lambda、哪些要用 anonymous class（OnMemoClickListener）。
```

**練習擴充**：`請把 MemoDAO 改成回傳 LiveData<List<Memo>>，讓 UI 自動更新（不需要手動 loadMemos）。`

**驗證**：新增幾筆 → **關掉 App 重開 → 資料還在**。

---

# ⭐ 第 6 章　完整範例二：使用者設定（SharedPreferences + 檔案）

> 套件 `com.example.usersettings`。把 Day 3 前兩種「非資料庫」持久化實際跑一遍。

**佈局**：標題「使用者設定」+ `etName` + `etTopic` + 三顆按鈕：`btnSavePrefs`（SharedPreferences）、`btnWriteLog`（寫檔）、`btnReadLog`（讀檔）。

**程式重點**

```java
// SharedPreferences
private void savePrefs() {
    getSharedPreferences("user_prefs", MODE_PRIVATE)
            .edit().putString("name", name).putString("topic", topic).apply();
}
private void loadPrefs() {   // 啟動時讀回，填入輸入框
    etName.setText(prefs.getString("name", ""));   // 第二參數 = 預設值
}

// 內部儲存（檔案）· 記得用 UTF-8 避免中文亂碼
try (FileOutputStream fos = openFileOutput("user_log.txt", Context.MODE_PRIVATE)) {
    fos.write(content.getBytes(StandardCharsets.UTF_8));
}
// 讀回：openFileInput + BufferedReader 逐行讀 → AlertDialog 顯示
```

| 操作 | 預期結果 |
|---|---|
| 填「小明 / 程式」→ 儲存設定 | Toast「設定已儲存」 |
| **關掉 App 重開** | 輸入框自動帶回「小明」「程式」✓ |
| 寫入 / 讀取日誌 | Toast「已寫入」/ AlertDialog 顯示內容 |

---

# AI 動手做｜5-2 使用者設定提示（指南 §5-2）

```
我學到「使用者設定」，套件 com.example.usersettings，請幫我產出 2 支檔案：

1. activity_main.xml：標題、EditText etName、etTopic、三個按鈕 btnSavePrefs(儲存設定 SharedPreferences)、btnWriteLog(寫入日誌 檔案)、btnReadLog(讀取日誌)
2. MainActivity.java：
   - 常數：PREFS_NAME="user_prefs"、KEY_NAME、KEY_TOPIC、LOG_FILENAME="user_log.txt"
   - loadPrefs()：啟動時 getSharedPreferences 讀回，填入輸入框（第二參數預設值）
   - savePrefs()：getSharedPreferences(...).edit().putString(...).putString(...).apply()
   - writeLog()：openFileOutput + FileOutputStream + UTF-8 寫入私人檔案
   - readLog()：openFileInput + BufferedReader 逐行讀，組回字串，AlertDialog 顯示
請用 lambda 掛三個按鈕監聽。
```

**驗證**：填「小明/程式」儲存 → **重開 App 輸入框自動帶回** → 寫入/讀取日誌能看到內容。

---

# ⭐ 第 7 章　完整範例三：活動報名名單（純 SQLite CRUD）

> 套件 `com.example.signupapp`。**不使用 Room、直接寫 SQLite**，補足對底層 SQL 的掌握。不需額外依賴。

**佈局**：`etName` + `etPhone`（`inputType="phone"`）、`btnSignUp`「報名」、`tvCount`「目前報名人數：0」、`ListView`。

**DBHelper**：`signup.db`，建 `signup` 表（`id` 主鍵、`name`、`phone`）。

**MainActivity 重點**

```java
db.execSQL("INSERT INTO signup (name, phone) VALUES (?, ?)", new Object[]{name, phone});

private void refreshList() {      // 查詢 + 刷新
    displayList.clear(); int count = 0;
    Cursor cursor = db.rawQuery("SELECT name, phone FROM signup ORDER BY id ASC", null);
    while (cursor.moveToNext()) {
        displayList.add(cursor.getString(0) + "  (" + cursor.getString(1) + ")"); count++;
    }
    cursor.close(); db.close();
    adapter.notifyDataSetChanged(); tvCount.setText("目前報名人數：" + count);
}
// 長按列 → confirmDelete(id)：execSQL("DELETE FROM signup WHERE id = ?", {id}) + AlertDialog 確認
```

- 記憶口訣：**「改容器 → refreshList → notifyDataSetChanged」**
- `setOnItemLongClickListener` 是單一方法→lambda，且要 `return true`

---

# 第 7 章　與 Room 對照（為何官方推 Room）

| 事項 | 純 SQLite（本範例） | Room |
|---|---|---|
| 建表 | 手寫 SQL 字串 | `@Entity` 註解自動產生 |
| 新增 | 手寫 INSERT | `@Insert void insert(...)` |
| 查詢 | Cursor + 手動迴圈 | `@Query` 回傳 `List<Memo>` |
| SQL 檢查時機 | 執行時期 | **編譯時期**查錯 |
| 程式碼量 | 較多 | 較少 |

> 兩種都懂之後就知道：**Room 只是把 SQL/Cursor 樣板自動化，底層仍是 SQLite。**

---

# AI 動手做｜5-3 活動報名名單提示（指南 §5-3）

```
我學到「活動報名名單」（純 SQLite、不用 Room），套件 com.example.signupapp，請幫我產出 3 支檔案：

1. activity_main.xml：EditText etName、etPhone(inputType="phone")、按鈕 btnSignUp「報名」、TextView tvCount「目前報名人數：0」、ListView
2. DBHelper.java：繼承 SQLiteOpenHelper，DB "signup.db"，onCreate 建 signup 表(id 主鍵、name、phone)，onUpgrade DROP 重建
3. MainActivity.java：
   - dbHelper.getWritableDatabase() + execSQL INSERT with ? 佔位
   - refreshList()：getReadableDatabase + rawQuery + Cursor(moveToNext / getString 依索引) 組 String 到 displayList，notifyDataSetChanged + 更新人數
   - 長按列 → confirmDelete(id)：execSQL DELETE WHERE id = ? + AlertDialog 確認
   - 記憶口訣「改容器 → refreshList → notifyDataSetChanged」
請用 lambda（setOnItemLongClickListener 是單一方法介面）。
```

**練習擴充**：`請幫活動報名改用 SELECT COUNT(*) 顯示人數，並加「修改電話」功能。`

**驗證**：報名 → 出現「姓名 (電話)」→ 重開資料仍在 → 長按刪除。

---

# ⭐ 第 8 章　總成果：記帳 App（Expense Tracker）

> 整合 Day 1～Day 3 **所有技能**：XML 佈局、View 綁定、RecyclerView + Adapter、Room 持久化、SharedPreferences、lambda。套件 `com.example.expenseapp`。

**Expense（Entity）**：`id` 主鍵、`title`、`amount`(double)、`type`（**0=支出, 1=收入**）。

**ExpenseDao（含總額 SQL — 重點）**

```java
@Query("SELECT * FROM expense ORDER BY id DESC") List<Expense> getAll();

// 淨額 = 總支出 − 總收入；IFNULL 把空表轉成 0
@Query("SELECT IFNULL(SUM(CASE WHEN type = 0 THEN amount END), 0)" +
        " - IFNULL(SUM(CASE WHEN type = 1 THEN amount END), 0) FROM expense")
double getTotal();
```

**佈局**：`tvTotal`（總額）+ `etTitle` + `etAmount`（`numberDecimal`）+ `RadioGroup`（支出預設/收入）+ `btnAdd` + `RecyclerView`。

---

# ⭐ 第 8 章　記帳 App：ExpenseAdapter + MainActivity

**ExpenseAdapter**：監聽介面 `OnItemClick` 只有**一個**方法 → **functional interface → 可用 lambda**（和第 5 章 `OnMemoClickListener` 不同！）

```java
holder.tvType.setText(expense.type == 1 ? "收入" : "支出");
String sign = expense.type == 1 ? "+" : "-";
holder.tvAmount.setText(String.format("%s%,.0f", sign, expense.amount));
// 收入綠色 holo_green_dark、支出紅色 holo_red_dark
holder.itemView.setOnClickListener(v -> listener.onItemClick(expense));   // lambda
```

**MainActivity**：`SharedPreferences` 記「上次類別」→ 啟動時恢復；`ExpenseAdapter(expense -> showDeleteDialog(expense))`；`addExpense()` 用 `Double.parseDouble` + **try/catch 抓 `NumberFormatException`**；`loadData()` 用 `getAll()` + `getTotal()`（`Locale.TAIWAN` 千分號）。

> 💡 這支把 Day 3 三種概念串起來：**Room 存資料、RecyclerView 顯示、SharedPreferences 記偏好**。

---

# ⭐ 第 8 章　記帳 App：測試流程

| 步驟 | 操作 | 預期結果 |
|---|---|---|
| 1 | 輸入「午餐」100、選「支出」→ 新增 | 列表「支出 午餐 -100」(紅)，總額 = -100 |
| 2 | 輸入「薪水」3000、選「收入」→ 新增 | 列表「收入 薪水 +3,000」(綠)，總額 = 2,900 |
| 3 | **重開 App** | 資料仍在，且「收入」按鈕已自動選中（SharedPreferences ✓） |
| 4 | 點任一列 | 刪除確認框 → 確定後移除、總額更新 |

> ✅ 這是你的「三天學習總成果」專案。可繼續擴充：日期欄位、`LiveData<Double>` 自動更新、匯出 CSV、`ItemTouchHelper` 滑動刪除。

---

# AI 動手做｜5-4 記帳 App 總成果提示（指南 §5-4）

```
請幫我完成「記帳 App」總成果專案，套件 com.example.expenseapp，整合 Day1-3 所有技能：

依賴：appcompat、material、recyclerview、room-runtime + annotationProcessor room-compiler

1. Expense.java：@Entity tableName="expense"，int id 主鍵、String title、double amount、int type(0=支出,1=收入)
2. ExpenseDao.java：@Insert / @Delete / @Query getAll / getTotal() 用 SUM+CASE WHEN 計算「支出-收入」淨額（用 IFNULL 防 NULL）
3. AppDatabase.java：double-checked locking 單例 getInstance，expense.db
4. row_expense.xml：水平 LinearLayout，左側垂直(tvTitle + tvType)、右側 tvAmount(靠右 18sp 粗體)
5. ExpenseAdapter.java：# 自訂 interface OnItemClick（只有一個方法 → functional interface → 可用 lambda）
   - onBindViewHolder：tvType 收入/支出、tvAmount String.format("%s%,.0f", sign, amount)、收入綠/支出紅
6. activity_main.xml：tvTotal、etTitle、etAmount(numberDecimal)、RadioGroup(支出/收入)、btnAdd、RecyclerView
7. MainActivity.java：dao 取得、SharedPreferences 記上次類別並恢復、adapter 用 lambda、addExpense 驗證+try/catch、loadData 更新總額
請特別說明：為什麼這裡 Adapter 的監聽能用 lambda，但 5-1 Memo 的 OnMemoClickListener 不能。
```

**驗證**：午餐支出 -100 → 薪水收入 +3,000 → 總額 2,900 → 重開資料仍在、收入按鈕自動選中。

---

# AI 動手做｜遇到錯誤，讓 AI 幫你除錯（指南 §6）

| 常見問題 | 你可以這樣問 |
|---|---|
| Room 編譯錯誤 / import 不過 | 「Java 專案是不是要用 annotationProcessor 而不是 kapt？build.gradle 該怎麼寫？」 |
| `requires an entity` / 找不到無參數建構子 | 「Room 說 Entity 需要無參數建構子，Entity/DAO/Database 該怎麼寫？」 |
| 主執行緒同步 Room | 「主執行緒直接呼叫 dao.getAll() 會有問題嗎？Room 正式做法（LiveData/背景執行緒）？」 |
| 資料重開就不見 | 「我第二次啟動資料消失了，是不是沒用持久化？教我檢查（App Inspection）」 |
| 中文亂碼 | 「寫檔中文變亂碼，是不是要用 UTF-8？openFileOutput 怎麼指定編碼？」 |
| 記帳總額算錯 | 「getTotal() 的 SUM/CASE WHEN/IFNULL 邏輯幫我檢查」 |

> 貼上**完整錯誤訊息**與你的程式碼，AI 才能精準定位。

---

# 第 9 章　自我測驗（先寫再對答案）

1. SharedPreferences、檔案、SQLite 各適合什麼場景？
2. SQLite 中 `?` 佔位符的用途是什麼？為什麼不用直接拼字串？
3. Cursor 與 JDBC 的 ResultSet 有何相似？
4. Room 的 Entity、DAO、Database 三者各自角色為何？
5. 為什麼官方建議用 Room 而非純 SQLite？

---

# 測驗解答

| # | 解答 |
|---|---|
| 1 | SharedPreferences：key-value 設定；檔案：原始資料讀寫；SQLite/Room：多筆結構化、需查詢/排序/關聯 |
| 2 | `?` 是參數佔位符，執行時安全 bind 值，**防 SQL injection**，避免字串拼接問題（≈ `PreparedStatement`） |
| 3 | 都是查詢結果游標：`moveToNext()`≈`next()`，`getString/getInt(index)`≈`rs.getString(index)` |
| 4 | **Entity**=資料表模型；**DAO**=資料操作介面（Room 自動實作）；**Database**=資料庫入口、單例提供 DAO |
| 5 | 編譯期查 SQL 錯誤、少樣板碼、整合 LiveData/Coroutines、型別安全（≈ JPA 對 JDBC 的便利） |

---

# AI 動手做｜提示寫作重點回顧 + 複習流程（指南 §7）

| 重點 | 做法 |
|---|---|
| Room 一次給整套 | Entity + DAO + Database 一起要，避免對不上 |
| 註明 Java / annotationProcessor | 避免 AI 給你 Kotlin 的 kapt 寫法 |
| Database 要單例 | 明確要求 getApplicationContext + volatile + synchronized |
| lambda 界線再強調 | 單方法介面 → lambda；多方法（OnMemoClickListener）→ anonymous class |
| 附上依賴 | 每次 Room/RecyclerView 範例都要求附 build.gradle 依賴 |

**複習流程**：先自己做一遍（尤其純 SQLite 那支）→ 再讓 AI 產 Room 版對照 → 把 5-4 記帳 App 當總成果跑通 → 練習擴充（LiveData、搜尋、滑動刪除）→ 把 Day 1 的 BMI App 串上 Room / Retrofit。

---

# 三天總結

| 天 | 主題 | 完成小專案 |
|---|---|---|
| Day 1 | 環境、佈局、元件、事件 | BMI 計算機 |
| Day 2 | Intent 跳轉、傳值、列表 | 待辦清單（記憶體） |
| Day 3 | SharedPreferences、檔案、SQLite/Room | 備忘錄 CRUD（持久化） |

**恭喜完成 Android 三天入門！** 接下來可以往：Jetpack Compose、ViewModel、LiveData、網路請求 (Retrofit)、MVVM 架構、「Android + Spring Boot」整合前進。

> 延伸閱讀：`Appendix_C_Troubleshooting.md`（排錯）、`Appendix_D_Gradle_Setup.md`（Gradle）、`Appendix_E_Debugging.md`（除錯）、`Appendix_G_Lifecycle.md`。