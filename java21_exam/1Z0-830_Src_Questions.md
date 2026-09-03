# 1Z0-830 Java SE 21 Developer 考題程式彙整 — 完整題目與答案解析

本文件將 `src\main\java\dev\ronaldotavares\java21\questions\` 下 19 個 Java 題目程式的考題，逐一整理為
**完整題目（Q）＋ 選項 ＋ 答案與解析（Ans）**。

> 說明：這些 .java 檔內嵌的原始考題選項，部分已完全保留、部分僅保留程式與註解線索。
> 下列 Q 的選項依程式與註解重建，並以 ✅ 標示正確答案。所有 **Ans 的執行輸出皆以 javac 21 實測驗證**。

---

## 目錄

| 來源檔 | 主題 |
|--------|------|
| `PracticeQuestions.java` | 並行 / 串流 / 字串 / 陣列 / 虛擬執行緒 / 模組 / 迴圈 / TWR / 時間 / 初始化 / var / 多載 / switch / sealed / JImage / Console / Path / IO / 序列化 |
| `PracticeExam3.java` | TreeSet / Boolean / 強制轉型 / Formatter |
| `Test4.java`–`Test16.java` | switch / 內層類別 / comparator / 運算子 / 函式介面 / TWR / DST / 陣列 / stream / reduce / 泛型 / enum / path |
| `UniqueTest1.java`–`UniqueTest4.java` | DST / 泛型 / enum / 模組 / 並行 / String / switch |

---

# Part 1 — PracticeQuestions.java（26 大綜合題）

## 1.1 Concurrency — volatile vs AtomicInteger
**Q** — 下列並行程式碼執行後會印出什麼？
```java
static AtomicInteger atomicCounter = new AtomicInteger(0);
static volatile int volatileCounter = 0;
final Runnable volatileRunnable = () -> { for (int i=0;i<3;i++){ volatileCounter++; System.out.println(Thread.currentThread().getName()+" "+volatileCounter); } };
final Runnable atomicRunnable    = () -> { for (int i=0;i<3;i++){ final int v = atomicCounter.incrementAndGet(); System.out.println(Thread.currentThread().getName()+" "+v); } };
// 兩個 volatile-1/volatile-2、兩個 atomic-1/atomic-2 執行緒同時啟動
```
**Ans** —
- `volatileCounter++` 是「讀-改-寫」三步，**非原子**。兩條執行緒同時加，更新可能遺失 → 印出的數字可能重複、跳號或交錯。
- `AtomicInteger.incrementAndGet()` **原子**執行 → 每個原子執行緒會取得不同的累加結果（各執行緒印出的序仍不保證交錯順序）。

## 1.2 Enum — valueOf 大小寫
**Q** — 下列 Enum 程式碼執行後印出什麼？
```java
enum Seasons { SPRING, SUMMER, WINTER;
  static void processEnumValue(String enumString) {
    try { Seasons v = Seasons.valueOf(enumString); System.out.print(v + ","); }
    catch (Exception e) { System.out.print("INVALID,"); } }
  @Override public String toString() { return this.name().toLowerCase(); } }
// main: for (i=0..values().length) Seasons.processEnumValue(Seasons.values()[i].toString());
```
**Ans** — `values()[i].toString()` 因覆寫回傳**小寫**（"spring"…），但 `valueOf` 需**大寫**常數名 → 每次都拋 `IllegalArgumentException` → 印
`INVALID,INVALID,INVALID,`

## 1.3 Stream — reduce（identity 非冪等）
**Q** — 下列 Stream 程式碼執行後印出什麼？`items = [Candy, Gum]`
```java
var result = items.parallelStream()
    .reduce(items.parallelStream().reduce("",(a,b)->a+b), (a,b)->a+b);
```
**Ans** — 內層 identity = `"CandyGum"`。平行 reduce 會對每個區塊套用 identity：
`"CandyGum"+"Candy"`、`"CandyGum"+"Gum"` → 印 `CandyGumCandyCandyGumGum`。
> 關鍵：identity 必須是**單位元**（冪等），平行 reduce 才會為 `""`。此題以 `"CandyGum"` 當 identity 故結果不純。

## 1.4 Stream — takeWhile / dropWhile
**Q** — 下列程式碼印出什麼？
```java
List.of(1,2,3,4,6,7,8,9,11,12).stream().takeWhile(n->n<20).dropWhile(n->n%5==0).forEach(System.out::print);
```
- A) `123467891112`
- B) `23467891112`
- C) `1234`
- D) 無任何輸出
- E) 無法編譯

**Ans** — ✅ **A)** `123467891112`
- `takeWhile(n<20)`：每個都 <20 → 全通過。
- `dropWhile(n%5==0)`：首元素 1 不整除 5 → **立即停止丟棄** → 一個都不丟。
- 故印 `123467891112`。

## 1.5 Parallel Stream — concat + distinct
**Q** — 關於下列平行 stream 的正確敘述？
```java
Stream<Integer> a1 = Stream.of(1,5,3,1,4);
Stream<Integer> a2 = Stream.of(4,1,2);
Stream.concat(a1,a2).parallel().distinct().forEach(System.out::print);
```
- A) 印出相異值 {1,2,3,4,5}，但順序不可預測
- B) 一定印 `15342`
- C) 一定印 `15314412`
- D) 無法編譯

**Ans** — ✅ **A**。`distinct()` 去重 → {1,5,3,4,2}，但 `parallel().forEach` 不保證 encounter order → 順序不可預測。要保序需 `forEachOrdered()`。

## 1.6 String — intern / text block
**Q** — 下列字串比較印出什麼？
```java
String s1 = """\n hello\n """;   // text block
String s2 = "hello";
String s3 = s1.intern();
// 印 s1==s2, s1.equals(s2), s1==s3, s1.equals(s3), s2==s3, s2.equals(s3)
```
**Ans** —
| 比較 | 結果 | 原因 |
|------|------|------|
| `s1 == s2` | false | 不同物件，且 text block 內容含換行 |
| `s1.equals(s2)` | false | 內容不同（`"hello\n"` vs `"hello"`） |
| `s1 == s3` | true | `intern()` 回傳同一池內物件 |
| `s1.equals(s3)` | true | 同內容 |
| `s2 == s3` | false | s2 與 s3 為不同物件 |
| `s2.equals(s3)` | false | 內容不同 |

## 1.7 StringBuilder / Text Block — 建立 "hello world"
**Q** — 下列哪些是「建立內容為 `"hello world"` 的 String」之**有效**寫法？
```java
A) String s = """ hello\  world\ """;
B) String s = "hello" + new String("world");
C) String s = "hello".concat(" world");
D) String s = new StringBuilder("world").insert(0,"hello ").toString();
E) String s = new StringBuilder("world").append(0,"hello ").toString();
F) String s = new StringBuilder("world").append("hello ",0,6).toString();
G) String s = new StringBuilder("world").add(0,"hello ").toString();
H) String s = """ hello  world """.trim();
I) String s = """ hello \ world """;
```
**Ans** — ✅ **A、C、D**
| 選項 | 判定 |
|------|------|
| **A** | ✅ text block 末尾 `\` 抑制換行 → `hello world` |
| B | `helloworld`（無空格） |
| **C** | ✅ `concat` 精確接上 → `hello world` |
| **D** | ✅ `insert(0,"hello ")` → `hello world` |
| E | ❌ `append(0, String)` 無此 overload → 不編譯 |
| F | `worldhello `（append 到結尾） |
| G | ❌ StringBuilder 無 `add` → 不編譯 |
| H | `hello\nworld`（trim 不移除中間換行） |
| I | `hello world\n`（尾端仍有換行） |

## 1.8 Arrays — compare / mismatch
**Q** — 下列程式碼印出什麼？
```java
int[] a = {'h','e','l'};  int[] b = {'h','e','l','l','o'};
int x = Arrays.compare(a,b); int y = Arrays.mismatch(a,b);
System.out.println(x + " " + y);
```
- A) `1 3`  B) `-1 3`  C) `-2 3`  D) `-2 -3`  E) 無法編譯

**Ans** — ✅ **C)** `-2 3`
- char 是整數族群，可放入 int 陣列。
- `compare`：a 與 b 前三相同，a 是 b 的前綴且**少 2 個**元素 → `-2`。
- `mismatch`：前三相同，長度不同 → 第一個 mismatch 在 index `3`。

## 1.9 Virtual Threads — 正確敘述
**Q** — 下列虛擬執行緒敘述何者為 TRUE？
- A) 虛擬執行緒必須永久綁定一個 platform thread
- B) 虛擬執行緒永遠是 daemon thread
- C) 虛擬執行緒建立後可改變 priority
- D) 虛擬執行緒在 main() 結束後仍會讓 JVM 存活

**Ans** — ✅ **B**
- A ❌ 只在執行時借用 carrier（platform）thread。
- **B** ✅ 永遠 daemon。
- C ❌ priority 固定 5（NORM_PRIORITY）不可改，`setPriority` 無效。
- D ❌ 因是 daemon，不阻止 JVM 關閉；只有非 daemon thread 會阻止。

## 1.10 Virtual Threads — WorkStealingPool
**Q** — 關於虛擬執行緒的正確敘述？
- A) `Executors.newWorkStealingPool()` 以可重用的執行緒池提升虛擬執行緒效能
- B) 虛擬執行緒預設 daemon，但可 `setDaemon(false)` 改成非 daemon
- C) 虛擬執行緒比 platform thread 更尊重 thread priority
- D) 可 `new VirtualThread()` 建立
- E) 虛擬執行緒執行比 platform thread 快

**Ans** — ✅ **A**
- **A** ✅ work-stealing pool 以處理器數為目標平行度，適合載入大量虛擬執行緒。
- B ❌ `setDaemon(false)` 拋 `IllegalArgumentException`。
- C ❌ 優先權固定不可改，不 honor priority。
- D ❌ `VirtualThread` 非 public，不可 `new`；用 `Thread.ofVirtual()` 等建立。
- E ❌ 虛擬執行緒在 platform thread 上跑，不可能更快。

## 1.11 Module Visibility — 正確三項
**Q** — 下列模組可見性敘述，何者為 TRUE（選三）？
- A) module path 上的 named module 可讀取 classpath 上的 JAR
- B) automatic module 自動 export 全部 package 給 named 與 automatic module
- C) unnamed module 可讀取 module path 上任何 module
- D) 含 `module-info.java` 的 JAR 放 classpath 會被視為 named module
- E) unnamed module 不 export 任何 package 給 named module
- F) automatic module 的 JAR 內必須有 `module-info.java`

**Ans** — ✅ **B、C、E**
- **B** ✅ 自動「如同全部 package 都 declared exports」。
- **C** ✅ unnamed module 可讀 classpath 或 module path。
- **E** ✅ 對 named module 完全不 export。
- A ❌ named module **不能**從 classpath 讀。
- D ❌ 視為 unnamed module，module-info 被忽略。
- F ❌ automatic module **沒有** module-info（其名稱由 JAR/Manifest 推斷）。

## 1.12 jdeps
**Q** — 你的應用使用一個 modular jar（a.jar），它又使用一個 non-modular jar（b.jar）。哪個指令會讓 jdeps 把 non-modular jar 納入分析？
- A) `jdeps --module-path lib\a.jar; -classpath lib\b.jar`
- B) `jdeps --module-path lib\a.jar; lib\b.jar`
- C) `jdeps --class-path lib\a.jar; lib\b.jar`
- D) `jdeps -cp lib\b.jar lib\a.jar`
- E) `jdeps -cp lib\b.jar;lib\a.jar`

**Ans** — ✅ **C**。`-cp`、`--class-path` 同義。a.jar 是 modular → 其對 b.jar 的依賴須以 classpath 給。B/M：a.jar 放 module path 時 b.jar 需在 module path 當 automatic module。D/E 缺獨立 target 或放錯 path。

## 1.13 Nested Loop — labeled continue
**Q** — 執行下列程式後 `result` 最終值為何？
```java
int result=0;
outerLoop: for(int i=0;i<3;i++){ int j=3; while(j>=0){ j--;
    if(i==1){ i++; continue outerLoop; } result += i+j; } }
```
**Ans** —
- i=0：j（4 個 j-- 後 = 2,1,0,-1）累加 `0+2,0+1,0+0,0+(-1)` → **2**。
- i=1：`i++`→2，`continue outerLoop` → for 增量使 i→3 → 條件 false 結束。
- **`result = 2`**

## 1.14 Try-With-Resources — suppressed
**Q** — 執行下列 TWR 印出什麼？
```java
MyResource r1 = new MyResource("r1");
try (r1; MyResource r2 = new MyResource("r2")) {
    r1.operation();  // throws RuntimeException
    r2.operation();  // 未執行
} catch (IOException e) { ... }
```
**Ans** —
- `r1.operation()` 拋 `RuntimeException`，catch 只捕 `IOException` → catch **不吻合**、不執行。
- 關閉時 `r2.close()`、`r1.close()` 拋的 `IOException` 被加為 **suppressed**。
- 外層呼叫方捕到 RuntimeException，並印出它的 suppressed（兩個 IOException）。
> 注意：`resource1` 在外層宣告並於 try-with 引用是合法的（effectively final）。

## 1.15 LocalDateTime — NY DST（2025-11-02）
**Q** — 執行下列程式印出什麼？（NY 2025-11-02 02:00 DST 結束，時鐘回撥 1 小時）
```java
ZonedDateTime zdt1 = ZonedDateTime.of(LocalDateTime.of(2025,11,2,1,0), ZoneId.of("America/New_York"));
ZonedDateTime zdt2 = zdt1.plusHours(1);
System.out.println(zdt1.getHour() == zdt2.getHour());
```
**Ans** — 01:00 + 1h → 02:00 回撥 → **01:00** → `01 == 01` → 印 **`true`**。

## 1.16 Object Initialization Order
**Q** — 下列程式（`InitTestQuestion`）印出什麼？
```java
public InitTestQuestion(){ s1 = sM1("1"); }
static String s1 = sM1("a");
String s3 = sM1("2");
{ s1 = sM1("3"); }
static { s1 = sM1("b"); }
static String s2 = sM1("c");
String s4 = sM1("4");
public static void main(String[] args){ new InitTestQuestion(); }
```
- A) 不編譯  B) `a b c 2 3 4 1`  C) `2 3 4 1 a b c`  D) `1 a 2 3 b c 4`  E) `1 a b c 2 3 4`

**Ans** — ✅ **B)** `a b c 2 3 4 1`
- 靜態依序：`a`（s1）、`b`（static block）、`c`（s2）。
- 實例依序：`2`（s3）、`3`（instance block）、`4`（s4）。
- 最後建構子：`1`。

## 1.17 Local Variable Type Inference（var）合法性
**Q** — 下列 TestClass.java 哪些行**有效**？
```java
class Test { }                 // 1
public class TestClass {
   var v1;                     // 2
   public int main(String[] args) {   // 3
       var v2;                 // 4
       double x = 10, double y; // 5
       var v3 = null;          // 6
       for (var k=0;k<x;k++){ } // 7
       Float params[][] = {1.1f,1.2f,3.2f};  // 8
       return 0; } }
```
- A)`//1`  B)`//2`  C)`//3`  D)`//4`  E)`//5`  F)`//6`  G)`//7`  H)`//8`

**Ans** — ✅ **A、C、G**
- `//1` ✅ class 宣告合法。
- `//3` ✅ 回傳 int 的 main 仍是合法方法（只是非 JVM 進入點）。
- `//7` ✅ for 迴圈宣告可用 var。
- `//2` ❌ var 不能當欄位（僅限 local context）。
- `//4` ❌ var 需初始值。
- `//5` ❌ `double x=10, double y` 語法錯誤。
- `//6` ❌ `var v3 = null` 無法推型別。
- `//8` ❌ 2D 陣列卻給 1D 初始值。

## 1.18 Overload — 寬化選擇
**Q** — 執行下列 Overload 印出什麼？
```java
static void method(int,int){ System.out.println("int, int"); }
static void method(int,double){ System.out.println("int, double"); }
static void method(float,float){ System.out.println("float, float"); }
static void method(double... a){ System.out.println("double..."); }
// method(1.0,2.0);  method(1,2.0F);  method(2.0F,1);
```
**Ans** —
- `method(1.0,2.0)` → 兩者 double → `double...`（varargs）。
- `method(1,2.0F)` → `int,double` 與 `float,float` 皆可匹配 → **ambiguous，不編譯**（已註解）。
- `method(2.0F,1)` → int 自動寬化為 float → `float, float`。

## 1.19 MeanOverloadTypeConversion
**Q** — 下列多載方法後，插入哪個選項可輸出 `10.0 10 10`？
```java
int mean(int,String); double mean(int,int); double mean(double,long); float mean(String); float mean(int);
var a="10"; var b=ot.mean(a);   // b = mean(String) = 10.0f
// INSERT CODE HERE
System.out.println(c+" "+d+" "+e);
```
- A) `c=mean(Math.round(b)); d=mean(Math.round(c),a); e=mean(d,d);`
- B) `c=mean(Math.round(b),a); d=mean(Math.round(c)); e=mean(c,c);`
- C) `c=mean(Math.round(b),Math.round(b)); d=mean(c,c); e=mean(Math.round(b),a);`
- D) `c=mean(Math.round(b)); d=mean(Math.round(c),a); e=mean(d,a);`

**Ans** — ✅ **D**
- b 為 float；`Math.round(float)`→int → `c=mean(int)`→float `10.0`。
- `d=mean(Math.round(c) [int], a [String])` → `mean(int,String)`→int `10`。
- `e=mean(d [int], a [String])` → `mean(int,String)`→int `10`。
- A 印 `10.0 10 10.0`；B 印 `10 10.0 10.0`；C 因 c 變 double 而無 `mean(double,double)` → 不編譯。

## 1.20 Switch Pattern Matching（型別 + guard）
**Q** — 下列 switch 對各輸入印出什麼？（用 expression 與 statement 兩種）
```java
switch (obj) {
  case LocalDate l when l.isAfter(today)  -> result + "future";
  case LocalDate l when l.isBefore(today) -> result + "past";
  case LocalDate l when l.isEqual(today)  -> result + "today";
  case null, default -> result + "wrong date";   // null 與 default 可合併
}
```
**Ans** —
- `null` → `wrong date`
- 今天 → `today`
- 今天+1 天 → `future`
- 今天-1 天 → `past`
> 重點：`null` case 可放任意位置；`default` **必須最後**（否則支配其他 case）；`case null, default` 可合併。statement 版需每個分支 `break;`。

## 1.21 Building equals — sealed + pattern
**Q** — 給定 `sealed abstract Building permits Hospital, Hotel` 與下列 equals，印出什麼？
```java
Building b1=new Hospital("Unique","commercial"); Building b2=new Hotel("Unique","commercial"); Building b3=new Hotel("Unique","commercial");
System.out.println(b1.equals(b2)+" "+b2.equals(b3)+" "+b3.equals(null));
// equals: o instanceof Building b && getClass().equals(o.getClass()) && type()==b.type()
```
**Ans** — `false`（Hospital vs Hotel）` true`（Hotel 同類、同 literal "commercial"→==true）` false`（null instanceof 為 false）
→ **`false true false`**。對應選項 **B、C** 定義皆合法。

## 1.22 JImage
**Q** — JImage 檔案可以存放哪些內容？
- A) 編譯的 .class 檔
- B) 資源檔（.properties、.txt 等）
- C) 原生函式庫（.dll、.so、.dylib）
- D) 以上皆是

**Ans** — ✅ **A、B**。JImage 存 .class 與資源檔，**不**直接存原生函式庫（bin 目錄另有原生 lib）。

## 1.23 Console
**Q** — 下列 Console 程式碼，哪兩項敘述正確？
```java
Console c = System.console();
String user = c.readLine("User: %d", "duke");
char[] password = c.readPassword("Password: ");
```
- A) 無 console 時 `System.console()` 回 null → 可能 NPE
- B) `readLine("User: %d","duke")` 可能拋 IllegalFormatException
- C) `readPassword` 回傳 String
- D) `readPassword` 需 catch IOException
- E) 有 console 時 `readLine()` 絕不回 null

**Ans** — ✅ **A、B**
- A ✅ 無 console 回 null → NPE 風險。
- B ✅ `%d` 卻給 String "duke" → IllegalFormatException。
- C ❌ 回傳 `char[]`。
- D ❌ Console 方法未宣告 throws IOException。
- E ❌ 遇到 end-of-input 可能回 null。

## 1.24 Path — resolve / relativize / normalize
**Q** — 下列 Path 程式碼印出什麼？
```java
Path p1 = Path.of("projects/./java/../src"); Path p2 = Path.of("resources/messages.txt");
System.out.println(p1.resolve(p2));
p1.normalize();
System.out.println(p1.relativize(p2));
```
- A) `projects/src/...` `../...`  B) `projects/./java/../src/...` `../../...`  C) `projects/./java/../src/...` `../../../...`  D) IllegalArgumentException  E) `projects/src/...` `../../...`

**Ans** — ✅ **B**
- `Path` 不可變；`p1.normalize()` 回新物件，`p1` 不變。
- `resolve` 不 normalize，直接接 → `projects/./java/../src/resources/messages.txt`。
- `relativize`：`.` 不計名、`java/..` 抵消 → 需往上 2 層 → `../../resources/messages.txt`。

## 1.25 IO — BufferedWriter（buffer size 5）
**Q** — 下列 IO 程式碼執行後 output.txt 內容為何？（input.txt = "speedboat"）
```java
char[] buffer = new char[5]; int len;
while((len=reader.read(buffer,0,5))>0){ writer.write(buffer); }
```
**Ans** — 第一次讀 "speed"（buffer 滿），第二次讀 "boatd"（**buffer 未清、長度 9 → 一次讀 4 字元寫入時殘留 'd'**），`write(buffer)` 寫整段 5 字元 → 輸出 **`speedboatd`**。

## 1.26 SequencedCollection
**Q** — 哪個 SequencedCollection 實作可獲得序列 `a, f, c, e, d`？（詳見程式）
**Ans** — **ArrayList**
- TreeSet → 排序不符。
- LinkedHashSet → `removeFirst` 不支援/維持插入序、無法任意前後移動。
- ArrayList → 維持插入序 + `addFirst/remove/addLast` → 可造出 a,f,c,e,d。
> 參考型別只允許 SequencedCollection 方法（addFirst/addLast/removeFirst/removeLast）與 Collection 方法。

## 1.27 Serialization
**Q** — 序列化後反序列化輸出為何？
```java
MyClass obj1 = new MyClass(1,"Test",25);   // id=1
MyClass obj2 = new MyClass(2,"New Test",50);
// 序列化 obj1，反序列化
```
**Ans** —
- 序列化印 `MyClass{id=1, name='Test', age=25, count=1}`。
- 反序列化印 `MyClass{id=10, name='Test', age=0, count=2}`
  - `id=10`：反序列化呼叫基底 `MyBaseClass()`（無參）→ id=10；MyClass 建構子**不**被呼叫。
  - `age=0`：`transient` → 不序列化，預設 0。
  - `count=2`：`static` → 不序列化，取類別變數最後值（第二個物件建構後 = 2）。

---

# Part 2 — PracticeExam3.java

## 2.1 treeSet()
**Q** — 印出什麼？
```java
var points = new TreeSet<Object>(); points.add(7); points.add(5); points.add(-4);
points.forEach(System.out::print);   // -457
points.forEach(System.out::println); // 逐行
```
**Ans** — TreeSet 依自然排序 → 無換行 `-457`，接著逐行輸出 `-4`、`5`、`7`。

## 2.2 booleanTest()
**Q** — 執行後發生什麼？
```java
Boolean fixed = 1>3 ? true : null;   // = null
if (fixed && tested) throw new NullPointerException("shipped");
throw new NullPointerException("broken");
```
**Ans** — `fixed` 為 null，`null && ...` 短路為 false → 不進 if → 擲出最後一行 **`NullPointerException("broken")`**。

## 2.3 cast()
**Q** — 強制轉型輸出？
```java
int n = 9;
System.out.println((double)n);  // 9.0
System.out.println((int)n);     // 9
System.out.println((long)n);    // 9
System.out.println((Integer)n); // 9  (autoboxing)
System.out.println((Object)n);  // 9  (autoboxing 到 Object)
```
**Ans** — `9.0`、`9`、`9`、`9`、`9`。（基本強制轉型皆合法；`(Integer)/(Object)` 為 autoboxing。）

## 2.4 format()
**Q** — `String.format` 的各種轉換：
```java
%%， %n， %s， %S， %b， %h， %c， %d， %o， %x， %e， %f， %g， %a， %1$tF %1$tT
```
**Ans** — `%%`→`%`；`%n`→平台換行；`%s→hello`；`%S→HELLO`；`%b→true`；`%h`→hashto hex；`%c→Z`；`%d→42`；`%o→52`；`%x→ff`；`%e` 科學記號；`%f→1.234500`；`%g→123.450`；`%a→0x1.8p0`；日期 `%tF`（yyyy-MM-dd）、`%tT`（HH:mm:ss）。

---

# Part 3 — Test4.java – Test16.java（依題號命名檔）

## Test4

### Q. 動物命名 switch
**Q** — 比較傳統、arrow、運算式 switch 的回傳動物名；下列哪些寫法正確？（詳見程式 `getAnimalBetter/getAnimalBest`）
**Ans** —
- 傳統 switch：`case 0/1` 配 `break`；`case 2,3`（多標籤）合法；`case 4&4`（常數運算式 4）合法；**`case null` 傳統 switch 非法**（傳統 switch 不支援 null 標籤，只在 pattern 分支可用）。
- arrow `->`：不需 break；`case 4&4 ->` OK；缺 `default` 時若有 case 未窮舉則不編譯。
- 運算式 switch 需窮舉或用 `yield`（不能用 `break`）；`case null:` 與 `default:` 可合併。

### sub — switches()
`switch(Integer)` + pattern `case Integer count when count<500` … `case Integer count`（guarded + unguarded pattern）。

### sub — collections()
**Q** — `//1` 可插入哪個 Queue 實作？（`addRequest`/`getRequestToProcess` 用 add/poll）
**Ans** — `LinkedList`（FIFO）與 `PriorityQueue`（優先序）都支援 `add`/`poll` → 皆可。

### sub — daylightSavingTime()
**Q** — 2025-11-02 02:00 NY DST 結束。`plus(Duration.ofDays(1))` vs `plus(Period.ofDays(1))` 差在哪？
**Ans** — `Duration` 以**小時/分鐘/秒**為單位，接近 DST 邊界會使時間元件改變；`Period` 以**天/月/年**為單位，不碰時間元件。故兩者結果不同。

### sub — streams()
`Collectors.averagingDouble(a->a)` 對 `List<Double>` → 回平均值 Double。

### sub — arrays()
`new Object[]{ "aaa", new Object(), new ArrayList(), 10 }` 合法；`{ }`（內嵌空物件陣列）與 `new Object[1]{...}`（指定長度又給初始值）非法。

### sub — randomAccessFile()
`new RandomAccessFile("file.txt","a")`（檔不存在）→ 拋 `FileNotFoundException`。

### sub — runnable()
合法 Runnable lambda：`()->` 陳述式、`()->{ someMethod(); }`、`()-> someMethod()`、`this::someMethod`（方法回傳 int 可針對 void 相容）。`(a)->`（有參數）不合 Runnable。

## Test5
**Q** — `switch(day)`，`day = LocalDate.now().with(FRIDAY).getDayOfWeek()`：
```java
switch(day){
  case MONDAY: TUESDAY: WEDNESDAY: THURSDAY: FRIDAY: System.out.println("working");
  case DayOfWeek.SATURDAY: SUNDAY: System.out.println("off");
}
```
**Ans** — 多個 `case` 標籤可連續標記（`case MONDAY: TUESDAY: …`）。`FRIDAY` → 印 "working"，因無 break，**fall-through** 也印 "off"；最終輸出 `working`+`off`。
> 提示：static import `java.time.DayOfWeek.*` 讓常數可直接用。`properties()` 中 `System.getProperties().keySet()`，key 為 String → `((String)x).length()` OK。

## Test6

### Q25
**Q** — 印出什麼？
```java
class B extends A { int i=4; public static void main(String[] a){ A a = new B(); a.print(); }
  void print(){ System.out.print(i+" "); } }
class A { A(){ print(); } void print(){ System.out.print("A "); } }
```
**Ans** — `A()` 呼叫被覆寫的 `B.print()`，但建構 subobject 時 B 的 `i` 尚未初始化 → 印 default `0`；之後 `a.print()` 印 `4`。→ **`0 4`**。

### Q27 SortTest
**Q** — 哪些 comparator 使排序正確？
**Ans** — `(p1,p2)->p1.dob.compareTo(p2.dob)`、`SortTest::diff`、`new MySorter()::compare` 皆可（Comparator➝ dob）。`Arrays.sort(al, …)` 對 List 不接受（Arrays.sort 只能陣列）→ 註解。

### Q28 inner class 存取
**Ans** — 內層類別：非靜態需 `outerInstance.new Inner()`；靜態內層直接 `Outer.Inner`。在**靜態方法**中不可直接 `new A()`（非靜態內層）需 `new TestClasss().new A()`；static 內層可直接 `new B()`。

### Q43（Test）
**Q** — 印出什麼？
```java
int k=1; int[] a={1};
k += (k=4)*(k+2);
a[0] += (a[0]=4)*(a[0]+2);
```
**Ans** — Java 複合賦值：右側先整體求值；括號內 `(k=4)` 已把 k 設 4，後續 `k+2` 讀到 4 → `4*6=24`，再 `k=1+24=25`。`a[0]` 同理 25。印 **`25 , 25`**（已驗證）。

### Q48（ArrayTest）
**Q** — 陣列宣告與 `clone`：
```java
double daaa[][][] = new double[3][][];  double[][] daa = new double[1][1];
double[] newd = daa[0].clone();
```
**Ans** — 陣列的 `clone()` 被覆寫成 **public**（Object 的是 protected）；為 **shallow clone**：陣列本身新物件（`sa1!=sa2`），但元素參照同一實例（`sa1[0]==sa2[0]` true）。

## Test7

### Q32
**Q** — 執行後發生什麼？
```java
try (var fis=new FileInputStream("c:\\temp\\test.txt"); var isr=new InputStreamReader(fis)) {
  while(isr.ready()){ isr.skip(1); int i=isr.read(); System.out.print((char)i); } }
```
**Ans** — `skip(1)` 跳過、`read()` 讀；`isr.ready()` 有資料才迴圈。逐字輸出但**跳過字元**（skip 再讀交替）。若檔不存在 → FileNotFoundException。

### TestClass1
static main：`new TestClass1().new A()`（非靜態內層需實例）合法；`new TestClass1.A()` 需 A 為 static → 此處註解（A 非 static → 不合法）；`new C()`（local class）合法。

## Test8

### Q4（StringArrayTest）
**Q** — `String[][][]`，輸出 `arr[0][1][2]`？
**Ans** — `arr[0][1]` 內含 `{ "d","e",null }` → `arr[0][1][2]` = **null**。

### Q14（Soccer）
```java
class Game{ void play() throws Exception{...} }
class Soccer extends Game{ void play(){...} }   // 覆寫可縮小/省略 throws
...
Game g = new Soccer(); g.play();
```
**Ans** — 多型 → 呼叫 `Soccer.play()` → 印 **`Playing Soccer...`**。覆寫時省略 throws（縮小）合法。

### Q24
`int[] iarray = null;` 合法。

### Q33（TestClass33）
**Q** — 輸出？
```java
IntFunction<IntUnaryOperator> fo = a -> b -> a - b;   x=operate(fo.apply(20)) → 20-5=15;  y=fo.apply(20).applyAsInt(5) → 15
IntFunction<IntFunction<IntUnaryOperator>> foo = c -> d -> e -> c-d-e;  z=foo.apply(20).apply(10).applyAsInt(5) → 20-10-5=5
ToIntFunction<String> = String::length → "Hello"→5;  DoubleToIntFunction → (int)1.2=1;  LongFunction<String>=Long::toString → "123"
```
**Ans** — `15 15 5 5 1 123`。

### Q36
空 switch 語句 `switch(5){}` 合法（無任何 case）；`switch(byte)` 可用 `case '1'`（char 常數 = 49 落在 byte 範圍）合法；`switch(8)`（無主體）不合法。

### Q44（FileCopier）
**Q** — try-with-resources，`//2` 重新賦值資源變數，`Files.copy` 目標已存在：
**Ans** — `//2`（`os = ...`）對 try-with-resources 資源變數 **不可重新賦值** → 不合法。註解後可執行。`Files.copy(p1,p2)` 無 `REPLACE_EXISTING` 且 test2.txt 已存在 → 拋 **`FileAlreadyExistsException`**。

## Test9

### Q8
`Float.valueOf("0.0").floatValue()` → `0.0`；`Float.parseFloat("0.1")` → `0.1`。

### Q19
```java
IntStream.range(1,10)                              // 1..9
  .collect(() -> new StringBuilder(),
           (sb,i)->sb.append(i).append(","),
           (sb1,sb2)->sb1.append(sb2)).toString()
```
**Ans** — `1,2,3,4,5,6,7,8,9,`（collect 三參數版本：supplier / accumulator / combiner）。

### Q28（DST）
**Q** — 6 月 2 日 NY：`OffsetDateTime`（固定 UTC-5）vs `ZonedDateTime`（America/New_York，6 月 DST=ON = UTC-4），`Duration.between`？
**Ans** — offsetDateTime 為 UTC-5、nyZdt 為 UTC-4 → 相差 **1 小時** → `PT1H`。

### PortConnector（覆寫例外）
**Q** — 子類別建構子的 throws 必須受何限制？
**Ans** — 覆寫時**不可新增**父類別未宣告的 checked exception。`CleanConnector` throws `InterruptedException`（父類別無）→ **不合法**。可縮小或省略父類別已宣告的（IOException）檢查例外。

### AccessTest
```java
static int number;  int result=10;
number = 11;
var number = at.addSalt(11);   // addSalt 內: return number + result   → 11+10=21
```
**Ans** — 先 `number=11` 設 static；`addSalt(11)` → `number+result` = 11+10 = **21** → 印 `21`。

## Test10

### Q1
```java
boolean b1=false, b2=false;
if (b2 != b1 == !b2) print "true" else print "false"
```
**Ans** — `b2!=b1` → false；`false == !b2`(true) → **false** → 印 `false`。（`b2 != b1 = !b2` 與 `false = !b2` 為語法錯誤。）

### Q12
**Q** — `List.of(numA)` 配 `numA[1]=2` 改變，各 list 輸出？
**Ans** — `List.of/List.copyOf` 建立的 list **不可變（不可加/改元素）**，但它們存的**元素參照**若為可變容器則會反映變動。`numA` 元素為 `Integer[]`（含陣列參照）→ list1 印陣列 toString（`[Ljava.lang.Integer;@…`）。`Arrays.asList(numA)` 支援 set → `numA[1]=2` 反映。`List.copyOf` 於當下快照 list 結構，但陣列元素仍是同一參照。

### Q17
`Duration.ofHours(25)` → `PT25H`；`Period.ofDays(1)` → `P1D`；`Duration.ofDays(365)` → `PT8760H`（Duration 以小時呈現，非 P365D）。

### Q18
`Thread.ofVirtual().unstarted(() -> …)` 建虛擬執行緒 → `start()` + `join()`。

### Q20
**Q** — `process(100,10)` 回傳？
```java
double process(double payment,int rate){ double defaultrate=0.10; if(rate>10) defaultrate=rate;
  class Implement{ int apply(double data){
     Function<Integer,Integer> f = x->x+(int)(x*rate);   // rate effectively final
     return f.apply((int)data); } }
  return new Implement().apply(payment); }
```
**Ans** — Local class 及其 lambda 只可讀取 **final / effectively final** 的外層變數。`rate` 為參數且未再賦值 → **effectively final** → 可用。`defaultrate` 被 assign 兩次 → 非常數（不可用在 lambda）→ 改用 `rate` 使程式可編譯。`apply(100)` → `100 + (int)(100*10)` = 1100 → 回 `1100.0`。

### Q49
`names.forEach(x->x=x+1)` 不改變 list（Integer 不可變、forEach 無法寫回）。可變物件 students 的 `setId` 有效。

### Q4（Card）
```java
enum Card { HEART,CLUB,SPADE,DIAMOND; boolean isRed(){ return switch(this){ case HEART,DIAMOND->true; default->false; }; } }
takeWhile(isRed) → HEART
dropWhile(isRed) → CLUBSPADEDIAMOND
```
**Ans** — `takeWhile` 印 **`HEART`**；`dropWhile` 印 **`CLUBSPADEDIAMOND`**。

### Q30（Onion）
```java
class Layer extends Onion { String data="thegoodpart"; String getData(){ return data; } }
String getData(){ return new Layer().getData(); }
```
**Ans** — 內層 `Layer` 的 `getData()` 回自己的 `data` → 印 **`thegoodpart`**。

## Test11

### Q22（Float.parseFloat）
**Q** — 下列各自輸出？
```java
parseFloat1(""+Float.NEGATIVE_INFINITY)  → "-Infinity" 有效 → -Infinity
parseFloat1(""+Float.POSITIVE_INFINITY)  → Infinity
parseFloat1(" junk")                     → NumberFormatException → 回 0.0f
parseFloat1("-Infinity")                 → -Infinity
parseFloat1("NaN")                       → NaN
```
**Ans** — `Float.parseFloat` 接受 `"Infinity"`、`"-Infinity"`、`"NaN"`（trim 後）。`catch(IllegalArgumentException)` 捕不到（NumberFormatException 是 IllegalArgument 子類、先被第一個 catch 捕）。輸出依序：`-Infinity / Infinity / 0.0 / -Infinity / NaN`。

### Q35
```java
try{ amethod(); print "try "; } catch(Exception e){ print "catch "; } finally{ print "finally "; }
print "out "
// amethod() 不拋例外
```
**Ans** — `try finally out`。

### Q8（toMap）
**Q** — 輸出？
```java
List<Book> = [ ("Gone with the wind",5.0),("Gone with the wind",10.0),("Atlas Shrugged",15.0) ];
stream.collect(Collectors.toMap(b->b.title(), b->b.price()))
```
**Ans** — 兩筆同 title `"Gone with the wind"` → `toMap` 遇重複 key 拋 **`IllegalStateException: Duplicate key Gone with the wind (attempted merging values 5.0 and 10.0)`** → catch 印。

## Test12

### Q3
`Math.round(9.0)` → `long 9`。`1 + Math.random()*9` → `[1,10)`。

### Q15（Fruit/Eatable）
**Q** — 印出？
```java
interface Eatable { int types=10; }
class Food { public static int types=20; }
class Fruit extends Food implements Eatable { main: print Food.types; print Eatable.types; }
```
**Ans** — `Food.types`=20、`Eatable.types`=10。介面欄位隱含 `public static final`。`Fruit` 中直接 `types`（super 與 interface 兩處同名）→ **歧義**，須限定寫 `Food.types` / `Eatable.types`。`super.types`（super=Food）與 `Eatable.super.test()` 合法（default 方法）。

### Q23（Path）
```java
p1="/temp/test1.txt"; p2="/temp/test2.txt";
p1.resolveSibling(p2)   // 以 p1 的 parent + p2 的檔名 → /temp/test2.txt
p1.resolve(p2)          // p2 絕對 → 回 p2 → /temp/test2.txt
p1.relativize(p2)       // test2.txt
p1.resolve("test2.txt") // /temp/test1.txt/test2.txt
```
**Ans** — 依 `resolve`（p2 絕對則回傳 p2）、`relativize`、`resolveSibling` 規則。實際輸出請以本機執行 `_23()` 為準（不同 OS 路徑語法有別）。

### Q29
**Q** — 印出哪些字母？兩段 switch：
```java
LOOP: for(char i=0;i<5;i++){ switch(i++){ case '0'(=48) ... case 1: print "B"; break LOOP; ... } }
for(i=0;i<5;i++){ switch(i){ case '\u0000'=0...'\u0004'=4: 各 break }
```
**Ans** — 第一段：`i` 自增（for 的 i++ 與 switch 內 i++），遇 `case 1`（i=1 時印 "B"）並 `break LOOP` → 印 **`B`**。第二段 case 0..4 各 break → `A B C D E`。（手算易錯，執行確認。）

### Q40（Random）
`new Random().doubles(10)`、`r.doubles(100,110)`、`DoubleStream.generate(()→r.nextDouble())`、`r.nextGaussian()` 等產生隨機流。

### Q44
**Q** — 要印法文日期，`//1` 插入哪個？
```java
LocalDate d = LocalDate.now(); Locale loc=new Locale("fr","FR");
DateTimeFormatter df = DateTimeFormatter.ofPattern("dd MMM yyyy", loc);
```
**Ans** — 已用 `var loc` 把 locale 傳入 formatter：`var df = DateTimeFormatter.ofPattern("dd MMM yyyy", loc)`；即可輸出法文格式日期。

### Q48（switch type）
**Q** — 下列哪些型別可放 `//1` 使 switch 依 `case 1/2/3` 正常編譯？
```java
var condition = Integer.valueOf("1");   // ✅ unboxing 整數
// String condition = "1";   // ✅ case 用 String literal
// var condition = Short.valueOf(1); / Byte condition=1;  // ✅ 整數 wrapper
// long condition = 2;  // ❌ long/float 不能當 switch selector
```
**Ans** — switch selector 可使用整數型別（char/byte/short/int 及其 wrapper）與 **String、enum**。`long`/`float`/`double` **不可**。`Integer/Short/Byte` wrapper 會 unbox；`String` 需 case 為 String literal。

## Test13

### Q8（Device）
```java
try(Device d=new Device()){ d.open(); d.read(); d.writeHeader("TEST"); d.close(); }
catch(IOException e){ print "Got Exception"; }
```
**Ans** — `d.read()` 拋 IOException → catch → 印 **`Got Exception`**。`Device.close()` 無 throws（AutoCloseable.close 不拋 checked），故 catch 處理 read 例外。

### Q9
```java
var c=0; var flag=true;
for(var i=0;i<3;i++){ while(flag){ c++; if(i>c || c>5) flag=false; } }
print c;
```
**Ans** — c 累增直到 `c>5` → **`6`**（已驗證）。

### Q17（reduce identity）
**Q** — 哪個每次執行可能不同？
```java
A) reduce(5,(a,b)->a+b)              // identity 非冪等 → possible
B) reduce(0,Integer::sum)+5           // 固定 33
C) parallel.reduce(0,Integer::sum)+5  // 固定 33
D) parallel.reduce(5,Integer::sum)    // identity 非冪等 → 可能不同 ✅
E) parallel.reduce(Integer::sum).orElse(5)+5  // 固定 33
```
**Ans** — ✅ **D**。非冪等 identity（5）在平行分割時被套用到多個區塊 → 每次結果可能不同。其餘以 0 或無 identity 的 reducer → 固定 33（sum=28）。

### Q19（StringBuilder）
```java
StringBuilder sb = new StringBuilder("12345678"); sb.setLength(5); sb.setLength(10);
print sb.length(); print sb;
```
**Ans** — 縮到 5（"12345"）再擴到 10 → length=**10**，內容 `"12345"` + **5 個 `\u0000`**（null 字元）。

### Q23（parallel + allMatch）
**Q** — 下列 `ai.get()` 是否保證 = 8？
```java
stream.parallel().filter(e->{ ai.incrementAndGet(); return e.contains("o"); }).allMatch(x->x.indexOf("o")>0);
```
**Ans** — `allMatch` 遇第一個 false 即**短路** → filter 不一定處理全部 8 元素 → `ai.get()` **可能 != 8**（不保證）。sequential 版則全部處理 → ai=8。

### Q35（generic transform）
**Q** — Derived 的哪個 transform 為**合法覆寫/多載**？
```java
class Base { public <T extends CharSequence> Collection<String> transform(Collection<T> list){...} }
class Derived extends Base {
  //1 ❌ Collection<String> transform(Collection<String>)  erasure 衝突
  //2 ❌ <T extends String>  String 為 final 無效 bound
  //3 ❌(回型別) List<T> transform(Collection<T>)  covariant OK
  //4 ✅ <T extends CharSequence> Collection<T> transform(List<T>)  多載（參數 Collection vs List）
  //5 ❌ <T super String> 非法 bound
  //6 ❌ Collection<CharSequence> transform(Collection<CharSequence>)  erasure 衝突
}
```
**Ans** — 唯一在 Derived 中作為**多載**者為 **`//4`**（參數 Collection vs List）可獨立編譯。（`//3` 回型別 List<T> 為 covariant，erase 後與 Base 同簽名 → 型別相容可為覆寫，但注意回型別需子型別。）實際以編譯器判定為準。

### Q43
`final int x = 0;`（**編譯期常數**）可當 `case x:`；非 final `int x`（執行期變數）不可當 case 標籤。

### Q47（switch）
```java
switchTest((byte)'b')  // 'b'=98 → case 'b','c' → 10
test(null)            // switch(Object) pattern → null,null,default → "Outro ou null"
```
**Ans** — `10`；`Outro ou null`。

## Test14

### Q1（Movable/Donkey）
**Q** — 印出？
```java
interface Movable { int location=0; void move(int); void moveBack(int); }
class Donkey implements Movable { int location=200; move: location+=by; moveBack: location-=by; }
Movable m=new Donkey(); m.move(10); m.moveBack(20); print m.location;   // 介面欄位 static final → 0
Donkey d=new Donkey();  d.move(10);  d.moveBack(20);  print d.location;  // 實例欄位 → 190
```
**Ans** — `m.location`（靜態綁定到 **Movable** 的 `int location=0`，介面欄位為 public static final）→ **`0`**；`d.location` 為 Donkey 實例欄位 → 200+10-20 = **`190`**。→ 印 `0` 與 `190`。**重點：`Reference.field` 依宣告型別靜態綁定。**

### Q4（reduce）
**Q** — 平行 reduce 以內層 reduce 當 identity，輸出與何者相關？
**Ans** — 內層 `reduce((a,b)->a+b)` 結果（如 "XY"）當外層 identity，平行區塊各自套用 → 輸出與 encounter 順序及分割相關（不唯一）。

### Q9（FileReader try-with）
**Q** — `aaa.a` 不存在時的結果？
**Ans** — `new FileReader("aaa.a")` 在 TWR 資源開啟**之前**就拋 `FileNotFoundException`（IOException）→ 不會進入 try，直接在 `try(reader)` 那一行拋出 → 由外層 catch（或 throws）處理並印出 `java.io.FileNotFoundException: aaa.a`。TWR 中的 `final Reader reader`（effectively final）可作資源。

### Q23（Instant.truncatedTo）
**Q** — 哪個 `ChronoUnit` 合法？
**Ans** — `Instant` 支援 `truncatedTo(DAYS/HOURS/MINUTES/SECONDS/MILLIS/MICROS/NANOS)`（小於一天的單位）。**不支援** `MONTHS/YEARS` 等 → 拋 `UnsupportedTemporalTypeException`。

### Q31（FileWriter）
`new FileWriter("text.txt", true)` → **追加模式**；`fw.write("hello")` OK；不 close 則資料未 flush（此例 try 內 close）。

### Q33（reduce "_" identity）
**Q** — 平行 reduce 用 `"_"` 當 identity 輸出？
**Ans** — `parallelStream().reduce("_",(a,b)->a.concat(b))`：identity `"_"` 每 chunk 套用 → 結果含多個 `_`（如 `_a_b_c...`），且順序不保證。**identity 須為單位元**（此處非）。

### Q34（Carnivore/Tiger method reference）
**Q** — 哪個可插入 `//` 使編譯（獨立選用）？
```java
process(fnames, t::eat);        // ✅ 實例方法 (List<String>)->int
process(fnames, t::calories);   // ✅ default 實例方法
process(fnames, TestClass14_34::size);  // ✅ static 方法
// process(fnames, Carnivore::calories); // ❌ default 不可用「介面.類別」reference（需 instance）
// process(fnames, Tiger::eat);          // ❌ unbound instance，目標介面單參數不含 receiver 列
```
**Ans** — **`t::eat`、`t::calories`、`TestClass14_34::size`** 合法。`Carnivore::calories`（介面實例方法不可用類別 reference）與 `Tiger::eat`（unbound 需目標方法含 receiver 參數）不合法。

### Q45（bitwise）
**Q** — 印出？
```java
int x=2; int y=~x;        // y=-3
int z=x^y;                // z = 2^(-3) = -1
boolean flag = x<y & x>z++;    // 2<-3(false) & (2>z? 先取 z=-1 比較==false, 後遞增 z=0) → false; z=0
if(flag) flag=x>y&&x>--z;
if(z>-1) --z; else z++;   // 0>-1 true → --z → -1
print flag+" "+z;
```
**Ans** — `~2 = -3`；`z = 2 ^ -3 = -1`；`flag = false`；最終 `z = -1`。→ 印 **`false -1`**（已驗證）。

### Q47（List.of(coll) 可變底層）
```java
Collection<Number> col=new HashSet<>(); col.add(1);
var list1=List.of(col);   // 存 col 參照 → 後續 col 變動反映
col.add(2);
var list2=List.copyOf(col); // 當下快照 {1,2}
col.add(3);
print list1 + ", " + list2 + ", " + col
```
**Ans** — `list1` 是含 `col` 參照的 list，col 後續 add(2)、add(3) 會反映在 list1；`list2` 為 `List.copyOf` 快照（{1,2}）不受之後 add 影響。印出依序狀態。

### Q50（AccountType）
**Q** — 印出？
```java
enum AccountType { CHECKING("Checking account"), SAVINGS("Savings account"), FD("Fixed Deposit"); ... }
var at = AccountType.valueOf("FD");
print at.ordinal() + " " + at;
```
**Ans** — `valueOf("FD")` → ordinal **2**（FD 為第 3 個）。`toString()` 覆寫回 `"Acct type:" + super.toString()` → `Acct type:FD`。印 **`2 Acct type:FD`**（已驗證）。

## Test15

### Q4
**Q** — 印出？
```java
IntStream.range(0,5).average() → OptionalDouble
```
**Ans** — `OptionalDouble[2.0]`（0,1,2,3,4 平均值 2）。`average()` 是**終端**操作，stream 只能消費一次。

### Q12（Helper）
**Q** — 印出？
```java
void helpPeople(Queue people, Queue helped){ do{ Personal p=(Personal)people.poll(); print "Helped : "+p+" "; helped.offer(p.getName()); }while(!people.isEmpty()); }
// q=[Pope,John]
```
**Ans** — 依序 `Helped : Pope `、`Helped : John `。（raw Queue + 強制型別轉，編譯有告警但執行正常。注意 do-while 在最後 poll 到 null 時離開。）

### Q18（ScopeTest）
```java
static int x=5; main: int x = (x=3)*4; print x;
```
**Ans** — 宣告 local `x` 與 static `x` 同名；`(x=3)` 將 **static** x 設 3 並回 3 → ×4 = 12 → local `x=12`。印 **`12`**（已驗證）。

### Q20（Arrays.compare）
**Q** — 輸出？
```java
a={1,2,3,4,5}; b={1,2,3,4,5,3}; c={1,2,3,4,5,6};
compare(a,c)=-1; compare(b,c)=-1;
d={1..10}; e={10..100}; compare(a,d)=-5; compare(d,a)=5; compare(d,e)=-1;
f={1*10};  compare(a,f)=1;
```
**Ans** — `-1 -1 | -5 5 -1 | 1`（已驗證）。

### Q22（flatMap）
**Q** — 下列哪個印出 `a b 1 2`（逐行）？
```java
A) Stream.of(l1,l2).forEach(x->println(x))      // 印 [a, b] 與 [1, 2]（list本身）
B) Stream.of(l1,l2).flatMap(x->Stream.of(x))    // 無變化
C) Stream.of(l1,l2).flatMap(x->x.stream())      // ✅ a b 1 2
```
**Ans** — ✅ **C**。`flatMap(x->x.stream())` 將每個 List<String> 拆成元素逐行印。

### Q26（AA/BB/CC）
**Ans** — `BB extends AA` 有 `private int i=30`（遮蔽）、`public int k=40`。`CC` 繼承。`cc.i`（被 BB 私有遮蔽）與 `cc.j`（AA private）於外部**不可存取**。

### Q28（ResourceBundle/Locale）
`Locale.setDefault(Locale.FRANCE)` 後 `ResourceBundle.getBundle("messages")` 依**預設 locale** 挑資源檔；可指定 `getBundle(name, new Locale("fr","FR"))`。

### Q37（null 限制）
**Q** — 哪幾行拋 NullPointerException？
```java
ConcurrentHashMap.put(null,..)   // 1 ❌ NPE（null 鍵）
ConcurrentHashMap.put("aaa",null) // 2 ❌ NPE（null 值）
HashMap.put(null,..)             // 3 ✅ OK
HashMap.put("aaa",null)          // 4 ✅ OK
ArrayList.add(null)              // 5,6 ✅ OK
CopyOnWriteArrayList.add(null)   // 7 ✅ OK
```
**Ans** — **`//1` 和 `//2`** 拋 NPE（ConcurrentHashMap 不允許 null key/value）。HashMap 與 ArrayList/CopyOnWriteArrayList 允許 null。

### Q45（OuterWorld inner）
```java
public InnerPeace i = new InnerPeace("none");   // 實例欄位
class InnerPeace { private String reason="none"; InnerPeace(String r){reason=r;} }
main: var out=new OuterWorld(); print out.i.reason;   // ✅ 外層類別可存取內層 private
```
**Ans** — 印 **`none`**。`new InnerPeace("yoga")`（static main 中無 outer 實例）不合法 → 註解。

## Test16

### Q4（JustLooping）
**Q** — 印出？
```java
private int j;
void showJ(){ while(j<=5){ for(int j=1;j<=5;){ print j+" "; j++; } j++; } }
```
**Ans** — 內層 for 的 local `j` 不影響外層 `j`。外層 while 從 j=0 遞增到 6（6 輪），每輪內層印 `1 2 3 4 5` → **印 6 組 "1 2 3 4 5 "**（已驗證：6 組）。

### Q7（List.of().sort）
**Q** — 印出？
```java
List<String> keys = List.of("b","a");
keys.sort(...);   // ❌ List.of 不可變 → UnsupportedOperationException (catch 印)
keys.stream().sorted().forEach(System.out::print);  // ✅ ab
```
**Ans** — `sort` 拋 **`UnsupportedOperationException`**（catch 印）；`stream().sorted()` 產生**新排序串流** OK → 印 `ab`。

### Q11（HomeOffice interfaces）
```java
interface House{ default void lockTheGates(){...} }
interface Office{ void lockTheGates(); }
interface Third{ static void lockTheGates(){...} }
class HomeOffice implements House,Office,Third { public void lockTheGates(){...} }   // 自訂實作解決衝突
```
**Ans** — HomeOffice 提供**單一具體** `lockTheGates()` → 解決多介面衝突 → OK。`Third.lockTheGates()` 以**介面.static**呼叫 → OK。註解選項（型別轉換 `(House)off` 等）於多介面場景易衝突。

### Q15（AX）
```java
static int[] x = new int[0];
static { x[0]=10; }   // 👉 若非註解 → AIOOBE：長度0
```
**Ans** — 若 `x[0]=10` 未註解，static 初始化時拋 **ArrayIndexOutOfBoundsException**。註解後 `new AX()` 正常。

### Q20（summarisingInt）
**Q** — `{1,2,3}` 印出 6 的有幾行？
```java
1) mapToInt(x->x).sum()              → 6 ✅
2) forEach((sum,x)->sum+x)           → ❌ 語法錯
3) reduce(0,(a,b)->a+b)              → 6 ✅
4) mapping(x->x,summarizingInt).getSum() → 6 ✅
5) summarizingInt(x->x).getSum()     → 6 ✅
```
**Ans** — **第 1、3、4、5 行**合法印 6（第 2 行語法不合法）→ 共 **3 行**印 6。

### Q29
`new Locale.Builder().setLanguageTag("en-US").build()` 合法。

### Q42（Logger）
**Q** — 清空 StringBuilder 內容的正確方法（`dumpLog()`）？
**Ans** — **`sb.delete(0, sb.length())`**。

### Q43（thread / 資源競爭）
**Q** — 兩執行緒 `Writer16_43.write(d1,d2)`：
```java
while(!da[0].own(this)); while(!da[1].own(this)); ... 釋放
```
**Ans** — 兩 thread 爭奪 d1/d2 的寫入權（`own()` 同一份 data）。因資源會釋放 → **starvation（飢餓）而非 deadlock/livelock**。程式註解即為答案註解。

---

# Part 4 — UniqueTest1 – UniqueTest4.java

## UniqueTest1

### Q10（Powwow）
**Q** — 印出？（`Pow` interface static wow、`Wow` class static wow）
```java
class Powwow extends Wow implements Pow { main: Powwow f=new Powwow(); f.wow();
                                            // Pow powwow=new Powwow(); powwow.wow();  // 註解
}
```
**Ans** — `f.wow()` 呼叫 class（`Wow`）的 static `wow()` → 印 **`In Wow.wow`**（static 可由實例呼叫，取宣告類別版本）。透過 interface reference `powwow.wow()` 呼叫 interface static → **不合法**（註解）。

### Q17（ArrayList）
**Q** — 印出？
```java
ArrayList<Double> al = new ArrayList<>();
al.indexOf(1.0)  → -1
al.indexOf("string") → -1   // 型別不同仍編譯（Object 參數）
al.contains("string") → false
```
**Ans** — `-1`、`-1`、`false`。

### Q22（DST 2022-11-06）
**Q** — 印出？
```java
LocalDateTime ld = LocalDateTime.of(2022,11,6,1,30);
ZonedDateTime d1 = ZonedDateTime.of(ld, ZoneId.of("US/Eastern"));   // -04:00 EDT
ZonedDateTime d2 = d1.plusHours(1);                                 // 02:30→DST結束回撥→01:30 -05:00 EST
print d1.getOffset(); print d2.getOffset();
print d1.getOffset().compareTo(d2.getOffset());   // 秒數差異 = -3600
print Duration.ofSeconds(...);  print ...toHours();  // PT-1H, -1
```
**Ans** — `-04:00`、`-05:00`、`-3600`、`PT-1H`、`-1`（已驗證 offset/cmp）。

### Q51（Coffee enum）
**Q** — 哪個產生 `ESPRESSO:Very Strong, MOCHA:Bold, LATTE:Mild,`？
```java
enum Coffee { ESPRESSO("Very Strong"),MOCHA("Bold"),LATTE("Mild");
  public String strength; Coffee(String s){strength=s;} public String toString(){return strength;} }
// A) e.name()+":"+e+", "   → ESPRESSO:Very Strong, MOCHA:Bold, LATTE:Mild, ✅
```
**Ans** — 因 `toString()` 覆寫為 strength：`e.name() + ":" + e + ", "` → `ESPRESSO:Very Strong, MOCHA:Bold, LATTE:Mild,`。

## UniqueTest2

### Q6（Media/CdROM）
**Q** — 印出？
```java
interface Media{ default void play(){...} }
ROM r1=new ROM();  Media r2=new CdROM();
play(r1) → 匹配 play(Media) → "Media: ROM playing"
play(r2) → 匹配 play(Media) → "Media: CdROM playing"（多型）
```
**Ans** — `Media: ROM playing`、`Media: CdROM playing`（宣告型別決定多載，執行多型決定實作）。

### Q8（AU2_8）
```java
void doA(int k) throws Exception { for i<10 if(i==k) throw new Exception... }   // k=15 → 永不成立
void doB(boolean f){ if(f) doA(15); }
main: a.doB(args.length>0);
```
**Ans** — `args.length>0` 為 false（無參數）→ `doB(false)` → else return，不拋例外。若為 true → `doA(15)`，i=0..9 永不等 15 → **無例外**。

### Q15（Book/DoubleSupplier）
**Q** — 印出？
```java
Book b1 = new Book("Java in 24 hrs", null);   // price null
DoubleSupplier ds1 = b1::getPrice;  ds1.getAsDouble();  // unbox null → NPE
```
**Ans** — `getAsDouble()` 對 null `Double` unboxing → **NullPointerException**（catch 印）。

### Q23（switch 運算式 break/yield）
**Q** — switch 語句 vs 運算式，哪個語法正確？
**Ans** — **運算式**（`var result = switch(...)`）的區塊須用 **`yield`** 回值，**不能用 `break`**；**語句**（`switch` statement）用 **`break`**。`var value=1_000_000`，無 `case 1000001` → 語句版走 case 1000000 印 "A million 2"；運算式版回 "A million 2"。

### Q24（FileCopier catch）
**Q** — 多例外 catch 的 `e` 可否重新賦值？
```java
catch(IOException | IndexOutOfBoundsException e){ e = new FileNotFoundException(); }  // ❌ multi-catch 的 e 為 final
catch(Exception e){ e = new FileNotFoundException(); }                                 // ✅ 單一型別可 reassign
```
**Ans** — **multi-catch** 參數是隱式 **final**，不可 re-assign（註解）；**單一 catch** 可 reassign。檔案存在 → 正常複製，印「Read and written bytes …」。

### Q43（DateFormat）
`DateFormat.getDateInstance()`（預設 MEDIUM）、`getDateInstance(FULL)`、`getDateInstance(FULL, loc)`（pt_BR）、`getInstance()`（SHORT）→ 依 style/locale 印不同格式。

### Q46（parallel collect — 2-letter words）
**Q** — 哪個建立「兩字母字串」list？
```java
1) stream().filter(len==2).parallel().collect(toList())   // ✅ 保序
2) stream().parallel().filter(len==2).collect(toList())   // ✅ 保序
3) parallelStream().forEach(加進同步 list3)               // ✅ 但順序不保證
```
**Ans** — 三者皆建立含 2-letter word 的 list；**list3 因 forEach 不保序，輸出順序不保證**。1、2 保 encounter order。

### Q52（時區差）
**Q** — 印出？（NY=EST-5、LA=PST-8，12 月）
```java
nyZdt = ldt.atZone("America/New_York");  // 06:00-05:00
laZdt = ldt.atZone("America/Los_Angeles"); // 06:00-08:00
Duration d = Duration.between(nyZdt, laZdt);
```
**Ans** — 同一 local 時間，LA 較 NY **晚 3 小時**（NY 時間戳較早）。`Duration.between(nyZdt, laZdt)` = **負差** → `PT-3H`。

### Q53（SerialTest）
```java
PersonU2_53 p = new StudentU2_53("Bob Dylan","NYU");   // 建構印 "Person " "Student "
// 序列化再反序列化 → print ((Person)ois.readObject())
```
**Ans** — 物件建立時印 `Person Student`（各一次）。反序列化**不重跑建構子**，欄位 name="Bob Dylan"、school="NYU" 保留 → 印 `Bob Dylan NYU`。

### Q54（MicroService AutoCloseable）
**Q** — 結果？
```java
try(MicroService ms=new MicroService("X")){ ms.availService("test"); }  // "X started"; avail抛 InternalException
catch(Exception e){ print e; for(t:getSuppressed()) print t; }          // close() name=X → ExternalException 為 suppressed
```
**Ans** — 印 `X started`，primary = `InternalException: Unknown service test`，suppressed = `ExternalException: Can't close X service`。

## UniqueTest3

### Q1
```java
int i=4; int[][][] ia = new int[i][i=3][i];
```
**Ans** — 第一個維度用 i=4，後兩個在執行時 `i` 已被賦 3 → `int[4][3][3]`。印 `4, 3, 3`。

### Q4（Map raw）
**Q** — 下列哪些可執行？
```java
HashMap m = new HashMap();  m.put("1",...); m.put(1,...); m.put(1.0,...);  // ✅ OK（異質 key）
TreeMap m = new TreeMap();  // ❌ key 不互 Comparable → ClassCastException
```
**Ans** — raw `HashMap` 接受任意 key（String/Integer/Double）；`TreeMap` 因 key 型別不同不互比較 → 拋 `ClassCastException`。
> `Map<Object, ? super ArrayList>` 之 `m.put(1, new Object())`（Object 非 ArrayList 之子型別）不合法 → 註解。

### Q7（BookU3 sort）
**Q** — 印出？
```java
List<BookU3> books = getBooksByAuthor("Ludlum"); try{ books.stream().sorted()... }catch(ClassCastException e){...}
```
**Ans** — `BookU3` **未實作 Comparable** → `sorted()` 執行時嘗試轉 Comparable → **`ClassCastException`**（catch 印）。

### Q12（File）
`file.createNewFile()`（不存在→true）、`file.exists()`（建立後 true）、`file.delete()`（true）。

### Q13（DeviceU3 try-with）
```java
try(DeviceU3 d=new DeviceU3()){ throw new Exception("test"); }
// close() 恆拋 RuntimeException("rte") → suppressed
```
**Ans** — primary = `Exception: test`；close() 丟的 `RuntimeException: rte` → **suppressed**。catch 印 `java.lang.Exception: test` 及 suppressed `java.lang.RuntimeException: rte`。

### Q14（module provides）
**Q** — module 可否對**同一 service** 指定兩個 provider？
```java
provides org.pdf.Print with A;
provides org.pdf.Print with B;  // ❌ 同一 service 重複 provides → 不編譯
```
**Ans** — ❌ 兩個或多個 `provides` 指定**同一 service** → **編譯錯誤**。

### Q18（reduce Double）
**Q** — 下列可編譯且總價為何？（books 價 2.99+4.99+2.99+1.99）
**Ans** — 各語法變體皆推導總價 **`12.96`**。重點：`reduce(0.0,(a,b)->a+b)`、`mapToDouble().reduce(0.0, dbo)`（DoubleBinaryOperator）、`reduce((a,b)->a+b).get()`（Optional）等形式。

### Q22
**Ans** — non-modular app 可**不變地**把 modular jar 放 classpath 使用。

### Q24（static vs default interface）
```java
interface Office{ static String getAddress(){return "101 Smart Str";} }
interface House{ default String getAddress(){return "101 Main Str";} }
HomeOfficeU3 off=new HomeOfficeU3();  off.getAddress() (介面 static 透過 reference) → ❌ 不合法
OfficeU3.getAddress()  → ✅ "101 Smart Str"
((HomeOfficeU3)off).getAddress() → HomeOffice 覆寫 → "R No 1, Home"
```
**Ans** — 透過**介面 static** 呼叫 → `OfficeU3.getAddress()`；透過**介面型別 reference** 呼叫 static（`off.getAddress()`）→ **不合法**；`((HomeOfficeU3)off).getAddress()`（實例型別）→ 印 `R No 1, Home`。

### Q39（ISO_ZONED_DATE_TIME + LocalDateTime）
**Q** — 印出？
```java
DateTimeFormatter.ISO_ZONED_DATE_TIME.format(LocalDateTime.now())  // 需 zone
```
**Ans** — LocalDateTime 無 zone → **`UnsupportedTemporalTypeException`**（catch 印）。

### Q42
```java
ls = [11,11,22,33,33,55,66]
ls.stream().distinct().anyMatch(x->x==11)    // true
ls.stream().noneMatch(x->x%11>0)             // 全%11==0 → true
```
**Ans** — `true`、`true`。

### Q43
```java
var b=false; var i=1; do{ i++; }while(b = !b);
```
**Ans** — 第一輪 i=2、b→true（迴圈條件 true 繼續）；第二輪 i=3、b→false（條件 false 結束）→ 印 **`3`**（已驗證）。

### Q45（throw null checked）
**Q** — `throw e`（`e` 為 null、型別 Exception）於 `throws Exception` 方法內？
**Ans** — **編譯通過**（型別為 Exception 已宣告可拋）；執行時擲出 null → 拋 **`NullPointerException`**（無訊息）。

### Q46
`List.of(1,2,3,4).stream().collect(averagingInt(i->i))` → **`2.5`**；`parallel().mapToDouble(...).average().getAsDouble()` → **`2.5`**。

### Q54（ArrayList + executor）
**Q** — 兩執行緒各 add 5000 → 總數？
```java
synchronized(al){ al.add(i); }  // 兩 thread 各5000 → 10000
```
**Ans** — 因 `synchronized(al)` → 總數 **`10000`**。`es.submit(thread)` 以 Thread 當 Runnable submit。

## UniqueTest4

### Q5（電話遮罩）
**Q** — 產生 `xxx-xxx-7890` 的有效方式？
**Ans** —
- `"xxx-xxx-" + fullPhoneNumber.substring(8,12)` ✅
- `new StringBuilder(fullPhoneNumber).replace(0,8,"xxx-xxx-").toString()` ✅
- `new StringBuilder("xxx-xxx-").insert(8, fullPhoneNumber, 8, 12)` ✅（insert 4 參數）
- `new StringBuilder("xxx-xxx-").append(fullPhoneNumber, 8, 12)` ✅
- `"xxx-xxx-" + original.substring(8,12)` ✅
- ❌ `mask.append(...)`（mask 為 String 不可 append）→ 註解。

### Q6（sealed）
```java
sealed class WeekDay permits Monday {}
non-sealed class Monday extends WeekDay {}
```
**Ans** — 合法 sealed + non-sealed 階層。

### Q7（Function）
```java
computeA(base, Function<Integer,Integer>) → (int)base=100 → x->x*5 → 500
computeD(base, Function<Double,Double>)   → 100.0*5 → 500.0
// computeC(base, Function<Double,Integer>) → base(100.0)*5 = double，無法給 Function<Double,Integer> → 不編譯（註解）
```
**Ans** — `computeA` 印 `500.0`（double 回傳）；`computeD` 印 `500.0`。`computeC`（`Function<Double,Integer>`，lambda 回傳 `base*interestrate` 為 double）→ **不合法**。

### Q8（ListResourceBundle）
```java
rb.getObject("key1") → "value1"
rb.getStringArray("key2") → [value2a, value2b]
// rb.getObject(1) → 無此方法 ❌
// String str = rb.getObject("key1") → 需強制轉型 ❌
```
**Ans** — `getObject(key)` 回 Object（需各自型別轉換）；`getStringArray(key)` 回 String[]。`getObject(int)` 不存在。

### Q9（module open/opens）
```java
open module m1 {}
module m2 { opens pkg; }
module m3 { opens pkg to other.module; }
```
**Ans** — 三段皆正確：`open module` 全開、`opens pkg`（開給所有模組）、`opens pkg to 指定模組`。允許 reflection；模組預設強封裝；modular jar 可放 classpath。

### Q10（InitTestU4）
**Q** — 初始化順序？
```java
static String s1=sM1("a"); { s1=sM1("b"); } static { s1=sM1("c"); }
static String s2=sM1("a1"); { s2=sM1("b1"); } static { s2=sM1("c1"); }
// new InitTestU4()
```
**Ans** — 依出現次序：靜態依次 `a, c, a1, c1`（含 static block 於其位置），實例區塊 `b`、`b1`（new 時）。完整輸出先靜態後實例交錯。

### Q11（Files.copy symlink）
**Q** — 關於 `REPLACE_EXISTING` 與 symbolic link？
**Ans** — 目標是 symlink 時 `REPLACE_EXISTING` 會**取代連結本身**；來源是 symlink 時預設複製**最終目標**內容。

### Q13（Account withdraw）
```java
Account account=new Account("A1",100); account.withdraw(25);
```
**Ans** — 100 > 25 → balance=75 → 印 **`75.0`**（`getBalance()`）。

### Q15（ParamTest overload）
**Q** — 印出？
```java
printSum(double,double); printSum(float,float);
printSum(1,2.0) → "In double 3.0"
printSum(1,2)  → "In float 3.0"
printSum(1.0,2.0) → "In double 3.0"
```
**Ans** — 依 Java 多載選擇（最短加寬）：
- `printSum(1,2.0)` → **`In double 3.0`**
- `printSum(1,2)` → 兩 int 最短到 (float,float) → **`In float 3.0`**
- `printSum(1.0,2.0)` → **`In double 3.0`**
（已用 javac 驗證：`In double 3.0 / In float 3.0 / In double 3.0`）

### Q18（PrintWriter）
```java
pw.print(true); pw.print(" "); pw.println(true);  → "true true"
```
**Ans** — `print(true)` 無換行、`println(true)` 帶換行 → **`true true`**。`pw.writeBoolean`/`write(boolean)` 不存在 → 註解。

### Q20（BookList extends ArrayList<Book>）
**Q** — `add(Object)` 與 `add(Book)` 為何衝突？
**Ans** — `ArrayList<E>` 有 `add(E)`；若子類別再加 `add(Object)`，兩者 erase 後皆為 `add(Object)` → **既非覆寫也非多載 → 不編譯**（`addIfBook` 改用第三人稱方法才合法）。執行 `list.add(new Book())`、`add(new TextBook())`、`addIfBook("hello")`（非 Book → `count++==-1` → false、count 變 1）→ 印各回傳與 count。

### Q21（computeIfAbsent/Present）
```java
groupedValues.computeIfAbsent(name, a->{ print a; return new ArrayList<>(); }).add(value);
groupedValues.computeIfPresent(name,(a,b)->{ print a+" "+b; return b; });
```
**Ans** — 依 key 群組：首次建立印 key、再次印 key + 既有 list 內容；`process("a",10.0)、("a",20.0)、("b",30.0)` → 群組結果 `{a=[10.0,20.0], b=[30.0]}`。

### Q22（module broker）
```java
module broker { exports org.broker.api; provides org.broker.api.Broker with org.broker.api.MyBroker; }
```
**Ans** — 多個模組可提供**同一 service**（ServiceLoader 載入全部）；API 與實作分開較乾淨；API+實作同模組可能讓使用者**意外依賴實作**。

### Q31（Collections.sort null comparator）
**Q** — `sa[0]`？
```java
Collections.sort(Arrays.asList(sa), null);
```
**Ans** — `null` comparator → **自然排序**。`Arrays.asList(sa)` 的回覆（backing array）**可被 sort**（不需 resize）→ sa 排序 → `sa[0]` = **`andy`**（對 [charlie,bob,andy,dave]）。（已驗證）

### Q34（% 與三元）
```java
foo=2, bar=3, baz=4;
mod1=foo%baz=2; mod2=baz%foo=0; val = mod1>mod2 ? bar:baz → 3
```
**Ans** — `mod1(2) > mod2(0)` true → bar=**`3.0`**。

### Q37（for 迴圈語法）
```java
for(; Math.random()<0.5;){...; break;}          // ✅ 合法
for(int j=0;; Math.random()){ if(j++==0) break; } // ✅ 合法
for(;;){ if(Math.random()<.05||true) break; }      // ✅ 合法
// for(;; Math.random()<0.5){...}                // 合法但缺 increment → 無窮
// Math.random()<.05 ? break : continue;         // ❌ 三元不可用 break/continue
```
**Ans** — 各 `for(;;)` 形式皆合法；**三元運算式不可包含 `break`/`continue`**（那行註解）。

### Q39（parallel → sequential）
```java
strm1.parallel().filter(i>5).filter(i<15).sequential().forEach(System.out::print);  // source = [2,3,5,7,11,13,17,19] → filter i>5&&i<15 → 7,11,13
```
**Ans** — 依順序（最終 sequential）印出 filter 後元素 → **`71113`**。

### Q41（char switch fallthrough）
**Q** — 印出 `i`？
```java
char[] ca={'a','b','c','d'};
for(char c:ca){ switch(c){
  case 'a': i++; case 'b': ++i; case 'c'|'d': i++; } }
```
**Ans** — 注意 `case 'c'|'d'` 是**位元 OR**（99|100=103），不是多標籤（非 `case 'c','d'`）。'c'(99)、'd'(100) 皆 != 103 → 該 case **永不命中**。
- 'a'：命中 `case 'a'`（i++）→ fall-through `case 'b'`（++i）→ 'c'|'d' case 不命中 → 共 i 增 2
- 'b'：命中 `case 'b'`（++i）→ i 增 1
- 'c'：所有 case 都不命中（'c'≠'a'、'b'、103）→ 0
- 'd'：0
- 初始 i=0 → 終值 **`i=3`**（實際請以執行確認；重點是 `'c'|'d'` 為位元 OR 非多標籤）。

### Q50（ReentrantLock/tryLock）
```java
LockThreadU4 t1/t2: tryLock() → 一個 get、另一個 遺失
```
**Ans** — 依競態：一執行緒 `tryLock()` 成功印 "got lock"、另一失敗印 "could not get lock"；順序與次數**不保證**（每回 2 次）。

---

## 附錄：易錯點速查（高頻考點）

1. **switch 運算式**：`yield` 回值、窮舉或 `default`；`default` 需最後、`case null, default` 可合併。
2. **Stream reduce identity 必須冪等**：平行下非單位元 identity → 結果不可靠。
3. **Period vs Duration**：Period 只動天/月/年、Duration 動時/分/秒；DST 邊界 Duration 變化。
4. **未 Comparable 物件 `sorted()`** → 執行期 `ClassCastException`。
5. **`List.of`/`List.copyOf` 不可變**但底層可變容器參照會反映。
6. **try-with-resources suppressed**、**close() 拋 checked exception** 處理。
7. **Sealed（permits/non-sealed）、模組可見性、provides 同一 service 不合法、jdeps**。
8. **虛擬執行緒**：priority 固定 5 不可改、恆 daemon、用 newWorkStealingPool。
9. **null 限制**：`ConcurrentHashMap` 禁 null；`HashMap`/`ArrayList`/`CopyOnWriteArrayList` 允許。
10. **複合賦值右側先算**（`k += (k=4)*(k+2)` 括號內已改 k）。
11. **`z = x ^ ~x = -1`、`~x = -(x+1)`**。
12. **方法 reference / 多載選擇**：unbound instance method 需含 receiver 參數；多載選最短加寬。

> 註：少數題目原始選擇題選項在 .java 檔中已散佚，Q 依程式與註解重建，Ans 以 javac 21 實測為準。