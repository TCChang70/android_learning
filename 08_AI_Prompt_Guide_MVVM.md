# 08 搭配 AI 的提示指南 — MVVM：ViewModel / LiveData / Repository

> 使用前提：你已完成 Day 1–3（`01–03`）與 Retrofit（`07`）。
> 目標：教你「讓 AI 產生」一支用 **MVVM 架構**把 **Retrofit（網路）+ Room（本地庫）** 整合起來的 App。
> 核心概念：把三本書的繁瑣手動刷新去掉，改由「資料變化自動通知 UI」。
> 心法同前：**你決定需求，AI 寫程式，但你要看懂、能改、能驗證**。

---

## 目錄

- [0. 為什麼要 MVVM（解決什麼痛點）](#0-為什麼要-mvvm)
- [1. MVVM 三層與台灣名詞對照](#1-mvvm-三層對照)
- [2. Room 改回傳 LiveData（Day 3 升級）](#2-room-改用-livedata)
- [3. ViewModel](#3-viewmodel)
- [4. Repository（把網路 + 本地統一起來）](#4-repository)
- [5. 整合範例：記帳 App 升級 MVVM](#5-整合範例記帳-app-升級-mvvm)
- [6. 需要的依賴與前置](#6-依賴與前置)
- [7. 練習擴充提示](#7-練習擴充提示)
- [8. 讓 AI 幫你除錯](#8-讓-ai-幫你除錯)
- [9. 提示寫作重點回顧（MVVM）](#9-提示寫作重點回顧)

---

## 0. 為什麼要 MVVM

回想 Day 3 的痛點：每刪一筆、新增一筆，都要自己呼叫 `loadMemos()` / `notifyDataSetChanged()`，
然後畫面重建（旋轉手機）時資料就沒了。接著 Retrofit 又要處理背景執行緒。

MVVM 用一套**分工**解決這些：

| 痛點 | MVVM 解法 |
|---|---|
| 手動刷新 UI | **LiveData** 自動通知（資料一變，UI 自己更新） |
| 旋轉/重建丟資料 | **ViewModel** 保存資料（跨重建存活） |
| UI 太多程式邏輯 | 邏輯搬到 **ViewModel / Repository** |
| 網路 + 本地的程式碼混在一起 | **Repository** 統一管理資料來源 |

> 一句話：**ViewModel 幫 Activity 存資料並暴露 LiveData，Repository 負責「資料從哪來」**，
> Activity/Fragment 只負責「把 LiveData 顯示到畫面上」。

---

## 1. MVVM 三層對照

| 層 | 角色 | 你的類別例子 |
|---|---|---|
| **Model** | 資料與資料來源（網路/資料庫） | `BmiApi`、`Room`、`Expense`、Repository 內部 |
| **View** | UI（Activity / XML） | `MainActivity`、`activity_main.xml` |
| **ViewModel** | 橋樑：持有資料（暴露 LiveData），不碰 UI | `ExpenseViewModel` |

```
View (Activity)
   │  觀察 LiveData → 自動更新
   ▼
ViewModel   (暴露 LiveData<...>)
   │  呼叫
   ▼
Repository  (統整: 網路 Retrofit + 本地 Room)
   │
   ├── Room DAO (LocalDataSource)
   └── Retrofit API (RemoteDataSource)
```

> 關鍵：**View 不直接碰 Room/Retrofit，全透過 ViewModel + Repository**。

---

## 2. Room 改用 LiveData

**提示（升級）**
```
請教我 Day 3 的 Room DAO 改用 LiveData 的好處與改法：
1. 原本 dao.getAll() 回傳 List<Expense>，每次要自己 loadData() 再 notifyDataSetChanged
2. 改成回傳 LiveData<List<Expense>>，Activity 用 observe() 監聽，資料一變就自動刷新
3. 給我 ExpenseDao 修改前後的對照，並解釋「為何 LiveData 讓 UI 自動更新、不用手動刷新」
請用 Java。
```

> 這是 MVVM 最核心的一步：Room 天生支援 LiveData，`LiveData<List<T>>` 一有變動就自動 notify。

---

## 3. ViewModel

**提示**
```
請用 JFrame 沒有、Android 特有的「生命週期」概念，教我 ViewModel：
1. 為何畫面旋轉時 Activity 被銷毀重建，ViewModel 卻活著
2. 為何 ViewModel 不能持有 View/Context 的參考（避免洩漏）
3. 用近期學的記帳 App 給我 ExpenseViewModel：
   - 繼承 androidx.lifecycle.ViewModel
   - 持有 Repository 與 MutableLiveData / LiveData
   - 提供 addExpense()、deleteExpense()、getAllExpenses() 等方法
   - 用 new ViewModelProvider(this).get(ExpenseViewModel.class) 取得（不能用 new）
請用 Java，含完整程式碼。
```

> 例：
> ```java
> ExpenseViewModel vm = new ViewModelProvider(this).get(ExpenseViewModel.class);
> vm.getAllExpenses().observe(this, list -> adapter.setExpenses(list));
> ```

---

## 4. Repository

**提示**
```
請為「記帳 App」建一個 Repository 統一管理資料來源，套件 com.example.expenseapp.mvvm：
1. ExpenseRepository.java：
   - 持有 ExpenseDao（本地）與 BmiApi 等（若串網路）
   - loadExpenses() 回傳 dao.getAll()（跳到 LiveData 版）
   - insert(Expense)、delete(Expense) 包 dao
   - 若之後加「從後端同步」，也在這裡提供（範例：fetchFromServer() 用 Retrofit，成功後再寫入資料庫）
2. 解釋為何「UI 和 ViewModel 都不該直接碰 dao/api」，統一從 Repository 進出
請用 Java，含完整程式碼。
```

> Repository 是「資料的唯一出入口」。View/ViewModel 要資料就問它，不必管來自網路或本地。

---

## 5. 整合範例：記帳 App 升級 MVVM

**需求提示**（`com.example.expenseapp.mvvm`）
```
我學到 MVVM，要把 Day 3 的記帳 App 重構成 MVVM，套件 com.example.expenseapp.mvvm。
給我一層一層的完整結構，並標明每層放哪個檔案：

依賴：appcompat、material、recyclerview、room-runtime + annotationProcessor room-compiler、lifecycle-viewmodel + lifecycle-livedata、retrofit + converter-gson（若串後端）

資料層 (Model)：
1. Expense.java（@Entity）
2. ExpenseDao.java（@Query 改回傳 LiveData<List<Expense>>）+ @Insert/@Delete + getTotal()
3. AppDatabase.java（單例，Room）
4. ExpenseRepository.java（暴露 LiveData、包 insert/delete、可加網路）

ViewModel：
5. ExpenseViewModel.java（ViewModelProvider 取得；addExpense/deleteExpense/getAllExpenses/總額）

View：
6. activity_main.xml、row_expense.xml（沿用 Day 3 佈局）
7. MainActivity.java：
   - 不用再持有 dao，改成 ViewModel
   - vm.getAllExpenses().observe(this, ...) + vm.getTotal().observe(...) 自動更新 adapter 與 tvTotal
   - 事件（新增/刪除）呼叫 vm 的方法
請用 Java，強調「Activity 不再碰 Room、List 用 LiveData observe 自動刷新」。
```

**驗證**：新增/刪除後**不需要**自己刷新畫面，UI 自動更新；旋轉手機資料不遺失。

> 加網路同步版本：`fetchFromServer()` 在 Repository 用 Retrofit 抓後端，成功後 `insertAll` 進 Room，LiveData 自動把整合結果推給 UI —— 這就是「本地優先、同步後端」的典型架構。

---

## 6. 依賴與前置

**提示**
```
請給我 Gradle (Groovy) 裡 MVVM 所需的依賴與版本（假設用較新 AndroidX）：
- androidx.lifecycle:lifecycle-viewmodel
- androidx.lifecycle:lifecycle-livedata
- 提醒：Room 用 annotationProcessor，不是 kapt（Java 專案）
並說明 ViewModelProvider 需要這些 lifecycle 依賴才能用。
```

---

## 7. 練習擴充提示

**擴充 1：網路 + 本地同步**
```
請教我 Repository 的「本地優先」策略：先顯示 Room 資料，再用 Retrofit 抓後端更新，
資料回來後寫進 Room，LiveData 自動通知 UI。給我對應的 Repository 方法 fetchFromServer() 範例。
```

**擴充 2：事件處理單一化**
```
請在我的記帳 App ViewModel 加一支 MutableLiveData<String> message，
新增/刪除失敗時用 setValue() 通知，Activity 用 observe() 顯示 Toast。
```

**擴充 3：URL 轉 (data class 對照)**
```
若之後想換 Kotlin，請對照我目前的 Java MVVM，用 Kotlin 的 data class / ViewModel 重寫 Expense，
讓我看懂 Java 與 Kotlin 的差異。
```

---

## 8. 讓 AI 幫你除錯

| 常見問題 | 你可以這樣問 |
|---|---|
| `observe` 沒觸發 / UI 沒自動更新 | 「我 observe 了 but UI 不動，是不是 DAO 沒回傳 LiveData？還是 LiveData 一次性？幫我校對」 |
| 找不到 ViewModel 依賴 | 「我用 ViewModelProvider 但 import 不過，是不是沒加 lifecycle 依賴？」 |
| `MutableLiveData` vs `LiveData` | 「ViewModel 內部該用哪個、外部暴露哪個？為何外部要只讀？」 |
| Activity 旋轉仍重建 | 「我以為 ViewModel 保存資料，為何旋轉還是重抓？我是不是在 onCreate 又把 LiveData reload 了？」 |
| Repository 網路更新沒反映到 UI | 「Repository 抓回後端後，為什麼 list 沒變？是不是該先寫進 Room 而不只是更新 LiveData？」 |

> 貼上**完整錯誤訊息（含 Logcat）**與你的程式碼，AI 才精準。

---

## 9. 提示寫作重點回顧（MVVM）

| 重點 | 做法 |
|---|---|
| **層層分明** | 明確要求「每層一個 class、Activity 不碰 dao/api」 |
| **LiveData 方向** | 內部用 `MutableLiveData`、外部暴露 `LiveData`（只讀） |
| **一次給整套** | Entity + DAO + Database + Repository + ViewModel + Activity 一次要齊 |
| **提醒依賴** | lifecycle-viewmodel / livedata、Room 用 annotationProcessor |
| **求「為什麼」** | 多問「為何 destroy 後 ViewModel 仍活著」「為何 observe 自動刷新」以內化觀念 |

---

## 建議複習流程

1. **先各自學** 2 / 3 / 4 三節（Room LiveData → ViewModel → Repository）
2. **再把記帳 App 重構成 MVVM**（比對改前改後差異）
3. 照貼後跑通，**確認刪新增不用手動刷新、旋轉不丟資料**
4. 做擴充 1 的「本地優先同步」，把 Retrofit（`07`）跟 Room 用 Repository 真正整合
5. 對照 README 的總成果，你就具備進入進階架構（Hilt、Kotlin）的完整基礎

> 至此 `04–08` 五份 AI 指南已串起：Day1 基礎 → Day2 多頁面 → Day3 持久化 → Retrofit 網路 → MVVM 架構。你已能靠「需求 → AI → 貼 → 驗證」獨立打造一支真正可用的 App。
