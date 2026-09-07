# Phase 2 學習路線 — Android 串後端 + Jetpack 架構

> 接續：`README.md`（三日基礎）之後的下一階段學習規劃。
> 對象：已完成 Day 1–3（會 XML 佈局、Activity、Intent、RecyclerView、Room），
> 具 Swing/JFrame 背景、用 **Java**（非 Kotlin/Compose）開發的學習者。
> 總時程建議：**約 4–6 週，每週 6–8 小時**。

---

## 為何這樣安排

你最初的目標就是「**Android 連 Spring Boot REST API**」。三日基礎已讓你能寫「會存資料的多頁面 App」，
但這還停留在**單機端**。下階段要把資料端點搬到後端，並補上工程化觀念。

設計原則：**先把「前端↔後端」打通（看得見的成果），再回頭補架構**。不要急著跳 Kotlin / Compose。

---

## 主軸與優先順序

| 優先 | 主軸 | 核心內容 | 解決什麼 |
|---|---|---|---|
| **1** | Retrofit 網路請求 | REST API、JSON、Retrofit、Gson | 串 Spring Boot 後端 |
| **2** | 執行緒與主執行緒限制 | 背景執行緒、Callback、Handler | 網路/耗時操作不卡 UI |
| **3** | Jetpack 架構（MVVM） | ViewModel、LiveData、Repository | UI 自動更新、畫面重建不遺失資料 |
| **4** | RecyclerView 進階 + 圖片 | Glide、DiffUtil、Gson 技巧 | 真實列表 + 圖片載入 |

---

## 詳細學習內容

### 主軸 1：Retrofit 網路請求（最高優先，第 1–2 週）

**背景知識**
- HTTP 四大動作：GET / POST / PUT / DELETE
- JSON 格式與序列化（`Gson` / `GsonConverterFactory`）
- REST API 設計概念（資源、端點、狀態碼）

**Retrofit 三件套**
- 宣告 API 介面：`@GET("api/bmi")`、`@POST("api/calc")`、`@Query`、`@Body`
- `Retrofit.Builder().baseUrl("http://10.0.2.2:8080/").addConverterFactory(GsonConverterFactory.create()).build()`
- `Call<T>` / `Callback<T>`（類似你熟悉的 Listener）

**實作目標**
- 把 Day 1 的 BMI 計算邏輯搬到 Spring Boot 端
- 用 `10.0.2.2` 存取模擬器上的本機後端
- Android 傳數字 → 拿到結果 → 顯示

> 附：Spring Boot 端可先做一支極簡 `@RestController` 提供 BMI 計算。

### 主軸 2：執行緒與主執行緒限制（第 2–3 週）

- Android 的 **主執行緒 (UI thread)** 概念，對照 Swing 的 EDT
- **不能在主執行緒做網路/耗時操作**（會 `NetworkOnMainThreadException`）
- Retrofit 的 `enqueue` 自動在背景執行、回主執行緒回呼（最簡單）
- 了解 Java 的 `Executor` / `Handler`（若不用 Retrofit）
- `AsyncTask`：**僅了解即可，已被官方淘汰，勿在新專案用**

### 主軸 3：Jetpack 架構 MVVM（第 4 週）

- **ViewModel**：畫面旋轉/重建時保留資料（對照 JFrame 沒有、Android 生命週期需要）
- **LiveData**：資料改變自動通知 UI（解決 Day 3「手動 notifyDataSetChanged / loadMemos()」痛點）
- **Repository 模式**：把「網路 + Room」資料來源統一集中管理
- **MVVM**：Model / View / ViewModel 分層

### 主軸 4：RecyclerView 進階 + 圖片（穿插）

- **Glide** 載入網路圖片（後端頭像、商品圖）
- **DiffUtil** 高效更新列表
- **ItemTouchHelper** 滑動刪除（Day 2 提過）
- **Gson** 序列化技巧（List / 巢狀物件）

---

## 學習路線圖（含時間）

```
Phase 2（4–6 週）

第 1–2 週  Retrofit + 網路基礎 + Spring Boot 端
   └─ 目標：一支 App 呼叫 Spring Boot BMI API 並顯示結果

第 3 週     多頁面專案整合（登入 → 資料列表 → 明細）
   └─ 目標：有登入、抓後端列表、用 Glide 顯示圖片的完整 App

第 4 週     ViewModel + LiveData + Repository
   └─ 目標：把同一支專案改造成 MVVM，UI 自動更新

第 5–6 週   總成果專案（記帳/備忘錄升級版：串後端 + 雲端資料庫）
```

---

## 里程碑驗證

| 里程碑 | 通過標準 |
|---|---|
| M1（第 2 週末） | 能在模擬器用 `10.0.2.2` 連到 Spring Boot，BMI 算得出並顯示 |
| M2（第 3 週末） | 能登入、看到後端回傳的列表、圖片載得出來 |
| M3（第 4 週末） | UI 不再手動刷新（ViewModel + LiveData 自動更新），旋轉不遺失資料 |
| M4（第 6 週末） | 一支整合所有技能的完整 App，可部署到實機 |

---

## 之後的階段（可選）

| 方向 | 適合誰 |
|---|---|
| **Java → Kotlin** | 想進業界主流（官方已以 Kotlin 為主） |
| **Jetpack Compose** | 想學新式宣告式 UI |
| **Dagger/Hilt、單元測試** | 想進大型工程 |
| **Backend 深化（Spring Boot）** | 把重心放後端 |

> **階段性建議**：先別跳 Kotlin/Compose。用 Java 把本 Phase 的核心概念走完，再考慮 Kotlin（熟 Java 者上手很快）。

---

## 對應文件

- 本 Phase 含 **`07_AI_Prompt_Guide_Retrofit.md`**：Retrofit 的教學 + AI 提示指南（含 BMI 串後端範例）。
- 與三日基礎的 `04–06` 指南同一套「你給需求 → AI 產程式 → 貼 → 驗證」心法。
