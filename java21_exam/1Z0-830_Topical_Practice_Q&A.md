# 1Z0-830 Java SE 21 — 主題分類練習題（附完整答案）

> 來源：javainuse.com Practice Test 1（66 題）彙整，依考試主題分類。  
> 格式：每題含程式碼、選項（✅ = 正確答案）、解析。  
> 整理時間：2026-09-17

---

## 目錄

| # | 主題 | 題數 |
|---|------|------|
| 1 | [語言基礎（var、運算子、迴圈、assert）](#1-語言基礎) | 10 |
| 2 | [物件導向（封裝、繼承、介面、sealed、records）](#2-物件導向) | 12 |
| 3 | [泛型與萬用字元（Wildcards）](#3-泛型與萬用字元) | 4 |
| 4 | [集合框架（Collections）](#4-集合框架) | 7 |
| 5 | [函式式編程（Lambda、Stream、Optional）](#5-函式式編程) | 8 |
| 6 | [日期時間 API](#6-日期時間-api) | 3 |
| 7 | [文字塊與字串（Text Block、String）](#7-文字塊與字串) | 4 |
| 8 | [模組系統（JPMS）](#8-模組系統jpms) | 3 |
| 9 | [並行（Concurrency）](#9-並行concurrency) | 4 |
| 10 | [I/O、路徑與序列化](#10-io路徑與序列化) | 5 |
| 11 | [Switch 與 Pattern Matching（Java 21）](#11-switch-與-pattern-matching) | 2 |
| 12 | [例外處理與 try-with-resources](#12-例外處理與-try-with-resources) | 3 |
| 13 | [其他 Java 21 新特性](#13-其他-java-21-新特性) | 1 |

---

## 1. 語言基礎

### Q1-1 `var` 無效宣告（選三）

以下哪些 `var` 區域變數宣告**無效**？（Choose three）

```java
A. var x = 10;
B. var y;
C. var z = null;
D. var a = {1, 2, 3};
E. var b = new int[]{1, 2, 3};
F. var c = (d = 5);
```

> ✅ **答：B、C、D**  
> - B：`var` 必須有初始值  
> - C：無法從 `null` 推斷型別  
> - D：array initializer 需搭配 `new`

---

### Q1-2 `var` 無效宣告（選四）

以下哪些 `var` 宣告**無效**？（Choose four）

```java
A. var a = 10;
B. var b = 1, c = 2;
C. var arr = new int[3];
D. var d;
E. var e = {1, 2, 3};
F. var f = null;
```

> ✅ **答：B、D、E、F**  
> - B：`var` 一次只能宣告一個變數  
> - D：缺少初始值  
> - E：array initializer 需 `new`  
> - F：無法從 `null` 推斷

---

### Q1-3 底線識別字

```java
var _ = 5;
var $ = 9;
System.out.println(_ + $);
```

選項：A. 14　B. _$　C. Compilation fails　D. An exception

> ✅ **答：C — Compilation fails**  
> Java 9 起單一底線 `_` 不能用作識別字。

---

### Q1-4 後置遞增 do-while

```java
var count = 1;
do { System.out.print(count + " "); } while (count++ < 3);
```

選項：A. 1 2 3　B. 1 2　C. 1 2 3 4　D. 2 3

> ✅ **答：A — 1 2 3**  
> 後置遞增以**目前值**判斷後才遞增；迴圈跑 count=1、2、3，第三次判斷 `3 < 3` 為 false 結束。

---

### Q1-5 前置遞增 do-while

```java
var num = 0;
do { System.out.print(num + " "); } while (++num < 3);
```

選項：A. 0 1 2　B. 1 2 3　C. 0 1 2 3　D. 1 2

> ✅ **答：A — 0 1 2**  
> 前置遞增先加後比較：印 0（num→1, 1<3 繼續）、印 1（num→2）、印 2（num→3, 3<3 false）。

---

### Q1-6 do-while 條件為 false

```java
var brands = new String[]{"Gucci", "Prada", "Armani"};
var i = 0;
do { System.out.print(brands[i] + " "); } while (i++ > 0);
```

選項：A. Gucci　B. Gucci Prada Armani　C. ArrayIndexOutOfBoundsException　D. Compilation fails

> ✅ **答：A — Gucci**  
> 第一次迭代印 "Gucci"；條件 `i++ > 0` 當下 i=0，0>0 為 false，迴圈即結束。

---

### Q1-7 前後置遞增計算

```java
int x = 4; int y = 4;
int post = x++ + 5;
int pre = ++y + 5;
System.out.println("post: " + post + ", pre: " + pre + ", final x: " + x + ", final y: " + y);
```

選項：A. post: 9, pre: 10, final x: 5, final y: 5　B. post: 10, pre: 9, final x: 5, final y: 4

> ✅ **答：A — post: 9, pre: 10, final x: 5, final y: 5**  
> `x++` 回傳 4（x=5）；`++y` 先變 5 再回傳 5。

---

### Q1-8 方法多載不能只靠回傳型別

```java
public class Service {
    public static void main(String[] args) {
        Service s = new Service();
        String a = s.process();
        LocalDate d = s.process();
    }
    public String process() { return "done"; }
    public LocalDate process() { return LocalDate.now(); }
}
```

選項：A. 正常執行　B. Compilation fails　C. Runtime exception

> ✅ **答：B — Compilation fails**  
> 方法多載不能只靠**回傳型別**區分，兩者參數相同 → 編譯失敗。

---

### Q1-9 void 方法 vs 建構子

```java
public class Palace {
    int rooms; int floors;
    void Palace() { this.rooms = 10; System.out.println("Palace has " + rooms + " rooms."); }
    public static void main(String[] args) { var p = new Palace(); }
}
```

選項：A. Palace has 10 rooms.　B. Nothing is printed　C. Compilation fails at Line 1

> ✅ **答：B — Nothing is printed**  
> `void Palace()` 是回傳型別為 void 的**方法**（非建構子）；`new Palace()` 呼叫的是預設 no-arg 建構子，不執行任何事。

---

### Q1-10 assert 與 NullPointerException

```java
void check(Object obj) {
    boolean enabled = false;
    assert enabled = true;
    assert enabled;
    System.out.println(obj.toString());
    assert obj != null;
}
```

何時丟 `NullPointerException`？

> ✅ **答：僅當 assertion 停用且 obj 為 null**  
> assertion 啟用時，`assert obj != null` 在 obj=null 時先丟 AssertionError；停用時 `obj.toString()` 直接丟 NPE。

---

## 2. 物件導向

### Q2-1 Sealed Class 編譯（選二）

以下哪些 sealed class 宣告可**編譯**？（Choose two）

```
A. sealed class Shape permits Circle {} final class Circle extends Shape {}
B. sealed class Shape permits Circle {} class Circle extends Shape {}
C. public sealed class Shape permits Circle, Square {}
   final class Circle extends Shape {} non-sealed class Square extends Shape {}
D. public sealed class Shape {} final class Circle extends Shape {}
```

> ✅ **答：A、C**  
> 繼承 sealed class 的子類別必須宣告 `final`、`sealed` 或 `non-sealed`；`permits` 不可省略。B 子類別未宣告限制詞；D 缺少 `permits`。

---

### Q2-2 介面 static 方法 vs default 方法

```java
interface Parent { default void print() { System.out.print("parent"); } }
interface Child extends Parent { static void print() { System.out.print("child"); } }
public class TestInterfaces {
    public static void main(String[] args) { Child.print(); }
}
```

選項：A. parent　B. child　C. Compilation fails　D. Nothing

> ✅ **答：B — child**  
> 介面的 `static` 方法不繼承；`Child.print()` 呼叫的是 Child 自己的 static 方法。

---

### Q2-3 介面常數與繼承

```java
public class AdvancedCalc extends BaseCalc implements Extra {
    int compute() { return value - bonus; }
    public static void main(String[] args) { System.out.println(new AdvancedCalc().compute()); }
}
class BaseCalc { int value = 5; }
interface Extra { int bonus = 3; }
```

選項：A. 2　B. 3　C. 8　D. Compilation fails

> ✅ **答：A — 2**  
> `bonus` 是介面的 `public static final` 常數（值 3）；`value` 繼承自 BaseCalc（值 5）；5-3=2。

---

### Q2-4 介面方法存取修飾子

```java
interface Device { boolean isOn(); }
class Laptop implements Device {
    boolean power;
    boolean isOn() { power = power; return power; }
}
```

選項：A. Laptop 不編譯　B. 一切正常編譯　C. 介面不編譯

> ✅ **答：A — Laptop 不編譯**  
> 介面方法隱式 `public`，實作時降低為 package-private 是縮減存取 → 編譯失敗。

---

### Q2-5 非 static 內部類別建立

```java
public class Container {
    String message = "Hello";
    class Inner { void print() { System.out.println(message); } }
    public static void main(String[] args) {
        Container c = new Container();
        Inner i = new Inner();  // Line 1
        i.print();
    }
}
```

> ✅ **答：Line 1 編譯失敗**  
> 非 static 內部類別需外層實例，需寫 `c.new Inner()`。

---

### Q2-6 Records 編譯（選二）

哪些 records 可**編譯**？（Choose two）

```
A. record ARecord(int x) { int y; }
B. record BRecord(int x) { static int y; }
C. record CRecord(int x) extends RuntimeException {}
D. record DRecord(int x) implements Runnable { public void run() {} }
```

> ✅ **答：B、D**  
> - A：record 不能加額外 instance field  
> - C：record 隱式繼承 `java.lang.Record`，不可再 extends  
> - B：可含 static field；D：可實作介面

---

### Q2-7 Inner/Static Nested 類別建立（選三）

```java
public class Demo {
    class Inner {}
    static class Nested {}
    public static void main(String[] args) { /* 哪三個有效？ */ }
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

> ✅ **答：B、C、E**（若 static context）  
> 非 static 內部類別需外層實例：`new Demo().new Inner()`；static Nested 可用 `new Nested()` 或 `new Demo.Nested()`。

---

### Q2-8 Final Class

關於 `final class`，下列何者正確？

```
A. final 關鍵字須放在 class 後面
B. final class 必須宣告至少一個 final 方法
C. final class 不能被繼承
D. final class 不能實作介面
E. final class 不能繼承其他類別
```

> ✅ **答：C — final class 不能被繼承**  
> 可實作介面、可繼承其他類別、不必含 final 方法。

---

### Q2-9 Protected 存取（不同套件的子類別）

```java
// package zoo.animal
public class Animal { protected String name = "Lion"; }
// package zoo.caretaker
public class Keeper extends Animal {
    public static void main(String[] args) {
        Animal a = new Animal();
        a.name = "Tiger";          // 透過父類別參考
    }
}
```

> ✅ **答：Compilation fails**  
> 不同套件的子類別中，`protected` 成員只能透過**繼承關係**存取，不能透過父型別參考。

---

### Q2-10 Predicate 哪些是 default 方法（選全部）

`java.util.function.Predicate` 中哪些是 **default** 方法？

```
A. and(Predicate<? super T> other)
B. isEqual(Object targetRef)
C. negate()
D. not(Predicate<? super T> target)
E. or(Predicate<? super T> other)
F. test(T t)
```

> ✅ **答：A、C、E**  
> `test(T)` 是 abstract；`isEqual()` 和 `not()` 是 static；`and()`、`negate()`、`or()` 是 default。

---

### Q2-11 Functional Interface（唯一 abstract 方法）

哪個介面可作為 lambda 的目標型別？

```java
interface X { default void m1() {} }
interface Y extends X { static void m2() {} }
interface Z extends Y { void m1(); void m3(); }
interface W extends Z { void m4(); }
interface V extends W { default void m1() {} default void m3() {} }
```

> ✅ **答：V**  
> V 提供 `m1`、`m3` 的 default 實作，只剩 `m4` 為 abstract → 剛好一個抽象方法 → functional interface。

---

### Q2-12 方法不能只靠回傳型別多載

*(見 Q1-8)*

---

## 3. 泛型與萬用字元

### Q3-1 Map 泛型宣告（選二）

`List<String> italianAuthors = new ArrayList<>()` 加入 "Dante"、"Umberto Eco" 後，哪些宣告可**編譯**？（Choose two）

```
A. Map<String, ArrayList<String>> map1 = new HashMap<>(); map1.put("IT", italianAuthors);
B. Map<String, ? extends List<String>> map2 = new HashMap<String, ArrayList<String>>(); map2.put("IT", italianAuthors);
C. var map3 = new HashMap<String, List<String>>(); map3.put("IT", italianAuthors);
D. Map<String, List<String>> map4 = new HashMap<String, ArrayList<String>>(); map4.put("IT", italianAuthors);
E. Map<String, List<String>> map5 = new HashMap<>(); map5.put("IT", italianAuthors);
```

> ✅ **答：C、E**  
> 泛型不具型別變性（invariance）；B 無法 `put`（? extends 不可寫入）；D 右側型別不相容；A 左側為 ArrayList 但 italianAuthors 是 List。

---

### Q3-2 Wildcard extends/super（IOException）

以下哪些方法可**編譯**？（Choose all）

```java
A. public List<? extends IOException> m1() { return new ArrayList<FileNotFoundException>(); }
B. public List<? super IOException> m2() { return new ArrayList<Exception>(); }
C. public List<? extends IOException> m3() { return new ArrayList<Exception>(); }
D. public List<? super IOException> m4() { return new ArrayList<FileNotFoundException>(); }
```

> ✅ **答：A、B**  
> `? extends IOException`：允許子類（FileNotFoundException ✅）；`? super IOException`：允許父類（Exception ✅）。

---

### Q3-3 Wildcard extends/super（RuntimeException）

以下哪些方法可**編譯**？（Choose all）

```java
A. public List<? extends RuntimeException> getList1() { return new ArrayList<IllegalArgumentException>(); }
B. public List<? super RuntimeException> getList2() { return new ArrayList<Exception>(); }
C. public List<? extends RuntimeException> getList3() { return new ArrayList<Exception>(); }
D. public List<? super RuntimeException> getList4() { return new ArrayList<IllegalArgumentException>(); }
```

> ✅ **答：A、B**  
> `IllegalArgumentException` 是 RuntimeException 子類（A ✅）；`Exception` 是 RuntimeException 父類（B ✅）。

---

### Q3-4 var + raw HashMap

```java
var map = new HashMap<>();
map.put("A", 1);
map.put("B", 2);
map.put(3, "C");
```

能否編譯？

> ✅ **答：True（可編譯）**  
> `var` + `new HashMap<>()` 推斷為 `HashMap<Object, Object>`，鍵值型別任意。

---

## 4. 集合框架

### Q4-1 TreeSet headSet

```java
var cities = new TreeSet<String>();
cities.add("Berlin"); cities.add("Amsterdam");
cities.add("Zurich"); cities.add("Madrid"); cities.add("Lisbon");
System.out.println(cities.headSet("Madrid"));
```

選項：A. [Amsterdam, Berlin]　B. [Amsterdam, Berlin, Lisbon]　C. [Berlin, Lisbon]　D. Compilation fails

> ✅ **答：B — [Amsterdam, Berlin, Lisbon]**  
> TreeSet 字母排序：`[Amsterdam, Berlin, Lisbon, Madrid, Zurich]`；`headSet("Madrid")` 回傳**嚴格小於** "Madrid" 的元素。

---

### Q4-2 ConcurrentHashMap 建構子

如何建立初始容量 32、負載因子 0.75、並行層級 8 的 `ConcurrentHashMap`？

```
A. new ConcurrentHashMap(32)
B. new ConcurrentHashMap(32, 8)
C. new ConcurrentHashMap(32, 0.75f, 8)
D. new ConcurrentHashMap(0.75f, 32, 8)
```

> ✅ **答：C**  
> 建構子簽名：`ConcurrentHashMap(int initialCapacity, float loadFactor, int concurrencyLevel)`

---

### Q4-3 DoubleSummaryStatistics combine（一）

```java
DoubleSummaryStatistics stats1 = new DoubleSummaryStatistics();
stats1.accept(2.0); stats1.accept(6.0);
DoubleSummaryStatistics stats2 = new DoubleSummaryStatistics();
stats2.accept(4.0); stats2.accept(8.0);
stats1.combine(stats2);
System.out.println("Sum: " + stats1.getSum() + ", Max: " + stats1.getMax() + ", Avg: " + stats1.getAverage());
```

> ✅ **答：Sum: 20.0, Max: 8.0, Avg: 5.0**  
> 合併後含 2、6、4、8；Sum=20、Max=8、Avg=5。

---

### Q4-4 DoubleSummaryStatistics combine（二）

```java
s1: 1.5, 2.5 / s2: 3.0, 4.0 → s1.combine(s2)
```

> ✅ **答：Sum: 11.0, Max: 4.0, Avg: 2.75**  
> 合併後含 1.5、2.5、3.0、4.0；Sum=11、Max=4、Avg=2.75。

---

### Q4-5 ArrayDeque peek/poll/pop/element

```java
var deque = new ArrayDeque<Integer>();
deque.add(10); deque.add(20); deque.add(30); deque.add(40);
System.out.print(deque.peek() + " ");    // 不移除
System.out.print(deque.poll() + " ");    // 移除
System.out.print(deque.pop() + " ");     // 移除
System.out.print(deque.element() + " "); // 不移除
```

> ✅ **答：10 10 20 30**  
> `peek`=10（不移除）；`poll`=10（移除，佇列剩 20,30,40）；`pop`=20（移除）；`element`=30。

---

### Q4-6 TreeMap 自動排序

```java
Map<String, Integer> map = Map.of("z", 3, "x", 1, "y", 2);
TreeMap<String, Integer> tree = new TreeMap<>(map);
System.out.println(tree);
```

> ✅ **答：{x=1, y=2, z=3}**  
> `TreeMap` 依鍵的自然順序（字母）排序。

---

### Q4-7 CopyOnWriteArrayList 並發迭代

```java
CopyOnWriteArrayList<Integer> list = new CopyOnWriteArrayList<>();
list.add(1); list.add(2); list.add(3);
new Thread(() -> { list.add(4); System.out.println("Added 4"); }).start();
new Thread(() -> { for (Integer i : list) System.out.println("Read: " + i); }).start();
```

> ✅ **答：所有原始元素都會印出；迭代期間的修改可能看不到**  
> `CopyOnWriteArrayList` 迭代時使用快照，不丟 `ConcurrentModificationException`。

---

## 5. 函式式編程

### Q5-1 Lambda 對應 Functional Interface

```java
interface Processor { double apply(int x); }
Processor p1 = x -> x * 2;                              // Line 1
Processor p2 = x -> Double.valueOf(x);                  // Line 2
Processor p3 = x -> { throw new RuntimeException(); };  // Line 3
```

哪行無法編譯？

> ✅ **答：程式完全可編譯**  
> `x*2`（int→double 自動加寬）；`Double.valueOf(x)`（拆箱）；拋 unchecked 例外皆合法。

---

### Q5-2 Collectors.joining

```java
StringBuilder a = new StringBuilder("FR"), b = new StringBuilder("DE");
String result = Stream.of(a, b).collect(Collectors.joining("-", "[", "]"));
System.out.println(result);
```

> ✅ **答：[FR-DE]**  
> `joining(delimiter, prefix, suffix)` 以 toString() 串聯元素。

---

### Q5-3 Stream forEach 不修改原始 List

```java
List<String> list = List.of("x", "y", "z");
list.stream().forEach(s -> { s = s.toUpperCase(); });
list.stream().forEach(System.out::print);
```

> ✅ **答：xyz**  
> `String` 不可變；lambda 內重指派只影響區域參數，不改變 list。

---

### Q5-4 Stream collect 使用 supplier

```java
StringBuilder result = Stream.of("x", "y")
    .collect(() -> new StringBuilder("z"), StringBuilder::append, (a, b) -> b.append(a));
System.out.println(result);
```

> ✅ **答：zxy**  
> supplier 建立含 "z" 的 StringBuilder；sequential 流依序 append "x"→"zx"、"y"→"zxy"；combiner 不被呼叫。

---

### Q5-5 ExecutorService execute vs submit（選二）

```java
Runnable r = () -> System.out.println("Running Runnable");
Callable<String> c = () -> { System.out.println("Running Callable"); return "Done"; };
ExecutorService service = Executors.newSingleThreadExecutor();
// 哪兩段同時印出兩行？
```

```
A. service.execute(r); service.execute(c);
B. service.submit(r); service.submit(c);
C. service.execute(r); service.submit(c);
D. service.submit(r); service.run();
```

> ✅ **答：B、C**  
> `execute()` 只接受 `Runnable`（A 的 `execute(c)` 不編譯）；`submit()` 兩者皆可。

---

### Q5-6 建立 Stream 無效方式（選二）

```
A. Stream s = new Stream();
B. Stream<String> s = Stream.of("a", "b");
C. Stream<String> s = Stream.generate(() -> "x");
D. Stream<String> s = Stream.empty();
E. Stream<String> s = Stream.builder().add("a").build();
F. Stream<String> s = Stream.ofNullable("a");
```

> ✅ **答：A（只有 A 無效）**  
> `Stream` 是介面無法 `new`；B~F 皆為有效建立方式。  
> *注意：C 是無限流，需 `limit()` 才安全，但語法本身有效。*

---

### Q5-7 Optional flatMap

```java
Optional<Integer> o1 = Optional.empty();
Optional<Integer> o2 = Optional.of(5);
Optional<Integer> o3 = Stream.of(o1, o2)
    .filter(Optional::isPresent).findFirst().flatMap(o -> o);
System.out.println(o3.orElse(10));
```

> ✅ **答：5**  
> 過濾掉空的 o1；`findFirst()` 得 `Optional<Optional<Integer>>`；`flatMap` 解包得含 5 的 `Optional`。

---

### Q5-8 DoubleStream.allMatch 型別不符

```java
DoubleStream stream = DoubleStream.of(1.1, 2.2, 6.6, 7.7);
Predicate<Double> p = d -> d > 5;
System.out.println(stream.allMatch(p));
```

> ✅ **答：Compilation fails**  
> `DoubleStream.allMatch()` 需要 `DoublePredicate`，不是 `Predicate<Double>`。

---

## 6. 日期時間 API

### Q6-1 SimpleDateFormat pattern

已知程式碼印出 "December 05"，應使用哪個 pattern？

```java
DateFormat formatter = new SimpleDateFormat(/* pattern */);
```

選項：A. MM dd　B. MMMM dd　C. MMM dd　D. MMDD

> ✅ **答：B — MMMM dd**  
> `MMMM` = 完整月份名稱；`dd` = 兩位日期。

---

### Q6-2 Period vs Duration 搭配 LocalDate

```java
Period p = Period.between(LocalDate.of(2022, 1, 1), LocalDate.of(2023, 1, 1));
System.out.print(p);
Duration d = Duration.between(LocalDate.of(2022, 1, 1), LocalDate.of(2023, 1, 1));
System.out.print(d);
```

> ✅ **答：P1Y 後丟 UnsupportedTemporalTypeException**  
> `Period` 支援 date-based；`Duration` 需要 time-based，`LocalDate` 無時間部分 → 拋例外。

---

### Q6-3 ISO_WEEK_DATE

假設今天是 2024/12/31，哪個格式化器印出 `2025-W01`？

```java
var f1 = DateTimeFormatter.ISO_LOCAL_DATE;   // 2024-12-31
var f2 = DateTimeFormatter.ISO_WEEK_DATE;    // 2025-W01-2
var f3 = new DateTimeFormatterBuilder()
    .appendValue(IsoFields.WEEK_BASED_YEAR, 4).appendLiteral("-W")
    .appendValue(IsoFields.WEEK_OF_WEEK_BASED_YEAR, 2).toFormatter();
```

> ✅ **答：f2 (`ISO_WEEK_DATE`)**  
> 2024/12/31 屬於週基準年 2025 的第 1 週；f3 缺少日（day）元素，格式不完整。

---

## 7. 文字塊與字串

### Q7-1 text block 取代字串（換行）

下列哪個 text block 可取代 `String animals = "cat\ndog\nbird\n"`？

> ✅ **答：None of the propositions**  
> 原字串含 `\n`；提供的 text block 選項皆無法精確重現換行序列。

---

### Q7-2 String.strip()

```java
String s = "  "; System.out.print("[" + s.strip() + "]");
s = " world\n"; System.out.print("[" + s.strip() + "]");
s = "  java  "; System.out.print("[" + s.strip() + "]");
```

> ✅ **答：[][world][java]**  
> `strip()` 移除前後 Unicode 空白。

---

### Q7-3 text block length（換行計）

```java
String block = """
    X
    Y
    Z
    """;
System.out.println(block.length());
```

> ✅ **答：6**  
> 內容為 `"X\nY\nZ\n"`：3 個字母 + 3 個換行 = 6。

---

### Q7-4 text block length（含 Tab）

```java
String block = """
    A\t
    B
    C
    """;
System.out.println(block.length());
```

> ✅ **答：8**  
> `A\t\n`(3) + `B\n`(2) + `C\n`(2) + 空行換行(1) = 8。  
> *注意：text block 開頭三引號後的換行不計入。*

---

## 8. 模組系統（JPMS）

### Q8-1 module-info.java 正確寫法

`inventory.app` 模組依賴 `inventory.core`，需將 `inventory.app.api` 開放給外部。正確模組宣告？

```
A. 檔名 module-info.inventory.app.java
B. 檔名 module-info.java → module inventory.app { requires inventory.core; exports inventory.app.api; }
C. 檔名 module.java
D. 檔名 inventory.app.module
```

> ✅ **答：B**  
> 模組描述符固定命名為 `module-info.java`；`requires` 宣告依賴、`exports` 開放套件。

---

### Q8-2 JPMS 正確陳述（選三）

```
A. 具名模組中的程式碼可存取未具名模組中的 public 型別。
B. 未具名模組預設讀取所有具名模組。
C. 具名模組存取另一具名模組的 exported package 需明確 requires。
D. 從 Java 9 起所有 Java 應用程式都必須有 module descriptor。
E. 未具名模組會匯出（export）其所有套件。
F. 若某套件同時存在於兩個具名模組，應用程式會因 split package 衝突而失敗。
```

> ✅ **答：C、E、F**  
> A 錯（具名模組無法存取未具名模組）；D 錯（module descriptor 非強制）。

---

### Q8-3 ServiceLoader 正確用法（選全部）

```java
A. PaymentService s = ServiceLoader.load(PaymentService.class).iterator().next();
B. PaymentService s = ServiceLoader.load(PaymentService.class).findFirst().get();
C. PaymentService s = ServiceLoader.getService(PaymentService.class);
D. PaymentService s = ServiceLoader.services(PaymentService.class).getFirstInstance();
```

> ✅ **答：A、B**  
> `ServiceLoader.load()` 後可用 `iterator().next()` 或 Java 9+ 的 `findFirst()`；無 `getService()`/`services().getFirstInstance()`。

---

## 9. 並行（Concurrency）

### Q9-1 synchronized 建構子 + static 欄位競態

```java
public class Counter {
    static int value;
    synchronized Counter() { value++; }
    public static void main(String[] args) throws InterruptedException {
        Runnable task = Counter::new;
        Thread t1 = new Thread(task), t2 = new Thread(task);
        t1.start(); t2.start(); t1.join(); t2.join();
        System.out.println(value);
    }
}
```

> ✅ **答：可能是 1 或 2（競態條件）**  
> 建構子 `synchronized` 鎖的是**各自的實例**，未共享；`static value` 遞增無類別層級同步 → 可能競態。

---

### Q9-2 ExecutorService shutdown 後 submit

```java
ExecutorService service = Executors.newSingleThreadExecutor();
Runnable task = () -> System.out.println("Done");
service.submit(task);
service.shutdown();
service.submit(task);   // 再次 submit
```

> ✅ **答：印 "Done" 一次後拋 RejectedExecutionException**  
> `shutdown()` 後不再接受新任務，第二次 `submit()` 丟例外。

---

### Q9-3 DoubleStream 需 DoublePredicate

*(見 Q5-8)*

---

### Q9-4 CopyOnWriteArrayList 快照迭代

*(見 Q4-7)*

---

## 10. I/O、路徑與序列化

### Q10-1 序列化後強制轉型不相容

```java
class X implements Serializable { int value = 10; }
class Y implements Serializable { int value = 20; }
// 序列化 X 物件後讀取並強轉為 Y
Y result = (Y) in.readObject();
System.out.println(result.value);
```

> ✅ **答：ClassCastException**  
> 反序列化的物件仍是 X，強轉為無繼承關係的 Y → 拋 `ClassCastException`。

---

### Q10-2 Console 不存在的方法

`java.io.Console` 中哪個方法**不存在**？

```
A. readLine()   B. readLine(String fmt, Object... args)
C. readPassword()   D. readPassword(String fmt, Object... args)
E. writer()   F. print(String s)
```

> ✅ **答：F — print(String s)**  
> `Console` 輸出使用 `writer()` 返回的 `PrintWriter`，或直接呼叫 `format()`/`printf()`，無 `print(String)` 方法。

---

### Q10-3 Path.getName(0)

```java
Path path = Paths.get("/usr/local/bin/script.sh");
System.out.println(path.getName(0));
```

選項：A. /　B. usr　C. local　D. script.sh　E. Compilation error

> ✅ **答：B — usr**  
> `getName()` 的 name 元素**不含 root**；index 0 = `usr`。

---

### Q10-4 Files.readAllLines + skip + limit

`data.csv` 含 Header1、Header2、Row1、Row2、Row3、Row4 六行。

```java
Files.readAllLines(Paths.get("data.csv")).stream()
    .skip(2).limit(2).forEach(System.out::println);
```

> ✅ **答：Row1 Row2**  
> `skip(2)` 跳過 Header1、Header2；`limit(2)` 取接下來 2 行：Row1、Row2。

---

### Q10-5 寫字串到檔案的非法方式

以下哪個**無法**寫字串到檔案？

```
A. Files.write(path, "Hello".getBytes())
B. new BufferedWriter(new FileWriter("output.txt")).write("Hello")
C. new FileOutputStream("output.txt").write("Hello")
D. new PrintWriter("output.txt").printf("Hello %s", "World")
E. new FileWriter("output.txt").write("Hello")
```

> ✅ **答：C**  
> `FileOutputStream.write()` 需 `byte[]` 或 `int`，直接傳 `String` 不編譯。

---

## 11. Switch 與 Pattern Matching

### Q11-1 Switch Pattern Matching（Long）

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

> ✅ **答：long**  
> `10L` 是 `Long` 型別，命中 `case Long l`。

---

### Q11-2 Switch Pattern Matching（Double）

```java
Object input = 3.14;
String result = switch (input) {
    case String s  -> "It's a string: " + s;
    case Integer i -> "It's an integer: " + i;
    case Double d  -> "It's a double: " + d;
};
System.out.println(result);
```

> ✅ **答：It's a double: 3.14**  
> `3.14` 是 `Double`（double literal 包裝），命中 `case Double d`。  
> *注意：switch 無 `default` 時需 exhaustive；Object 型別需要 default。此題實際會 Compilation fails（缺 default）。*

---

## 12. 例外處理與 try-with-resources

### Q12-1 finally 覆蓋例外

```java
public class Test {
    public static void main(String[] args) {
        try { throw new IllegalArgumentException(); }
        catch (IllegalArgumentException e) { throw new RuntimeException(); }
        finally { throw new NullPointerException(); }
    }
}
```

> ✅ **答：丟 NullPointerException**  
> `finally` 一定執行，其丟出的例外**覆蓋**前面所有例外。

---

### Q12-2 巢狀 try-catch-finally 例外流程

```java
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
```

> ✅ **答：Epsilon, Beta, Gamma**  
> `10/0` 丟 ArithmeticException；未被 NPE catch 接住；calculate 的 finally 先印 "Epsilon, "；例外傳回 main 被 catch 印 "Beta, "；main 的 finally 印 "Gamma"。

---

### Q12-3 TWR + suppressed exception

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

> ✅ **答：start close catch**  
> try 拋例外 → 自動呼叫 `close()` 印 "close "；close 的例外成為 suppressed exception；原例外被 catch 印 "catch "。

---

## 13. 其他 Java 21 新特性

### Q13-1 CompactNumberFormat

```java
double amount = 12500;
NumberFormat format = NumberFormat.getCompactNumberInstance(Locale.US, NumberFormat.Style.SHORT);
System.out.println(format.format(amount));
```

> ✅ **答：12.5K**  
> `getCompactNumberInstance` + `Style.SHORT` 在 US locale 將 12,500 格式化為 `12.5K`。

---

## 快速複習速查表

| 主題 | 重要規則 |
|------|----------|
| `var` | 需初始值；不能 `null`；不能多重宣告；不能 array initializer（無 new） |
| Sealed class | 子類必須 `final` / `sealed` / `non-sealed`；`permits` 不可省 |
| Record | 不能額外 instance field；隱式繼承 Record；可實作介面；可有 static field |
| 介面方法 | `static` 不繼承；實作類不可降低存取權限 |
| `protected` | 不同套件子類只能透過繼承關係存取，不能透過父型別參考 |
| `finally` | 一定執行；其例外覆蓋 try/catch 的例外 |
| TWR | close 的例外成為 suppressed；close 順序與宣告相反 |
| `DoubleStream.allMatch` | 需 `DoublePredicate`，非 `Predicate<Double>` |
| Pattern Matching switch | Object 型別需 `default`；case 檢查依序進行 |
| `CopyOnWriteArrayList` | 迭代使用快照；不丟 ConcurrentModificationException |
| `synchronized` 建構子 | 鎖在各自實例；static 欄位仍需類別層級同步 |
| `Duration.between(LocalDate…)` | 丟 `UnsupportedTemporalTypeException`；LocalDate 無時間部分 |
| `headSet(key)` | 嚴格小於 key（exclusive）；`tailSet(key)` 含 key（inclusive） |
| `ServiceLoader` | `load().iterator().next()` 或 `load().findFirst().get()` |
| Text block length | 每個 `\n` 算 1 個字元；`\t` 算 1 個字元 |
| `Path.getName(0)` | 不含 root，從第一個元素開始（`/usr/…` → `usr`） |
| `var _ = …` | Java 9+ 單一底線不能作識別字 → Compilation fails |
| 方法多載 | 不能只靠回傳型別區分 |
| `void method()` vs 建構子 | 有 `void` 是一般方法；建構子沒有回傳型別 |
