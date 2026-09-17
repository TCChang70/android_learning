# 10 AI 提示指南 — Python + AI 整合（RAG 知識庫問答助理）

> 使用前提：你已完成週 1–17（Java / Spring Boot / React），有良好的程式邏輯與「串接」概念。
> 目標：教你「用 AI 輔助學習 Python，並從零做出最終驗收作品——RAG 知識庫問答助理」。
> 心法同前：**你決定需求，AI 寫程式，但你要看懂、能改、能驗證**。
> 本指南以「你懂 Java」為基礎，直接幫你對照、加速、避坑。

---

## 目錄

- [0. 重點：Java 開發者學 Python 的三大心態](#0-重點)
- [1. 讓 AI 幫你「Java → Python」翻譯對照](#1-java--python-翻譯對照)
- [2. 讓 AI 幫你抓 Python 陷阱](#2-讓-ai-幫你抓-python-陷阱)
- [3. 讓 AI 產生「requests 串 API」範例](#3-requests-串-api-範例)
- [4. 讓 AI 產生「pandas 資料分析」範例](#4-pandas-資料分析範例)
- [5. 讓 AI 產生「OpenAI LLM 呼叫」範例](#5-openai-llm-呼叫範例)
- [6. 讓 AI 產生「RAG 完整系統」](#6-rag-完整系統)
- [7. RAG 驗收檢查清單 + 測試提示](#7-驗收檢查清單)
- [8. 錯誤排除提示模板](#8-錯誤排除)
- [9. 提示寫作重點回顧（Python + AI）](#9-提示寫作重點回顧)

---

## 0. 重點

| 概念 | 對照你已懂的（Java） |
|---|---|
| venv + pip | Maven + pom.xml（依賴隔離與管理） |
| 動態型別 | 不需宣告型別，用 type hint 輔助 |
| 函式 def | 方法（但不必宣告回傳型別） |
| list / dict / set | ArrayList / HashMap / HashSet |
| 縮排定義區塊 | `{}` 定義區塊 |
| requests | OkHttp / RestTemplate |
| pandas | Java 的 Stream / 自寫 SQL 分析 |
| openai SDK | 呼叫外部 REST API 的 Client |
| RAG | 「全文檢索 + LLM 回答」的組合系統 |

> **最省時的策略**：不要「從頭學」Python 語法，而是「直接做 AI 串接」，遇到的語法再抓著 AI 問「對照 Java 這是什麼」。

---

## 1. Java → Python 翻譯對照

**提示**
```
我是 Java 開發者（懂 OOP、Spring Boot）。請把下面這段 Java 程式翻譯成等價的 Python，
並指出每個對照點該怎麼對應：

[貼上你的 Java 程式碼]

請用表格對照：Java 語法 | Python 語法 | 注意事項。
特別提醒我：Python 的縮排、f-string、無大括號、字串比較用 ==、除法的不同。
```

**範例**
```
我有這個 Employee class：
public class Employee {
    private String name;
    private int salary;
    public Employee(String name, int salary) { this.name = name; this.salary = salary; }
    public String getName() { return name; }
    public void raise(int pct) { salary += salary * pct / 100; }
}
請翻譯成 Python，並用表格對照 __init__ / self / @property / f-string 的對應。
```

---

## 2. 讓 AI 幫你抓 Python 陷阱

**提示**
```
我是 Java 開發者，第一次寫 Python。請列出「最常踩的 10 個 Python 陷阱」，
每個陷阱要：1) Java 的習慣寫法 2) Python 會怎麼錯 3) 正確寫法 4) 一行代替說明。
重點包含：整數除法、None 判斷、True/False、i++、字串可變性、shallow copy、
dictionary 在 for 中改動、default mutable argument、== vs is、except 裸吞例外。
```

---

## 3. requests 串 API 範例

**提示**
```
我懂 Spring Boot 的 RestTemplate / OkHttp。請用 Python requests 寫一個範例：

1. GET：https://jsonplaceholder.typicode.com/posts?userId=1
2. POST：新增一篇 post（json 參數）
3. 錯誤處理：用 try/except 包住，Timeout / ConnectionError / HTTPError 分開處理
4. 每個動作用表格對照「Java(RestTemplate) vs Python(requests)」

我已經有 python-dotenv，請順便示範如何從 .env 讀 API Key 加進 header。
```

---

## 4. pandas 資料分析範例

**提示**
```
我懂 SQL（會 GROUP BY / WHERE / ORDER BY）與 Java Stream。
請用 pandas 實作「員工資料分析」：
- 資料欄位：name, department, salary, years
- 需求：
  1. 篩選 salary > 60000 且 department == "IT"（對照 SQL WHERE + AND）
  2. 按 department 分組算出每部門人數、平均薪資、最高薪資（對照 GROUP BY + 聚合）
  3. 依平均薪資排序（對照 ORDER BY）
  4. 新增一欄 level = "Senior"/"Junior"（years >= 5）
- 每個操作標註「對照的 SQL 片段」。
請直接給我可執行的完整程式碼。
```

---

## 5. OpenAI LLM 呼叫範例

**提示**
```
我有 Python + .env 讀取的環境，已 pip install openai python-dotenv。
請幫我寫一支 OpenAI 呼叫範例：

1. 從 .env 讀 OPENAI_API_KEY
2. 建立 OpenAI client
3. 呼叫 chat.completions.create，用 gpt-4o-mini
4. system prompt：你是一個 Python 教學助理，回答要用繁體中文，並和 Java 對照
5. user prompt：使用者輸入的問題（從 input() 讀）
6. 設定 response_format={"type": "json_object"}，要求回傳 JSON：
   {"answer": "...", "tag": ["python", "spring"], "difficulty": 1-5}
7. 解析 JSON 並用 print 顯示
8. 印出 token 用量（usage）

請附完整可執行的程式碼。
```

**前端串接版本（進階）**
```
我已有 FastAPI 基礎。請把上面那支 OpenAI 範例改成一個 REST API：
POST /api/ask → body: {"question": "..."}
→ 回傳 {"answer": "...", "tag": [...], "difficulty": N}
用 pydantic BaseModel + FastAPI，並給出測試網址與 uvicorn 啟動指令。
```

---

## 6. RAG 完整系統

**提示（核心驗收）**
```
我懂 Java/Spring/React，已會用 requests、pandas、OpenAI API。
請用 Python 寫一支完整的「RAG 知識庫問答助理」命令列程式。

架構要求：
1. 讀取知識庫：從 ./kb/ 目錄讀取所有 .txt/.md 檔案
2. 切塊：每 500 字元切割、重疊 50、從句號或換行優先斷開
3. Embedding：用 OpenAI text-embedding-3-small
4. 儲存：建立 embedding_db.json（含來源檔名、段落文字、向量）
5. 檢索：用餘弦相似度找最相關的 top 3 段落
6. 生成：用 gpt-4o-mini 回答，附引用來源
7. 回應必須是 JSON：
   {
     "query": "問題",
     "answer": "回答（含來源標記）",
     "sources": ["來源1", "來源2"],
     "confidence": 0.0-1.0,
     "timestamp": "ISO 時間"
   }
8. 互動模式：input() 迴圈，輸入 q 離開，rebuild 重建向量資料庫
9. 程式分割成可讀的函式：get_embedding / cosine_similarity /
   chunk_text / build_kb / search / generate_answer / rag_query

請附完整程式碼，並寫明：如何準備知識庫、執行步驟、驗收測試方法。
```

**FastAPI 版本（銜接週 19 部署）**
```
請把上面 RAG 助理包成一支 FastAPI：
- POST /ask → body {"question": "..."} → 回傳上面 JSON
- GET /health → {"status": "ok", "kb_size": N}
啟動時載入知識庫一次，避免每次請求重算。
給出 uvicorn 指令與直接呼叫測試範例。
```

---

## 7. 驗收檢查清單

| 驗收點 | 測試方法 |
|---|---|
| 知識庫有資料 | `./kb/` 放了文件，rebuild 成功，印出段落數 |
| 檢索合理 | 問「怎麼安裝 Python」應比「火星天氣」相似度高 |
| 回答引用來源 | answer 含 `[來源: xxx]`，sources 陣列非空 |
| JSON 格式正確 | `json.loads` 不報錯，欄位齊全 |
| 資料不足會說不知道 | 問知識庫外問題，LLM 不硬掰 |
| 可重跑 | 重開程式，load 既有 embedding_db.json 而非重新計算 |
| 中文正常 | ensure_ascii=False，無亂碼 |

**測試提示（出題用）**
```
我完成了一支出問題→回傳 JSON 的 RAG 助理。請給我 5 個「測試問題」：
1. 2 個知識庫內一定可答的問題（依我的知識庫主題）
2. 1 個知識庫外、應回「無法回答」的問題
3. 1 個需要跨段落整合的問題（測 chunking 品質）
4. 1 個模糊問題（測檢索 robustness）
並告訴我每個問題「預期應該怎麼回」才是通過。
```

---

## 8. 錯誤排除

**提示模板（遇到任何錯誤貼這個）**
```
我是 Python 初學者（懂 Java）。執行下面程式時噴了這個錯誤：

[完整錯誤訊息 stack trace]
[相關程式碼片段]

請：
1. 用一句話解釋錯誤原因（用 Java 對照幫我理解）
2. 給修正後的完整片段
3. 提醒我未來如何避免同類錯誤
```

**常見錯誤對照速查**

| 錯誤訊息 | Java 對照 | 原因與解法 |
|---|---|---|
| `NameError: name 'x' is not defined` | Variable not declared | 變數沒定義，檢查拼字/順序 |
| `TypeError: 'int' object is not callable` | `int x = 5();` | 變數蓋掉了函式名 |
| `IndentationError` | 少 `{}` | 縮排不一致，統一 4 空格 |
| `KeyError: 'name'` | HashMap.get 回 null | dict 沒這個 key，用 `.get("name", 預設)` |
| `IndexError: list index out of range` | ArrayIndexOutOfBounds | list 越界，先檢查 len() |
| `ModuleNotFoundError: No module named 'requests'` | 缺 Maven dependency | `pip install requests`，確認 venv 有啟動 |
| `AttributeError: 'NoneType' object has no attribute` | NPE | 前面回傳 None，先做 None 檢查 |
| `JSONDecodeError` | Jackson parse 失敗 | 回應不是 JSON，先 print 原文看內容 |

---

## 9. 提示寫作重點回顧

| 要點 | 做法 |
|---|---|
| 先講背景 | 「我是 Java 開發者，懂 Spring Boot」→ AI 會用你懂的語言解釋 |
| 給輸入輸出 | 明確說「輸入什麼、回傳什麼格式」 |
| 指定 JSON 格式 | 直接貼你要的 JSON schema，AI 會照做 |
| 指定 model | 練習用 `gpt-4o-mini`（便宜），正式再考慮 `gpt-4o` |
| 要求對照表 | 每個關鍵語法都請 AI「對照 Java」給一樣的 |
| 分小步驗證 | 先跑通 embedding → 再跑通檢索 → 再接 LLM，不要一次全做 |
| 驗收導向 | 每個提示都以「驗收作品：RAG JSON 回傳」為目標回頭檢驗 |
| 資料安全 | API Key 只在 `.env`，絕不 commit；範例中也避免嵌入真實 Key |