# Android 三天入門 — 課程總覽（含 AI 協作指南）

> 對象：具備 Java 開發經驗、熟悉 Swing / JFrame 的開發者，想以 Java 開發 Android App，並進一步連結後端 Spring Boot REST API。
> 教材：`01`–`03` 為三天合併完整教材；`04`–`06` 為「搭配 AI 產生程式碼」的提示互動指南。
> 對照方式：全程以「JFrame → Android」的對照思維講解（⚡ 標記）。

---

## 課程檔案一覽（01–06）

| 檔號 | 檔案 | 主題 | 類型 |
|------|------|------|------|
| 01 | `01_Day1_Complete.md` | Day 1 — 環境建置與基礎：建立第一個 App | 完整教材 |
| 02 | `02_Day2_Complete.md` | Day 2 — 多頁面 App：Intent 跳轉、傳值、列表 | 完整教材 |
| 03 | `03_Day3_Complete.md` | Day 3 — 資料持久化：SharedPreferences、檔案、SQLite/Room | 完整教材 |
| 04 | `04_AI_Prompt_Guide_Day1.md` | Day 1 搭配 AI：每個章節的可複製提示 | AI 互動指南 |
| 05 | `05_AI_Prompt_Guide_Day2.md` | Day 2 搭配 AI：多 Activity / Intent / 列表提示 | AI 互動指南 |
| 06 | `06_AI_Prompt_Guide_Day3.md` | Day 3 搭配 AI：Room / SQLite / 記帳總成果提示 | AI 互動指南 |

> 建議用法：**先讀 `01–03` 完整教材照做，再用 `04–06` 讓 AI 產生同一支程式互相對照**，強化理解。

---

## 總覽（三天進度與成果）

| 天 | 主題 | 主線技能 | 完成小專案 |
|---|---|---|---|
| **Day 1** | 環境建置與基礎 | Android 專案結構、XML 佈局、View 元件、事件綁定 | BMI 計算機、溫度轉換器、登入表單、View 互動展示 |
| **Day 2** | 多頁面 App | Activity、Intent 跳轉、跨頁傳值、列表 (ListView/RecyclerView)、Dialog | 待辦事項、商品編輯傳值、顏色選擇器 |
| **Day 3** | 資料持久化 | SharedPreferences、內部儲存、SQLite、Room | 備忘錄 (Room CRUD)、使用者設定、活動報名、記帳 App |

> 三天合起來即可完成一支「會儲存資料的多頁面 App」，並具備往 Jetpack / MVVM / 網路請求 (Retrofit) 前進的基礎。

---

# Day 1 — 環境建置與基礎（建立第一個 Android App）

> 對應教材：`01_Day1_Complete.md` ｜ AI 指南：`04_AI_Prompt_Guide_Day1.md`
> 時間：約 6–8 小時

核心目標：熟悉 Android 與 JFrame 的「元件導向」共通思維，跨越「XML 佈局 vs 直接 new 元件」的思維差異。

| 章節 | 主題 | 重點 |
|---|---|---|
| 第 0 章 | 為什麼從 JFrame 遷移到 Android 不太難 | 元件對照表、先備知識、「先 XML 再 findViewById」 |
| 第 1 章 | 安裝環境 | Android Studio、模擬器 (AVD) |
| 第 2 章 | 建立第一個專案 | Empty Views Activity、Java、Minimum SDK |
| 第 3 章 | Android 專案結構 | `java/`、`res/layout/`、`AndroidManifest.xml`、`build.gradle` |
| 第 4 章 | 第一個畫面：activity_main.xml | `LinearLayout`、`match_parent`/`wrap_content`、`dp`/`sp`/`px` |
| 第 5 章 | 綁定元件與事件 | `findViewById`、`setOnClickListener`、functional interface + lambda |
| 第 6 章 | Toast 與 Log | `Toast.makeText(...)`、`Log.v/d/i/w/e`、TAG 過濾 |
| 第 7 章 | 常用 View 元件一覽 | TextView/EditText/Button/ImageView/CheckBox/RadioButton/Spinner、`inputType` |
| 第 8 章 | 頁面跳轉預告 | `Intent` 概念（Day 2 展開） |

### Day 1 完整範例

| 範例 | 練習重點 |
|---|---|
| **9. BMI 計算機** | 數字輸入與驗證、單位換算、if/else 分類、`String.format` |
| **10. 溫度轉換器** | RadioGroup 單選、負數+小數輸入、條件轉換 |
| **11. 登入表單** | CheckBox 切換密碼顯示、AlertDialog 錯誤提示 |
| **12. 常用 View 互動展示** | ImageView/Spinner/Switch/SeekBar/RatingBar 取值、lambda vs anonymous class |

- **第 13 章**：自我測驗與解答
- **AI 指南 `04`**：每個章節與範例都有可複製的提示（含練習擴充提示）

---

# Day 2 — 多頁面 App（Intent 跳轉、傳值、列表）

> 對應教材：`02_Day2_Complete.md` ｜ AI 指南：`05_AI_Prompt_Guide_Day2.md`
> 時間：約 6–8 小時

核心目標：學會「一個畫面 = 一個 Activity」，用 Intent 在畫面間移動、傳資料、回傳結果。

| 章節 | 主題 | 重點 |
|---|---|---|
| 第 1 章 | 認識 Activity（多個畫面） | 一畫面一 Activity、AndroidManifest.xml 註冊 |
| 第 2 章 | Intent：啟動新的 Activity | `new Intent(this, SecondActivity.class)`、`startActivity` |
| 第 3 章 | 畫面間傳遞資料 | `putExtra`/`getExtra`（取代 `showInputDialog`） |
| 第 4 章 | 回傳結果給前一個畫面 | 新版 Result API vs 舊 `startActivityForResult`；⚠️ `onActivityResult` 不能用 lambda |
| 第 5 章 | Intent 的其它用法 | 系統 Intent（`ACTION_DIAL`、`ACTION_VIEW`） |
| 第 6 章 | 顯示列表：ListView（入門） | `ArrayAdapter`、`simple_list_item_1` |
| 第 7 章 | 顯示列表：RecyclerView（進階） | `RecyclerView.Adapter` + `ViewHolder` |
| 第 8 章 | 資料容器：ArrayList | 動態增刪、搭配列表 |
| 第 9 章 | Dialog：AlertDialog | 流式寫法（取代 JOptionPane） |

### Day 2 完整範例

| 範例 | 練習重點 |
|---|---|
| **兩頁面跳轉 (第 2 章)** | 最基本的 `startActivity` 跳轉 |
| **A→B 傳值 (第 3 章)** | putExtra / getExtra、預設值 |
| **A⇄B 回傳結果 (第 4 章)** | 新版 Result API + 舊寫法對照 |
| **系統功能 (第 5 章)** | 撥號、開網頁 |
| **10. 待辦事項 Todo App** | ListView + ArrayAdapter + ArrayList、長按刪除 |
| **11. 商品編輯傳值** | Intent + putExtra/getExtra、雙頁面往返 |
| **12. 顏色選擇器** | RecyclerView + Adapter + Intent 回傳結果 |

- **第 13 章**：自我測驗與解答
- **AI 指南 `05`**：特別強調「新版能 lambda / 舊版不能」的提示界線

---

# Day 3 — 資料持久化（SQLite / Room 資料庫 + SharedPreferences）

> 對應教材：`03_Day3_Complete.md` ｜ AI 指南：`06_AI_Prompt_Guide_Day3.md`
> 時間：約 6–8 小時

核心目標：讓資料「關掉 App 重開」後仍在。分「非資料庫」與「資料庫」兩大步驟。

| 章節 | 主題 | 重點 |
|---|---|---|
| 第 0 章 | 概觀：三種資料儲存方式 | SharedPreferences / 檔案 / SQLite–Room 適用場景 |
| 第 1 章 | SharedPreferences（輕量 key-value） | `getSharedPreferences`、`Editor`、`apply()` vs `commit()` |
| 第 2 章 | 內部儲存（File 讀寫） | `openFileOutput`/`openFileInput`、try-with-resources、UTF-8 |
| 第 3 章 | SQLite（直接寫 SQL） | `SQLiteOpenHelper`、CRUD 的 `?` 參數、`Cursor`（對照 ResultSet） |
| 第 4 章 | Room（官方推薦 ORM） | gradle 依賴、三大核心 Entity/DAO/Database、使用 CRUD |

### Day 3 完整範例

| 範例 | 練習重點 |
|---|---|
| **5. 備忘錄 Memo App** | Room CRUD + RecyclerView、lambda vs anonymous class |
| **6. 使用者設定** | SharedPreferences + 內部儲存檔案 + AlertDialog |
| **7. 活動報名名單** | 純 SQLite 完整 CRUD、與 Room 對照 |
| **8. 記帳 App（總成果）** | Room + RecyclerView + SharedPreferences 整合、`SUM` 彙總 SQL |

- **第 9 章**：自我測驗與解答
- **三天總結**：三種持久化技術總整理、進階挑戰（LiveData / ViewModel / MVVM）
- **AI 指南 `06`**：特別強調 Room 依賴要用 `annotationProcessor`（Java 非 kapt）、Room 一次給整套

---

## 貫穿三天的兩條主線

**1. JFrame ↔ Android 對照**（每章 ⚡ 標記）
- `new JFrame` → `setContentView(R.layout.xxx)` + `startActivity`
- `new JButton("文字")` → XML 宣告 + `findViewById`
- `addActionListener` → `setOnClickListener`
- `JOptionPane` → `Toast` / `AlertDialog`
- `showInputDialog` 傳值 → `Intent` + `putExtra/getExtra`
- `JDBC + MySQL` → 內建 `SQLite` / `Room`

**2. Lambda 適用準則**
- **單一抽象方法介面（Functional Interface）→ 可用 lambda**（`setOnClickListener`、`OnItemClick`、`OnCheckedChangeListener`…）
- **多個方法介面或方法覆寫 → 只能 anonymous class**（`onActivityResult`、`OnItemSelectedListener`、`OnSeekBarChangeListener`、`OnMemoClickListener`…）
- 正式 App 建議：Room 用 `LiveData` + background thread（教材為求理解採同步）

---

## AI 協作教學法（搭配 04–06 指南）

| 步驟 | 做法 |
|---|---|
| 1. 先自己做 | 先照 `01–03` 教材實作，不看 AI |
| 2. 再用 AI | 用 `04–06` 的提示讓 AI 產生同一支程式 |
| 3. 比對差異 | 對照你寫的 vs AI 寫的，看不同處 |
| 4. 讓 AI 出測驗 | 驗證你真正懂 |
| 5. 練習擴充 | 用「練習擴充提示」新增功能挑戰自己 |

> 核心心法：**你決定需求，AI 寫程式，但你要看懂、能改、能驗證**。AI 是幫你反覆練習，不是幫你抄作業。

---

## 建議學習路線

1. 依序讀完 **Day 1 → Day 2 → Day 3**（`01`→`02`→`03`，每章照貼程式實作）。
2. 每章末「自我測驗」先作答再看解答。
3. 完整範例照貼後**實際 Run 到模擬器驗證**。
4. 完成後搭配 **`04`–`06` AI 指南**反覆練習與擴充。

---

