# 1Z0-830 Java SE 21 Developer — 網路上蒐集考題（一）

> 來源：
> 1. freecram.com（85 題題庫之首頁 9 題）— https://www.freecram.com/Oracle-certification/1z0-830-exam-questions.html
> 2. TheExamsLab（84 題題庫之首頁 6 題）— https://www.theexamslab.com/online/1Z0-830-practice-test
> 3. TechExamLexicon（原創練習 4 題，含詳解）— https://techexamlexicon.com/oracle/java/1z0-830/sample-questions
>
> 整理時間：2026-09-17

---

# Part A — freecram 題庫

## A1. TreeMap.subMap
下列程式會印出什麼？
```java
var cabarets = new TreeMap<>();
cabarets.put(1, "Moulin Rouge");
cabarets.put(2, "Crazy Horse");
cabarets.put(3, "Paradis Latin");
cabarets.put(4, "Le Lido");
cabarets.put(5, "Folies Bergere");
System.out.println(cabarets.subMap(2, true, 5, false));
```
- A. Compilation fails.
- B. An exception is thrown at runtime.
- C. {2=Crazy Horse, 3=Paradis Latin, 4=Le Lido, 5=Folies Bergere}
- D. {}
- E. {2=Crazy Horse, 3=Paradis Latin, 4=Le Lido}

**答：E。** `subMap(2, true, 5, false)` 含 2、不含 5，故包含 key 2、3、4。

---

## A2. do-while 前置遞增
```java
var counter = 0;
do { System.out.print(counter + " "); } while (++counter < 3);
```
- A. An exception is thrown.　B. 1 2 3　C. Compilation fails.
- D. 0 1 2 3　E. 0 1 2　F. 1 2 3 4

**答：E。** do-while 先執行再判斷；`++counter < 3` 在判斷前先加 1。印出 0、1、2，第三次判斷時 counter 變 3 而結束。

---

## A3. 泛型 wildcard 編譯
哪些方法可編譯？
```java
A. public List<? super IOException> getListSuper() { return new ArrayList<FileNotFoundException>(); }
B. public List<? extends IOException> getListExtends() { return new ArrayList<FileNotFoundException>(); }
C. public List<? super IOException> getListSuper() { return new ArrayList<Exception>(); }
D. public List<? extends IOException> getListExtends() { return new ArrayList<Exception>(); }
```
**答：B、C。**
- `? extends IOException`：元素型別須是 IOException 或其子類別。FileNotFoundException extends IOException 合法（B）;Exception 不是子類別（D 錯）。
- `? super IOException`：元素型別須是 IOException 或其父類別。FileNotFoundException 是子類別（A 錯）;Exception 是父類別（C 對）。

---

## A4. Text Block 長度
```java
String textBlock = """
        j \a \tv \sa \""";
System.out.println(textBlock.length());
```
- A. 14　B. 10　C. 11　D. 12

**答：D（12）。** 計算轉義後實際字元：`j`(1) + 空格(1) + `a`(1) + 空格(1) + `\t`(1) + `v`(1) + 空格(1) + `\s`(1) + `a`(1) + 空格(1) + `"`(1) + 關閉行尾 = 12。`\a` 非內建轉義，會被辭彙處理為 `a`（Java 21 警告但不報錯）。

---

## A5. synchronized 建構子
```java
public class Test {
    static int count;
    synchronized Test() { count++; }
    public static void main(String[] args) throws InterruptedException {
        Runnable task = Test::new;
        Thread t1 = new Thread(task);
        Thread t2 = new Thread(task);
        t1.start(); t2.start(); t1.join(); t2.join();
        System.out.println(count);
    }
}
```
- A. Compilation fails　B. It's always 2　C. It's always 1
- D. It's either 1 or 2　E. It's either 0 or 1

**答：A。** 建構子不能加 `synchronized` 修飾字，編譯失敗。

---

## A6. DoubleSummaryStatistics.combine
```java
DoubleSummaryStatistics stats1 = new DoubleSummaryStatistics();
stats1.accept(4.5); stats1.accept(6.0);
DoubleSummaryStatistics stats2 = new DoubleSummaryStatistics();
stats2.accept(3.0); stats2.accept(8.5);
stats1.combine(stats2);
System.out.println("Sum: " + stats1.getSum() + ", Max: " + stats1.getMax() + ", Avg: " + stats1.getAverage());
```
- A. Compilation fails.
- B. Sum: 22.0, Max: 8.5, Avg: 5.0
- C. Sum: 22.0, Max: 8.5, Avg: 5.5
- D. An exception is thrown at runtime.

**答：C。** 合併後總和 4.5+6.0+3.0+8.5=22.0、最大值 8.5、平均 22.0/4=5.5。

---

## A7. switch pattern matching（原始型別）
```java
Object myVar = 0;
String print = switch (myVar) {
    case int i -> "integer";
    case long l -> "long";
    case String s -> "string";
    default -> "";
};
System.out.println(print);
```
- A. integer　B. long　C. Compilation fails.
- D. It throws an exception at runtime.　E. string　F. nothing

**答：C。** switch 的 type pattern **不支援原始型別**（int/long），必須用 wrapper（`case Integer i`）才能編譯。

---

## A8. final class 描述
下列關於 final class 的敘述何者正確？
- A. It must contain at least a final method.
- B. It cannot extend another class.
- C. The final keyword in its declaration must go right before the class keyword.
- D. It cannot be extended by any other class.
- E. It cannot implement any interface.

**答：D。** final class 不能被繼承。B 錯——final class 仍可 extends 其他類別。

---

## A9. 介面方法實作未加 public
```java
interface SmartPhone { boolean ring(); }
class Iphone15 implements SmartPhone {
    boolean isRinging;
    boolean ring() { isRinging = !isRinging; return isRinging; }
}
```
- A. Everything compiles
- B. An exception is thrown at running Iphone15.ring();
- C. SmartPhone interface does not compile
- D. Iphone15 class does not compile

**答：D。** 介面抽象方法預設 `public abstract`，實作時必須宣告 `public`，否則編譯失敗（降低可視性）。

---

# Part B — TheExamsLab 題庫

## B1. getCompactNumberInstance
```java
double amount = 42_000.00;
NumberFormat format = NumberFormat.getCompactNumberInstance(Locale.FRANCE, NumberFormat.Style.SHORT);
System.out.println(format.format(amount));
```
- A. 42000E　B. 42 000,00 €　C. 42000　D. 42 k

**答：D。** `Style.SHORT` + FRANCE locale 將 42,000 格式化為緊湊數字 `42 k`。

---

## B2. Files.move + delete
```java
Path p1 = Path.of("f1.txt");
Path p2 = Path.of("f2.txt");
Files.move(p1, p2);
Files.delete(p1);
```
下列何種情況會拋例外？
- A. Neither files f1.txt nor f2.txt exist
- B. Both files f1.txt and f2.txt exist
- C. An exception is always thrown
- D. File f2.txt exists while file f1.txt doesn't
- E. File f1.txt exists while file f2.txt doesn't

**答：C。** 任何情況必拋例外：兩檔都存在時 `move` 因目標已存在拋 `FileAlreadyExistsException`；move 成功後 `p1` 已不存在，`delete(p1)` 拋 `NoSuchFileException`。

---

## B3. Java module system
下列關於 Java module system 的敘述哪些正確？（Choose three）
- A. Code in an explicitly named module can access types in the unnamed module.
- B. The unnamed module exports all of its packages.
- C. If a package is defined in both a named module and the unnamed module, then the package in the unnamed module is ignored.
- D. We must add a module descriptor to make an application developed using a Java version prior to SE9 run on Java 11.
- E. The unnamed module can only access packages defined in the unnamed module.
- F. If a request is made to load a type whose package is not defined in any known module, then the module system will attempt to load it from the classpath.

**答：B、C、F。** unnamed module 匯出所有套件（B）；套件重複時以 named module 為準，unnamed 被忽略（C）；找不到套件時退回 classpath（F）。A、E 錯誤——named module 無法讀取 unnamed module，但 unnamed module 可以讀取 classpath/named module 匯出的型別（A 反了）。

---

## B4. StringBuilder 建構子
```java
public class StringBuilderInstantiations {
    public static void main(String[] args) {
        var stringBuilder1 = new StringBuilder();
        var stringBuilder2 = new StringBuilder(10);
        var stringBuilder3 = new StringBuilder("Java");
        var stringBuilder4 = new StringBuilder(new char[]{'J', 'a', 'v', 'a'});
    }
}
```
哪一個無法編譯？
- A. None of them　B. stringBuilder4　C. stringBuilder1　D. stringBuilder3　E. stringBuilder2

**答：B。** StringBuilder 沒有接收 `char[]` 的建構子。

---

## B5. ExecutorService submit after shutdown
```java
ExecutorService service = Executors.newFixedThreadPool(2);
Runnable task = () -> System.out.println("Task is complete");
service.submit(task);
service.shutdown();
service.submit(task);
```
- A. 印出一次 "Task is complete" 並拋例外
- B. 印出兩次 "Task is complete" 並拋例外
- C. 正常結束且無輸出
- D. 印出兩次後正常結束
- E. 印出一次後正常結束

**答：A。** 第一個 task 正常執行並印出一次；`shutdown()` 後再 `submit` 會拋 `RejectedExecutionException`。

---

## B6. Optional orElse / orElseGet / orElseThrow
（假設 `optionalName` 為 empty Optional）
```java
String bread = optionalName.orElse("Baguette");
System.out.print("bread:" + bread);
String dish = optionalName.orElseGet(() -> "Frog legs");
System.out.print(", dish:" + dish);
try {
    String cheese = optionalName.orElseThrow(() -> new Exception());
    System.out.println(", cheese:" + cheese);
} catch (Exception exc) {
    System.out.println(", no cheese.");
}
```
- A. bread:Baguette, dish:Frog legs, cheese.
- B. bread:Baguette, dish:Frog legs, no cheese.
- C. bread:bread, dish:dish, cheese.
- D. Compilation fails.

**答：B。** empty Optional 的 `orElse("Baguette")`、`orElseGet(...)` 都回傳替代值；`orElseThrow(...)` 拋出例外被 catch 後印 `no cheese`。

---

# Part C — TechExamLexicon 原創練習題

## C1. 型別模式變數作用域
```java
static String label(Object value) {
    if (value instanceof String s && s.length() > 3) {
        return s.substring(0, 3);
    } else {
        return s;
    }
}
```
- A. 方法可編譯，長字串回傳前三個字元。
- B. 方法可編譯，非字串回傳原物件。
- C. 因 `s` 在 else 區塊不在作用域內而無法編譯。
- D. 方法可編譯，但非字串執行時拋 ClassCastException。

**答：C。** pattern variable `s` 只在 `&&` 條件成立的分支為 definitely matched，else 區塊取用 `s` 會編譯失敗。

---

## C2. Stream 重複使用
```java
var stream = java.util.stream.Stream.of("a", "bb", "ccc");
var count = stream.filter(s -> s.length() > 1).count();
var first = stream.findFirst();
System.out.println(count + " " + first.orElse("none"));
```
- A. 印 `2 a`　B. 印 `2 none`
- C. 拋例外，因 stream 已被操作（count 是 terminal operation）
- D. 無法編譯，因 filter 改變 stream 宣告型別

**答：C。** Stream 只能使用一次，第二次 terminal operation `findFirst()` 拋 `IllegalStateException`。

---

## C3. Record compact constructor
```java
record Course(String code, int seats) {
    Course {
        if (seats < 0) throw new IllegalArgumentException();
        code = code.strip().toUpperCase();
    }
}
```
- A. compact constructor 可在欄位賦值前驗證並正規化參數。
- B. compact constructor 不能對 `code` 賦值，因為 record component 是 final。
- C. record 必須明確指派 `this.code` 與 `this.seats`。
- D. 無法編譯，因為 record 建構子不能拋例外。

**答：A。** compact constructor 中參數（非欄位）可重新指派，驗證後由隱式邏輯完成欄位指派；欄位在建構完成後仍是 final。

---

## C4. 泛型不變性與上限 wildcard
哪個宣告允許方法從 `List<Integer>`、`List<Long>` 或 `List<Double>` 讀取數字，且不新增內容？
- A. `static void read(java.util.List<Number> values)`
- B. `static void read(java.util.List<? extends Number> values)`
- C. `static void read(java.util.List<? super Number> values)`
- D. `static void read(java.util.List<Object> values)`

**答：B。** 泛型不變（List<Number> 不接受 List<Integer>）；`? extends Number` 是 producer 上限邊界，可讀取為 Number，且不允許寫入新元素。