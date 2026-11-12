# 1Z0-830 Java SE 21 模擬考題 ─ 77 題完整答案與詳解

> 來源：`jdk21exam.txt`（補習班四次模擬考整合題庫，共 77 題，依單元排列）
> 驗證環境：JDK 21.0.2（本文所有「實際輸出」皆以 JDK 21 編譯／執行確認）
> 文件目的：逐題說明**為什麼是這個答案**、**其他選項錯在哪裡**、以及**對應的考試考點**

---

## 目錄

| 單元 | 主題 | 題數 | 題號 |
|---|---|---|---|
| 1 | 基本語法與運算子 | 8 | 20, 24, 25, 30, 31, 51, 66, 67 |
| 2 | 字串與文字區塊 | 3 | 42, 43, 63 |
| 3 | 類別、介面與物件導向 | 14 | 12, 21, 34, 40, 41, 44, 45, 56, 62, 69, 71, 72, 76, 77 |
| 4 | Record | 1 | 13 |
| 5 | Enum | 3 | 26, 27, 38 |
| 6 | 樣式比對與 switch | 4 | 35, 36, 37, 39 |
| 7 | 例外處理 | 3 | 14, 15, 65 |
| 8 | 集合與陣列 | 7 | 6, 7, 8, 9, 53, 54, 73 |
| 9 | Stream API | 10 | 4, 5, 48, 49, 50, 57, 58, 60, 70, 74 |
| 10 | 並行與執行緒 | 8 | 10, 11, 17, 18, 19, 55, 68, 75 |
| 11 | I/O、NIO 與序列化 | 6 | 16, 28, 29, 32, 33, 64 |
| 12 | 日期時間、格式化與本地化 | 5 | 1, 46, 47, 52, 59 |
| 13 | 模組系統 | 5 | 2, 3, 22, 23, 61 |

---

## 答案總表（依題號排序）

| 題號 | 答案 | 題號 | 答案 | 題號 | 答案 | 題號 | 答案 |
|---|---|---|---|---|---|---|---|
| 1 | D | 21 | D | 41 | C | 61 | A, B |
| 2 | D | 22 | A, C | 42 | D | 62 | D |
| 3 | G | 23 | C | 43 | D | 63 | C |
| 4 | D | 24 | C | 44 | B | 64 | B |
| 5 | C | 25 | C | 45 | A | 65 | D |
| 6 | C | 26 | B | 46 | C | 66 | B |
| 7 | A | 27 | D | 47 | B | 67 | B |
| 8 | C | 28 | A | 48 | F | 68 | C |
| 9 | B, E | 29 | B | 49 | C | 69 | A, B, E |
| 10 | A | 30 | E | 50 | C | 70 | C |
| 11 | D | 31 | A | 51 | A | 71 | B |
| 12 | C | 32 | B | 52 | C | 72 | D, E |
| 13 | C, E | 33 | B | 53 | A | 73 | B |
| 14 | A, E | 34 | D | 54 | F | 74 | B |
| 15 | A | 35 | B | 55 | H | 75 | B |
| 16 | D | 36 | D | 56 | D | 76 | E |
| 17 | A, D | 37 | C | 57 | B | 77 | B, E |
| 18 | D | 38 | E | 58 | A | | |
| 19 | A | 39 | E | 59 | D | | |
| 20 | C, F | 40 | A, E | 60 | C | | |

---

# 1. 基本語法與運算子（8 題）

## 第 20 題（第 1 次模擬考 第 20 題）

**題目**：Which two code fragments compile?（選 2 個）

```java
A. class L5 {
       public void m() {
           var strVar = null;
       }
   }
B. class L2 {
       public void m(int x) {
           var x = 10;
       }
   }
C. class A {}
   class B extends A {}
   class L4 {
       public static void main(String[] args) {
           var x = new A();
           x = new B();
       }
   }
D. class L1 {
       var x = 100;
   }
E. class L3 {
       public static void main(String[] args) {
           var a = 10;
           a = "30";
       }
   }
F. class L6 {
       public static void main(String[] args) {
           var x = new ArrayList<>();
           x.add(10);
           x.add("30");
           System.out.println(x);
       }
   }
```

**答案：C、F**

**解析**

- `var` 是「區域變數型別推斷」，編譯器會依**初始化運算式的靜態型別**決定變數型別，之後就固定不變。
- **C**：`var x = new A();` → `x` 的型別是 `A`。`x = new B();` 中 `B` 是 `A` 的子類別，可以賦值給 `A` → 合法。
- **F**：`var x = new ArrayList<>();` 沒有目標型別可推斷泛型，編譯器推成 `ArrayList<Object>`。因此 `add(10)` 與 `add("30")` 都接受（`Object`）→ 合法。

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | `var` 不能由 `null` 推斷型別（`cannot infer type`） |
| B | 編譯失敗 | 參數 `x` 已存在，區域變數不可同名重複宣告 |
| C | **編譯成功** | `B` 是 `A` 的子型別，可賦值 |
| D | 編譯失敗 | `var` 只能用於**區域變數**，不可用於欄位 |
| E | 編譯失敗 | `a` 已推斷為 `int`，不可再指派 `String` |
| F | **編譯成功** | 無目標型別 → `ArrayList<Object>`，任何物件都能 `add` |

**考點**：`var` 的使用限制（不可為 `null`、不可用於欄位／參數、不可重複宣告、不可換型別）、泛型鑽石運算子在 `var` 下的行為。

---

## 第 24 題（第 1 次 第 24 題、第 2 次 第 22 題、第 3 次 第 22 題）

**題目**

```java
public class Calculator {
    int calc(int i, String s) {
        return s.length()+i;
    }
    int calc(int i, int j) {
        return i*j;
    }
    float calc(String s) {
        return s.length()/2f;
    }
    float calc(int i) {
        return i/2f;
    }
    public static void main(String[] args) {
        Calculator cal = new Calculator();
        var a = "ACME";
        var b = cal.calc(a);
        // Line n1
        System.out.println(c+" "+d+" "+e);
    }
}
```

Which code fragment inserted at line marked "Line n1" would result in the following output: `6 3.0 36`?

```java
A. var c = cal.calc(Math.round(b));
   var d = cal.calc(Math.round(c),a);
   var e = cal.calc(d, d);
B. var c = cal.calc(Math.round(b));
   var d = cal.calc(Math.round(c),a);
   var e = cal.calc(d,a);
C. var c = cal.calc(Math.round(b),a);
   var d = cal.calc(Math.round(c));
   var e = cal.calc(c, c);
D. var c = cal.calc(Math.round(b), Math.round(b));
   var d = cal.calc(c,c);
   var e = cal.calc(Math.round(b),a);
```

**答案：C**

**解析**

先算出前置條件：

- `cal.calc("ACME")` 會選到 `float calc(String)`，回傳 `4/2f = 2.0f`，所以 `b` 是 `float`，值為 `2.0`。
- `Math.round(float)` 的回傳型別是 **`int`**（不是 `long`）；`Math.round(b) = 2`。

逐一追蹤選項 C：

1. `c = cal.calc(Math.round(b), a)` → `cal.calc(2, "ACME")` → 選 `int calc(int, String)` → `4 + 2 = 6`（`int`）
2. `d = cal.calc(Math.round(c))` → `cal.calc(6)` → 選 `float calc(int)` → `6/2f = 3.0f`（`float`）
3. `e = cal.calc(c, c)` → `cal.calc(6, 6)` → 選 `int calc(int, int)` → `6*6 = 36`（`int`）

輸出 `6 3.0 36` ✔（實測結果相同）

**各選項檢討**

| 選項 | c | d | e | 輸出 |
|---|---|---|---|---|
| A | `calc(2)` → 1.0f | `calc(1,"ACME")` → 5 | `calc(5,5)` → 25 | `1.0 5 25` |
| B | 1.0f | 5 | `calc(5,"ACME")` → 9 | `1.0 5 9` |
| **C** | **6** | **3.0** | **36** | **`6 3.0 36`** ✔ |
| D | `calc(2,2)` → 4 | `calc(4,4)` → 16 | `calc(2,"ACME")` → 6 | `4 16 6` |

**考點**：多載解析（overload resolution）＋ `Math.round(float)` 回傳 `int` ＋ `int/2f` 會提升為浮點除法。

---

## 第 25 題（第 1 次 第 25 題、第 3 次 第 21 題）

**題目**

```java
public class Question {
    public void answer(int a, int b) {
        System.out.print(" A");
    }
    public void answer(int a, float b) {
        System.out.print(" B");
    }
    public void answer(float a, float b) {
        System.out.print(" C");
    }
    public void answer(double... a) {
        System.out.print(" D");
    }
    public static void main(String[] args) {
        Question q = new Question();
        q.answer(10,15.25);
        q.answer(10, 24);
        q.answer(10.25,10.25);
    }
}
```

What is the result?

```text
A. B A C
B. B A D
C. D A D
D. D D D
```

**答案：C**

**解析**

Java 多載解析分三階段：① 不裝箱／不 varargs；② 允許裝箱／拆箱；③ 允許 varargs。前一階段找到就不再往下找。

1. `q.answer(10, 15.25)`
   - `15.25` 是 `double`，Java **不會**自動把 `double` 窄化成 `float`，所以 `(int,float)`、`(float,float)` 都不適用。
   - 只剩 `(double...)` 在階段 ③ 適用（`10` 可 widen 成 `double`）→ 印 **`D`**。
2. `q.answer(10, 24)`
   - 階段 ① 就找到完全符合的 `(int,int)` → 印 **`A`**。
3. `q.answer(10.25, 10.25)`
   - 兩個都是 `double`，`(int,float)`、`(float,float)` 皆需窄化 → 不適用；只剩 `(double...)` → 印 **`D`**。

輸出：`D A D` ✔（實測 ` D A D`）

**考點**：多載三階段解析、varargs 的優先順序最低、`double` 不會自動轉 `float`。

---

## 第 30 題（第 1 次 第 30 題、第 3 次 第 5 題）

**題目**

```java
int x = Integer.valueOf("a", 16)-9;
String y = "128";
byte z = Boolean.valueOf(String.valueOf(x)) ? Integer.valueOf(y).byteValue() : (byte)x;
System.out.println(z);
```

What is the result?

```text
A. 0
B. 128
C. -128
D. Exception is thrown at run time
E. 1
F. -1
```

**答案：E**

**解析**

1. `Integer.valueOf("a", 16)` → 以 16 進位解析 `"a"` → `10`；`10 - 9 = 1`，所以 `x = 1`。
2. `String.valueOf(x)` → `"1"`。
3. `Boolean.valueOf("1")` → **只有** `"true"`（忽略大小寫）才是 `true`，其餘字串（含 `"1"`）都是 `false`。
4. 三元運算式走 `false` 分支 → `(byte) x` = `(byte) 1` = `1`。
5. 印出 `1` ✔

**陷阱**：`Integer.valueOf("128").byteValue()` 會得到 `-128`（溢位），但這個分支**不會被執行**，所以答案是 E 不是 C。

**考點**：`Integer.valueOf(String,int)` 基數解析、`Boolean.valueOf(String)` 只認 `"true"`、三元運算式的短路特性、`byte` 溢位。

---

## 第 31 題（第 1 次 第 31 題、第 2 次 第 1 題）

**題目**

```java
int i = 15;
// Line n1
System.out.println(j);
```

Which statement inserted at "Line n1" enables you to print `2.0`?

```java
A. float j = i % 3 + 2;
B. float j = i / 3 + 2;
C. float j = i / (3 + 2);
D. float j = i % (3 + 2);
```

**答案：A**

**解析**

| 選項 | 計算 | 結果 |
|---|---|---|
| **A** | `15 % 3 = 0`；`0 + 2 = 2`（int）；指派給 `float` → `2.0f` | **`2.0`** ✔ |
| B | `15 / 3 = 5`；`5 + 2 = 7` → `7.0` | `7.0` |
| C | `15 / 5 = 3` → `3.0` | `3.0` |
| D | `15 % 5 = 0` → `0.0` | `0.0` |

**關鍵**：右邊的整數運算**先算完**才轉成 `float`，所以 `float j = i / 3 + 2;` 不會得到 `2.0`。

**考點**：整數除法／取餘數、`int` 運算結果再寬轉 `float`。

---

## 第 51 題（第 2 次 第 2 題、第 3 次 第 4 題）

**題目**

```java
int a = 2;
int b = ~a;
int c = a^b;
boolean d = a < b & a > c++;
System.out.println(d + " " + c);
boolean e = a > b && a > c++;
System.out.println(e + " " + c);
```

What is the result?

```text
A. false 0
   true 1
B. true 1
   false 2
C. false 1
   false 2
D. false 0
   true 2
E. false 1
   true 2
```

**答案：A**

**解析**

1. `a = 2`（二進位 `...0010`）
2. `b = ~a` → `...1101` = **`-3`**（`~n = -n-1`）
3. `c = a ^ b` → `2 ^ -3`：
   `0010 ^ 1101 = 1111` → **`-1`**
4. `d = a < b & a > c++`
   - `a < b` → `2 < -3` → `false`
   - `a > c++` → 先比較 `2 > -1` → `true`，之後 `c` 變成 `0`
   - `&` **不短路**，兩邊都會算 → `false & true = false`
   - 此時 `c = 0` → 印 `false 0`
5. `e = a > b && a > c++`
   - `a > b` → `2 > -3` → `true`
   - `&&` 左邊為 `true`，右邊才計算：`2 > 0` → `true`，`c` 變成 `1`
   - `e = true` → 印 `true 1`

輸出：

```text
false 0
true 1
```

✔（實測相同）

**考點**：位元補數 `~`、XOR `^`、`&`（非短路）與 `&&`（短路）對 `c++` 副作用次數的影響。

---

## 第 66 題（第 2 次 第 48 題、第 3 次 第 45 題）

**題目**

```java
int c = 0;
x:
for (int a = 3; a > 0; a--) {
    for (int b = 0; b < 3; b++, c--) {
        if (b == 1) continue x; else if (a == 1) break; c += a+b;
    }
}
System.out.println(c);
```

What is the result?

```text
A. 5
B. 3
C. 4
D. 2
```

**答案：B**

**解析**

關鍵：`for` 迴圈的執行順序是「初始化 → 條件 → body → **update** → 條件 → …」。`continue x;` 會跳到**標籤所指（外層）迴圈的 update**，因此**內層的 `b++, c--` 會被跳過**。

逐圈追蹤：

| 步驟 | 外層 a | 內層 b | 執行內容 | c |
|---|---|---|---|---|
| 1 | 3 | 0 | `b != 1`、`a != 1` → `c += 3+0` | `0 → 3` |
| 2 | 3 | 0→1 | 內層 update：`b++`、`c--` | `3 → 2` |
| 3 | 3 | 1 | `b == 1` → `continue x`（跳過內層 update，直接做外層 `a--`） | `2` |
| 4 | 2 | 0 | `c += 2+0` | `2 → 4` |
| 5 | 2 | 0→1 | 內層 update：`b++`、`c--` | `4 → 3` |
| 6 | 2 | 1 | `b == 1` → `continue x` | `3` |
| 7 | 1 | 0 | `b != 1`，但 `a == 1` → `break`（跳出內層，**不做 update**） | `3` |
| 8 | 0 | — | 外層 `a > 0` 失敗 → 結束 | `3` |

最終 `c = 3` ✔（實測輸出 `3`）

> 常見錯誤：以為 `continue x` 連 `b++/c--` 都不算，或以為 `break` 會先做 update，這兩種誤解都會算出 `4` 或 `5`。

**考點**：標籤 `continue` 的跳轉目標、`for` 的 update 執行時機、`break` 不執行 update。

---

## 第 67 題（第 2 次 第 50 題、第 3 次 第 43 題）

**題目**

```java
int a = 0, b = 1, c = 2;
if (Math.round(b/c) < b/c & b != b/++a) {
    c += a+++b;
} else {
    c -= --b+a;
}
System.out.println(c);
```

What is the result?

```text
A. 2
B. 1
C. -1
D. A runtime exception is thrown
E. 0
```

**答案：B**

**解析**

1. `b/c` = `1/2` = `0`（整數除法）
2. `Math.round(0)` = `0`（`Math.round(int)` 回傳 `int`）
3. `0 < 0` → `false`
4. `&` 為**非短路**，右邊仍會計算：`b != b/++a`
   - `++a` → `a = 1`
   - `b / 1` = `1`
   - `1 != 1` → `false`
5. `false & false` = `false` → 執行 `else`
6. `c -= --b + a`
   - `--b` → `b = 0`
   - `0 + 1 = 1`
   - `c = 2 - 1 = 1`
7. 印出 `1` ✔（實測 `1`）

**陷阱**：`a+++b` 會被解析為 `a++ + b`；但本題根本沒進 `if` 分支。

**考點**：`&` 與 `&&` 差異、前置／後置遞增、`Math.round` 多載、整數除法。

---

# 2. 字串與文字區塊（3 題）

## 第 42 題（第 1 次 第 42 題、第 3 次 第 23 題）

**題目**

```java
// Line n1
String s = "-%s-";
System.out.printf(s, x.charAt(6));
```

Which statement inserted at "Line n1" enables you to print `-S-`?

```java
A. String x = """
   Java
   SE
   """;
B. String x = """
   Java SE""";
C. String x = """Java SE""";
D. String x = """
   Java
   
   SE
   """;
```

> 註：原始 txt 經文字擷取後，選項 A 與 D 看起來相同；實際上 **D 在 `Java` 與 `SE` 之間有一個空白行**（PDF 擷取時空行被吃掉），這也是本題的關鍵差異。

**答案：D**

**解析**

`x.charAt(6)` 要取出 `'S'`，所以索引 6 必須是 `S`。

- **A** 的文字區塊內容是 `"Java\nSE\n"`（長度 8）：

  | 索引 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
  |---|---|---|---|---|---|---|---|---|
  | 字元 | J | a | v | a | `\n` | S | E | `\n` |

  `charAt(6)` = `'E'` → 印出 `-E-`（實測 `-E-`）

- **D** 的文字區塊內容是 `"Java\n\nSE\n"`（中間多一空行，長度 9）：

  | 索引 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
  |---|---|---|---|---|---|---|---|---|---|
  | 字元 | J | a | v | a | `\n` | `\n` | **S** | E | `\n` |

  `charAt(6)` = `'S'` → 印出 `-S-` ✔（實測 `-S-`）

**各選項檢討**

| 選項 | 文字區塊值 | charAt(6) |
|---|---|---|
| A | `"Java\nSE\n"` | `'E'` |
| B | `"Java SE"`（結束分隔符號與內容同行，不含結尾換行） | `'E'` |
| C | 編譯失敗：開頭 `"""` 之後必須換行 | — |
| **D** | **`"Java\n\nSE\n"`** | **`'S'`** ✔ |

**考點**：文字區塊的內容規則（開頭分隔符號後必須換行、結尾分隔符號位置決定是否含最後換行、共同縮排會被移除）、`String.charAt` 索引。

---

## 第 43 題（第 1 次 第 43 題、第 2 次 第 42 題、第 3 次 第 24 題）

**題目**

```java
String a = "Hello! Java";
System.out.print(a.indexOf("Java"));
a.replace("Hello!", "Welcome!");
System.out.print(a.indexOf("Java"));
StringBuilder b = new StringBuilder(a);
System.out.print(b.indexOf("Java"));
```

What is the result?

```text
A. 888
B. 7107
C. 81111
D. 777
E. 71010
F. 8109
G. 799
```

**答案：D**

**解析**

`"Hello! Java"` 的索引：

| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|---|---|---|---|---|---|---|---|---|---|---|
| H | e | l | l | o | ! | (空白) | J | a | v | a |

- 第一次 `indexOf("Java")` → `7`
- `a.replace("Hello!", "Welcome!");`：**`String` 不可變**，回傳新字串但沒有指派回 `a` → `a` 仍是原字串 → `indexOf` 還是 `7`
- `new StringBuilder(a).indexOf("Java")` → `7`

輸出 `777` ✔（實測 `777`）

**考點**：`String` 不可變性（回傳新物件，原物件不變）、`StringBuilder.indexOf`。

---

## 第 63 題（第 2 次 第 43 題）

**題目**

```java
String myStr = "Hello Java";
String myTextBlk1 = """
Hello Java""";
String myTextBlk2 = """
Hello Java
""";
System.out.print(myStr.equals(myTextBlk1)+":");
System.out.print(myStr.equals(myTextBlk2)+":");
System.out.print(myTextBlk1.equals(myTextBlk2)+":");
System.out.println(myTextBlk1.intern() == myTextBlk2.intern());
```

What is the result?

```text
A. true:true:false:false
B. true:false:true:false
C. true:false:false:false
D. true:false:true:true
```

**答案：C**

**解析**

- `myTextBlk1`：結束分隔符號 `"""` **與內容同一行** → 內容不含結尾換行 → `"Hello Java"`（長度 10）
- `myTextBlk2`：結束分隔符號**單獨一行** → 內容包含最後的換行 → `"Hello Java\n"`（長度 11）

| 比較 | 結果 |
|---|---|
| `myStr.equals(myTextBlk1)` | `"Hello Java".equals("Hello Java")` → **true** |
| `myStr.equals(myTextBlk2)` | 長度不同 → **false** |
| `myTextBlk1.equals(myTextBlk2)` | 內容不同 → **false** |
| `intern() == intern()` | 兩者內容不同，intern 後仍是不同物件 → **false** |

輸出 `true:false:false:false` ✔（實測相同）

**考點**：文字區塊結尾換行規則、`String.equals` 與 `==`／`intern()` 的差異。

---

# 3. 類別、介面與物件導向（14 題）

## 第 12 題（第 1 次 第 12 題、第 2 次 第 21 題、第 3 次 第 40 題）

**題目**

```java
public class Symbols {
    private char value = '?';
    public Symbols(char value) {
        this.value = value;
    }
    public Symbols() {
        this('!');
    }
    static { System.out.print('/'); }
    { System.out.print(this.value); }
    public String toString() {
        return String.valueOf(this.value);
    }
    public static void main(String[] args) {
        Symbols s1 = new Symbols();
        Symbols s2 = new Symbols('-');
        String symbols = s1.toString()+s2.toString();
        System.out.print(symbols);
    }
}
```

What is the result?

```text
A. !?-?!
B. /?!-
C. /??!-
D. /!!-
E. !??-!
F. !/?!-
```

**答案：C**

**解析**

初始化順序（**每個物件只會執行一次實例初始化區塊**）：

1. 類別載入 → 執行 `static` 區塊 → 印 `/`
2. `new Symbols()` → 委派 `this('!')` → 進入 `Symbols(char)`
   - 先執行**欄位初始化** `value = '?'`
   - 再執行**實例初始化區塊** → 此時 `value` 還是 `'?'` → 印 `?`
   - 最後執行建構子本體 `this.value = '!'`
   - → `s1` 的 `value = '!'`
3. `new Symbols('-')` → 同樣：欄位初始化 `'?'` → 實例區塊印 `?` → 建構子設 `'-'`
   - → `s2` 的 `value = '-'`

最後 `s1.toString()` = `"!"`、`s2.toString()` = `"-"`，印出 `!-`。

完整輸出：`/` + `?` + `?` + `!` + `-` = **`/??!-`** ✔（實測 `/??!-`）

**陷阱**：實例初始化區塊執行時，建構子本體**還沒**執行，所以印出的是預設初始值 `'?'` 而不是 `'!'`。

**考點**：類別初始化 vs 實例初始化順序、建構子委派 `this(...)`、初始化區塊。

---

## 第 21 題（第 1 次 第 21 題、第 2 次 第 37 題）

**題目**：Which example defines the `Book` class to provide immutable `Book` objects?

```java
A. public final class Book {
       private static int maxId;
       private final int id;
       private final String title;
       public Book () { this.id = ++maxId; }
       public Book (String title) { this.title = title; }
       public String getTitle() { return title; }
   }
B. public final class Book {
       private static int maxId;
       private final int id;
       private final String title;
       public Book () { this(""); id = ++maxId; }
       public Book (String title) { this.title = title; }
       public String getTitle() { return title; }
   }
C. public final class Book {
       private static int maxId;
       private final int id;
       private final String title;
       public Book () { id = ++maxId; }
       public Book (String title) { this.id = ++maxId; this.title = title; }
       public String getTitle() { return title; }
   }
D. public final class Book {
       private static int maxId;
       private final int id;
       private final String title;
       public Book () { this(""); }
       public Book (String title) { this.id = ++maxId; this.title = title; }
       public String getTitle() { return title; }
   }
E. public final class Book {
       private static int maxId;
       private final int id = ++maxId;
       private final String title;
       public Book () { }
       public Book (String title) { this(); this.title = title; }
       public String getTitle() { return title; }
   }
```

**答案：D**

**解析**

「不可變（immutable）」的必要條件：

1. 類別 `final`（不可被繼承改寫行為）
2. 所有欄位 `private final`
3. 沒有 setter
4. 建構子必須讓**每一個** `final` 欄位都被**明確指派一次**

Java 的**明確指派（definite assignment）規則**：`blank final` 欄位必須在**每個建構子的每一條路徑**上被指派，否則編譯失敗。

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | `Book()` 未指派 `title`；`Book(String)` 未指派 `id` |
| B | 編譯失敗 | `Book(String)` 未指派 `id`（直接呼叫此建構子時） |
| C | 編譯失敗 | `Book()` 未指派 `title` |
| **D** | **正確** | `Book()` 用 `this("")` 委派，兩條路徑都由 `Book(String)` 指派 `id` 與 `title` |
| E | 編譯失敗 | `Book()` 未指派 `title`（欄位初始化只處理 `id`） |

**考點**：`final` 欄位的明確指派規則、建構子鏈 `this(...)`、immutable 類別設計。

---

## 第 34 題（第 1 次 第 34 題、第 2 次 第 9 題、第 3 次 第 25 題）

**題目**

```java
public final class Music extends Art {
    private String metre;
    public Music(String title, String metre) {
        super(title);
        this.metre = metre;
    }
    public String metre() { return metre; }
}

public non-sealed class Dance extends Art {
    private String metre;
    public Dance(String title, String metre) {
        super(title);
        this.metre = metre;
    }
    public String metre() { return metre; }
}

public class Stage {
    public static void main(String[] args) {
        Art a1 = new Music("Waltz","3/4");
        Art a2 = new Dance("Waltz","3/4");
        Art a3 = new Dance("Waltz","3/4");
        System.out.print(a1.equals(a2)+" ");
        System.out.print(a2.equals(a3)+" ");
        System.out.print(a3.equals(null)+" ");
    }
}
```

Which definition of the class `Art` allows to produce the `false true false` output?

```java
A. public sealed class Art permits Music, Dance {
       private String title;
       public Art(String title){ this.title = title; }
       public boolean equals(Object obj) {
           return switch (obj) {
               case Dance dance -> dance.metre().equals(this.metre());
               case Music music -> music.metre().equals(this.metre());
               case null -> false;
               default -> false;
           };
       }
   }
B. public sealed class Art permits Music, Dance {
       private String metre;
       public Art(String metre){ this.metre = metre; }
       public String metre() { return metre; }
       public boolean equals(Object obj) {
           if (obj instanceof Art art) {
               return art.metre().equals(this.metre());
           }
           return false;
       }
   }
C. public sealed class Art permits Music, Dance {
       private String title;
       public Art(String title){ this.title = title; }
       public boolean equals(Object obj) {
           return obj != null && obj.getClass().equals(this.getClass())
               && (((Dance)obj).metre().equals(metre())
               || (((Music)obj).metre().equals(metre())));
       }
   }
D. public abstract sealed class Art permits Music, Dance {
       private String title;
       public Art(String title){ this.title = title; }
       public abstract String metre();
       public boolean equals(Object obj) {
           return obj != null && obj.getClass().equals(this.getClass())
               && ((Art)obj).metre().equals(this.metre());
       }
   }
E. public abstract sealed class Art permits Music {
       private String title;
       public Art(String title){ this.title = title; }
       public abstract String metre();
       public boolean equals(Object obj) {
           if (obj instanceof Art art) {
               return art.metre().equals(this.metre());
           }
           return false;
       }
   }
```

**答案：D**

**解析**

需求：`a1.equals(a2)` → false（Music vs Dance）、`a2.equals(a3)` → true（兩個 Dance 且 metre 相同）、`a3.equals(null)` → false。

**D**：

```java
obj != null
&& obj.getClass().equals(this.getClass())     // 類別必須完全相同
&& ((Art)obj).metre().equals(this.metre())    // 再比 metre
```

- `Music.equals(Dance)` → `getClass()` 不同 → **false** ✔
- `Dance.equals(Dance)` → 類別相同、`"3/4".equals("3/4")` → **true** ✔
- `Dance.equals(null)` → `obj != null` 失敗 → **false** ✔

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | `Art` 只有 `title` 欄位、沒有 `metre()` 方法，因此 `this.metre()`（以及 `dance.metre()` 的比較對象）找不到 |
| B | 輸出 `true true false` | 只比 `metre`，`Music` 與 `Dance` 的 metre 同為 `"3/4"` → 第一個比較就是 true |
| C | 編譯失敗 | `Art` 沒有 `metre()`；`metre()` 未限定物件（應為 `this.metre()`） |
| **D** | **`false true false`** ✔ | 先比類別再比 metre |
| E | 編譯失敗 | `permits Music` 漏掉 `Dance`，但 `Dance extends Art` → sealed 的子類別必須全部列出 |

**考點**：`sealed` / `non-sealed` / `final` 的 permits 規則、`equals` 的對稱性與 `getClass()` 比較、抽象方法。

---

## 第 40 題（第 1 次 第 40 題、第 2 次 第 5 題）

**題目**

```java
interface IFace {
    public void m1();
    public default void m2() {
        System.out.println("m2");
    }
    public static void m3() {
        System.out.println("m3");
    }
    private void m4() {
        System.out.println("m4");
    }
}
class MyC implements IFace {
    public void m1() {
        System.out.println("Hello");
    }
}
```

Which two method invocations execute?（選 2 個）

```java
A. new MyC().m2();
B. IFace.m2();
C. IFace myClassObj = new MyC();
   myClassObj.m4();
D. IFace myClassObj = new MyC();
   myClassObj.m3();
E. IFace.m3();
F. IFace.m4();
```

**答案：A、E**

**解析**

| 方法 | 種類 | 呼叫方式 |
|---|---|---|
| `m1()` | abstract | 只能透過實例 |
| `m2()` | `default` | 透過**實例**（會被繼承） |
| `m3()` | `static` | 只能透過**介面名稱** `IFace.m3()` |
| `m4()` | `private` | **只能在介面內部**呼叫 |

- **A**：`new MyC().m2();` → default 方法被繼承，透過實例呼叫 ✔
- **B**：`IFace.m2();` → default 方法不能用介面名稱呼叫 ✘
- **C**：`myClassObj.m4();` → private 方法不可從外部存取 ✘
- **D**：`myClassObj.m3();` → static 方法不可透過實例呼叫（編譯錯誤）✘
- **E**：`IFace.m3();` ✔
- **F**：`IFace.m4();` → private ✘

**考點**：Java 8/9 介面成員規則（`default`、`static`、`private`）、static 方法不被繼承。

---

## 第 41 題（第 1 次 第 41 題、第 2 次 第 6 題、第 3 次 第 36 題）

**題目**

```java
public interface Magic {
    int MAX_POWER = 10;
    public default boolean applyPower(int power) {
        return getRemainingPower(power) >= 0;
    }
    static int getRemainingPower(int power) {
        return MAX_POWER-power;
    }
    int cast();
    String toString();
}
public class Spell implements Magic {
    // Line n1
    private int power;
    public Spell(int power) {
        this.power = power;
    }
    public static void main(String[] args) {
        try {
            Spell spell = new Spell(6);
            int power = spell.cast();
            System.out.println("Power="+spell.power+" Overhead="+power);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
```

Which code fragment correctly implements the `Magic` interface when inserted at "Line n1"?

```java
A. @Override
   public int cast() {
       if (applyPower(power)) {
           return getRemainingPower(power);
       } else {
           throw new RuntimeException("Not enough power");
       }
   }
B. @Override
   public int cast() {
       if (applyPower(power)) {
           return getRemainingPower(power);
       } else {
           throw new RuntimeException("Not enough power");
       }
   }
   @Override
   public String toString() {
       return "Power="+this.power+" Overhead="+getRemainingPower(power);
   }
C. @Override
   public int cast() throws RuntimeException {
       if (applyPower(power)) {
           return Magic.getRemainingPower(power);
       } else {
           throw new RuntimeException("Not enough power");
       }
   }
D. @Override
   public int cast() throws Exception {
       if (applyPower(power)) {
           return Magic.getRemainingPower(power);
       } else {
           throw new Exception("Not enough power");
       }
   }
E. @Override
   public int cast() throws Exception {
       if (applyPower(power)) {
           return Magic.getRemainingPower(power);
       } else {
           throw new Exception("Not enough power");
       }
   }
   public String toString() {
       return "Power="+this.power+" Overhead="+Magic.getRemainingPower(power);
   }
```

**答案：C**

**解析**

三個關鍵規則：

1. **介面的 `static` 方法不會被實作類別繼承**，所以 `getRemainingPower(power)` 不能直接寫，必須寫 `Magic.getRemainingPower(power)`。
   → A、B 直接呼叫未限定的 `getRemainingPower` → **編譯失敗**。
2. **覆寫方法不能拋出更寬的 checked exception**。`Magic.cast()` 沒有 `throws`，實作就只能拋 unchecked（`RuntimeException` 可以）或更窄的例外。
   → D、E 的 `throws Exception` → **編譯失敗**。
3. `String toString();` 在介面中是抽象方法，但 `Object.toString()` 已提供 `public` 實作，實作類別**不一定要覆寫**。
   → C 不覆寫 `toString()` 也合法。

C 使用 `Magic.getRemainingPower(power)`，且只宣告 unchecked 的 `throws RuntimeException` → 合法 ✔

**考點**：介面 static 方法不被繼承、覆寫方法的例外限制、`toString()` 在介面中的宣告。

---

## 第 44 題（第 1 次 第 44 題、第 2 次 第 41 題）

**題目**

```java
public class App {
    private App app;
    public App() {
        this.app = null;
    }
    public App(App app) {
        this.app = app;
    }
    public String play() {
        return "playing";
    }
    public static void main(String[] args) {
        App a1 = new App();
        App a2 = new App(a1);
        App a3 = new App();
        a1 = null;
        System.out.println(a2.play());
    }
}
```

Which statement is true while the program prints the word "playing"?

```text
A. All of the App instances are eligible for garbage collection
B. None of the App instances are eligible for garbage collection
C. Only one instance of the App is eligible for garbage collection
D. Two instances of the App are eligible for garbage collection
```

**答案：B**

**解析**

建立三個物件與參考關係：

```text
a1 ──► instance#1          （a1 = null 後，仍被 instance#2.app 參考）
a2 ──► instance#2 ──► instance#1
a3 ──► instance#3
```

- `a1 = null` 只斷掉**區域變數** `a1` 的參考，但 `instance#2` 的欄位 `app` 仍指向 `instance#1`。
- `a2`、`a3` 仍存活，且 `instance#1` 被 `instance#2` 參考。

→ **三個物件都還可達（reachable）**，沒有任何一個符合 GC 條件 ✔

**考點**：可達性分析（reachability）、參考鍵結、GC 不會回收仍被參考的物件。

---

## 第 45 題（第 1 次 第 45 題、第 2 次 第 40 題、第 3 次 第 2 題）

**題目**：Which program prints `Bibbidi-Bobbidi-Boo` and `Abracadabra`?

```java
A. public class Wizard {
       record Spell(String cast) { }
       public static void main(String[] args) {
           Spell[] spells = {new Spell("Bibbidi-Bobbidi-Boo"),
                             new Spell("Abracadabra")};
           class Duel {
               void fight() {
                   for (Spell spell: spells) {
                       System.out.println(spell.cast());
                   }
               }
           }
           Duel duel = new Duel();
           duel.fight();
       }
   }
B. public class Wizard {
       record Spell(String cast) { }
       public static void main(String[] args) {
           Spell[] spells = null;
           class Duel {
               void fight() {
                   System.out.println(spells[0].cast());
                   System.out.println(spells[1].cast());
               }
           }
           spells = new Spell[2];
           spells[0] = new Spell("Bibbidi-Bobbidi-Boo");
           spells[1] = new Spell("Abracadabra");
           Duel duel = new Duel();
           duel.fight();
       }
   }
C. public class Wizard {
       class Spell {
           public String cast;
           public Spell (String cast) { this.cast = cast; }
       }
       private static Spell[] spells;
       public static void main(String[] args) {
           class Duel {
               void fight() {
                   for (Spell spell: spells) {
                       System.out.println(spell.cast);
                   }
               }
           }
           spells = new Spell[]{new Spell("Bibbidi-Bobbidi-Boo"),
                                new Spell("Abracadabra")};
           Duel duel = new Duel();
           duel.fight();
       }
   }
D. public class Wizard {
       class Spell {
           String cast;
           Spell (String cast) { this.cast = cast; }
       }
       private static Spell[] spells = {new Spell("Bibbidi-Bobbidi-Boo"),
                                        new Spell("Abracadabra")};
       public static void main(String[] args) {
           class Duel {
               void fight() {
                   for (Spell spell: spells) {
                       System.out.println(spell.cast);
                   }
               }
           }
           new Duel().fight();
       }
   }
```

**答案：A**

**解析**

- **A**：`spells` 是區域變數且初始化後不再改變 → **effectively final**，區域類別 `Duel` 可以擷取它。`record` 的 accessor 是 `cast()`，用 `spell.cast()` 正確 → 依序印出兩個字串 ✔（實測正確）
- **B**：`spells` 在宣告後又被重新指派（`spells = new Spell[2]`）→ **不是 effectively final**，區域類別不可擷取 → **編譯失敗**
- **C**：`Spell` 是**非 static 內部類別**，在 `static` 的 `main` 中 `new Spell(...)` 沒有外部實例 → **編譯失敗**（`non-static variable this cannot be referenced from a static context`）
- **D**：`static` 欄位初始化器中 `new Spell(...)` 同樣需要外部實例 → **編譯失敗**

**考點**：區域類別擷取變數必須 effectively final、內部類別（inner class）與 static 內容的關係、record 的 accessor 命名。

---

## 第 56 題（第 2 次 第 23 題）

**題目**

```java
public class Test {
    interface Animal {                 // 照片未拍到，依畫面重建
        default String play() {
            return "jump";
        }
    }
    static class Dog implements Animal {
        public String play() { return "fetch"; }
    }
    static class Cat implements Animal {
        public String play() { return "scratch"; }
    }
    private static void play(Animal a) {
        System.out.println(a.play());
    }
    private static void play(Dog d) {
        System.out.println(d.play());
    }
    public static void main(String[] args) {
        Animal a1 = new Dog();
        Dog a2 = new Dog();
        Animal a3 = new Cat();
        play(a1);
        play(a2);
        play(a3);
    }
}
```

What is the result?

```text
A. jump
   fetch
   scratch
B. jump
   fetch
   jump
C. fetch
   fetch
   jump
D. fetch
   fetch
   scratch
E. Compilation error
```

**答案：D**

**解析**

`play` 有兩個多載：`play(Animal)` 與 `play(Dog)`。**多載是在編譯期依「參數的靜態型別」決定**；**覆寫是在執行期依「實際物件型別」決定**。

| 呼叫 | 靜態型別 | 編譯期選到 | 執行期實際方法 | 輸出 |
|---|---|---|---|---|
| `play(a1)` | `Animal` | `play(Animal)` | `Dog.play()` | `fetch` |
| `play(a2)` | `Dog` | `play(Dog)`（較具體） | `Dog.play()` | `fetch` |
| `play(a3)` | `Animal` | `play(Animal)` | `Cat.play()` | `scratch` |

輸出：

```text
fetch
fetch
scratch
```

✔（實測相同）

**考點**：多載（編譯期、靜態型別）vs 覆寫（執行期、動態型別）、`default` 方法的覆寫。

---

## 第 62 題（第 2 次 第 36 題、第 3 次 第 34 題）

**題目**：Which code fragment prints the message `Hi!`?

```java
A. public class App {
       String txt = "Hi";
       static String message;
       public static void main(String... args) {
           App a = new App();
           var txt = "Hello";
           message = txt;
           a.greet('.');
           System.out.println(message);
       }
       String greet(char sign) {
           sign = '!';
           return message+sign;
       }
   }
B. public class App {
       String txt = "Hi";
       static String message;
       public static void main(String... args) {
           App a = new App();
           var message = a.txt;
           a.greet('.');
           System.out.println(message);
       }
       String greet(char sign) {
           sign = '!';
           return message+sign;
       }
   }
C. public class App {
       String txt = "Hi";
       static String message;
       public static void main(String... args) {
           App a = new App();
           a.txt = "Hello";
           var message = a.greet('.');
           System.out.println(message);
       }
       String greet(char sign) {
           sign = '!';
           return message+sign;
       }
   }
D. public class App {
       String txt = "Hi";
       static String message;
       public static void main(String... args) {
           App a = new App();
           message = a.txt;
           message = a.greet('.');
           System.out.println(message);
       }
       String greet(char sign) {
           sign = '!';
           return message+sign;
       }
   }
E. public class App {
       String txt = "Hi";
       static String message;
       public static void main(String... args) {
           App a = new App();
           message = a.txt;
           message = a.greet('.');
           System.out.println(message);
       }
       String greet(char sign) {
           var sign = '!';
           return message+sign;
       }
   }
```

**答案：D**

**解析**

重點：`greet` 的回傳值是 `message + sign`，而 `sign` 在方法內被改成 `'!'`。所以要印出 `Hi!`，必須**把回傳值存回 `message`**。

| 選項 | 追蹤 | 輸出 |
|---|---|---|
| A | `message = "Hello"`；`a.greet('.')` 回傳值被丟棄 | `Hello` |
| B | 區域變數 `message = a.txt = "Hi"`，`greet` 的回傳值被丟棄 | `Hi` |
| C | `a.txt = "Hello"`；`message` 仍是 `null` → `greet` 回傳 `"null!"` | `null!` |
| **D** | `message = "Hi"` → `message = greet('.')` = `"Hi" + '!'` = `"Hi!"` | **`Hi!`** ✔ |
| E | `var sign = '!'` 與參數 `sign` 同名 → **編譯失敗** | — |

**考點**：區域變數遮蔽（shadowing）、參數傳值、字串串接、`var` 不可與參數同名。

---

## 第 69 題（第 3 次 第 3 題）

**題目**

```java
class OClass {
    private int var1 = 100;
    public int var2 = 200;
    class IClass {
        int var3 = 300;
        public int var4 = 400;
        int m2(){
            return var2;
        }
    }
    public int m1(){
        return var1;
    }
}
// and the code fragment:
public class App {
    public static void main(String[] args) {
        OClass.IClass inner = new OClass().new IClass();
    }
}
```

Which three members can be accessed by the inner reference variable?（選 3 個）

```text
A. var4
B. m2
C. m1
D. var2
E. var3
F. var1
```

**答案：A、B、E**

**解析**

`inner` 的**編譯期型別**是 `OClass.IClass`，所以只能存取 `IClass` 本身宣告的成員：

| 成員 | 所屬 | 能否透過 `inner` 存取 |
|---|---|---|
| `var4` | `IClass`（public） | ✔ |
| `m2` | `IClass`（package-private，同套件） | ✔ |
| `var3` | `IClass`（package-private，同套件） | ✔ |
| `m1` | `OClass` | ✘（需 `OClass` 參考） |
| `var2` | `OClass` | ✘（需 `OClass` 參考） |
| `var1` | `OClass`（private） | ✘ |

**注意**：內部類別**可以**在自己的方法內直接使用外層的 `var2`（如 `m2()` 所示），但那是「內部類別內部」的存取，不是透過 `inner` 參考從外部存取。

**考點**：內部類別的編譯期型別、成員存取的對象、`private` 與套件存取權限。

---

## 第 71 題（第 3 次 第 35 題）

**題目**

```java
public class App {
    public String x = "01";
    public static void main(String[] args) {
        String x = "10";
        App t = new App();
        t.myMethod(x);
        System.out.print(x);
    }
    public void myMethod(String x) {
        x += "1";
        System.out.print(x);
        System.out.print(this.x);
    }
}
```

What is the result?

```text
A. 10110110
B. 1010110
C. 0110110
D. 1001110
E. 0111010
```

**答案：B**

**解析**

1. `main` 的區域變數 `x = "10"`
2. `t.myMethod(x)` → **傳值**：把 `"10"` 的參考複製給參數 `x`
3. 方法內 `x += "1"` → 參數 `x` 指向新字串 `"101"`（**不影響** `main` 的 `x`）
4. 印 `x` → `101`
5. 印 `this.x` → 物件的欄位 `x` → `01`
6. 回到 `main`，印區域變數 `x` → 仍是 `"10"`

輸出：`101` + `01` + `10` = **`1010110`** ✔（實測 `1010110`）

**考點**：Java 只有傳值（reference by value）、參數與區域變數／欄位的遮蔽關係、`String` 不可變。

---

## 第 72 題（第 3 次 第 37 題）

**題目**：Which two interfaces are considered to be functional interfaces?（選 2 個）

```java
A. @FunctionalInterface
   interface Magic {
       int MAX_POWER = 10;
       public default boolean applyPower(int power) {
           return getRemainingPower(power) >= 0;
       }
       static int getRemainingPower(int power) {
           return MAX_POWER-power;
       }
   }
B. @FunctionalInterface
   interface Magic {
       int MAX_POWER = 10;
       public default boolean applyPower(int power) {
           return getRemainingPower(power) >= 0;
       }
       int getRemainingPower(int power);
       int cast();
   }
C. interface Magic {
       int MAX_POWER = 10;
       public default void applyPower(int power) {
           return MAX_POWER = power;
       }
   }
D. interface Magic {
       int MAX_POWER = 10;
       public default boolean applyPower(int power) {
           return getRemainingPower(power) >= 0;
       }
       private int getRemainingPower(int power) {
           return MAX_POWER-power;
       }
       int cast();
   }
E. @FunctionalInterface
   interface Magic {
       int MAX_POWER = 10;
       public default boolean applyPower(int power) {
           return getRemainingPower(power) >= 0;
       }
       static int getRemainingPower(int power) {
           return MAX_POWER-power;
       }
       int cast();
   }
F. @FunctionalInterface
   interface Magic {
       private int MAX_POWER = 10;
       public default boolean applyPower(int power) {
           return getRemainingPower(power) >= 0;
       }
       int getRemainingPower(int power);
   }
```

**答案：D、E**

**解析**

函式介面（functional interface）的定義：**恰好一個抽象方法**（SAM）。`default`、`static`、`private` 方法都**不算**抽象方法。

| 選項 | 抽象方法數 | 結果 |
|---|---|---|
| A | 0 個（只有 default + static） | 不是函式介面；且 `@FunctionalInterface` 會**編譯失敗**（`Unexpected @FunctionalInterface annotation`，已實測） |
| B | 2 個（`getRemainingPower`、`cast`） | 不是；`@FunctionalInterface` 編譯失敗 |
| C | 0 個 | 不是；且 `void` 方法 `return MAX_POWER = power;` 回傳值 → **編譯失敗** |
| **D** | **1 個（`cast`）** | ✔ 是函式介面（private 方法不算抽象） |
| **E** | **1 個（`cast`）** | ✔ 是函式介面（static 方法不算抽象） |
| F | 2 個（`getRemainingPower`、`applyPower` 是 default → 實際 1 個抽象） | 但 `private int MAX_POWER` 在介面中不合法（介面欄位隱含 `public static final`）→ **編譯失敗** |

**考點**：SAM 定義、`@FunctionalInterface` 的編譯檢查、介面欄位隱含修飾子。

---

## 第 76 題（第 4 次 第 30 題）

**題目**：Which example correctly defines and implements an interface?

```java
A. public sealed interface Book permits Story, Art {
       default String title() { return "Winnie the Pooh" ; }
   }
   class Story implements Book {}
   class Art implements Book {}
B. non-sealed interface Book permits Story {
       String getTitle() { return "Winnie the Pooh" ; }
   }
   class Story implements Book {}
C. interface Book {
       public default int getCounter() { return 10; }
       public static void displayTitle();
       public void shareFile();
   }
   class Story implements Book {}
D. interface Book {
       public default int getCounter() { return 10; }
       public final void title() {
           System.out.println("Winnie the Pooh");
       }
   }
   class Story implements Book {}
E. interface Book {
       public static final String title = "Winnie the Pooh";
       private void readStory() {
           System.out.println(title);
       }
   }
   class Story implements Book {}
F. interface Book {
       public default int getCounter() { return 10; }
       public void title();
   }
   class Story implements Book {
       String title() { return "Winnie the Pooh" ; }
   }
```

**答案：E**

**解析**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | `sealed` 介面的實作類別必須宣告為 `final`、`sealed` 或 `non-sealed`；`Story`、`Art` 都沒有 |
| B | 編譯失敗 | `non-sealed` 必須有 `sealed` 的父型別；且介面方法 `String getTitle() {...}` 缺少 `default` |
| C | 編譯失敗 | `public static void displayTitle();` 是 static 方法卻沒有方法本體；且 `Story` 未實作 `shareFile()` |
| D | 編譯失敗 | 介面方法不可宣告 `final` |
| **E** | **正確** ✔ | 介面可含 `public static final` 常數與 `private` 方法（有本體）；`Story` 沒有抽象方法要實作 |
| F | 編譯失敗 | 實作方法 `title()` 是 package-private，弱於介面的 `public` → 存取權限不可縮小 |

**考點**：介面成員（常數、default、static、private）、sealed 子型別的宣告義務、覆寫時不可縮小存取權。

---

## 第 77 題（第 4 次 第 43 題）

**題目**

```java
public abstract class Animal {
    public static enum Type {
        DOG, CAT, FISH;
    }
    private Type type;
    public Animal(Type type) {
        this.type = type;
    }
    public void setType(Type type) {
        this.type = type;
    }
    public abstract String name();
    public String toString() {
        return name()+" "+type;
    }
    public static void main(String[] args) {
        Animal a = new Pet("Fido", Animal.Type.DOG);
        System.out.println(a);
    }
}
public interface Playable {
    default String play() {
        return "none";
    }
}
```

Which two alternative definitions of the class `Pet` enable the program to print `Fetch Fido DOG`?（選 2 個）

```java
A. public class Pet extends Animal implements Playable {
       private String name;
       public Pet(String name, Type type) { super(type); this.name = name; }
       public String name() { return play()+" "+name; }
       public String toString() { return "Fetch "+name+" "+super.type; }
   }
B. public class Pet extends Animal implements Playable {
       private String name;
       public Pet(String name, Type type) { super(type); this.name = name; }
       public String name() { return play()+" "+name; }
       public String play() { return ""; }
       public String toString() { return "Fetch"+super.toString(); }
   }
C. public class Pet extends Animal implements Playable {
       private String name;
       public Pet(String name, Type type) { this.name = name; super.setType(type); }
       public String name() { return play()+" "+name; }
       public String play() { return "Fetch"; }
   }
D. public class Pet extends Animal implements Playable {
       private String name;
       public Pet(String name, Type type) { super(type); this.name = name; }
       public String name() { return play()+" "+name; }
       String play() { return "Fetch"; }
   }
E. public class Pet extends Animal implements Playable {
       private String name;
       public Pet(String name, Type type) { super(type); this.name = name; }
       public String name() { return play()+" "+name; }
       public String play() { return "Fetch"; }
   }
```

**答案：B、E**

**解析**

`System.out.println(a)` 會呼叫 `Animal.toString()`（`Pet` 未覆寫時）：

```java
return name()+" "+type;   // type 是 Animal 的 private 欄位
```

要印出 `Fetch Fido DOG`，`name()` 必須回傳 `"Fetch Fido"`。

**B**：

- `name()` = `play() + " " + name`，而 `play()` 被覆寫成 `""` → `" Fido"`
- `toString()` 覆寫為 `"Fetch" + super.toString()`，`super.toString()` = `" Fido DOG"`
- 結果：`"Fetch Fido DOG"` ✔（實測正確）

**E**：

- `name()` = `"Fetch" + " " + "Fido"` = `"Fetch Fido"`
- 繼承 `Animal.toString()` → `"Fetch Fido DOG"` ✔（實測正確）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | `super.type`：`type` 在 `Animal` 中是 `private`，子類別不可存取 |
| **B** | **`Fetch Fido DOG`** ✔ | `play()` 回傳空字串 + `super.toString()` |
| C | 編譯失敗 | `Animal` 沒有無參數建構子，隱含的 `super()` 失敗 |
| D | 編譯失敗 | `String play()` 是 package-private，但 `Playable.play()` 是 `public` → 覆寫時縮小權限 |
| **E** | **`Fetch Fido DOG`** ✔ | `play()` 回傳 `"Fetch"`，`name()` 組合後由父類 `toString()` 輸出 |

**考點**：`private` 成員不被子類別繼承、`super.toString()`、覆寫不可縮小存取權、介面 default 方法的覆寫。

---

# 4. Record（1 題）

## 第 13 題（第 1 次 第 13 題、第 2 次 第 20 題、第 3 次 第 41 題）

**題目**：Which two record definitions are valid?（選 2 個）

```java
A. record Item(String name) {
       private static int maxId;
       private int id;
       { id = ++maxId; }
       public Item {
           if (name.length() < 3) {
               throw new IllegalArgumentException();
           }
       }
   }
B. record Item(String name){
       private static int maxId;
       private int id;
       public Item(String name){
           this.id = ++maxId;
           if (name.length() < 3){
               throw new IllegalArgumentException();
           }else{
               this.name = name;
           }
       }
   }
C. record Item(int id, String name){
       private static int maxId;
       public Item(int id, String name){
           this.id = ++maxId;
           if (name.length() < 3){
               throw new IllegalArgumentException();
           }else{
               this.name = name;
           }
       }
   }
D. record Item(int id, String name) {
       private static int maxId;
       { id = ++maxId; }
       public Item {
           if (name.length() < 3) {
               throw new IllegalArgumentException();
           }
       }
   }
E. record Item(int id, String name){
       private static int maxId;
       public Item {
           id = ++maxId;
           if (name.length() < 3){
               throw new IllegalArgumentException();
           }
       }
   }
F. record Item(int id, String name){
       private static int maxId;
       public Item {
           this.id = ++maxId;
           if (name.length() < 3){
               throw new IllegalArgumentException();
           }else{
               this.name = name;
           }
       }
   }
```

**答案：C、E**

**解析**

Record 的三條硬規則：

1. **不能宣告實例欄位**（只能有 `static` 欄位）；元件（components）本身就是欄位。
2. **不能有實例初始化區塊**（instance initializer）。
3. **精簡建構子（compact constructor）內不可用 `this.x = ...` 指派**，必須直接寫參數名稱（`id = ...`），編譯器會在最後自動把參數值指派給欄位。

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | `private int id;` 是實例欄位，record 不允許；且有實例初始化區塊 |
| B | 編譯失敗 | 有 `private int id;` 實例欄位 |
| **C** | **合法** ✔ | 標準（canonical）建構子，`id`、`name` 兩個元件都被指派；`maxId` 是 static 欄位（允許） |
| D | 編譯失敗 | 有實例初始化區塊 `{ id = ++maxId; }` |
| **E** | **合法** ✔ | 精簡建構子直接寫 `id = ++maxId;`（不是 `this.id`），`name` 未賦值時自動指派參數值 |
| F | 編譯失敗 | 精簡建構子使用 `this.id`／`this.name` → `cannot assign a value to final variable`（已實測） |

**考點**：record 的元件、精簡建構子語法、record 禁止實例欄位與實例初始化區塊。

---

# 5. Enum（3 題）

## 第 26 題（第 1 次 第 26 題、第 2 次 第 30 題、第 3 次 第 15 題）

**題目**

```java
public class Weather {
    public enum Forecast {
        SUNNY, CLOUDY, RAINY;
        public String toString() {
            return this.name().toLowerCase();
        }
        static String getForecast(String name) {
            try {
                Forecast f = Forecast.valueOf(name);
                return (f.ordinal() % 2 != 0)
                    ? f.name().toLowerCase() : f.name().toUpperCase();
            }catch(Exception e){
                return "SNOWY";
            }
        }
    }
    public static void main(String[] args) {
        for (int i = 0; i < Forecast.values().length; i++){
            String name = Forecast.values()[i].toString();
            System.out.print(Forecast.getForecast(name));
        }
    }
}
```

What is the result?

```text
A. SUNNYCLOUDYRAINY
B. SNOWYSNOWYSNOWY
C. SUNNYcouldyRAINY
D. snowysnowysnowy
E. sunnyCLOUDYrainy
F. sunnycouldyrainy
```

**答案：B**

**解析**

關鍵陷阱：`toString()` 被覆寫成**小寫**，而 `valueOf(String)` 只接受**常數的原始名稱（大寫）**。

1. `Forecast.SUNNY.toString()` → `"sunny"`
2. `Forecast.valueOf("sunny")` → 找不到名為 `sunny` 的常數 → 丟出 `IllegalArgumentException`
3. `catch (Exception e)` → 回傳 `"SNOWY"`

三次迴圈（SUNNY、CLOUDY、RAINY）全部都是小寫 → 全部例外出錯 → 印出 `SNOWYSNOWYSNOWY` ✔（實測相同）

**考點**：`Enum.valueOf` 與 `toString()` 的差異（`valueOf` 只看 `name()`）、`ordinal()`、例外處理。

---

## 第 27 題（第 1 次 第 27 題、第 2 次 第 29 題、第 3 次 第 14 題）

**題目**

```java
public class Test {
    public static void main(String[] value) {
        List<String> list = List.of("Hello","and","WELCOME");
        String result = list.stream()
            .collect(Collectors.mapping(v->Transformer.transform(v),
                     Collectors.joining(" ")));
        System.out.println(result);
    }
}
```

Which implementation of the `Transformer` enum produces the result `"Hello AND welcome"`?

```java
A. import java.util.function.UnaryOperator;
   public enum Transformer {
       UPPER((String value) -> value.toUpperCase()),
       LOWER((String value) -> value.toLowerCase());
       private final UnaryOperator<String> operator;
       public Transformer(UnaryOperator<String> operator) {
           this.operator = operator;
       }
       public static String transform(String value) {
           return Transformer.valueOf(
               value.toUpperCase().equals(value) ? "UPPER" : "LOWER").operator.apply(value);
       }
   }
B. import java.util.function.UnaryOperator;
   public enum Transformer {
       UPPER((String value) -> value.toUpperCase()),
       LOWER((String value) -> value.toLowerCase());
       private final UnaryOperator<String> operator;
       Transformer(UnaryOperator<String> operator) {
           this.operator = operator;
       }
       public static String transform(String value) {
           return Transformer.valueOf(
               value.toUpperCase().equals(value) ? "UPPER" : "LOWER").operator.apply(value);
       }
   }
C. import java.util.function.UnaryOperator;
   public enum Transformer {
       UPPER((String value) -> value.toUpperCase()),
       LOWER((String value) -> value.toLowerCase());
       private final UnaryOperator<String> operator;
       public Transformer(UnaryOperator<String> operator) {
           this.operator = operator;
       }
       public static String transform(String value) {
           return switch(value) {
               case String v when v.toUpperCase().equals(value) -> LOWER.operator.apply(value);
               case String v when v.toLowerCase().equals(value) -> UPPER.operator.apply(value);
               default -> value;
           };
       }
   }
D. import java.util.function.UnaryOperator;
   public enum Transformer {
       UPPER((String value) -> value.toUpperCase()),
       LOWER((String value) -> value.toLowerCase());
       private final UnaryOperator<String> operator;
       Transformer(UnaryOperator<String> operator) {
           this.operator = operator;
       }
       public static String transform(String value) {
           return switch(value) {
               case String v when v.toUpperCase().equals(value) -> LOWER.operator.apply(value);
               case String v when v.toLowerCase().equals(value) -> UPPER.operator.apply(value);
               default -> value;
           };
       }
   }
E. import java.util.function.UnaryOperator;
   public enum Transformer {
       UPPER((String value) -> value.toUpperCase()),
       LOWER((String value) -> value.toLowerCase());
       private final UnaryOperator<String> operator;
       public Transformer(UnaryOperator<String> operator) {
           this.operator = operator;
       }
       public static String transform(String value) {
           return Transformer.valueOf(
               value.toUpperCase().equals(value) ? "U" : "L").operator.apply(value);
       }
       public String toString() {
           return switch(this) {
               case UPPER -> "U";
               case LOWER -> "L";
           };
       }
   }
F. import java.util.function.UnaryOperator;
   public enum Transformer {
       UPPER((String value) -> value.toUpperCase()),
       LOWER((String value) -> value.toLowerCase());
       private final UnaryOperator<String> operator;
       Transformer(UnaryOperator<String> operator) {
           this.operator = operator;
       }
       public static String transform(String value) {
           return Transformer.valueOf(
               value.toUpperCase().equals(value) ? "U" : "L").operator.apply(value);
       }
       public String toString() {
           return switch(this) {
               case UPPER -> "U";
               case LOWER -> "L";
           };
       }
   }
```

**答案：D**

**解析**

需求轉換規則（要得到 `Hello AND welcome`）：

| 輸入 | 期望輸出 | 規則 |
|---|---|---|
| `Hello` | `Hello` | 混合大小寫 → **不變** |
| `and` | `AND` | 全小寫 → **轉大寫** |
| `WELCOME` | `welcome` | 全大寫 → **轉小寫** |

D 的 `switch`：

```java
case String v when v.toUpperCase().equals(value) -> LOWER.operator.apply(value);  // 全大寫→小寫
case String v when v.toLowerCase().equals(value) -> UPPER.operator.apply(value);  // 全小寫→大寫
default -> value;                                                                // 其他→不變
```

- `"Hello"`：`"HELLO" != "Hello"`、`"hello" != "Hello"` → `default` → `Hello` ✔
- `"and"`：第二個 guard 成立 → `UPPER` → `AND` ✔
- `"WELCOME"`：第一個 guard 成立 → `LOWER` → `welcome` ✔

結果 `Hello AND welcome` ✔

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | enum 建構子不可為 `public` |
| B | 邏輯錯誤 | 規則相反：全大寫 → `UPPER`（不變）、其他 → `LOWER` → `hello and welcome` |
| C | 編譯失敗 | enum 建構子不可為 `public`（與 D 的差別只在建構子修飾子） |
| **D** | **正確** ✔ | 建構子為 package-private，轉換規則正確 |
| E | 執行時例外 | `valueOf("U")`／`valueOf("L")` 找不到常數 → `IllegalArgumentException` |
| F | 執行時例外 | 同 E（`toString()` 不影響 `valueOf`） |

**考點**：enum 建構子只能是 private／package-private、`valueOf` 只看常數名稱、switch 的 `when` guard、`Collectors.mapping` + `joining`。

---

## 第 38 題（第 1 次 第 38 題）

**題目**

```java
import java.util.*;
public enum Listing {
    LIST(new ArrayList<>()),
    SET(new HashSet<>());
    private Collection<String> values;
    Listing(Collection<String> values){
        this.values = values;
    }
    public Collection<String> setValues(String... values){
        for (String value: values) {
            this.values.add(value);
        }
        return this.values;
    }
}
// and the following code fragment:
String[] letters = {"A","B","B","A"};
StringBuilder txt = new StringBuilder();
for(int i = 0; i < Listing.values().length; i++) {
    Iterator<String> iter = Listing.values()[i].setValues(letters).iterator();
    while(iter.hasNext()) {
        String value = iter.next();
        txt.append(value);
    }
    System.out.print(txt);
}
```

What is the result?

```text
A. ABBA
B. ABBAAB
C. AB
D. ABB
E. ABBAABBAAB
F. ABBAABBA
```

**答案：E**

**解析**

enum 常數是**單例**，其中的 `values` 集合在整個 JVM 生命週期只有一份，`setValues` 每次呼叫都會**累加**元素。

1. `i = 0` → `LIST`（`ArrayList`）
   - `setValues("A","B","B","A")` → `[A, B, B, A]`（List 允許重複）
   - `txt` 累加 → `ABBA`，印出 `ABBA`
2. `i = 1` → `SET`（`HashSet`）
   - `setValues("A","B","B","A")` → `[A, B]`（重複被去除）
   - `txt` **繼續累加** → `ABBA` + `AB` = `ABBAAB`，印出 `ABBAAB`

因為 `System.out.print(txt)` 在迴圈內印的是**整份累積內容**，所以螢幕輸出為：

```text
ABBAABBAAB
```

（第一次 `ABBA`，第二次 `ABBAAB`，串接後為 `ABBAABBAAB`）✔（實測 `ABBAABBAAB`）

**考點**：enum 常數是單例（狀態共享）、`List` vs `Set` 的重複處理、`StringBuilder` 累積輸出。

---

# 6. 樣式比對與 switch（4 題）

## 第 35 題（第 1 次 第 35 題、第 2 次 第 10 題、第 3 次 第 26 題）

**題目**

```java
class A {public void mA() {System.out.println("mA");}}
class B extends A {public void mB() {System.out.println("mB");}}
class C extends B {public void mC() {System.out.println("mC");}}
public class App {
    public static void main(String[] args) {
        A bobj = new B();
        A cobj = new C();
        if (cobj instanceof B v) {
            v.mB();
            if (v instanceof C v1) {
                v1.mC();
            }
        } else {
            cobj.mA();
        }
    }
}
```

What is the result?

```text
A. mB
B. mB
   mC
C. mA
D. mB
   mA
```

**答案：B**

**解析**

1. `cobj` 實際型別是 `C`，`C extends B` → `cobj instanceof B` 為 `true`，`v` 綁定為 `cobj`（編譯期型別 `B`）
2. `v.mB()` → 印 `mB`
3. `v instanceof C` → 實際物件是 `C` → `true`，`v1` 綁定（型別 `C`）
4. `v1.mC()` → 印 `mC`

輸出：

```text
mB
mC
```

✔（實測相同）

**考點**：`instanceof` 樣式變數的綁定與作用域（flow scoping）、繼承鏈。

---

## 第 36 題（第 1 次 第 36 題、第 2 次 第 47 題、第 3 次 第 42 題、第 4 次 第 20 題）

**題目**

```java
public record URL(Address<String, Integer> address, String value) { }
public record Address<V,P>(V host , P port) { }
// and the class:
public class Show {
    public static void main(String[] args) {
        URL url = new URL(new Address<>("localhost", Integer.valueOf(8080)),"hello");
        // Line n1
    }
}
```

Which code fragment prints `http://localhost:8080/hello` when inserted at Line n1?

```java
A. if (url instanceof URL(Address(var value, var port), var text) || !(port < 1024)) {
       System.out.println("http://"+value+":"+port+"/"+text);
   }
B. if (url instanceof URL(Address<>(var value, var port), var text) && port > 1024) {
       System.out.println("http://"+value+":"+port+"/"+text);
   }
C. if (url instanceof URL(Address<String,Integer> address, var text) && address.port > 1024) {
       System.out.println("http://"+address.value+":"+address.port+"/"+text);
   }
D. if (url instanceof URL(Address(var value, Integer port), var text) && port > 1024) {
       System.out.println("http://"+value+":"+port+"/"+text);
   }
```

**答案：D**

**解析**

Record pattern 的語法：`型別(元件樣式, ...)`，元件順序必須與 record 宣告一致。

**D**：

```java
url instanceof URL(Address(var value, Integer port), var text) && port > 1024
```

- 外層 `URL` 的兩個元件：`address`、`value` → 樣式 `Address(...)`、`var text`
- 內層 `Address` 的兩個元件：`host`、`port` → `var value`（推斷為 `String`）、`Integer port`
- `&&` 右邊可直接使用左邊綁定的 `port`（flow scoping 成立）
- `8080 > 1024` → true → 印 `http://localhost:8080/hello` ✔（實測相同）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | 使用 `||` 時，左側樣式變數在右側**不保證已指派** → `port` 無法使用（flow scoping 不成立） |
| B | 編譯失敗 | record pattern 不能使用鑽石 `Address<>(...)` |
| C | 編譯失敗 | `address.port`：record 的存取子是 `port()`，且欄位是 private；`address.value` 同理 |
| **D** | **正確** ✔ | 巢狀 record pattern + `&&` 的 flow scoping |

**考點**：巢狀 record pattern、flow scoping（`&&` 可用、`||` 不可用）、record accessor。

---

## 第 37 題（第 1 次 第 37 題、第 3 次 第 44 題）

**題目**

Method `test` should accept any `Object` as an argument and return a `String`.

- If the argument is `null` or not an instance of `LocalDate`, it should return `"Wrong Value"`.
- If the argument represents a date in the future, it should return `"Future"`.
- If the argument represents a date in the past, it should return `"Past"`.
- If the argument represents current date, it should return `"Present"`.

Which code fragment correctly implements this scenario?

```java
A. public String test(Object obj) {
       return switch(obj) {
           default -> "Wrong Value";
           case null -> "Wrong Value";
           case LocalDate date when date.isBefore(LocalDate.now()) -> "Past";
           case LocalDate date when date.isAfter(LocalDate.now()) -> "Future";
           case LocalDate date when date.equals(LocalDate.now()) -> "Present";
       };
   }
B. public String test(Object obj) {
       return switch(obj) {
           case LocalDate date when date.isBefore(LocalDate.now()) -> "Past";
           case LocalDate date when date.isAfter(LocalDate.now()) -> "Future";
           case LocalDate date when !date.isBefore(LocalDate.now())
                && !date.isAfter(LocalDate.now()) -> "Present";
           case !(LocalDate date) -> "Wrong Value";
           case null -> "Wrong Value";
       };
   }
C. public String test(Object obj) {
       return switch(obj) {
           case null -> "Wrong Value";
           case LocalDate date when date.isBefore(LocalDate.now()) -> "Past";
           case LocalDate date when date.isAfter(LocalDate.now()) -> "Future";
           case LocalDate date when date.equals(LocalDate.now()) -> "Present";
           case Object o -> "Wrong Value";
       };
   }
D. public String test(Object obj) {
       return switch(obj) {
           case LocalDate date when date.isBefore(LocalDate.now()) -> "Past";
           case LocalDate date when !date.isBefore(LocalDate.now()) -> "Future";
           case LocalDate date when date.equals(LocalDate.now()) -> "Present";
           default -> "Wrong Value";
       };
   }
```

**答案：C**

**解析**

**C** 的順序與條件都正確：

1. `case null` → `"Wrong Value"`（Java 21 的 pattern switch 必須明寫 `case null`，否則 selector 為 `null` 會拋 `NullPointerException`）
2. `isBefore(now)` → `"Past"`
3. `isAfter(now)` → `"Future"`
4. `equals(now)` → `"Present"`
5. `case Object o` → 其餘型別 → `"Wrong Value"`（`Object` 樣式讓 switch 無條件窮盡）

✔（實測：`Wrong Value Wrong Value Present Past Future`）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | `default` 放在前面會**支配（dominate）**後面的 `case null` 與 `case LocalDate` → `this case label is dominated by a preceding case label`（已實測） |
| B | 編譯失敗 | 不支援否定樣式 `case !(LocalDate date)` |
| **C** | **正確** ✔ | `case null` 必須寫，且 `case Object o` 保證窮盡 |
| D | 語意錯誤 | 第二個 guard `!date.isBefore(now)` 對「今天」也成立 → 今天會回傳 `"Future"`，永遠到不了 `"Present"` |

**考點**：Java 21 pattern switch、`case null`、`when` guard、`default` 的支配規則、窮盡性（exhaustiveness）。

---

## 第 39 題（第 1 次 第 39 題、第 2 次 第 49 題）

**題目**

```java
public sealed interface Consumable permits Food, Drink { }
public record Food(String name) implements Consumable { }
public record Drink(String name) implements Consumable { }
// and a method:
public String test(Consumable consumable) {
    String result = "None";
    if (consumable instanceof Food(var name)) {
        result = "Eat "+name;
    } else if (consumable instanceof Drink(var name)) {
        result = "Drink "+name;
    }
    return result;
}
```

Which alternative code fragment implements behaviors that are equivalent to the given method example?

```java
A. public String test(Consumable consumable) {
       return switch (consumable) {
           case Food(String name) -> "Eat "+name;
           case Drink(String name) -> "Drink "+name;
           default -> "None";
       };
   }
B. public String test(Consumable consumable) {
       return switch (consumable) {
           default -> "None";
           case Food(String name) -> "Eat "+name;
           case Drink(String name) -> "Drink "+name;
       };
   }
C. public String test(Consumable consumable) {
       return switch (consumable) {
           case Food(String name) -> "Eat "+name;
           case default -> "Drink "+name;
           case null -> "None";
       };
   }
D. public String test(Consumable consumable) {
       String result = "None";
       switch (consumable) {
           case Food(String name): {
               result = "Eat "+name;
               break;
           }
           case Drink(String name): {
               result = "Drink " + name;
           }
       }
       return result;
   }
E. public String test(Consumable consumable) {
       return switch (consumable) {
           case null -> "None";
           case Food(String name) -> "Eat "+name;
           case Drink(String name) -> "Drink "+name;
       };
   }
F. public String test(Consumable consumable) {
       String result = switch (consumable) {
           case Food(String name): {
               yield "Eat " + name;
           }
           case Drink(String name): {
               yield "Drink " + name;
           }
           case null -> "None";
       };
       return result;
   }
```

**答案：E**

**解析**

原方法對 `null` 的處理：兩個 `instanceof` 都是 `false` → 回傳 `"None"`。

**E**：

```java
case null -> "None";                  // 明確處理 null
case Food(String name) -> "Eat "+name;
case Drink(String name) -> "Drink "+name;
```

`Consumable` 是 `sealed` 且只 permits `Food`、`Drink` → switch **窮盡**，不需要 `default`。行為與原方法完全一致 ✔（實測：`None / Eat pizza / Drink tea`）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 行為不同 | 沒有 `case null` → selector 為 `null` 時丟 `NullPointerException`，不會回傳 `"None"` |
| B | 行為不同 | `default` 放前面會支配後面的 case → 編譯失敗；且同樣沒有 `case null` |
| C | 編譯失敗 | `case default` 語法錯誤；`default` 也不能夾在中間 |
| D | 行為不同 | 沒有 `case null`（NPE）；`Drink` 分支沒有 `break`（雖然在 switch 最後，但不影響）；主要問題是 null |
| **E** | **完全等價** ✔ | 明寫 `case null`，且 sealed 型別窮盡 |
| F | 編譯失敗 | 同一個 switch 區塊混用 `case X:` 與 `case X ->` |

**考點**：pattern switch 的 `case null`（不寫會 NPE）、sealed 型別的窮盡性、箭頭與冒號標籤不可混用。

---

# 7. 例外處理（3 題）

## 第 14 題（第 1 次 第 14 題、第 2 次 第 46 題、第 3 次 第 31 題）

**題目**

```java
public class ContentException extends RuntimeException {
    public ContentException(String message) {
        super(message);
    }
}
public class ClosureException extends Exception {
    public ClosureException(String message) {
        super(message);
    }
}
public class TinCan implements AutoCloseable {
    private boolean problem;
    public TinCan(boolean problem) {
        this.problem = problem;
        System.out.println("opened");
    }
    public void checkContent(boolean anyGood) {
        if (!anyGood) {
            throw new ContentException("Not good");
        }
    }
    @Override
    public void close() throws ClosureException {
        if(problem) {
            throw new ClosureException("Problem closing the tin can");
        }
        System.out.println("closed");
    }
    public static void main(String[] args) {
        try (TinCan tc = new TinCan(true)) {
            tc.checkContent(false);
        } catch (ContentException | ClosureException e) {
            System.out.println(e);
        }
    }
}
```

Which two statements are true about this example?（選 2 個）

```text
A. The program will behave the same if the catch clause is replaced with catch (Exception e).
B. It prints:
   opened
   ContentException: Not good
   Problem closing the tin can
C. A no-arg constructor must be added to the ClosureException.
D. It prints:
   opened
   ContentException: Not good
   Problem closing the tin can
   closed
E. It prints:
   opened
   ContentException: Not good
F. A no-arg constructor must be added to the ContentException.
G. It prints:
   opened
   ContentException: Not good
   closed
H. A throws ContentException clause must be added to the checkContent method.
```

**答案：A、E**

**解析**

try-with-resources 的例外規則：

1. 先執行 `new TinCan(true)` → 印 `opened`
2. `checkContent(false)` 丟出 `ContentException`（unchecked）→ 這是**主要例外（primary exception）**
3. 離開 try 區塊時自動呼叫 `close()`；`close()` 又丟出 `ClosureException`
4. 當 try 區塊已有主要例外時，`close()` 的例外會被**加入為 suppressed（被抑制的例外）**，**不會被印出**
5. `catch (ContentException | ClosureException e)` 接到 `ContentException` → 印 `e` → `ContentException: Not good`

實際輸出：

```text
opened
ContentException: Not good
```

✔（實測相同；`close()` 的 `ClosureException` 被抑制）

**各選項檢討**

| 選項 | 正確？ | 原因 |
|---|---|---|
| **A** | ✔ | `catch (Exception e)` 也能接住兩者，行為相同 |
| B | ✘ | suppressed 例外不會自動印出 |
| C | ✘ | `ClosureException` 已有 `(String)` 建構子，編譯器不會要求無參數建構子（只有序列化等特殊情況才需要） |
| D | ✘ | `close()` 丟例外，不會執行 `System.out.println("closed")` |
| **E** | ✔ | 正確輸出 |
| F | ✘ | `ContentException` 不需要無參數建構子 |
| G | ✘ | `close()` 有問題，不會印 `closed` |
| H | ✘ | `ContentException` 是 `RuntimeException`（unchecked），不需要 `throws` |

**考點**：try-with-resources 的例外抑制（`getSuppressed()`）、unchecked vs checked、multi-catch。

---

## 第 15 題（第 1 次 第 15 題、第 3 次 第 32 題）

**題目**

```java
public class Test{
    public static void main(String[] args) {
        class ZeroValueException extends RuntimeException {
            ZeroValueException(String message) {
                super(message);
            }
            ZeroValueException(String message, Throwable cause) {
                super(message, cause);
            }
        }
        int nums[] = {1,0,1};
        int sum = 0;
        try {
            try {
                for (int v: nums) {
                    if (v != 0) {
                        sum += v;
                    }else{
                        throw new ZeroValueException("Zero value");
                    }
                }
            }catch(Exception e) {
                throw new ZeroValueException("Error",e);
            }
        }catch(Exception e) {
            System.out.print("Caught " + e.getMessage());
        }
        System.out.println(sum);
    }
}
```

What is the result?

```text
A. Caught Error1
B. Caught Zero value1
C. Caught Error2
D. Caught Zero value2
```

**答案：A**

**解析**

1. `v = 1` → `sum = 1`
2. `v = 0` → 丟出 `ZeroValueException("Zero value")`
3. 內層 `catch(Exception e)` 接到後，**包裝**成 `new ZeroValueException("Error", e)` 再丟出
4. 外層 `catch` 接到的是包裝後的例外，`getMessage()` 是 **`"Error"`**（不是 `"Zero value"`）
5. 印 `Caught Error`
6. `sum` 仍為 `1`（迴圈在 `v=0` 就中斷，後面的 `1` 沒加到）
7. 印 `1`

輸出：`Caught Error1` ✔（實測 `Caught Error1`）

**考點**：例外包裝（exception wrapping / chaining）、`getMessage()` 只取最外層訊息、`catch` 的執行順序。

---

## 第 65 題（第 2 次 第 45 題）

**題目**

```java
import java.io.*;
import java.nio.file.*;
public class Test {
    public static void main(String[] args) {
        Test t = new Test();
        t.read("acme.txt");
    }
    public void read(String fileName) {
        String data = null;
        try {
            Path path = Path.of(fileName);
            openFile(path);
            readData(path);
        }catch(NoSuchFileException e){
            System.out.println(e.getMessage());
        }catch(Exception e){
            System.out.println("Something went wrong");
            return;
        }finally{
            System.out.println("Cleanup");
        }
        System.out.println("Data acquired "+data);
    }
    public void openFile(Path path) throws IOException {
        if (!Files.exists(path)){
            throw new NoSuchFileException("File not found");
        }
    }
    public String readData(Path path) throws IOException {
        return Files.lines(path)
            .collect(StringBuilder::new,
                     StringBuilder::append,
                     StringBuilder::append)
            .toString();
    }
}
```

Assume：`acme.txt` 存在、含兩行 `ONE` / `TWO`，但**讀取第二行時儲存裝置損壞而失敗**。

What is the result?

```text
A. Something went wrong
B. File not found
   Cleanup
   Data acquired null
C. Something went wrong
   Cleanup
   Data acquired null
D. Something went wrong
   Cleanup
E. Data acquired ONE
   Something went wrong
   Cleanup
F. Something went wrong
   Cleanup
   Data acquired ONE
G. Data acquired ONE
   Something went wrong
```

**答案：D**

**解析**

1. `openFile(path)`：檔案存在 → 不丟 `NoSuchFileException`
2. `readData(path)`：讀到第二行時發生 I/O 錯誤 → 丟 `IOException`
3. `catch(NoSuchFileException)` 不匹配 → 進入 `catch(Exception e)`
4. 印 `Something went wrong`，然後 **`return`**
5. `finally` **一定執行** → 印 `Cleanup`
6. 因為已 `return`，`System.out.println("Data acquired "+data)` **不會執行**

輸出：

```text
Something went wrong
Cleanup
```

✔

**考點**：`finally` 一定執行、`catch` 中的 `return` 會跳過後續程式、`NoSuchFileException` 與一般 `IOException` 的分類。

---

# 8. 集合與陣列（7 題）

## 第 6 題（第 1 次 第 6 題、第 2 次 第 12 題、第 3 次 第 49 題）

**題目**

```java
Integer[] values = {-4,-2,12,7};
Arrays.sort(values, (v1, v2) -> v1.toString().compareTo(v2.toString()) );
System.out.println(Arrays.toString(values));
```

What is the result?

```text
A. [7, 12, -4, -2]
B. [12, 7, -4, -2]
C. [-2, -4, 12, 7]
D. [-4, -2, 7, 12]
E. [-4, -2, 12, 7]
F. [7, 12, -2, -4]
G. [12, 7, -2, -4]
```

**答案：C**

**解析**

比較器是**字串**的字典順序（ASCII）：

- `"-4"` vs `"-2"`：`'-'` 相同，`'4'(52)` > `'2'(50)` → `"-2" < "-4"`
- 負號 `'-'`(45) < 數字 `'1'`(49) < `'7'`(55) → 所有負數字串都排在正數前
- `"12"` < `"7"`（`'1' < '7'`）

排序結果：`"-2" < "-4" < "12" < "7"` → `[-2, -4, 12, 7]` ✔（實測 `[-2, -4, 12, 7]`）

**考點**：`Comparator` 自訂排序、字串字典順序與數值順序的差異。

---

## 第 7 題（第 1 次 第 7 題）

**題目**

```java
List<String> list1 = new ArrayList<>();
list1.add("A");
list1.add("B");
List<String> list2 = Collections.unmodifiableList(list1);
list1.add("C"); // Line n1
System.out.println(list1);
System.out.println(list2); // Line n2
```

What is the result?

```text
A. [A, B, C]
   [A, B, C]
B. On the line marked "Line n1", an exception is thrown at run time.
C. [A, B, C]
   [A, B]
D. [A, B, C]
   followed by an exception thrown at line marked "Line n2".
```

**答案：A**

**解析**

`Collections.unmodifiableList(list1)` 回傳的是**視圖（view）**，不是複本：

- 它禁止**透過 `list2`** 修改（`add`／`remove` 會丟 `UnsupportedOperationException`）
- 但底層 `list1` 的修改**仍然反映**在 `list2` 上

因此 `list1.add("C")` 成功，兩個參考看到的都是 `[A, B, C]` ✔（實測相同）

**考點**：unmodifiable 視圖 vs 不可變複本（`List.copyOf`）、視圖的即時反映。

---

## 第 8 題（第 1 次 第 8 題、第 3 次 第 48 題）

**題目**：Which code fragment prints `Milk Honey Chocolate`?

```java
A. Set<String> foods = new HashSet<>(Arrays.asList("Milk","Honey","Chocolate"));
   foods.forEach(f->System.out.print(f+" "));
B. List<String> foods = new ArrayList<>(Arrays.asList("Chocolate","Milk","Honey"));
   Collections.sort(foods, (f1,f2) -> f2.length()-f1.length());
   foods.forEach(f->System.out.print(f+" "));
C. List<String> foods = new ArrayList<>(Arrays.asList("Chocolate","Milk","Honey"));
   foods.sort((f1,f2) -> f1.length()-f2.length());
   foods.forEach(f->System.out.print(f+" "));
D. Set<String> foods = new HashSet<>(Arrays.asList("Chocolate","Milk","Honey"));
   Collections.sort(foods.stream().toList(),(f1,f2) -> f1.length()-f2.length());
   foods.forEach(f->System.out.print(f+" "));
E. Set<String> foods = new HashSet<>(Arrays.asList("Chocolate","Milk","Honey"));
   Collections.sort(new ArrayList<String>(foods),(f1,f2) -> f1.length()-f2.length());
   foods.forEach(f->System.out.print(f+" "));
```

**答案：C**

**解析**

長度：`Milk` = 4、`Honey` = 5、`Chocolate` = 9。要得到 `Milk Honey Chocolate` 就是**依長度遞增排序**。

- **C**：`foods.sort((f1,f2) -> f1.length()-f2.length())` → 4, 5, 9 → `Milk Honey Chocolate` ✔（實測相同）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 順序不可預測 | `HashSet` 不保證順序 |
| B | `Chocolate Honey Milk` | `f2.length()-f1.length()` 是**遞減** |
| **C** | **`Milk Honey Chocolate`** ✔ | 遞增排序 |
| D | 執行時例外 | `stream().toList()` 回傳不可變清單，`Collections.sort` 丟 `UnsupportedOperationException`；且就算排序也不影響 `foods` |
| E | 順序不可預測 | 排序的是**複本**，`foods`（HashSet）本身沒被排序 |

**考點**：`List.sort` vs `Collections.sort`、Comparator 正負號、`HashSet` 無序、不可變清單。

---

## 第 9 題（第 1 次 第 9 題、第 2 次 第 13 題、第 3 次 第 46 題）

**題目**

```java
String[] pets = {"Fido","Rex","Felix","Boo"};
```

Which two code fragments print the following text?（選 2 個）

```text
Fido
Fudge
Felix
Boo
```

```java
A. Set<String> petsSet = Set.of(pets);
   petsSet.remove("Rex");
   petsSet.add("Fudge");
   petsSet.stream().forEach(p->System.out.println(p));
B. List<String> petsList = Arrays.asList(pets);
   pets[petsList.indexOf("Rex")] = "Fudge";
   petsList.stream().forEach(p->System.out.println(p));
C. Set<String> petsSet = new HashSet(Arrays.asList(pets));
   petsSet.remove("Rex");
   petsSet.add("Fudge");
   petsSet.stream().forEach(p->System.out.println(p));
D. List<String> petsList = Arrays.asList(pets);
   petsList.removeIf(p->p.equals("Rex"));
   petsList.add(1,"Fudge");
   petsList.stream().forEach(p->System.out.println(p));
E. List<String> petsList = Arrays.asList(pets);
   petsList.stream()
       .map(p-> p.equals("Rex") ? "Fudge" : p)
       .forEach(p->System.out.println(p));
```

**答案：B、E**

**解析**

- **B**：`Arrays.asList(pets)` 是**陣列的視圖**（backed by array）。`pets[indexOf("Rex")] = "Fudge"` 直接改陣列 → 清單同步看到 `Fido, Fudge, Felix, Boo`，且保留原本順序 ✔（實測相同）
- **E**：用 `map` 把 `"Rex"` 換成 `"Fudge"`，其餘不變，順序保留 ✔（實測相同）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 執行時例外 | `Set.of` 是不可變集合，`remove`／`add` 丟 `UnsupportedOperationException` |
| **B** | **正確** ✔ | 陣列視圖，改陣列即反映 |
| C | 順序不可預測 | `HashSet` 不保證輸出順序 |
| D | 執行時例外 | `Arrays.asList` 是**固定大小**（陣列視圖），`removeIf` 就會丟 `UnsupportedOperationException`（已實測），後面的 `add` 更不可能成功 |
| **E** | **正確** ✔ | `map` 替換元素，順序不變 |

**考點**：`Arrays.asList` 的視圖特性（可 `set`、不可 `add`/`remove`）、`Set.of` 不可變、`HashSet` 無序。

---

## 第 53 題（第 2 次 第 11 題）

**題目**

```java
String[] primes = {"2","3","5","7","11"};
Deque<Integer> numbers = new ArrayDeque<>();
for (int i = 0; i < primes.length; i++) {
    if (i != ((numbers.peekLast() != null) ? numbers.peekLast() : 0)) {
        numbers.offerFirst(Integer.parseInt(primes[i]));
    }else{
        numbers.offerLast(Integer.parseInt(primes[i]));
    }
}
for (Integer number : numbers) {
    System.out.print(number);
}
```

What is the result?

```text
A. 117325
B. 117532
C. 253117
D. 273511
E. 235711
F. 112735
```

**答案：A**

**解析**

`peekLast()` 取尾端元素（空時為 `null`）。逐一追蹤：

| i | 尾端 peekLast | `i != peekLast` | 動作 | Deque（front → back） |
|---|---|---|---|---|
| 0 | `null → 0` | `0 != 0` false | `offerLast(2)` | `[2]` |
| 1 | 2 | `1 != 2` true | `offerFirst(3)` | `[3, 2]` |
| 2 | 2 | `2 != 2` false | `offerLast(5)` | `[3, 2, 5]` |
| 3 | 5 | `3 != 5` true | `offerFirst(7)` | `[7, 3, 2, 5]` |
| 4 | 5 | `4 != 5` true | `offerFirst(11)` | `[11, 7, 3, 2, 5]` |

迭代 `ArrayDeque` 的順序是 front → back：`11 7 3 2 5` → `117325` ✔（實測 `117325`）

**考點**：`Deque` 的 `offerFirst` / `offerLast` / `peekLast`、`ArrayDeque` 迭代順序。

---

## 第 54 題（第 2 次 第 14 題）

**題目**

```java
Map<String, BigDecimal> priceList = new HashMap<>();
priceList.put("Cake",BigDecimal.valueOf(3.99));
priceList.put("Cookie",BigDecimal.valueOf(1.99));
priceList.put("Candy",BigDecimal.valueOf(2.99));
priceList.put("Cookie",BigDecimal.valueOf(4.99));
priceList.entrySet().stream()
    .sorted((e1, e2)->e1.getValue().compareTo(e2.getValue()))
    .forEach(e->System.out.print(e+" "));
```

What is the result?

```text
A. Candy=2.99 Cake=3.99 Cookie=1.99
B. Cookie=1.99 Cake=3.99 Candy=2.99
C. Cookie=4.99 Cake=3.99 Candy=2.99
D. Exception is thrown at run time.
E. Cake=3.99 Cookie=1.99 Candy=2.99
F. Candy=2.99 Cake=3.99 Cookie=4.99
G. Cake=3.99 Cookie=4.99 Candy=2.99
```

**答案：F**

**解析**

1. `Map` 的 key 唯一：第二次 `put("Cookie", 4.99)` 會**覆蓋**舊值 → `Cookie = 4.99`
2. 最終資料：`Cake=3.99`、`Cookie=4.99`、`Candy=2.99`
3. 依 `value` 遞增排序：`2.99 < 3.99 < 4.99`
4. 輸出：`Candy=2.99 Cake=3.99 Cookie=4.99 ` ✔（實測相同）

**考點**：`Map.put` 覆蓋語意、`Map.Entry` 的 `toString` 格式、`BigDecimal.compareTo`。

---

## 第 73 題（第 3 次 第 47 題）

**題目**：Which code fragment prints `Felix Boo Fido Rex`?

```java
A. SequencedCollection<String> pets = new TreeSet<>();
   pets.addFirst("Rex");
   pets.addFirst("Felix");
   pets.addFirst("Fido");
   pets.addFirst("Boo");
   pets.addFirst("Felix");
   for (String pet : pets) { System.out.print(pet+" "); }
B. SequencedCollection<String> pets = new LinkedHashSet<>();
   pets.addFirst("Rex");
   pets.addFirst("Felix");
   pets.addFirst("Fido");
   pets.addFirst("Boo");
   pets.addFirst("Felix");
   for (String pet : pets) { System.out.print(pet+" "); }
C. SequencedCollection<String> pets = new TreeSet<>();
   pets.add("Rex");
   pets.add("Felix");
   pets.add("Fido");
   pets.add("Boo");
   pets.add("Felix");
   for (String pet : pets) { System.out.print(pet+" "); }
D. SequencedCollection<String> pets = new LinkedHashSet<>();
   pets.addFirst("Rex");
   pets.addFirst("Felix");
   pets.addFirst("Fido");
   pets.addFirst("Boo");
   for (String pet : pets) { System.out.print(pet+" "); }
```

**答案：B**

**解析**

`LinkedHashSet` 實作了 `SequencedSet`（Java 21），其 `addFirst` 的行為：**若元素已存在，會把它移到最前面**（不會新增重複）。

追蹤 B：

| 動作 | 內容（front → back） |
|---|---|
| `addFirst("Rex")` | `[Rex]` |
| `addFirst("Felix")` | `[Felix, Rex]` |
| `addFirst("Fido")` | `[Fido, Felix, Rex]` |
| `addFirst("Boo")` | `[Boo, Fido, Felix, Rex]` |
| `addFirst("Felix")` | `[Felix, Boo, Fido, Rex]`（已存在 → 移到最前） |

輸出 `Felix Boo Fido Rex` ✔（實測相同）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 執行時例外 | `TreeSet` 是排序集合，不支援 `addFirst` → `UnsupportedOperationException` |
| **B** | **正確** ✔ | `LinkedHashSet.addFirst` 對已存在元素會移到最前 |
| C | `Boo Felix Fido Rex` | `TreeSet` 依自然順序排序 |
| D | `Boo Fido Felix Rex` | 少了第二次 `addFirst("Felix")` |

**考點**：Java 21 `SequencedCollection` / `SequencedSet`、`LinkedHashSet` 的插入順序、`TreeSet` 不支援位置操作。

---

# 9. Stream API（10 題）

## 第 4 題（第 1 次 第 4 題、第 2 次 第 33 題、第 4 次 第 50 題）

**題目**

```java
List<Integer> l1 = List.of(1, 3, 5, 7, 9);
List<Integer> l2 = List.of(2, 4, 6, 8);
List<List<Integer>> l3 = List.of(l1, l2);
//line n1
System.out.println(l4);
```

Which code fragment at line n1 enables `l4` to contain numbers greater than 5 from the lists `l1` and `l2`?

```java
A. List<Integer> l4 = l3.stream()
       .map(x -> x.stream())
       .filter(y -> y > 5)
       .collect(Collectors.toList());
B. List<Integer> l4 = l3.stream()
       .flatMap(x -> x.stream()
       .filter(y -> y > 5).toList());
C. List<Integer> l4 = l3.stream()
       .filter(y -> y > 5).collect();
D. List<Integer> l4 = l3.stream()
       .flatMap(x -> x.stream())
       .filter(y -> y > 5)
       .collect(Collectors.toList());
```

**答案：D**

**解析**

`l3` 是 `Stream<List<Integer>>`，要「攤平」成 `Stream<Integer>` 必須用 `flatMap`，**先攤平再過濾**。

**D**：

```java
l3.stream()                 // Stream<List<Integer>>
  .flatMap(x -> x.stream()) // Stream<Integer>：1,3,5,7,9,2,4,6,8
  .filter(y -> y > 5)       // 7,9,6,8
  .collect(Collectors.toList());
```

結果 `[7, 9, 6, 8]` ✔（實測相同）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 編譯失敗 | `map` 後是 `Stream<Stream<Integer>>`，`filter(y -> y > 5)` 的 `y` 是 `Stream`，不能與 `int` 比較 |
| B | 編譯失敗 | `flatMap` 要求回傳 `Stream`，但 `.toList()` 回傳 `List` → 型別不符 |
| C | 編譯失敗 | `filter` 作用在 `List<Integer>` 上（`y > 5` 不合法）；且 `collect()` 無參數不存在 |
| **D** | **正確** ✔ | `flatMap` 攤平後過濾 |

**考點**：`map` vs `flatMap`、`Stream<List<T>>` 的攤平、`Collectors.toList()`。

---

## 第 5 題（第 1 次 第 5 題）

**題目**

```java
DoubleStream values = DoubleStream.generate(()-> ThreadLocalRandom.current().nextDouble());
double value = values.sorted().filter(d->d > 0.4 && d < 0.5)
                     .peek(d-> d++).findFirst().getAsDouble();
System.out.println(value);
```

What is the result?

```text
A. The biggest double value between 0.4 and 0.5
B. The biggest double value between 1.4 and 1.5
C. An error is thrown at run time.
D. The smallest double value between 1.4 and 1.5
E. The smallest double value between 0.4 and 0.5
```

**答案：C**

**解析**

`DoubleStream.generate(...)` 產生的是**無限 Stream**，而 `sorted()` 是**有狀態（stateful）的中介操作**：它必須**先讀完所有元素**才能排序。

- 對無限 Stream 呼叫 `sorted()` → **永遠不會完成**（實務上會一直卡住，最後可能因記憶體耗盡丟出 `OutOfMemoryError`）
- 後面的 `filter`、`findFirst` 根本沒有機會執行
- 因此**不會**回傳任何介於 0.4～0.5 的值 → A、B、D、E 都不可能

官方答案為 **C（執行時發生錯誤）**。嚴格來說這題的行為是「不會終止」；考試把「無法完成而失敗」歸類為 runtime error。

> 另外，`peek(d -> d++)` 本身是合法的（lambda 參數可以遞增，且 `d++` 是 statement expression，可符合 `void` 的 `DoubleConsumer`），所以**不是**編譯錯誤。

**考點**：無限 Stream、`sorted()` 需要全部元素、短路操作（`findFirst`）無法拯救無限來源。

---

## 第 48 題（第 1 次 第 48 題）

**題目**

```java
Logger logger = Logger.getLogger("Test");
Stream<String> s1 = Stream.of("A", "B", "C", "B");
Stream<String> s2 = Stream.of("A", "D", "E");
Stream.concat(s1,s2).parallel().distinct().sorted()
      .forEach(e->logger.log(Level.INFO,e));
```

What is the result?

```text
A. ADEABCB
B. ABCDE
C. ABBCDE // the order of elements is unpredictable
D. ABBCDE
E. ADEABCB // the order of elements is unpredictable
F. ABCDE // the order of elements is unpredictable
```

**答案：F**

**解析**

1. `concat` → `A, B, C, B, A, D, E`
2. `distinct()` → `A, B, C, D, E`
3. `sorted()` → `A, B, C, D, E`
4. `parallel()` + `forEach(...)` → **`forEach` 不保證順序**（若要保持順序必須用 `forEachOrdered`）

所以**內容**一定是 `ABCDE`，但**列印順序不可預測** → F ✔

**考點**：`distinct` + `sorted` 的結果內容、parallel stream 的 `forEach`（unordered）vs `forEachOrdered`。

---

## 第 49 題（第 1 次 第 49 題、第 2 次 第 25 題、第 3 次 第 13 題）

**題目**

```java
Stream<String> melody1 = Stream.of("E","G","A");
Stream<String> melody2 = Stream.of("D","C","F");
var value = Stream.concat(melody1, melody2).reduce((a,b)->b+a).get();
System.out.println(value);
```

What is the result?

```text
A. DCFEGA
B. AGEFCD
C. FCDAGE
D. EGADCF
```

**答案：C**

**解析**

`concat` 後的順序：`E, G, A, D, C, F`。

`reduce((a,b) -> b + a)` 是**把新元素接在前面**：

| 步驟 | a（累計） | b（新元素） | b + a |
|---|---|---|---|
| 1 | E | G | GE |
| 2 | GE | A | AGE |
| 3 | AGE | D | DAGE |
| 4 | DAGE | C | CDAGE |
| 5 | CDAGE | F | **FCDAGE** |

輸出 `FCDAGE` ✔

**考點**：`reduce` 的累加器方向、`concat` 的順序。

---

## 第 50 題（第 1 次 第 50 題、第 2 次 第 27 題、第 3 次 第 11 題）

**題目**

```java
var list = List.of("Table", "Chair");
var result = list.parallelStream()
    .reduce(list.parallelStream()
        .reduce((l, p)-> l+p)
        .get(),
        (n,m) -> n+m, String::concat);
System.out.print(result);
```

What is the result?

```text
A. TableChairTableChair
B. TableChairTableChairTableChair
C. TableChairTableTableChairChair
D. An exception is thrown at run time.
E. TableChairTableChairChair
```

**答案：C**

**解析**

1. 內層 `reduce((l,p)->l+p)` → `"TableChair"`
2. 外層是**三參數 reduce**：`reduce(identity, accumulator, combiner)`
   - `identity = "TableChair"`
   - 對 **parallel stream** 而言，identity 會**套用到每一個分割區（partition）**，不是只加一次
3. 兩個元素被切成兩個分割區：
   - 分割區 1：`"TableChair" + "Table"` = `"TableChairTable"`
   - 分割區 2：`"TableChair" + "Chair"` = `"TableChairChair"`
   - `combiner`（`String::concat`）合併 → `"TableChairTable" + "TableChairChair"`

結果：`TableChairTableTableChairChair` ✔（JDK 21 實測連續 5 次皆相同）

**重點**：parallel reduce 的 identity 必須是**真正的單位元素**（例如 `""`、`0`），否則結果會隨分割區數量而不同。

**考點**：三參數 `reduce`、parallel stream 的分割與 combiner、identity 非單位元素的陷阱。

---

## 第 57 題（第 2 次 第 26 題、第 3 次 第 12 題）

**題目**

```java
List<String> elements =
    Arrays.asList("car", "truck", "car",
                  "bicycle", "car", "truck", "motorcycle");
Map<String, Long> map =
    elements.stream()
        .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
map.keySet().stream().sorted().forEach(k->System.out.print(map.get(k)));
```

What is the result?

```text
A. 123
B. 1312
C. 1213
D. 213
E. 3211
F. 2131
G. 1123
H. 312
I. 321
J. 7777
```

**答案：B**

**解析**

`groupingBy(identity, counting())` 統計次數：

| key | 次數 |
|---|---|
| bicycle | 1 |
| car | 3 |
| motorcycle | 1 |
| truck | 2 |

`map.keySet().stream().sorted()` 依字母排序：`bicycle, car, motorcycle, truck`

依序印出次數：`1`、`3`、`1`、`2` → **`1312`** ✔（實測 `1312`）

**考點**：`groupingBy` + `counting`、key 的排序、輸出的是「次數」不是 key。

---

## 第 58 題（第 2 次 第 28 題）

**題目**

```java
List<Integer> listOfNumbers = List.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
```

Which code fragment produces a sum value that is different from the other code fragments?

```java
A. int sum = listOfNumbers.parallelStream().reduce(5, Integer::sum);
B. int sum = listOfNumbers.stream().reduce(0, Integer::sum) + 5;
C. int sum = listOfNumbers.parallelStream().reduce(0, Integer::sum) + 5 ;
D. int sum = listOfNumbers.stream().reduce(5, (a, b) -> a+ b);
E. int sum = listOfNumbers.parallelStream().reduce((m, n) -> m + n).orElse(5) + 5;
```

**答案：A**

**解析**

1～10 的總和 = **55**。

| 選項 | 計算 | 結果 |
|---|---|---|
| **A** | parallel reduce，identity `5` 會**套用到每個分割區** → `55 + 5×分割區數` | **≠ 60**（例如 65、75…） |
| B | sequential，identity `0` 只加一次 → `55 + 5` | `60` |
| C | parallel，但 identity `0` 是單位元素 → `55 + 5` | `60` |
| D | sequential 三參數 reduce，identity `5` 只加一次 → `5 + 55` | `60` |
| E | 無 identity 的 parallel reduce → `55`，`orElse` 不觸發 → `55 + 5` | `60` |

只有 **A** 會不同 ✔

**考點**：parallel reduce 的 identity 必須是單位元素、`reduce` 三種多載的差異。

---

## 第 60 題（第 2 次 第 32 題、第 3 次 第 9 題）

**題目**

```java
Stream.of(3,6,9,12,15,18,21,24,27)
    .takeWhile(s -> s % 3 == 0)
    .dropWhile(s -> s % 2 == 0)
    .limit(3).forEach(s -> System.out.print(s + " "));
```

What is the result?

```text
A. 3 9 15
B. 3 9 15 21
C. 3 6 9
D. 15 21 27
```

**答案：C**

**解析**

1. `takeWhile(s -> s % 3 == 0)`：全部元素都能被 3 整除 → **全部保留**（3～27）
2. `dropWhile(s -> s % 2 == 0)`：從頭開始丟棄偶數，遇到第一個奇數就**停止丟棄**並保留之後所有元素
   - `3` 是奇數 → 立刻停止丟棄 → 序列仍是 `3,6,9,12,...`
3. `limit(3)` → `3, 6, 9`

輸出 `3 6 9 ` ✔（實測 `3 6 9`）

**陷阱**：`dropWhile` 只會丟棄**開頭**符合條件的元素，不是過濾全部偶數。若誤以為是 `filter`，會得到 `3 9 15`（選項 A）。

**考點**：`takeWhile` / `dropWhile` 的「前綴」語意（Java 9+）、`limit`。

---

## 第 70 題（第 3 次 第 10 題）

**題目**

```java
class Product {
    String name; double price;
    Product(String s, double d) {
        this.name = s;
        this.price = d;
    }
}
class ElectricProduct extends Product {
    ElectricProduct(String name, double price) {
        super(name, price);
    }
}
// and the code fragment:
List<Product> p = List.of(
    new ElectricProduct("CellPhone",100),
    new ElectricProduct("ToyCar",90),
    new ElectricProduct("Motor",200),
    new ElectricProduct("Fan",300)
);
DoubleSummaryStatistics sts = p.stream()
    .filter(a -> a instanceof ElectricProduct)
    .collect(Collectors.summarizingDouble(a -> a.price));
String s1 = p.stream().filter(a -> a instanceof Product)
    .collect(Collectors.mapping(p2 -> p2.name, Collectors.joining(",")));
System.out.println(sts.getMax());
System.out.println(s1);
```

What is the result?

```text
A. 100.00 CellPhone,ToyCar,Motor,Fan
B. 100.00
   CellPhone,ToyCar
C. 300.00
   CellPhone,ToyCar,Motor,Fan
D. 300.00
   CellPhone,ToyCar
```

**答案：C**

**解析**

1. 四個元素**都是** `ElectricProduct`（`ElectricProduct extends Product`）→ `filter(a -> a instanceof ElectricProduct)` 全部通過
2. `summarizingDouble(a -> a.price)` 的 `getMax()` → `300.0`
3. 第二個 `filter(a -> a instanceof Product)` 也全部通過 → 依序 join 名稱 → `CellPhone,ToyCar,Motor,Fan`

輸出：

```text
300.0
CellPhone,ToyCar,Motor,Fan
```

✔（實測 `300.0`；題目選項寫 `300.00`，重點是**最大值為 300**，格式差異不影響答案）

**考點**：`instanceof` 對子類別的判斷、`summarizingDouble`、`Collectors.mapping` + `joining`。

---

## 第 74 題（第 3 次 第 50 題）

**題目**

```java
public class TextGenerator {
    static int counter = 0;
    static int leftLimit = 'a';
    static int rightLimit = 'z';
    public static void main(String[] args) {
        // Line n1
    }
}
```

Which code fragment, when inserted into the `main` method at "Line n1", generates a text comprising random characters of 10000 characters in length?

```java
A. StringBuilder result = new StringBuilder();
   ThreadLocalRandom.current()
       .ints(leftLimit,rightLimit+1)
       .limit(10000)
       .parallel()
       .forEach(c->result.append((char)c));
B. String result = ThreadLocalRandom.current()
       .ints(leftLimit,rightLimit+1)
       .limit(10000)
       .parallel()
       .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
       .toString();
C. String result = ThreadLocalRandom.current()
       .ints(leftLimit,rightLimit+1)
       .takeWhile(c->counter++ < 10000)
       .parallel()
       .mapToObj(c-> String.valueOf((char)c))
       .collect(Collectors.joining());
D. StringBuilder result = new StringBuilder();
   ThreadLocalRandom.current()
       .ints(leftLimit,rightLimit+1)
       .takeWhile(c->result.length() != 10000)
       .parallel()
       .forEach(c->result.append((char)c));
```

**答案：B**

**解析**

**B** 是唯一**保證**產生「剛好 10000 個字元」且**執行緒安全**的寫法：

```java
String result = ThreadLocalRandom.current()
    .ints(leftLimit, rightLimit+1)   // 產生 'a'~'z' 的 int
    .limit(10000)                    // 只要 10000 個
    .parallel()
    .collect(StringBuilder::new,     // 每個分割區各自建立 StringBuilder
             StringBuilder::appendCodePoint,
             StringBuilder::append)  // 最後合併
    .toString();
```

- `IntStream.collect(supplier, ObjIntConsumer, BiConsumer)` 的 accumulator 是 `StringBuilder::appendCodePoint`（`(StringBuilder, int)` → 相容 `void`）
- 每個執行緒使用自己的 `StringBuilder`，最後由 combiner 合併 → **沒有競態**
- 長度必為 10000 ✔（實測 `10000`）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | 長度不保證 | `parallel().forEach` 同時對**同一個** `StringBuilder` 做 `append` → **競態條件**，長度可能少於 10000 |
| **B** | **正確** ✔ | 用 `collect` 的 supplier/accumulator/combiner，執行緒安全 |
| C | 不保證 | `ThreadLocalRandom.ints()` 是**無序（unordered）** Stream；`takeWhile` 對無序 Stream 的行為**不確定**（可只取任意子集），不能保證 10000 個 |
| D | 不保證 | 同 A 的競態；且 `takeWhile` 讀取 `result.length()` 在平行下也不可靠 |

**考點**：parallel stream 的可變性（mutable reduction 必須用 `collect`）、`StringBuilder` 非執行緒安全、`takeWhile` 在 unordered stream 的語意。

---

# 10. 並行與執行緒（8 題）

## 第 10 題（第 1 次 第 10 題）

**題目**：Which statements is true regarding how to achieve a thread-safe iteration through a collection?

```text
A. Use the synchronized iterator provided by copy-on-write collections.
B. Implement your own synchronized iterator method to work with synchronized collections.
C. Use the synchronized iterator provided by immutable collections.
D. Implement your own synchronized iterator method to work with copy-on-write collections.
E. Implement your own synchronized iterator method to work with immutable collections.
F. Use the synchronized iterator provided by synchronized collections.
```

**答案：A**

**解析**

- **Copy-on-Write（COW）集合**（如 `CopyOnWriteArrayList`、`CopyOnWriteArraySet`）的迭代器是**快照（snapshot）迭代器**：
  - 建立迭代器時取得當下陣列的快照
  - 迭代期間**不會**拋出 `ConcurrentModificationException`
  - 多執行緒同時迭代是安全的，**不需要額外同步**
- 相對地：
  - `synchronized` 集合的迭代器**不是**執行緒安全的，必須自行在 `synchronized` 區塊中迭代（否則可能 `ConcurrentModificationException`）
  - immutable 集合雖然本身不可變，但題目說的「synchronized iterator provided by ...」並不存在這種機制

因此 A 正確 ✔

**考點**：COW 的快照迭代器、`Collections.synchronizedList` 的迭代仍需手動同步、immutable 集合。

---

## 第 11 題（第 1 次 第 11 題、第 2 次 第 24 題）

**題目**：Which statement is true?

```text
A. The lock() method returns a boolean indicator immediately if it has managed to acquire the lock;
   otherwise, it waits for the lock acquisition.
B. The lock() method returns a boolean indicator immediately regardless of whether it has or has not
   managed to acquire the lock.
C. The tryLock() method returns a boolean indicator immediately if it has managed to acquire the lock;
   otherwise, it waits for the lock acquisition.
D. The tryLock() method returns a boolean indicator immediately regardless of whether it has or has
   not managed to acquire the lock.
```

**答案：D**

**解析**

`java.util.concurrent.locks.Lock` 的兩個方法：

| 方法 | 回傳 | 行為 |
|---|---|---|
| `lock()` | `void` | **阻塞**直到取得鎖為止（沒有回傳值） |
| `tryLock()` | `boolean` | **立刻**回傳 `true`（取得）或 `false`（沒取得），**不等待** |

- A、B 都說 `lock()` 回傳 boolean → 錯（`lock()` 是 `void`）
- C 說 `tryLock()` 失敗會等待 → 錯（那是 `lock()` 的行為；`tryLock(timeout, unit)` 才會等待）
- **D** 正確 ✔

**考點**：`Lock.lock()` vs `tryLock()`、`tryLock(long, TimeUnit)` 的差異。

---

## 第 17 題（第 1 次 第 17 題、第 2 次 第 18 題）

**題目**：Which two statements are true about virtual threads?（選 2 個）

```text
A. Virtual threads can handle both Callable and Runnable objects.
B. The Thread.setDaemon() method is used to configure a virtual thread as daemon.
C. Virtual threads do not run code on the Platform threads.
D. Virtual threads are instances of the java.lang.Thread class.
E. The Thread.setPriority() method is automatically triggered to lower the priority of the Virtual
   thread when it is waiting for the I/O operations to complete.
F. The Executors.newWorkStealingPool() method is used to improve virtual thread performance by
   reusing threads in a thread pool.
```

**答案：A、D**

**解析**

| 選項 | 正確？ | 說明 |
|---|---|---|
| **A** | ✔ | `Thread.ofVirtual().start(Runnable)`；`Executors.newVirtualThreadPerTaskExecutor().submit(Callable)` 也支援 |
| B | ✘ | 虛擬執行緒**永遠是 daemon**；呼叫 `setDaemon()` 會丟 `UnsupportedOperationException` |
| C | ✘ | 虛擬執行緒由 **carrier thread（平台執行緒）** 實際執行，只是掛起時會釋放 carrier |
| **D** | ✔ | 虛擬執行緒是 `java.lang.Thread` 的實例（`Thread.isVirtual()` 可判斷） |
| E | ✘ | 虛擬執行緒的優先權**沒有作用**，也不會自動調整 |
| F | ✘ | `newWorkStealingPool()` 是一般平台執行緒池，與虛擬執行緒無關；虛擬執行緒不靠池化重用 |

**考點**：Virtual Threads（JEP 444）特性、`isVirtual()`、daemon 與 priority 的限制。

---

## 第 18 題（第 1 次 第 18 題、第 3 次 第 20 題）

**題目**：Which statement is true about thread life cycle?

```text
A. The Thread.interrupt() method puts a thread into a timed waiting state.
B. The Thread.interrupt() method puts a thread into a waiting state.
C. Thread.interrupt() method puts a thread into a blocked state.
D. The Thread.interrupt() method does not change the state of a thread.
E. The Thread.interrupt() method puts a thread into a terminated state.
F. The Thread.interrupt() method puts a thread into a runnable state.
```

**答案：D**

**解析**

`Thread.interrupt()` 只是**設定中斷旗標（interrupt status）**，它本身**不會改變執行緒狀態**：

- 若執行緒正處於 `sleep`／`wait`／`join` 等會拋 `InterruptedException` 的方法中，會**喚醒**它並拋出例外（此時狀態才由被中斷的方法改變）
- 若執行緒正在執行，旗標被設定，執行緒**繼續執行**，狀態不變
- 若執行緒已終止，呼叫 `interrupt()` 沒有任何效果

因此「`interrupt()` 不會改變執行緒狀態」→ **D** ✔

**考點**：`Thread.State`、interrupt 旗標、`isInterrupted()` vs `Thread.interrupted()`。

---

## 第 19 題（第 1 次 第 19 題、第 2 次 第 19 題、第 3 次 第 18 題）

**題目**：Which statement is true?

```text
A. A thread in waiting state must handle InterruptedException.
B. After the timed wait expires, the waited thread moves to the terminated state.
C. IllegalStateException is thrown if a thread in waiting state is moved back to runnable.
D. A thread in waiting state consumes CPU cycles.
```

**答案：A**

**解析**

| 選項 | 正確？ | 說明 |
|---|---|---|
| **A** | ✔ | 進入 waiting／timed waiting 的常見方法（`wait()`、`join()`、`sleep()`）都會拋 **checked** 的 `InterruptedException`，必須處理 |
| B | ✘ | timed wait 到期後回到 **RUNNABLE**，不是 TERMINATED |
| C | ✘ | 不會有這種 `IllegalStateException`；狀態轉換由 JVM 控制 |
| D | ✘ | waiting 狀態**不消耗 CPU**（這正是等待的意義） |

**考點**：執行緒狀態轉換（WAITING / TIMED_WAITING / RUNNABLE / TERMINATED）、`InterruptedException` 為 checked。

---

## 第 55 題（第 2 次 第 17 題、第 3 次 第 19 題）

**題目**

```java
StringBuilder txt = new StringBuilder();
Runnable r = () -> {
    for (int i = 0; i < 5; i++) {
        synchronized(txt){
            txt.append(i);
        }
    }
};
Thread t1 = new Thread(r,"T1");
Thread t2 = new Thread(r,"T2");
ExecutorService es = Executors.newFixedThreadPool(2);
Future f1 = es.submit(t1);
Future f2 = es.submit(t2);
es.shutdown();
try {
    f1.get();
    f2.get();
    System.out.println(txt);
} catch (Exception e) {
    System.out.println("error");
}
```

What is the result?

```text
A. Nothing is printed.
B. All integers from 0 to 4 are printed.
C. The word "error" is printed.
D. Some of the integers in the range 0 to 4 are printed.
E. Some of the integers in the range 0 to 4 are printed twice in stochastic order.
F. All integers from 0 to 4 are printed twice.
G. Some of the integers in the range 0 to 4 are printed twice.
H. All integers from 0 to 4 are printed twice in stochastic order.
I. All integers from 0 to 4 are printed in stochastic order.
J. Some of the integers in the range 0 to 4 are printed in stochastic order.
```

**答案：H**

**解析**

- 同一個 `Runnable r` 被**兩個執行緒**執行 → 每個執行緒都會跑 `0..4` 一次 → 總共 **10 個字元**
- `synchronized(txt)` 保證 `append` 不會交錯損壞，但**兩個執行緒誰先誰後**沒有保證
- `f1.get()`、`f2.get()` 等待兩個工作完成後才印 → **一定會印完**
- 因此：`0~4` 每個數字**各出現兩次**，但**順序不確定（stochastic）**

實測（可能每次不同，例如）：

```text
0123401234
```

→ **H** ✔

**考點**：`synchronized` 只保證互斥不保證順序、`Future.get()` 的等待、Runnable 共用實例。

---

## 第 68 題（第 3 次 第 1 題）

**題目**

```java
ReentrantReadWriteLock rwl = new ReentrantReadWriteLock();
Lock rl = rwl.readLock();
Lock wl = rwl.writeLock();
String result = null;
try {
    rl.lock();
    if (wl.tryLock()) {
        result = "locked";
    }
} catch(Exception e) {
    result = "broken";
} finally {
    rl.unlock();
    if (rwl.isWriteLocked()) {
        wl.unlock();
        result = "unlocked";
    }
}
System.out.println(result);
```

What is the result?

```text
A. locked
B. broken
C. null
D. key
E. unlocked
```

**答案：C**

**解析**

1. `rl.lock()` 取得**讀鎖**
2. `wl.tryLock()`：目前執行緒持有讀鎖，而 `ReentrantReadWriteLock` **不支援讀鎖升級為寫鎖**（同一執行緒也不行）→ `tryLock()` 回傳 **`false`**
3. 因此 `result` 仍為 `null`
4. `finally`：先 `rl.unlock()` 釋放讀鎖
5. `rwl.isWriteLocked()` → 沒有人持有寫鎖 → `false` → **不進入 if**
6. 印出 `null` ✔（實測 `null`）

**重點**：`tryLock()` 失敗不會拋例外，所以 `catch` 也不會執行（不是 `"broken"`）。

**考點**：`ReentrantReadWriteLock` 的讀寫互斥、鎖升級（upgrade）不支援、`tryLock()` 回傳值。

---

## 第 75 題（第 4 次 第 14 題）

**題目**

```java
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Level;
import java.util.logging.Logger;
class Test {
    volatile int x = 1;
    AtomicInteger y = new AtomicInteger(1);
    public static void main(String[] args) {
        Logger logger = Logger.getLogger("p6.Test");
        Test t = new Test();
        Runnable r1 = () -> {
            while (t.x < 3) {
                logger.log(Level.INFO,"Thread One :"+String.valueOf(t.x));
                t.x++;
            }
        };
        Runnable r2 = () -> {
            while (t.y.get() < 3) {
                logger.log(Level.INFO,"Thread Two :"+String.valueOf(t.y));
                t.y.getAndIncrement();
            }
        };
        Thread t1 = new Thread(r1);
        Thread t2 = new Thread(r2);
        t1.setPriority(4);
        t2.setPriority(7);
        t1.start();
        t2.start();
    }
}
```

Which statement is true?

```text
A. The program logs values 1 and 2 for the first thread and then values 1 and 2 for the second thread.
B. The program logs values 1 and 2 for each of the thread in random order.
C. The program throws an exception.
D. The program logs values 1 and 2 for the second thread and then values 1 and 2 for the first thread.
E. The program logs values 1 and 2 for the second thread and then value 1 for the first thread
   indefinitely.
```

**答案：B**

**解析**

- `t1` 與 `t2` 各自操作**不同的變數**（`x` 與 `y`），互不相干
- 每個執行緒的迴圈都是 `1 → 2`（條件 `< 3`），各記錄兩次
- **執行緒排程不確定**：`setPriority()` 只是「提示」，**不保證**誰先執行
- 因此：兩個執行緒都會記錄 `1`、`2`，但**交錯順序隨機** → **B** ✔

**陷阱**：`volatile` 只保證可見性、**不保證複合操作（`x++`）的原子性**；`AtomicInteger` 保證 `getAndIncrement` 原子性。本題因為兩個執行緒操作不同變數，所以不會有競態問題。

**考點**：`volatile` vs `AtomicInteger`、執行緒優先權不可靠、`Thread.start()` 後的排程不確定性。

---

# 11. I/O、NIO 與序列化（6 題）

## 第 16 題（第 1 次 第 16 題、第 3 次 第 33 題）

**題目**

```java
Path p1 = Path.of("fldr1/fldr2/file1.txt");
Path p2 = Path.of("fldr3/file1.txt");
System.out.println(p1.resolve(p2));
System.out.println(p1.relativize(p2));
```

What is the result?

```text
A. fldr1/fldr2/fldr3/file1.txt
   ../../../../fldr3/file1.txt
B. fldr1/fldr2/file1.txt/fldr3/file1.txt
   fldr3/file1.txt
C. fldr1/fldr2/file1.txt/fldr3
   ../../../fldr3/
D. fldr1/fldr2/file1.txt/fldr3/file1.txt
   ../../../fldr3/file1.txt
```

**答案：D**

**解析**

1. `resolve`：`p2` 是**相對路徑**，所以直接接在 `p1` 後面
   → `fldr1/fldr2/file1.txt/fldr3/file1.txt`
2. `relativize`：兩個都是相對路徑（同一個 root），計算「從 `p1` 到 `p2` 要怎麼走」
   - `p1` 有 3 個名稱元素：`fldr1`、`fldr2`、`file1.txt`
   - 先退回 3 層：`../../..`
   - 再加上 `p2`：`fldr3/file1.txt`
   → `../../../fldr3/file1.txt`

✔（實測：Windows 上分隔符號顯示為 `\`，內容相同）

**考點**：`Path.resolve`（絕對路徑會取代、相對路徑會串接）、`Path.relativize`（同 root 才能算）。

---

## 第 28 題（第 1 次 第 28 題、第 2 次 第 16 題、第 3 次 第 27 題）

**題目**

```java
import java.io.Serializable;
public class Software implements Serializable {
    private String title;
    public Software(String title) {
        this.title = title;
        System.out.print("Software ");
    }
    public String toString() { return title; }
}
// and the Game class:
public class Game extends Software {
    private int players;
    public Game(String title, int players) {
        super(title);
        this.players = players;
        System.out.print("Game ");
    }
    public String toString() { return super.toString()+" "+players; }
}
// and the AppStore class:
import java.io.*;
public class AppStore {
    public static void main(String[] args) {
        Software s = new Game("Chess", 2);
        try(ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("game.ser"))) {
            out.writeObject(s);
        } catch (Exception e) {
            System.out.println("write error");
        }
        try(ObjectInputStream in = new ObjectInputStream(new FileInputStream("game.ser"))) {
            s = (Software)in.readObject();
        } catch (Exception e) {
            System.out.println("read error");
        }
        System.out.println(s);
    }
}
```

What is the result?

```text
A. Software Game Chess 2
B. Software Game Software Game Chess 0
C. Software Game write error
D. Software Game Software Game Chess 2
E. Software Game Chess 0
F. Software Game read error
```

**答案：A**

**解析**

1. `new Game("Chess", 2)` → 依序呼叫 `Software` 建構子（印 `Software `）→ `Game` 建構子（印 `Game `）
2. 序列化：`Game` 與 `Software` 都 `implements Serializable`（`Game` 繼承）
3. **反序列化時，可序列化類別的建構子不會被呼叫**（只有「第一個不可序列化的父類別」的無參數建構子會被呼叫）
   - 因此 `Software`／`Game` 的建構子**都不會**再印任何字
   - 欄位 `title`、`players` 由串流還原 → `"Chess"`、`2`
4. `System.out.println(s)` → `Game.toString()` → `"Chess 2"`

完整輸出：`Software Game Chess 2` ✔（實測相同）

**考點**：序列化不呼叫建構子、`Serializable` 的繼承、`transient` 之外欄位都會被還原。

---

## 第 29 題（第 1 次 第 29 題、第 2 次 第 15 題、第 3 次 第 28 題）

**題目**

```java
import java.io.*;
public class Product implements Serializable {
    private static float averagePrice = 2.99f;
    private String description;
    private transient float price;
    public Product(String description, float price) {
        this.description = description;
        this.price = price;
    }
    public void readObject(ObjectInputStream in)
        throws IOException, ClassNotFoundException {
        in.defaultReadObject();
        price = averagePrice;
    }
    public String toString() {
        return description+" "+price+" "+averagePrice;
    }
}
// and the Shop class:
import java.io.*;
public class Shop {
    public static void main(String[] args) {
        Product p = new Product("Cookie", 3.99f);
        try {
            try (ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("p.ser"))) {
                out.writeObject(p);
            }
            try (ObjectInputStream in = new ObjectInputStream(new FileInputStream("p.ser"))) {
                p = (Product)in.readObject();
            }
        } catch (Exception e) { e.printStackTrace(); }
        System.out.println(p);
    }
}
```

What is the result?

```text
A. Cookie 2.99 2.99
B. Cookie 0.0 2.99
C. Cookie 3.99 2.99
D. An exception is produced at run time.
E. Compilation fails.
F. Cookie 0.0 0.0
```

**答案：B**

**解析**

兩個關鍵：

1. `price` 是 **`transient`** → 序列化時**不會**被寫入，反序列化後是**預設值 `0.0f`**
2. `readObject` 必須宣告為 **`private`** 才會被序列化機制呼叫（這是「特殊方法」的規則）。本題寫成 `public void readObject(...)` → **不會被呼叫**，所以 `price` 不會被設成 `averagePrice`

因此反序列化後：

- `description` = `"Cookie"`（一般欄位，有還原）
- `price` = `0.0`（transient，預設值）
- `averagePrice` = `2.99`（static，不參與序列化，但類別載入時初始化）

輸出：`Cookie 0.0 2.99` ✔（實測相同）

**考點**：`transient` 的預設值、`readObject` / `writeObject` 必須是 `private`、`static` 欄位不參與序列化。

---

## 第 32 題（第 1 次 第 32 題、第 2 次 第 4 題、第 3 次 第 6 題）

**題目**：Which statement is true?

```text
A. The java.lang.System.console() method throws an exception when console is not available.
B. The java.io.PrintStream class converts characters to bytes when printing to the console.
C. The java.io.PrintWriter class converts characters to bytes when printing to the console.
D. The java.io.Console.readPassword() method encrypts text typed by the user.
```

**答案：B**

**解析**

| 選項 | 正確？ | 說明 |
|---|---|---|
| A | ✘ | 沒有主控台時 `System.console()` 回傳 **`null`**，不拋例外 |
| **B** | ✔ | `PrintStream` 是**位元組串流**，內部會把字元依編碼轉成 bytes 輸出 |
| C | ✘ | `PrintWriter` 是**字元串流**（writer），不做「字元→位元組」的轉換 |
| D | ✘ | `Console.readPassword()` 只是**不回顯（no echo）**，回傳 `char[]`，**沒有加密** |

**考點**：`PrintStream`（bytes）vs `PrintWriter`（chars）、`System.console()` 可能為 `null`、`readPassword` 的用途。

---

## 第 33 題（第 1 次 第 33 題、第 2 次 第 3 題、第 3 次 第 7 題）

**題目**

`in.txt` 內容：

```text
racecar
```

```java
char[] buffer = new char[4];
int count = 0;
try(FileReader in = new FileReader("in.txt");
    FileWriter out = new FileWriter("out.txt")) {
    while((count = in.read(buffer)) != -1) {
        out.write(buffer);
    }
}
```

What is the content of the `out.txt` file?

```text
A. racecara
B. racecare
C. raceca
D. race
E. racec
F. racecar
```

**答案：B**

**解析**

`in.read(buffer)` 每次最多讀 4 個字元，但 `out.write(buffer)` **每次都寫入整個 buffer（4 個字元）**，不管這次實際讀到幾個。

1. 第一次 `read` → 讀到 `r a c e`（4 個），`buffer = [r,a,c,e]` → 寫出 `race`
2. 第二次 `read` → 讀到 `c a r`（3 個），`buffer` 變成 `[c,a,r,e]`（**第 4 格保留上一次的 `e`**）→ 寫出 `care`
3. 第三次 `read` → `-1`，結束

`out.txt` = `race` + `care` = **`racecare`** ✔（實測 `[racecare]`）

**陷阱**：正確寫法應是 `out.write(buffer, 0, count);`。

**考點**：`Reader.read(char[])` 的回傳值、重複使用 buffer 的殘留資料、`Writer.write(char[])` 全長寫入。

---

## 第 64 題（第 2 次 第 44 題）

**題目**

假設 `/test` 資料夾有兩個檔案：

- `infoA.txt`：
  ```text
  a!
  b!!
  ```
- `infoB.txt`：
  ```text
  c?!
  ?d?
  ```

```java
int result = Files.list(Path.of("/test"))
    .filter(p->Files.isRegularFile(p) &&
        p.toString().endsWith("txt"))
    .flatMap(p -> {
        try {
            return Files.lines(p);
        } catch (IOException e) {
            return null;
        }})
    .filter(s->s.contains("!"))
    .map(s->s.indexOf("?"))
    .reduce((s1,s2) -> s1+s2).get();
System.out.println(result);
```

What is the result?

```text
A. 2
B. -1
C. 0
D. -2
E. 1
```

**答案：B**

**解析**

1. `Files.list` → 兩個 `.txt` 檔
2. `flatMap(Files.lines)` → 四行：`a!`、`b!!`、`c?!`、`?d?`
3. `filter(s -> s.contains("!"))` → 保留 `a!`、`b!!`、`c?!`（`?d?` 沒有 `!`，被排除）
4. `map(s -> s.indexOf("?"))`：
   - `"a!"` → `-1`
   - `"b!!"` → `-1`
   - `"c?!"` → `1`
5. `reduce((s1,s2) -> s1+s2)` → `-1 + (-1) + 1 = -1`

輸出 `-1` ✔（實測 `-1`）

**考點**：`Files.lines` 的 `flatMap`、`indexOf` 找不到回傳 `-1`、`reduce` 的加總。

---

# 12. 日期時間、格式化與本地化（5 題）

## 第 1 題（第 1 次 第 1 題）

**題目**

```java
int saleAmount = 10000;
NumberFormat format1 = NumberFormat.getCurrencyInstance(Locale.US);
NumberFormat format2 = NumberFormat.getCompactNumberInstance(Locale.US, Style.SHORT);
String res = format1.format(saleAmount);
System.out.println(res);
format2.format(Integer.valueOf(res));
System.out.println(saleAmount);
```

What is the result?

```text
A. $10,000.00
   $10K
B. $10000.00
   $10.00 K
C. $10,000.00
   $10,000.00 K
D. $10,000.00
   An exception is thrown.
```

**答案：D**

**解析**

1. `format1.format(10000)` → `"$10,000.00"`，印出
2. `Integer.valueOf("$10,000.00")` → 字串含 `$`、`,`、`.` → **`NumberFormatException`**
3. 因此第二行不會印出 `saleAmount`，而是拋出例外

輸出：

```text
$10,000.00
Exception in thread "main" java.lang.NumberFormatException: For input string: "$10,000.00"
```

✔（實測相同）

**重點**：`NumberFormat.format` 的回傳值是**格式化後的字串**，不能直接丟回 `Integer.valueOf` 解析；且 `format2.format(...)` 的回傳值也**沒有被使用**。

**考點**：`NumberFormat` 貨幣與緊湊格式、`Integer.valueOf(String)` 只接受純數字字串。

---

## 第 46 題（第 1 次 第 46 題、第 2 次 第 8 題）

**題目**：Which code fragment prints `2024-05-04`?

```java
A. var x = LocalDate.of(2024, 1, 4)
       .plusMonths(1)
       .minus(Period.ofDays(-3));
   System.out.println(x);
B. var x = LocalDate.of(2024, 4, 1);
   x.withDayOfMonth(4).plus(Period.ofDays(30));
   System.out.println(x);
C. var x = LocalDate.of(2024, 4, 1)
       .plusMonths(1)
       .withDayOfMonth(15)
       .plusDays(-4)
       .minus(Period.ofWeeks(1));
   System.out.println(x);
D. var x = Period.between(
       LocalDate.of(2024, 4, 1),
       LocalDate.of(2024, 5, 1).plusDays(4));
   System.out.println(x);
```

**答案：C**

**解析**

**C**：

```text
2024-04-01
→ plusMonths(1)      = 2024-05-01
→ withDayOfMonth(15) = 2024-05-15
→ plusDays(-4)       = 2024-05-11
→ minus(ofWeeks(1))  = 2024-05-04   ✔
```

（實測 `2024-05-04`）

**各選項檢討**

| 選項 | 結果 | 原因 |
|---|---|---|
| A | `2024-02-07` | `2024-01-04 +1 月 = 2024-02-04`；`minus(-3 天)` = `+3 天` |
| B | `2024-04-01` | `LocalDate` 不可變，`withDayOfMonth(4).plus(...)` 的結果**沒有指派回 `x`** |
| **C** | **`2024-05-04`** ✔ | 鏈式呼叫正確 |
| D | `P1M4D` | `Period.between` 回傳 `Period`，不是日期 |

**考點**：`LocalDate` 不可變（每個方法都回傳新物件）、`Period.ofWeeks`、`Period.between`。

---

## 第 47 題（第 1 次 第 47 題、第 3 次 第 30 題）

**題目**

```java
LocalDate d1 = LocalDate.of(2021, Month.JANUARY, 1);
LocalDate d2 = d1.plus(Period.ofDays(-10)).withMonth(1);
LocalDateTime ldt = d2.atTime(LocalTime.of(11, 11));
if (d1.isAfter(d2) ^! d1.getMonth().equals(ldt.getMonth())) {
    ldt = d2.atTime(LocalTime.of(12, 12));
}
System.out.println(ldt.format(DateTimeFormatter.ofPattern("HHMM")));
```

What is the result?

```text
A. 1111
B. 1201
C. 1101
D. A runtime exception is thrown.
E. 1212
```

**答案：B**

**解析**

1. `d1 = 2021-01-01`
2. `d1.plus(Period.ofDays(-10))` = `2020-12-22`；`.withMonth(1)` = **`2020-01-22`**
3. `ldt = 2020-01-22T11:11`
4. 條件 `d1.isAfter(d2) ^ !d1.getMonth().equals(ldt.getMonth())`
   - `d1.isAfter(d2)`：`2021-01-01` 在 `2020-01-22` 之後 → **`true`**
   - `d1.getMonth()` = `JANUARY`；`ldt.getMonth()` = `JANUARY` → `equals` 為 `true` → `!true` = **`false`**
   - `true ^ false` = **`true`** → 進入 if
5. `ldt = 2020-01-22T12:12`
6. **關鍵**：`DateTimeFormatter.ofPattern("HHMM")` 中
   - `HH` = 時（24 小時制）
   - **`MM` = 月（month）**，不是分！
   - 分是 **`mm`**
7. 所以輸出 = 時 `12` + 月 `01` = **`1201`** ✔（實測 `1201`）

**考點**：`Period` 運算、`withMonth`、`^` 與 `!` 的優先順序、**`DateTimeFormatter` 大小寫差異（`MM` 月 vs `mm` 分）**。

---

## 第 52 題（第 2 次 第 7 題、第 3 次 第 29 題）

**題目**

Daylight Saving Time (DST) is the practice of advancing clocks at the start of spring by one hour and adjusting them backward by one hour in autumn.

Considering that in 2021, DST in Chicago (Illinois) ended on November 7th at 2 AM, and given the fragment:

```java
ZoneId zoneID = ZoneId.of("America/Chicago");
ZonedDateTime zdt = ZonedDateTime.of(
    LocalDate.of(2021, 11, 7),
    LocalTime.of(1, 30),
    zoneID);
ZonedDateTime anHourLater = zdt.plusHours(1);
System.out.println(zdt.getHour() == anHourLater.getHour());
System.out.print(zdt.getOffset().equals(anHourLater.getOffset()));
```

What is the output?

```text
A. false
   true
B. false
   false
C. true
   false
D. true
   true
```

**答案：C**

**解析**

2021-11-07 芝加哥：凌晨 2:00 時鐘**撥回** 1:00（夏令時間結束）。

- `zdt = 2021-11-07T01:30-05:00[America/Chicago]`（CDT，UTC-5）
- `plusHours(1)` 是**加絕對時間 1 小時** → 實際時間變成 `01:30-06:00`（CST，UTC-6）
  - 因為時鐘撥回，**本地時間的小時仍然是 1**
- 所以：
  - `zdt.getHour() == anHourLater.getHour()` → `1 == 1` → **`true`**
  - `zdt.getOffset()`（`-05:00`）`.equals(anHourLater.getOffset())`（`-06:00`）→ **`false`**

輸出：

```text
true
false
```

✔（實測：`2021-11-07T01:30-05:00` → `2021-11-07T01:30-06:00`）

**考點**：`ZonedDateTime` 的 DST 行為、`plusHours` 是絕對時間運算（`plusDays` 是本地時間運算）、offset 比較。

---

## 第 59 題（第 2 次 第 31 題、第 3 次 第 8 題）

**題目**

```java
Locale.setDefault(Locale.US);
Locale currentLocale = new Locale.Builder().setLanguage("en").build();
ResourceBundle captions = ResourceBundle.getBundle("Captions.properties", currentLocale);
System.out.println(captions.getString("user"));
```

檔案內容：

```properties
# Captions.properties
user = UserName

# Captions_en.properties
user = User name (EN)

# Captions_US.properties
message = User name (US)

# Captions_en_US.properties
message = User name (EN - US)
```

What is the result?

```text
A. User name (EN - US)
B. User name (US)
C. User name (EN)
D. The program throws a MissingResourceException
E. UserName
```

**答案：D**

**解析**

`ResourceBundle.getBundle(baseName, locale)` 的 `baseName` 是**基底名稱（不含 `.properties`）**，而且會被當成「類名」處理：

- `baseName = "Captions.properties"`
- 實際尋找的資源檔名 = `Captions/properties.properties`（點被換成路徑分隔）
- 找不到 → **`MissingResourceException`** ✔（實測：`Can't find bundle for base name Captions.properties, locale en`）

**如果寫對**（`getBundle("Captions", currentLocale)`）：

- `locale = en` → 候選：`Captions_en` → `Captions`（預設）
- `Captions_en.properties` 只有 `message`，沒有 `user` → 往上找父系 `Captions.properties` → `user = UserName`
- 所以正確寫法會印 **`UserName`**（選項 E）

但本題的 base name 多了 `.properties` → 直接 `MissingResourceException`。

**考點**：`ResourceBundle` 基底名稱規則、locale 候選順序、`MissingResourceException`。

---

# 13. 模組系統（5 題）

## 第 2 題（第 1 次 第 2 題）

**題目**

```java
module citizen {
    exports com.name to greeting;
}
module greeting {
}
```

Which statement is true?

```text
A. Public members in the citizen module are accessible only to the greeting module.
B. Public members in the com.name package are accessible to all modules.
C. All members of com.name are accessible only to the citizen and greeting modules.
D. Inserting requires citizen; into the greeting module-info enables classes in the greeting module
   to access public members of the com.name package.
E. Inserting opens com.name; into the greeting module-info enables classes in the greeting module to
   access all members of the com.name package.
F. All members in the com.name package are accessible only to the greeting module.
```

**答案：D**

**解析**

`exports com.name to greeting;` 是**限定匯出（qualified export）**：只有 `greeting` 模組能存取 `com.name` 套件中的 **public** 成員。

但要讓 `greeting` 真的能使用，還需要：

1. `citizen` 匯出該套件（已有）
2. `greeting` **讀取** `citizen` → 在 `greeting` 的 `module-info` 加上 **`requires citizen;`**

**D** 完全符合 ✔

**各選項檢討**

| 選項 | 正確？ | 說明 |
|---|---|---|
| A | ✘ | 不是「citizen 模組的所有 public 成員」，只有 `com.name` 套件的 public 成員 |
| B | ✘ | 限定匯出後，**不是**所有模組都能存取 |
| C | ✘ | 只有 public 成員（不是所有成員），且 citizen 本身不需要「存取」 |
| **D** | ✔ | `requires citizen` 才能讀取被匯出的套件 |
| E | ✘ | `opens` 是給**反射**用的，且 `opens` 要寫在**提供者**（citizen）而非消費者 |
| F | ✘ | 只有 public 成員，不是「所有成員」 |

**考點**：`exports ... to ...` 限定匯出、`requires` 的必要性、`opens` 的用途。

---

## 第 3 題（第 1 次 第 3 題、第 2 次 第 35 題、第 3 次 第 16 題）

**題目**

Given the following scenario:

- A module `abc` contains an `abc.shopping.ShopService` interface.
- A module `xyz` contains an `xyz.shop.OnlineShop` class that implements `abc.shopping.ShopService`.
- A module `acme` needs to use the implementation of `ShopService` provided by the `xyz` module.

Which statement is true?

```text
A. A requires xyz directive must be added to the acme module-info.
B. An opens abc directive must be added to the acme module-info.
C. A requires abc.shopping directive must be added to the acme module-info.
D. A requires xyz.shop directive must be added to the acme module-info.
E. An opens abc.shopping directive must be added to the acme module-info.
F. An opens xyz.shop directive must be added to the acme module-info.
G. A requires abc directive must be added to the acme module-info.
H. An opens xyz directive must be added to the acme module-info.
```

**答案：G**

**解析**

- `requires` 的對象是**模組名稱**，不是套件名稱 → C、D 語法錯誤（`abc.shopping`、`xyz.shop` 是套件名）
- `opens` 是給**反射**用的，不是一般編譯期存取 → B、E、F、H 都不對
- `acme` 要能宣告／使用 `ShopService` 這個**型別**，就必須讀取介面所在的模組 `abc` → `requires abc;`

因此 **G** ✔

**為什麼不是 A？**

`acme` 是「使用 `xyz` 提供的實作」，典型的做法是透過 **ServiceLoader**：

```java
uses abc.shopping.ShopService;   // acme 的 module-info
```

此時 `acme` 在**編譯期完全不需要**讀取 `xyz`（實作是由執行期載入的），所以 `requires xyz` 並非「必須」。反過來說，`xyz` 必須 `requires abc` 並以 `provides abc.shopping.ShopService with xyz.shop.OnlineShop;` 註冊實作，`abc` 則必須 `exports abc.shopping;`。

**考點**：`requires` 接受模組名（非套件名）、`uses` / `provides` 的服務載入模型、`opens` 與 `exports` 的差別。

---

## 第 22 題（第 1 次 第 22 題、第 2 次 第 39 題、第 3 次 第 38 題）

**題目**：Which two statements are true about running code on the class path and the module path?（選 2 個）

```text
A. A modular JAR placed on the --module-path results in a named application module.
B. A non-modular JAR placed on the --module-path results in a named application module.
C. A non-modular JAR placed on the -classpath results in an unnamed module.
D. A modular JAR placed on the -classpath results in an automatic module.
E. A modular JAR placed on the -classpath results in a named application module.
```

**答案：A、C**

**解析**

| 選項 | 正確？ | 說明 |
|---|---|---|
| **A** | ✔ | 有 `module-info.class` 的 JAR 放在 `--module-path` → **具名應用模組（explicit named module）** |
| B | ✘ | 沒有 `module-info` 的 JAR 放在 `--module-path` → **自動模組（automatic module）**。自動模組雖然也算「具名」，但它是自動產生的，不是選項所說的「application module」 |
| **C** | ✔ | 放在 `-classpath` 的任何 JAR → 都屬於 **unnamed module** |
| D | ✘ | 具名模組 JAR 放在 `-classpath` → 被當成 unnamed module 的一般 JAR，**不會**變成 automatic module |
| E | ✘ | 放在 classpath 不會是 named module |

**考點**：named module / automatic module / unnamed module 的判定。

---

## 第 23 題（第 1 次 第 23 題、第 2 次 第 38 題、第 3 次 第 39 題）

**題目**：Which statement is true regarding the JImage deployment?

```text
A. A JImage can only include Java artefacts such as compiled classes and property bundles.
B. A JImage can only include modules that are referred to via the requires, or opens directives.
C. A JImage can be produced to run on multiple platforms.
D. A JImage can be produced for a non-modular application.
```

**答案：C**

**解析**

JImage 是 `jlink` 產生的執行期映像（runtime image），裡面包含模組化的 JDK 與應用程式模組。

| 選項 | 正確？ | 說明 |
|---|---|---|
| A | ✘ | 不只能含 Java artefacts，也可以含**原生函式庫、設定檔**等資源 |
| B | ✘ | 映像可包含未被 `requires`／`opens` 直接引用的模組（例如 `jlink --add-modules` 指定的模組） |
| **C** | ✔ | `jlink` 可以產生**不同平台**的映像：把目標平台的 `jmods` 放在 `--module-path`，即可產生給該作業系統／架構使用的映像（一個映像仍只對應一個平台） |
| D | ✘ | `jlink` 以**模組**為單位，非模組化應用無法直接產生 JImage |

**考點**：`jlink` / JImage、跨平台映像、模組化限制。

---

## 第 61 題（第 2 次 第 34 題、第 3 次 第 17 題）

**題目**

```java
package com.transport.vehicle.cars;
public interface Car {
    int getSpeed();
}
// and
package com.transport.vehicle.cars.impl;
import com.transport.vehicle.cars.Car;
public class CarImpl implements Car {
    private int speed;
    public CarImpl() {
        this(10);
    }
    public CarImpl (int speed) {
        this.speed = speed;
    }
    @Override
    public int getSpeed() {
        return speed;
    }
}
```

Which two should the `module-info` file include for it to represent the service provider interface?（選 2 個）

```text
A. provides com.transport.vehicle.cars.Car with com.transport.vehicle.cars.impl.CarImpl;
B. exports com.transport.vehicle.cars;
C. provides com.transport.vehicle.cars.impl.CarImpl for com.transport.vehicle.cars.Car;
D. exports com.transport.vehicle.cars.Car;
E. exports com.transport.vehicle;
F. requires com.transport.vehicle.cars.Car;
G. requires com.transport.vehicle.cars;
```

**答案：A、B**

**解析**

Service Provider Interface（SPI）的三要素：

1. **服務介面**：`com.transport.vehicle.cars.Car`
2. **服務提供者**：`com.transport.vehicle.cars.impl.CarImpl`
3. **module-info 宣告**：
   - 匯出服務介面套件（讓其他模組能使用）：`exports com.transport.vehicle.cars;`
   - 宣告提供實作：`provides <介面> with <實作類別>;`

正確語法：

```java
module com.transport.vehicle.cars {
    exports com.transport.vehicle.cars;
    provides com.transport.vehicle.cars.Car
        with com.transport.vehicle.cars.impl.CarImpl;
}
```

→ **A、B** ✔

**各選項檢討**

| 選項 | 正確？ | 說明 |
|---|---|---|
| **A** | ✔ | `provides ... with ...` 語法正確 |
| **B** | ✔ | 匯出服務介面所在套件 |
| C | ✘ | 語法是 `provides ... with ...`，不是 `for` |
| D | ✘ | `exports` 的對象是**套件**，不是介面 |
| E | ✘ | 匯出的是父套件，不是介面所在套件（且沒有實際意義） |
| F | ✘ | `requires` 的對象是模組，不是介面 |
| G | ✘ | 這裡是**提供者模組**，`requires` 自己的模組名稱沒有意義 |

**考點**：`provides ... with ...`、`exports` 只接受套件、SPI 的模組宣告。

---

# 附錄 A：高頻考點速查

## A-1. `var` 規則

| 規則 | 說明 |
|---|---|
| 只能是**區域變數** | 不可用於欄位、方法參數、回傳型別 |
| 必須有初始化 | `var x;` 不合法 |
| 不可初始化為 `null` | 無法推斷型別 |
| 型別一旦推斷即固定 | 之後不可換型別 |
| 無目標型別時推成 `Object` | `var list = new ArrayList<>();` → `ArrayList<Object>` |

## A-2. 多載解析順序

1. 階段 1：不裝箱、不 varargs（精確／寬廣化）
2. 階段 2：允許裝箱／拆箱
3. 階段 3：允許 varargs

> `double` **不會**自動窄化成 `float`；`Math.round(float)` 回傳 `int`。

## A-3. 初始化順序

```text
類別載入：static 欄位 → static 區塊（依原始碼順序）
建立物件：super() → 欄位初始化 → 實例初始化區塊 → 建構子本體
```

## A-4. 介面成員

| 成員 | 修飾子 | 備註 |
|---|---|---|
| 常數 | `public static final`（隱含） | 不可 `private` |
| 抽象方法 | `public abstract`（隱含） | |
| default | `public default` | 透過實例呼叫 |
| static | `public static` | 只能 `介面名.方法()` |
| private | `private`（Java 9+） | 只能在介面內使用 |

## A-5. `String` / 文字區塊

- `String` 不可變：`replace`、`trim`、`substring` 都回傳新物件
- 文字區塊：
  - 開頭 `"""` 後**必須換行**
  - 結尾 `"""` 與內容同行 → **不含**最後換行
  - 結尾 `"""` 獨立一行 → **含**最後換行
  - 共同縮排（incidental whitespace）會被移除

## A-6. Record

| 規則 | 說明 |
|---|---|
| 不能有實例欄位 | 只能有 `static` 欄位 |
| 不能有實例初始化區塊 | |
| 精簡建構子不可用 `this.x =` | 直接寫 `x = ...` |
| 可覆寫 accessor / `toString` / `equals` / `hashCode` | |
| 隱含 `final` | 不可被繼承 |

## A-7. Enum

- 建構子只能是 `private` 或 package-private（**不能 `public`**）
- `valueOf(String)` 只認 `name()`（原始常數名），與 `toString()` 無關
- 常數是**單例**，實例欄位會被共享

## A-8. Pattern Matching / switch

- `instanceof 型別 變數`：flow scoping
- `case null` **必須明寫**，否則 `null` selector 會 NPE
- `when` guard 用於額外條件
- `default` 若放在前面，會**支配**後面的 case → 編譯錯誤
- 同一個 switch 不可混用 `case X:` 與 `case X ->`
- sealed 型別可窮盡，不需要 `default`

## A-9. 例外

| 主題 | 重點 |
|---|---|
| try-with-resources | `close()` 的例外會被 **suppressed**，不會自動印出 |
| `finally` | 一定執行，即使 `catch` 中有 `return` |
| checked vs unchecked | `RuntimeException` 子類別不需要 `throws` |
| 覆寫 | 不可拋出更寬的 checked exception |

## A-10. 集合

| 類別／方法 | 重點 |
|---|---|
| `Arrays.asList` | 陣列視圖：可 `set`、不可 `add`/`remove` |
| `List.of` / `Set.of` | 不可變，任何修改都丟 `UnsupportedOperationException` |
| `Collections.unmodifiableList` | **視圖**，底層改變會反映 |
| `HashSet` | 不保證順序 |
| `LinkedHashSet` | 保留插入順序；`addFirst` 會把已存在元素移到最前 |
| `TreeSet` | 排序；不支援 `addFirst` |
| `Deque` | `offerFirst` / `offerLast` / `peekLast`；迭代由 front → back |

## A-11. Stream

| 操作 | 重點 |
|---|---|
| `map` vs `flatMap` | `flatMap` 攤平 `Stream<Stream<T>>` → `Stream<T>` |
| `sorted()` | stateful，對**無限 Stream** 永遠不會完成 |
| `takeWhile` / `dropWhile` | 只作用在**前綴**；unordered stream 行為不確定 |
| `parallel().forEach` | **不保證順序**；要順序用 `forEachOrdered` |
| `reduce(identity, acc, comb)` | identity 會**套用到每個分割區**，必須是單位元素 |
| `Collectors.groupingBy` + `counting` | 回傳 `Map<K, Long>` |

## A-12. 執行緒

| 主題 | 重點 |
|---|---|
| `lock()` | `void`，阻塞等待 |
| `tryLock()` | `boolean`，立刻回傳 |
| 讀寫鎖 | 讀鎖**不可**升級為寫鎖 |
| `interrupt()` | 只設旗標，**不改變狀態** |
| 虛擬執行緒 | 永遠 daemon、`setPriority` 無效、由 carrier thread 執行 |
| `volatile` | 保證可見性，**不保證** `x++` 原子性 |

## A-13. I/O 與序列化

| 主題 | 重點 |
|---|---|
| `PrintStream` | 位元組串流（會做字元→位元組編碼） |
| `PrintWriter` | 字元串流 |
| `Reader.read(char[])` | 回傳**實際讀到的字元數** |
| `Writer.write(char[])` | 寫入**整個陣列** |
| `transient` | 反序列化後為**預設值** |
| `readObject` / `writeObject` | 必須是 **`private`** 才會被呼叫 |
| 反序列化 | **不會**呼叫可序列化類別的建構子 |

## A-14. 日期時間

| 模式字母 | 意義 |
|---|---|
| `HH` | 時（0-23） |
| `mm` | 分 |
| `MM` | **月** |
| `ss` | 秒 |

- `LocalDate` / `LocalDateTime` 都是**不可變**
- `ZonedDateTime.plusHours` 是**絕對時間**運算（DST 會造成本地時間不變）
- `Period` 是日期期間、`Duration` 是時間期間

## A-15. 模組

| 指令 | 說明 |
|---|---|
| `requires M;` | 讀取模組 M（**模組名**，非套件） |
| `exports P;` | 匯出套件 P（**套件**） |
| `exports P to M;` | 限定匯出給 M |
| `opens P;` | 開放套件給**反射** |
| `provides I with C;` | 宣告服務提供者 |
| `uses I;` | 宣告使用服務 |

---

# 附錄 B：易錯陷阱 Top 20

1. `Boolean.valueOf("1")` → **`false`**（只認 `"true"`）
2. `Integer.valueOf("a", 16)` → `10`
3. `~n = -n - 1`
4. `&` 不短路、`&&` 短路 → 影響 `c++` 次數
5. `Math.round(float)` 回傳 **`int`**
6. `double` 不會自動窄化成 `float`
7. `var` 不能是 `null`、不能是欄位
8. `String.replace` 回傳新字串，**原字串不變**
9. 文字區塊結尾 `"""` 的位置決定**是否含最後換行**
10. 實例初始化區塊執行時，建構子本體**尚未**執行
11. `final` 欄位必須在**每個建構子**都被指派
12. 介面 `static` 方法**不被實作類別繼承**
13. 覆寫方法不可拋出更寬的 **checked** exception
14. record **不能有實例欄位**、**不能有實例初始化區塊**
15. 精簡建構子不可寫 `this.x = ...`
16. enum 建構子不可 `public`
17. `Enum.valueOf` 只看 `name()`，與 `toString()` 無關
18. pattern switch 的 `case null` **必須明寫**
19. `default` 放在前面會**支配**後面的 case
20. `DateTimeFormatter` 的 `MM` 是**月**、`mm` 才是分

---

# 附錄 C：以單元整理的答案

| 單元 | 題號 → 答案 |
|---|---|
| 1 基本語法 | 20 C,F ／ 24 C ／ 25 C ／ 30 E ／ 31 A ／ 51 A ／ 66 B ／ 67 B |
| 2 字串與文字區塊 | 42 D ／ 43 D ／ 63 C |
| 3 類別與 OOP | 12 C ／ 21 D ／ 34 D ／ 40 A,E ／ 41 C ／ 44 B ／ 45 A ／ 56 D ／ 62 D ／ 69 A,B,E ／ 71 B ／ 72 D,E ／ 76 E ／ 77 B,E |
| 4 Record | 13 C,E |
| 5 Enum | 26 B ／ 27 D ／ 38 E |
| 6 樣式與 switch | 35 B ／ 36 D ／ 37 C ／ 39 E |
| 7 例外處理 | 14 A,E ／ 15 A ／ 65 D |
| 8 集合與陣列 | 6 C ／ 7 A ／ 8 C ／ 9 B,E ／ 53 A ／ 54 F ／ 73 B |
| 9 Stream | 4 D ／ 5 C ／ 48 F ／ 49 C ／ 50 C ／ 57 B ／ 58 A ／ 60 C ／ 70 C ／ 74 B |
| 10 並行與執行緒 | 10 A ／ 11 D ／ 17 A,D ／ 18 D ／ 19 A ／ 55 H ／ 68 C ／ 75 B |
| 11 I/O 與序列化 | 16 D ／ 28 A ／ 29 B ／ 32 B ／ 33 B ／ 64 B |
| 12 日期時間與本地化 | 1 D ／ 46 C ／ 47 B ／ 52 C ／ 59 D |
| 13 模組系統 | 2 D ／ 3 G ／ 22 A,C ／ 23 C ／ 61 A,B |

---

> 本文件依 `jdk21exam.txt` 的題目與官方標示答案整理，並以 JDK 21.0.2 實際編譯／執行驗證關鍵題目（第 12、13、25、26、33、36、37、38、39、42、47、50、51、52、53、55、56、57、59、60、62、63、66、67、68、69、70、71、72、73、74、77 題等）。若題目文字擷取造成程式碼差異（例如第 42 題的空行），文中已標註。

