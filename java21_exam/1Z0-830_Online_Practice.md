# 1Z0-830 Java SE 21 線上考古題彙整（網路來源）

> **聲明**：以下題目擷取自兩個免費線上練習網站（Mastery Exam Prep 與 Cert Empire）。這些是**練習題（practice questions）**，並非 Oracle 官方或正式考試的考古題 dump。答案與講解係轉錄自網站原始內容，**僅供學習參考**。建議自行驗證答案，並以 Oracle 官方考試指南（Exam Blueprint）與官方文件為最終依據。

---

## 目錄

- [Section 1：Mastery Exam Prep（50 題自由練習）](#section-1mastery-exam-prep50-題自由練習)
- [Section 2：Cert Empire（自由練習題）](#section-2cert-empire自由練習題)

---

# Section 1：Mastery Exam Prep（50 題自由練習）

> 原始頁面：Mastery Exam Prep — Free Java 21 1Z0-830 Practice Exam
> 共 50 題，涵蓋全 exam domains。題目依「Question N / Topic: / Options / Best answer / Explanation」格式整理如下。

---

### Question 1

**Topic:** Working with Streams and Lambda Expressions

**題目：**
A developer is troubleshooting why an audit list remains empty. They expected one checked … entry per input value.

```java
var audit = new ArrayList<String>();

var pipeline = List.of("red", "blue", "green").stream()
    .filter(s -> {
        audit.add("checked " + s);
        return s.length() > 3;
    })
    .map(String::toUpperCase);

System.out.println(audit);
```

The program prints `[]`. Which is the best cause or next fix?

**Options:**
- **A.** Use `parallelStream()` so operations run eagerly.
- **B.** Call `pipeline.close()` before printing audit.
- **C.** Call `pipeline.toList()` before printing audit.
- **D.** Replace `filter()` with `peek()` for auditing.

**Best answer: C**

**Explanation（重點翻譯）：**
串流管線（pipeline）只是「被建構」而未被「執行」。`filter()` 與 `map()` 都是 intermediate operation（中間操作），具 **lazy（延遲）** 特性，必須等終端操作（terminal operation，如 `toList()`、`forEach()`、`count()`、`reduce()`）被呼叫後才會真正遍歷來源資料。此處在 `System.out.println(audit)` 之前沒有呼叫任何終端操作，因此 `filter()` 的 lambda 從未執行，清單維持為空。修正方式是在印出 `audit` 前先呼叫 `pipeline.toList()`。使用 `peek()` 無法解決，因為 `peek()` 同樣是 lazy 的中間操作。

---

### Question 2

**Topic:** Handling Date, Time, Text, Numeric, and Boolean Values

**題目：**
A payroll method stores amounts in cents. The business rule is: first add `baseCents` and `overtimeCents`, then return 10% of that combined amount using integer arithmetic. Which replacement for the return statement best fixes the defect?

```java
class Payroll {
    static int bonusCents(int baseCents, int overtimeCents) {
        return baseCents + overtimeCents * 10 / 100;
    }
}
```

**Options:**
- **A.** `return baseCents + overtimeCents * (10 / 100);`
- **B.** `return (baseCents + overtimeCents) * 10 / 100;`
- **C.** `return baseCents + overtimeCents * 10 / 100;`
- **D.** `return (baseCents + overtimeCents * 10) / 100;`

**Best answer: B**

**Explanation（重點翻譯）：**
Java 中 `*` 與 `/` 的優先權高於 `+`。若要對「加總後的合計」套用百分比，必須以括號先將 `baseCents + overtimeCents` 括起。原式 `baseCents + overtimeCents * 10 / 100` 只對 `overtimeCents` 套用百分比。選項 A 的 `10 / 100` 在整數除法下等於 0，overtime 項目會完全失去貢獻。

---

### Question 3

**Topic:** Controlling Program Flow

**題目：**
A developer is reviewing a boundary case where the source array may be empty. Assume the code compiles. Which result correctly applies Java SE 21 loop execution rules?

```java
public class Demo {
    public static void main(String[] args) {
        int[] nums = {};
        int a = 0, b = 0, c = 0, d = 0;

        while (a < nums.length) a += 10;
        do { b++; } while (b < nums.length);

        for (int i = 0; i < 3; i++) {
            if (i == 1) continue;
            c += i;
        }
        for (int n : nums) d += n;

        System.out.print(a + ":" + b + ":" + c + ":" + d);
    }
}
```

**Options:**
- **A.** The output is 0:1:3:0.
- **B.** The output is 0:0:2:0.
- **C.** The output is 0:1:2:0.
- **D.** The output is 10:1:2:0.

**Best answer: C**

**Explanation（重點翻譯）：**
這是空陣列的迴圈邊界案例。`while` 是先檢查條件再執行（pre-test）；`do-while` 是先執行 body 再檢查條件（post-test）。因此 `a` 維持 0（`0 < 0` 為 false），而 `b` 先變成 1 後檢查、停止。基本 `for` 迴圈在 `i == 1` 時由 `continue` 跳過，只加 0 與 2。對空陣列的 enhanced for 沒有迭代，`d` 維持 0。輸出為 `0:1:2:0`。

---

### Question 4

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
A developer wants the no-argument constructor to reuse the one-argument constructor before printing A0.

```java
class Report {
    Report() { System.out.print("R0 "); }
    Report(String name) { System.out.print("R1 "); }
}

class AuditReport extends Report {
    AuditReport() {
        // INSERT
        System.out.print("A0 ");
    }
    AuditReport(String name) {
        super(name);
        System.out.print("A1 ");
    }
}
```

Which replacement for `// INSERT` compiles and makes `new AuditReport()` print `R1 A1 A0` ?

**Options:**
- **A.** `super("daily");`
- **B.** `this("daily");`
- **C.** `System.out.print("start "); this("daily");`
- **D.** `this("daily"); super("daily");`

**Best answer: B**

**Explanation（重點翻譯）：**
無參數建構子必須委派給 `AuditReport(String)`，而非直接呼叫 `Report(String)`。在 Java 中，`this(...)` 或 `super(...)` 必須是建構子**第一個語句**，且兩者只能擇一。`this("daily")` 會呼叫同類別的一參數建構子（其內部再呼叫 `super(name)`），回到無參數建構子後印出 A0，產生 `R1 A1 A0` 的順序。若 `this(...)` 之前有任何語句即為非法。

---

### Question 5

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
Which statement correctly describes normalization in a Java 21 compact constructor for a record class?

**Options:**
- **A.** Modify accessor return values to normalize stored state.
- **B.** Assign `this.component` directly for each component.
- **C.** Declare new mutable fields for normalized components.
- **D.** Reassign component parameters; implicit field assignment follows.

**Best answer: D**

**Explanation（重點翻譯）：**
Compact constructor 用於 record 欄位初始化前的驗證與正規化。可在 compact constructor 中重新指派隱式的 component 參數（例如 `name = name.strip();`），compiler 會在此後自動將這些參數指派給 record 的 `private final` component 欄位。不允許直接做 `this.name = ...`（因為 component 欄位由 canonical constructor 管理且為 final）。關鍵是「參數正規化」而非「欄位直接變更」。

---

### Question 6

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
A monitoring app needs an enum `Priority` whose constants each store an `int` level and whose instances support `boolean isUrgent()`. Which declaration correctly applies Java SE 21 enum rules?

**Options:**
- **A.**
```java
enum Priority {
private final int level;
LOW(1), MEDIUM(2), HIGH(3);Priority(int level) { this.level = level; }boolean isUrgent() { return level >= 3; }
}
```
- **B.**
```java
enum Priority {
    LOW(1), MEDIUM(2), HIGH(3);

    private final int level;

    public Priority(int level) { this.level = level; }

    boolean isUrgent() { return level >= 3; }
}
```
- **C.**
```java
enum Priority {
LOW, MEDIUM, HIGH;private final int level;Priority(int level) { this.level = level; }boolean isUrgent() { return level >= 3; }
}
```
- **D.**
```java
enum Priority {
    LOW(1), MEDIUM(2), HIGH(3);

    private final int level;

    Priority(int level) { this.level = level; }

    boolean isUrgent() { return level >= 3; }
}
```

**Best answer: D**

**Explanation（重點翻譯）：**
Enum 常數必須宣告在欄位、建構子與方法**之前**。當常數帶有參數時，需有相符簽章的 enum 建構子來初始化 instance 欄位。該建構子**不能宣告為 public 或 protected**；不加存取修飾詞時隱式為 private。因此 D 正確：常數在前、欄位由建構子初始化、`isUrgent()` 讀取欄位。

---

### Question 7

**Topic:** Working with Streams and Lambda Expressions

**題目：**
What is the result of compiling and running this code?

```java
import java.util.*;
import java.util.stream.*;

record Sale(String region, int units) {}

public class Main {
    public static void main(String[] args) {
        var sales = List.of(new Sale("west", 5),
                new Sale("east", 2), new Sale("west", 3));
        var stats = sales.stream().collect(Collectors.groupingBy(
                Sale::region, TreeMap::new,
                Collectors.summarizingInt(Sale::units)));
        var report = stats.entrySet().stream()
                .map(e -> e.getKey() + "=" + e.getValue().getCount()
                        + "/" + e.getValue().getSum())
                .collect(Collectors.joining(","));
        System.out.println(report);
    }
}
```

**Options:**
- **A.** Compilation fails because `summarizingInt()` cannot be downstream of `groupingBy()`.
- **B.** It prints `west=2/8,east=1/2`.
- **C.** It prints `east=1/2,west=2/8`.
- **D.** It prints `east=1/2,west=1/5`.

**Best answer: C**

**Explanation（重點翻譯）：**
使用三參數 `groupingBy`（classifier + map factory + downstream collector）。map factory 指定 `TreeMap::new`，結果依 key 排序（east 在 west 之前）。`summarizingInt` 為每個 region 產生 `IntSummaryStatistics`。east 群有一個銷售共 2 單位；west 群有兩個銷售共 8 單位。`joining(",")` 依 TreeMap 的 encounter order 串接，輸出 `east=1/2,west=2/8`。

---

### Question 8

**Topic:** Working with Arrays and Collections

**題目：**
A service keeps a mutable list internally, but its `names()` method must return a snapshot that callers cannot modify. Elements are guaranteed non-null.

```java
class Registry {
    private final List<String> names = new ArrayList<>();

    void add(String name) { names.add(name); }

    List<String> names() {
        return Collections.unmodifiableList(names);
    }
}
```

Which replacement for `names()` is the best fix?

**Options:**
- **A.** `return names;`
- **B.** `return Arrays.asList(names.toArray(String[]::new));`
- **C.** `return Collections.unmodifiableList(names);`
- **D.** `return List.copyOf(names);`

**Best answer: D**

**Explanation（重點翻譯）：**
`Collections.unmodifiableList()` 雖然阻擋透過回傳參照來修改，但它是 **view-backed**：內部 `names` 的後續變更仍會反映在先前回傳的清單中。`List.copyOf(names)` 會建立一份**不可變的副本**，同時滿足「呼叫者無法修改」與「不觀測內部後續變更」兩個需求。由於題目保證元素 non-null，`List.copyOf()` 是最合適的 Java 21 修正。

---

### Question 9

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
A developer is choosing a replacement for the comment. Which replacement both compiles and prints `fixed`?

```java
class Account {
    private int cents = 25;
    int cents() { return cents; }
}
class Demo {
    static void audit(long value) { System.out.print("fixed"); }
    static void audit(Integer... values) { System.out.print("varargs"); }
    public static void main(String[] args) {
        // insert code here
    }
}
```

**Options:**
- **A.** `var a = new Account(); var c; c = a.cents(); audit(c);`
- **B.** `var a = new Account(); { var c = a.cents(); } audit(c);`
- **C.** `var a = new Account(); var c = a.cents(); audit(c);`
- **D.** `var a = new Account(); audit(a.cents);`

**Best answer: C**

**Explanation（重點翻譯）：**
`var` 需要「有 initializer」的宣告才能推斷型別；`c` 推斷為 `int`。`cents` 欄位是 private，必須透過 method `cents()` 取得。區域變數若宣告在巢狀 block 內，block 結束後即不可見。重載解析時，固定參數方法（fixed-arity）優先於 varargs 方法；`int` 透過 **widening** 轉為 `long` 會選擇 `audit(long)`。

---

### Question 10

**Topic:** Using Java I/O API

**題目：**
For `java.nio.file.Path` in Java 21, which statement is a correct NIO.2 rule?

**Options:**
- **A.** `path.normalize()` checks the file system before removing `.` and `..`.
- **B.** `base.resolve(other)` returns `other` when `other` is absolute.
- **C.** `path.toAbsolutePath()` also normalizes the path automatically.
- **D.** `Path.of("/").getFileName()` returns the root path.

**Best answer: B**

**Explanation（重點翻譯）：**
`Path.resolve` 對絕對路徑參數有特定規則：**absolute path wins**——若參數是絕對路徑，結果直接回傳該參數。`normalize()` 是詞法（lexical）操作，不會檢查檔案系統。`toAbsolutePath()` 不等於 `normalize()`。只有 root 的 path 沒有 name element，`getFileName()` 回傳 `null`（`getRoot()` 才回傳 root）。

---

### Question 11

**Topic:** Logging API and Standard Annotations

**題目：**
A Java SE 21 utility uses `java.util.logging.Logger`. In a catch block, it must create a warning log record whose message is `Load failed` and whose `Throwable` is stored on the `LogRecord`, not merely appended to the text. Which comparison correctly identifies the appropriate logging call?

**Options:**
- **A.** `logger.log(Level.WARNING, "Load failed " + ex)` records the same throwable metadata.
- **B.** `logger.warning("Load failed", ex)` records the throwable separately.
- **C.** `logger.log(Level.WARNING, "Load failed", ex)` records the throwable separately.
- **D.** `logger.throwing("Loader", "load", ex)` creates a warning message `Load failed`.

**Best answer: C**

**Explanation（重點翻譯）：**
`Logger.log(Level, String, Throwable)` 的多載可將例外物件附加到 log record 的 thrown 欄位，供 handler 或 formatter 辨識。字串串接只會呼叫 `toString()`，喪失例外 metadata。`warning(String)` 沒有接受 throwable 的兩參數多載。`throwing(...)` 用於追蹤方法結束的例外，屬 FINER 層級，非 warning message。

---

### Question 12

**Topic:** Working with Arrays and Collections

**題目：**
A report component fails to compile in Java 21:

```java
import java.util.*;

class ReportLoader {
    void load(List<String> keys)  { }
    void load(List<Integer> keys) { }
}
```

Callers must keep one method name, and the API may add one argument. The new API should reject mismatched element declarations at compile time and choose behavior even when the list is empty. Which refactor is the best fix?

**Options:**
- **A.** Dispatch with `keys instanceof List<String>` inside `load(List<?> keys)`.
- **B.** Overload `load(List<String>[] keys)` and `load(List<Integer>[] keys)`.
- **C.** Overload `load(List<? extends CharSequence>)` and `load(List<? extends Number>)`.
- **D.** Use `<T> void load(List<T> keys, Class<T> elementType)`.

**Best answer: D**

**Explanation（重點翻譯）：**
Java 的 generic type arguments 會被 **erasure（型別抹除）**。`List<String>` 與 `List<Integer>` 在 runtime 都會 erase 成 `List`，因此無法做為不同重載方法。`Class<T>` token 是可具體化（reifiable）的 runtime 資訊；`<T> void load(List<T> keys, Class<T> elementType)` 同時讓 list 與 token 的型別對齊，也適用於空 list。`instanceof List<String>` 無效，因為 `List<String>` 非 reifiable。

---

### Question 13

**Topic:** Controlling Program Flow

**題目：**
A service processes groups of SKUs. A blank SKU invalidates only the current order: the code should stop checking that order, skip `submit(order)`, and then continue with the next order.

```java
void process(List<List<String>> orders) {
    for (var order : orders) {
        for (var sku : order) {
            if (sku.isBlank()) {
                continue; // defect
            }
            reserve(sku);
        }
        submit(order);
    }
}
```

Which refactor is the simplest valid fix?

**Options:**
- **A.** Label the outer loop and use `continue orderLoop;`.
- **B.** Replace the defect line with `break;`.
- **C.** Label the outer loop and use `break orderLoop;`.
- **D.** Move `submit(order)` inside the inner loop.

**Best answer: A**

**Explanation（重點翻譯）：**
需求是：捨棄目前外層迴圈的這次迭代，但繼續處理後續訂單。內層的 unlabeled `continue` 只跳過目前 SKU。**Labeled continue** 可目標指向外層迴圈，結束該外層迭代並跳到下一次，同時略過 `submit(order)`。`break`（無論是否 labeled）不是這個需求的答案：unlabeled break 只跳出內層，label break 會終止所有訂單處理。

---

### Question 14

**Topic:** Managing Concurrent Code Execution

**題目：**
A service method must update stock only if it can obtain a `ReentrantLock` immediately. If the lock is unavailable, it must return -1 without waiting. If it obtains the lock, it must release it even if the update logic later throws an unchecked exception. Which method body correctly applies the Java SE 21 lock rule?

```java
class Inventory {
    private final java.util.concurrent.locks.Lock lock =
        new java.util.concurrent.locks.ReentrantLock();
    private int stock = 10;

    int sell(int n) {
        // choose replacement
    }
}
```

**Options:**
- **A.**
```java
try {
if (!lock.tryLock()) return -1;
stock -= n;
return stock;
} finally {
lock.unlock();
}
```
- **B.**
```java
if (lock.tryLock()) {
    stock -= n;
    return stock;
}
return -1;
```
- **C.**
```java
lock.lock();
try {
stock -= n;
return stock;
} finally {
lock.unlock();
}
```
- **D.**
```java
if (!lock.tryLock()) return -1;
try {
    stock -= n;
    return stock;
} finally {
    lock.unlock();
}
```

**Best answer: D**

**Explanation（重點翻譯）：**
`tryLock()` 會立即嘗試取得鎖，若無法取得立即回傳 false。**只有在確認取得鎖之後**，才進入 try/finally 區塊並在 finally 中呼叫 `unlock()`。若 `tryLock()` 回傳 false，方法應直接回傳 -1 而不呼叫 `unlock()`（呼叫未持有的鎖會丟 `IllegalMonitorStateException`）。選項 A 在 `tryLock()` 失敗時仍會執行 finally 的 `unlock()` 而出錯；選項 B 未釋放鎖；選項 C 使用 `lock()` 會等待而不符合需求。

---

### Question 15

**Topic:** Using Java I/O API

**題目：**
A utility must count all `.log` files under root, including nested directories. A review flags this Java 21 method for potentially keeping directory resources open longer than necessary.

```java
long countLogs(Path root) throws IOException {
    return Files.walk(root)
            .filter(Files::isRegularFile)
            .filter(p -> p.toString().endsWith(".log"))
            .count();
}
```

Which refactor is the best fix?

**Options:**
- **A.** Replace `Files.walk(root)` with `Files.list(root)` and keep the pipeline.
- **B.** Add `.onClose(() -> {})` to the pipeline and leave it otherwise unchanged.
- **C.** Wrap `Files.walk(root)` in try-with-resources and run `count()` inside it.
- **D.** Replace it with `Files.find(...)` because that stream closes automatically.

**Best answer: C**

**Explanation（重點翻譯）：**
`Files.walk` 回傳 **lazy** 的 `Stream<Path>`，在遍歷期間可能持有目錄資源。終端操作 `count()` **不會**自動關閉該 stream。正確修正是用 **try-with-resources** 包住：

```java
try (Stream<Path> paths = Files.walk(root)) {
    return paths
            .filter(Files::isRegularFile)
            .filter(p -> p.toString().endsWith(".log"))
            .count();
}
```

其它的 traversal 方法（`Files.list`、`Files.find`）同樣需要自行關閉。

---

### Question 16

**Topic:** Working with Streams and Lambda Expressions

**題目：**
A batch job must process order numbers 100 through 104, including both endpoints, as primitive `int` values before a terminal operation such as `sum()`. Which declaration correctly creates the required stream?

**Options:**
- **A.** `IntStream orderNos = IntStream.rangeClosed(100, 104);`
- **B.** `IntStream orderNos = IntStream.range(100, 104);`
- **C.** `IntStream orderNos = Stream.of(100, 101, 102, 103, 104);`
- **D.** `Stream<Integer> orderNos = IntStream.rangeClosed(100, 104);`

**Best answer: A**

**Explanation（重點翻譯）：**
題目要求 **primitive int** 且**含含端點** 100~104。`IntStream.rangeClosed(100, 104)` 包含上界，符合需求。`range` 排除上界。`Stream.of(...)` 建立的是 `Stream<Integer>`（reference stream，需要 boxing）。`IntStream` 也無法直接指派給 `Stream<Integer>`。

---

### Question 17

**Topic:** Logging API and Standard Annotations

**題目：**
A developer is refactoring a subclass and wants the compiler to reject an accidental overload when the intent is to **override** the superclass method.

```java
class Base {
    void audit(Object value) { }
}

class Child extends Base {
    void audit(String value) { }
}
```

Which annotation use best matches this intent?

**Options:**
- **A.** Annotate `Base.audit(Object)` with `@Deprecated`.
- **B.** Annotate `Child` with `@FunctionalInterface`.
- **C.** Annotate `Child.audit(String)` with `@Override`.
- **D.** Annotate `Child.audit(String)` with `@SuppressWarnings`.

**Best answer: C**

**Explanation（重點翻譯）：**
`snipper` 中 `audit(String)` 其實是 **overload（重載）** `audit(Object)`，而非 override（參數型別從 Object 改成 String）。加上 `@Override` 後，compiler 會驗證是否真的在覆寫；若不是，compilation 失敗，正好在重構時暴露此錯誤。`@Deprecated` 標記 API 已不建議使用、`@SuppressWarnings` 隱藏警告、`@FunctionalInterface` 驗證單一抽象方法，都不會檢查覆寫意圖。

---

### Question 18

**Topic:** Handling Exceptions

**題目：**
A team is troubleshooting why a test reports close failures in an unexpected order. The code compiles and prints the shown output:

```java
class R implements AutoCloseable {
    private final String id;
    R(String id) { this.id = id; }
    public void close() { throw new IllegalStateException("close " + id); }
}

public class Test {
    public static void main(String[] args) {
        try (var a = new R("A"); var b = new R("B")) {
            throw new RuntimeException("work");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            for (var s : e.getSuppressed()) System.out.println(s.getMessage());
        }
    }
}
```

Output:
```
work
close B
close A
```

Which explanation best identifies the cause?

**Options:**
- **A.** The body exception is primary; resources close in reverse order.
- **B.** Close failures are ignored when the try block throws first.
- **C.** The last close failure replaces the exception from the try block.
- **D.** Resources close in declaration order, so a closes before b.

**Best answer: A**

**Explanation（重點翻譯）：**
try-with-resources 在 try block 結束後，會**以宣告的相反順序**自動關閉資源（b 先關、a 後關）。try block 丟出的例外是 **primary exception**；關閉資源時丟出的例外會被加到主例外的 **suppressed exceptions** 清單中。因此 `work` 先被印出（primary），接著印出 `close B`、`close A`（依照 suppressed 順序）。

---

### Question 19

**Topic:** Packaging and Deploying Java Code

**題目：**
A team is migrating an application to JPMS in Java 21. The application must remain a named module, but it uses a legacy JAR, `validator-2.0.jar`, that has no `module-info.class`. Its manifest contains `Automatic-Module-Name: com.vendor.validator`.

```java
module com.acme.orders {
    exports com.acme.orders.api;
}
```

The build currently places `com.acme.orders` on the module path and `validator-2.0.jar` on the class path. Code in `com.acme.orders` imports `com.vendor.validation.Validator`. What is the best fix?

**Options:**
- **A.** Move the JAR to the module path and add `requires validator;`.
- **B.** Keep the JAR on the class path and add `requires com.vendor.validator;`.
- **C.** Add `exports com.vendor.validation;` to `com.acme.orders`.
- **D.** Move the JAR to the module path and add `requires com.vendor.validator;`.

**Best answer: D**

**Explanation（重點翻譯）：**
Named module **無法**讀取 class path 上的 unnamed module 類別。把沒有 `module-info.class` 的 JAR 放到 module path，它會成為 **automatic module**（自動模組），manifest 中的 `Automatic-Module-Name` 提供了 module name 供 `requires` 使用。因此要將 JAR 移到 module path 並在 `com.acme.orders` 中宣告 `requires com.vendor.validator;`。module 只能 export 自己的套件，不能 export 依賴項的套件。

---

### Question 20

**Topic:** Working with Arrays and Collections

**題目：**
In Java 21, consider this method signature:

```java
void copyInts(List<? extends Number> source,
              List<? super Integer> target) { ... }
```

Other than adding null, which statement describes calls that are type-safe at compile time?

**Options:**
- **A.** `Integer i = source.get(0);` and `target.add(Double.valueOf(1.0));`
- **B.** `Number n = source.get(0);` and `target.add(Integer.valueOf(1));`
- **C.** `source.add(Double.valueOf(1.0));` and `Number n = target.get(0);`
- **D.** `source.add(Integer.valueOf(1));` and `Integer i = target.get(0);`

**Best answer: B**

**Explanation（重點翻譯：**
這是 **PECS 規則：Producer extends, Consumer super**。對 `List<? extends Number>`，安全讀取為 `Number`（因為實際可能是 `List<Integer>`、`List<Double>` 等）；加入特定 Number 子型別不安全。對 `List<? super Integer>`，安全加入 `Integer`；讀取僅保證為 `Object`。因此 B 正確：從 source 讀取為 `Number`，對 target 加入 `Integer`。

---

### Question 21

**Topic:** Handling Date, Time, Text, Numeric, and Boolean Values

**題目：**
Which statement accurately describes how Java 21 converts text block source text into the resulting `String` content?

**Options:**
- **A.** Only indentation before the opening delimiter is removed.
- **B.** Escapes are interpreted before incidental indentation is stripped.
- **C.** Line terminators are normalized, indentation is stripped, then escapes are interpreted.
- **D.** Platform-specific line terminators are preserved exactly.

**Best answer: C**

**Explanation（重點翻譯：**
Text block 的轉換順序為：**先將 line terminators 正規化為 `\n`** → **移除 incidental indentation 與 trailing whitespace** → **最後才解釋 escape sequences**（如 `\s` 保留本來會被去除的空格）。此順序很重要：`\s` 可用來保留會被視為 trailing whitespace 而剝離的空格。

---

### Question 22

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
No imports are required. What is the result of running this Java 21 code?

```java
public class DispatchDemo {
    static class Base {
        String tag(Number n) { return "Base:Number"; }
        String tag(Integer i) { return "Base:Integer"; }
    }
    static class Derived extends Base {
        @Override
        String tag(Number n) { return "Derived:Number"; }
        String tag(Double d) { return "Derived:Double"; }
    }
    public static void main(String[] args) {
        Base ref = new Derived();
        Number value = Integer.valueOf(7);
        System.out.print(ref.tag(value));
    }
}
```

**Options:**
- **A.** It prints `Derived:Number`.
- **B.** It prints `Base:Number`.
- **C.** It does not compile.
- **D.** It prints `Base:Integer`.

**Best answer: A**

**Explanation（重點翻譯：**
這題結合 **overloading（重載）與 overriding（覆寫）**。重載解析在 **compile time** 以宣告型別進行：`ref` 的宣告型別是 `Base`，`value` 的宣告型別是 `Number`，故選定 `tag(Number)` 這個簽章。接著以 receiver 的 runtime 物件做多型派送：`ref` 實際是指向 `Derived` 實例，且 `Derived` 覆寫了 `tag(Number)`，因此執行 `Derived.tag(Number)` 印出 `Derived:Number`。參數的 runtime 型別（Integer）不會重新觸發重載解析。

---

### Question 23

**Topic:** Controlling Program Flow

**題目：**
A developer is reviewing this Java 21 code. Imports are not material.

```java
public class LoopReview {
    public static void main(String[] args) {
        int n = 0;
        while (n++ < 0) {
            System.out.print("W");
        }
        do {
            System.out.print(n);
        } while (n++ < 2);
        for (;;) {
            System.out.print("F");
            break;
        }
    }
}
```

What is the result?

**Options:**
- **A.** It prints `12F`.
- **B.** It does not compile because `for (;;)` has no condition.
- **C.** It prints `01F`.
- **D.** It prints `12F` forever.

**Best answer: A**

**Explanation（重點翻譯：**
`while` 先檢查條件：`n++ < 0` 在 n=0 時為 false（但 n 遞增為 1），因此 body 不執行。`do-while` 先執行 body 再檢查：先印 1，檢查 `1 < 2` true（n 變 2），再印 2，檢查 `2 < 2` false 停止。`for (;;)` 是合法的無限迴圈語法，但 body 中的 `break` 會在印出 F 後立刻結束迴圈。輸出為 `12F`。

---

### Question 24

**Topic:** Packaging and Deploying Java Code

**題目：**
A modular application uses `ServiceLoader` to find plug-ins. The provider module is on the module path and declares a valid `provides` directive.

```java
module com.acme.catalog.api {
    exports com.acme.catalog.spi;
}

module com.acme.catalog.app {
    requires com.acme.catalog.api;
}
```

Code in `com.acme.catalog.app` calls `ServiceLoader.load(PricePlugin.class)`, where `PricePlugin` is in `com.acme.catalog.spi`. At run time, it fails with `ServiceConfigurationError` stating that `com.acme.catalog.app` does not declare `uses`. Which `module-info` change is the best next fix?

**Options:**
- **A.** Add `opens com.acme.catalog.spi to com.acme.catalog.app;` to the API module.
- **B.** Export `com.acme.catalog.spi` only to `com.acme.catalog.app`.
- **C.** Change the app dependency to `requires transitive com.acme.catalog.api;`.
- **D.** Add `uses com.acme.catalog.spi.PricePlugin;` to `com.acme.catalog.app`.

**Best answer: D**

**Explanation（重點翻譯：**
在 named module 中，`ServiceLoader.load()` 要求 **consuming module** 明確宣告 `uses`，即使 service interface 的套件已 export 且可讀取。正確修正是在 `com.acme.catalog.app` 的 module-info 中加入：

```java
module com.acme.catalog.app {
    requires com.acme.catalog.api;
    uses com.acme.catalog.spi.PricePlugin;
}
```

`requires transitive` 是為了讓下游 module 取得可讀性，此處不需要。`opens` 用於反射存取，與 service consumption 無關。

---

### Question 25

**Topic:** Working with Streams and Lambda Expressions

**題目：**
A developer is comparing lambda expressions to pass into this method. Which replacement for `/* lambda */` is valid Java 21 syntax?

```java
import java.util.function.BiFunction;

class Demo {
    static void calculate(BiFunction<Integer, Integer, Integer> f) {
        System.out.println(f.apply(4, 5));
    }
    public static void main(String[] args) {
        calculate(/* lambda */);
    }
}
```

**Options:**
- **A.** `(Integer a, Integer b) -> { return a + b; }`
- **B.** `(Integer a, b) -> a + b`
- **C.** `(a, b) -> { a + b; }`
- **D.** `(a, int b) -> a + b`

**Best answer: A**

**Explanation（重點翻譯：**
Lambda 參數要嘛**全部顯式型別**，要嘛**全部 inferred**，不能混用。目標型別是 `BiFunction<Integer, Integer, Integer>`（非 void 回傳）。區塊 body 必須用 `return` 提供值。A 的 fully typed lambda 搭配 `return` 符合所有條件。B 與 D 混用型別；C 的區塊 body `{ a + b; }` 沒有 `return`。

---

### Question 26

**Topic:** Managing Concurrent Code Execution

**題目：**
In Java 21, a program starts a virtual-thread worker with `Thread.startVirtualThread(...)`. The main thread must print a status line only after that worker's `Runnable` has finished, and the program must not depend on scheduler timing. Which API rule gives that lifecycle guarantee?

**Options:**
- **A.** Use `Thread.interrupt()`; it waits until the worker stops running.
- **B.** Use `Thread.sleep(long)`; it lets started workers finish before continuing.
- **C.** Use `Thread.yield()`; it hands execution to the worker deterministically.
- **D.** Use `Thread.join()`; when it returns normally, the worker has terminated.

**Best answer: D**

**Explanation（重點翻譯：**
`Thread.join()` 是保證 worker 完成的 lifecycle 操作。`Thread.startVirtualThread(...)` 回傳 `Thread` 物件；對其呼叫 `join()` 會讓呼叫執行緒等待目標執行緒終止。此規則同樣適用於 virtual threads。`sleep()` 只是延遲，無法證明 worker 已完成；`yield()` 只是 scheduler hint，不保證特定執行緒會被排程；`interrupt()` 是訊號，不會等待終止。

---

### Question 27

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
A team is designing `com.acme.model.Order` for use by code in `com.acme.app`, a different package. Client code must create orders only through a validating factory method and read the order id through the public API. The id must not be directly accessible or assignable outside `Order`. Which declaration set best supports these requirements?

**Options:**
- **A.** `public final class Order; private final String id; private Order(String id); public static Order of(String id); public String id()`
- **B.** `public final class Order; public final String id; private Order(String id); public static Order of(String id)`
- **C.** `public final class Order; private final String id; public Order(String id); public static Order of(String id); public String id()`
- **D.** `class Order; private final String id; private Order(String id); public static Order of(String id); public String id()`

**Best answer: A**

**Explanation（重點翻譯：**
跨套件使用時，top-level class 與預期的 API 方法必須為 `public`。封裝由 private state 欄位 + private constructor + public static factory method 維持。D 的 class 沒有 `public`，其他套件無法使用。B 的 `id` 是 public field，破壞封裝。C 的 `public Order(String id)` 允許呼叫者繞過 validating factory。

---

### Question 28

**Topic:** Managing Concurrent Code Execution

**題目：**
A service method was expected to print `CAT`, but it throws a `CompletionException` whose cause is a `RejectedExecutionException`. The team wants the uppercase transformation to remain executor-backed. What is the best fix?

```java
ExecutorService pool = Executors.newSingleThreadExecutor();
CompletableFuture<String> start = new CompletableFuture<>();

CompletableFuture<String> result =
    start.thenApplyAsync(String::toUpperCase, pool);

pool.shutdown();
start.complete("cat");

System.out.println(result.join());
```

**Options:**
- **A.** Replace `thenApplyAsync` with `thenApply`.
- **B.** Use `Executors.newVirtualThreadPerTaskExecutor()`.
- **C.** Replace `result.join()` with `result.get()`.
- **D.** Move `pool.shutdown()` until after `result.join()` completes.

**Best answer: D**

**Explanation（重點翻譯：**
`thenApplyAsync(..., pool)` 會在 `start` 完成時才將 transformation 派送到 pool。此處在 `start.complete("cat")` **之前**就呼叫 `pool.shutdown()`，導致相依任務被拒絕（`RejectedExecutionException`）。修正方式是把 `pool.shutdown()` 延後到 `result.join()` **完成之後**。換執行緒型別或改用非 async 方法都無法修正「太早關閉 executor」這個根本問題。

---

### Question 29

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
Given this Java 21 code, what is the result?

```java
interface Left { default String tag() { return "L"; } }
interface Right { default String tag() { return "R"; } }
class Parent { public String tag() { return "P"; } }
class Child extends Parent implements Left, Right { }

public class Test {
    public static void main(String[] args) {
        System.out.print(new Child().tag());
    }
}
```

**Options:**
- **A.** It compiles and prints `L`.
- **B.** It fails because both interfaces provide `tag()`.
- **C.** It fails unless `Child` overrides `tag()`.
- **D.** It compiles and prints `P`.

**Best answer: D**

**Explanation（重點翻譯：**
Java 規則為「**classes win**」：若 class 從 superclass 繼承了 concretic instance method，該方法在衝突解析中優先於 interface 的 default methods。`Child extends Parent implements Left, Right`，繼承了 `Parent.tag()`，因此不需覆寫即可編譯與執行，輸出為 `P`。

---

### Question 30

**Topic:** Handling Date, Time, Text, Numeric, and Boolean Values

**題目：**
A team is troubleshooting this Java 21 code. It compiles and prints `2025-03-10:0:0`, but the developer expected `2025-03-18:8:8`. What is the best cause or next fix?

```java
import java.time.*;
import java.time.temporal.ChronoUnit;

public class Plan {
    public static void main(String[] args) {
        var start = LocalDate.of(2025, 3, 10);
        var target = start;
        target.plusDays(5);
        target.withDayOfMonth(20);
        target.minusDays(2);
        System.out.print(target + ":");
        System.out.print(ChronoUnit.DAYS.between(start, target) + ":");
        System.out.print(start.until(target, ChronoUnit.DAYS));
    }
}
```

**Options:**
- **A.** Assign or chain the returned `LocalDate` values.
- **B.** Replace both day calculations with `Period.between`.
- **C.** Attach the system default `ZoneId` before comparing.
- **D.** Call `until` before `between` to avoid consuming `target`.

**Best answer: A**

**Explanation（重點翻譯：**
**`LocalDate` 是不可變（immutable）**。`plusDays`、`minusDays`、`withDayOfMonth` 都回傳**調整後的新物件**，而非修改原物件。此處回傳值被忽略，`target` 仍是 `2025-03-10`。修正：`target = target.plusDays(5).withDayOfMonth(20).minusDays(2);` 使其成為 2025-03-18，產生 8 天差異。`between` 與 `until` 都是唯讀計算，不會消耗或修改日期。

---

### Question 31

**Topic:** Packaging and Deploying Java Code

**題目：**
A team is migrating an application to JPMS. `com.store.app` is an explicit named module launched from the module path. `billing-api.jar` has no module descriptor, has `Automatic-Module-Name: billing.api`, and is on the module path. `legacy-util.jar` has no descriptor and remains on the class path; only `billing-api.jar` uses it internally. Which entry correctly belongs in `com.store.app`'s module declaration?

**Options:**
- **A.** `requires ALL-UNNAMED;`
- **B.** `requires billing.api;`
- **C.** `requires legacy.util;`
- **D.** Omit `requires` because descriptorless JARs are unreadable.

**Best answer: B**

**Explanation（重點翻譯：**
`billing-api.jar` 因為在 module path 上且無 descriptor，會成為 **automatic module**，其 module name 來自 `Automatic-Module-Name: billing.api`。explicit named module `com.store.app` 可以 `requires billing.api;`。`legacy-util.jar` 在 class path 上屬於 unnamed module，無法用 `requires` 宣告。`ALL-UNNAMED` 不是 module-info.java 中的合法 module name。

---

### Question 32

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
A team changes a value type into a record but keeps an older subclass. The code now fails with `error: cannot inherit from final Box`.

```java
interface Shippable {
    int weight();
}

record Box(int weight) implements Shippable { }

class GiftBox extends Box {
    GiftBox(int weight) {
        super(weight);
    }
}
```

The team wants both types to be usable through `Shippable`. Which fix best addresses the cause?

**Options:**
- **A.** Make `GiftBox` implement `Shippable` and define `weight()`.
- **B.** Add a protected no-argument constructor to `Box`.
- **C.** Declare `Box` as an abstract record.
- **D.** Remove `implements Shippable` because records cannot implement interfaces.

**Best answer: A**

**Explanation（重點翻譯：**
Record 是 **implicitly final**，不能被子類別繼承，無法用「繼承 Box」的方式建立 `GiftBox`。但 record **可以實作介面**，其 component accessor（`weight()`）可滿足介面方法。正確作法是讓 `GiftBox` 自己實作 `Shippable` 並提供 `weight()`。Records 不能做成 abstract；records 確實可以實作介面。

---

### Question 33

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
A utility method should return the stripped length only when `value` is a nonblank `String`; otherwise it should return 0. The current Java 21 code does not compile.

```java
class TextUtil {
    static int normalizedLength(Object value) {
        if (value instanceof String s || !s.isBlank()) {
            return s.strip().length();
        }
        return 0;
    }
}
```

Which refactor is the best fix?

**Options:**
- **A.** Use `value instanceof String s && !s.isBlank()` in the if condition.
- **B.** Use `value instanceof String s || s.isBlank()` in the if condition.
- **C.** Cast first with `String s = (String) value;` before the if.
- **D.** Use `value instanceof var s && !s.isBlank()` in the if condition.

**Best answer: A**

**Explanation（重點翻譯：**
Type pattern（型別樣式）的 pattern variable 只在 compiler **能證明匹配成功**的作用域內可見。`&&` 只有在左側為 true 時才評估右側，因此 `value instanceof String s && !s.isBlank()` 中，`s` 在右側與 if body 中都安全可用。`||` 中右側可能在 `instanceof` 為 false 時被評估，`s` 不安全。選項 C 會對非 String 輸入拋 `ClassCastException`。`instanceof var s` 不是合法的 Java 21 語法。

---

### Question 34

**Topic:** Working with Streams and Lambda Expressions

**題目：**
An API review compares the results of the same predicate on an ordered list stream and on a stream explicitly marked unordered. Assume Java SE 21 stream semantics and do not rely on a specific implementation for unordered streams.

```java
var nums = List.of(2, 4, 6, 7, 8, 10);

var ot = nums.stream()
    .takeWhile(n -> n % 2 == 0).toList();
var ut = nums.stream().unordered()
    .takeWhile(n -> n % 2 == 0).toList();
var od = nums.stream()
    .dropWhile(n -> n % 2 == 0).toList();
var ud = nums.stream().unordered()
    .dropWhile(n -> n % 2 == 0).toList();
```

Which comparison is guaranteed?

**Options:**
- **A.** `ot` and `ut` are both `[2, 4, 6]`; `od` and `ud` are both `[7, 8, 10]`.
- **B.** `ut` may contain 7; `ud` may drop 7 because unordered streams ignore the predicate boundary.
- **C.** `ot` is `[2, 4, 6]`; `od` is `[7, 8, 10]`; `ut` may be a subset of evens and `ud` must retain 7.
- **D.** `ot` and `ut` contain all even values; `od` and `ud` contain only `[7]`.

**Best answer: C**

**Explanation（重點翻譯：**
Ordered stream 有定義的 prefix 行為：`takeWhile` 在 7 前停止（`ot` = [2,4,6]）；`dropWhile` 移除相符 prefix（`od` = [7,8,10]）。呼叫 `.unordered()` 後，Stream API 對 unordered stream 的 `takeWhile` 不再定義「第一個元素」邊界：結果可能是任何相符元素的**子集**；而 unordered `dropWhile` 可能丟棄任何相符子集，但**非相符元素（如 7）會被保留**。因此 C 正確。

---

### Question 35

**Topic:** Controlling Program Flow

**題目：**
A developer runs the following Java 21 code. Which output is produced?

```java
public class BranchTest {
    public static void main(String[] args) {
        int x = 4, y = 9;
        String r;
        if (x > 5) {
            r = "A";
        } else if (y < 10) {
            if (x + y > 13) {
                r = "B";
            } else if (y % x == 1) {
                r = "C";
            } else {
                r = "D";
            }
        } else {
            r = "E";
        }
        System.out.println(r);
    }
}
```

**Options:**
- **A.** E
- **B.** C
- **C.** D
- **D.** B

**Best answer: B**

**Explanation（重點翻譯：**
`x > 5` 為 false，進入 `y < 10`（true）。巢狀判斷：`x + y > 13` 即 `13 > 13` 為 false。接著 `y % x == 1` 即 `9 % 4 == 1` 為 true，指派並印出 `C`。關鍵是 `13 > 13` 並非 `>=`，不會通過。

---

### Question 36

**Topic:** Managing Concurrent Code Execution

**題目：**
No imports are required. What is the result of compiling and running this Java 21 program?

```java
public class StartRunDemo {
    public static void main(String[] args) throws InterruptedException {
        Thread.currentThread().setName("driver");
        Thread t = new Thread(() ->
            System.out.print(Thread.currentThread().getName() + " "),
            "worker");

        t.run();
        t.start();
        t.join();
        t.start();
    }
}
```

**Options:**
- **A.** It does not compile because `run()` cannot be invoked directly.
- **B.** It prints `worker worker `, then throws `IllegalThreadStateException`.
- **C.** It prints `driver worker `, then throws `IllegalThreadStateException`.
- **D.** It prints `driver worker worker` and terminates normally.

**Best answer: C**

**Explanation（重點翻譯：**
`t.run()` 直接呼叫只是**目前執行緒上的普通方法呼叫**（lambda 在 main thread 執行，名字為 `driver`）——並未啟動新執行緒。`t.start()` 才建立名為 `worker` 的新執行緒；`t.join()` 等待其完成。一個 `Thread` 物件**啟動後不能再啟動第二次**，即使它已終止，因此最後的 `t.start()` 會拋 `IllegalThreadStateException`。輸出順序：`driver worker ` 後拋例外。

---

### Question 37

**Topic:** Logging API and Standard Annotations

**題目：**
A reviewer is checking uses of `@Override`, `@FunctionalInterface`, `@Deprecated`, `@SuppressWarnings`, and `@SafeVarargs` in Java 21 code. Which rule is correct?

**Options:**
- **A.** `@Deprecated` prevents new source code from compiling against the annotated element.
- **B.** `@SafeVarargs` may annotate a varargs constructor or a varargs method that is `static`, `final`, or `private`.
- **C.** `@Override` is valid only when overriding a concrete superclass method.
- **D.** `@FunctionalInterface` disallows default and static methods in the annotated interface.

**Best answer: B**

**Explanation（重點翻譯：**
`@SafeVarargs` 用於標記對 varargs 參數不會執行不安全操作的示警抑制。Java 21 中它只能用於 **varargs constructor** 或 **static、final、private** 的 varargs 方法——因為這些宣告不能被覆寫，子類別無法用不安全的實作取代。`@Deprecated` 只是警告，不是編譯錯誤。`@Override` 也可用於實作介面方法。`@FunctionalInterface` 允許 default 與 static 方法（只要只有一個 abstract method）。

---

### Question 38

**Topic:** Logging API and Standard Annotations

**題目：**
A Java 21 application configures `java.util.logging` with no filters and parent handlers disabled:

```java
Logger logger = Logger.getLogger("app");
logger.setUseParentHandlers(false);
logger.setLevel(Level.INFO);

ConsoleHandler handler = new ConsoleHandler();
handler.setLevel(Level.WARNING);
logger.addHandler(handler);
```

For standard `Level` values, which log calls can this handler publish?

**Options:**
- **A.** `info()`, `warning()`, and `severe()`
- **B.** `info()` only
- **C.** `warning()` and `severe()` only
- **D.** All standard-level log calls

**Best answer: C**

**Explanation（重點翻譯：**
**Logger 的 Level 與每個 Handler 的 Level 都會被套用**。logger 先判斷 record 是否可 loggable，然後每個 handler 再套用自己的門檻。標準 Level 由 FINEST 到 SEVERE：`Level.INFO` 允許 INFO、WARNING、SEVERE；`Level.WARNING` 允許 WARNING、SEVERE。兩者交集為 **WARNING 與 SEVERE**，因此只有 `warning()` 與 `severe()` 可由 handler 發布。

---

### Question 39

**Topic:** Handling Date, Time, Text, Numeric, and Boolean Values

**題目：**
A test team runs this Java 21 program, but the question does not specify the machine's default time zone. What is the result?

```java
import java.time.*;

public class Stamp {
    public static void main(String[] args) {
        Instant stamp = Instant.parse("2025-03-30T00:30:00Z");
        LocalDate day = LocalDate.ofInstant(stamp, ZoneId.systemDefault());
        System.out.println(day);
    }
}
```

**Options:**
- **A.** It always prints `2025-03-29` because local dates are behind UTC.
- **B.** It does not compile because `ofInstant` requires a `ZoneOffset`.
- **C.** It compiles, but the printed date depends on the default time zone.
- **D.** It always prints `2025-03-30` because the `Instant` is UTC.

**Best answer: C**

**Explanation（重點翻譯：**
`Instant` 代表 UTC 上的一個時刻，但 `LocalDate.ofInstant(stamp, zone)` 需依 zone 將時刻轉成當地曆法日期。此處使用 `ZoneId.systemDefault()`（預設時區），因此**輸出取決於 JVM 預設時區**：在 UTC 以西可能為 3 月 29 日，在 UTC 或東方多數時區為 3 月 30 日。需要確定性結果時應指定明確的 `ZoneId`（如 `ZoneId.of("UTC")`）。

---

### Question 40

**Topic:** Implementing Localization

**題目：**
A reporting service receives an `Instant` and must produce a localized date-time string using `FormatStyle.LONG`. The output must use French language/conventions and the Europe/Paris civil time, regardless of the JVM defaults. Which formatter setup best satisfies this requirement before calling `format(instant)`?

**Options:**
- **A.** `ofLocalizedDateTime(LONG).withZone(ZoneId.of("Europe/Paris"))`
- **B.** `ofLocalizedDateTime(LONG).withLocale(Locale.FRANCE)`
- **C.** `ofPattern("dd MMMM uuuu HH:mm").withLocale(Locale.FRANCE)`
- **D.** `ofLocalizedDateTime(LONG).withLocale(Locale.FRANCE).withZone(ZoneId.of("Europe/Paris"))`

**Best answer: D**

**Explanation（重點翻譯：**
Localized date-time formatting 將 **presentation locale 與 time zone 分離**。`Locale.FRANCE` 控制語言與在地慣例（月份名稱、排序方式等）；`ZoneId.of("Europe/Paris")` 提供 `Instant` 轉成 civil time 所需的時區。兩者都必須設定，才能使輸出不受 JVM 預設值影響。A 只設 zone、B 只設 locale、C 的自訂 pattern 偏離了 `FormatStyle.LONG` 需求。

---

### Question 41

**Topic:** Packaging and Deploying Java Code

**題目：**
A migration team is compiling `app` as a named module. `util-api.jar` has no `module-info.class`, contains `public class util.Tool`, is on the module path, and has `Automatic-Module-Name: util.api`. `legacy.jar` has no `module-info.class`, contains `public class legacy.Helper`, and is on the class path.

What is the compile-time result?

```java
/* src/app/module-info.java */
module app {
    requires util.api;
}

/* src/app/demo/Main.java */
package demo;

import util.Tool;
import legacy.Helper;

public class Main {
    public static void main(String[] args) {
        System.out.print(Tool.name() + Helper.name());
    }
}
```

**Options:**
- **A.** Compilation succeeds and the program prints both names.
- **B.** Compilation fails because `app` cannot read the unnamed module.
- **C.** Compilation fails because automatic modules cannot be required.
- **D.** Compilation succeeds, but running throws `NoClassDefFoundError`.

**Best answer: B**

**Explanation（重點翻譯：**
`util-api.jar` 在 module path 上成為 automatic module，`requires util.api;` 合法。但 `legacy.jar` 在 class path 上屬 **unnamed module**；explicit named module `app` **不能讀取 unnamed module**。因此 `import legacy.Helper;` 導致 compilation 失敗——是在編譯期就失敗，並非 runtime class-loading 錯誤。`requires util.api` 合法，automatic module 可被 required，故此題答案為 B。

---

### Question 42

**Topic:** Using Java I/O API

**題目：**
A method receives a `BufferedReader br` and a `Writer out`. The input contains at least five characters, and no mark has been set before the fragment starts. The method must read the first character into `first`, reset to the beginning, skip the first five characters, transfer the remaining characters to `out`, and flush the destination. The method declares `throws IOException`. Which fragment is valid Java SE 21 and meets the goal?

**Options:**
- **A.** `br.mark(10); int first = br.read(); br.reset(); br.skip(5); br.transferTo(out); out.flush();`
- **B.** `br.mark(10); int first = br.read(); br.reset(); out.skip(5); out.transferTo(br); br.flush();`
- **C.** `int first = br.read(); br.reset(); br.skip(5); br.transferTo(out); out.flush();`
- **D.** `br.mark(10); int first = br.read(); br.skip(5); br.reset(); br.transferTo(out); out.flush();`

**Best answer: A**

**Explanation（重點翻譯：**
`mark()`、`read()`、`skip()`、`reset()` 都是 **Reader** 層級的操作。`reset()` 必須有先前的 `mark()`。`Reader.transferTo(Writer)` 將 reader 剩餘字元複製到 writer；之後 `out.flush()` 刷新目的地。選項 A 的順序正確：先 mark、讀取 first、reset 回起點、skip 5、transfer 剩下、flush。C 缺少 mark（reset 無效）；B 用在 Writer 上 call `skip()` 與 `transferTo`（不正確）；D 的 skip 在 reset 之後就被 reset 抵銷。

---

### Question 43

**Topic:** Handling Exceptions

**題目：**
A team uses a small helper to record control flow. What is printed by this Java 21 program?

```java
class Flow {
  static StringBuilder log = new StringBuilder();
  static int value() { log.append("R"); return 2; }

  static int run() {
    try {
      log.append("T");
      throw new IllegalStateException();
    } catch (RuntimeException e) {
      log.append("C");
      return value();
    } finally {
      log.append("F");
      throw new IllegalArgumentException();
    }
  }

  public static void main(String[] args) {
    try { System.out.print(run()); }
    catch (Exception e) {
      System.out.print(log + ":" + e.getClass().getSimpleName());
    }
  }
}
```

**Options:**
- **A.** `TCRF:IllegalArgumentException`
- **B.** `2`
- **C.** `TCF:IllegalArgumentException`
- **D.** `TCRF:IllegalStateException`

**Best answer: A**

**Explanation（重點翻譯：**
`finally` 會在 try 或 catch 路徑開始完成時執行，包括有 pending return 的情況。此處：try 追加 T 並拋出 IllegalStateException → catch 追加 C 並計算 `value()`（追加 R、準備回傳 2）→ 在此 return 離開 `run()` 之前，finally 追加 F 並**拋出 IllegalArgumentException**，取代了 pending return。因此 main 捕獲 `IllegalArgumentException`，印出 `TCRF:IllegalArgumentException`。

---

### Question 44

**Topic:** Handling Date, Time, Text, Numeric, and Boolean Values

**題目：**
Assume the Java runtime uses the IANA time-zone rule that in `America/New_York` on March 9, 2025, clocks move forward from 02:00 to 03:00, changing the offset from -05:00 to -04:00. What is the result of running this Java 21 code?

```java
import java.time.*;

public class Demo {
    public static void main(String[] args) {
        ZoneId zone = ZoneId.of("America/New_York");
        ZonedDateTime start = ZonedDateTime.of(
            2025, 3, 9, 1, 30, 0, 0, zone);
        ZonedDateTime later = start.plusHours(1);
        System.out.println(later);
        System.out.println(Duration.between(start, later).toMinutes());
    }
}
```

**Options:**
- **A.** It prints `2025-03-09T03:30-04:00[America/New_York]` and `120`.
- **B.** It prints `2025-03-09T03:30-04:00[America/New_York]` and `60`.
- **C.** It throws `DateTimeException` because 02:30 does not exist.
- **D.** It prints `2025-03-09T02:30-05:00[America/New_York]` and `60`.

**Best answer: B**

**Explanation（重點翻譯：**
在該時區規則下，當天 02:00~02:59 不存在（DST gap）。從 01:30 加 1 小時會直接跳到 03:30（offset -04:00）。`Duration.between(start, later)` 衡量的是 **instant timeline 上的實際流逝時間**，而非牆上時鐘標籤的差值，因此報告 60 分鐘。答案 B 正確。

---

### Question 45

**Topic:** Managing Concurrent Code Execution

**題目：**
An application starts a virtual thread to load a file. The code does not compile at the marked line. The team wants the caller to obtain the loaded text or the failure through `Future.get()`, without catching `IOException` inside the task body. Which is the best refactoring?

```java
class Loader {
    static Thread start(Path file) {
        return Thread.startVirtualThread(() -> {
            String text = Files.readString(file); // compile error
            System.out.println(text.length());
        });
    }
}
```

**Options:**
- **A.** Submit a `Callable<String>` to a virtual-thread executor.
- **B.** Add `throws IOException` to `start` and keep the `Runnable`.
- **C.** Submit a `Runnable` and return `Future<String>`.
- **D.** Pass a `Callable<String>` directly to `Thread.startVirtualThread`.

**Best answer: A**

**Explanation（重點翻譯：**
`Thread.startVirtualThread` 接受 `Runnable`，其 `run()` **不能拋出 checked exceptions** 也**不產生結果**。若要從任務回傳載入的內容並讓呼叫端處理 `IOException`，應改用 **`Callable<String>`** 並提交到 executor（例如 `Executors.newVirtualThreadPerTaskExecutor()`）。呼叫端可用 `Future.get()` 取得結果或以 `ExecutionException`（其 cause 可能是 IOException）接收失敗。`Thread.startVirtualThread` 不接受 `Callable`。

---

### Question 46

**Topic:** Using Object-Oriented Concepts in Java

**題目：**
The snippet uses no imports. What is the result?

```java
public class VarDemo {
    static int sum(int... nums) {
        int total = 0;
        for (int n : nums) total += n;
        return total;
    }

    static int count(int[] nums) {
        return nums.length;
    }

    public static void main(String[] args) {
        int[] data = {1, 2, 3};
        System.out.print(sum(data) + " ");
        System.out.print(sum(4, 5) + " ");
        System.out.print(count(data) + " ");
        System.out.print(count(6, 7));
    }
}
```

**Options:**
- **A.** It prints `6 9 3 13`.
- **B.** It does not compile because `sum(data)` is invalid.
- **C.** It prints `6 9 3 2`.
- **D.** It does not compile because `count(6, 7)` is invalid.

**Best answer: D**

**Explanation（重點翻譯：**
Varargs 方法 `sum(int...)` 可接受 `int[]` 或零個以上的 int 個別參數，因此 `sum(data)` 與 `sum(4, 5)` 都合法。但 `count(int[])` 是普通陣列參數，**不能**以 `count(6, 7)` 呼叫。因此在 runtime 開始前，class 就無法編譯。輸出假設 count 是 varargs 是不正確的。

---

### Question 47

**Topic:** Handling Exceptions

**題目：**
A utility method should compile, close the reader automatically, and wrap any `IOException` in `UncheckedIOException`. Cleanup must not hide a returned value or thrown exception. Which refactor best fixes this method?

```java
static String firstLine(Path path) {
    BufferedReader br;
    try (br = Files.newBufferedReader(path);
         var label = new StringBuilder("line=")) {
        return label.append(br.readLine()).toString();
    } catch (FileNotFoundException | IOException ex) {
        ex = new IOException("read failed", ex);
        throw new UncheckedIOException(ex);
    } finally {
        return "line=<error>";
    }
}
```

**Options:**
- **A.** Initialize `br` before try, use `try (br; label)`, and keep the multi-catch.
- **B.** Declare `br` in try, move `label` inside, and keep `FileNotFoundException | IOException`.
- **C.** Declare `br` in try, move `label` inside, catch `IOException`, and remove `finally`.
- **D.** Declare `br` in try, move `label` inside, catch `IOException`, and keep the `finally return`.

**Best answer: C**

**Explanation（重點翻譯：**
原程式碼有多個問題：try-with-resources header 不能包含 `br = ...` 的指派（須為 resource declaration），`StringBuilder` 不實作 `AutoCloseable` 不能作為 resource；multi-catch 不能包含具有繼承關係的型別（`FileNotFoundException` 是 `IOException` 的子類別）；multi-catch 參數是 implicitly final 不能重新指派。`finally` 中的 `return` 會遮罩正常回傳值或拋出的例外。正確修正：在 resource list 宣告 `BufferedReader`、將 `StringBuilder` 作為一般區域變數、catch `IOException` 並移除 `finally return`。

---

### Question 48

**Topic:** Working with Arrays and Collections

**題目：**
A developer reviews two independent fragments. Assume required imports exist.

```java
// Fragment 1
Integer[] values = {1, 2};
Number[] numbers = values;
numbers[0] = 3.14;

// Fragment 2
List<Integer> valuesList = new ArrayList<>();
List<Number> numbersList = valuesList;
numbersList.add(3.14);
```

Which option correctly compares the fragments?

**Options:**
- **A.** Both fragments compile and store `3.14` successfully.
- **B.** Both fragments compile, but both fail at runtime.
- **C.** Fragment 1 compiles but throws `ArrayStoreException`; Fragment 2 does not compile.
- **D.** Fragment 1 does not compile; Fragment 2 compiles but throws `ClassCastException`.

**Best answer: C**

**Explanation（重點翻譯：**
Java arrays 是 **covariant（共變）**：`Integer[]` 可被視為 `Number[]` 的子型別，所以 `Number[] numbers = values;` 可編譯。但實際陣列物件仍是 `Integer[]`，陣列在 runtime 有 store check，放入 `Double` 會拋 `ArrayStoreException`。Generic collections 是 **invariant（不變）**：`List<Integer>` **不是** `List<Number>` 的子型別，因此 `List<Number> numbersList = valuesList;` 在編譯期就被拒絕。

---

### Question 49

**Topic:** Working with Arrays and Collections

**題目：**
A developer adds a reusable helper to a generic class, but this code does not compile:

```java
import java.util.*;

class Box<T> {
    private final List<T> items = new ArrayList<>();
    void add(T item) { items.add(item); }

    static T first(List<T> list) {
        return list.get(0);
    }
}
```

The compiler reports that `T` cannot be referenced from a static context. Which fix best preserves the intended generic utility method?

**Options:**
- **A.** Create `new Box<T>()` inside `first` before returning
- **B.** Change `items` to `private static final List<T> items`
- **C.** Declare `first` as `static <T> T first(List<T> list)`
- **D.** Change the class declaration to `class Box<static T>`

**Best answer: C**

**Explanation（重點翻譯：**
Class 型別參數 `T` 屬於 `Box<T>` 的**實例**，不屬於 class 本身。Static member 與特定 `Box<String>` 或 `Box<Integer>` 實例無關，不能參照 class 的 `T`。要讓 static utility method 通用，必須在方法宣告自己的型別參數：`static <T> T first(List<T> list)`。該 `T` 只作用於方法，依每個 call site 的引數推斷。`class Box<static T>` 不是合法語法。

---

### Question 50

**Topic:** Handling Exceptions

**題目：**
Assume required imports exist. A team wants `run()` to be the only method that handles file-read failures from `readConfig()`. The code should compile and print `recovered` when `readConfig()` fails.

```java
class ConfigJob {
    static void run() {
        try {
            load();
        } catch (IOException e) {
            System.out.print("recovered");
        }
    }
    static void load() {
        readConfig();
    }
    static void readConfig() throws IOException {
        throw new IOException("missing");
    }
}
```

What is the best correction?

**Options:**
- **A.** Remove `throws IOException` from `readConfig()`.
- **B.** Declare `run()` with `throws IOException`.
- **C.** Change the handler to `catch (Exception e)`.
- **D.** Declare `load()` with `throws IOException`.

**Best answer: D**

**Explanation（重點翻譯：**
Checked exception 必須在每個可能逸出的方法邊界 **catch 或 declare**。`readConfig()` 宣告了 `throws IOException`，因此直接呼叫它的 `load()` 必須處理或宣告。要在 `run()` 處理而 `load()` 不處理，`load()` 就必須宣告 `throws IOException`，讓例外向上傳播到 `run()` 的 catch 區塊，印出 `recovered`。只在 `run()` 宣告無法解決 `load()` 直接呼叫 checked-exception 方法的編譯錯誤。

---

# Section 2：Cert Empire（自由練習題）

> 原始頁面：Cert Empire — Free 1Z0-830 Practice Test Questions and Answers (2026)
> 此檔案中共有 **20 題**（頁面宣稱共 97 題，但此快照僅擷取到此 20 題）。

---

### Question 1

**題目：**
When iterating over a parallel stream and collecting results into a `List`, which method ensures thread-safety?

**Options:**
- **A.** `forEach()`
- **B.** `collect(Collectors.toList())`
- **C.** `parallelStream()`
- **D.** `stream()`

**Correct Answer: B**

**Explanation（重點翻譯）：**
`forEach()` 用於對 stream 的元素執行 side effect，並非收集結果，且本身對並行修改集合不是 thread-safe。`parallelStream()` 只是建立 parallel stream，未解決收集過程的 thread-safety。`collect(Collectors.toList())` 與 `collect()` 搭配時，Java 內部以 thread-safe 機制處理 parallel processing 期間對新 `ArrayList` 的並行新增。若需在 stream 內修改原始集合，可考慮 `CopyOnWriteArrayList`。

---

### Question 2

**題目：**
Which of the following statements is TRUE about modules in Java SE 21?

**Options:**
- **A.** Modules can access all public classes from any other module by default.
- **B.** Modules require explicit declaration of dependencies on other modules.
- **C.** Reflection can be used to bypass module boundaries and access private members.
- **D.** Services and providers are not related to the modular system in Java.

**Correct Answer: B**

**Explanation（重點翻譯）：**
Module 預設只能存取自己套件的 public 成員，以及明確宣告依賴（`requires`）的模組之 public 成員——無限制的存取會破壞 modularity 的封裝目標。反射**不能**越過 module boundaries 存取其他 module 的 private members。Services 與 providers 是 Java module system 的相關概念（`uses`/`provides`），允許 module 發掘與互動特定功能的實作。

---

### Question 3

**題目：**
Given a `Stream` of integers, which code snippet efficiently finds the maximum value using a **reduction** operation?

**Options:**
- **A.** `List numbers = Arrays.asList(10, 5, 20, 1); int max = numbers.stream().filter(n -> n > 10).findFirst().get();` *(Incorrect - Filters then finds first)*
- **B.** `List numbers = Arrays.asList(10, 5, 20, 1); int max = numbers.stream().max(Integer::compareTo).get();` *(Incorrect - max with Comparator, not reduction)*
- **C.** `List numbers = Arrays.asList(10, 5, 20, 1); int max = numbers.stream().reduce(Integer::max).get();`
- **D.** `List numbers = Arrays.asList(10, 5, 20, 1); Optional max = numbers.stream().max(Integer::compareTo);` *(Incorrect - Optional without get() for reduction)*

**Correct Answer: C**

**Explanation（重點翻譯）：**
`filter` 與 `findFirst` 用於過濾與尋找第一個符合條件的元素，非 reduction。`max(Integer::compareTo)` 使用 comparator，非 reduction。`reduce(Integer::max)` 使用二元運算子將 stream 的每個元素進行 reduction——`Integer::max` 比較兩個整數回傳較大者；未提供初始值時第一個元素成為初始值；`get()` 從 Optional 取出最大值。**(注意：選項 B 其實也可取得 max，但題目的「正解」依原始網站標示為 C。)**

---

### Question 4

**題目：**
Which of the following methods is best suited for iterating over a Java collection concurrently?

**Options:**
- **A.** `for loop`
- **B.** `while loop`
- **C.** `Iterator#next()`
- **D.** `Stream#forEachParallel()`

**Correct Answer: D**

**Explanation（重點翻譯）：**
傳統的 `for`/`while` 迴圈本身不是 thread-safe；多執行緒並行修改集合可能造成 race condition 與資料損毀。`Iterator.next()` 也不保證 thread-safety。`Stream#forEachParallel()` 屬於 Streams API，專為並行處理集合元素而設計，會利用多執行緒並行處理，適合大型集合以提升效能；但**不保證處理順序**，且僅用於 side effect（如列印），而非收集結果——若要 thread-safe 收集，應用 `collect()`。

---

### Question 5

**題目：**
Which class from the Java I/O API is used to write text data to the console?

**Options:**
- **A.** `System.out.println()`
- **B.** `FileOutputStream`
- **C.** `PrintStream`
- **D.** `BufferedReader`

**Correct Answer: C**

**Explanation（重點翻譯）：**
`System.out` 是 `PrintStream` 的實例。`PrintStream` 提供格式化與未格式化資料寫入 output stream 的方法；`System.out.println()` 是利用 `System.out`（PrintStream）寫入標準輸出。`FileOutputStream` 用於寫檔案、`BufferedReader` 用於讀字元 stream。

---

### Question 6

**題目：**
Java SE 21 introduced the `TemporalQueries` interface. What is the primary purpose of this interface?

**Options:**
- **A.** To define methods for manipulating date-time objects.
- **B.** To provide a mechanism for querying specific information from temporal objects
- **C.** To represent different calendar systems.
- **D.** To define a standard way to format date-time objects.

**Correct Answer: B**

**Explanation（重點翻譯）：**
`TemporalQueries` 定義從 temporal objects（日期、時間或時區物件）**提取特定資訊**的策略，例如 year、month、day of month 或 time zone offset。它不是用於修改物件（`plusDays()` 等負責修改）、不直接處理 calendar systems（`ChronoLocalDate` 處理非 ISO 曆法）、也不負責格式化（`DateTimeFormatter` 負責）。範例：`today.query(TemporalQueries.year())` 可取出年份。

---

### Question 7

**題目：**
Given a `Stream` of Strings, which code snippet concatenates all elements into a single String separated by commas?

**Options:**
- **A.** `List names = Arrays.asList("Alice", "Bob", "Charlie"); String allNames = names.stream().collect(Collectors.joining(","));`
- **B.** `List names = Arrays.asList("Alice", "Bob", "Charlie"); StringBuilder sb = new StringBuilder(); names.stream().forEach(n -> sb.append(n + ",")); String allNames = sb.toString().substring(0, sb.length() - 1);` *(Incorrect - Manual concatenation with forEach)*
- **C.** `List names = Arrays.asList("Alice", "Bob", "Charlie"); String allNames = ""; names.stream().forEach(n -> allNames += n + ",");` *(Incorrect - Manual concatenation with forEach, inefficient)*
- **D.** `List names = Arrays.asList("Alice", null, "Charlie"); String allNames = names.stream().collect(Collectors.joining(","));` *(Incorrect - Fails with null value in stream)*

**Correct Answer: A**

**Explanation（重點翻譯）：**
`Collectors.joining(",")` 是專為將 stream 元素串接成單一 String 設計的 collector，可指定分隔符。B 與 C 使用手動串接（較不簡潔也不高效）；D 若 list 含有 `null` 值，stream 預設無法處理 null，需要在 collect 前過濾或自訂 joining 函式。

---

### Question 8

**題目：**
How can you add a new element `"Apple"` to the end of a `LinkedList` named `fruits`?

**Options:**
- **A.** `fruits.addFirst("Apple");`
- **B.** `fruits.set(fruits.size(), "Apple");`
- **C.** `fruits.addLast("Apple");`
- **D.** `fruits.append("Apple"); // This method doesn't exist in LinkedList`

**Correct Answer: C**

**Explanation（重點翻譯）：**
`LinkedList.addLast(...)` 是專為在 `LinkedList` 結尾新增元素的 method。`addFirst` 新增在開頭；`set(fruits.size(), ...)` 會因索引等於 size 而拋 `IndexOutOfBoundsException`（list 該位置尚無元素）；`LinkedList` 沒有 `append()` 方法。

---

### Question 9

**題目：**
What functionality is provided by the `jdeps` tool?

**Options:**
- **A.** Creates a runtime image for a Java application.
- **B.** Analyzes dependencies between modules and classes.
- **C.** Generates documentation for Java code.
- **D.** Compiles Java source code into bytecode.

**Correct Answer: B**

**Explanation（重點翻譯）：**
`jdeps` 是 JDK 自 Java 8 提供的 **靜態分析工具**，分析 Java 應用程式中 module 與 class 之間的依賴關係：找出 class file dependencies、JAR dependencies 與 module dependencies（Java 9+）。`jlink` 用於建立 runtime image、`javadoc` 產生文件、`javac` 是編譯器。開發者可藉 `jdeps` 找出未使用的依賴、重構減少依賴並為 modular 遷移做準備。

---

### Question 10

**題目：**
What is the purpose of a functional interface in Java?

**Options:**
- **A.** To define a set of static helper methods.
- **B.** To provide a callback mechanism for lambda expressions.
- **C.** To enforce specific naming conventions for methods.
- **D.** To restrict access to methods within an interface.

**Correct Answer: B**

**Explanation（重點翻譯）：**
Functional interface（Java 8 引進，具 @FunctionalInterface 選用標示）有**恰好一個抽象方法（SAM）**，作為 lambda expressions 的藍圖。lambda 可作為參數傳給方法或高階函式，提供簡潔彈性的行為定義，等同 callback 機制。它並非特別設計 static helper methods、不強制命名慣例、也不處理存取限制。

---

### Question 11

**題目：**
Which command-line argument instructs the `javac` compiler to produce a modular JAR file?

**Options:**
- **A.** `-cp`
- **B.** `--module-source`
- **C.** `-module-path`
- **D.** `--module`

**Correct Answer: D**

**Explanation（重點翻譯）：**
`-cp` 指定 classpath（供 compiler 找依賴）；`--module-source` 指定 module source version；`-module-path` 指定 module path 解析依賴。**`--module <module>`** 讓 `javac` 將編譯的類別視為具名的 module，是建立 modular JAR 的關鍵步驟。之後可用 `jar` 命令建立含 module 資訊的 JAR（`jar --create --file my-module.jar -C .`）。

---

### Question 12

**題目：**
Consider the expression `(byte) (5.7 + 3.2)`. What is the result of this expression?

**Options:**
- **A.** `8.9 (double)`
- **B.** `8 (int)`
- **C.** Compile-time error
- **D.** `5 (byte)`

**Correct Answer: C**

**Explanation（重點翻譯）：**
第一步：`5.7 + 3.2` 兩個 double 相加得 `8.9`（double）。第二步：將 `8.9`（double）轉型為 `byte`。因為 `byte` 範圍只有 -128~127 且只能存整數，將含小數的 `8.9` 轉為 `byte` 會造成資訊遺失，Java 為防止意外行為與資料損失，在此情境下會拋 **compile-time error**。（*註：此為原始網站的解答認定。實務上 Java 允許將 double literal 轉型為 byte，例如 `(byte)8.9` 是合法的 explicit narrowing cast，會得 8；原始網站此題判定可能有誤，建議自行驗證。*）

---

### Question 13

**題目：**
Which of the following statements is **NOT** true about the `synchronized` keyword in Java?

**Options:**
- **A.** It guarantees exclusive access to a code block by a single thread at a time.
- **B.** It can be applied to methods and code blocks
- **C.** It automatically handles thread-safety for immutable objects.
- **D.** It can lead to deadlocks if used incorrectly.

**Correct Answer: C**

**Explanation（重點翻譯）：**
`synchronized` 保證同一時間只有一個執行緒能執行 synchronized block/method；可應用於方法與程式碼區塊；不當使用可能造成 deadlock。**C 不正確**：不可變（immutable）物件本身無法在建立後被修改，因此本質上就是 thread-safe，這與 `synchronized` 無關——`synchronized` 不會「自動處理」immutable objects 的 thread-safety。

---

### Question 14

**題目：**
Which of the following statements about overloaded methods with varargs is TRUE?

**Options:**
- **A.** A varargs parameter can be of any primitive type.
- **B.** A varargs parameter must be the only parameter in the method signature.
- **C.** A method can be overloaded based solely on the presence or absence of a varargs parameter.
- **D.** The compiler throws an error if you call a varargs method with zero arguments.

**Correct Answer: C**

**Explanation（重點翻譯：**
Varargs（variable arguments）允許方法接受相同型別的可變數目引數，本質上以陣列待之。**C 正確**：可建立一個固定參數版本與一個 varargs 版本的重載，以處理不同引數數量的情境。A 錯誤：varargs 通常限制為 primitive 或其 wrapper classes。B 錯誤：varargs 可與固定參數結合（只能為最後一個參數）。D 錯誤：零引數呼叫 varargs 是合法的（視為空陣列）。

---

### Question 15

**題目：**
When compiling Java code for a modular application, what happens if a class depends on a class from an unnamed module?

**Options:**
- **A.** The compilation will fail because unnamed modules cannot be referenced.
- **B.** The compiler will automatically include the unnamed module in the compilation process.
- **C.** You need to explicitly declare the unnamed module on the module path.
- **D.** Unnamed modules are not supported in Java 21.

**Correct Answer: B**

**Explanation（重點翻譯：**
Unnamed modules 代表傳統的 classpath 方式，仍是 Java 21（及之後）支援的型態，用於處理尚未轉換成 module 的 legacy libraries。當編譯 modular application 時，compiler 除了明確宣告的 module 之外，也會搜尋 classpath 上的依賴，因此 unnamed module 的類別（如標準函式庫或 legacy code）可在 modular 專案中使用。不過 unnamed module 的封裝與控制層級不如 named modules，若 classpath 上多個 JAR 提供同名類別可能造成衝突。

---

### Question 16

**題目：**
When parsing a user-entered date string, which exception might be thrown if the format is invalid for the current locale?

**Options:**
- **A.** `NumberFormatException`
- **B.** `ParseException`
- **C.** `LocaleException`
- **D.** `DataFormatException`

**Correct Answer: B**

**Explanation（重點翻譯：**
`ParseException` 由 `SimpleDateFormat`（或 Java 8+ 的 `DateTimeFormatter` 相對機制）在解析字串為日期物件失敗時拋出；無效的日期格式即為一種觸發原因。`NumberFormatException` 是解析數字失敗；`LocaleException` 與無效 locale code 相關；`DataFormatException` 是較通用的格式錯誤，非日期解析專用。

---

### Question 17

**題目：**
Which of the following statements is true about buffering when using streams for file I/O?

**Options:**
- **A.** Buffering improves performance but increases memory usage.
- **B.** Buffering decreases performance but reduces memory usage.
- **C.** Buffering has no impact on performance or memory usage.
- **D.** Buffering is only used for network I/O, not file I/O.

**Correct Answer: A**

**Explanation（重點翻譯：**
Buffering 可以**減少個別磁碟存取的次數**——將多個小型的讀寫要求合併成一次較大的操作，顯著提升檔案 I/O 效能（尤其對頻繁的小型讀寫）。但 buffer 本身需要記憶體來暫存資料，因此 **記憶體使用會增加**。Buffering 同時適用於 network 與 file I/O。

---

### Question 18

**題目：**
Which of the following statements is true about reflection and modules?

**Options:**
- **A.** Reflection allows unrestricted access to all classes and members within a module.
- **B.** Reflection can be used to access public members of a module, but not private ones.
- **C.** Modules can completely disable reflection within their code.
- **D.** Reflection bypasses module boundaries entirely.

**Correct Answer: B**

**Explanation（重點翻譯：**
Java module system 強化封裝，反射**遵循 module boundaries**：Reflection 可用來存取某 module 的 **public members**（即使反射程式碼沒有直接依賴該 module）；但**不能**存取其他 module 類別的 private members。Modules 無法完全停用程式碼內的反射（反射是核心 Java 功能）。

---

### Question 19

**題目：**
Which of the following correctly sorts a `List` of custom objects based on their age in descending order using a `Stream`?

**Options:**
- **A.** `List people = ...; people.stream().sorted((p1, p2) -> p1.getAge() - p2.getAge()).collect(Collectors.toList());`
- **B.** `List people = ...; people.stream().sort(Comparator.comparing(Person::getAge)).collect(Collectors.toList());`
- **C.** `List people = ...; people.stream().sorted(Person::getAge).collect(Collectors.toList());`
- **D.** `List people = ...; people.sort((p1, p2) -> p2.getAge() - p1.getAge());`

**Correct Answer: A**

**Explanation（重點翻譯：**
`Stream.sorted(Comparator)` 接收 comparator 定義排序邏輯。`(p1, p2) -> p1.getAge() - p2.getAge()` 的 lambda 依年齡比較；負值表示 p1 較年輕、正值表示 p2 較年輕、0 代表年齡相同。B 使用 `sort()`（List 方法而非 Stream）且看不清升降冪；C 的 `Person::getAge` 無法單獨作為 comparator；D 直接排序原始 List（可運作但非 Stream 風格）。

---

### Question 20

**題目：**
When designing overloaded methods with varargs, what's the best practice to avoid ambiguity?

**Options:**
- **A.** Use the same parameter type for both regular and varargs parameters.
- **B.** Make the varargs method the only overloaded version available.
- **C.** Clearly define the intended use cases for each overloaded method.
- **D.** There's no way to completely avoid ambiguity with varargs.

**Correct Answer: C**

**Explanation（重點翻譯：**
雖然無法保證完全消除 varargs 的所有含糊性，但**清楚的設計與文件**可顯著提升可讀性並降低編譯錯誤或非預期行為的風險。關鍵做法：為每個 overload 說明用途（何時用 fixed-argument 方法、何時用 varargs 方法）；若可能，讓 fixed 參數與 varargs 參數使用**不同型別**以利 compiler 區分；盡量**減少 varargs 重載的數量**；必要時以 multiple fixed-argument 方法取代 varargs。

---

---

*文件結束。所有答案依原始網站內容轉錄，請自行驗證。*
