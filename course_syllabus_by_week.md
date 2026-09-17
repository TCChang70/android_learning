# 全端開發就業班｜課程學習大綱（對應週次）

> Spring Boot + Data JPA + MySQL + React + Python AI
> 20 週 / 480 小時 | 每週學習目標、內容、實作與驗收總表

---

## 一、課程總覽

| 項目 | 內容 |
|---|---|
| 課程名稱 | 全端開發就業實務（Web 全端 + AI 整合） |
| 總時數 | 20 週，480 小時（前 17 週每週約 24h；Python+AI 濃縮 30h） |
| 先備知識 | 零基礎（不需懂任何程式） |
| 技術棧 | Java 17 + Spring Boot 3 + Spring Data JPA + MySQL 8 + React 18 + Vite + Python 3 + LLM API |
| 完成能力 | 前端 React + 後端 REST API + 資料庫 + AI 服務的完整系統，並自動化部署上線 |
| 就業導向 | 可展示專案 + 面試題演練 + 履歷包裝 + AI 話題 |

### 學程目標

1. 從零建立程式邏輯與物件導向觀念（Java）
2. 學會資料建模與 SQL 關聯查詢（MySQL）
3. 開發工業級 REST API（Spring Boot + Data JPA）
4. 完成現代化前端並串接後端（React）
5. 用環境變數與 GitHub Actions/Render 自動化部署
6. 濃縮 30h 快速掌握 Python + AI（LLM API / RAG）
7. 完成「員工管理系統 + AI 助理」上線作品並包裝就業

---

## 二、階段規劃（總覽）

| 階段 | 週次 | 主題 | 時數 |
|---|---|---|---|
| 一 | 1-4 | Java 程式基礎與物件導向 | 96h |
| 二 | 5 | 資料庫設計與 SQL | 24h |
| 三 | 6-10 | Spring Boot 後端開發 | 120h |
| 四 | 11-13 | 前端基礎與 React | 72h |
| 五 | 14-15 | 期末專題：員工管理系統 | 48h |
| 六 | 16-17 | 自動化部署（環境變數 + Actions + Render） | 48h |
| 七 | 18 | Python + AI 整合（濃縮模組） | 30h |
| 八 | 19-20 | 最終部署＋就業準備 | 42h |

---

## 三、每週學習大綱

### 階段一｜Java 程式基礎（週 1-4）

#### 週 1｜程式基礎Ⅰ：變數、型別、流程控制（24h）

- **學習目標**：寫出第一支 Java 主控台程式，理解程式執行的順序邏輯
- **內容要點**
  - `public class / main` 程式結構
  - 八大型別與型別轉換、運算子
  - `if / else`、`switch`、`for / while`
- **實作範例**：猜數字、九九乘法表、停車費計算機
- **驗收小作品**：主控台「購物結帳系統」（輸入金額 → 計算折扣 → 輸出）

#### 週 2｜程式基礎Ⅱ：方法、陣列、字串（24h）

- **學習目標**：用方法拆解程式，操作陣列與字串處理資料
- **內容要點**
  - 方法的定義/呼叫/參數/回傳值/多載
  - 一維與二維陣列、常用字串方法
  - `Scanner`、隨機數、格式化輸出
- **實作範例**：學生成績統計（最高/最低/平均/名次）、字串反轉
- **驗收小作品**：「成績統計程式」主控台版

#### 週 3｜物件導向（OOP）（24h）

- **學習目標**：建立 OOP 觀念，為看懂 Spring 元件打下基礎
- **內容要點**
  - 類別與物件、封裝（`private` + getter/setter）
  - 繼承（`extends` / `@Override`）、介面（`interface`）
  - 例外處理（`try / catch`）
- **實作範例**：圖書管理主控台版（Book、EBook 繼承、借閱流程）
- **驗收小作品**：「圖書管理系統」（新增/查詢/借還書）

#### 週 4｜集合框架 + 檔案 IO（24h）

- **學習目標**：使用集合管理資料，並體驗「持久化」概念
- **內容要點**
  - `ArrayList`、`HashMap`、`Set`、泛型、`for-each`
  - 檔案讀寫（`FileReader / FileWriter`）
- **實作範例**：「會員清單管理」收集合 → 存文字檔 → 重開讀回
- **驗收小作品**：關掉程式重開，資料仍在的會員清單

---

### 階段二｜資料庫（週 5）

#### 週 5｜MySQL 與 SQL（24h）

- **學習目標**：學會建資料庫、查資料與關聯查詢——JPA 的地基
- **內容要點**
  - 安裝 MySQL、匯入 classicmodels 範本資料庫
  - DDL / DML：`CREATE TABLE`、CRUD、主鍵/外鍵
  - `WHERE / ORDER BY / GROUP BY / HAVING / JOIN`、三表 JOIN、自關聯
  - Transaction（`COMMIT / ROLLBACK` / ACID）、View、Stored Procedure
- **實作範例**：以真實資料回答查詢（各國客戶數、訂單分佈、未下單客戶）
- **驗收小作品**：classicmodels 完成 3+2 題查詢（GROUP BY / LEFT JOIN / 多表營收）

---

### 階段三｜Spring Boot 後端（週 6-10）

#### 週 6｜第一個 REST API（24h）

- **學習目標**：從主控台跨到 Web 程式，開發「看得見的系統」
- **內容要點**
  - Spring Initializr 建置專案（Spring Web）
  - 專案結構（`pom.xml`、`application.properties`）
  - `@RestController` + `@GetMapping` + `@RequestParam`
- **實作範例**：HelloController、CalculatorController
- **驗收小作品**：「Hello World」REST API（回傳 JSON）

#### 週 7｜Spring Boot 進階：Lombok、DI、三層架構（24h）

- **學習目標**：理解依賴注入與分層架構的工程意義
- **內容要點**
  - Lombok（`@Data`）、依賴注入（DI）
  - Controller → Service → Repository 三層架構
- **實作範例**：將計算機重整為三層架構 + Lombok
- **驗收**：能畫出請求流向圖並說明分層原因

#### 週 8｜Spring Data JPA + MySQL（24h）｜課程核心

- **學習目標**：用 JPA 操作資料庫，完成 CRUD API
- **內容要點**
  - `@Entity` / `@Table`、`application.properties` 連線設定
  - `JpaRepository`、方法命名查詢
- **實作範例**：Employee 實體 + Repository + Service + Controller
- **驗收小作品**：員工 CRUD API（POST/GET/PUT/DELETE 五支 API 全過）

#### 週 9｜REST API 完整化（24h）

- **學習目標**：讓 API 具備「可上線品質」
- **內容要點**
  - `@Valid` 欄位驗證、`@RestControllerAdvice` 統一例外處理
  - 自訂回應格式（`ApiResponse`）、`Pageable` 分頁
- **驗收**：API 文件（Swagger / Markdown）列出每支 API 的請求/回應/錯誤格式

#### 週 10｜關聯設計 + 進階查詢 + 安全基礎（24h）

- **學習目標**：學會多表關聯與最小可用安全機制
- **內容要點**
  - `@ManyToOne` / `@OneToMany`、`@Query`（JPQL / 原生 SQL）
  - BCrypt 密碼雜湊、JWT 登入概念
- **實作範例**：部門-員工關聯 API + JWT 登入示範
- **驗收小作品**：「部門管理 + 員工所屬部門查詢」API

---

### 階段四｜前端與 React（週 11-13）

#### 週 11｜前端基礎：HTML / CSS / JavaScript（24h）

- **學習目標**：掌握網頁三兄弟，所有前端框架的地基
- **內容要點**
  - HTML 語意化、CSS 盒模型與 Flexbox、JS 事件與 DOM
  - `fetch` 串接 API
- **實作範例**：員工資料表靜態頁 → JS `fetch` 顯示後端資料
- **驗收小作品**：純 JS 員工清單頁（成功呼叫週 9 API）

#### 週 12｜React 基礎（24h）

- **學習目標**：用 React 元件化思維建立前端
- **內容要點**
  - Vite 建置、JSX、元件
  - `useState`、Props、事件處理、列表渲染
- **實作範例**：待辦事項 App（新增/刪除/完成勾選）
- **驗收小作品**：可新增/刪除的待辦事項 App

#### 週 13｜React 串接後端（24h）｜重點週

- **學習目標**：完成「前端 ↔ 後端 ↔ 資料庫」完整來回
- **內容要點**
  - axios、`useEffect`、`react-router-dom` 路由
  - Context API、CORS 與 Vite Proxy 轉接
- **實作範例**：員工資料管理頁（增刪改查全接後端）
- **驗收**：新增一位員工 → 列表出現 → 刷新後仍存在

---

### 階段五｜期末專題（週 14-15）

#### 週 14｜員工/使用者管理系統：開發（24h）

- **學習目標**：個人/團隊完成一套可操作系統
- **功能規格**
  - JWT 登入與權限、員工 CRUD/分頁/搜尋、部門管理
  - React 前端串接、MySQL 正規化設計
- **品質要求**：欄位驗證、例外處理、API 文件、Git、README

#### 週 15｜專題補強 + 測試 + 文件（24h）

- **學習目標**：把專題補到「可交付、可展示」
- **內容要點**：功能補強、回歸測試、操作/文件整理、Demo 準備
- **驗收**：系統 + 操作文件完整

---

### 階段六｜自動化部署（週 16-17）

#### 週 16｜環境變數 + GitHub Actions CI（24h）

- **學習目標**：敏感設定抽離程式碼，push 後自動建置測試
- **內容要點**
  - 環境變數（`.env` / `application-local` / `${DB_PASSWORD}`、Git 忽略清單）
  - GitHub Actions（`.github/workflows/ci.yml`）：JDK 17 + `mvn test` + `npm build`
  - Repo Secrets 設定與使用
- **驗收**：程式碼零密碼，push 後 CI 綠燈

#### 週 17｜Render 自動化部署（24h）

- **學習目標**：作品上線為「可公開連線、push 即更新」的網站
- **內容要點**
  - Render Web Service（Spring Boot）+ Static Site（React）
  - Render Secrets 與本地環境變數對應、資料庫遷移
  - `publish on push` 自動部署、Logs / Health Check 除錯
- **驗收小作品**：員工管理系統公開網址 + push 自動重新部署

---

### 階段七｜Python + AI 整合（週 18）

#### 週 18｜Python + AI 整合（30h 濃縮模組）

- **學習目標**：以 Java 經驗 30h 內掌握 Python 並整合 LLM / RAG
- **內容與時數配比**

| 段 | 時數 | 內容 |
|---|---|---|
| Python 基礎（與 Java 對照） | 10h | 語法、流程、函式、檔案、venv/pip |
| Python 實務 | 8h | `requests` 串 API、`pandas` 資料處理 |
| LLM API 整合 | 6h | API Key、Prompt、`response_format=json` |
| RAG 知識庫問答 | 6h | 切塊 / embedding / 檢索、問答助理 |

- **濃縮原則**：只學「串接與整合」必要技能，以「看得見結果」的小作品驗收
- **驗收**：一支「問一句話 → 回傳 JSON（含引用來源）」的 RAG 知識庫問答助理

---

### 階段八｜最終部署與就業（週 19-20）

#### 週 19｜最終部署（三服務）+ AI 強化回歸（24h）

- **學習目標**：員工系統 + Python AI 服務三服務一起上線
- **內容要點**
  - Render 三服務：Spring Boot + React + Python AI（FastAPI）
  - GitHub Actions 完整流水線（test → build → deploy）
  - 環境變數分層（本地 / prod / Render Secrets，API Key 只進後端）
  - 回歸測試：加入 AI 後原有 CRUD / 登入不壞
- **驗收**：含 AI 助理的系統三服務上線，網址可公開連線

#### 週 20｜求職準備（18h）

- **學習目標**：把作品與技能包裝成「面試能講的故事」
- **內容要點**
  - 30+ 題 JAVA / Spring / React 面試題＋Python / AI（RAG）話題
  - 自我介紹、履歷專案描述（STAR）
  - 模擬面試：講解「React → Spring Boot → Python AI → LLM」流程
- **驗收**：AI 強化版系統線上展示 + 一頁面試 story + 30 題演練

---

## 四、每週驗收總表

| 週次 | 驗收小作品 | 驗收方式 |
|---|---|---|
| 1 | 購物結帳系統 | 主控台正確輸出 |
| 2 | 成績統計程式 | 輸入→正確統計 |
| 3 | 圖書管理系統 | 類別/繼承/多型範例 |
| 4 | 會員清單存檔 | 重開程式資料仍在 |
| 5 | classicmodels 查詢練習 | Join 查詢正確 |
| 6 | Hello / Calculator API | Postman 回傳 JSON |
| 7 | 三層架構計算機 | 檢視程式分層 |
| 8 | 員工 CRUD API | Postman 五支 API 全過 |
| 9 | API 文件 + 例外處理 | 錯誤資訊可讀 |
| 10 | 部門-員工關聯 API | Join 關聯正常 |
| 11 | 純 JS 員工清單頁 | 頁面顯示 API 資料 |
| 12 | 待辦事項 App | 新增/刪除/勾選 |
| 13 | 員工資料管理頁 | 前端串後端 CRUD 完成 |
| 14 | 期末專題（後端+前端） | 完整系統驗收 |
| 15 | 專題補強 + 測試 + 文件 | 文件齊備、功能完整 |
| 16 | 環境變數化 + CI 流水線 | 程式零密碼 + CI 綠燈 |
| 17 | Render 上線網址 | 可公開連線 + push 自動更新 |
| 18 | RAG 知識庫問答助理（30h 濃縮模組） | 問一句話 → JSON + 引用來源 |
| 19 | 三服務部署 + 回歸測試 | 可公開連線網址 + 回歸通過 |
| 20 | 求職準備 | 履歷 + 面試 story + 30 題演練 |

> 以「作品」驗收，不以「考卷」驗收——這是最貼近就業的能力證明。