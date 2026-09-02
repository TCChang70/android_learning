# Android 三天入門 — 課程大綱

> 對象：具備 Java 開發經驗、熟悉 Swing / JFrame 的開發者。
> 教材：合併版每日完整檔（`.MD` 位於 `consolidated\`）。
> 對照方式：全程以「JFrame → Android」的對照思維講解。

---

## 總覽（三天進度與成果）

| 天 | 主題 | 主線技能 | 完成小專案 |
|---|---|---|---|
| **Day 1** | 環境建置與基礎 | Android 專案結構、XML 佈局、View 元件、事件綁定 | BMI 計算機、溫度轉換器、登入表單、View 互動展示 |
| **Day 2** | 多頁面 App | Activity、Intent 跳轉、跨頁傳值、列表 (ListView/RecyclerView)、Dialog | 待辦事項、商品編輯傳值、顏色選擇器 |
| **Day 3** | 資料持久化 | SharedPreferences、內部儲存、SQLite、Room | 備忘錄 (Room CRUD)、使用者設定、活動報名、記帳 App |

> 三天合起來即可完成一支「會儲存資料的多頁面 App」，並具備往 Jetpack / MVVM 前進的基礎。

---

## Day 1 — 環境建置與基礎（建立第一個 Android App）

核心目標：熟悉 Android 與 JFrame 的「元件導向」共通思維，跨越「XML 佈局 vs 直接 new 元件」的思維差異。

### 第 0 章　為什麼從 JFrame 遷移到 Android 不太難
- 元件導向共通性對照表（JFrame / Activity、JButton / Button、Listener / OnClick…）
- 先備知識清單
- 最重要的一課：元件要「先寫在 XML，再用 findViewById 綁定」；lambda 與傳統 anonymous class 對照

### 第 1 章　安裝環境
- 安裝 Android Studio、建立模擬器 (AVD)

### 第 2 章　建立第一個專案
- Empty Views Activity、Java、Minimum SDK 設定

### 第 3 章　Android 專案結構（對照 JFrame 專案）
- `java/`、`res/layout/`、`res/values/`、`AndroidManifest.xml`、`build.gradle`

### 第 4 章　第一個畫面：activity_main.xml
- `LinearLayout`、`match_parent` / `wrap_content`、尺寸單位 `dp` / `sp` / `px`

### 第 5 章　綁定元件與事件
- `findViewById`、`setOnClickListener`、functional interface 與 lambda
- **完整範例 1**：Toast 訊息 + Log 日誌互動 App（6.1）

### 第 6 章　Toast 與 Log（取代 JOptionPane）
- `Toast.makeText(...).show()`、長短、置中
- `Log.v/d/i/w/e` 五層級與 TAG 過濾

### 第 7 章　常用 View 元件一覽
- TextView / EditText / Button / ImageView / CheckBox / RadioButton / Spinner、`inputType`

### 第 8 章　頁面跳轉預告
- `Intent` 概念預告（Day 2 展開）

### 完整範例（本章實作小專案）
| 範例 | 練習重點 |
|---|---|
| **9. BMI 計算機** | 數字輸入與驗證、單位換算、if/else 分類、`String.format` |
| **10. 溫度轉換器** | RadioGroup 單選、負數+小數輸入、條件轉換 |
| **11. 登入表單** | CheckBox 切換密碼顯示、AlertDialog 錯誤提示 |
| **12. 常用 View 互動展示** | ImageView / Spinner / Switch / SeekBar / RatingBar 取值、lambda vs anonymous class |

### 第 13 章　自我測驗與解答

---

## Day 2 — 多頁面 App（Intent 跳轉、傳值、列表）

核心目標：學會「一個畫面 = 一個 Activity」，用 Intent 在畫面間移動、傳資料、回傳結果。

### 第 1 章　認識 Activity（多個畫面）
- 一畫面一 Activity、AndroidManifest.xml 註冊

### 第 2 章　Intent：啟動新的 Activity
- `new Intent(this, SecondActivity.class)`、`startActivity`
- **完整範例**：兩頁面跳轉 App

### 第 3 章　畫面間傳遞資料
- `putExtra` / `getExtra`（取代 `showInputDialog` 回傳值）
- **完整範例**：A → B 傳值 App

### 第 4 章　回傳結果給前一個畫面
- `startActivityForResult`（新舊 API 對照）
- ⚠️ `onActivityResult` 是方法覆寫 → 只能用 anonymous class，不能用 lambda
- **完整範例**：A ⇄ B 回傳結果 App

### 第 5 章　Intent 的其它用法
- 系統 Intent（撥號 `ACTION_DIAL`、開啟網頁 `ACTION_VIEW`）
- **完整範例**：系統功能 App

### 第 6 章　顯示列表：ListView（入門）
- `ArrayAdapter`、`simple_list_item_1`

### 第 7 章　顯示列表：RecyclerView（常用進階）
- `RecyclerView.Adapter` + `ViewHolder`

### 第 8 章　資料容器：ArrayList（取代陣列）
- `ArrayList` 增刪、搭配列表
- **完整範例**：可增刪待辦清單 App

### 第 9 章　Dialog：AlertDialog（取代 JOptionPane 彈窗）
- AlertDialog 流式寫法

### 完整範例（本章整合）
| 範例 | 練習重點 |
|---|---|
| **10. 待辦事項 Todo App** | ListView + ArrayAdapter + ArrayList、長按刪除 |
| **11. 商品編輯傳值** | Intent + putExtra/getExtra、雙頁面往返 |
| **12. 顏色選擇器** | RecyclerView + Adapter + Intent 回傳結果 |

### 第 13 章　自我測驗與解答

---

## Day 3 — 資料持久化（SQLite / Room 資料庫 + SharedPreferences）

核心目標：讓資料「關掉 App 重開」後仍在。分「非資料庫」與「資料庫」兩大步驟。

### 第 0 章　概觀：三種資料儲存方式
- SharedPreferences / 內部儲存 / SQLite–Room 的適用場景表

### 第 1 章　SharedPreferences（輕量 key-value）
- `getSharedPreferences`、`Editor`、`apply()` vs `commit()`、讀取與預設值

### 第 2 章　內部儲存（File 讀寫）
- `openFileOutput` / `openFileInput`、try-with-resources、UTF-8

### 第 3 章　SQLite（直接寫 SQL）
- `SQLiteOpenHelper` 建表 / 升級、CRUD 的 `?` 參數、`Cursor`（對照 ResultSet）

### 第 4 章　Room（官方推薦的 ORM）
- gradle 依賴、三大核心：Entity / DAO / Database 單例、使用 CRUD

### 完整範例（本章整合）
| 範例 | 練習重點 |
|---|---|
| **5. 備忘錄 Memo App** | Room CRUD + RecyclerView、lambda vs anonymous class |
| **6. 使用者設定** | SharedPreferences + 內部儲存檔案 + AlertDialog |
| **7. 活動報名名單** | 純 SQLite 完整 CRUD、與 Room 對照 |
| **8. 記帳 App（總成果）** | Room + RecyclerView + SharedPreferences 整合、`SUM` 彙總 SQL |

### 第 9 章　自我測驗與解答

### 三天總結
- 三種持久化技術總整理、進階挑戰（LiveData / ViewModel / MVVM 前路）

---

## 貫穿三天的兩條主線

1. **JFrame ↔ Android 對照**（每章 ⚡ 標記）
   - `new JFrame` → `setContentView(R.layout.xxx)` + `startActivity`
   - `new JButton("文字")` → XML 宣告 + `findViewById`
   - `addActionListener` → `setOnClickListener`
   - `JOptionPane` → `Toast` / `AlertDialog`
   - `showInputDialog` 傳值 → `Intent` + `putExtra/getExtra`
   - `JDBC + MySQL` → 內建 `SQLite` / `Room`

2. **Lambda 適用準則**
   - **單一抽象方法介面（Functional Interface）→ 可用 lambda**
     （`setOnClickListener`、`OnItemClick`、`setOnCheckedChangeListener`、`setOnRatingBarChangeListener`…）
   - **多個方法介面或方法覆寫 → 只能 anonymous class**
     （`onActivityResult`、`OnItemSelectedListener`、`OnSeekBarChangeListener`、`OnMemoClickListener`…）
   - 正式 App 建議：Room 用 `LiveData` + background thread（教材為求理解採同步）

---

## 建議學習路線

1. 依序讀完 **Day 1 → Day 2 → Day 3** 合併檔（每章照著貼程式實作）。
2. 每章末「自我測驗」先作答再看解答。
3. 完整範例照貼後**實際 Run 到模擬器驗證**。
4. 完成後挑戰各章的「可練習擴充」與「進階挑戰」。
5. 延伸閱讀：`Appendix_A`（專案建立）、`Appendix_B`（Lambda）、`Appendix_D`（Gradle）、`Appendix_G`（生命週期）、`Appendix_H`（Swing vs Android）。