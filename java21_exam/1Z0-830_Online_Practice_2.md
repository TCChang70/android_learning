# 1Z0-830 Java SE 21 網路上題目與解析彙整（第 2 集）

本文彙整【免費公開】的 1Z0-830（Oracle Certified Professional: Java SE 21 Developer）考題來源，包含題目、選項與解析。
全部題目來自公開網路資源，非官方 live-exam 盜版題庫；**建議以本機 javac 21 實測驗證答案**。

## 來源一覽

| 來源 | 題數 | 含解析 | 網址 |
|------|------|--------|------|
| MyExamCloud 部落格免費練習 | 22 | 部分（有題目+答案） | `myexamcloud.com/blog/...` |
| Javarevisited（javinpaul） | 10 | 題目+選項（答案自算） | `medium.com/javarevisited/...` |
| DBExam 樣本題 | 10 | 題目+答案 | `dbexam.com/oracle/...` |
| Tech Exam Lexicon | 4 | 題目+選項+解析 | `techexamlexicon.com/...` |
| 其他付費/需登入（略） | — | — | freecram、theexamslab、certmage 等 |

> 完整 50 題 True Mastery（已另檔 `1Z0-830_Online_Practice.md`），本篇為**第 2 集**補充其他來源。

---

# Part A — MyExamCloud 免費練習題（22 題）

## Q1（Streams / Lambda）
```java
import java.util.stream.DoubleStream;
public class MyExamCloud {
  public static void main(String[] args){
    var doubles = DoubleStream.of(0.45,0.42,0.49);
    System.out.print(doubles.filter(e -> e>0.45).count());
  }
}
```
輸出？
- A: `1`  B: `2`  C: 編譯失敗（未 import predicate）  D: line7 錯  E: line8 錯

**Ans:** ✅ **A**. `0.45` 不 >0.45；`0.42`、`0.49` 中只有 `0.49>0.45` → count=1。

## Q2（Modules / Packaging）
類別 `com.myexamcloud.exam.Exam` 屬於模組 `com.myexamcloud.exam`（在 myexam.jar）。下面哪個指令可執行此類別？（jar 在目前目錄）
- A: `java --module-path myexam.jar --module com.myexamcloud.exam.Exam`
- B: `java --module-path myexam.jar --module com.myexamcloud.exam com.myexamcloud.exam.Exam`
- C: `java --module-path myexam.jar --module com.myexamcloud.exam --main-class com.myexamcloud.exam.Exam`
- D: `java --module-path myexam.jar --module com.myexamcloud.exam/com.myexamcloud.exam.Exam`
- E: `java --module-path . --module com.myexamcloud.exam/com.myexamcloud.exam.Exam`

**Ans:** ✅ **D、E**. `--module 模組/主類別` 語法；`--module-path .` 中主類別寫 `module/MainClass`。C（--main-class 搭配 --module）語法不正確。A、B 主類別位置有誤。

## Q3（Concurrency / ReentrantLock）
```java
record Account(String accNumber, double balance) {
  static java.util.concurrent.locks.ReentrantLock lock = new ReentrantLock();
  public double withdraw(double amt) {
    double latestBalance = 0;
    try { lock.lock();
      if (balance > amt) latestBalance = balance - amt;
    } finally { lock.unlock(); }
    return latestBalance;
  }
}
```
如何讓上述程式 thread-safe？
- A: 改 `new ReentrantLock(true)`
- B: 把 lock 設 protected
- C: lock 設 protected, final, static
- D: 把 `lock.lock()` 移到 try 之前
- E: lock 設 final
- F: 不需修改
- G: lock 宣告為 **private** 且 final

**Ans:** ✅ **G**。record 中的 `lock` 是**可變 static 欄位**，任何物件都可改它（如 `Account.lock = new ...`），會破壞鎖的保證。改成 `private static final` 才不可被外部取代、可安全共用。

## Q4（I/O）
```java
import java.io.*;
public class MyExamCloud {
  public static void main(String[] args) throws Exception {
    try (var bfr = new BufferedReader(new InputStreamReader(System.in))) {
      System.out.println("Enter Your Name:");
      var s = bfr.readLine();
      System.out.println("Your Name is : " + s);
    } catch (Exception e) { e.printStackTrace(); }
  }
}
```
執行 `java MyExamCloud Joe` 的輸出？
- A: `Enter Your Name:` / `Your Name is: MyExamCloud  Joe`
- B: exception stack trace
- C: `Enter Your Name:` / `Your Name is : null`
- D: `Enter Your Name:`
- E: `Enter Your Name:` / `Your Name is : Joe`

**Ans:** ✅ **D**。`Joe` 是**命令列引數（args）**，不是標準輸入。`readLine()` 從 `System.in` 讀，等待鍵盤輸入（無資料時阻塞），`args` 未使用 → 只印出 `Enter Your Name:`。

## Q5（Program Flow — instanceof pattern）
`obj` 型別是 `java.lang.Object`。哪個片段能編譯？
```java
A: if (obj instanceof String name & name.length() > 10) { var xPosition = 10; var yPosition = 0; }
B: if (obj instanceof String name && name.length() > 10) { var xPosition = 10; var yPosition = 0; }
C: if (obj instanceof String name | name.length() > 10) { var xPosition = 10; var yPosition = 0; }
D: None of above
```
**Ans:** ✅ **B**。pattern variable（`name`）的 scope 在 `&&` 之後才成立（`&`/`|` 非短路，pattern 變數不在右側可用）→ 只有 `&&` 合法。

## Q6（Program Flow — switch pattern，選「不正確」）
```java
class Account {} class StandardAccount extends Account {}
class PremiumAccount extends Account { int monthsRemaining(){return 10;} }
public class MyExamCloud {
  record Point(int i, int j) {}
  static void testType(Object o) {
    switch (o) {
      case null -> System.out.println("null");
      case String s -> System.out.println("String");
      case StandardAccount a -> System.out.println("Account");
      case PremiumAccount p -> System.out.println("PremiumAccount");
      case int[] ia -> System.out.println("Array");
      default -> System.out.println("Something else");
    }
  }
  public static void main(String as[]) {
    testType(new PremiumAccount());
    testType(new StandardAccount());
    testType(new Account());
    testType(null);
    testType("");
    testType(new int[] {1,2,3,4,5});
  }
}
```
哪個「不正確」？
- A: 可能印出 Account 和 PremiumAccount
- B: 永遠不會印 Something else
- C: 可能印出 Array 和 Something else
- D: 可能印出 null 和 String

**Ans:** ✅ **B**（此為「何者不正確」）。`testType(new Account())`（非 Standard/Premium）→ 走 `default` → 印 **Something else**。所以 B「永遠不會印 Something else」是**錯的**。A/C/D 都正確。

## Q7（Program Flow — switch pattern）
```java
class Exam { public String toString(){ return "MyExamCloud Practice Exam"; } }
public class MyExamCloud {
  public static void main(String as[]) {
    Object o = new Exam();
    switch (o) {
      case null -> System.out.println("null");
      case String s -> System.out.println("String");
      case Exam e -> System.out.println(e.toString());
      case int[] ia -> System.out.println("Array length" + ia.length);
      default -> System.out.println("Something else");
    }
  }
}
```
輸出？
- A: `@Exam`  B: `String`  C: `Array length 0`  D: `null`  E: `MyExamCloud Practice Exam`  F: `Something else`

**Ans:** ✅ **E**。`o` 實際是 `Exam` → 命中 `case Exam e` → `e.toString()` 回 `MyExamCloud Practice Exam`。

## Q8（OOP — record）
```java
record Customer(Account account, int customerId) implements java.io.Serializable { // L1
  public int customerId() { return this.customerId + 1; } // L3
  public void someMethod() { System.out.println("Some method"); } // L4
  public static void test() { } // L5
  static { System.out.println("A static intilizer record "); } // L6
  record InnerRecord() {} // L7
}
```
何者為真？
- A: L5 編譯錯（不能有 static 方法）
- B: L6 編譯錯（不能有 static 區塊）
- C: 這種 record 應視為不良風格
- D: L4 編譯錯（不能有額外 instance 方法）
- E: L3 編譯錯（customerId 是 private final）
- F: L7 編譯錯（不能有 inner record）

**Ans:** ✅ **C**。記錄可含 static 方法、static 區塊、額外 instance 方法、巢狀 record 都可編譯。**問題是**：在 accessor `customerId()` 回傳 `this.customerId + 1`，遮蔽了標準 accessor 的語意（accessor 應回原始值），違反 record 慣例 → 不良風格。

## Q9（Text Block — 哪個不能編譯）
```java
A: String myArticle = """
     Java SE 21 is Good.
     MyExamCloud Tests are realy useful
     for latest Java Certifications. " """;
B: String type = ...;
   String code = String.format("""
     public void print(%s o) {
       System.out.println(Objects.toString(o));
     }
     """, type);
C: String code = """
     String text = \"""
       A text block inside a text block
     \""";
     """;
D: String myQuote =""" Pain is the healing process.     
   Failue is the success process.""";
```
**Ans:** ✅ **D**（不能編譯）。D 的 `"""` 開頭後緊接字元且**開頭分隔符號同一行**，實際上是非法 text block 語法（opening delimiter 之後必須換行）。A/B/C 都可編譯。

## Q10（Date/Time DST — 正確用語）
- A: `LocalDate date = LocalDate.now(); System.out.println(date);`
- B: `Calendar` + `TimeZone`
- C: `Date` + `SimpleDateFormat` setTimeZone
- D: `LocalDateTime...atZone(ZoneId)` + `plus(10, ChronoUnit.DAYS)`

**Ans:** ✅ **D**。Java 21 正確的 DST 處理應使用 **`ZonedDateTime`**（D），在含時區的型別上做加法，DST 轉換才正確。A 無時區、B/C 用舊 `Calendar`/`Date` API。

## Q11（Record pattern）
```java
record Line(int x, int y) {}
enum Color { RED, GREEN, BLUE }
record ColoredLine(Line l, Color c) {}
record Rectangle(ColoredLine top, ColoredLine bottom, ColoredLine left, ColoredLine right) {}
```
哪個程式可取 top 的 **color**（Java 21 record patterns）？
- A: `if (r instanceof Rectangle(ColoredLine(Point p, Color c), ColoredLine bottom, ...)) println(c);`
- B: `if (r instanceof Rectangle(ColoredLine top, ...)) println(top.c());`
- C: `if (r instanceof Rectangle(ColoredLine top, ... ) r) println(r.top.c());`
- D: `if (r instanceof Rectangle r) println(top.c());`
- E: `if (r instanceof Rectangle r) println(r.top.c());`

**Ans:** ✅ **A、B**。
- A：巢狀 record pattern `Rectangle(ColoredLine(Point p, Color c), ...)` 直接解出 `Color c` ✅（註：`Point` 此處與 `Line` 型別不符，需以實際 `Line` 為準；概念上 A 用巢狀解構）。
- B：先解出 `ColoredLine top`，再 `top.c()` ✅。
- C~E：語法錯誤（pattern variable 綁定寫法有誤、`top`/`r.top` 不合法）。

## Q12（Virtual Thread）
哪個選項建立 **virtual thread**？
- A: `new Thread().start(() -> ...)`（語法有誤）
- B: `Thread.ofVirtual().start(() -> ...)`
- C: `Thread.Builder builder = Thread.ofPlatform().name("..."); ... builder.start(task);`
- D: `Thread.Builder builder = Thread.ofVirtual().name("..."); ... builder.start(task);`

**Ans:** ✅ **B、D**。`Thread.ofVirtual()` 建立 virtual thread。C 用 `ofPlatform()` 是 platform thread。A 語法錯（`Thread().start(runnable)` 不正確）。

## Q13（ArrayDeque binarySearch）
```java
var lst = new ArrayList<String>();
lst.addFirst("a1"); lst.add("a2"); lst.addLast("a3");
var x1 = Collections.binarySearch(lst, "a3");  // 未排序 → 結果不保證
Collections.sort(lst);
var x2 = Collections.binarySearch(lst, "a3");  // 已排序 [a1,a2,a3] → 2
var list2 = lst.reversed();                    // [a3,a2,a1]
var x3 = Collections.binarySearch(list2, "a3");// 反序 [a3,a2,a1] → binarySearch 要求升序，但此處恰為 0？錯誤用法→-4
var x4 = Collections.binarySearch(list2, "a0");// -1
```
**Ans:** ✅ **B: `2 2 -4 -1`**。重點：`binarySearch` **要求 list 為「升序」**。`list2` 是反序（descending），對下降順序 list 做 binarySearch 屬**未定義結果**（此例回 -4），對不存在的 a0 回 insertion point 負值 -1。

## Q14（sealed）
```java
sealed class Account permits BankAccount {}
sealed class BankAccount extends Account permits CreditAccount {}
non-sealed class CreditAccount extends BankAccount {}
public class MyExamCloud {
  public static void main(String[] args) {
    Account bA = new BankAccount();
    Account cA = new CreditAccount();
    if (cA instanceof BankAccount ba) {
      ba.methodB();
      if (ba instanceof CreditAccount ca) { ca.methodC(); }
    } else { cA.methodA(); }
  }
}
```
輸出？
- A: `methodB methodC`  B: `methodB methodB`  C: `methodB methodA`  D: `methodA methodB`

**Ans:** ✅ **A**。`cA`（CreditAccount）是 BankAccount → 進 if → `ba.methodB()` 印 methodB；`ba` 又是 CreditAccount → `ca.methodC()` 印 methodC → **methodB methodC**。

## Q15（enum switch）
```java
public enum AI_MODELS {
  ML('A'), SL('B'), UL('C'), DL('D');
  char c; private AI_MODELS(char c){ this.c = c; }
}
// main:
Arrays.stream(AI_MODELS.values()).dropWhile(s -> s.equals(AI_MODELS.SL)); // 中斷式，丟棄到 SL → 結果未使用
switch (AI_MODELS.valueOf("SL")) {
  case ML -> println("Machine learning");
  case SL -> println("Supervised learning");
  case UL -> println("Unsupervised learning");
  case DL -> println("Deep learning");
  default -> println("Undefined AI Model");
}
```
**Ans:** ✅ **B: `Supervised learning`**。`valueOf("SL")` → SL → `case SL` → "Supervised learning"。dropWhile 結果未指派，不影響輸出。enum switch 對 `values()` 不窮舉亦可（此處有 default）。

## Q16（Serialization / transient / static）
```java
class Course implements Serializable {
  private static float averagePrice = 9.99f;
  private String description;
  private transient float price;
  public Course(String d, float p){ description=d; price=p; }
  public void readObject(ObjectInputStream in) throws IOException, ClassNotFoundException {
    in.defaultReadObject();
    price = averagePrice;
  }
  public String toString(){ return description + " " + price + " " + averagePrice; }
}
// 建 Course("Java 21 Practice Tests", 19.99f)，序列化再反序列化
```
輸出？
- A: `Java 21 Practice Tests 9.99 9.99`  B: `... 19.99 19.99`  C: `... 0.0 0.0`
- D: exception  E: 編譯失敗  F: `... 0.0 9.99`

**Ans:** ✅ **F: `Java 21 Practice Tests 0.0 9.99`**。`price` 是 **transient** → 不序列化、反序列化後為 `0.0`，但自訂 `readObject` 內 `price = averagePrice`（static，非序列化、為初始 9.99）→ price=9.99。`averagePrice`（static）序列化後仍是 9.99。→ `description 0.0 9.99`。（題目選項 F 為 `0.0 9.99`，視版本而定。）

## Q17（Overload 多載）
```java
public void addAll(int a, int b){ print(" A"); }
public void addAll(int a, float b){ print(" B"); }
public void addAll(float a, float b){ print(" C"); }
public void addAll(double... a){ print(" D"); }
// main:
mc.addAll(1, 2.5f);   // int,float → B
mc.addAll(1, 2);      // int,int → A
mc.addAll(1.5, 2.5);  // double,double → 無固定 → varargs D
```
**Ans:** ✅ **C: `B A D`**。`addAll(1,2.5f)` → `(int,float)` B；`addAll(1,2)` → `(int,int)` A；`addAll(1.5,2.5)` → double literals 無固定匹配 → `double...` D。

## Q18（parallel reduce identity）
```java
public String addCourse1(List<String> data) {
  return data.parallelStream().reduce("J", (n,m)->n+m, String::concat);
}
public String addCourse2(List<String> data) {
  return data.parallelStream().reduce((l,p)->l+p).get();
}
// list = ["Java","Python"]
// print(c1 + " " + c2)
```
**Ans:** ✅ **B: `JJavaJPython JavaPython`**。`addCourse1`：identity="J"，parallel 下每個 chunk 應用 identity → `JJava`（chunk Java）、`JPython`（chunk Python）→ **非冪等 identity 造成** `JJavaJPython`。`addCourse2`：無 identity 用 `reduce((a,b)->a+b)`（組合器省略同 BinaryOperator）→ `JavaPython`。

## Q19（static 存取 instance 欄位）
```java
class Course {
  String name;
  public static void getName() { name = "Java"; println(name); }  // ❌ static 不可存取 instance 欄位
  public void getName(String name) { this.name += name; println(name); }
}
```
讓程式編譯的動作？
- A: `String name;` → `final String name;`
- B: `String name;` → `static String name;`
- C: `public static void getName()` → `public void getName()`
- D: `public void getName(String name)` → `void getName(String name)`

**Ans:** ✅ **B**。`getName()` 是 static，卻存取 instance 欄位 `name` → 編譯錯。把欄位改 **static**（B）即可（static 方法只能存取 static 成員）。D 改回傳修飾不回補助。

## Q20（Localization ResourceBundle）
```
app.properties:       name = myexamcloud
app_en.properties:    name = MyExamCloud(EN)
app_US.properties:    name = MyExamCloud(US)
app_en_US.properties: name = MyExamCloud(EN US)
```
```java
Locale.setDefault(Locale.US);
Locale currentLocale = new Locale.Builder().setLanguage("en").build();
ResourceBundle captions = ResourceBundle.getBundle("app.properties", currentLocale);
System.out.println(captions.getString("name"));
```
結果？
- A: `MyExamCloud(EN)`  B: `myexamcloud`  C: `MyExamCloud(US)`  D: `MyExamCloud(EN US)`  E: MissingResourceException

**Ans:** ✅ **B**。`getBundle("app.properties", ...)` 的 bundle base name 是 **`app.properties`**（含 `.properties` 字尾！），系統找不到 `app.properties_en_...` 的資源檔 → 直接載入**基底** `app.properties`（name=myexamcloud）。→ 印 `myexamcloud`。
（正確 bundle name 應為 `app` 不含副檔名，才能套用 locale fallback。）

## Q21（switch statement — 合併 case）
```java
class MyExamCloud {
  static void testName(Object o) {
    switch (o) {
      case null, String s -> System.out.println("Name: " + s.toString());
      case default -> System.out.println("Default");
    }
  }
  public static void main(String as[]) { testName(null); }
}
```
編譯/執行結果？
- A: 不能編譯（不能 `case null, String s` 合併）
- B: 編譯並印 Name
- C: 編譯並執行時拋 NPE
- D: 編譯並印 Default

**Ans:** ✅ **A**（不能編譯）。在 **switch statement**（非 expression）中，**`case null, String s` 不能合併**——pattern label 與 `null` 無法在同一 case 群組（Java 語法限制：`null` label 只能單獨，或與 guard 搭配在 expression 中）。statement 版此寫法不合法。

## Q22（multiple finally）
```java
try { new MyExamCloud().method(); }
catch(ArithmeticException e){ print("Arithmetic"); }
finally { print("final 1"); }
finally { print("final 2"); }   // ❌ 第二個 finally → 編譯錯
```
**Ans:** ✅ **E: 編譯失敗**。一個 try 只能有**一個** finally 區塊 → 出現兩個 finally → 編譯錯誤。

---

# Part B — Javarevisited 樣本題（10 題，選項已知，答案請演算/驗證）

## B1（reduce）
```java
String[] letters = {"x","y","z","w","v","u"};
String output = "Sequence:";
for (String ch : letters) { output += "-" + ch; }
```
哪個片段與上述迴圈產生相同結果？
- A: `Arrays.stream(letters).reduce("Sequence:", (s1,s2)->s1+"-"+s2)`
- B: `output += Arrays.stream(letters).parallel().reduce((s1,s2)->s1+"-"+s2).get()`
- C: `Arrays.stream(letters).parallel().reduce("Sequence:", (s1,s2)->s1+"-"+s2)`
- D: `output += Arrays.stream(letters).parallel().reduce("", (s1,s2)->s1+"-"+s2)`

**Ans（推導）:** ✅ **A**。A 有 identity `"Sequence:"`，結果 `Sequence:-x-y-z-w-v-u` 與迴圈相同。
- B 少了 identity 起始（`reduce((a,b)->...)` 從第一個元素起 → 以 `output` 開頭再 concat → `Sequence:-x-y...` 但 parallel 無 identity，順序可能不同）。
- C 非冪等 identity `"Sequence:"` 在 parallel 下被重複套用 → 多餘。
- D identity `""` 起始無 `Sequence:`，parallel 下順序不保證。
> 正確答案：**A**（偶爾同測驗標記可能有差異，請實測）。

## B2（labeled loop）
```java
String[] txt = {"AB","CD"};
x: for (String value : txt) {
  var values = value.toCharArray();
  for (int i = values.length - 1; i >= 0; i--) {
    if (i < 1) continue x;
    else if (values[i] == 'C') break;
    System.out.println(txt[i]);
  }
}
```
結果？選項含 A) A B) AB C) AD D) AB E) CDCD F) ABAB G) 無輸出
**Ans（推導）:** 第一輪 value="AB"（values=[A,B]，i 從 1）：i=1 → 非 i<1、非 C → `println(txt[1]="CD")`→CD。i=0 → `continue x`。第二輪 value="CD"：i=1 → values[1]='D' 非 C → `println(txt[1]="CD")`→CD。i=0 → `continue x`。→ 印 **`CDC D` = `CDC D`...** 即兩行 `CD`。此題選項看似有缺字，重點是流程：印出兩次 `txt[1]`（="CD"）。

## B3（var 合法宣告）
哪個 local `var` 初始化合法？
- A: `var 24H = Duration.ofHours(24);`（識別字不能用數字開頭 → 錯）
- B: `var backslashChar = '\\';` ✅
- C: `var doubleSlash = "\\\\";` ✅（含兩個反斜線字元的字串）
- D: `var underscoreIndex = "A_Z".indexOf("_");` ✅
- E: None

**Ans:** ✅ **B、C、D**（A 識別字 `24H` 不合法）。此題若單選則為 B/C/D 皆可；依題意「哪個是正確」通常選 B 或 D（視題目單/多選）。

## B4（ArrayDeque offerFirst/Last）
```java
int[] values = {-1,-2,0,2,1};
Deque<Integer> numbers = new ArrayDeque<>();
for (int i = 0; i < values.length; i++) {
  if (i%2 == 0) numbers.offerFirst(Integer.valueOf(values[i]));
  else          numbers.offerLast(Integer.valueOf(values[i]));
}
println(numbers);
```
**Ans（推導）:** 逐項：
- i=0（偶, offerFirst -1）: [-1]
- i=1（奇, offerLast -2）: [-1,-2]
- i=2（偶, offerFirst 0）: [0,-1,-2]
- i=3（奇, offerLast 2）: [0,-1,-2,2]
- i=4（偶, offerFirst 1）: [1,0,-1,-2,2]
→ **`[1, 0, -1, -2, 2]` = A**。

## B5（switch pattern on Number）
```java
public static String test(Number value) {
  return switch(value) {
    case Double num when num > 0 -> "Positive";
    case Double num when num < 0 -> "Negative";
    case Double num when num == 0 -> "Zero";
    default -> "Invalid";
  };
}
// main: Number num = Integer.valueOf(1); print(test(num)); num=null; print(test(num));
```
選項：A) ErrorError B) InvalidError C) PositiveInvalid D) InvalidInvalid E) PositiveError F) None
**Ans（推導）:** `Integer.valueOf(1)` 是 Integer，非 Double → 都不命中 → `default` → **"Invalid"**。`num=null` → 無 `case null` → `default` → **"Invalid"**。→ **`InvalidInvalid` = D**。

## B6（DateTimeFormatter pattern "CM"）
```java
DateTimeFormatter fmt = DateTimeFormatter.ofPattern("CM");
var x = LocalDate.of(2001, 2, 5);
var y = Period.ofMonths(3).plusDays(1);
var z = x.plus(y);            // 2001-05-06
println(fmt.format(z));        // C=世紀(century)，M 被視為月？pattern 無年月區分→可能拋出或怪異
```
**Ans（推導）:** pattern `"CM"`：`C` 是「世紀年 / 2001 的世紀」；`M` 是月份。`z = 2001-02-05 + 3月+1天 = 2001-05-06`。`C`(2001→世紀 20；"CM" 輸出會是 `20` + M=5 → "205"？)。此題為往年真題陷阱，pattern 不完整會丟出異常。**此題建議實測**；`Period.plusDays` 於月份交錯時，5/06 的月 = 5。選項答案多為 `38`、`56`、`83`、`65` 等——以 javac 實測為準。

## B7（parallel stream sorted + forEach）
```java
IntStream.concat(IntStream.range(0,3), IntStream.range(3,7))
  .parallel().sorted().filter(i -> i<5 && i>1).mapToObj(i->String.valueOf(i))
  .forEach(s -> Logger.getLogger("test").log(Level.INFO, s));
```
選項：A) 2,3,4 無序 B) 6,5,1,0 C) 0,1,5,6 無序 D) 4,3,2 有序 E) 2,3,4 有序 F) 0,1,5,6 有序
**Ans（推導）:** 資料 0..6，filter `i<5 && i>1` → {2,3,4}。`parallel().sorted()` 排序後 encounter order 2,3,4。但 **`forEach` 於 parallel 不保證順序**！→ 印 **{2,3,4} 以無序** → 選 **A**。（若要保序用 forEachOrdered。）

## B8/B9（synchronizedList + invokeAll）
```java
List<Integer> nums = Collections.synchronizedList(new ArrayList<>());
Callable<String> c = () -> { for (int i=0;i<5;i++) nums.add(i); return null; };
Collection<Callable<String>> tasks = List.of(c, c, c);
ExecutorService es = Executors.newFixedThreadPool(2);
try { List<Future<String>> res = es.invokeAll(tasks); es.shutdown();
  nums.stream().forEach(System.out::print); }
catch (InterruptedException e) { print("error"); }
```
**Ans（推導）:** `synchronizedList` 保證 `add` 是 atomic（彼此不互相破壞），所以**所有 15 次 add 都會成功**，每次加 0..4。故最後 nums 含 {0,1,2,3,4} 各 3 次。但**執行順序（哪些 add 先發生）不保證** → 印出所有 0..4 **各 3 次、隨機順序**。→ 對 B9 挑「All of the integers 0 to 4 in stochastic order, each appears 3 times」= **D**。B8 同理（選項同型）。

## B10（stream 找最低卡路里）
```java
Food[] foods = {Apple 200, Banana 400, Cake 800, Donut 700};
IntStream.generate(() -> ThreadLocalRandom.current().nextInt(foods.length))
  .mapToObj(i -> foods[i]).sorted((f1,f2)->f1.calories()-f2.calories()).findFirst().get();
```
- A: 用 `nextInt(foods.length-1)` + `.limit(10)` + `.max(...)`
- B: `nextInt(foods.length-1)` 無 limit + sorted + findFirst
- C: `nextInt(foods.length)` + sorted (升序) + findFirst
（要找最低卡路里）
**Ans（推導):** 
- A：`nextInt(foods.length-1)` 只產生 0..2，**永遠不選 Donut(3)**；且用 `.max()`（取最高）→ 錯。
- B：`nextInt(foods.length-1)` 只到 index 2，漏 index 3；且無 limit 無窮流但 sorted 會先收集完畢 → 找不到索引 3。
- C：`nextInt(foods.length)` 可含全部索引，sorted 升序後 `findFirst()` 得最小卡路里 ✅。
→ **C 正確**。

---

# Part C — DBExam 樣本題（10 題）

## C1（Path / Files）
```java
var p = Path.of("sloth.schedule");
var a = Files.readAttributes(p, BasicFileAttributes.class);
Files.mkdir(p.resolve(".backup"));       // ❌ 無 Files.mkdir 方法
if(a.size()>0 && a.isDirectory()) {
  a.setTimes(null,null,null);             // ❌ BasicFileAttributes 無 setTimes
}
```
**Ans:** ✅ **c、e**。`Files.mkdir(...)` 不存在（應為 `Files.createDirectory`）；`BasicFileAttributes.setTimes` 不存在（應為 `BasicFileAttributes` 唯讀，`setTimes` 在 `FileTime`/`BasicFileAttributeView`）。

## C2（runtime image 工具）
何者可建立 Java runtime image？
- a) jlink  b) javac  c) jar  d) jmod
**Ans:** ✅ **a) jlink**。

## C3（interface 未實作全部方法）
類別實作 interface 但未實作所有 abstract 方法 → 要編譯必須？
**Ans:** ✅ **b) 類別必須宣告 abstract**。

## C4（建立 parallel stream）
```java
var c = List.of(19, 66);
var s = ThreadLocalRandom.current().doubles();
var p = _________;   // Choose two
a) new ParallelStream(s)  b) c.parallel()  c) s.parallelStream()  d) c.parallelStream()  e) new ParallelStream(c)  f) s.parallel()
```
**Ans:** ✅ **d、f**。`List.parallelStream()`；`DoubleStream.parallel()`。`s.parallelStream()` 是 collection 的方法，stream 上無此方法；`c.parallel()` 回 Stream（非 parallelStream 但 parallel() 使串流平行 ✅——注意 `Stream.parallel()` 存在）；此題標準答案 d、f。

## C5（try-with-ressource var）
```java
var res = new java.io.StringReader("hi");
try (res) { System.out.print("read "); }
System.out.print("done");
```
**Ans:** ✅ **d) `read done`**。`res` 已在外部以 `var` 宣告，於 try-with 中引用為 effectively final 資源合法；執行 `read ` 後印 `done`，且 reader 在 try-with 結束時自動關閉（`read done`）。

## C6（catch 順序 — 不可達）
```java
try {
  Object o = null; o.toString();   // NullPointerException
} catch (RuntimeException e) { print("runtime"); }
  catch (NullPointerException e) { print("npe"); }   // ❌ NPE 是 RuntimeException 子類 → 不可達
```
**Ans:** ✅ **a) 編譯失敗**（第二個 catch 不可達）。因 NPE 是 RuntimeException 子類，會被第一個 catch 捕到。

## C7（while 迴圈特性）
哪個迴圈「初始化在外部、且在第一次迭代前評估條件」？
**Ans:** ✅ **c) while 迴圈**。

## C8（模組 package 衝突）
module path 上兩個模組都有 `com.shared.util`，第三模組同時 requires 兩者？
**Ans:** ✅ **a) module graph 無法解析，因為 package 只能存在於一個模組**。

## C9（sealed — 正確兩項）
- a) switch over sealed type 若所有 permits 子型別都涵蓋則不需 default ✅
- b) sealed 類別每個直接子類別必須 final、sealed 或 non-sealed ✅
- c) permits clause 僅在 permitted subtype 於不同 package 時可省略 ❌
- d) sealed 不能作為 switch expression selector ❌
- e) sealed interface 不能由 record 實作 ❌（可）
- f) sealed 類別可由同 package 任意類別繼承而無需 permits ❌
**Ans:** ✅ **a、b**。

## C10（service provider 模組）
已有 SPI module、service provider、service locator、consumer 四個模組；若再加一個 service provider module，需重新編譯幾個既有模組？
**Ans:** ✅ **c) 0 個**。新增 provider 不需重編既有模組（ServiceLoader 動態載入）。

---

# Part D — Tech Exam Lexicon 樣本題（4 題，含解析）

## D1（Pattern variable scope）
```java
static String label(Object value) {
  if (value instanceof String s && s.length() > 3) { return s.substring(0,3); }
  else { return s; }          // ❌ s 不在 else scope
}
```
- A: 編譯且在長字串回前 3 字  B: 編譯回原物件  C: **s 不在 else scope → 編譯失敗**  D: 執行時 ClassCastException
**Ans:** ✅ **C**。pattern variable `s` 只在 `&&` true 分支作用；else 中不可用 → 編譯錯誤。

## D2（Stream 重用）
```java
var stream = Stream.of("a","bb","ccc");
var count = stream.filter(s->s.length()>1).count();  // terminal → 2
var first = stream.findFirst();                       // ❌ 重用已消費 stream
```
**Ans:** ✅ **C**。stream 單次使用；`count()` 後再 `findFirst()` → `IllegalStateException`。

## D3（Record compact constructor）
```java
record Course(String code, int seats) {
  Course {
    if (seats < 0) throw new IllegalArgumentException();
    code = code.strip().toUpperCase();
  }
}
```
- A: compact constructor 可在欄位指派前驗證/正規化參數 ✅
- B: 不能指派 code 因為 final ❌
- C: 必須明確指派 this.code/this.seats ❌
- D: records 建構子不能拋例外 ❌
**Ans:** ✅ **A**。compact constructor 的參數可再指派，隱式欄位指派在 body 結束後進行。

## D4（generic invariance）
哪個能讀 Integer/Long/Double list 而不新增？
- A: `List<Number>`  B: `List<? extends Number>`  C: `List<? super Number>`  D: `List<Object>`
**Ans:** ✅ **B**。`? extends Number` 為 producer 上界通配，可讀為 Number。

---

# Part E — Q&A 學習指南（Anasss java21docCards / GitHub MIT）

> 完整 Q&A 學習指南內容已另存於 `C:\temp\android_learning\1Z0-830_Study_Guide.md`。
> 此指南以「問答式」覆蓋各考點（sealed、records、enum、泛型通配、streams、例外、日期時間、I/O、JPMS、並行、虛擬執行緒等），適合當考前複習速查。請參閱該檔。

---

## 附註
- 上述 Part A–D 全部源自公開免費網頁內容，**正確答案以原始來源與本機 javac 21 實測為準**；其中註記「推導」者為作者依 Java 規則推導，建議執行驗證。
- 付費/需登入來源（freecram 85 題、theexamslab 84 題、certmage PDF、originaldumps PDF 等）未納入，因內容鎖付費或版權。
- 免費可下載的 1Z0-830 PDF 樣本（如 braindumpstudy 的 demo PDF）通常只含少數題目，多數完整題庫需付費。
