# 1Z0-830 Java SE 21 Developer — 網路上蒐集考題（二）

> 來源：
> 1. Medium（Javarevisited，10 題範例）— https://medium.com/javarevisited/1z0-830-sample-questions-for-java-se-21-developer-certification-exam-with-resources-2020cc5999de
> 2. CertGod（95 題題庫之免費預覽 15 題，含詳解）— https://www.certgod.com/1z0-830/questions.html
>
> 整理時間：2026-09-17

---

# Part A — Medium（Javarevisited）範例 10 題

> Medium 原文未附官方答案，以下答案為依 Java 21 語意推導的參考解答。

## A1. reduce 與串接
```java
String[] letters = {"x", "y", "z", "w", "v", "u"};
String output = "Sequence:";
for (String ch : letters) { output += "-" + ch; }
```
哪段 Stream 程式與上方迴圈產生**相同結果**？
- A. `Arrays.stream(letters).reduce("Sequence:", (s1, s2) -> s1 + "-" + s2);`
- B. `output += Arrays.stream(letters).parallel().reduce((s1, s2) -> s1 + "-" + s2).get();`
- C. `Arrays.stream(letters).parallel().reduce("Sequence:", (s1, s2) -> s1 + "-" + s2);`
- D. `output += Arrays.stream(letters).parallel().reduce("", (s1, s2) -> s1 + "-" + s2);`

**答：A。** 只有 A 以 `"Sequence:"` 為 identity 循序累加，產出 `Sequence:-x-y-z-w-v-u`。B/C/D 平行 reduce 的 identity 會在各區塊重複套用、順序不保證，結果與回圈不同。

---

## A2. Labeled loop
```java
String[] txt = {"AB", "CD"};
x:
for (String value : txt) {
    var values = value.toCharArray();
    for (int i = values.length - 1; i >= 0; i--) {
        if (i < 1) continue x;
        else if (values[i] == 'C') break;
        System.out.println(txt[i]);
    }
}
```
- A. A　B. ABD　C. AD　D. AB　E. CDCD　F. ABAB　G. 無輸出

**答：E（CDCD）。**
- 第一輪 `"AB"`：i=1 → 不滿足、非 'C' → 印 `txt[1]="CD"`；i=0 → `continue x`。
- 第二輪 `"CD"`：i=1 → 非 'C' → 印 `txt[1]="CD"`；i=0 → `continue x`。
- 總輸出 `CDCD`。

---

## A3. var 宣告
哪一個區域變數宣告是正確的？
- A. `var 24H = Duration.ofHours(24);`
- B. `var backslashChar = '\\';`
- C. `var doubleSlash = "\\\\";`
- D. `var underscoreIndex = "A_Z".indexOf("_");`

**答：B、C、D。** A 識別字不能以數字開頭（`24H` 非法）；B 為 char literal、C 為 String、D 為 int，皆可推斷。

---

## A4. ArrayDeque offerFirst/offerLast
```java
int[] values = {-1,-2,0,2,1};
Deque<Integer> numbers = new ArrayDeque<>();
for (int i = 0; i < values.length; i++) {
    if (i % 2 == 0) { numbers.offerFirst(values[i]); }
    else { numbers.offerLast(values[i]); }
}
System.out.println(numbers);
```
- A. [1, 0, -1, -2, 2]
- B. [-1, 0, -1, -2, 2]
- C. [-1, 0, 1, -2, 2]
- D. [-1, -2, -0, 1, 2]
- E. None of the Above

**答：A。**
- i=0 offerFirst(-1) → [-1]
- i=1 offerLast(-2) → [-1, -2]
- i=2 offerFirst(0) → [0, -1, -2]
- i=3 offerLast(2) → [0, -1, -2, 2]
- i=4 offerFirst(1) → [1, 0, -1, -2, 2]

---

## A5. switch pattern matching + Number
```java
public static String test(Number value) {
    return switch (value) {
        case Double num when num > 0 -> "Positive";
        case Double num when num < 0 -> "Negative";
        case Double num when num == 0 -> "Zero";
        default -> "Invalid";
    };
}
// main:
Number num = Integer.valueOf(1);
System.out.println(test(num));
num = null;
System.out.println(test(num));
```
- A. Error/Error　B. Invalid/Error　C. Positive/Invalid
- D. Invalid/Invalid　E. Positive/Error　F. None of the above

**答：E。** `Integer.valueOf(1)` 不是 Double → `default` 回傳 `Invalid`；傳 null 給 switch 對 null 取值 → NPE → 被 catch 印 `Error`。

---

## A6. DateTimeFormatter "CM"
```java
DateTimeFormatter fmt = DateTimeFormatter.ofPattern("CM");
var x = LocalDate.of(2001, 2, 5);
var y = Period.ofMonths(3).plusDays(1);
var z = x.plus(y);
System.out.println(fmt.format(z));
```
- A. 56　B. 83　C. 38　D. 65　E. None of the above

**答：E。** `C` = century-of-era（numeric）、`M` = month。2001-02-05 + 3 個月 + 1 天 = 2001-05-06，格式化為 `205`，不在任何選項中。

---

## A7. 平行串流 + sorted + forEach
```java
IntStream.concat(IntStream.range(0,3), IntStream.range(3,7))
  .parallel()
  .sorted()
  .filter(i -> i < 5 && i > 1)
  .mapToObj(i -> String.valueOf(i))
  .forEach(s -> Logger.getLogger("test").log(Level.INFO, String.valueOf(s)));
```
- A. 2 3 4 以不可預期順序輸出
- B. 6 5 1 0 依此順序輸出
- C. 0 1 5 6 以不可預期順序輸出
- D. 4 3 2 依此順序輸出
- E. 2 3 4 依此順序輸出
- F. 0 1 5 6 依此順序輸出

**答：A。** 元素 0..6 中 `1 < i < 5` 者為 2、3、4；`sorted()` 保證資料已排序，但為平行串流，之後的 `forEach` 不保證逐元素輸出順序（除非用 `forEachOrdered`）。

---

## A8/A9. synchronizedList + invokeAll（兩題同程式）
```java
List<Integer> nums = Collections.synchronizedList(new ArrayList<>());
Callable<String> c = () -> {
    for (int i = 0; i < 5; i++) { nums.add(i); }
    return null;
};
Collection<Callable<String>> tasks = List.of(c, c, c);
ExecutorService es = Executors.newFixedThreadPool(2);
try {
    List<Future<String>> results = es.invokeAll(tasks);
    es.shutdown();
    nums.stream().forEach(i -> System.out.print(i));
} catch (InterruptedException e) {
    System.out.println("error");
}
```
- A. 印出 0 到 4 的部分整數（升冪）
- B. 印出 0 到 4 的部分整數（降冪）
- C. 印出 0 到 4 的所有整數（升冪），每個出現 3 次
- D. 印出 0 到 4 的所有整數（隨機順序），每個出現 3 次
- E. 印出 0 到 4 的部分整數（隨機順序）
- F. 印出 0 到 4 的所有整數（降冪），每個出現 3 次
- G. 印出 "error"
- H. None of the above

**答：(Q8 版) H；(Q9 版) D。** `invokeAll` 會等三個 task 全部完成，三個 task 各塞入 0..4 → 15 個元素、每個數字各 3 次；但三個執行緒交錯 append，整體順序不保證為升冪，故為「隨機順序、各 3 次」。Q8 選項沒有此項（D 為 None of the above），Q9 的 D 就是正確答案。

---

## A10. record + IntStream 最小熱量
```java
public record Food(String name, int calories) {}

Food[] foods = {new Food("Apple", 200), new Food("Banana", 400),
                new Food("Cake", 800), new Food("Donut", 700)};
// Line n1
```
哪段程式能從**隨機選取**的 Food 串流中找出熱量最低者？
- A. `IntStream.generate(() -> ThreadLocalRandom.current().nextInt(foods.length-1)).limit(10).mapToObj(i -> foods[i]).max((f1, f2) -> f1.calories() - f2.calories()).get();`
- B. `IntStream.generate(() -> ThreadLocalRandom.current().nextInt(foods.length-1)).mapToObj(i -> foods[i]).sorted((f1, f2) -> f1.calories() - f2.calories()).findFirst().get();`
- C. `IntStream.generate(() -> ThreadLocalRandom.current().nextInt(foods.length)).mapToObj(i -> foods[i]).sorted((f1, f2) -> f1.calories() - f2.calories()).findFirst().get();`
- D. Both of them　E. None of the above

**答：D。** A 用 `max` 找的是最高熱量（不符），且 A、B 的 `nextInt(length-1)` 索引範圍略小（不含最後一個元素）；B、C 皆為升冪排序後 `findFirst()` 取得所選隨機子集中熱量最低者，故 D。

---

# Part B — CertGod 免費預覽 15 題（含官方式詳解）

## B1. ServiceLoader 載入服務
考慮用 ServiceLoader 載入 MyService 實作的方法，哪些正確？（Choose all）
- A. `MyService service = ServiceLoader.load(MyService.class).iterator().next();`
- B. `MyService service = ServiceLoader.load(MyService.class).findFirst().get();`
- C. `MyService service = ServiceLoader.getService(MyService.class);`
- D. `MyService service = ServiceLoader.services(MyService.class).getFirstInstance();`

**答：A、B。** `load()` + `iterator().next()` 或 `findFirst().get()` 皆可取得第一個 provider（皆需處理空值例外）。C 的 `getService` 與 D 的 `services`/`getFirstInstance` 並不存在，會編譯失敗。

---

## B2. switch pattern 原始型別
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
**答：F（Compilation fails）。** switch type pattern 不支援原始型別；`0` 會被 box 成 Integer，改用 `case Integer i` 才可編譯並印出 `integer`。

---

## B3. this() 循環呼叫
```java
public class ThisCalls {
    public ThisCalls() { this(true); }
    public ThisCalls(boolean flag) { this(); }
}
```
- A. 無法編譯　B. 執行時拋例外　C. 可編譯

**答：A。** 兩個建構子彼此間接呼叫自身 → recursive constructor invocation，編譯錯誤（JLS 明定禁止）。

---

## B4. Collectors.joining
```java
StringBuffer us = new StringBuffer("US");
StringBuffer uk = new StringBuffer("UK");
Stream<StringBuffer> stream = Stream.of(us, uk);
String output = stream.collect(Collectors.joining("-", "=", ""));
System.out.println(output);
```
- A. US-UK　B. An exception is thrown.　C. -US=UK
- D. =US-UK　E. Compilation fails.　F. US=UK

**答：D。** `joining(delimiter, prefix, suffix)`：元素間用 `-`，開頭加 `=`，結尾 `""` → `=US-UK`。

---

## B5. Virtual threads
關於 virtual threads（Project Loom, Java 21），何者為真？
- A. Virtual threads share OS-level stacks.
- B. Virtual threads require explicit pool management.
- C. Virtual threads are created using Thread.startVirtualThread().
- D. Virtual threads block the carrier thread during I/O.

**答：C。** Virtual threads 由 JVM 排程、各自有堆疊，不需手動管理 pool；I/O 阻塞時不會卡住 carrier thread（會 unmount）。建立方式之一是 `Thread.startVirtualThread(Runnable)`。

---

## B6. CopyOnWriteArrayList 迭代
```java
CopyOnWriteArrayList<String> list = new CopyOnWriteArrayList<>();
list.add("A"); list.add("B"); list.add("C");
new Thread(() -> { list.add("D"); System.out.println("Element added: D"); }).start();
new Thread(() -> { for (String element : list) { System.out.println("Read element: " + element); } }).start();
```
- A. 印出所有元素且包含迭代期間的變更
- B. 印出所有元素，但迭代期間的變更可能看不到
- C. 拋例外
- D. 編譯失敗

**答：B。** `CopyOnWriteArrayList` 的迭代器建立在**快照**上，迭代期間的寫入（新增 D）不會反映在已建立的 iterator。

---

## B7. do-while 前置遞增（同 A2）
```java
var counter = 0;
do { System.out.print(counter + " "); } while (++counter < 3);
```
**答：B（0 1 2）。** do-while 至少執行一次；`++counter < 3` 先加後比。counter=0→印 0、1→印 1、2→印 2，第三輪 counter=3 時結束。

---

## B8. jdeps 選項
下列哪一個不是 jdeps 的合法選項？
- A. --check-deps
- B. --generate-open-module
- C. --list-deps
- D. --generate-module-info
- E. --print-module-deps
- F. --list-reduced-deps

**答：A。** jdeps 無 `--check-deps`。其餘皆為合法選項：`--generate-open-module`、`--list-deps`、`--generate-module-info`、`--print-module-deps`、`--list-reduced-deps`。

---

## B9. 非靜態內部類別實體化
```java
public class OuterClass {
    String outerField = "Outer field";
    class InnerClass {
        void accessMembers() { System.out.println(outerField); }
    }
    public static void main(String[] args) {
        OuterClass outerObject = new OuterClass();
        InnerClass innerObject = new InnerClass(); // n1
        innerObject.accessMembers();               // n2
    }
}
```
- A. Inner class:/Outer field　B. Nothing　C. An exception is thrown at runtime.
- D. Compilation fails at line n1.　E. Compilation fails at line n2.

**答：D。** `InnerClass` 是非靜態內部類別，須依附 outer 實例：`OuterClass.InnerClass innerObject = outerObject.new InnerClass();`。n1 直接 `new` 編譯失敗。

---

## B10. try-with-resources 寫入
```java
try (FileOutputStream fos = new FileOutputStream("t.tmp");
     ObjectOutputStream oos = new ObjectOutputStream(fos)) {
    fos.write("Today");          // 選項 A
    fos.writeObject("Today");    // 選項 B
    oos.write("Today");          // 選項 C
    oos.writeObject("Today");    // 選項 D
} catch (Exception ex) { }
```
哪一個述句可編譯？
- A. `fos.write("Today");`
- B. `fos.writeObject("Today");`
- C. `oos.write("Today");`
- D. `oos.writeObject("Today");`

**答：D。** `FileOutputStream.write` 只接受 `int`/`byte[]`（A 錯）；沒有 `writeObject`（B 錯）。`ObjectOutputStream.write` 無 String 版（C 錯）。`oos.writeObject("Today")` —— String 可序列化，唯一合法。

---

## B11. String.strip()
```java
String s = "    ";
System.out.print("[" + s.strip());
s = " hello ";
System.out.print("," + s.strip());
s = "h i ";
System.out.print("," + s.strip() + "]");
```
- A. [ ,hello,h i]　B. [,hello,h i]　C. [,hello,hi]　D. [ , hello ,hi ]

**答：B。** 四個空格的 `strip()` → 空字串；`" hello "` → `hello`；`"h i "` → `h i`（中間空白保留）。合併為 `[,hello,h i]`。

---

## B12. Predicate 的 default 方法
`java.util.function.Predicate` 中哪些是 default 方法？
- A. `and(Predicate<? super T> other)`
- B. `isEqual(Object targetRef)`
- C. `negate()`
- D. `not(Predicate<? super T> target)`
- E. `or(Predicate<? super T> other)`
- F. `test(T t)`

**答：A、C、E。** `and`、`negate`、`or` 是 default 實例方法；`isEqual`、`not` 是 static 方法；`test` 是抽象方法。

---

## B13. var 陣列宣告
```java
var array1 = new String[]{ "foo", "bar", "buz" };   // A
var array2[] = { "foo", "bar", "buz" };             // B
var array3 = new String[3] { "foo", "bar", "buz" }; // C
var array4 = { "foo", "bar", "buz" };               // D
String array5[] = new String[]{ "foo", "bar", "buz" }; // E
```
哪些陣列宣告可編譯？（Select 2）
**答：A、E。** `var array2[]` 語法非法（不能 `var x[]`）；`new String[3] {...}` 不能同時給大小與 initializer（C）；陣列 initializer 不能做為 var 的初始化式（D）。`array1`（`new String[]{...}`）與 `array5`（傳統宣告）皆合法。

---

## B14. record 編譯合法度
```java
record WithInstanceField(String foo, int bar) { double fuz; }    // 選項 B
record WithStaticField(String foo, int bar) { static double wiz; } // 選項 D
record ExtendingClass(String foo) extends Exception {}            // 選項 A
record ImplementingInterface(String foo) implements Cloneable {}  // 選項 C
```
哪些 record 可編譯？（Select 2）
**答：C（ImplementingInterface）、D（WithStaticField）。** record 能實作介面（Cloneable 為 marker，可）；也可宣告 static 欄位。record 不能宣告額外 instance fields（B 錯）；record 隱式 extends `java.lang.Record`，不能再 extends 其他類別（A 錯）。

---

## B15. TreeMap.subMap（同 A1 變體）
```java
var cabarets = new TreeMap<>();
cabarets.put(1, "Moulin Rouge");
cabarets.put(2, "Crazy Horse");
cabarets.put(3, "Paradis Latin");
cabarets.put(4, "Le Lido");
System.out.println(cabarets.subMap(2, true, 5, false));
```
**答：B（{2=Crazy Horse, 3=Paradis Latin, 4=Le Lido}）。** `fromInclusive=true` 含 2、`toInclusive=false` 不含 5（5 本就不存在，無影響）。