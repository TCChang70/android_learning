# 週 18｜Python + AI 整合（30h 濃縮模組）

> **學習目標**：以 Java 經驗 30h 內掌握 Python 並整合 LLM / RAG
> **最終驗收**：一支「問一句話 → 回傳 JSON（含引用來源）」的 RAG 知識庫問答助理

---

## 時數配比總覽

| 段 | 時數 | 內容 | 核心產出 |
|---|---|---|---|
| A | 10h | Python 基礎（與 Java 對照） | Python 腳本能跑 |
| B | 8h | Python 實務 | 串 API + 資料處理 |
| C | 6h | LLM API 整合 | 能呼叫 OpenAI 並解析 JSON |
| D | 6h | RAG 知識庫問答 | 完整 RAG 問答助理 |
| **合計** | **30h** | | |

---

## 模組 A｜Python 基礎與 Java 對照（10h）

### A-1 環境建置 + 認識 Python（1.5h）

#### 安裝與環境

```
# 1. 安裝 Python 3.11+（勾選 Add to PATH）
# 2. 驗證
python --version
pip --version

# 3. 建立虛擬環境（對應 Java 的 Maven/Gradle 依賴隔離）
python -m venv venv
# Windows 啟動
venv\Scripts\activate
# macOS/Linux 啟動
source venv/bin/activate

# 4. 安裝套件（對應 Maven 的 <dependency>）
pip install requests pandas openai
pip freeze > requirements.txt          # 對應 pom.xml
pip install -r requirements.txt        # 對應 mvn install
```

#### 檔案結構對照

| Java 專案 | Python  專案 | 說明 |
|---|---|---|
| `pom.xml` | `requirements.txt` | 套件依賴清單 |
| `src/main/java/` | `src/` 或根目錄 | 原始碼 |
| `application.properties` | `.env` + `python-dotenv` | 設定檔 |
| `mvn clean install` | `pip install -r requirements.txt` | 安裝依賴 |
| `java MainClass` | `python main.py` | 執行程式 |

#### 第一支程式

```python
# hello.py
print("Hello from Python!")          # 對應 System.out.println()

# 互動輸入（對應 Scanner）
name = input("你叫什麼名字？ ")
print(f"你好，{name}！")              # f-string ≈ String.format()
```

---

### A-2 變數、型別、運算（1.5h）

#### Java vs Python 型別對照

| Java | Python | 說明 |
|---|---|---|
| `int x = 10;` | `x = 10` | Python 不需宣告型別（動態型別） |
| `double pi = 3.14;` | `pi = 3.14` | Python 一律用 `float`（無 `double`） |
| `String s = "hi";` | `s = "hi"` | 字串用 `str`，無 `char` 型別 |
| `boolean flag = true;` | `flag = True` | 注意大小寫 `True / False` |
| `final int N = 5;` | `N = 5` | Python 無 `final`，用全大寫命名慣例 |
| `int[] arr = {1,2};` | `arr = [1, 2]` | Python 用 list，無固定長度陣列 |

#### 運算子差異

```python
# 除法（重要差異！）
7 / 2     # → 3.5  （Java 的 7/2 = 3 整數除法）
7 // 2    # → 3    （Python 的整數除法用 //）
7 % 2     # → 1    （取餘數相同）

# 比較運算
# Python 沒有 === ，只有 ==（因無型別歧義）
# Python 支援鏈式比較：1 < x < 10（Java 需 1 < x && x < 10）

# 邏輯運算
# Java: && || !    Python: and or not
x = 5
result = x > 0 and x < 10   # True
```

#### 字串操作對照

| 功能 | Java | Python |
|---|---|---|
| 字串長度 | `s.length()` | `len(s)` |
| 取字元 | `s.charAt(0)` | `s[0]` |
| 子字串 | `s.substring(1, 3)` | `s[1:3]` |
| 分割 | `s.split(",")` | `s.split(",")` |
| 取代 | `s.replace("a", "b")` | `s.replace("a", "b")` |
| 去空白 | `s.trim()` | `s.strip()` |
| 格式化 | `String.format()` | `f"{var}"` |
| 空值判斷 | `s == null \|\| s.isEmpty()` | `not s`（ falsy 判斷） |

```python
s = "  Hello, Python!  "
print(s.strip())              # "Hello, Python!"
print(len(s.strip()))         # 15
print(s.strip()[0:5])         # "Hello"
print(f"長度為 {len(s.strip())}")  # "長度為 15"
```

---

### A-3 流程控制（1.5h）

#### if / elif / else

```python
# Java                    # Python（注意：無大括號，靠縮排）
score = 85                score = 85
                          if score >= 90:
if (score >= 90) {            grade = "A"
    grade = "A";          elif score >= 80:
} else if (score >= 80) {      grade = "B"
    grade = "B";          elif score >= 70:
} else {                      grade = "C"
    grade = "C";          else:
}                               grade = "D"
                          print(grade)
```

> **Python 不用括號，用縮排（4 空格或 1 tab）定義區塊。**

#### for 迴圈

```python
# Java: for (int i = 0; i < 5; i++)
for i in range(5):          # 0, 1, 2, 3, 4
    print(i)

# Java: for (String s : list)
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)

# 帶索引（Java 的 fori）
for i, fruit in enumerate(fruits):
    print(f"{i}: {fruit}")

# while
count = 0
while count < 5:
    print(count)
    count += 1              # Python 沒有 count++
```

#### 列表推導式（Python 獨有，Java 無對應）

```python
# Java 要寫 5 行
squares = []
for x in range(10):
    if x % 2 == 0:
        squares.append(x ** 2)

# Python 一行搞定
squares = [x ** 2 for x in range(10) if x % 2 == 0]
# → [0, 4, 16, 36, 64]
```

---

### A-4 資料結構（1h）

#### Python 內建四大容器

| Python | Java 對應 | 特性 |
|---|---|---|
| `list` | `ArrayList` | 有序、可重複、可改 |
| `tuple` | 無直接對應（近似 `List.unmodifiable`） | 有序、不可改 |
| `dict` | `HashMap` | 鍵值對、有序（3.7+） |
| `set` | `HashSet` | 無序、不重複 |

```python
# list（對應 ArrayList）
nums = [1, 2, 3]
nums.append(4)          # [1, 2, 3, 4]
nums.pop()              # 移除最後一個 → 4
nums[0]                 # 取值 → 1

# dict（對應 HashMap）
person = {"name": "Alice", "age": 30}
person["name"]          # "Alice"
person["email"] = "a@b.com"   # 新增
"name" in person        # True（Java 的 containsKey）

# tuple（不可變的 list）
point = (10, 20)
# point[0] = 30        # ❌ 會報錯

# set（對應 HashSet）
tags = {"python", "java", "python"}  # 自動去重
tags.add("ai")
```

---

### A-5 函式與模組（1.5h）

#### 函式定義

```python
# Java
public int add(int a, int b) {
    return a + b;
}

# Python
def add(a, b):          # 不需宣告回傳型別
    return a + b        # 不需宣告回傳型別

# 預設參數值（Java 不支援，需多載）
def greet(name, times=1):    # times 預設為 1
    for _ in range(times):
        print(f"Hello, {name}!")

greet("Alice")          # Hello, Alice!
greet("Alice", 3)       # Hello, Alice! x3

# 回傳多個值（Java 要建 Class 或用 Pair）
def min_max(nums):
    return min(nums), max(nums)

lo, hi = min_max([3, 1, 4, 1, 5])    # lo=1, hi=5
```

#### Lambda 匿名函式

```python
# Java: x -> x * 2   或  (x) -> { return x * 2; }
double_it = lambda x: x * 2
print(double_it(5))     # 10

# 常搭配 sorted / map / filter
words = ["banana", "apple", "cherry"]
sorted_words = sorted(words, key=lambda w: len(w))
# → ['apple', 'banana', 'cherry']
```

#### 模組與 import

```python
# math_utils.py（對應 Java 的 Class）
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

# main.py
import math_utils                        # 整個模組
print(math_utils.factorial(5))           # 120

from math_utils import factorial         # 只匯入函式
print(factorial(5))

# 內建模組（對應 java.util.*）
import json
import os
import datetime
from pathlib import Path                 # 對應 java.nio.file.Path
```

---

### A-6 類別與物件（OOP）（1.5h）

```python
# Java
public class Employee {
    private String name;
    private double salary;

    public Employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
    }

    public String getName() { return name; }
    public double getSalary() { return salary; }
    public void raise(double pct) { salary *= (1 + pct / 100); }

    @Override
    public String toString() {
        return "Employee{name='" + name + "', salary=" + salary + "}";
    }
}

# Python（功能等價）
class Employee:
    def __init__(self, name: str, salary: float):   # 對應 constructor
        self.__name = name                            # 雙底線 = private（名稱改寫）
        self.__salary = salary

    @property                                         # 對應 getter
    def name(self):
        return self.__name

    @property
    def salary(self):
        return self.__salary

    def raise_pct(self, pct: float):                 # 對應方法
        self.__salary *= (1 + pct / 100)

    def __str__(self):                               # 對應 @Override toString()
        return f"Employee(name='{self.__name}', salary={self.__salary})"

# 使用
emp = Employee("Alice", 50000)
emp.raise_pct(10)
print(emp)          # Employee(name='Alice', salary=55000.0)
print(emp.name)     # Alice
```

#### 繼承

```python
class Manager(Employee):                             # 對應 extends
    def __init__(self, name, salary, team_size):
        super().__init__(name, salary)               # 對應 super()
        self.__team_size = team_size

    @property
    def team_size(self):
        return self.__team_size

    def __str__(self):
        return (f"Manager(name='{self.name}', "
                f"salary={self.salary}, "
                f"team={self.__team_size})")

mgr = Manager("Bob", 80000, 5)
print(mgr)      # Manager(name='Bob', salary=80000, team=5)
```

#### Pythonic 的資料類別（Python 3.7+）

```python
# Java 有 Lombok @Data，Python 有 dataclasses
from dataclasses import dataclass

@dataclass
class Employee:
    name: str
    salary: float
    department: str = "未分配"        # 預設值

    def raise_pct(self, pct: float):
        self.salary *= (1 + pct / 100)

emp = Employee("Alice", 50000)       # 自動產生 __init__
print(emp)                           # Employee(name='Alice', salary=50000, department='未分配')
emp.raise_pct(10)
print(emp.salary)                    # 55000.0
```

---

### A-7 例外處理（0.5h）

```python
# Java
try {
    int result = 10 / 0;
} catch (ArithmeticException e) {
    System.out.println("Error: " + e.getMessage());
} finally {
    System.out.println("Done");
}

# Python
try:
    result = 10 / 0
except ZeroDivisionError as e:           # 捕捉特定型別
    print(f"Error: {e}")
except Exception as e:                   # 捕捉所有（對應 catch(Exception e)）
    print(f"Unexpected: {e}")
finally:
    print("Done")

# 拋出例外（對應 throw）
def divide(a, b):
    if b == 0:
        raise ValueError("除數不能為零")   # 對應 throw new IllegalArgumentException()
    return a / b
```

---

### A-8 檔案操作（1h）

#### 讀寫文字檔

```python
# Java: Files.writeString / Files.readString (Java 11+)
from pathlib import Path

# 寫入（覆蓋）
Path("data.txt").write_text("Hello\n", encoding="utf-8")

# 寫入（追加）
with open("data.txt", "a", encoding="utf-8") as f:
    f.write("World\n")

# 讀取全部
content = Path("data.txt").read_text(encoding="utf-8")
print(content)

# 逐行讀取
with open("data.txt", "r", encoding="utf-8") as f:
    for line in f:
        print(line.strip())
```

#### 讀寫 JSON

```python
import json

# 寫入 JSON（對應 Java 的 ObjectMapper.writeValueAsString）
data = {
    "employees": [
        {"name": "Alice", "salary": 50000},
        {"name": "Bob", "salary": 60000}
    ]
}
Path("employees.json").write_text(
    json.dumps(data, ensure_ascii=False, indent=2),
    encoding="utf-8"
)

# 讀取 JSON（對應 ObjectMapper.readValue）
raw = Path("employees.json").read_text(encoding="utf-8")
loaded = json.loads(raw)
print(loaded["employees"][0]["name"])    # Alice
```

---

### A-9 虛擬環境 + 套件管理（1h）

```bash
# 建立虛擬環境（隔離專案依賴）
python -m venv venv
venv\Scripts\activate             # Windows
# source venv/bin/activate       # macOS/Linux

# 安裝套件
pip install requests              # 安裝單一套件
pip install pandas openai         # 安裝多個
pip install 'fastapi[standard]'   # 安裝含 extras

# 列出已安裝
pip list

# 匯出依賴（對應 pom.xml）
pip freeze > requirements.txt

# 從 requirements.txt 安裝
pip install -r requirements.txt

# 卸載
pip uninstall requests

# 建議的 .gitignore
# venv/
# __pycache__/
# .env
# *.pyc
```

---

### A-10 Python 基礎模組驗收（0.5h）

#### 練習題：員工檔案管理器

```python
"""
需求：整合 A-1 ~ A-9 所學，完成以下功能
1. 定義 Employee dataclass
2. 讀取 employees.json（若不存在則建立空 list）
3. 新增員工（input 名字、薪資）
4. 儲存回 JSON
5. 列出所有員工（格式化輸出）
"""

import json
from dataclasses import dataclass, asdict
from pathlib import Path

DATA_FILE = Path("employees.json")

@dataclass
class Employee:
    name: str
    salary: float
    department: str = "未分配"

def load_employees():
    if DATA_FILE.exists():
        data = json.loads(DATA_FILE.read_text(encoding="utf-8"))
        return [Employee(**e) for e in data]
    return []

def save_employees(employees):
    DATA_FILE.write_text(
        json.dumps([asdict(e) for e in employees],
                   ensure_ascii=False, indent=2),
        encoding="utf-8"
    )

def main():
    employees = load_employees()
    print(f"目前有 {len(employees)} 位員工")

    name = input("員工姓名：")
    salary = float(input("薪資："))
    employees.append(Employee(name, salary))
    save_employees(employees)

    print("\n=== 員工清單 ===")
    for i, emp in enumerate(employees, 1):
        print(f"{i}. {emp.name} - ${emp.salary:,.0f} ({emp.department})")

if __name__ == "__main__":
    main()
```

---

## 模組 B｜Python 實務（8h）

### B-1 requests 串接 REST API（3h）

#### 基本 GET 請求

```python
import requests

# GET 請求（對應 Java 的 HttpURLConnection 或 OkHttp）
response = requests.get("https://jsonplaceholder.typicode.com/posts/1")

print(response.status_code)     # 200
print(response.headers["Content-Type"])
print(response.json())          # 自動解析 JSON → dict

# 帶 Query Params
response = requests.get(
    "https://jsonplaceholder.typicode.com/posts",
    params={"userId": 1}        # ?userId=1
)
posts = response.json()
print(f"共 {len(posts)} 篇文章")
```

#### POST / PUT / DELETE

```python
# POST - 新增
new_post = {
    "title": "Hello",
    "body": "Content",
    "userId": 1
}
response = requests.post(
    "https://jsonplaceholder.typicode.com/posts",
    json=new_post               # 自動設 Content-Type: application/json
)
print(response.status_code)     # 201
print(response.json())

# PUT - 更新
response = requests.put(
    "https://jsonplaceholder.typicode.com/posts/1",
    json={"id": 1, "title": "Updated", "body": "New", "userId": 1}
)

# DELETE - 刪除
response = requests.delete("https://jsonplaceholder.typicode.com/posts/1")
print(response.status_code)     # 200
```

#### 錯誤處理 + Timeout

```python
import requests
from requests.exceptions import HTTPError, ConnectionError, Timeout

def call_api(url, method="GET", data=None, timeout=10):
    try:
        if method == "GET":
            resp = requests.get(url, timeout=timeout)
        elif method == "POST":
            resp = requests.post(url, json=data, timeout=timeout)
        else:
            raise ValueError(f"不支援的 method: {method}")

        resp.raise_for_status()     # 對應 Java 的 if (code >= 400) throw
        return resp.json()

    except Timeout:
        print(f"請求逾時（{timeout}s）")
    except ConnectionError:
        print("連線失敗")
    except HTTPError as e:
        print(f"HTTP 錯誤 {e.response.status_code}: {e.response.text}")
    except Exception as e:
        print(f"未預期錯誤: {e}")
    return None

# 使用
result = call_api("https://jsonplaceholder.typicode.com/posts/1")
if result:
    print(result["title"])
```

#### 自訂 Headers（含 API Key）

```python
headers = {
    "Authorization": "Bearer YOUR_API_KEY",
    "Content-Type": "application/json",
    "X-Custom-Header": "value"
}
response = requests.get("https://api.example.com/data", headers=headers)
```

---

### B-2 pandas 資料處理（3h）

#### 建立 DataFrame

```python
import pandas as pd
from pathlib import Path
import json

# 從 dict 建立
data = {
    "name": ["Alice", "Bob", "Charlie", "Diana"],
    "department": ["IT", "HR", "IT", "Finance"],
    "salary": [75000, 55000, 80000, 65000],
    "years": [5, 3, 8, 4]
}
df = pd.DataFrame(data)

# 從 CSV 讀取（對應 Java 讀 CSV 的第三方庫）
# df = pd.read_csv("employees.csv")

# 從 JSON 讀取
# df = pd.read_json("employees.json")

# 從 API 讀取
# resp = requests.get("https://api.example.com/employees")
# df = pd.DataFrame(resp.json())

print(df)
#      name department  salary  years
# 0    Alice         IT   75000      5
# 1      Bob         HR   55000      3
# 2  Charlie         IT   80000      8
# 3    Diana    Finance   65000      4
```

#### 常用操作

```python
# 基本檢視
df.shape                      # (4, 4) - 列數 x 欄數
df.head(2)                    # 前 2 列
df.info()                     # 欄位型別 + 非空計數
df.describe()                 # 數值統計（count/mean/std/min/max）

# 選欄位（對應 SQL SELECT column）
df["name"]                    # 單欄 → Series
df[["name", "salary"]]        # 多欄 → DataFrame

# 篩選列（對應 SQL WHERE）
seniors = df[df["years"] >= 5]
it_team = df[df["department"] == "IT"]
high_salary = df[df["salary"] > 60000]

# 多條件篩選（AND: &，OR: |，NOT: ~）
result = df[(df["department"] == "IT") & (df["salary"] > 70000)]

# 新增欄位
df["bonus"] = df["salary"] * 0.1
df["level"] = df["years"].apply(
    lambda y: "Senior" if y >= 5 else "Junior"
)

# 排序
df.sort_values("salary", ascending=False)           # 薪資高→低
df.sort_values(["department", "salary"], ascending=[True, False])
```

#### Group By 聚合（對應 SQL GROUP BY）

```python
# 按部門統計
dept_stats = df.groupby("department").agg(
    count=("name", "count"),
    avg_salary=("salary", "mean"),
    max_salary=("salary", "max"),
    total_years=("years", "sum")
).reset_index()

print(dept_stats)
#   department  count  avg_salary  max_salary  total_years
# 0    Finance      1     65000.0       65000            4
# 1         HR      1     55000.0       55000            3
# 2         IT      2     77500.0       80000           13

# 匯出結果
dept_stats.to_csv("dept_stats.csv", index=False)
dept_stats.to_json("dept_stats.json", orient="records", force_ascii=False)
```

---

### B-3 實戰練習：串 API + pandas 分析（2h）

#### 範例：抓取 GitHub 資訊並分析

```python
import requests
import pandas as pd

def get_github_repos(language="python", per_page=30):
    """搜尋 GitHub trending repos"""
    url = "https://api.github.com/search/repositories"
    params = {
        "q": f"language:{language}",
        "sort": "stars",
        "order": "desc",
        "per_page": per_page
    }
    resp = requests.get(url, params=params, timeout=15)
    resp.raise_for_status()
    return resp.json()["items"]

def analyze_repos(repos):
    df = pd.DataFrame(repos)
    # 只取需要的欄位
    df = df[["name", "full_name", "stargazers_count",
             "forks_count", "open_issues_count", "created_at"]]

    print("=== 基本統計 ===")
    print(f"總共 {len(df)} 個 repo")
    print(f"平均星星: {df['stargazers_count'].mean():,.0f}")
    print(f"最多星星: {df['stargazers_count'].max():,}")

    print("\n=== Top 5 ===")
    top5 = df.nlargest(5, "stargazers_count")
    for _, row in top5.iterrows():
        print(f"  {row['name']}: ⭐ {row['stargazers_count']:,}")

    # 匯出
    df.to_csv("github_repos.csv", index=False)
    print("\n已匯出 github_repos.csv")

if __name__ == "__main__":
    repos = get_github_repos("python", 30)
    analyze_repos(repos)
```

---

### B-4 實戰練習：CSV 報表產生器（可選，自學）

```python
import pandas as pd
from datetime import datetime

# 模擬訂單資料
orders = pd.DataFrame({
    "order_id": range(1001, 1011),
    "customer": ["Alice", "Bob", "Alice", "Charlie", "Diana",
                 "Bob", "Alice", "Diana", "Charlie", "Bob"],
    "product": ["Laptop", "Mouse", "Keyboard", "Monitor", "Laptop",
                "Mouse", "Monitor", "Keyboard", "Laptop", "Mouse"],
    "quantity": [1, 2, 1, 1, 1, 3, 1, 2, 1, 5],
    "unit_price": [999, 25, 75, 299, 999, 25, 299, 75, 999, 25]
})

# 計算金額
orders["total"] = orders["quantity"] * orders["unit_price"]

# 客戶消費排名
customer_summary = orders.groupby("customer").agg(
    order_count=("order_id", "count"),
    total_spent=("total", "sum"),
    avg_order=("total", "mean")
).sort_values("total_spent", ascending=False)

print("=== 客戶消費排名 ===")
print(customer_summary.to_string())

# 匯出報表
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
orders.to_excel(f"orders_{timestamp}.xlsx", index=False, sheet_name="訂單明細")
print(f"\n已匯出 orders_{timestamp}.xlsx")
```

---

## 模組 C｜LLM API 整合（6h）

### C-1 認識 LLM API + 環境建置（1.5h）

#### LLM API 概念

```
你的程式（Python）
    ↓ HTTP POST (prompt)
LLM 服務（OpenAI / Claude / Gemini）
    ↓ 回傳 completion
你的程式 → 解析 response → 顯示/儲存
```

#### 安裝 OpenAI SDK

```bash
pip install openai
```

#### API Key 管理

```python
# .env 檔案（絕對不能 commit 到 Git）
OPENAI_API_KEY=sk-xxxxxxxxxxxxx

# Python 讀取 .env
from dotenv import load_dotenv
import os

load_dotenv()                          # 讀取 .env
api_key = os.getenv("OPENAI_API_KEY")
print(f"Key 長度: {len(api_key)}")     # 確認有讀到
```

#### .gitignore 必加

```
.env
venv/
__pycache__/
*.pyc
```

---

### C-2 呼叫 LLM API（2h）

#### 最簡單的呼叫

```python
from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

response = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[
        {"role": "system", "content": "你是一個 helpful 的助理。"},
        {"role": "user", "content": "什麼是 RAG？用一句話解釋。"}
    ]
)

answer = response.choices[0].message.content
print(answer)
```

#### Prompt 工程基礎

```python
# system prompt = 角色設定（對應 Java 的 @Configuration）
# user prompt = 使用者輸入

# 1. 角色扮演
system_prompt = """你是一位資深 Python 工程師，專精 Spring Boot 轉 Python。
回答時：
- 使用繁體中文
- 程式碼附帶註解
- 與 Java 做對照說明
- 範例使用 Python 3.11+ 語法"""

# 2. 結構化輸出提示
user_prompt = """
請比較 Java 和 Python 的檔案讀取方式，用 JSON 格式回傳：

{
  "java_code": "Java 範例程式碼",
  "python_code": "Python 等價程式碼",
  "differences": ["差異點1", "差異點2"]
}
"""
```

#### 強制 JSON 輸出（response_format）

```python
response = client.chat.completions.create(
    model="gpt-4o",
    messages=[
        {"role": "system", "content": "你只能用 JSON 格式回答。"},
        {"role": "user", "content": "列出3種Python資料結構，用JSON回傳。"}
    ],
    response_format={"type": "json_object"}   # 強制 JSON 輸出
)

import json
data = json.loads(response.choices[0].message.content)
print(json.dumps(data, ensure_ascii=False, indent=2))
# {
#   "data_structures": [
#     {"name": "list", "description": "有序、可變的集合"},
#     {"name": "dict", "description": "鍵值對的映射"},
#     {"name": "set", "description": "無序、不重複的集合"}
#   ]
# }
```

---

### C-3 實戰：AI 輔助翻譯 + 分類 API（1.5h）

#### 建立一支 Python API（FastAPI）

```python
# pip install fastapi uvicorn

from fastapi import FastAPI
from pydantic import BaseModel
from openai import OpenAI
from dotenv import load_dotenv
import os, json

load_dotenv()
app = FastAPI(title="AI 分類 API")
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

class TextInput(BaseModel):
    text: str

@app.post("/classify")
def classify_text(input: TextInput):
    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[
            {"role": "system", "content": """你是一個文字分類器。
使用者給你一段文字，你要判斷它屬於哪個類別。
回傳 JSON 格式：
{"category": "類別", "confidence": 0.0-1.0, "keywords": ["關鍵字1", "關鍵字2"]}"""},
            {"role": "user", "content": input.text}
        ],
        response_format={"type": "json_object"}
    )

    result = json.loads(response.choices[0].message.content)
    return {"input": input.text, **result}

# 執行：uvicorn main:app --reload
# 測試：http://localhost:8000/docs
```

---

### C-4 Token 計費 + 最佳實踐（1h）

#### Token 概念

```
1 token ≈ 英文 3/4 個字 ≈ 中文 1~2 個字
GPT-4o-mini: 輸入 $0.15 / 輸出 $0.60 / 1M tokens
GPT-4o:      輸入 $2.50 / 輸出 $10.00 / 1M tokens
```

#### 節省成本技巧

```python
# 1. 使用 gpt-4o-mini（便宜 10x，夠用的場景就用 mini）
model = "gpt-4o-mini"     # 而非 "gpt-4o"

# 2. 控制 max_tokens
response = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[...],
    max_tokens=200            # 限制回應長度
)

# 3. 系統提示詞精簡
# ❌ 不要：長篇大論的角色設定
# ✅ 要：精準 1-2 句指令

# 4. 善用 temperature
response = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[...],
    temperature=0.0           # 精確任務用 0（如分類）
    # temperature=0.7         # 創意任務用 0.7（如寫作）
)

# 5. 追蹤 token 使用量
usage = response.usage
print(f"輸入 tokens: {usage.prompt_tokens}")
print(f"輸出 tokens: {usage.completion_tokens}")
print(f"總計: {usage.total_tokens}")
```

---

## 模組 D｜RAG 知識庫問答（6h）

### D-1 RAG 概念與架構（1h）

#### 什麼是 RAG？

```
RAG = Retrieval-Augmented Generation（檢索增強生成）

使用者提問
    ↓
[1. 切塊] 知識庫文件 → 切成小段（chunks）
    ↓
[2. Embedding] 每段轉成向量（數字陣列）
    ↓
[3. 檢索] 問題向量 vs 知識庫向量 → 找最相關的 N 段
    ↓
[4. 生成] 把「問題 + 相關段落」丟給 LLM → 產生答案（附引用來源）
```

#### 為什麼需要 RAG？

| 問題 | 沒有 RAG | 有 RAG |
|---|---|---|
| LLM 知不知道你公司內部資料？ | ❌ 不知道 | ✅ 知道 |
| LLM 會不會胡說八道（幻覺）？ | ❌ 會 | ✅ 有引用，可查證 |
| 資料更新了怎麼辦？ | 需重新訓練 | 更新知識庫即可 |

---

### D-2 切塊（Chunking）（1.5h）

#### 切塊策略

```python
def chunk_text(text: str, chunk_size: int = 500, overlap: int = 50) -> list[dict]:
    """
    將文字切成小段落
    chunk_size: 每段最大字元數
    overlap: 相鄰段落重疊字元數（確保上下文連貫）
    """
    chunks = []
    start = 0
    text = text.strip()

    while start < len(text):
        end = start + chunk_size

        # 優先在段落或句號處斷開
        if end < len(text):
            # 嘗試在句號處斷開
            last_period = text.rfind("。", start, end)
            if last_period > start + chunk_size // 2:
                end = last_period + 1
            else:
                # 嘗試在換行處斷開
                last_newline = text.rfind("\n", start, end)
                if last_newline > start + chunk_size // 2:
                    end = last_newline + 1

        chunk_text = text[start:end].strip()
        if chunk_text:
            chunks.append({
                "id": len(chunks),
                "text": chunk_text,
                "start": start,
                "end": end
            })

        start = end - overlap  # 重疊

    return chunks

# 使用
from pathlib import Path

doc = Path("knowledge.txt").read_text(encoding="utf-8")
chunks = chunk_text(doc, chunk_size=500, overlap=50)
print(f"共切成 {len(chunks)} 個段落")
for c in chunks[:3]:
    print(f"[{c['id']}] {c['text'][:60]}...")
```

#### 範例：從 Markdown 建立知識庫

```python
from pathlib import Path
import json

def load_markdown_kb(directory: str) -> list[dict]:
    """從目錄中的 .md 檔案建立知識庫"""
    kb = []
    md_files = Path(directory).glob("*.md")

    for filepath in md_files:
        content = filepath.read_text(encoding="utf-8")
        # 按 ## 標題切分
        sections = content.split("\n## ")

        for i, section in enumerate(sections):
            if section.strip():
                # 取第一行作為標題
                lines = section.strip().split("\n")
                title = lines[0].replace("#", "").strip()
                body = "\n".join(lines[1:]).strip()

                if body:
                    kb.append({
                        "source": filepath.name,
                        "section": title,
                        "content": body,
                        "chunk_id": f"{filepath.stem}_{i}"
                    })

    return kb

# 建立知識庫
kb = load_markdown_kb("./docs/")
print(f"知識庫共 {len(kb)} 個段落")

# 儲存
Path("knowledge_base.json").write_text(
    json.dumps(kb, ensure_ascii=False, indent=2),
    encoding="utf-8"
)
```

---

### D-3 Embedding 向量化（1.5h）

#### 什麼是 Embedding？

```
文字：    "Python 是一種程式語言"
向量：    [0.02, -0.15, 0.87, 0.03, ..., 0.42]  (1536 維)
          ↑ 每個數字代表一個「語意面向」
相似的文字 → 向量在空間中距離相近
```

#### 使用 OpenAI Embedding API

```python
from openai import OpenAI
from dotenv import load_dotenv
import json
from pathlib import Path

load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

def get_embedding(text: str) -> list[float]:
    """取得單一文字的向量"""
    response = client.embeddings.create(
        model="text-embedding-3-small",    # 1536 維，便宜
        input=text
    )
    return response.data[0].embedding

def build_embedding_db(chunks: list[dict]) -> list[dict]:
    """為所有 chunks 建立向量資料庫"""
    db = []
    for i, chunk in enumerate(chunks):
        embedding = get_embedding(chunk["text"])
        db.append({
            **chunk,
            "embedding": embedding
        })
        if (i + 1) % 10 == 0:
            print(f"已處理 {i + 1}/{len(chunks)} 個段落")
    return db

# 使用
chunks = chunk_text(Path("knowledge.txt").read_text(encoding="utf-8"))
db = build_embedding_db(chunks)

# 儲存向量資料庫
Path("embedding_db.json").write_text(
    json.dumps(db, ensure_ascii=False),
    encoding="utf-8"
)
```

#### 向量相似度計算（餘弦相似度）

```python
import math

def cosine_similarity(a: list[float], b: list[float]) -> float:
    """計算兩個向量的餘弦相似度（0~1，越接近 1 越相似）"""
    dot = sum(x * y for x, y in zip(a, b))
    norm_a = math.sqrt(sum(x * x for x in a))
    norm_b = math.sqrt(sum(x * x for x in b))
    if norm_a == 0 or norm_b == 0:
        return 0.0
    return dot / (norm_a * norm_b)

# 找出與查詢最相關的段落
def search(query: str, db: list[dict], top_k: int = 3) -> list[dict]:
    """語意搜尋：找最相關的 top_k 個段落"""
    query_embedding = get_embedding(query)

    results = []
    for chunk in db:
        score = cosine_similarity(query_embedding, chunk["embedding"])
        results.append({**chunk, "score": score})

    # 按相似度排序
    results.sort(key=lambda x: x["score"], reverse=True)
    return results[:top_k]

# 測試搜尋
results = search("如何安裝 Python？", db, top_k=3)
for r in results:
    print(f"[{r['score']:.3f}] {r['source']}: {r['section']}")
    print(f"  {r['text'][:80]}...\n")
```

---

### D-4 RAG 問答助理完整實作（1.5h）

#### 完整 RAG 系統

```python
"""
RAG 知識庫問答助理
功能：問一句話 → 回傳 JSON（含引用來源）
"""

from openai import OpenAI
from dotenv import load_dotenv
import json
import math
from pathlib import Path

load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
EMBEDDING_MODEL = "text-embedding-3-small"
CHAT_MODEL = "gpt-4o-mini"

# ========== 向量工具 ==========

def get_embedding(text: str) -> list[float]:
    response = client.embeddings.create(model=EMBEDDING_MODEL, input=text)
    return response.data[0].embedding

def cosine_similarity(a: list[float], b: list[float]) -> float:
    dot = sum(x * y for x, y in zip(a, b))
    norm_a = math.sqrt(sum(x * x for x in a))
    norm_b = math.sqrt(sum(x * x for x in b))
    return dot / (norm_a * norm_b) if norm_a and norm_b else 0.0

# ========== 切塊 ==========

def chunk_text(text: str, size: int = 500, overlap: int = 50) -> list[dict]:
    chunks = []
    start = 0
    while start < len(text):
        end = min(start + size, len(text))
        chunk = text[start:end].strip()
        if chunk:
            chunks.append({"id": len(chunks), "text": chunk})
        start = end - overlap
    return chunks

# ========== 搜尋 ==========

def retrieve(query: str, db: list[dict], top_k: int = 3) -> list[dict]:
    q_emb = get_embedding(query)
    results = [{**c, "score": cosine_similarity(q_emb, c["embedding"])} for c in db]
    results.sort(key=lambda x: x["score"], reverse=True)
    return results[:top_k]

# ========== 生成 ==========

def generate_answer(query: str, contexts: list[dict]) -> dict:
    context_text = "\n\n---\n\n".join(
        f"[來源: {c['source']}, 段落: {c.get('section', 'N/A')}]\n{c['text']}"
        for c in contexts
    )

    response = client.chat.completions.create(
        model=CHAT_MODEL,
        messages=[
            {"role": "system", "content": """你是一個知識庫問答助理。
根據提供的「參考資料」回答問題。
規則：
1. 只根據參考資料回答，如果資料不足就說「根據現有資料無法回答」
2. 必須標註引用來源（在答案後附上 [來源: xxx]）
3. 使用繁體中文
4. 回傳 JSON 格式"""},
            {"role": "user", "content": f"""參考資料：
{context_text}

問題：{query}

請用以下 JSON 格式回傳：
{{
  "answer": "你的回答（含引用標記）",
  "sources": ["來源1", "來源2"],
  "confidence": 0.0 到 1.0
}}"""}
        ],
        response_format={"type": "json_object"},
        temperature=0.0
    )

    return json.loads(response.choices[0].message.content)

# ========== 主程式 ==========

def rag_query(query: str, kb: list[dict]) -> dict:
    """完整 RAG 流程：問一句話 → 回傳 JSON"""
    # 1. 檢索
    contexts = retrieve(query, kb, top_k=3)

    # 2. 生成
    answer = generate_answer(query, contexts)

    # 3. 組裝完整回應
    return {
        "query": query,
        "answer": answer["answer"],
        "sources": answer.get("sources", []),
        "confidence": answer.get("confidence", 0),
        "retrieved_chunks": [
            {
                "source": c["source"],
                "score": round(c["score"], 3),
                "excerpt": c["text"][:100]
            }
            for c in contexts
        ]
    }

# ========== 使用範例 ==========

if __name__ == "__main__":
    # 載入知識庫（假設已建好 embedding_db.json）
    kb = json.loads(Path("embedding_db.json").read_text(encoding="utf-8"))
    print(f"知識庫載入完成，共 {len(kb)} 個段落")

    # 互動問答
    while True:
        query = input("\n請提問（輸入 q 離開）：")
        if query.lower() == "q":
            break

        result = rag_query(query, kb)
        print(json.dumps(result, ensure_ascii=False, indent=2))
```

---

### D-5 串成 FastAPI 服務（0.5h）

```python
"""
RAG 問答 API
POST /ask → {"question": "..."} → 回傳 JSON
"""

from fastapi import FastAPI
from pydantic import BaseModel
from pathlib import Path
import json

app = FastAPI(title="RAG 知識庫問答 API")

# 載入知識庫（啟動時載入一次）
kb = json.loads(Path("embedding_db.json").read_text(encoding="utf-8"))

class QuestionRequest(BaseModel):
    question: str

@app.post("/ask")
def ask(request: QuestionRequest):
    result = rag_query(request.question, kb)
    return result

@app.get("/health")
def health():
    return {"status": "ok", "kb_size": len(kb)}

# 執行
# uvicorn rag_api:app --reload --port 8000
# 測試 http://localhost:8000/docs
```

---

## 綜合驗收專案（含於 6h RAG 模組中）

### 06_final_rag_assistant.py

```python
"""
=== RAG 知識庫問答助理 ===
驗收標準：問一句話 → 回傳 JSON（含引用來源）

使用方式：
1. 建立知識庫資料夾 ./kb/，放入 .txt 或 .md 檔案
2. 執行此腳本建立向量資料庫（首次）
3. 啟動後即可互動問答
"""

from openai import OpenAI
from dotenv import load_dotenv
import json, math, os
from pathlib import Path
from datetime import datetime

load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

# ===== 設定 =====
KB_DIR = Path("./kb")
DB_FILE = Path("./embedding_db.json")
EMBEDDING_MODEL = "text-embedding-3-small"
CHAT_MODEL = "gpt-4o-mini"

# ===== 工具函式 =====

def get_embedding(text: str) -> list[float]:
    resp = client.embeddings.create(model=EMBEDDING_MODEL, input=text)
    return resp.data[0].embedding

def cosine_sim(a: list[float], b: list[float]) -> float:
    dot = sum(x * y for x, y in zip(a, b))
    na = math.sqrt(sum(x**2 for x in a))
    nb = math.sqrt(sum(x**2 for x in b))
    return dot / (na * nb) if na and nb else 0.0

def chunk_text(text: str, size: int = 500, overlap: int = 50) -> list[str]:
    chunks = []
    start = 0
    while start < len(text):
        end = min(start + size, len(text))
        chunk = text[start:end].strip()
        if chunk:
            chunks.append(chunk)
        start = end - overlap
    return chunks

# ===== 建立知識庫 =====

def build_kb():
    """從 ./kb/ 目錄建立向量資料庫"""
    if not KB_DIR.exists():
        KB_DIR.mkdir()
        print(f"已建立 {KB_DIR} 目錄，請放入 .txt 或 .md 檔案後重新執行。")
        return []

    all_chunks = []
    for f in KB_DIR.glob("*"):
        if f.suffix in (".txt", ".md"):
            text = f.read_text(encoding="utf-8")
            for chunk in chunk_text(text):
                all_chunks.append({
                    "source": f.name,
                    "text": chunk
                })

    if not all_chunks:
        print("知識庫為空，請在 ./kb/ 放入文字檔案。")
        return []

    print(f"共 {len(all_chunks)} 個段落，正在建立向量...")
    db = []
    for i, c in enumerate(all_chunks):
        emb = get_embedding(c["text"])
        db.append({**c, "embedding": emb})
        if (i + 1) % 10 == 0:
            print(f"  {i+1}/{len(all_chunks)}")

    DB_FILE.write_text(json.dumps(db, ensure_ascii=False), encoding="utf-8")
    print(f"向量資料庫已儲存至 {DB_FILE}")
    return db

# ===== 檢索 + 生成 =====

def rag_query(question: str, db: list[dict]) -> dict:
    """核心 RAG 流程"""
    # Step 1: 檢索
    q_emb = get_embedding(question)
    scored = [{**c, "score": cosine_sim(q_emb, c["embedding"])} for c in db]
    scored.sort(key=lambda x: x["score"], reverse=True)
    top = scored[:3]

    # Step 2: 組裝 context
    context = "\n---\n".join(
        f"[{c['source']}]\n{c['text']}" for c in top
    )

    # Step 3: 呼叫 LLM
    resp = client.chat.completions.create(
        model=CHAT_MODEL,
        messages=[
            {"role": "system", "content": (
                "你是一個知識庫問答助理。根據提供的參考資料回答。"
                "如果資料不足就說「現有資料無法回答」。"
                "必須標註引用來源。用繁體回答。"
            )},
            {"role": "user", "content": (
                f"參考資料:\n{context}\n\n問題: {question}\n\n"
                "請用 JSON 回答:\n"
                '{"answer": "回答內容", '
                '"sources": ["來源1", "來源2"], '
                '"confidence": 0.0到1.0}'
            )}
        ],
        response_format={"type": "json_object"},
        temperature=0.0
    )

    answer = json.loads(resp.choices[0].message.content)

    return {
        "query": question,
        "answer": answer.get("answer", ""),
        "sources": answer.get("sources", []),
        "confidence": answer.get("confidence", 0),
        "timestamp": datetime.now().isoformat()
    }

# ===== 主程式 =====

def main():
    print("=" * 50)
    print("  RAG 知識庫問答助理")
    print("=" * 50)

    # 載入或建立向量資料庫
    if DB_FILE.exists():
        db = json.loads(DB_FILE.read_text(encoding="utf-8"))
        print(f"向量資料庫已載入，共 {len(db)} 個段落")
    else:
        db = build_kb()

    if not db:
        return

    # 互動問答
    print("\n輸入問題開始問答（輸入 q 離開，輸入 rebuild 重建資料庫）\n")
    while True:
        q = input("📝 問題：").strip()
        if q.lower() == "q":
            break
        if q.lower() == "rebuild":
            db = build_kb()
            continue
        if not q:
            continue

        result = rag_query(q, db)
        print(f"\n🤖 回答：{result['answer']}")
        print(f"📎 引用來源：{', '.join(result['sources'])}")
        print(f"📊 信心度：{result['confidence']}")
        print()

if __name__ == "__main__":
    main()
```

---

## 30h 時數分配建議

| 天 | 時數 | 內容 | 重點 |
|---|---|---|---|
| Day 1 | 6h | A-1 ~ A-5（環境、變數、流程、容器、函式） | Python 語法基礎 |
| Day 2 | 4h | A-6 ~ A-10（OOP、例外、檔案、venv） | 完成基礎模組驗收 |
| Day 3 | 4h | B-1（requests 串 API） | 能呼叫 REST API |
| Day 4 | 4h | B-2 ~ B-3（pandas + 實戰練習） | 能處理 CSV/JSON |
| Day 5 | 4h | C-1 ~ C-2（LLM API + Prompt） | 能呼叫 OpenAI |
| Day 6 | 2h | C-3 ~ C-4（FastAPI + Token 計費） | 建立 AI API |
| Day 7 | 6h | D-1 ~ D-5（RAG 全流程 + 驗收） | 完成 RAG 問答助理 |

---

## 常見 Java → Python 踩坑提醒

| 場景 | Java 預期 | Python 實際 | 解法 |
|---|---|---|---|
| 整數除法 | `7/2 = 3` | `7/2 = 3.5` | 用 `7//2` |
| 變數宣告 | `int x = 5;` | `x = 5` | 直接賦值 |
| 字串比較 | `s.equals(t)` | `s == t` | Python 的 `==` 就是值比較 |
| 空值 | `null` | `None` | 用 `is None` 判斷，不是 `== None` |
| 布林值 | `true/false` | `True/False` | 注意大小寫 |
| 沒有型別 | `int x` | `x = 5` | 不需宣告，用 type hint 輔助 |
| 沒有 switch | `switch(x) { case 1: }` | `if/elif/else` | 或 `match`（Python 3.10+）|
| 沒有 `++` | `i++` | `i += 1` | 用 += 代替 |
| 縮排 | `{}` 定義區塊 | 縮排定義區塊 | 統一用 4 空格 |
| import | `import java.util.*` | `import os` | 按需匯入，無全域引入 |
