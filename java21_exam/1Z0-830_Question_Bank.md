# Oracle 1Z0-830 Java SE 21 Developer — 完整考題題庫（javainuse）

> 來源：https://javainuse.com/cert/1z0830/quiz （Practice Test 1–5，共 5 份，每份 66 題）
> 已排除各份卷中未填內容的「佔位符題目」（placeholder）。
> 整理時間：2026-09-03

## 題庫統計

| 測驗卷 | 有效題數 | 備註 |
|---|---|---|
| Test 1 | 66 | 全部有內容 |
| Test 2 | 66 | 全部有內容 |
| Test 3 | 20 | Q21–66 為佔位符 |
| Test 4 | 3 | Q4–66 為佔位符 |
| Test 5 | 66 | 全部有內容 |
| **合計** | **221** | 220 有效 + Test3 部分 |

> 各題皆保留原始難度（EASY/MEDIUM）。每個選項後未標註正確答案者，答案以「Answer」解說為準。

---

## Test 1（66 題，全部有效）

### Q1 MEDIUM）以下 sealed class 宣告哪些可編譯？（Choose two.）
```
A. sealed class Shape permits Circle {} final class Circle extends Shape {}
B. sealed class Shape permits Circle {} class Circle extends Shape {}
C. public sealed class Shape permits Circle, Square {}
   final class Circle extends Shape {} non-sealed class Square extends Shape {}
D. public sealed class Shape {} final class Circle extends Shape {}
```
**答：A 與 C。** 繼承 sealed class 之子類別必須宣告 `final`、`sealed` 或 `non-sealed`；`permits` 子句不可省略。

---

### Q2 MEDIUM）以下 `var` 區域變數宣告哪些無效？（Choose three.）
```
A. var x = 10;
B. var y;
C. var z = null;
D. var a = {1, 2, 3};
E. var b = new int[]{1, 2, 3};
F. var c = (d = 5);
```
**答：B、C、D。** `var` 需有初始值；不能從 `null` 推斷；array initializer 語法必須搭配 `new`。

---

### Q3 MEDIUM）下列程式的輸出為何？
```java
double amount = 12500;
NumberFormat format = NumberFormat.getCompactNumberInstance(Locale.US, NumberFormat.Style.SHORT);
System.out.println(format.format(amount));
```
**答：`12.5K`。** `getCompactNumberInstance` + `Style.SHORT` 在 US locale 把 12,500 格式化成緊湊數字 `12.5K`。

---

### Q4 MEDIUM）inventory.app 模組依賴 inventory.core，並需將套件 inventory.app.api 開放給其他模組。以下哪個是正確的模組宣告檔？
```
A. 檔名 module-info.inventory.app.java → module inventory.app { requires inventory.core; exports inventory.app.api; }
B. 檔名 module-info.java → module inventory.app { requires inventory.core; exports inventory.app.api; }
C. 檔名 module.java → module app.inventory { requires inventory.core; exports inventory.app.api; }
D. 檔名 inventory.app.module → module inventory.app { requires inventory.core; exports inventory.app.api; }
```
**答：B。** 模組必須宣告於 `module-info.java`；`module-info.java` 中的模組名稱需與檔案所在位置相符，`requires` 宣告依賴、`exports` 開放套件。

---

### Q5 MEDIUM）下列程式的輸出為何？
```java
public class TestInterfaces {
    public static void main(String[] args) { Child.print(); }
}
interface Parent { default void print() { System.out.print("parent"); } }
interface Child extends Parent { static void print() { System.out.print("child"); } }
```
**答：`child`。** 介面的 `static` 方法不會被繼承；`Child.print()` 呼叫的是 Child 自己宣告的 static 方法。

---

### Q6 MEDIUM）給定 `List<String> italianAuthors = new ArrayList<>();` 且加入 "Dante"、"Umberto Eco"。以下哪些宣告可編譯？（Choose two.）
```
A. Map<String, ArrayList<String>> map1 = new HashMap<>(); map1.put("IT", italianAuthors);
B. Map<String, ? extends List<String>> map2 = new HashMap<String, ArrayList<String>>(); map2.put("IT", italianAuthors);
C. var map3 = new HashMap<String, List<String>>(); map3.put("IT", italianAuthors);
D. Map<String, List<String>> map4 = new HashMap<String, ArrayList<String>>(); map4.put("IT", italianAuthors);
E. Map<String, List<String>> map5 = new HashMap<>(); map5.put("IT", italianAuthors);
```
**答：C 與 E。** `var` 推斷為 `HashMap<String, List<String>>` 合法；diamond operator 同理。泛型不具變性（invariance），故 `HashMap<String, ArrayList<String>>` 不是 `Map<String, List<String>>` 的子型別（B、D 錯）；A 因存取型別不符而失敗。

---

### Q7 MEDIUM）已知程式碼印出 "December 05"。下列哪個應作為 pattern？
```java
LocalDate localDate = LocalDate.of(2021, 12, 5);
Date date = java.sql.Date.valueOf(localDate);
DateFormat formatter = new SimpleDateFormat(/* pattern */);
String output = formatter.format(date);
```
```
A. MM dd   B. MMMM dd   C. MMM dd   D. MMDD
```
**答：B。** `MMMM` 為完整月份名稱（December）、`dd` 為兩位日。

---

### Q8 MEDIUM）下列程式的輸出為何？
```java
Period p = Period.between(LocalDate.of(2022, Month.JANUARY, 1), LocalDate.of(2023, Month.JANUARY, 1));
System.out.print(p);
Duration d = Duration.between(LocalDate.of(2022, Month.JANUARY, 1), LocalDate.of(2023, Month.JANUARY, 1));
System.out.print(d);
```
```
A. P1Y PT8760H           B. PT8760H P1Y
C. P1Y UnsupportedTemporalTypeException
D. UnsupportedTemporalTypeException
```
**答：C。** `Period` 適用於 `LocalDate`（印 `P1Y`）；`Duration` 需要 time-based 型別，傳 `LocalDate` 丟 `UnsupportedTemporalTypeException`。

---

### Q9 MEDIUM）哪幾行無法編譯？
```java
interface Processor { double apply(int x); }
public class Test {
    public static void main(String[] args) {
        Processor p1 = x -> x * 2;                  // Line 1
        Processor p2 = x -> Double.valueOf(x);     // Line 2
        Processor p3 = x -> { throw new RuntimeException(); }; // Line 3
    }
}
```
**答：程式完全可編譯。** `apply(int)` 回傳 `double`：`x*2` 從 `int` 自動加寬為 `double`；`Double.valueOf(x)` 自動拆箱；lambda 允許拋出 unchecked 例外。

---

### Q10 MEDIUM）下列程式的輸出為何？
```java
var cities = new TreeSet<String>();
cities.add("Berlin"); cities.add("Amsterdam");
cities.add("Zurich"); cities.add("Madrid"); cities.add("Lisbon");
System.out.println(cities.headSet("Madrid"));
```
```
A. [Amsterdam, Berlin]                        B. [Amsterdam, Berlin, Lisbon]
C. [Berlin, Lisbon]                           D. Compilation fails
E. [Amsterdam, Berlin, Lisbon, Madrid]
```
**答：B。** `TreeSet` 依字母排序 `[Amsterdam, Berlin, Lisbon, Madrid, Zurich]`；`headSet("Madrid")` 回傳**嚴格小於**者。

---

### Q11 MEDIUM）`java.util.function.Predicate` 中哪些是 default 方法？（Choose all that apply）
```
A. and(Predicate<? super T> other)   B. isEqual(Object targetRef)
C. negate()                          D. not(Predicate<? super T> target)
E. or(Predicate<? super T> other)    F. test(T t)
```
**答：A、C、E。** `test(T)` 為 abstract；`isEqual()` 與 `not()` 為 static；`and()`、`negate()`、`or()` 為 default。

---

### Q12 MEDIUM）下列程式的輸出為何？
```java
public class AdvancedCalc extends BaseCalc implements Extra {
    public static void main(String[] args) { System.out.println(new AdvancedCalc().compute()); }
    int compute() { return value - bonus; }
}
class BaseCalc { int value = 5; }
interface Extra { int bonus = 3; }
```
**答：`2`。** 繼承的 instance field `value = 5`；介面常數 `bonus = 3`（隱式 `public static final`）。5 - 3 = 2。

---

### Q13 MEDIUM）以下哪些方法可編譯？（Choose all that apply）
```
A. public List<? extends RuntimeException> getList1() { return new ArrayList<IllegalArgumentException>(); }
B. public List<? super RuntimeException> getList2() { return new ArrayList<Exception>(); }
C. public List<? extends RuntimeException> getList3() { return new ArrayList<Exception>(); }
D. public List<? super RuntimeException> getList4() { return new ArrayList<IllegalArgumentException>(); }
```
**答：A 與 B。** `? extends` 允許子型別（`IllegalArgumentException`）；`? super` 允許父型別（`Exception`）。

---

### Q14 MEDIUM）如何建立 ConcurrentHashMap：初始容量 32、負載因子 0.75、並行層級 8？
```
A. new ConcurrentHashMap(32);
B. new ConcurrentHashMap(32, 8);
C. new ConcurrentHashMap(32, 0.75f, 8);
D. new ConcurrentHashMap(0.75f, 32, 8);
E. None of the above
```
**答：C。** 建構子 `ConcurrentHashMap(int initialCapacity, float loadFactor, int concurrencyLevel)`。

---

### Q15 MEDIUM）選擇正確的陳述。
```java
interface Device { boolean isOn(); }
class Laptop implements Device {
    boolean power;
    boolean isOn() { power = power; return power; }
}
```
**答：Laptop 不編譯。** 介面方法隱式 `public`，實作時必須保持 `public`；省略 `public` 降低存取權限，編譯失敗。

---

### Q16 MEDIUM）下列哪個 text block 可取代 `String animals = "cat " + "dog " + "bird ";`？
**答：None of the propositions。** 原字串含 `\n` 換行；提供的 text block 皆無法精確重現 `"cat " + "dog " + "bird "` 的換行序列。

---

### Q17 MEDIUM）下列程式的輸出為何？
```java
DoubleSummaryStatistics stats1 = new DoubleSummaryStatistics();
stats1.accept(2.0); stats1.accept(6.0);
DoubleSummaryStatistics stats2 = new DoubleSummaryStatistics();
stats2.accept(4.0); stats2.accept(8.0);
stats1.combine(stats2);
System.out.println("Sum: " + stats1.getSum() + ", Max: " + stats1.getMax() + ", Avg: " + stats1.getAverage());
```
**答：`Sum: 20.0, Max: 8.0, Avg: 5.0`。** 合併後含 2、6、4、8：Sum=20、Max=8、Avg=5。

---

### Q18 MEDIUM）下列程式發生什麼？
```java
public class Container {
    String message = "Hello";
    class Inner { void print() { System.out.println(message); } }
    public static void main(String[] args) {
        Container c = new Container();
        Inner i = new Inner();  // Line 1
        i.print();              // Line 2
    }
}
```
**答：Line 1 編譯失敗。** `Inner` 是非 static 內部類別，需 `c.new Inner()` 才能建立。

---

### Q19 MEDIUM）序列化類別 X 後強制轉型為 Y，兩者無關。下列程式的輸出為何？
```java
import java.io.*;
class X implements Serializable { int value = 10; }
class Y implements Serializable { int value = 20; }
public class Test {
    public static void main(String[] args) throws Exception {
        File file = new File("data.ser");
        X obj = new X();
        var out = new ObjectOutputStream(new FileOutputStream(file));
        out.writeObject(obj); out.close();
        var in = new ObjectInputStream(new FileInputStream(file));
        Y result = (Y) in.readObject(); in.close();
        System.out.println(result.value);
    }
}
```
**答：`ClassCastException`。** X 物件反序列化後轉型為無關的 Y 型別，runtime 丟 `ClassCastException`。

---

### Q20 MEDIUM）下列程式的輸出為何？
```java
public class Test {
    public static void main(String[] args) {
        try { throw new IllegalArgumentException(); }
        catch (IllegalArgumentException e) { throw new RuntimeException(); }
        finally { throw new NullPointerException(); }
    }
}
```
**答：`NullPointerException`。** `finally` 一定執行，其丟出的例外覆蓋前面所有例外。

---

### Q21 MEDIUM）下列程式的輸出為何？
```java
StringBuilder a = new StringBuilder("FR");
StringBuilder b = new StringBuilder("DE");
Stream<StringBuilder> stream = Stream.of(a, b);
String result = stream.collect(Collectors.joining("-", "[", "]"));
System.out.println(result);
```
**答：`[FR-DE]`。** `joining(delimiter, prefix, suffix)` 以元素 `toString()` 串聯。

---

### Q22 MEDIUM）下列程式的輸出為何？
```java
String s = " ";
System.out.print("[" + s.strip() + "]");
s = " world ";
System.out.print("[" + s.strip() + "]");
s = " java ";
System.out.print("[" + s.strip() + "]");
```
**答：`[][]world][java]`。** `strip()` 移除前後空白（Unicode-aware）：空字串→`[]`、` world `→`[world]`、` java `→`[java]`。

---

### Q23 MEDIUM）下列程式的輸出為何？
```java
List<String> list = List.of("x", "y", "z");
list.stream().forEach(s -> { s = s.toUpperCase(); });
list.stream().forEach(System.out::print);
```
**答：`xyz`。** `String` 不可變；lambda 內指派只改區域參數，不影響原 list。

---

### Q24 MEDIUM）下列程式的輸出為何？
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
**答：`long`。** `value` 是 `Long`，switch pattern matching 選第一個符合的 case。

---

### Q25 MEDIUM）下列程式的輸出為何？
```java
StringBuilder result = Stream.of("x", "y")
    .collect(() -> new StringBuilder("z"), StringBuilder::append, (a, b) -> b.append(a));
System.out.println(result);
```
**答：`zxy`。** supplier 建立含 `"z"` 的 `StringBuilder`；依序 append "x"→"zx"、"y"→"zxy"；順序串流不使用 combiner。

---

### Q26 MEDIUM）假設今天是 12/31/2024。哪個變數印出 `2025-W01`？
```java
var now = LocalDate.now();
var f1 = DateTimeFormatter.ISO_LOCAL_DATE;
var f2 = DateTimeFormatter.ISO_WEEK_DATE;
var f3 = new DateTimeFormatterBuilder()
    .appendValue(IsoFields.WEEK_BASED_YEAR, 4)
    .appendLiteral("-W").appendValue(IsoFields.WEEK_OF_WEEK_BASED_YEAR, 2)
    .toFormatter();
```
```
A. f1   B. f2   C. f3   D. None of them
```
**答：B。** 2024/12/31 屬於 week-based year 2025 的第 1 週；`ISO_WEEK_DATE` 使用週基準年份格式。f3 少了 day element，不符「2025-W01」完整格式。

---

### Q27 MEDIUM）下列程式的輸出為何？
```java
public class Counter {
    static int value;
    synchronized Counter() { value++; }
    public static void main(String[] args) throws InterruptedException {
        Runnable task = Counter::new;
        Thread t1 = new Thread(task); Thread t2 = new Thread(task);
        t1.start(); t2.start(); t1.join(); t2.join();
        System.out.println(value);
    }
}
```
**答：它可能是 1 或 2。** 建構子 `synchronized` 鎖的是個別建立的實例，未共享同一把鎖；`static value` 遞增無類別級同步 → 競態條件（race condition）。

---

### Q28 MEDIUM）下列程式的輸出為何？
```java
public class ExceptionFlow {
    public static void main(String[] args) {
        try { calculate(); System.out.print("Alpha, "); }
        catch (ArithmeticException e) { System.out.print("Beta, "); }
        finally { System.out.print("Gamma"); }
    }
    static int calculate() {
        try { int x = 10 / 0; return x; }
        catch (NullPointerException e) { System.out.print("Delta, "); return -1; }
        finally { System.out.print("Epsilon, "); }
    }
}
```
**答：`Epsilon, Beta, Gamma`。** calculate() 內 `10/0` 丟 `ArithmeticException`（未被 NPE catch 接住），`finally` 印 "Epsilon, "；例外傳回 main 被 catch 印 "Beta, "；main 的 `finally` 印 "Gamma"。

---

### Q29 MEDIUM）哪些 records 可編譯？（Choose two.）
```
A. record ARecord(int x) { int y; }
B. record BRecord(int x) { static int y; }
C. record CRecord(int x) extends RuntimeException {}
D. record DRecord(int x) implements Runnable { public void run() {} }
```
**答：B 與 D。** record 不能加額外 instance field（A 錯）；record 隱式繼承 `java.lang.Record` 不能 extends（C 錯）；可含 static field、可實作介面。

---

### Q30 MEDIUM）下列哪兩段 statements 會同時印出 "Running Runnable" 與 "Running Callable"？（Choose two.）
```java
Runnable r = () -> System.out.println("Running Runnable");
Callable<String> c = () -> { System.out.println("Running Callable"); return "Done"; };
ExecutorService service = Executors.newSingleThreadExecutor();
// INSERT CODE HERE
service.shutdown();
```
```
A. service.execute(r); service.execute(c);
B. service.submit(r); service.submit(c);
C. service.execute(r); service.submit(c);
D. service.submit(r); service.run();
E. service.call(c);
```
**答：B 與 C。** `execute()` 只接受 `Runnable`（A 的 `execute(c)` 不編譯）；`submit()` 兩者皆可。無 `run()`/`call()` 方法。

---

### Q31 MEDIUM）下列哪兩個**不是**建立 Stream 的有效方式？（Choose two.）
```
A. Stream s = new Stream();
B. Stream<String> s = Stream.of("a", "b");
C. Stream<String> s = Stream.generate(() -> "x");
D. Stream<String> s = Stream.empty();
E. Stream<String> s = Stream.builder().add("a").build();
F. Stream<String> s = Stream.ofNullable("a");
```
**答：A 與 C。** `Stream` 是介面不能 `new`；`generate()` 產出無限串流需搭配 `limit()` 才屬標準用法。其餘皆有效。

---

### Q32 MEDIUM）下列程式的輸出為何？
```java
var _ = 5;
var $ = 9;
System.out.println(_ + $);
```
**答：Compilation fails。** Java 9+ 單一底線 `_` 不能作為識別字。

---

### Q33 MEDIUM）`java.io.Console` 中哪個方法**不存在**？
```
A. readLine()                      B. readLine(String fmt, Object... args)
C. readPassword()                  D. readPassword(String fmt, Object... args)
E. writer()                        F. print(String s)
```
**答：F。** `Console` 沒有 `print(String)`；輸出使用 `writer()` 或 `format()`/`printf()`。

---

### Q34 MEDIUM）下列程式的輸出為何？
```java
Optional<Integer> o1 = Optional.empty();
Optional<Integer> o2 = Optional.of(5);
Optional<Integer> o3 = Stream.of(o1, o2)
    .filter(Optional::isPresent).findFirst().flatMap(o -> o);
System.out.println(o3.orElse(10));
```
**答：`5`。** 過濾掉空的 o1，留下 o2；`findFirst()` 得 `Optional<Optional<Integer>>`，`flatMap` 解包成含 5 的 `Optional`。

---

### Q35 MEDIUM）下列程式發生什麼？
```java
// File 1 package zoo.animal;
public class Animal { protected String name = "Lion"; }
// File 2 package zoo.caretaker;
import zoo.animal.Animal;
public class Keeper extends Animal {
    public static void main(String[] args) {
        Animal a = new Animal();
        a.name = "Tiger";
        System.out.println(a.name);
    }
}
```
**答：Compilation fails。** `protected` 成員在不同套件的子類別中，只能透過**繼承關係**存取，不能透過父型別參考（`a.name`）；縮減存取權限導致編譯失敗。

---

### Q36 MEDIUM）以下哪些方法可編譯？（Choose all that apply）
```
A. public List<? extends IOException> m1() { return new ArrayList<FileNotFoundException>(); }
B. public List<? super IOException> m2() { return new ArrayList<Exception>(); }
C. public List<? extends IOException> m3() { return new ArrayList<Exception>(); }
D. public List<? super IOException> m4() { return new ArrayList<FileNotFoundException>(); }
```
**答：A 與 B。** `FileNotFoundException` 為 `IOException` 子類別（`? extends` OK）；`Exception` 為其父類別（`? super` OK）。

---

### Q37 MEDIUM）下列程式的輸出為何？
```java
public class Sample {
    static int total;
    synchronized Sample() { total++; }
    public static void main(String[] args) throws InterruptedException {
        Runnable task = Sample::new;
        Thread t1 = new Thread(task); Thread t2 = new Thread(task);
        t1.start(); t2.start(); t1.join(); t2.join();
        System.out.println(total);
    }
}
```
**答：它是 1 或 2。** 建構子同步鎖為各自實例，未共享；`static total` 遞增無類別級同步 → 競態條件。

---

### Q38 MEDIUM）執行下列程式碼片段時發生什麼？
```java
ExecutorService service = Executors.newSingleThreadExecutor();
Runnable task = () -> System.out.println("Done");
service.submit(task);
service.shutdown();
service.submit(task);
```
**答：印 "Done" 一次後拋例外。** `shutdown()` 後不再接受新任務，第二次 `submit()` 丟 `RejectedExecutionException`。

---

### Q39 MEDIUM）哪個介面可作為 lambda 的目標（functional interface）？
```java
interface X { default void m1() {} }
interface Y extends X { static void m2() {} }
interface Z extends Y { void m1(); void m3(); }
interface W extends Z { void m4(); }
interface V extends W { default void m1() {} default void m3() {} }
```
**答：V。** functional interface 必須剛好一個 abstract method。V 提供 m1、m3 的 default，只剩 m4 為 abstract；Z、W 有多個 abstract 方法；X、Y 無 abstract。

---

### Q40 MEDIUM）下列程式碼能否編譯？
```java
var map = new HashMap<>();
map.put("A", 1);
map.put("B", 2);
map.put(3, "C");
```
**答：True（可編譯）。** `var` + `new HashMap<>()` 推斷為 `HashMap<Object, Object>`，keys/values 皆可用 String 或 Integer。

---

### Q41 MEDIUM）下列程式的輸出為何？
```java
var deque = new ArrayDeque<Integer>();
deque.add(10); deque.add(20); deque.add(30); deque.add(40);
System.out.print(deque.peek() + " ");
System.out.print(deque.poll() + " ");
System.out.print(deque.pop() + " ");
System.out.print(deque.element() + " ");
```
**答：`10 10 20 30`。** `peek` 取得不移除→10；`poll` 移除並回傳→10；`pop` 同 poll→20；`element` 取得不移除→30。

---

### Q42 MEDIUM）下列程式的輸出為何？
```java
Object input = 3.14;
String result = switch (input) {
    case String s  -> "It's a string: " + s;
    case Integer i -> "It's an integer: " + i;
    case Double d  -> "It's a double: " + d;
};
System.out.println(result);
```
**答：`It's a double: 3.14`。** `3.14` 是 `Double`，switch pattern matching 命中 `case Double d`。

---

### Q43 MEDIUM）下列程式發生什麼？
```java
var text = """
    Line one
    Line two
    Line three
    """;
for (int i = 0; i <= 3; i++) {
    System.out.println(text.lines().toList().get(i));
}
```
**答：列印前 3 行後拋例外。** `lines().toList()` 只有 3 個元素（index 0–2）；`i=3` 時 `get(3)` 丟 `IndexOutOfBoundsException`。

---

### Q44 MEDIUM）下列哪 3 個 statements 插入 main 後有效？（Choose three.）
```java
public class Demo {
    class Inner {}
    static class Nested {}
    public static void main(String[] args) { /* Insert here */ }
}
```
```
A. Inner i = new Inner();
B. Nested n = new Demo.Nested();
C. Inner i = new Demo().new Inner();
D. Nested n = new Nested();
E. Demo.Nested n = new Demo.Nested();
F. Inner i = new Demo.Inner();
```
**答：B、C、E。** non-static Inner 需外層實例 `new Demo().new Inner()`；static Nested 可用 `new Nested()` 或 `new Demo.Nested()`。

---

### Q45 MEDIUM）關於 Java Platform Module System，下列哪 3 個陳述正確？（Choose three.）
```
A. 具名模組中的程式碼可存取未具名模組中的 public 型別。
B. 未具名模組預設讀取所有具名模組。
C. 具名模組存取另一具名模組的 exported package 需明確 requires。
D. 從 Java 9 起所有 Java 應用程式都必須有 module descriptor。
E. 未具名模組會匯出（export）其所有套件。
F. 若某套件同時存在於兩個具名模組，應用程式會因 split package 衝突而失敗。
```
**答：C、E、F。** 具名模組需 `requires` 才能存取；未具名模組匯出全部套件；split package 在不同具名模組會造成衝突。具名模組無法存取未具名模組型別；module descriptor 為選用。

---

### Q46 MEDIUM）關於 `final` 類別，下列何者正確？
**答：`A final class cannot be subclassed`。** final 類別不能被繼承。它可實作介面、可繼承其他類別、不必含 final 方法。

---

### Q47 MEDIUM）下列程式的輸出為何？
```java
DoubleSummaryStatistics s1 = new DoubleSummaryStatistics();
s1.accept(1.5); s1.accept(2.5);
DoubleSummaryStatistics s2 = new DoubleSummaryStatistics();
s2.accept(3.0); s2.accept(4.0);
s1.combine(s2);
System.out.println("Sum: " + s1.getSum() + ", Max: " + s1.getMax() + ", Avg: " + s1.getAverage());
```
**答：`Sum: 11.0, Max: 4.0, Avg: 2.75`。** 合併後含 1.5、2.5、3.0、4.0；Sum=11、Max=4、Avg=2.75。

---

### Q48 MEDIUM）下列程式的輸出為何？
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
**答：`start close catch`。** try 拋例外後自動 `close()`；close() 的趲出變成 suppressed exception；原例外被 catch 印 "catch "。

---

### Q49 MEDIUM）下列程式的輸出為何？
```java
String block = """
    X
    Y
    Z
    """;
System.out.println(block.length());
```
**答：`6`。** text block 每行（含最後一行）最後的換行也算字元：`"X\nY\nZ\n"` = 3 字母 + 3 換行 = 6。

---

### Q50 MEDIUM）下列程式的輸出為何？
```java
DoubleStream stream = DoubleStream.of(1.1, 2.2, 6.6, 7.7);
Predicate<Double> p = d -> d > 5;
System.out.println(stream.allMatch(p));
```
**答：Compilation fails。** `DoubleStream.allMatch()` 需要 `DoublePredicate`，不是 `Predicate<Double>`。

---

### Q51 MEDIUM）下列程式的輸出為何？
```java
var count = 1;
do { System.out.print(count + " "); } while (count++ < 3);
```
**答：`1 2 3`。** 後置遞增以目前值判斷後才遞增，迴圈跑到 1、2、3。

---

### Q52 MEDIUM）下列程式的輸出為何？
```java
Map<String, Integer> map = Map.of("z", 3, "x", 1, "y", 2);
TreeMap<String, Integer> tree = new TreeMap<>(map);
System.out.println(tree);
```
**答：`{x=1, y=2, z=3}`。** `TreeMap` 依鍵的自然順序排序：x、y、z。

---

### Q53 MEDIUM）何時此方法會丟 `NullPointerException`？
```java
void check(Object obj) {
    boolean enabled = false;
    assert enabled = true;
    assert enabled;
    System.out.println(obj.toString());
    assert obj != null;
}
```
**答：僅當 assertion 停用且 obj 為 null。** 若 assertion 啟用且 obj null，最後 `assert obj != null` 會先失敗丟 `AssertionError`；若 assertion 停用則 `obj.toString()` 在 obj null 時丟 NPE。

---

### Q54 MEDIUM）下列片段的輸出為何？（假設檔案存在）
```java
Path path = Paths.get("/usr/local/bin/script.sh");
System.out.println(path.getName(0));
```
**答：`usr`。** name 元素不含 root：usr、local、bin、script.sh；index 0 = `usr`。

---

### Q55 MEDIUM）下列程式發生什麼？
```java
public class Palace {
    int rooms; int floors;
    void Palace() {                 // Line 1
        this.rooms = 10; this.floors = 3;
        System.out.println("Palace has " + rooms + " rooms.");
    }
    public static void main(String[] args) { var p = new Palace(); }  // Line 2
}
```
**答：Nothing is printed。** Line 1 是回傳型別為 `void` 的方法（非建構子，因建構子無回傳型別）；類別有預設 no-arg 建構子，執行後不做任何事；`Palace()` 方法從未被呼叫。

---

### Q56 MEDIUM）data.csv 內容：Header1、Header2、Row1、Row2、Row3、Row4。下列程式的輸出為何？
```java
final Stream<String> lines = Files.readAllLines(Paths.get("data.csv")).stream();
lines.skip(2).limit(2).forEach(System.out::println);
```
**答：`Row1 Row2`。** readAllLines 依序回傳所有行；`skip(2)` 跳過 Header1、Header2；`limit(2)` 取 Row1、Row2。

---

### Q57 MEDIUM）下列哪些方法可正確載入 PaymentService 的實作？（Choose all that apply）
```
A. PaymentService s = ServiceLoader.load(PaymentService.class).iterator().next();
B. PaymentService s = ServiceLoader.load(PaymentService.class).findFirst().get();
C. PaymentService s = ServiceLoader.getService(PaymentService.class);
D. PaymentService s = ServiceLoader.services(PaymentService.class).getFirstInstance();
```
**答：A 與 B。** `ServiceLoader.load()` 後可用 `iterator().next()` 或 Java 9+ 的 `findFirst()`（回傳 `Optional`）。無 `getService()`/`services().getFirstInstance()` 方法。

---

### Q58 MEDIUM）下列程式發生什麼？
```java
CopyOnWriteArrayList<Integer> list = new CopyOnWriteArrayList<>();
list.add(1); list.add(2); list.add(3);
new Thread(() -> { list.add(4); System.out.println("Added 4"); }).start();
new Thread(() -> { for (Integer i : list) { System.out.println("Read: " + i); } }).start();
```
**答：所有原始元素都會印出；迭代期間的修改可能看不到。** `CopyOnWriteArrayList` 在迭代開始時建立快照，writer 的修改不影響本次迭代，也不丟 `ConcurrentModificationException`。

---

### Q59 MEDIUM）下列哪個**不是**寫字串到檔案的合法方式？
```
A. Path path = Paths.get("output.txt"); Files.write(path, "Hello".getBytes());
B. try (BufferedWriter writer = new BufferedWriter(new FileWriter("output.txt"))) { writer.write("Hello"); }
C. try (FileOutputStream out = new FileOutputStream("output.txt")) { out.write("Hello"); }
D. try (PrintWriter pw = new PrintWriter("output.txt")) { pw.printf("Hello %s", "World"); }
E. try (FileWriter writer = new FileWriter("output.txt")) { writer.write("Hello"); }
```
**答：C。** `FileOutputStream.write()` 需 byte[] 或 int，傳 `String` 不編譯。其餘都能正確寫字串。

---

### Q60 MEDIUM）下列程式的輸出為何？
```java
int x = 4; int y = 4;
int post = x++ + 5;
int pre = ++y + 5;
System.out.println("post: " + post + ", pre: " + pre + ", final x: " + x + ", final y: " + y);
```
**答：`post: 9, pre: 10, final x: 5, final y: 5`。** `x++` 回傳 4 再變 5（4+5=9）；`++y` 先變 5 再回傳 5（5+5=10）。

---

### Q61 MEDIUM）下列程式的輸出為何？
```java
var num = 0;
do { System.out.print(num + " "); } while (++num < 3);
```
**答：`0 1 2`。** 前置遞增 `++num` 先遞增再比較：印 0（num→1）、印 1（num→2）、印 2（num→3）後條件 false。

---

### Q62 MEDIUM）下列程式的輸出為何？
```java
var brands = new String[]{"Gucci", "Prada", "Armani"};
var i = 0;
do { System.out.print(brands[i] + " "); } while (i++ > 0);
```
**答：`Gucci`。** 第一次迭代印 `Gucci`；條件 `i++ > 0` 回傳 0，0 > 0 為 false，迴圈結束（i 遞增為 1）。

---

### Q63 MEDIUM）下列程式的輸出為何？
```java
String block = """
    A\t
    B
    C
    """;
System.out.println(block.length());
```
**答：`8`。** text block 內容含開頭換行 + `A\t\n`（A+Tab+換行=3）+ `B\n`（2）+ `C\n`（2）= 1+3+2+2 = 8。

---

### Q64 MEDIUM）以下 `var` 宣告哪些無效？（Choose four.）
```
A. var a = 10;
B. var b = 1, c = 2;
C. var arr = new int[3];
D. var d;
E. var e = {1, 2, 3};
F. var f = null;
```
**答：B、D、E、F。** `var` 只能單一宣告、需初始值、array initializer 需 `new`、不能從 null 推斷。

---

### Q65 MEDIUM）下列程式發生什麼？
```java
import java.time.LocalDate;
public class Service {
    public static void main(String[] args) {
        Service s = new Service();
        String a = s.process();
        LocalDate d = s.process();
        System.out.println(a + " " + d);
    }
    public String process() { return "done"; }
    public LocalDate process() { return LocalDate.now(); }
}
```
**答：Compilation fails。** 方法多載不能只靠回傳型別區分，兩者參數相同僅回傳型別不同 → 編譯失敗。

---

### Q66 MEDIUM）`java.util.function` 中哪個 functional interface **不存在**？
```
A. IntSupplier   B. LongSupplier   C. DoubleSupplier
D. Supplier<T>   E. CharSupplier   F. They all exist
```
**答：E。** 標準 API 無 `CharSupplier`；`IntSupplier`、`LongSupplier`、`DoubleSupplier` 與通用 `Supplier<T>` 皆存在。

---

## Test 2（66 題，全部有效）

### Q1 MEDIUM）哪些 `var` 宣告無效？（Choose two.）
```
A. var x = 10;
B. var y = 10, z = 20;
C. var a;
D. var b = new int[]{1,2};
```
**答：B 與 C。** `var` 一次只能宣告一個變數且須有初始值；多重宣告與缺初始值無效。

---

### Q2 MEDIUM）下列程式的輸出為何？`int x = 2; int y = x++ + ++x; System.out.println(y);`
```
A. 6   B. 7   C. 8   D. Compilation fails
```
**答：`6`。** `x++` 回傳 2（x 變 3）；`++x` 先變 4 再回傳 4；2+4=6。

---

### Q3 EASY）下列程式的輸出為何？`for(int i=1;i<=3;i++){ if(i==2) continue; System.out.print(i); }`
```
A. 123   B. 13   C. 23   D. Compilation fails
```
**答：`13`。** `continue` 在 i==2 時跳過印出，輸出 1、3。

---

### Q4 MEDIUM）下列何者可被覆寫（overridden）？
```
A. private method   B. static method   C. final method   D. non-final instance method
```
**答：`non-final instance method`。** private/static 是隱藏（hiding）非覆寫；final 不可覆寫。

---

### Q5 EASY）哪個例外必須宣告或捕捉？
```
A. NullPointerException   B. IllegalArgumentException
C. IOException            D. RuntimeException
```
**答：`IOException`。** 是 checked exception，必須處理或宣告。

---

### Q6 EASY）哪個 Set 實作維持插入順序？
```
A. HashSet   B. TreeSet   C. LinkedHashSet   D. ConcurrentSkipListSet
```
**答：`LinkedHashSet`。**

---

### Q7 MEDIUM）哪個運算是惰性（lazy）的？
```
A. forEach()   B. count()   C. map()   D. collect()
```
**答：`map()`。** 是 intermediate（惰性）運算；終端運算才觸發執行。

---

### Q8 MEDIUM）哪個 statement 讓 service 在 module-info.java 中可用？
```
A. requires   B. exports   C. provides ... with   D. opens
```
**答：`provides ... with`。** 宣告 service implementation。

---

### Q9 EASY）哪個類別非同步地執行任務？
```
A. Thread   B. ExecutorService   C. Runnable   D. Callable
```
**答：`ExecutorService`。**

---

### Q10 EASY）哪個方法寫入 bytes 到檔案？
```
A. Files.write()   B. Files.readAllLines()   C. Path.of()   D. Files.list()
```
**答：`Files.write()`。**

---

### Q11 MEDIUM）哪個方法建立 PreparedStatement？
```
A. Connection.createStatement()   B. Connection.prepareStatement()
C. Statement.prepare()            D. DriverManager.prepare()
```
**答：`Connection.prepareStatement()`。**

---

### Q12 EASY）哪個類別在現代 Java API 中格式化日期？
```
A. SimpleDateFormat   B. DateFormat   C. DateTimeFormatter   D. Calendar
```
**答：`DateTimeFormatter`。** 屬 `java.time`。

---

### Q13 MEDIUM）關於 sealed classes，下列何者正確？
```
A. 它們防止所有子類別化   B. 只允許 permitted 子類別
C. 需要 abstract 方法      D. 不能是 public
```
**答：`只允許 permitted 子類別`。**

---

### Q14 EASY）輸出為何？`String s = "Java"; System.out.println(s.repeat(2));`
```
A. JavaJava   B. Java2   C. Compilation fails   D. Java Java
```
**答：`JavaJava`。**

---

### Q15 MEDIUM）哪個 primitive 型別**不能**隱式加寬到 long？
```
A. byte   B. short   C. int   D. char
```
**答（題目陷阱）：全部都能加寬。** boolean 是不可加寬的；所列皆可加寬。此為考題的誤導性選項。

---

### Q16 EASY）哪個 statement 退出整個迴圈？
```
A. continue   B. break   C. return   D. yield
```
**答：`break`。**

---

### Q17 EASY）哪個修飾詞允許**同套件內**存取？
```
A. public   B. protected   C. private   D. default
```
**答：`default`（package-private）。**

---

### Q18 EASY）哪個關鍵字用來實作介面？
```
A. extends   B. implements   C. inherits   D. super
```
**答：`implements`。**

---

### Q19 EASY）哪個 statement 建立客製例外？
```
A. class MyEx extends Exception {}
B. class MyEx implements Exception {}
C. class MyEx throws Exception {}
D. class MyEx inherits Exception {}
```
**答：A。** 客製例外要 extends `Exception` 或 `RuntimeException`。

---

### Q20 MEDIUM）哪個 Map 允許一個 null key？
```
A. HashMap   B. Hashtable   C. TreeMap   D. ConcurrentHashMap
```
**答：`HashMap`。** Hashtable 與 ConcurrentHashMap 不允許 null key。

---

### Q21 EASY）哪個方法移除並回傳 Deque 的第一個元素？
```
A. peek()   B. poll()   C. element()   D. getFirst()
```
**答：`poll()`。**

---

### Q22 EASY）哪個 functional interface 不帶參數並回傳值？
```
A. Supplier   B. Consumer   C. Function   D. Predicate
```
**答：`Supplier<T>`。**

---

### Q23 EASY）哪個 Stream 運算排序元素？
```
A. map()   B. sorted()   C. filter()   D. limit()
```
**答：`sorted()`。**

---

### Q24 MEDIUM）哪個 directive 對特定模組開放套件給 reflection？
```
A. exports   B. opens   C. opens to   D. requires
```
**答：`opens to`。**

---

### Q25 MEDIUM）哪個方法使執行緒暫時放棄 CPU？
```
A. sleep()   B. yield()   C. join()   D. wait()
```
**答：`yield()`。**

---

### Q26 MEDIUM）哪個關鍵字確保跨執行緒的可見性？
```
A. synchronized   B. volatile   C. final   D. static
```
**答：`volatile`。** 保證可見性但不保證原子性。

---

### Q27 EASY）哪個類別從檔案讀取字元？
```
A. FileInputStream   B. FileReader   C. ObjectInputStream   D. Path
```
**答：`FileReader`。**

---

### Q28 MEDIUM）哪個方法手動提交交易？
```
A. commit()   B. close()   C. rollback()   D. flush()
```
**答：`commit()`。**

---

### Q29 EASY）哪個方法復原交易？
```
A. commit()   B. rollback()   C. execute()   D. save()
```
**答：`rollback()`。**

---

### Q30 EASY）哪個類別代表貨幣？
```
A. Money   B. Currency   C. Locale   D. NumberFormat
```
**答：`Currency`。**

---

### Q31 EASY）哪個特性自動產生 equals 與 hashCode？
```
A. Enum   B. Record   C. Sealed   D. Module
```
**答：`Record`。**

---

### Q32 MEDIUM）哪個 pattern matching 簡化型別轉型？
```
A. switch   B. instanceof   C. record   D. lambda
```
**答：`instanceof` pattern matching。** 結合檢查與轉型。

---

### Q33 EASY）哪個 wrapper class 對應 primitive int？
```
A. Int   B. Integer   C. Number   D. Long
```
**答：`Integer`。**

---

### Q34 MEDIUM）哪個 statement 從 switch expression 回傳值？
```
A. break   B. yield   C. return   D. continue
```
**答：`yield`。**

---

### Q35 EASY）哪個關鍵字防止繼承？
```
A. abstract   B. final   C. sealed   D. private
```
**答：`final`。**

---

### Q36 MEDIUM）哪個方法把 Stream 轉為 List？
```
A. toList()   B. collect(Collectors.toList())   C. Both   D. None
```
**答：`Both`。** Java 16+ 支援 `toList()`。

---

### Q37 EASY）哪個運算限制元素數量？
```
A. limit()   B. skip()   C. distinct()   D. reduce()
```
**答：`limit(n)`。**

---

### Q38 EASY）哪個工具編譯模組？
```
A. jlink   B. javac   C. jar   D. jdeps
```
**答：`javac`。**

---

### Q39 MEDIUM）哪個類別支援平行串流執行？
```
A. Thread   B. ForkJoinPool   C. Executor   D. Callable
```
**答：`ForkJoinPool`。** 平行串流使用 common pool。

---

### Q40 EASY）哪個方法檢查路徑是否存在？
```
A. Files.exists()   B. Path.exists()   C. File.existsPath()   D. Files.check()
```
**答：`Files.exists()`。**

---

### Q41 EASY）哪個 primitive 型別存放 true/false？
```
A. int   B. boolean   C. char   D. byte
```
**答：`boolean`。**

---

### Q42 MEDIUM）輸出為何？`int x = 1; System.out.println(x++ + x++);`
```
A. 2   B. 3   C. 4   D. Compilation fails
```
**答：`3`。** 第一次 x++ 回傳 1（x 變 2）；第二次回傳 2（x 變 3）；1+2=3。

---

### Q43 EASY）迭代次數已知時最適合哪種迴圈？
```
A. while   B. do-while   C. for   D. foreach only
```
**答：`for`。**

---

### Q44 EASY）哪個關鍵字呼叫父類別建構子？
```
A. this   B. parent   C. super   D. base
```
**答：`super()`。**

---

### Q45 EASY）哪個介面方法必須被實作？
```
A. default method   B. static method   C. abstract method   D. private method
```
**答：`abstract method`**（除非類別為 abstract）。

---

### Q46 EASY）哪個 block 處理例外？
```
A. try   B. catch   C. finally   D. throw
```
**答：`catch`。**

---

### Q47 EASY）哪個 List 實作快速隨機存取？
```
A. ArrayList   B. LinkedList   C. Vector   D. Stack
```
**答：`ArrayList`。** O(1) index access。

---

### Q48 EASY）哪個 collection 不允許重複？
```
A. List   B. Set   C. Map   D. Queue
```
**答：`Set`。**

---

### Q49 MEDIUM）哪個方法聚合 stream 元素？
```
A. map()   B. filter()   C. reduce()   D. peek()
```
**答：`reduce()`。**

---

### Q50 EASY）哪個介面消費一個值而不回傳？
```
A. Supplier   B. Function   C. Consumer   D. Predicate
```
**答：`Consumer<T>`。**

---

### Q51 MEDIUM）哪個工具分析模組依賴？
```
A. javac   B. jlink   C. jdeps   D. jar
```
**答：`jdeps`。**

---

### Q52 EASY）哪個方法阻塞直到執行緒結束？
```
A. sleep()   B. join()   C. wait()   D. yield()
```
**答：`join()`。**

---

### Q53 MEDIUM）哪個 executor 建立單一背景執行緒？
```
A. newFixedThreadPool(1)   B. newSingleThreadExecutor()
C. newCachedThreadPool()   D. newWorkStealingPool()
```
**答：`newSingleThreadExecutor()`。**

---

### Q54 MEDIUM）哪個方法把檔案內容讀成 `Stream<String>`？
```
A. Files.readAllLines()   B. Files.lines()   C. Path.readLines()   D. File.stream()
```
**答：`Files.lines()`。**

---

### Q55 EASY）哪個物件執行 SQL statements？
```
A. Connection   B. Statement   C. ResultSet   D. Driver
```
**答：`Statement`。**

---

### Q56 MEDIUM）哪個方法關閉 auto-commit？
```
A. setAutoCommit(false)   B. disableCommit()
C. commit(false)           D. autoCommit(false)
```
**答：`setAutoCommit(false)`。**

---

### Q57 MEDIUM）哪個類別格式化緊湊數字？
```
A. NumberFormat.getInstance()
B. NumberFormat.getCompactNumberInstance()
C. DecimalFormat   D. Formatter
```
**答：`getCompactNumberInstance()`。** 格式化如 1K、1M。

---

### Q58 EASY）哪個類別代表時區？
```
A. ZoneId   B. Locale   C. Currency   D. Period
```
**答：`ZoneId`。**

---

### Q59 MEDIUM）哪個特性允許 switch 解構（deconstruction）？
```
A. Records   B. Pattern matching   C. Modules   D. Generics
```
**答：`Pattern matching`。**

---

### Q60 MEDIUM）permitted subclasses 必須宣告哪個修飾詞？
```
A. public only   B. final/sealed/non-sealed   C. abstract only   D. static
```
**答：`final/sealed/non-sealed`。**

---

### Q61 EASY）哪個關鍵字使類別只能繼承單一類別？
```
A. implements   B. extends   C. super   D. abstract
```
**答：`extends`。** Java 單一繼承。

---

### Q62 MEDIUM）哪個 Map 依鍵自然排序？
```
A. HashMap   B. TreeMap   C. LinkedHashMap   D. Hashtable
```
**答：`TreeMap`。**

---

### Q63 EASY）哪個方法移除 stream 重複？
```
A. filter()   B. distinct()   C. reduce()   D. peek()
```
**答：`distinct()`。**

---

### Q64 MEDIUM）哪個並行 collection 使用 lock-free segmentation？
```
A. HashMap   B. ConcurrentHashMap   C. TreeMap   D. ArrayList
```
**答：`ConcurrentHashMap`。**

---

### Q65 EASY）哪個 statement 重新拋出例外？
```
A. throw e;   B. throws e;   C. catch e;   D. retry e;
```
**答：`throw e;`。**

---

### Q66 MEDIUM）哪個工具建立客製 runtime image？
```
A. javac   B. jlink   C. jar   D. jdeps
```
**答：`jlink`。**

---

## Test 3（Q1–20 有效；Q21–66 為佔位符，略）

### Q1 MEDIUM）下列程式的輸出為何？
```java
sealed interface Vehicle permits Car, Truck {}
final class Car implements Vehicle {}
final class Truck implements Vehicle {}
Vehicle v = new Car();
String type = switch (v) {
    case Car c   -> "Passenger";
    case Truck t -> "Commercial";
};
System.out.println(type);
```
**答：`Passenger`。** sealed interface 只允許 Car 與 Truck；switch 涵蓋全部 permitted 型別，不需 default。`v` 為 Car → 印 "Passenger"。

---

### Q2 MEDIUM）下列程式發生什麼？
```java
Object obj = List.of("A", "B", "C");
switch (obj) {
    case List<String> list -> System.out.println(list.size());
    default -> System.out.println("Not a list");
}
```
**答：Compilation fails。** 泛型在 runtime 被 erasure，JVM 無法區分 `List<String>` 與 `List<Integer>`，pattern 無法驗證 → "illegal generic type for instanceof"。

---

### Q3 MEDIUM）try-with-resources 區塊退出時發生什麼？
```java
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    for (int i = 0; i < 100000; i++)
        executor.submit(() -> { Thread.sleep(Duration.ofSeconds(1)); return "Done"; });
}
```
**答：所有任務都在程式繼續前完成。** `ExecutorService` 實作 `AutoCloseable`；`close()` 先 `shutdown()` 並等所有任務完成。虛擬執行緒讓 100,000 個任務只需約 100 MB 記憶體。

---

### Q4 MEDIUM）下列程式的輸出為何？
```java
SequencedMap<String, Integer> map = new LinkedHashMap<>();
map.put("A", 1); map.put("B", 2); map.put("C", 3);
var reversed = map.reversed();
reversed.put("D", 4);
System.out.println(map);
System.out.println(reversed);
```
```
A. {A=1, B=2, C=3} / {D=4, C=3, B=2, A=1}
B. {D=4, A=1, B=2, C=3} / {C=3, B=2, A=1, D=4}
C. {A=1, B=2, C=3, D=4} / {D=4, C=3, B=2, A=1}
D. UnsupportedOperationException is thrown
E. {A=1, B=2, C=3} / {C=3, B=2, A=1}
```
**答：C。** `reversed()` 回傳 live view（非副本）；`reversed.put("D",4)` 加在原始 map 的**尾端**。

---

### Q5 MEDIUM）下列程式發生什麼？
```java
record Box<T>(T value) {}
Box<String> box = new Box<>("Hello");
if (box instanceof Box(String s)) { System.out.println(s.toUpperCase()); }
```
**答：Compilation fails。** 泛型被 erasure，JVM 無法驗證 component type `String`；record pattern 搭配泛型 record 不被支援。

---

### Q6 MEDIUM）下列程式發生什麼？
```java
Stream<String> stream = Stream.of("a", "b", "c");
List<String> list1 = stream.toList();
List<String> list2 = stream.collect(Collectors.toList());
```
**答：list1 為 `[a, b, c]`，之後丟 `IllegalStateException`。** 一個 stream 只能有一次終端運算；第二次操作已關閉的 stream 丟 "stream has already been operated upon or closed"。

---

### Q7 MEDIUM）下列程式的輸出為何？
```java
var text = """
    Line 1\
    Line 2
    """;
System.out.println(text);
```
**答：`Line 1Line 2`。** 行尾反斜線 `\` 抑制換行，把下一行直接接續。

---

### Q8 MEDIUM）下列程式的輸出為何？
```java
Integer value = 5;
String result = switch (value) {
    case null -> "Null";
    case 1, 2, 3 -> "Low";
    case 4, 5, 6 -> "Medium";
    case 7, 8, 9 -> "High";
    default -> "Other";
};
System.out.println(result);
```
**答：`Medium`。** value=5 落在 `4, 5, 6`。

---

### Q9 MEDIUM）下列程式的輸出為何？
```java
Thread t1 = Thread.ofVirtual().unstarted(() -> System.out.println("Task"));
System.out.println(t1.isVirtual());
t1.start();
t1.join();
```
**答：`true` 然後 `Task`。** `Thread.ofVirtual().unstarted()` 建立但未啟動；`isVirtual()` 回傳 true；`start()` 後印 "Task"。

---

### Q10 MEDIUM）下列程式的輸出為何？
```java
List<String> list = new ArrayList<>(List.of("A", "B", "C"));
String first = list.removeFirst();
String last = list.removeLast();
System.out.println(list + " " + first + " " + last);
```
**答：`[B] A C`。** `removeFirst()` 移除 A；`removeLast()` 移除 C；剩 `[B]`。輸出 `[B] A C`。

---

### Q11 MEDIUM）下列程式發生什麼？
```java
sealed class Parent permits Child {}
final class Child extends Parent {}
class GrandChild extends Child {}
```
**答：Compilation fails。** `GrandChild` 不能繼承 final 類別 `Child`；final 使階層在此結束。

---

### Q12 MEDIUM）下列程式的輸出為何？
```java
record Person(String name, int age) {}
Person p = new Person("Alice", 30);
if (p instanceof Person(var n, var a)) {
    System.out.println(n + " is " + a);
}
```
**答：`Alice is 30`。** record pattern 可用 `var` 讓編譯器從 record component 推斷型別。

---

### Q13 MEDIUM）下列程式的輸出為何？（假設 test.txt 起初不存在）
```java
Path path = Path.of("test.txt");
Files.writeString(path, "Hello", StandardOpenOption.CREATE, StandardOpenOption.APPEND);
Files.writeString(path, " World", StandardOpenOption.APPEND);
String content = Files.readString(path);
System.out.println(content);
```
**答：`Hello World`。** 第一次 `CREATE`+`APPEND` 寫 "Hello"；第二次 `APPEND` 加 " World"。

---

### Q14 MEDIUM）若 users 表沒有名為 "name" 的欄位，下列程式發生什麼？
```java
String sql = "SELECT * FROM users WHERE id = ? AND status = ?";
try (PreparedStatement ps = conn.prepareStatement(sql)) {
    ps.setInt(1, 100); ps.setString(2, "ACTIVE");
    ResultSet rs = ps.executeQuery();
    if (rs.next()) System.out.println(rs.getString("name"));
}
```
**答：`SQLException`。** 存取不存在的欄位丟 `SQLException`（"Column 'name' not found"）。

---

### Q15 MEDIUM）German locale（de_DE）下 `nf.format(1234.56)` 的預期輸出格式為何？
```java
Locale locale = Locale.of("de", "DE");
NumberFormat nf = NumberFormat.getCurrencyInstance(locale);
System.out.println(nf.format(1234.56));
```
**答：`1.234,56 EUR`。** de_DE 用歐元符號、週期點為千分位、逗號為小數點、符號在金額後加空格。

---

### Q16 MEDIUM）下列程式的輸出為何？
```java
class Resource1 implements AutoCloseable { public void close() { System.out.print("R1 "); } }
class Resource2 implements AutoCloseable { public void close() { System.out.print("R2 "); } }
try (Resource1 r1 = new Resource1(); Resource2 r2 = new Resource2()) {
    System.out.print("Try ");
}
```
**答：`Try R2 R1`。** try-with-resources 以**宣告的相反順序**關閉資源：r2 先、r1 後。

---

### Q17 MEDIUM）另一模組宣告 `requires com.app;`。哪些模組可被該模組讀取？
```java
module com.app {
    requires java.sql;
    requires transitive java.logging;
    exports com.app.api;
}
```
**答：`com.app` 與 `java.logging`。** `requires transitive` 建立 implied readability，其他模組也隱式需求 `java.logging`；一般 `requires java.sql` 非 transitive，不能被其他模組讀取。

---

### Q18 MEDIUM）下列程式的輸出為何？
```java
Optional<String> opt = Optional.ofNullable(null);
String result = opt.orElse("Default");
System.out.println(result);
```
**答：`Default`。** `ofNullable(null)` 建立空 `Optional`；`orElse` 回傳 default。

---

### Q19 MEDIUM）下列程式的輸出為何？
```java
var list = List.of(1, 2, 3);
var first = list.get(0);
System.out.println(first.getClass().getName());
```
**答：`java.lang.Integer`。** `List.of(1,2,3)` 為 `List<Integer>`；`get(0)` 因泛型/autoboxing 回傳 `Integer`。

---

### Q20 MEDIUM）下列程式發生什麼？
```java
sealed interface Animal {}
record Dog(String name) implements Animal {}
```
**答：Compilation fails。** sealed interface 必須用 `permits` 指定允許的實作；無 `permits` 則無人可實作。

---

## Test 4（Q1–3 有效；Q4–66 為佔位符，略）

### Q1 MEDIUM）下列程式的輸出為何？
```java
Object obj = "Test";
switch (obj) {
    case Integer i when i > 0 -> System.out.println("Positive: " + i);
    case Integer i -> System.out.println("Non-positive: " + i);
    case String s when s.length() > 5 -> System.out.println("Long string: " + s);
    case String s -> System.out.println("Short string: " + s);
    default -> System.out.println("Other");
}
```
**答：`Short string: Test`。** guarded pattern 逐步求值：前兩個 Integer pattern 對 String 失敗；`case String s when s.length() > 5` 型別符合但 guard（"Test".length()=4>5）失敗；最後 `case String s` 無 guard 命中。

---

### Q2 MEDIUM）下列程式的輸出為何？
```java
Thread platformThread = Thread.ofPlatform().name("platform-thread")
    .start(() -> System.out.println(Thread.currentThread().isVirtual()));
Thread virtualThread = Thread.ofVirtual().name("virtual-thread")
    .start(() -> System.out.println(Thread.currentThread().isVirtual()));
platformThread.join(); virtualThread.join();
```
**答：`false true`。** platform thread 的 `isVirtual()` 為 false；virtual thread 的為 true。

---

### Q3 MEDIUM）下列程式的輸出為何？
```java
Deque<String> deque = new ArrayDeque<>();
deque.addFirst("A"); deque.addLast("B");
deque.addFirst("C"); deque.addLast("D");
String first = deque.removeFirst();
String last = deque.removeLast();
System.out.println(deque + " " + first + " " + last);
```
**答：`[A, B] C D`。** addFirst/addLast 依序得 `[C, A, B, D]`；removeFirst→C、removeLast→D；剩 `[A, B]`。輸出 `[A, B] C D`。

---

## Test 5（66 題，全部有效）

### Q1 MEDIUM）以下 `var` 宣告哪些無效？（Choose two.）
```
A. var a = 10;
B. var b;
C. var c = null;
D. var d = new String("Java");
```
**答：B 與 C。** `var` 需初始值，且不能從 `null` 推斷型別。

---

### Q2 MEDIUM）下列程式的輸出為何？
```java
int x = 5;
int y = ++x + x++;
System.out.println(y);
```
```
A. 11   B. 12   C. 13   D. Compilation fails
```
**答：`12`。** `++x`→x=6 回傳 6；`x++`→回傳 6 再 x=7；6+6=12。

---

### Q3 MEDIUM）下列程式的輸出為何？
```java
int i = 0;
do { System.out.print(i); } while(++i < 3);
```
```
A. 012   B. 123   C. 01   D. Compilation fails
```
**答：`012`。** 前置遞增先遞增再比較：印 0（i→1）、印 1（i→2）、印 2（i→3）後 false。

---

### Q4 MEDIUM）關於方法覆寫，下列何者正確？
```
A. 回傳型別必須完全相同   B. 回傳型別可為 covariant
C. 存取修飾詞可更嚴格     D. static 方法會被覆寫
```
**答：B。** 覆寫允許 covariant 回傳型別；存取修飾詞不可更嚴格；static 是隱藏非覆寫。

---

### Q5 EASY）下列程式的輸出為何？
```java
try { throw new RuntimeException(); }
catch(Exception e) { System.out.print("A"); }
finally { System.out.print("B"); }
```
```
A. AB   B. BA   C. B   D. Compilation fails
```
**答：`AB`。** 例外被接住印 A；finally 印 B。

---

### Q6 EASY）哪個 collection 維持自然排序？
```
A. HashSet   B. TreeSet   C. LinkedHashSet   D. ArrayList
```
**答：`TreeSet`。**

---

### Q7 MEDIUM）下列程式的輸出為何？
```java
Stream.of(1,2,3).filter(i -> i > 1).map(i -> i * 2).forEach(System.out::print);
```
```
A. 123   B. 46   C. 24   D. Compilation fails
```
**答：`46`。** filter 留 2、3；map 乘 2 得 4、6。

---

### Q8 EASY）哪個 directive 在 module-info.java 匯出套件？
```
A. requires   B. open   C. exports   D. provides
```
**答：`exports`。**

---

### Q9 EASY）哪個關鍵字防止方法被多執行緒同時存取？
```
A. volatile   B. transient   C. synchronized   D. final
```
**答：`synchronized`。**

---

### Q10 EASY）哪個類別用來序列化物件？
```
A. FileWriter   B. ObjectOutputStream   C. BufferedWriter   D. DataOutputStream
```
**答：`ObjectOutputStream`。**

---

### Q11 EASY）哪個 JDBC 介面代表資料庫連線？
```
A. Statement   B. Connection   C. ResultSet   D. Driver
```
**答：`Connection`。**

---

### Q12 EASY）哪個類別用於 locale 特定數字格式化？
```
A. DecimalFormat   B. NumberFormat   C. Formatter   D. Locale
```
**答：`NumberFormat`。**

---

### Q13 EASY）哪個特性允許 switch 的 pattern matching？
```
A. Records   B. Text Blocks   C. Pattern Matching for switch   D. Modules
```
**答：`Pattern Matching for switch`。**

---

### Q14 EASY）下列程式的輸出為何？
```java
String s = "  Java  ";
System.out.print("[" + s.strip() + "]");
```
```
A. [  Java  ]   B. [Java]   C. [ Java ]   D. Compilation fails
```
**答：`[Java]`。** `strip()` 移除前後 Unicode 空白；`trim()` 不支援 Unicode。

---

### Q15 EASY）下列程式的輸出為何？`int a = 10; int b = 20; System.out.println(a > b ? "A" : "B");`
```
A. A   B. B   C. Compilation fails   D. Runtime exception
```
**答：`B`。** 10 > 20 false → 回傳 "B"。

---

### Q16 MEDIUM）關於 switch expression 何者正確？
```
A. break 是必要的   B. 從 block 回傳值用 yield
C. Switch expression 不能回傳值   D. Switch expression 需要 default
```
**答：B。** switch expression 可回傳值；block 形式用 `yield`；break 不適用於 expression 形式。

---

### Q17 EASY）哪個關鍵字防止類別被繼承？
```
A. static   B. abstract   C. final   D. sealed
```
**答：`final`。**

---

### Q18 MEDIUM）下列哪些可編譯？（Choose two.）
```
A. List<? extends Number> l = new ArrayList<Integer>();
B. List<? super Integer> l = new ArrayList<Number>();
C. List<Number> l = new ArrayList<Integer>();
D. List<Integer> l = new ArrayList<Number>();
```
**答：A 與 B。** 泛型 invariant；`? extends` 允許子類別、`? super` 允許父類別；直接 `List<Number> = ArrayList<Integer>` 不編譯。

---

### Q19 EASY）哪個例外是 unchecked？
```
A. IOException   B. SQLException   C. NullPointerException   D. InterruptedException
```
**答：`NullPointerException`。**

---

### Q20 EASY）哪個方法取得但不移除 Queue 的 head？
```
A. poll()   B. remove()   C. peek()   D. pop()
```
**答：`peek()`。**

---

### Q21 EASY）哪個 intermediate operation 回傳 Stream？
```
A. forEach()   B. count()   C. map()   D. reduce()
```
**答：`map()`。** forEach、count、reduce 為終端運算。

---

### Q22 EASY）下列程式的輸出為何？
```java
Optional<String> o = Optional.of("Java");
System.out.println(o.orElse("Default"));
```
```
A. Java   B. Default   C. null   D. Compilation fails
```
**答：`Java`。**

---

### Q23 EASY）哪個 directive 宣告對另一模組的依賴？
```
A. exports   B. requires   C. opens   D. uses
```
**答：`requires`。**

---

### Q24 EASY）哪個介面代表回傳值的任務？
```
A. Runnable   B. Callable   C. Supplier   D. Executor
```
**答：`Callable`。**

---

### Q25 MEDIUM）哪個類別在無 `ConcurrentModificationException` 下執行緒安全地迭代？
```
A. ArrayList   B. HashMap   C. CopyOnWriteArrayList   D. TreeSet
```
**答：`CopyOnWriteArrayList`。** 使用 snapshot iteration。

---

### Q26 EASY）哪個類別屬於 NIO？
```
A. File   B. Path   C. FileReader   D. BufferedWriter
```
**答：`Path`。** 屬於 `java.nio.file`。

---

### Q27 EASY）哪個方法執行 SELECT？
```
A. executeUpdate()   B. executeQuery()   C. execute()   D. runQuery()
```
**答：`executeQuery()`。**

---

### Q28 EASY）哪個物件保存查詢結果？
```
A. Connection   B. Statement   C. ResultSet   D. DriverManager
```
**答：`ResultSet`。**

---

### Q29 EASY）哪個類別代表特定地理區域以格式化？
```
A. ZoneId   B. Locale   C. Currency   D. DateFormat
```
**答：`Locale`。**

---

### Q30 MEDIUM）關於 records 何者正確？
```
A. 它們可繼承另一類別   B. 它們隱式繼承 java.lang.Record
C. 它們不能實作介面     D. 允許 mutable components
```
**答：B。**

---

### Q31 MEDIUM）下列程式的輸出為何？
```java
int a = 4;
int b = a++ * 2;
System.out.println(b + " " + a);
```
```
A. 8 4   B. 8 5   C. 10 5   D. Compilation fails
```
**答：`8 5`。** a++ 用 4 再 a=5；4×2=8。

---

### Q32 EASY）哪個關鍵字跳過目前迴圈迭代？
```
A. break   B. continue   C. return   D. yield
```
**答：`continue`。**

---

### Q33 EASY）關於建構子何者正確？
```
A. 可回傳型別   B. 可為 abstract   C. 沒有回傳型別   D. 必須 public
```
**答：C。**

---

### Q34 EASY）哪個 block 一定執行？
```
A. try   B. catch   C. finally   D. throw
```
**答：`finally`。**

---

### Q35 MEDIUM）哪個 List 實作是 synchronized？
```
A. ArrayList   B. LinkedList   C. Vector   D. CopyOnWriteArrayList
```
**答：`Vector`。**

---

### Q36 EASY）哪個終端運算回傳 Optional？
```
A. count()   B. findFirst()   C. forEach()   D. map()
```
**答：`findFirst()`。**

---

### Q37 MEDIUM）哪個關鍵字允許 module 中的 reflective access？
```
A. exports   B. requires   C. opens   D. provides
```
**答：`opens`。**

---

### Q38 EASY）哪個方法等待執行緒完成？
```
A. sleep()   B. join()   C. wait()   D. yield()
```
**答：`join()`。**

---

### Q39 EASY）哪個方法讀取檔案所有行？
```
A. Files.read()   B. Files.readAllLines()   C. File.readLines()   D. Path.read()
```
**答：`Files.readAllLines()`。**

---

### Q40 EASY）哪個 JDBC 方法修改資料庫資料？
```
A. executeQuery()   B. executeUpdate()   C. executeSelect()   D. fetch()
```
**答：`executeUpdate()`。** 用於 INSERT、UPDATE、DELETE。

---

### Q41 EASY）哪個類別載入 JDBC drivers？
```
A. Connection   B. DriverManager   C. Statement   D. Database
```
**答：`DriverManager`。**

---

### Q42 MEDIUM）哪個方法依 locale 格式化貨幣？
```
A. NumberFormat.getCurrencyInstance()
B. Currency.getInstance()
C. Formatter.currency()
D. Locale.currency()
```
**答：`getCurrencyInstance()`。**

---

### Q43 MEDIUM）哪個關鍵字限制子類別為特定型別？
```
A. final   B. sealed   C. abstract   D. static
```
**答：`sealed`。**

---

### Q44 MEDIUM）permitted subclasses 必須宣告哪個修飾詞？
```
A. static   B. volatile   C. final/sealed/non-sealed   D. abstract only
```
**答：C。**

---

### Q45 MEDIUM）哪個 collector 分組元素？
```
A. Collectors.toList()   B. Collectors.groupingBy()
C. Collectors.joining()  D. Collectors.counting()
```
**答：`groupingBy()`。**

---

### Q46 EASY）哪個 functional interface 接受兩個參數回傳結果？
```
A. Function   B. BiFunction   C. Predicate   D. Supplier
```
**答：`BiFunction<T,U,R>`。**

---

### Q47 EASY）哪個存取修飾詞最嚴格？
```
A. public   B. protected   C. default   D. private
```
**答：`private`。**

---

### Q48 EASY）哪個關鍵字允許繼承？
```
A. implements   B. extends   C. inherits   D. super
```
**答：`extends`。**

---

### Q49 EASY）哪個迴圈保證至少執行一次？
```
A. for   B. while   C. do-while   D. foreach
```
**答：`do-while`。**

---

### Q50 MEDIUM）哪個是合法的 text block 宣告？
```
A. String s = """Hello""";
B. String s = """\nHello\n""";
C. String s = """Hello;
D. Text s = "Hello";
```
**答：B。** text block 開頭 `"""` 後須立即換行，A（`"""Hello"""`）因缺少換行而編譯失敗。B 以 `\n` 提供開啟分隔符後的換行，且內容含前後換行，符合 "Hello" 前後各一換行的語意。

---

### Q51 MEDIUM）哪個方法排序 List？
```
A. Collections.sort()   B. List.sort()   C. Both   D. None
```
**答：`Both`。**

---

### Q52 EASY）哪個方法暫停執行緒？
```
A. wait()   B. join()   C. sleep()   D. yield()
```
**答：`sleep()`。**

---

### Q53 EASY）哪個是終端運算？
```
A. filter()   B. map()   C. sorted()   D. collect()
```
**答：`collect()`。**

---

### Q54 MEDIUM）哪個類別依 locale 處理日期格式化？
```
A. DateTimeFormatter   B. DateFormat   C. LocalDate   D. ZoneId
```
**答：`DateFormat`。**

---

### Q55 EASY）哪個介面代表檔案路徑抽象？
```
A. File   B. Path   C. Stream   D. URI
```
**答：`Path`。**

---

### Q56 EASY）哪個關鍵字參考父類別？
```
A. this   B. parent   C. super   D. base
```
**答：`super`。**

---

### Q57 EASY）哪個特性減少 data carrier 的 boilerplate？
```
A. Enums   B. Records   C. Sealed classes   D. Modules
```
**答：`Records`。**

---

### Q58 MEDIUM）instanceof 的 pattern matching 允許什麼？
```
A. 自動轉型   B. 多重繼承   C. Checked exceptions   D. 平行執行
```
**答：`自動轉型`（自動 cast）。**

---

### Q59 EASY）哪個並行 map 實作存在？
```
A. HashMap   B. ConcurrentHashMap   C. TreeMap   D. WeakHashMap
```
**答：`ConcurrentHashMap`。**

---

### Q60 MEDIUM）哪個介面允許 LIFO 操作？
```
A. Queue   B. Deque   C. Set   D. Map
```
**答：`Deque`。** 支援 stack（LIFO）與 queue（FIFO）。

---

### Q61 EASY）哪個 statement 明確拋出例外？
```
A. try   B. throw   C. catch   D. finally
```
**答：`throw`。**

---

### Q62 EASY）哪個關鍵字退出方法？
```
A. break   B. continue   C. exit   D. return
```
**答：`return`。**

---

### Q63 EASY）哪個 primitive 型別是 64-bit 浮點數？
```
A. float   B. double   C. int   D. long
```
**答：`double`。**

---

### Q64 EASY）哪個關鍵字定義介面？
```
A. class   B. interface   C. abstract   D. implements
```
**答：`interface`。**

---

### Q65 EASY）哪個 functional interface 回傳 boolean？
```
A. Supplier   B. Predicate   C. Function   D. Consumer
```
**答：`Predicate<T>`。**

---

### Q66 MEDIUM）哪個工具把模組打包成 runtime image？
```
A. javac   B. jar   C. jlink   D. javadoc
```
**答：`jlink`。**

---

## 高頻考點速記

- **`var`**：需初始值、不能從 null 推斷、array 需 `new`、一次只宣告一個變數。
- **Sealed class/interface**：子類別須宣告 final/sealed/non-sealed；`permits` 不可省略。
- **Record**：不能加 instance field、不能 extends 類別、可實作介面、可含 static field、可與 pattern/`var` 搭配。
- **Pattern matching for switch**：型別 pattern 依序比對；可用 guard（`when`）；泛型 pattern 因 erasure 不合法。
- **後置 vs 前置遞增**：`x++` 用目前值後遞增；`++x` 先遞增後用目前值。
- **泛型不可變性（invariance）**：`List<Number>` 非 `List<Integer>` 之子型別；用 `? extends`（讀）/`? super`（寫）補足。
- **lambda 適用性**：functional interface（恰好一個 abstract method）才能用 lambda。
- **例外覆蓋**：`finally` 拋出之例外覆蓋先前所有例外；TWR 中 `close()` 例外為 suppressed。
- **Period vs Duration**：`Period`（日期、`LocalDate`）；`Duration`（時間、需 time-based 型別）。
- **Sealed + switch exhaustiveness**：涵蓋全部 permitted 子型別時不需 default。
- **Stream**：intermediate 惰性（map/filter/sorted/limit/skip/distinct）、terminal 觸發（forEach/count/reduce/collect/findFirst）。
- **Virtual Threads**：`Thread.ofVirtual()`、輕量、`ExecutorService` 搭配 try-with-resources 自動等待完成。
- **Sequenced Collections**：`reversed()` 回傳 live view；`getFirst()`/`getLast()`、`removeFirst()`/`removeLast()`。
- **text block**：開頭 `"""` 後換行；內含每行尾換行；行尾 `\` 抑制換行。
- **ConcurrentHashMap**：`(int initialCapacity, float loadFactor, int concurrencyLevel)`。

---

## 備考資源
- 練習測驗首頁：https://javainuse.com/cert/1z0830
- 練習測驗（Test 1–5）：https://javainuse.com/cert/1z0830/quiz
- 主題筆記：https://javainuse.com/cert/1z0830/prep