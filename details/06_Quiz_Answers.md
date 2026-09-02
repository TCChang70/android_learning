# 三天自我測驗與解答

> 先自己作答，再看解答。有些題目沒有唯一答案，參考解答即可。

---

## Day 1 測驗

**1. `android:layout_width="match_parent"` 和 `"wrap_content"` 分別是什麼意思？**

- `match_parent`：寬/高等於父容器的寬/高（填滿）。
- `wrap_content`：寬/高等於內容所需的大小（包住內容）。
- 對照 Swing：`match_parent` ≈ Fill，`wrap_content` ≈ Preferred Size。

**2. `findViewById(R.id.btnShow)` 的 `R.id.btnShow` 指的是什麼？**

`R` 是 Android 編譯時自動產生的資源類別。`R.id.btnShow` 是佈局中 `android:id="@+id/btnShow"` 這個元件對應的唯一整數 ID。`findViewById` 透過這個 ID 在已載入的佈局中尋找該 View 並回傳參考。

**3. Android 為什麼要建議文字用 `sp` 而不是 `px`？**

- `sp` (Scaled Pixel) 會依系統字型設定縮放，尊重使用者的無障礙字型偏好。
- `px` 是固定像素，在不同密度 (density) 螢幕上大小不一致，且不會跟隨系統字型。
- 排版距離用 `dp`，文字大小用 `sp`。

**4. `onCreate` 方法在何時被呼叫？裡面一定要做什麼事？**

- Activity 首次被建立時第一個被呼叫的生命週期方法。
- 一定要呼叫 `super.onCreate(savedInstanceState)` 且至少呼叫一次 `setContentView(R.layout.xxx)` 設定畫面。

**5. Toast 和 JOptionPane 的主要差異是什麼？**

- Toast 是非同步、不阻塞的短暫提示，自動消失，無法取得使用者回饋。
- JOptionPane 是同步對話框，會阻塞程式直到使用者回應，且可取得回傳值。
- Android 要用 `AlertDialog` 才類似 JOptionPane 的彈窗。

**6. 什麼情況下可以用 lambda？使用 lambda 有哪些限制？**

- 只有「單一抽象方法」的介面（functional interface）才能用 lambda。例如 `View.OnClickListener`、`DialogInterface.OnClickListener` 都只有一個方法，所以可以寫成 `v -> {...}`。
- 多個抽象方法的介面不行（例如 `MemoAdapter.OnMemoClickListener` 有兩個方法，只能寫 anonymous class）。
- 方法覆寫（override 已存在的方法，例如 `onActivityResult`）也不能用 lambda。
- 需 Java 8+（Android Studio 預設支援）。

---

## Day 2 測驗

**1. `startActivity(intent)` 和 `startActivityForResult(intent, code)` 差別在哪？**

- `startActivity`：啟動新畫面，不去等待結果（fire-and-forget）。
- `startActivityForResult`：啟動新畫面並等待該畫面透過 `setResult` 回傳資料，結果在 `onActivityResult` 接收。更新的 API 是 `Activity Result API` (registerForActivityResult)。

**2. `getIntExtra("age", 0)` 的第二個參數 `0` 是什麼意思？**

- 預設值 (default value)。若 Intent 中找不到 `"age"` 這個 key（例如沒傳、型別不符），就回傳 `0`，避免 null 崩潰。

**3. `onActivityResult` 的 `requestCode` 與 `resultCode` 分別代表什麼？**

- `requestCode`：發送端自己給的辨識碼（例如 `1001`），用來區分是哪一次跳轉的回應。
- `resultCode`：接收端用 `setResult(RESULT_OK, ...)` / `RESULT_CANCELED` 回應的結果狀態。

**4. Adapter 在 ListView 中扮演什麼角色？**

- Adapter 是資料與 UI 之間的橋樑。它把資料項目（陣列/List/Cursor）轉成畫面列的 View（並可做重複使用的效能優化）。類似 Swing 的 ListModel + ListCellRenderer。

**5. 為什麼用 RecyclerView 取代 ListView？**

- RecyclerView 有 ViewHolder 回收機制與 LayoutManager，捲動效能更好（只建立可見項目的 View）。
- 內建動畫、多種佈局（Linear/Grid/Staggered）。
- 官方建議使用，ListView 偏舊、code 較少但有效能瓶頸。

**6. `onActivityResult(...)` 為什麼「不能」寫成 lambda？那 `setOnClickListener(v -> ...)` 為什麼可以？**

- `onActivityResult(...)` 是 Activity 類別裡**已經定義好**的方法，你用 `@Override` 去「覆寫」它。Lambda 只能用來實現「尚未被實現的單一抽象方法介面」，不能用來覆寫既有方法，所以只能寫方法簽名 + 大括號。
- `setOnClickListener` 收的是 `View.OnClickListener` 介面，它**只有一個抽象方法** `onClick(View)`，是 functional interface，所以可用 `v -> {...}` 直接當成該介面的實作。
- 判斷準則：**要覆寫既有方法 → 只能寫方法；要實作單一方法的介面 → 可用 lambda**。

---

## Day 3 測驗

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

## 進階挑戰（選做）

1. 用 Room 的 `LiveData<List<Memo>>` 取代 `List<Memo>`，讓資料異動自動更新 UI，不需要手動 `loadMemos()`。
2. 把 BMI 計算結果用 SharedPreferences 儲存最近三次。
3. 在 MemoApp 加入搜尋：在 DAO 加 `@Query("SELECT * FROM memo WHERE title LIKE '%' || :keyword || '%'")`。
4. 用 `ViewHolder` + ItemTouchHelper 實現滑動刪除。
5. 把 App 換成 Jetpack Compose 的宣告式 UI（新的學習方向）。

祝學習順利！完成三天，你已具備 Android 原生 App 開發的基本能力。