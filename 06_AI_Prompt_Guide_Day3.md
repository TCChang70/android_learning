# Day 3 搭配 AI 的提示互動指南

> 這份文件教你「如何把我（AI）當成工具，產生 `03_Day3_Complete.md` 裡每一段程式碼」。
> 使用前提：你已完成 Day 1、Day 2（會 Activity、Intent、RecyclerView、lambda）。
> 主題：資料持久化 —— SharedPreferences（輕量設定）、內部儲存（檔案）、SQLite/Room（資料庫）。
> 核心心法同前兩天：**你決定需求，AI 寫程式，但你要看懂、能改、能驗證**。

---

## 目錄

- [0. 與 AI 互動提醒](#0-與-ai-互動提醒)
- [1. SharedPreferences（輕量 key-value）](#1-sharedpreferences)
- [2. 內部儲存（檔案讀寫）](#2-內部儲存)
- [3. SQLite（直接寫 SQL）](#3-sqlite)
- [4. Room（官方推薦 ORM）](#4-room)
- [5. 四個完整範例的提示](#5-四個完整範例的提示)
  - [5-1 備忘錄 Memo App（Room + RecyclerView）](#5-1-備忘錄-memo-app)
  - [5-2 使用者設定（SharedPreferences + 檔案）](#5-2-使用者設定)
  - [5-3 活動報名名單（純 SQLite CRUD）](#5-3-活動報名名單)
  - [5-4 記帳 App 總成果](#5-4-記帳-app-總成果)
- [6. 讓 AI 幫你除錯](#6-讓-ai-幫你除錯)
- [7. 提示寫作重點回顧（Day 3）](#7-提示寫作重點回顧)

---

## 0. 與 AI 互動提醒

| 提醒 | 說明 |
|---|---|
| **Room 依賴要用 `annotationProcessor`** | Java 專案用 `annotationProcessor`，**不是** `kapt`（那是 Kotlin） |
| **Room 三大件一起要** | Entity + DAO + Database 缺一不可，一次請 AI 一起給 |
| **Database 是單例** | 提醒 AI 用「雙重檢查鎖定」單例 + `context.getApplicationContext()` |
| **注意 lambda 界線** | `MemoAdapter.OnMemoClickListener` 有兩個方法 → 只能用 anonymous class；單方法介面才用 lambda |
| **同步是為教學** | 教材用同步 DAO 是求理解；AI 若提到非同步/LiveData，先知道那是正式做法即可 |

> 橘色 `[ ... ]` 是你要自己填的部分；提示都是可複製的完整範例。

---

## 1. SharedPreferences

**提示 1：學習 / 產生 SharedPreferences**
```
我是有 JDBC/Swing 經驗的 Java 開發者，正在學 Android。請教我 SharedPreferences：
1. 用 JFrame 的 config.properties / Properties 對照解釋
2. 給我一小段可編譯程式：
   - getSharedPreferences("memo_prefs", MODE_PRIVATE) 取設定
   - editor.putString / putInt + apply() 寫入
   - prefs.getString(name, 預設值) / getInt(counter, 0) 讀取
3. 解釋 apply() vs commit() 的差別（何者非同步、何者回傳 boolean）
請用 Java，放進一個 Activity 的範例方法裡。
```

---

## 2. 內部儲存

**提示 2：學習 / 產生檔案讀寫**
```
請教我用 JFrame 的 FileWriter/FileReader 對照 Android 內部儲存：
1. 解釋 openFileOutput / openFileInput 與 private files 目錄（不需權限）
2. 給一小段可編譯程式：
   - 寫檔：try-with-resources + FileOutputStream + content.getBytes()，catch IOException
   - 讀檔：FileInputStream + BufferedReader 逐行讀，組回 StringBuilder
3. 提醒 try-with-resources 與 UTF-8（避免中文亂碼）
```

---

## 3. SQLite

**提示 3：產生 SQLite 的 DBHelper + CRUD**
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

> 對照 `03_Day3_Complete.md` 第 3 章。

---

## 4. Room

**提示 4：產生 Room 三大件 + 使用範例**
```
我是 Java Android 開發者，請教我 Room（對照 JPA 對 JDBC）。給我完整的三個 class + 使用範例：

1. build.gradle 依賴：room-runtime + room-compiler（請用 annotationProcessor，因為是 Java，不是 kapt）

2. Memo.java（@Entity tableName="memo"）：@PrimaryKey(autoGenerate=true) int id、String title、String content、要有無參數建構子

3. MemoDao.java（@Dao 介面）：
   - @Insert void insert(Memo)
   - @Update void update(Memo)
   - @Delete void delete(Memo)
   - @Query("SELECT * FROM memo ORDER BY id DESC") List<Memo> getAll()

4. AppDatabase.java（@Database entities={Memo.class} version=1，抽象 class 繼承 RoomDatabase）：
   - 用 double-checked locking 單例 getInstance(Context)
   - Room.databaseBuilder(context.getApplicationContext(), AppDatabase.class, "memo.db").build()

5. Activity 內使用：AppDatabase.getInstance(this).memoDao() → dao.insert(new Memo(...))、dao.getAll()、dao.update / dao.delete

請說明 Entity / DAO / Database 三個角色，以及為何 Database 用單例。
```

---

## 5. 四個完整範例的提示

每個範例都是「你給需求 → AI 產出完整檔案 → 你照貼 → 驗證」。

---

### 5-1 備忘錄 Memo App（Room + RecyclerView）

**需求提示**（對應 Day3 第 5 章，`com.example.memoapp`）
```
我學到「備忘錄 Memo App」，整合 Day 2 的 RecyclerView + Day 3 的 Room，套件 com.example.memoapp，請幫我產出完整檔案：

依賴：appcompat、material、recyclerview、room-runtime + annotationProcessor room-compiler

1. Memo.java：@Entity + @PrimaryKey(autoGenerate=true) int id、String title、String content、無參數建構子 + (title, content) 建構子
2. MemoDao.java：@Insert / @Update / @Delete / @Query("SELECT * FROM memo ORDER BY id DESC") List<Memo> getAll()
3. AppDatabase.java：double-checked locking 單例 getInstance
4. row_memo.xml：垂直 LinearLayout，TextView tvTitle(18sp 粗體) + tvContent(14sp)
5. MemoAdapter.java：繼承 RecyclerView.Adapter
   - 注意：自訂 interface OnMemoClickListener 有「兩個」方法 onMemoClick + onMemoLongClick → 不是 functional interface，不能用 lambda
   - onCreateViewHolder inflate row_memo、onBindViewHolder setText + itemView.setOnClickListener / setOnLongClickListener（這兩個內部是 lambda，但傳給 Adapter 的監聽器要 anonymous class）
   - 內部 static MemoViewHolder
   - setMemos() 整批更新 + notifyDataSetChanged
6. activity_main.xml：EditText etTitle + etContent + 按鈕 btnAdd + RecyclerView
7. MainActivity.java：
   - dao = AppDatabase.getInstance(this).memoDao()
   - adapter = new MemoAdapter(new MemoAdapter.OnMemoClickListener(){...}) ← 用 anonymous class，因為有兩個方法
   - 新增、點擊(編輯 AlertDialog 動態 EditText)、長按(刪除 AlertDialog)、loadMemos()
請特別標出：哪些用 lambda、哪些要用 anonymous class（OnMemoClickListener）。
```

**練習擴充提示**
```
請把 MemoDAO 改成回傳 LiveData<List<Memo>>，讓 UI 自動更新（不需要手動 loadMemos）。
```

**驗證**：新增幾筆 → **關掉 App 重開 → 資料還在**（Room 持久化 ✓）。

---

### 5-2 使用者設定（SharedPreferences + 檔案）

**需求提示**（對應 Day3 第 6 章，`com.example.usersettings`）
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

### 5-3 活動報名名單（純 SQLite CRUD）

**需求提示**（對應 Day3 第 7 章，`com.example.signupapp`）
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

**練習擴充提示**
```
請幫活動報名改用 SELECT COUNT(*) 顯示人數（取代在 Java 自己 count），並加「修改電話」功能。
```

**驗證**：報名 → 出現「姓名 (電話)」→ 重開資料仍在 → 長按刪除。

---

### 5-4 記帳 App 總成果

**需求提示**（對應 Day3 第 8 章，`com.example.expenseapp`）
```
請幫我完成「記帳 App」總成果專案，套件 com.example.expenseapp，整合 Day1-3 所有技能。
請產出以下完整檔案：

依賴：appcompat、material、recyclerview、room-runtime + annotationProcessor room-compiler

1. Expense.java：@Entity tableName="expense"，int id 主鍵、String title、double amount、int type(0=支出,1=收入)、無參數+參數建構子
2. ExpenseDao.java：@Insert / @Delete / @Query getAll / @Query 用 SUM+CASE WHEN 計算「支出-收入」淨額 getTotal() 回傳 double（用 IFNULL 防 NULL）
3. AppDatabase.java：double-checked locking 單例 getInstance，expense.db
4. row_expense.xml：水平 LinearLayout，左側垂直(TextView tvTitle + tvType)、右側 TextView tvAmount(靠右 18sp 粗體)
5. ExpenseAdapter.java：繼承 RecyclerView.Adapter
   - 自訂 interface OnItemClick（只有一個方法 → functional interface → 可用 lambda）
   - onBindViewHolder：tvType 顯示 收入/支出、tvAmount 用 String.format("%s%,.0f", sign, amount)、收入綠色/支出紅色、點擊 lambda
   - 內部 static ExpenseViewHolder、setExpenses()
6. activity_main.xml：TextView tvTotal、EditText etTitle、etAmount(numberDecimal)、RadioGroup(支出/收入)、按鈕 btnAdd、RecyclerView
7. MainActivity.java：
   - dao = AppDatabase.getInstance(this).expenseDao()
   - SharedPreferences 記住上次選的類別，啟動時 radioGroup.check 恢復
   - adapter = new ExpenseAdapter(expense -> showDeleteDialog(expense)) ← 這是 lambda（單一方法介面）
   - addExpense()：驗證、Double.parseDouble 包 try/catch、判斷支出/收入、putInt 記偏好、dao.insert、loadData()
   - loadData()：dao.getAll + dao.getTotal 更新總額（String.format(Locale.TAIWAN, ...)）
   - showDeleteDialog：AlertDialog 確認刪除
請特別說明：為什麼這裡 Adapter 的監聽能用 lambda，但 5-1 Memo 的 OnMemoClickListener 不能。
```

**驗證**：午餐支出 -100 → 薪水收入 +3,000 → 總額 2,900 → 重開 App 資料仍在、收入按鈕自動選中。

---

## 6. 讓 AI 幫你除錯

Day 3 常見問題與提問方式：

| 常見問題 | 你可以這樣問 |
|---|---|
| Room 編譯錯誤 / import 不過 | 「我加了 room 依賴但 import androidx.room.* 不過，Java 專案是不是要用 annotationProcessor 而不是 kapt？build.gradle 該怎麼寫？」 |
| `requires an entity` / 找不到 void no-arg constructor | 「Room 說我的 Entity 需要無參數建構子，Entity/DAO/Database 該怎麼寫？」 |
| 網路 / 主執行緒錯誤（同步 Room） | 「我在主執行緒直接呼叫 dao.getAll() 有時會不會有問題？Room 建議的正式做法是什麼？」 |
| 資料重開就不見 | 「我第二次啟動 App 資料消失了，是不是我沒用持久化？教我怎麼檢查資料庫（App Inspection）」 |
| 中文亂碼 | 「我寫檔中文變亂碼，是不是要用 UTF-8？openFileOutput 怎麼指定編碼？」 |
| 記帳總額算錯 | 「getTotal() 回傳的 SQL 請幫我檢查 SUM/CASE WHEN/IFNULL 的邏輯」 |

> 貼上**完整錯誤訊息**與你的程式碼，AI 才能精準定位。

---

## 7. 提示寫作重點回顧（Day 3）

| 重點 | 做法 |
|---|---|
| **Room 一次給整套** | Entity + DAO + Database 一起要，避免對不上 |
| **註明 Java / annotationProcessor** | 避免 AI 給你 Kotlin 的 kapt 寫法 |
| **Database 要單例** | 明確要求 getApplicationContext + volatile + synchronized |
| **lambda 界線再強調** | 單方法介面 → lambda；多方法（OnMemoClickListener）→ anonymous class |
| **附上依賴** | 每次 Room/RecyclerView 範例都要求附 build.gradle 依賴 |

---

## 建議複習流程（Day 3）

1. **先自己做一遍**（尤其純 SQLite 那支，掌握底層）
2. **再用提示讓 AI 產出 Room 版**，對照 SQLite vs Room 的差異（第 7 章末有對照表）
3. **把 5-4 記帳 App 當總成果**照貼並跑通
4. **練習擴充**：LiveData、日期欄位、搜尋 `LIKE`、滑動刪除
5. **最後把 Day 1 的 BMI App 串上 Room / Retrofit**，邁向「Android + Spring Boot」整合

> 三天指南串起來之後，就可以往「Android + Retrofit + Spring Boot REST API」的整合（前面討論過的方向）前進。
