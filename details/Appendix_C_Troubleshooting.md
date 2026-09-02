# Appendix C：常見錯誤排解總表

> 所有範例文件的「常見錯誤」皆指向此表。

---

## 編譯期錯誤

| # | 錯誤訊息 | 原因 | 解法 |
|---|---|---|---|
| C1 | `cannot find symbol: R` / `R.id.xxx` 紅字 | import 錯誤、或 XML 有誤導致 R 不生成 | 1) 檢查 `import 你的套件.R` 不是 `android.R`  2) 修正所有 XML 錯誤  3) File → Invalidate Caches / Restart |
| C2 | `error: cannot find symbol: class ViewBinding` | 未啟用 ViewBinding | 我們用 `findViewById`，**不需** ViewBinding；移除錯誤 import |
| C3 | `error: package androidx.room does not exist` | 缺 Room 依賴 | `build.gradle` 加 `implementation 'androidx.room:room-runtime:2.6.1'` + `annotationProcessor 'androidx.room:room-compiler:2.6.1'` 並 Sync |
| C4 | `error: cannot find symbol: method registerForActivityResult` | AndroidX Activity 版本太舊 | 升級 `implementation 'androidx.activity:activity:1.8.0'` |
| C5 | `error: This class should provide a default constructor` (Room Entity) | Entity 缺無參建構子 | 加上 `public Memo() {}` |
| C6 | `error: There is a problem with the query: [SQLITE_ERROR] no such column` | SQL 欄位名拼錯、或 schema 不符 | 確認 `@Entity` 欄位名、或刪除 App 重裝（資料庫重建） |
| C7 | `error: lambda expressions are not supported at this language level` | Java 版本未設為 1.8 | `build.gradle` 確認 `compileOptions { sourceCompatibility JavaVersion.VERSION_1_8 }` |

---

## 執行期 Crash

| # | 錯誤訊息 | 原因 | 解法 |
|---|---|---|---|
| R1 | `NullPointerException: findViewById returns null` | `setContentView` 後才能找 View、或 id 拼錯 | 確認 `setContentView(R.layout.xxx)` 在前、`R.id.xxx` 與 XML 完全一致 |
| R2 | `IllegalStateException: Could not execute method for android:onClick` | XML 用 `android:onClick` 但方法簽名錯 | 改用 `setOnClickListener`（本教學皆用此法），或檢查方法 `public void xxx(View v)` |
| R3 | `android.database.sqlite.SQLiteException: no such table` | 資料庫未建表、或版本號未升 | 1) 確認 `onCreate` 有 `execSQL CREATE TABLE`  2) 升級 `DB_VERSION` 並重裝 App |
| R4 | `android.os.NetworkOnMainThreadException` | 主執行緒做網路/資料庫耗時操作 | Room 建議用 `LiveData` + 背景執行緒；教學為簡化用同步，小資料量可接受 |
| R5 | `ActivityNotFoundException` / `Unable to find explicit activity class` | Activity 未在 Manifest 註冊 | 新增 Activity 時勾選「自動註冊」，或手動加 `<activity android:name=".XxxActivity" />` |
| R6 | `CursorIndexOutOfBoundsException` | `moveToNext()` 前未檢查、或欄位索引錯 | 先 `if (cursor.moveToNext())`、欄位索引從 0 開始對照 SQL `SELECT` 順序 |
| R7 | `Resources$NotFoundException: String resource ID #0x...` | `setText(int)` 被當成 resource id | 用 `setText(String.valueOf(int))` 或 `setText("" + number)` |

---

## 介面/行為異常

| # | 現象 | 原因 | 解法 |
|---|---|---|---|
| U1 | 輸入框彈不出鍵盤 | `android:focusable="false"` 或佈局問題 | 確認 EditText 無 `focusable="false"`、父容器無攔截觸控 |
| U2 | ListView/RecyclerView 不顯示資料 | Adapter 未 `notifyDataSetChanged`、或資料為空 | 呼叫 `adapter.notifyDataSetChanged()`、確認 `setAdapter` 後才塞資料 |
| U3 | Toast 不出現 | `show()` 忘記、或在背景執行緒呼叫 | 必須在主執行緒呼叫 `.show()`；背景執行緒用 `runOnUiThread` |
| U4 | AlertDialog 按鈕無反應 | `setPositiveButton` 給 `null` listener | 給正確的 listener：`(d, w) -> { ... }` |
| U5 | 模擬器啟動極慢 / 卡死 | 電腦記憶體不足、未啟用虛擬化 | 1) BIOS 開啟 VT-x/AMD-V  2) 給模擬器 2GB+ RAM  3) 用實機測試 |
| U6 | 重開 App 資料消失 | 用記憶體 ArrayList、未持久化 | 改用 Room / SharedPreferences / 檔案（Day 3） |

---

## 快速除錯技巧

```java
// 1. Logcat 印關鍵值
Log.d("DEBUG", "name=" + name + ", id=" + id);

// 2. 斷點：在程式碼左側行號點一下 → Debug 模式 Run (蟲子圖示)
//    停下來時可檢視變數、Step Over (F8)、Step Into (F7)

// 3. Layout Inspector（工具列 → Layout Inspector）
//    即時看 View 階層、屬性、邊界

// 4. App Inspection → Databases
//    即時瀏覽 Room/SQLite 資料表內容

// 5. Gradle 命令行清理重建
//    .\gradlew.bat clean assembleDebug
```

---

## 專案級檢查清單（每支範例跑前必核）

- [ ] `build.gradle` 依賴完整（Room、RecyclerView 等）
- [ ] `AndroidManifest.xml` 所有 Activity 已註冊
- [ ] `strings.xml` 有 `app_name`
- [ ] XML `android:id` 唯一、無重複
- [ ] Java `package` 宣告與資料夾一致
- [ ] `minSdk` ≥ 24、`targetSdk` ≥ 34