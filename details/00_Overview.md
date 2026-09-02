# Android 程式開發 3 天學習指南（Java + XML）

> 對象：具備 Java 程式開發經驗，熟悉 JFrame 視窗程式開發
> 路徑：**Java + XML 佈局** + **資料庫 / 檔案存取**
> 預估總時數：3 天（每天約 6–8 小時）

---

## 為什麼從 JFrame 遷移到 Android 不會太難

如果你熟悉 Swing/JFrame，你會發現 Android 的元件導向思維是共通的：

| JFrame 概念 | Android 對應 | 說明 |
|---|---|---|
| `JFrame`（主視窗） | `Activity` | 一個畫面 = 一個 Activity |
| `JButton` / `JTextField` / `JLabel` | `Button` / `EditText` / `TextView` | UI 元件（View） |
| `setLayout(...)` + 元件定位 | `XML 佈局` + LayoutManager | 宣告式佈局描述 |
| `addActionListener(...)` | `setOnClickListener(...)` | 事件監聽 |
| `JPanel`（容器） | `LinearLayout` / `RelativeLayout` / `FrameLayout` | 容器 ViewGroup |
| 自訂 class 存資料 | `SQLite / Room`、`SharedPreferences` | 資料持久化 |

> 關鍵差異：**佈局改為宣告式 XML**，且 Android 有完整的**生命週期 (Lifecycle)** 概念，這是與 JFrame 最大的不同（JFrame 沒有「被系統回收再重建」的機制）。

---

## 3 天學習地圖總覽

### ✅ Day 1 — 環境與基礎：建立你的第一個 App
- 安裝 Android Studio、建立模擬器 (Emulator)
- 認識 Android 專案結構（`app/`、`MainActivity`、`AndroidManifest.xml`）
- **LinearLayout / RelativeLayout** 佈局
- 常用 **View 元件**：TextView、EditText、Button、ImageView
- **findViewById** 綁定元件（JFrame 最有感的一步）
- Button 事件處理（取代 `addActionListener`）
- Toast 訊息（取代 `JOptionPane`）
- 小實作：**BMI 計算機 App**
- 📂 完整範例（可編譯）：`04_Example_BMI`、`10_Day1_TempConverter`、`11_Day1_LoginForm`

### ✅ Day 2 — 頁面跳轉與列表：多畫面 App
- **Intent** 啟動新 Activity（類似 `new JFrame().setVisible(true)`）
- 畫面間傳遞資料 `putExtra` / `getExtra`
- **startActivityForResult / onActivityResult** 回傳結果（取代 `JOptionPane.showInputDialog`）
- **ListView / RecyclerView** 顯示資料列表（取代 JList / JTable）
- ListView 的 Adapter 機制（Model-View-Adapter，跟 Swing 的 ListModel 很像）
- 小實作：**待辦事項清單 App（暫存於記憶體）**
- 📂 完整範例（可編譯）：`07_Complete_Guide` (Part 2)、`12_Day2_ProductEdit`、`13_Day2_ColorPicker`

### ✅ Day 3 — 資料持久化：把資料存起來
- **SharedPreferences**：輕量 key-value 儲存（取代 Properties / 設定檔）
- **內部儲存 (Internal Storage)**：寫入 / 讀取檔案
- **SQLite** 資料庫：SQL 語法與 `SQLiteOpenHelper`
- **Room**（Google 官方 ORM）：註解式資料庫存取（推薦）
- 資料顯示 + 修改 + 刪除（CRUD）
- 完整實作：**備忘錄 (Memo) 完整 CRUD App + SQLite/Room 持久化**
- 📂 完整範例（可編譯）：`05_Example_MemoApp`、`14_Day3_UserSettings`、`15_Day3_SignUpApp`、`08_Extra_ExpenseTracker`

---

## 建議的每日節奏

每天建議分三塊進行：

1. **上午（2–3 小時）**：讀教材 + 跟著做範例
2. **下午（2–3 小時）**：練習題 / 小實作
3. **睡前（1 小時）**：回答「自我測驗」，回想當天觀念

---

## 檔案清單（本學習包）

| 檔案 | 內容 |
|---|---|
| `00_Overview.md` | (本文件) 三天地圖總覽 |
| `01_Day1_Basics.md` | Day 1 完整教材 + 圖文步驟 |
| `02_Day2_Navigation_Lists.md` | Day 2 完整教材 |
| `03_Day3_Persistence.md` | Day 3 完整教材 |
| `04_Example_BMI.md` | Day 1 BMI 完整程式碼 |
| `05_Example_MemoApp.md` | Day 3 備忘錄完整 CRUD 程式碼 |
| `06_Quiz_Answers.md` | 三天重點測驗 + 解答 |
| `07_Complete_Guide.md` | 一步步實作三專案 + 預期結果 + 常見錯誤排解 |
| `08_Extra_ExpenseTracker.md` | 整合三天技能的額外完整範例（Room + RecyclerView + SharedPreferences） |
| `10_Day1_TempConverter.md` | Day 1 完整範例：溫度轉換（RadioGroup、驗證） |
| `11_Day1_LoginForm.md` | Day 1 完整範例：登入（EditText、CheckBox、AlertDialog） |
| `12_Day2_ProductEdit.md` | Day 2 完整範例：Intent 跳轉 + 雙向傳值 |
| `13_Day2_ColorPicker.md` | Day 2 完整範例：RecyclerView + Intent 回傳 |
| `14_Day3_UserSettings.md` | Day 3 完整範例：SharedPreferences + 檔案儲存 |
| `15_Day3_SignUpApp.md` | Day 3 完整範例：純 SQLite CRUD |
| `Appendix_A_Project_Creation.md` | 共用：建立 Empty Views Activity 專案 |
| `Appendix_B_Lambda.md` | 共用：Lambda vs Anonymous Class |
| `Appendix_C_Troubleshooting.md` | 共用：常見錯誤排解 |
| `Appendix_D_Gradle_Setup.md` | 共用：Gradle 依賴與設定 |
| `Appendix_E_Debugging.md` | 共用：除錯技巧 |
| `Appendix_F_XML_Attrs.md` | 共用：XML 屬性速查 |
| `Appendix_G_Lifecycle.md` | 共用：Activity 生命週期 |
| `Appendix_H_Swing_vs_Android.md` | 共用：JFrame→Android 完整對照 |

---

## 先備知識清單（你應該已具備）

- ✅ Java 基本語法（類別、方法、變數、迴圈、if/else）
- ✅ 繼承、介面、Listener 事件模型
- ✅ 建立 GUI 元件與佈局的觀念
- ✅ (加分) 基本 SQL 語法（SELECT / INSERT / UPDATE / DELETE）

---

## 第一個小提醒（JFrame 使用者最容易犯的錯）

```java
// ❌ 錯誤：JFrame 習慣直接 new 元件之後去找
// Android 的元件必須「先寫在 XML」，再在程式用 findViewById 綁定

// ✅ 正確寫法（Day 1 會學到）
TextView tvTitle = findViewById(R.id.tvTitle);
Button btnSubmit = findViewById(R.id.btnSubmit);
btnSubmit.setOnClickListener(v -> {
    tvTitle.setText("你按了按鈕");
});
```

> Android **沒有 `new JButton("文字")` 這種寫法**。文字通常先在 XML 設定，程式只負責「取得參考 + 綁定事件」。

順帶一提：上面的 `v -> { ... }` 是 **lambda**（Java 8+）。它的原本面貌跟你熟悉的 Swing 完全一樣：

```java
// 兩種寫法完全等價：
// 傳統（跟你 Swing 的 addActionListener 一模一樣）
btnSubmit.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        tvTitle.setText("你按了按鈕");
    }
});

// lambda（只需要設定文字時，一行也行）
btnSubmit.setOnClickListener(v -> tvTitle.setText("你按了按鈕"));
```

---

## 後續怎麼準備環境？

在開始 Day 1 之前，請先安裝：

1. **Android Studio**（官方 IDE，建議下載最新穩定版）
   - 下載：https://developer.android.com/studio
2. 安裝時勾選 **Android Virtual Device (AVD)** 建立模擬器
3. 不需要實體手機也能學（用模擬器即可）

安裝完成後，直接進 `01_Day1_Basics.md` 開始第一天！

---

下一份文件 → [Day 1：環境與基礎](01_Day1_Basics.md)
