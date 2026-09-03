# Oracle 1Z0–830 Java SE 21 Developer（OCP Java SE 21）考題整理

> 來源：Emily Rose, *1Z0–830 Practice Tests for Java SE 21 Developer Certification Exam (with Resources)*（Medium）。
> 目的：彙整考試基本資訊、測驗範圍、備考資源、實作重點與 10 題精選範例考題解析。

---

## 一、考試基本資訊

| 項目 | 內容 |
|---|---|
| 認證 | Oracle Certified Professional (OCP): Java SE 21 Developer |
| 考試代碼 | **1Z0–830**（取代舊的 Java 11：1Z0–819） |
| 題數 | 50 題 |
| 通過分數 | 68% |
| 時間 | 90 分鐘 |
| 題型 | 單選 + 複選（select all that apply） |

---

## 二、測驗範圍（Exam Topics）

文章整理的主題範圍如下：

| 主題 | 重點內容 |
|---|---|
| **Data Types 資料型別** | Primitive、Wrapper、String、區域變數型別推導 `var` |
| **Control Flow 流程控制** | `if/else`、`switch` 運算式與述句、迴圈、assertion |
| **OOP 物件導向** | 類別、繼承、介面、record、sealed class |
| **Exception Handling 例外處理** | `try-catch`、multi-catch、try-with-resources |
| **Collections 集合** | `List`、`Set`、`Map`、`Queue`，以及 Java 21 的 **Sequenced 集合** |
| **Streams & Lambdas** | Functional interface、Stream API、`Optional` |
| **Modules & Packaging** | JPMS、service、module 遷移 |
| **Concurrency 並行** | Thread、`Executor`、**虛擬執行緒 Virtual Threads**（Java 21 / Project Loom）|
| **I/O & NIO.2** | 檔案處理、串流、序列化 |
| **JDBC** | Connection、Statement、transaction |
| **Localization** | `Locale`、`ResourceBundle`、格式化 API |
| **New Features（Java 8–21）** | Pattern matching、text blocks、records、sealed classes、virtual threads 等 |

---

## 三、備考資源

來源文章推薦：**javainuse.com/cert/1z0830**，分兩個區塊：

### 1. Practice Tests（練習測驗）
- 網址：`javainuse.com/cert/1z0830/quiz`
- **5 份完整練習卷**，每份 **66 題**（比正式考試稍多）。
- 涵蓋所有 exam objective、單選＋複選混合、即時計數器（0/66）、作答後即時回饋與每選項詳細解說。
- 連結：Practice Test [1](https://javainuse.com/cert/1z0830/quiz/1)、[2](https://javainuse.com/cert/1z0830/quiz/2)、[3](https://javainuse.com/cert/1z0830/quiz/3)、[4](https://javainuse.com/cert/1z0830/quiz/4)、[5](https://javainuse.com/cert/1z0830/quiz/5)

### 2. Preparation Topics（主題筆記）
- 網址：`javainuse.com/cert/1z0830/prep`
- 將整個 syllabus 整理成可點擊的 topic cards，每個主題連到含程式範例的深度筆記。
- 適合：事後補強弱點、考前快速複習。

---

## 四、建議備考計畫

| 週次 | 行動 |
|---|---|
| **第 1–2 週** | 依主題系統性研讀 prep topics。**Streams、Concurrency、Modules** 考題密度最高，多花時間。 |
| **第 3 週** | 限時完成 Practice Test 1（不翻書），仔細檢討每題答案與解說。 |
| **第 4 週** | 針對低於 70% 的主題回 prep topics 補強，接著做 Practice Test 2。 |
| **第 5 週** | 以考試情境做 Practice Test 3 / 4 / 5，目標穩定 **75% 以上**再報名。 |

---

## 五、應試重點提醒

- **「select all that apply」複選題**最易因漏選/多選扣分——每個選項獨立判斷。
- **`var` 規則**要背熟：常考 nullable、array、lambda 的邊界情況。
- **Virtual Threads（Java 21）**是新加入 syllabus，**不可跳過**。
- **Records 與 sealed classes** 出現頻率高於預期，且常與繼承、pattern matching 組合出題。
- **try-with-resources** 要熟練，例外題常把 multi-catch 和 TWR 組合考。

---

## 六、Practice Test 1 精選 10 題範例＋解析

> 先自己作答，再看答案。

### Q1. Which sealed class declarations compile?（Choose two.）
```
A. sealed class Shape permits Circle {} final class Circle extends Shape {}
B. sealed class Shape permits Circle {} class Circle extends Shape {}
C. public sealed class Shape permits Circle, Square {}
   final class Circle extends Shape {} non-sealed class Square extends Shape {}
D. public sealed class Shape {} final class Circle extends Shape {}
```
**✅ A and C**
- A：`Circle` 宣告 `final`，是繼承 sealed class 的必要條件。
- C：所有 permitted subclass 皆列出，且各自宣告 `final` 或 `non-sealed`。
- B 錯：`Circle` 必須是 `final`、`sealed` 或 `non-sealed`。
- D 錯：`Shape` 缺少 `permits` 子句。

---

### Q2. Which `var` declarations are invalid?（Choose three.）
```
A. var x = 10;
B. var y;
C. var z = null;
D. var a = {1, 2, 3};
E. var b = new int[]{1, 2, 3};
F. var c = (d = 5);
```
**✅ B, C, D**
- B 錯：`var` 需要 initializer（必須有初值）。
- C 錯：無法從 `null` 推斷型別。
- D 錯：array initializer 語法必須搭配 `new`（`{1,2,3}` 不合法）。
- E、F 皆合法。

---

### Q3. What does this print?
```java
double amount = 12500;
NumberFormat format = NumberFormat.getCompactNumberInstance(
    Locale.US, NumberFormat.Style.SHORT);
System.out.println(format.format(amount));
```
**✅ `12.5K`**
`getCompactNumberInstance` + `Style.SHORT` 在 US locale 下把 12,500 格式化為 `12.5K`。

---

### Q4. What is the output?
```java
Period p = Period.between(
    LocalDate.of(2022, Month.JANUARY, 1),
    LocalDate.of(2023, Month.JANUARY, 1));
System.out.print(p);

Duration d = Duration.between(
    LocalDate.of(2022, Month.JANUARY, 1),
    LocalDate.of(2023, Month.JANUARY, 1));
System.out.print(d);
```
**✅ 先印 `P1Y`，再丟 `UnsupportedTemporalTypeException`**
- `Period` 適用 `LocalDate`。
- `Duration` 需要 time-based 物件（如 `LocalDateTime`），傳 `LocalDate` 會丟 `UnsupportedTemporalTypeException`。

---

### Q5. What is printed?
```java
var cities = new TreeSet<String>();
cities.add("Berlin"); cities.add("Amsterdam");
cities.add("Zurich"); cities.add("Madrid"); cities.add("Lisbon");
System.out.println(cities.headSet("Madrid"));
```
**✅ `[Amsterdam, Berlin, Lisbon]`**
`TreeSet` 依字母排序；`headSet("Madrid")` 回傳 **嚴格小於** `"Madrid"` 的元素。

---

### Q6. What is the output?
```java
try { throw new IllegalArgumentException(); }
catch (IllegalArgumentException e) { throw new RuntimeException(); }
finally { throw new NullPointerException(); }
```
**✅ `NullPointerException`**
`finally` 一定執行，`finally` 內再丟的例外**覆蓋**前面任何例外。

---

### Q7. Which records compile?（Choose two.）
```
A. record ARecord(int x) { int y; }
B. record BRecord(int x) { static int y; }
C. record CRecord(int x) extends RuntimeException {}
D. record DRecord(int x) implements Runnable { public void run() {} }
```
**✅ B and D**
- A 錯：record 不能加額外的 instance field。
- C 錯：record 隱式繼承 `java.lang.Record`，**不能 extends 類別**。
- B：static field 允許。
- D：record 可實作介面。

---

### Q8. What is printed?
```java
var count = 1;
do {
    System.out.print(count + " ");
} while (count++ < 3);
```
**✅ `1 2 3`**
後置遞增 `count++` 以「目前值」做條件判斷後才遞增，所以迴圈跑到值 1、2、3。

---

### Q9. What is the output?
```java
Object value = 10L;
String result = switch (value) {
    case Integer i -> "int";
    case Long l    -> "long";
    case String s  -> "string";
    default        -> "unknown";
};
System.out.println(result);
```
**✅ `long`**
`10L` 的型別是 `Long`。switch 的 pattern matching 選第一個符合的 case → `case Long l` 命中。

---

### Q10. What is printed?
```java
public class Demo implements AutoCloseable {
    public static void main(String[] args) {
        try (Demo d = new Demo()) {
            System.out.print("start ");
            throw new Exception();
        } catch (Exception e) {
            System.out.print("catch ");
        }
    }
    public void close() throws Exception {
        System.out.print("close ");
        throw new RuntimeException();
    }
}
```
**✅ `start close catch`**
`try` 拋例外後自動呼叫 `close()`；`close()` 內丟的 `RuntimeException` 被**隱藏（suppressed）**。原本的例外隨後被 `catch`，印出 `"catch "`。

---

## 七、重點概念速記

- **`var`**：需有 initializer、不能從 `null` 推斷、array 需 `new`、不能當欄位/method 參數/回傳型別。
- **Sealed class**：子類別必須為 `final`／`sealed`／`non-sealed`；`permits` 子句不可省略於需受控的情境。
- **Record**：不能加 instance field、不能 extends 類別、可實作介面、可含 static field。
- **Period vs Duration**：`Period`（日期）用 `LocalDate`；`Duration`（時間）用 time-based 型別。
- **例外覆蓋規則**：`finally` 丟出的例外會覆蓋之前所有例外；try-with-resources 中 `close()` 的例外成為 suppressed exception。
- **TreeSet headSet**(to)/tailSet(from) 回傳嚴格小於/大於的部分。
- **Compact Number Format**：`getCompactNumberInstance(locale, Style.SHORT/LONG)`。

---

## 備考資源連結
- 練習測驗首頁：https://javainuse.com/cert/1z0830
- 練習測驗：https://javainuse.com/cert/1z0830/quiz（Test 1–5）
- 主題筆記：https://javainuse.com/cert/1z0830/prep