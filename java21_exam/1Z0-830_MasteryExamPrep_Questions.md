# 1Z0-830 Java SE 21 Developer — MasteryExamPrep 免費模擬考 50 題（全）

> 來源：MasteryExamPrep 官方免費練習（50 題，含題目、選項、正確答案與詳解）
> https://masteryexamprep.com/exams/oracle/1z0-830/free-practice-exam
> 整理時間：2026-09-17

### Q001 [Working with Streams and Lambda Expressions]

A developer is troubleshooting why an audit list remains empty. They expected one `checked ...` entry per input value.

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

**選項：**

- A. Use `parallelStream()` so operations run eagerly.
- B. Call `pipeline.close()` before printing `audit`.
- C. Call `pipeline.toList()` before printing `audit`.（✓ 正確）
- D. Replace `filter()` with `peek()` for auditing.

**答：C。** The stream pipeline is only being constructed, not executed. `filter()` and `map()` are intermediate operations, so their lambdas are lazy and do not run until a terminal operation consumes the stream.

In a stream pipeline, intermediate operations such as `filter()`, `map()`, `peek()`, `sorted()`, and `limit()` return another stream and are lazy. They describe work to be performed later. A terminal operation such as `toList()`, `forEach()`, `count()`, or `reduce()` starts traversal of the source. In this code, no terminal operation is invoked before `System.out.println(audit)`, so the `filter()` body never executes and the list remains empty. Adding `pipeline.toList()` before the print would consume the stream and run the pipeline. The key takeaway is that creating a stream pipeline is not the same as executing it.

-   **Using `peek()`** does not fix the issue because `peek()` is also an intermediate, lazy operation.
-   **Closing the stream** releases resources associated with the stream but does not perform pending pipeline work.
-   **Parallel execution** changes possible execution mechanics, not the lazy nature of intermediate operations.

---

### Q002 [Handling Date, Time, Text, Numeric, and Boolean Values]

A payroll method stores amounts in cents. The business rule is: first add `baseCents` and `overtimeCents`, then return 10% of that combined amount using integer arithmetic. Which replacement for the `return` statement best fixes the defect?

```java
class Payroll {
    static int bonusCents(int baseCents, int overtimeCents) {
        return baseCents + overtimeCents * 10 / 100;
    }
}
```

**選項：**

- A. `return baseCents + overtimeCents * (10 / 100);`
- B. `return (baseCents + overtimeCents) * 10 / 100;`（✓ 正確）
- C. `return baseCents + overtimeCents * 10 / 100;`
- D. `return (baseCents + overtimeCents * 10) / 100;`

**答：B。** Multiplication and division have higher precedence than addition in Java. To apply the percentage to the sum, the addition must be grouped explicitly with parentheses before the multiplication and division are evaluated.

Java evaluates `*` and `/` before `+`, with operators at the same precedence level evaluated left to right. The original expression computes `baseCents + ((overtimeCents * 10) / 100)`, so only the overtime portion is reduced to 10%. Parentheses around `baseCents + overtimeCents` change the evaluation order so the combined amount is computed first, and then integer arithmetic applies the percentage. The closest trap is adding parentheses in a place that still leaves `overtimeCents * 10` evaluated before the intended addition.

-   **Original precedence** leaves multiplication and division ahead of addition, so the percentage applies only to `overtimeCents`.
-   **Partial grouping** around `baseCents + overtimeCents * 10` still multiplies overtime before adding the base amount.
-   **Integer division trap** makes `10 / 100` evaluate to `0`, causing the overtime term to contribute nothing.

---

### Q003 [Controlling Program Flow]

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

**選項：**

- A. The output is `0:1:3:0`.
- B. The output is `0:0:2:0`.
- C. The output is `0:1:2:0`.（✓ 正確）
- D. The output is `10:1:2:0`.

**答：C。** This is a loop boundary case with an empty array. A `while` loop checks its condition before executing, but a `do-while` loop executes its body before the first condition check. The basic `for` loop also uses `continue` to skip one addition.

Java evaluates `while` conditions before the loop body, so `a < nums.length` is `0 < 0`, and `a` remains `0`. A `do-while` loop executes its body once before checking the condition, so `b` becomes `1` and then stops. The basic `for` loop runs with `i` values `0`, `1`, and `2`; when `i == 1`, `continue` skips `c += i`, so only `0` and `2` are added. The enhanced `for` loop over an empty array has no iterations, leaving `d` as `0`. The key distinction is pre-test versus post-test loop behavior.

-   **Skipped do-while body** fails because a `do-while` body executes once before its condition is evaluated.
-   **Entered while loop** fails because `while` checks `0 < 0` before running and does not enter.
-   **Ignored continue** fails because `continue` skips the addition when `i` is `1`.

---

### Q004 [Using Object-Oriented Concepts in Java]

A developer wants the no-argument constructor to reuse the one-argument constructor before printing `A0`.

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

**選項：**

- A. `super("daily");`
- B. `this("daily");`（✓ 正確）
- C. `System.out.print("start "); this("daily");`
- D. `this("daily"); super("daily");`

**答：B。** The no-argument constructor must delegate to `AuditReport(String)`, not directly to `Report(String)`. In Java, an explicit `this(...)` or `super(...)` constructor invocation must be the first statement in a constructor, and only one such invocation is allowed.

Constructor chaining is controlled by an explicit constructor invocation at the start of a constructor body. `this("daily");` calls the one-argument constructor of `AuditReport`, which then calls `super(name)`. Execution returns to the no-argument constructor and prints `A0`, producing the required sequence: `R1 A1 A0` . A direct `super(...)` call would initialize the superclass but would not reuse the sibling constructor. Any statement before `this(...)` or any attempt to use both `this(...)` and `super(...)` in the same constructor is illegal.

-   `super("daily");` calls the superclass constructor directly, so it skips `AuditReport(String)` and does not print `A1`.
-   Printing before `this("daily");` fails because an explicit constructor invocation must be the first statement.
-   Combining `this("daily");` and `super("daily");` fails because a constructor can have only one explicit constructor invocation.

---

### Q005 [Using Object-Oriented Concepts in Java]

Which statement correctly describes normalization in a Java 21 compact constructor for a record class?

**選項：**

- A. Modify accessor return values to normalize stored state.
- B. Assign `this.component` directly for each component.
- C. Declare new mutable fields for normalized components.
- D. Reassign component parameters; implicit field assignment follows.（✓ 正確）

**答：D。** A compact constructor is for validation and normalization before the record fields are initialized. You may reassign the implicit component parameters, and the compiler then assigns the private final component fields from those parameter values.

In a record compact constructor, the parameter list is omitted, but the component names are available as constructor parameters. The compact constructor body runs first, so code such as `name = name.strip();` normalizes the parameter. After the body finishes, the compiler inserts assignments from those parameters to the record’s private final component fields. Direct assignments such as `this.name = ...` are not allowed in a compact constructor because component fields are managed by the canonical construction process and are final. The key distinction is parameter normalization, not field mutation.

-   **Direct field assignment** fails because compact constructors cannot assign to record component fields.
-   **Accessor normalization** fails because accessors should report stored state, not replace canonical initialization.
-   **Extra mutable fields** fails because it undermines the record component model and is not how compact constructors normalize components.

---

### Q006 [Using Object-Oriented Concepts in Java]

A monitoring app needs an enum `Priority` whose constants each store an `int level` and whose instances support `boolean isUrgent()`. Which declaration correctly applies Java SE 21 enum rules?

**選項：**

- A. ```java
- B. ```java
- C. ```java
- D. ```java（✓ 正確）

**答：D。** Enum constants are instances of the enum type and must be declared before fields, constructors, and methods. When constants pass arguments, an enum constructor with matching parameters can initialize instance fields. That constructor cannot be `public` or `protected`; without an access modifier, it is implicitly private.

An enum declaration may define constants with constructor arguments, followed by a semicolon and then fields, constructors, and methods. Each constant invokes an enum constructor, so `LOW(1)` requires a constructor accepting an `int`. Enum constructors are used only during enum constant creation; they cannot be called with `new`, and they cannot be declared `public` or `protected`. In the valid declaration, the constants come first, the `level` field is initialized by the constructor, and `isUrgent()` reads that field. The closest traps are moving the field before the constants or making the constructor public, both of which violate enum declaration rules.

-   **Field before constants** fails because enum constants must appear before ordinary fields and methods.
-   **Public constructor** fails because enum constructors cannot be declared `public` or `protected`.
-   **Missing constructor arguments** fails because `LOW`, `MEDIUM`, and `HIGH` do not match the declared `Priority(int)` constructor.

---

### Q007 [Working with Streams and Lambda Expressions]

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

**選項：**

- A. Compilation fails because `summarizingInt()` cannot be downstream of `groupingBy()`.
- B. It prints `west=2/8,east=1/2`.
- C. It prints `east=1/2,west=2/8`.（✓ 正確）
- D. It prints `east=1/2,west=1/5`.

**答：C。** The `groupingBy` overload is given `TreeMap::new`, so the grouped result is sorted by key. The downstream `summarizingInt` collector computes per-region count and sum, and `joining` concatenates those entries in the map’s encounter order.

This code uses a three-argument `groupingBy` collector: classifier, map factory, and downstream collector. The classifier groups by `region`, the map factory creates a `TreeMap`, and `summarizingInt(Sale::units)` produces an `IntSummaryStatistics` for each region. The east group has one sale totaling 2 units. The west group has two sales totaling 8 units. Streaming the `TreeMap` entries visits `east` before `west`, and `joining(",")` concatenates the mapped strings without spaces. The key takeaway is that collector composition controls both aggregation and the final iteration order when an ordered map factory is supplied.

-   **Encounter order assumption** fails because the result map is a `TreeMap`, not an insertion-ordered map.
-   **Lost duplicate assumption** fails because `groupingBy` groups both west sales before summarizing them.
-   **Invalid downstream assumption** fails because `summarizingInt` is a valid downstream collector for `groupingBy`.

---

### Q008 [Working with Arrays and Collections]

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

**選項：**

- A. `return names;`
- B. `return Arrays.asList(names.toArray(String[]::new));`
- C. `return Collections.unmodifiableList(names);`
- D. `return List.copyOf(names);`（✓ 正確）

**答：D。** The method needs an unmodifiable snapshot, not a live view. `List.copyOf(names)` copies the current contents into an unmodifiable list, so it satisfies both requirements when elements are non-null.

`Collections.unmodifiableList()` prevents modification through the returned reference, but it is view-backed: changes to the original `names` list still appear in previously returned lists. `List.copyOf()` is different because it creates an unmodifiable copy of the source collection’s current contents. Since the stem guarantees non-null elements, `List.copyOf(names)` is the cleanest Java 21 fix for an immutable-style snapshot.

The key distinction is whether the returned collection blocks caller mutation only, or also stops observing future internal mutation.

-   **Returning the field** exposes the mutable `ArrayList`, allowing callers to change internal state directly.
-   **Unmodifiable view** blocks calls like `add()` on the returned list but still reflects later changes to `names`.
-   **Fixed-size list** from `Arrays.asList()` does not allow add/remove, but it still permits `set()` and is not unmodifiable.

---

### Q009 [Using Object-Oriented Concepts in Java]

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

**選項：**

- A. `var a = new Account(); var c; c = a.cents(); audit(c);`
- B. `var a = new Account(); { var c = a.cents(); } audit(c);`
- C. `var a = new Account(); var c = a.cents(); audit(c);`（✓ 正確）
- D. `var a = new Account(); audit(a.cents);`

**答：C。** The compiling replacement gets the value through the accessor and declares `c` with an initializer, so `var` infers `int`. When `audit(c)` is called, overload resolution chooses the fixed-arity `audit(long)` by widening before considering the varargs overload.

Local variable type inference with `var` works only when the declaration has an initializer, and the inferred type of `c` is `int`. The field `cents` is private, so code in `Demo` must call the accessible `cents()` method rather than read the field directly. A local declared inside a nested block is also not visible after that block ends. After those compile-time checks pass, overload resolution considers fixed-arity methods before variable-arity methods; widening `int` to `long` selects `audit(long)` before `audit(Integer...)` is considered. The key distinction is that a valid fixed-arity overload beats a varargs overload.

-   **Private field access** fails because `cents` is private to `Account`, even though the classes are in the same file.
-   **Uninitialized `var`** fails because a local variable declared with `var` must have an initializer.
-   **Block scope** fails because `c` is declared inside braces and is not visible at the later `audit(c)` call.

---

### Q010 [Using Java I/O API]

For `java.nio.file.Path` in Java 21, which statement is a correct NIO.2 rule?

**選項：**

- A. `path.normalize()` checks the file system before removing `.` and `..`.
- B. `base.resolve(other)` returns `other` when `other` is absolute.（✓ 正確）
- C. `path.toAbsolutePath()` also normalizes the path automatically.
- D. `Path.of("/").getFileName()` returns the root path.

**答：B。** `Path.resolve` has a specific rule for absolute arguments: the absolute path wins. This is a lexical path-composition rule and does not require file-system lookup or existence checks.

NIO.2 `Path` methods often operate on path syntax rather than actual files. For `resolve`, if the argument is absolute, the result is that argument, not the base path plus the argument. `normalize()` removes redundant name elements such as `.` and possible `..` pairs lexically; it does not verify files or follow symbolic links. `toAbsolutePath()` makes a path absolute but is not the same as calling `normalize()`. A root-only path has no name element, so `getFileName()` returns `null`, while `getRoot()` returns the root component.

-   **File-system lookup** fails because `normalize()` is lexical and does not check whether a path exists.
-   **Automatic normalization** fails because `toAbsolutePath()` does not imply `normalize()`.
-   **Root as file name** fails because a root component is returned by `getRoot()`, not `getFileName()`.

---

### Q011 [Logging API and Standard Annotations]

A Java SE 21 utility uses `java.util.logging.Logger`. In a catch block, it must create a warning log record whose message is `Load failed` and whose `Throwable` is stored on the `LogRecord`, not merely appended to the text. Which comparison correctly identifies the appropriate logging call?

**選項：**

- A. `logger.log(Level.WARNING, "Load failed " + ex)` records the same throwable metadata.
- B. `logger.warning("Load failed", ex)` records the throwable separately.
- C. `logger.log(Level.WARNING, "Load failed", ex)` records the throwable separately.（✓ 正確）
- D. `logger.throwing("Loader", "load", ex)` creates a warning message `Load failed`.

**答：C。** The Java Logging API has a `Logger.log(Level, String, Throwable)` overload for attaching an exception to a log record. That is different from adding the exception to the message text, which only calls `toString()` and loses throwable metadata.

In `java.util.logging`, the decisive distinction is whether the `Throwable` is passed to a throwable-aware logging method. `logger.log(Level.WARNING, "Load failed", ex)` creates a `LogRecord` with level `WARNING`, message `Load failed`, and the caught exception in the record’s thrown field. A handler or formatter can then treat the exception specially. By contrast, string concatenation only builds a message string, and convenience methods such as `warning(String)` do not accept a separate throwable argument. `Logger.throwing(...)` is for tracing method exits with exceptions and logs at `FINER`, not as a custom warning message.

-   **Convenience overload** fails because `warning` does not have a two-argument overload accepting a message and `Throwable`.
-   **String concatenation** fails because it logs only text, not a separate exception object.
-   **Throwing trace** fails because `throwing` is not a warning-level message call and uses its own trace-style message.

---

### Q012 [Working with Arrays and Collections]

A report component fails to compile in Java 21:

```java
import java.util.*;

class ReportLoader {
    void load(List<String> keys)  { }
    void load(List<Integer> keys) { }
}
```

Callers must keep one method name, and the API may add one argument. The new API should reject mismatched element declarations at compile time and choose behavior even when the list is empty. Which refactor is the best fix?

**選項：**

- A. Dispatch with `keys instanceof List<String>` inside `load(List<?> keys)`.
- B. Overload `load(List<String>[] keys)` and `load(List<Integer>[] keys)`.
- C. Overload `load(List<? extends CharSequence>)` and `load(List<? extends Number>)`.
- D. Use `<T> void load(List<T> keys, Class<T> elementType)`.（✓ 正確）

**答：D。** Java erases generic type arguments, so `List<String>` and `List<Integer>` cannot distinguish overloaded methods. A `Class<T>` token supplies reifiable runtime information while the generic method signature keeps the list and token types aligned. It also works for empty lists because dispatch does not depend on inspecting elements.

Generic type arguments such as `String` and `Integer` are not preserved as distinct runtime method parameter types. Both original overloads erase to `load(List)`, causing a name clash. Runtime checks cannot use `instanceof List<String>` because `List<String>` is non-reifiable. A `Class<T>` parameter, however, is reifiable and can be compared at runtime, while `<T> void load(List<T>, Class<T>)` forces normal generic callers to pass a matching list type and token. An implementation might branch on `elementType.equals(String.class)` or `elementType.equals(Integer.class)`. The key takeaway is to avoid pretending erased element types are available at overload resolution or runtime.

-   **Wildcard overloads** still erase to `load(List)`, so the methods have the same erased signature.
-   **Parameterized `instanceof`** fails because `List<String>` is not a reifiable runtime type.
-   **Generic-array overloads** still erase to array parameters with `List` components and do not preserve element type arguments.

---

### Q013 [Controlling Program Flow]

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

**選項：**

- A. Label the outer loop and use `continue orderLoop;`.（✓ 正確）
- B. Replace the defect line with `break;`.
- C. Label the outer loop and use `break orderLoop;`.
- D. Move `submit(order)` inside the inner loop.

**答：A。** The requirement is to abandon the current outer-loop iteration but continue processing later orders. A labeled `continue` targeting the outer loop does exactly that from inside the nested loop. It skips `submit(order)` for the invalid order without terminating all order processing.

In nested loops, an unlabeled `continue` applies only to the innermost loop, so the original code merely skips the blank SKU. A labeled `continue` can target an enclosing loop, ending the current iteration of that loop and starting its next iteration. Here, placing a label before the outer `for` loop and using `continue orderLoop;` inside the inner loop skips remaining SKUs and bypasses `submit(order)` for that invalid order.

An unlabeled `break` would leave only the inner loop, so `submit(order)` would still run. A labeled `break` would stop processing all orders, which is too broad.

-   **Unlabeled break** exits only the SKU loop, so the invalid order can still be submitted.
-   **Labeled break** exits the entire labeled loop, so later orders are not processed.
-   **Moving submit** changes when submission happens and can submit an order multiple times.

---

### Q014 [Managing Concurrent Code Execution]

A service method must update stock only if it can obtain a `ReentrantLock` immediately. If the lock is unavailable, it must return `-1` without waiting. If it obtains the lock, it must release it even if the update logic later throws an unchecked exception. Which method body correctly applies the Java SE 21 lock rule?

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

**選項：**

- A. ```java
- B. ```java
- C. ```java
- D. ```java（✓ 正確）

**答：D。** `tryLock()` attempts to acquire the lock immediately and returns `false` if it cannot. A thread must call `unlock()` only after it has actually acquired the lock, and the release should be in a `finally` block to handle exceptions.

With explicit locks, acquisition and release are not automatic as they are with `synchronized`. The safe non-blocking pattern is to call `tryLock()`, check its boolean result, and only enter a `try`/`finally` region after acquisition is confirmed. If `tryLock()` returns `false`, the method should return without calling `unlock()`. Calling `unlock()` when the current thread does not hold the lock can throw `IllegalMonitorStateException`. Using `lock()` instead would release correctly but would not satisfy the requirement to avoid waiting when the lock is unavailable.

-   **Unconditional finally unlock** fails because a `return` after a failed `tryLock()` still executes `finally` and calls `unlock()` without ownership.
-   **Blocking acquisition** fails because `lock()` may wait until the lock becomes available.
-   **Missing release** fails because successful `tryLock()` acquisition must be paired with `unlock()`, preferably in `finally`.

---

### Q015 [Using Java I/O API]

A utility must count all `.log` files under `root`, including nested directories. A review flags this Java 21 method for potentially keeping directory resources open longer than necessary.

```java
long countLogs(Path root) throws IOException {
    return Files.walk(root)
            .filter(Files::isRegularFile)
            .filter(p -> p.toString().endsWith(".log"))
            .count();
}
```

Which refactor is the best fix?

**選項：**

- A. Replace `Files.walk(root)` with `Files.list(root)` and keep the pipeline.
- B. Add `.onClose(() -> {})` to the pipeline and leave it otherwise unchanged.
- C. Wrap `Files.walk(root)` in try-with-resources and run `count()` inside it.（✓ 正確）
- D. Replace it with `Files.find(...)` because that stream closes automatically.

**答：C。** `Files.walk` returns a lazy `Stream<Path>` that can hold open directory resources while it traverses. Terminal operations such as `count()` do not automatically close the stream, so try-with-resources is the appropriate refactor.

NIO.2 traversal methods such as `Files.list`, `Files.walk`, and `Files.find` return streams that should be closed after use. The safe pattern is to create the stream in a try-with-resources block and complete the pipeline inside that block.

```java
try (Stream<Path> paths = Files.walk(root)) {
    return paths
            .filter(Files::isRegularFile)
            .filter(p -> p.toString().endsWith(".log"))
            .count();
}
```

Changing traversal methods does not remove the closing requirement; it only changes what is traversed or how matching is expressed.

-   **Nonrecursive listing** fails because `Files.list` visits only direct entries and still returns a stream that should be closed.
-   **Automatic find close** is incorrect because `Files.find` also returns a resource-owning stream.
-   **onClose callback** fails because it registers an action for closing; it does not close the stream by itself.

---

### Q016 [Working with Streams and Lambda Expressions]

A batch job must process order numbers 100 through 104, including both endpoints, as primitive `int` values before a terminal operation such as `sum()`. Which declaration correctly creates the required stream?

**選項：**

- A. `IntStream orderNos = IntStream.rangeClosed(100, 104);`（✓ 正確）
- B. `IntStream orderNos = IntStream.range(100, 104);`
- C. `IntStream orderNos = Stream.of(100, 101, 102, 103, 104);`
- D. `Stream<Integer> orderNos = IntStream.rangeClosed(100, 104);`

**答：A。** `IntStream.rangeClosed(100, 104)` creates a primitive stream containing 100, 101, 102, 103, and 104. The key rule is that `rangeClosed` includes the upper bound, while `range` excludes it.

Primitive numeric ranges are created with the primitive stream types, such as `IntStream`. For `IntStream.range(start, end)`, the end value is exclusive. For `IntStream.rangeClosed(start, end)`, the end value is inclusive. Because the job needs primitive `int` values from 100 through 104, `IntStream.rangeClosed(100, 104)` matches both the type and the required bounds. A `Stream<Integer>` would require boxing, and `Stream.of(...)` creates a reference stream rather than an `IntStream`.

-   **Exclusive upper bound** fails because `IntStream.range(100, 104)` stops before 104.
-   **Wrong declared type** fails because an `IntStream` is not assignable to `Stream<Integer>` without boxing.
-   **Reference stream factory** fails because `Stream.of(...)` produces a `Stream<Integer>`, not an `IntStream`.

---

### Q017 [Logging API and Standard Annotations]

A developer is refactoring a subclass and wants the compiler to reject an accidental overload when the intent is to override the superclass method.

```java
class Base {
    void audit(Object value) { }
}

class Child extends Base {
    void audit(String value) { }
}
```

Which annotation use best matches this intent?

**選項：**

- A. Annotate `Base.audit(Object)` with `@Deprecated`.
- B. Annotate `Child` with `@FunctionalInterface`.
- C. Annotate `Child.audit(String)` with `@Override`.（✓ 正確）
- D. Annotate `Child.audit(String)` with `@SuppressWarnings`.

**答：C。** `@Override` is the standard annotation for verifying overriding intent. In the snippet, `audit(String)` overloads `audit(Object)` rather than overriding it, so adding `@Override` to the subclass method causes a compile-time error and exposes the mistake.

The core distinction is overload versus override. A method overrides only when its signature is compatible with an inherited method; changing the parameter from `Object` to `String` creates a different parameter list, so `Child.audit(String)` is an overload. `@Override` does not change method resolution, but it asks the compiler to check that overriding is really happening. If the check fails, compilation fails, which is exactly useful during refactoring.

`@Deprecated` communicates discouraged API use, `@SuppressWarnings` requests warning suppression, and `@FunctionalInterface` validates single-abstract-method interface intent. None of those annotations verifies that a subclass method overrides an inherited method.

-   **Deprecation intent** fails because `@Deprecated` marks an API as discouraged, not as an override check.
-   **Functional interface intent** fails because `Child` is a class, and the annotation is for functional interface declarations.
-   **Warning suppression** fails because `@SuppressWarnings` hides selected warnings; it does not validate method overriding.

---

### Q018 [Handling Exceptions]

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

```text
work
close B
close A
```

Which explanation best identifies the cause?

**選項：**

- A. The body exception is primary; resources close in reverse order.（✓ 正確）
- B. Close failures are ignored when the try block throws first.
- C. The last close failure replaces the exception from the try block.
- D. Resources close in declaration order, so `a` closes before `b`.

**答：A。** The `RuntimeException` from the try block is the primary exception. Java then closes `b` before `a`, and each close exception is added to the primary exception as a suppressed exception.

In a try-with-resources statement, resources are closed automatically after the try block, in the reverse order of their declaration. If the try block already threw an exception, that exception remains the primary exception. Any exceptions thrown while closing resources are not discarded; they are attached to the primary exception and returned by `getSuppressed()` in the order they were suppressed.

Here, `work` is printed first because it is the primary exception. Then `b` closes before `a`, so `close B` appears before `close A` in the suppressed exception list. The key troubleshooting point is that the observed output is specified behavior, not a resource leak or replacement of the original failure.

-   **Declaration order** is incorrect because try-with-resources closes resources from last declared to first declared.
-   **Exception replacement** is incorrect because the try-block exception remains primary when close also fails.
-   **Ignored close failures** is incorrect because close exceptions are available through `getSuppressed()`.

---

### Q019 [Packaging and Deploying Java Code]

A team is migrating an application to JPMS in Java 21. The application must remain a named module, but it uses a legacy JAR, `validator-2.0.jar`, that has no `module-info.class`. Its manifest contains `Automatic-Module-Name: com.vendor.validator`.

```java
module com.acme.orders {
    exports com.acme.orders.api;
}
```

The build currently places `com.acme.orders` on the module path and `validator-2.0.jar` on the class path. Code in `com.acme.orders` imports `com.vendor.validation.Validator`. What is the best fix?

**選項：**

- A. Move the JAR to the module path and add `requires validator;`.
- B. Keep the JAR on the class path and add `requires com.vendor.validator;`.
- C. Add `exports com.vendor.validation;` to `com.acme.orders`.
- D. Move the JAR to the module path and add `requires com.vendor.validator;`.（✓ 正確）

**答：D。** A named module cannot read classes from the unnamed module on the class path. Placing the non-modular JAR on the module path makes it an automatic module, and its manifest supplies the module name to use in `requires`.

During migration, a regular JAR without `module-info.class` is treated differently depending on where it is placed. On the class path, it belongs to the unnamed module, which cannot be required by a named module. On the module path, it becomes an automatic module: it has a module name, exports its packages, and can be required by named modules. Because this JAR declares `Automatic-Module-Name: com.vendor.validator`, the named application module should require `com.vendor.validator`. Using a filename-derived guess is not appropriate when the manifest supplies the automatic module name.

-   **Class path dependency** fails because the legacy JAR remains in the unnamed module, which `com.acme.orders` cannot require.
-   **Wrong module name** fails because the manifest name overrides any filename-derived automatic module name.
-   **Exporting vendor packages** fails because a module can export only its own packages, not packages from a dependency.

---

### Q020 [Working with Arrays and Collections]

In Java 21, consider this method signature:

```java
void copyInts(List<? extends Number> source,
              List<? super Integer> target) { ... }
```

Other than adding `null`, which statement describes calls that are type-safe at compile time?

**選項：**

- A. `Integer i = source.get(0);` and `target.add(Double.valueOf(1.0));`
- B. `Number n = source.get(0);` and `target.add(Integer.valueOf(1));`（✓ 正確）
- C. `source.add(Double.valueOf(1.0));` and `Number n = target.get(0);`
- D. `source.add(Integer.valueOf(1));` and `Integer i = target.get(0);`

**答：B。** This is the PECS rule: producer extends, consumer super. `List<? extends Number>` is safe to read from as `Number`, while `List<? super Integer>` is safe to add `Integer` values to.

With `List<? extends Number>`, the actual list might be `List<Integer>`, `List<Double>`, or another subtype of `Number`, so adding a specific non-null `Number` subtype is not safe. Reading is safe as `Number`. With `List<? super Integer>`, the actual list might be `List<Integer>`, `List<Number>`, or `List<Object>`, so adding an `Integer` is safe. Reading from it is only safe as `Object`, because the compiler does not know the exact supertype. The key distinction is whether the collection is mainly producing values for you or consuming values from you.

-   **Adding to extends** fails because `List<? extends Number>` could be a list of a different `Number` subtype.
-   **Reading from super** fails as `Integer` or `Number` because `List<? super Integer>` only guarantees values are safely read as `Object`.
-   **Adding Double to super** fails because the target could be a `List<Integer>`, which cannot accept `Double`.

---

### Q021 [Handling Date, Time, Text, Numeric, and Boolean Values]

Which statement accurately describes how Java 21 converts text block source text into the resulting `String` content?

**選項：**

- A. Only indentation before the opening delimiter is removed.
- B. Escapes are interpreted before incidental indentation is stripped.
- C. Line terminators are normalized, indentation is stripped, then escapes are interpreted.（✓ 正確）
- D. Platform-specific line terminators are preserved exactly.

**答：C。** Java text blocks apply a defined translation process before creating the final `String`. Line terminators are normalized to `\n`, incidental indentation is removed, and escape sequences such as `\s` are interpreted afterward.

A Java 21 text block is not copied into the `String` exactly as typed. The compiler first normalizes line terminators to line-feed characters, then removes incidental indentation and trailing whitespace, and only then interprets escape sequences. This ordering matters: for example, `\s` can be used to preserve a space that would otherwise be stripped as trailing whitespace. The key takeaway is that text blocks have predictable normalization and indentation rules before escape processing.

-   **Escape order** is wrong because escapes are not interpreted before indentation processing.
-   **Platform line endings** is wrong because text block line terminators are normalized, not preserved exactly.
-   **Opening delimiter indentation** is wrong because stripping is based on incidental indentation of the text block content and closing delimiter position.

---

### Q022 [Using Object-Oriented Concepts in Java]

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

**選項：**

- A. It prints `Derived:Number`.（✓ 正確）
- B. It prints `Base:Number`.
- C. It does not compile.
- D. It prints `Base:Integer`.

**答：A。** The code compiles and prints `Derived:Number`. The selected method signature is determined at compile time from the declared types, but the implementation for that signature is chosen at runtime from the actual receiver object.

This question combines overloading and overriding. Overload resolution happens first at compile time, using the declared type of `ref` (`Base`) and the declared type of `value` (`Number`). Therefore, the selected signature is `tag(Number)`, not `tag(Integer)`, even though the object stored in `value` is an `Integer`. After that signature is chosen, normal polymorphic dispatch applies to the receiver object. Since `ref` refers to a `Derived` instance and `Derived` overrides `tag(Number)`, the `Derived` implementation runs. The key takeaway is that argument runtime type does not redo overload resolution.

-   **Static dispatch only** fails because overridden instance methods are dispatched using the receiver’s runtime type.
-   **Runtime argument type** fails because overload selection uses the declared type `Number`, not the actual `Integer` object.
-   **Compilation failure** is not present because `@Override` correctly marks `Derived.tag(Number)` as an override.

---

### Q023 [Controlling Program Flow]

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

**選項：**

- A. It prints `12F`.（✓ 正確）
- B. It does not compile because `for (;;)` has no condition.
- C. It prints `01F`.
- D. It prints `12F` forever.

**答：A。** The code compiles and prints `12F`. A `while` loop checks its condition before the body, a `do` loop runs its body before checking, and `for (;;)` is a valid infinite loop declaration unless control flow exits it.

The core concept is loop entry and termination rules. The `while` condition `n++ < 0` is checked before the body; with `n` starting at `0`, the comparison is false, but `n` becomes `1`. The `do` loop then prints before checking its condition, so it prints `1`, checks `1 < 2`, increments to `2`, prints `2`, then checks `2 < 2` and stops. The `for (;;)` loop is legal Java syntax for an infinite loop, but the `break` statement exits after printing `F`. The key takeaway is that an infinite-loop declaration can still terminate through control flow inside the loop body.

-   **Skipped `while` body** means `W` is never printed, but the post-increment still changes `n`.
-   **Endless output** is avoided because `break` exits the `for (;;)` loop after one iteration.
-   **Missing `for` condition** is allowed in Java; all three `for` header expressions are optional.

---

### Q024 [Packaging and Deploying Java Code]

A modular application uses `ServiceLoader` to find plug-ins. The provider module is on the module path and declares a valid `provides` directive.

```java
module com.acme.catalog.api {
    exports com.acme.catalog.spi;
}

module com.acme.catalog.app {
    requires com.acme.catalog.api;
}
```

Code in `com.acme.catalog.app` calls `ServiceLoader.load(PricePlugin.class)`, where `PricePlugin` is in `com.acme.catalog.spi`. At run time, it fails with `ServiceConfigurationError` stating that `com.acme.catalog.app` does not declare `uses`. Which module-info change is the best next fix?

**選項：**

- A. Add `opens com.acme.catalog.spi to com.acme.catalog.app;` to the API module.
- B. Export `com.acme.catalog.spi` only to `com.acme.catalog.app`.
- C. Change the app dependency to `requires transitive com.acme.catalog.api;`.
- D. Add `uses com.acme.catalog.spi.PricePlugin;` to `com.acme.catalog.app`.（✓ 正確）

**答：D。** The failure is caused by a missing service-consumer declaration. In a named module, `ServiceLoader.load()` requires the consuming module to declare `uses` for the service interface, even when the service interface package is already exported and readable.

JPMS separates readability, package access, reflection access, and service use. `requires com.acme.catalog.api` lets the app read the API module, and `exports com.acme.catalog.spi` makes the service interface accessible. However, service lookup by a named module also needs an explicit `uses` directive in the consuming module:

```java
module com.acme.catalog.app {
    requires com.acme.catalog.api;
    uses com.acme.catalog.spi.PricePlugin;
}
```

`requires transitive` would expose a dependency to modules that require the app, which is not the issue here. `opens` is for reflective access, not service consumption.

-   **Transitive dependency** is unnecessary because no downstream module needs readability through `com.acme.catalog.app`.
-   **Opening the package** would affect reflection, but `ServiceLoader` is reporting a missing service-use declaration.
-   **Qualified export** would restrict compile-time access and does not replace the consumer module’s `uses` directive.

---

### Q025 [Working with Streams and Lambda Expressions]

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

**選項：**

- A. `(Integer a, Integer b) -> { return a + b; }`（✓ 正確）
- B. `(Integer a, b) -> a + b`
- C. `(a, b) -> { a + b; }`
- D. `(a, int b) -> a + b`

**答：A。** Lambda parameters must be either all explicitly typed or all inferred, unless using `var` consistently. A block body for a non-void functional method must return a value, so the fully typed lambda with `return` is valid for `BiFunction<Integer, Integer, Integer>`.

The target type is `BiFunction<Integer, Integer, Integer>`, whose functional method takes two `Integer` arguments and returns an `Integer`. A lambda may use explicit parameter types, such as `(Integer a, Integer b)`, or inferred parameter types, such as `(a, b)`, but it cannot mix the two forms. When the lambda body is a block, it must use `return` to provide a value for this non-void target method. An expression body like `a + b` can return the value directly, but a block body `{ a + b; }` is not a valid replacement here.

-   **Mixed parameter forms** fails because `(Integer a, b)` combines an explicit type with an inferred parameter.
-   **Partially typed parameters** fails because `(a, int b)` also mixes inferred and explicit parameter declarations.
-   **Block without return** fails because a block body for this `BiFunction` must return a value.

---

---

### Q026 [Managing Concurrent Code Execution]

In Java 21, a program starts a virtual-thread worker with `Thread.startVirtualThread(...)`. The main thread must print a status line only after that worker’s `Runnable` has finished, and the program must not depend on scheduler timing. Which API rule gives that lifecycle guarantee?

**選項：**

- A. Use `Thread.interrupt()`; it waits until the worker stops running.
- B. Use `Thread.sleep(long)`; it lets started workers finish before continuing.
- C. Use `Thread.yield()`; it hands execution to the worker deterministically.
- D. Use `Thread.join()`; when it returns normally, the worker has terminated.（✓ 正確）

**答：D。** `join()` is the lifecycle operation designed for this situation. When `join()` returns normally, the target thread has terminated, so the main thread can print after the worker is done without guessing about scheduling.

Thread lifecycle coordination should use a completion API, not timing hints. `Thread.startVirtualThread(...)` returns the `Thread` object representing the started virtual thread. Calling `join()` on that object makes the calling thread wait until the target thread terminates; it can throw `InterruptedException`, so the caller must handle or declare it. This rule applies to virtual threads as well as platform threads. Sleep, yield, and interrupt do not provide the same completion guarantee.

-   **Sleeping is not coordination** because a delay does not prove the worker has completed.
-   **Yield is only a hint** because the scheduler is not required to run a particular thread next.
-   **Interrupt is a signal** because it requests interruption but does not wait for termination.

---

### Q027 [Using Object-Oriented Concepts in Java]

A team is designing `com.acme.model.Order` for use by code in `com.acme.app`, a different package. Client code must create orders only through a validating factory method and read the order id through the public API. The id must not be directly accessible or assignable outside `Order`. Which declaration set best supports these requirements?

**選項：**

- A. `public final class Order`; `private final String id`; `private Order(String id)`; `public static Order of(String id)`; `public String id()`（✓ 正確）
- B. `public final class Order`; `public final String id`; `private Order(String id)`; `public static Order of(String id)`
- C. `public final class Order`; `private final String id`; `public Order(String id)`; `public static Order of(String id)`; `public String id()`
- D. `class Order`; `private final String id`; `private Order(String id)`; `public static Order of(String id)`; `public String id()`

**答：A。** For cross-package use, the top-level class and intended API methods must be `public`. Encapsulation is preserved by keeping the state field `private` and forcing construction through a `private` constructor plus a public static factory method.

Access modifiers control both visibility and encapsulation. A top-level class with no modifier is package-private, so code in `com.acme.app` could not use `com.acme.model.Order`. The id field should be `private` so callers cannot access it directly. A `private` constructor prevents callers from bypassing validation, while a `public static` factory method and public accessor provide the intended API.

The key distinction is public API surface versus private implementation details.

-   **Package-private type** fails because a different package cannot access a top-level class declared without `public`.
-   **Public field** fails because direct field access breaks the stated encapsulation requirement.
-   **Public constructor** fails because callers could create instances without using the validating factory.

---

### Q028 [Managing Concurrent Code Execution]

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

**選項：**

- A. Replace `thenApplyAsync` with `thenApply`.
- B. Use `Executors.newVirtualThreadPerTaskExecutor()`.
- C. Replace `result.join()` with `result.get()`.
- D. Move `pool.shutdown()` until after `result.join()` completes.（✓ 正確）

**答：D。** `thenApplyAsync(..., pool)` schedules the transformation on the supplied executor when the previous stage completes. In this code, the executor is shut down before `start.complete("cat")`, so the dependent task is rejected. Keeping the executor open until the composed future completes fixes the failure while preserving executor-backed execution.

A dependent async `CompletableFuture` stage is not necessarily submitted when the chain is created. For `thenApplyAsync(String::toUpperCase, pool)`, the action is dispatched to `pool` when `start` completes. Because `pool.shutdown()` is called first, the executor no longer accepts new tasks, so the dependent stage completes exceptionally and `join()` wraps that failure in `CompletionException`.

The key lifecycle rule is to shut down an executor after all tasks and dependent async stages that need it have completed.

-   **Waiting method** is not the issue; `get()` also observes the same failed completion.
-   **Non-async stage** avoids using the executor, but it does not meet the requirement to keep the transformation executor-backed.
-   **Virtual thread executor** still rejects new tasks after shutdown, so changing executor type does not fix the ordering bug.

---

### Q029 [Using Object-Oriented Concepts in Java]

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

**選項：**

- A. It compiles and prints `L`.
- B. It fails because both interfaces provide `tag()`.
- C. It fails unless `Child` overrides `tag()`.
- D. It compiles and prints `P`.（✓ 正確）

**答：D。** Java gives priority to a concrete method inherited from a class over default methods inherited from interfaces. Here, `Child` inherits `Parent.tag()`, so the two interface defaults do not create an unresolved conflict.

The core rule is often summarized as “classes win.” If a class inherits a concrete instance method from its superclass, that method overrides or hides consideration of matching interface default methods for conflict resolution. In the snippet, `Parent` provides a public `tag()` method, and `Child` extends `Parent` while implementing `Left` and `Right`. Because `Child` already has an inherited concrete implementation, it does not need to override `tag()`, and the call dispatches to `Parent.tag()`. If `Child` implemented only `Left` and `Right` without a class implementation, then it would need to resolve the conflicting defaults explicitly.

-   **Interface conflict only** fails as a distractor because the superclass method resolves the conflict before `Child` must choose between defaults.
-   **Mandatory override** would apply if only conflicting interface defaults were inherited, not when a concrete class method is inherited.
-   **First interface wins** is not a Java rule; interface order in the `implements` clause does not select a default method.

---

### Q030 [Handling Date, Time, Text, Numeric, and Boolean Values]

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

**選項：**

- A. Assign or chain the returned `LocalDate` values.（✓ 正確）
- B. Replace both day calculations with `Period.between`.
- C. Attach the system default `ZoneId` before comparing.
- D. Call `until` before `between` to avoid consuming `target`.

**答：A。** The wrong output occurs because `LocalDate` is immutable. Methods such as `plusDays`, `minusDays`, and `withDayOfMonth` return adjusted copies rather than changing the existing object. Since the returned values are ignored, `target` remains equal to `start`, so both `between` and `until` return 0 days.

The core concept is immutability in the `java.time` API. `LocalDate.plusDays`, `LocalDate.minusDays`, and `LocalDate.withDayOfMonth` do not modify the receiver; each returns a new adjusted `LocalDate`. In the snippet, those returned objects are discarded, so `target` is still `2025-03-10`. `ChronoUnit.DAYS.between(start, target)` and `start.until(target, ChronoUnit.DAYS)` are queries that compute the amount from the first date to the second; they do not change either date. Reassigning with `target = target.plusDays(5).withDayOfMonth(20).minusDays(2);` makes `target` `2025-03-18`, producing an 8-day difference.

-   **Period replacement** still observes the unchanged `target`, so it does not fix the ignored adjustments.
-   **Zone attachment** is irrelevant because `LocalDate` has no time zone component.
-   **Consumption myth** fails because `between` and `until` are read-only calculations, not mutating operations.

---

### Q031 [Packaging and Deploying Java Code]

A team is migrating an application to JPMS. `com.store.app` is an explicit named module launched from the module path. `billing-api.jar` has no module descriptor, has `Automatic-Module-Name: billing.api`, and is on the module path. `legacy-util.jar` has no descriptor and remains on the class path; only `billing-api.jar` uses it internally. Which entry correctly belongs in `com.store.app`’s module declaration?

**選項：**

- A. `requires ALL-UNNAMED;`
- B. `requires billing.api;`（✓ 正確）
- C. `requires legacy.util;`
- D. Omit `requires` because descriptorless JARs are unreadable.

**答：B。** `billing-api.jar` becomes an automatic module because it is on the module path without a descriptor. Its stable module name comes from `Automatic-Module-Name`, so an explicit named module can use `requires billing.api;`.

JPMS distinguishes where code is placed during migration. `com.store.app` is an explicit named module because it has `module-info.java`. `billing-api.jar` is an automatic module because it is a non-modular JAR on the module path, and its module name is `billing.api`. `legacy-util.jar` is in the unnamed module because it remains on the class path. A named module can require the automatic module, but it cannot declare a dependency on the unnamed module in `module-info.java`. Automatic modules help migration by being able to read class-path code, so `billing-api.jar` can keep its internal dependency while the app requires only `billing.api`.

-   **Classpath dependency** fails because `legacy-util.jar` is in the unnamed module and cannot be named in a `requires` directive.
-   **ALL-UNNAMED** is a command-line target in some options, not a valid module name in `module-info.java`.
-   **Descriptorless unreadable** is wrong because a descriptorless JAR on the module path becomes an automatic module.

---

### Q032 [Using Object-Oriented Concepts in Java]

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

**選項：**

- A. Make `GiftBox` implement `Shippable` and define `weight()`.（✓ 正確）
- B. Add a protected no-argument constructor to `Box`.
- C. Declare `Box` as an abstract record.
- D. Remove `implements Shippable` because records cannot implement interfaces.

**答：A。** A record class is implicitly final and cannot be subclassed. It can implement interfaces, and its component accessor can satisfy an interface method such as `weight()`. The fix is to model `GiftBox` as its own `Shippable` type rather than as a subclass of `Box`.

In Java 21, a record is a special kind of class intended for transparent, shallowly immutable data carriers. A record implicitly extends `java.lang.Record` and is implicitly final, so no class can extend `Box`. However, records can implement interfaces, and the `weight` component creates a `weight()` accessor that satisfies `Shippable.weight()`. If `GiftBox` needs to participate in the same polymorphic API, it should implement `Shippable` itself and provide the required behavior. The key distinction is that interfaces are valid for records, but inheritance from a record is not.

-   **Abstract record** fails because records cannot be made abstract base classes for subclasses.
-   **Interface removal** misidentifies the issue; records are allowed to implement interfaces.
-   **Protected constructor** does not help because the subclassing attempt is blocked before constructor access matters.

---

### Q033 [Using Object-Oriented Concepts in Java]

A utility method should return the stripped length only when `value` is a nonblank `String`; otherwise it should return `0`. The current Java 21 code does not compile.

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

**選項：**

- A. Use `value instanceof String s && !s.isBlank()` in the `if` condition.（✓ 正確）
- B. Use `value instanceof String s || s.isBlank()` in the `if` condition.
- C. Cast first with `String s = (String) value;` before the `if`.
- D. Use `value instanceof var s && !s.isBlank()` in the `if` condition.

**答：A。** Pattern matching for `instanceof` introduces a pattern variable only where the compiler can prove the match succeeded. In this case, `&&` is the right operator because the blank check and body execute only after `value` is known to be a `String`.

A type pattern such as `value instanceof String s` both tests the runtime type and declares `s` as a `String` in the scope where the match is definitely true. With `&&`, the right operand is evaluated only if the left operand is true, so `s` can be used in `!s.isBlank()` and inside the `if` body. With `||`, the right operand may be evaluated when the left operand is false, so `s` is not safely available there.

The key takeaway is that pattern variables follow definite-match scope rules, not simple textual declaration rules.

-   **Using `||`** fails because `s` is not definitely matched when the right side of the expression might run.
-   **Casting first** compiles but can throw `ClassCastException` for non-`String` inputs, violating the required behavior.
-   **Using `var` pattern** is not valid Java 21 syntax for an `instanceof` type pattern.

---

### Q034 [Working with Streams and Lambda Expressions]

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

**選項：**

- A. `ot` and `ut` are both `[2, 4, 6]`; `od` and `ud` are both `[7, 8, 10]`.
- B. `ut` may contain `7`; `ud` may drop `7` because unordered streams ignore the predicate boundary.
- C. `ot` is `[2, 4, 6]`; `od` is `[7, 8, 10]`; `ut` may be a subset of evens and `ud` must retain `7`.（✓ 正確）
- D. `ot` and `ut` contain all even values; `od` and `ud` contain only `[7]`.

**答：C。** The ordered streams have a defined prefix: `takeWhile` stops before `7`, and `dropWhile` removes only that matching prefix. After `.unordered()`, Java does not define a first-element boundary, so results follow subset rules rather than the original list prefix.

For an ordered stream, `takeWhile` returns the longest prefix whose elements match the predicate, so `ot` is `[2, 4, 6]`. `dropWhile` drops that same matching prefix and returns the remaining ordered elements, so `od` is `[7, 8, 10]`. Calling `.unordered()` removes the encounter-order constraint for downstream operations. For unordered `takeWhile`, the result may be any subset of elements that match the predicate. For unordered `dropWhile`, the operation may drop any subset of matching elements, but nonmatching elements such as `7` are retained. The key distinction is prefix behavior versus unordered subset behavior.

-   **List source assumption** fails because `.unordered()` removes the encounter-order constraint for downstream operations.
-   **Filter-style reasoning** fails because `takeWhile` and `dropWhile` are not full-stream even/odd filters.
-   **Predicate ignored** fails because unordered operations still use the predicate; `takeWhile` cannot include `7`, and `dropWhile` cannot drop it.

---

### Q035 [Controlling Program Flow]

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

**選項：**

- A. `E`
- B. `C`（✓ 正確）
- C. `D`
- D. `B`

**答：B。** The code enters the outer `else if` because `x > 5` is false and `y < 10` is true. Inside that block, `4 + 9 > 13` is false, but `9 % 4 == 1` is true, so the nested `else if` assigns the printed value.

In an `if`/`else if` chain, Java evaluates conditions from top to bottom and executes only the first matching branch in that chain. Here, `x > 5` is false, so control moves to `y < 10`, which is true. The nested chain then starts: `x + y > 13` means `13 > 13`, which is false. The next nested condition, `y % x == 1`, means `9 % 4 == 1`, which is true. That branch assigns the value that is printed. The key point is that exact boolean results decide the path; close numeric comparisons such as `13 > 13` do not pass.

-   **Greater-than boundary** fails because `13 > 13` is false; the operator is not `>=`.
-   **Nested fallback** is skipped because the nested `else if` condition succeeds first.
-   **Outer fallback** is skipped because `y < 10` is true, so the final outer `else` is not reached.

---

### Q036 [Managing Concurrent Code Execution]

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

**選項：**

- A. It does not compile because `run()` cannot be invoked directly.
- B. It prints `worker worker` , then throws `IllegalThreadStateException`.
- C. It prints `driver worker` , then throws `IllegalThreadStateException`.（✓ 正確）
- D. It prints `driver worker worker` and terminates normally.

**答：C。** The program compiles because `run()` is an ordinary public method. Calling `run()` directly does not start a new thread, while `start()` starts the thread once. After that thread has terminated, calling `start()` again on the same `Thread` object throws `IllegalThreadStateException`.

A `Thread` object starts in the new state. Invoking its `run()` method directly is just a normal method call, so the lambda runs on the current main thread, whose name was changed to `driver`. Calling `start()` then creates the separate thread of execution named `worker`; `join()` waits until that worker finishes printing. A `Thread` instance cannot be restarted after it has been started, even if it has already terminated, so the final `start()` call throws `IllegalThreadStateException` at runtime.

The key distinction is that `run()` executes code synchronously on the current thread, while `start()` changes the thread lifecycle state and can be used only once per `Thread` object.

-   **New-thread assumption** fails because directly invoking `run()` does not switch execution to the `worker` thread.
-   **Reusable thread** fails because a `Thread` instance cannot be started a second time after termination.
-   **Compile-time rejection** fails because `run()` is callable like any other public instance method.

---

### Q037 [Logging API and Standard Annotations]

A reviewer is checking uses of `@Override`, `@FunctionalInterface`, `@Deprecated`, `@SuppressWarnings`, and `@SafeVarargs` in Java 21 code. Which rule is correct?

**選項：**

- A. `@Deprecated` prevents new source code from compiling against the annotated element.
- B. `@SafeVarargs` may annotate a varargs constructor or a varargs method that is static, final, or private.（✓ 正確）
- C. `@Override` is valid only when overriding a concrete superclass method.
- D. `@FunctionalInterface` disallows default and static methods in the annotated interface.

**答：B。** `@SafeVarargs` documents that a varargs method or constructor performs no unsafe operations on its varargs parameter. In Java 21, it is valid only on variable-arity constructors or variable-arity methods that are static, final, or private.

Standard annotations express compile-time intent; they do not generally change runtime behavior. `@SafeVarargs` is specifically for suppressing heap-pollution warnings from safe varargs use, but Java restricts it to declarations that cannot be overridden: constructors, and static, final, or private varargs methods. This matters because an overridable method could be replaced by unsafe behavior in a subclass. By contrast, annotations such as `@Deprecated`, `@Override`, and `@FunctionalInterface` communicate different compile-time checks or warnings.

-   **Interface methods** are included for `@Override`; a method implementing an interface method can use it.
-   **Deprecation warning** does not make use of the element a compilation error.
-   **Functional interface shape** allows default and static methods as long as there is exactly one abstract method.

---

### Q038 [Logging API and Standard Annotations]

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

**選項：**

- A. `info()`, `warning()`, and `severe()`
- B. `info()` only
- C. `warning()` and `severe()` only（✓ 正確）
- D. All standard-level log calls

**答：C。** A `Logger` level and a `Handler` level are both applied. The logger first decides whether the record is loggable, and each handler then applies its own threshold. With `INFO` on the logger and `WARNING` on the handler, only `WARNING` and `SEVERE` pass both checks.

In `java.util.logging`, setting a logger level does not force attached handlers to publish every accepted record. A record must be loggable for the logger, then loggable for the handler. Standard levels become more severe from `FINEST` up to `SEVERE`; `INFO` allows `INFO`, `WARNING`, and `SEVERE`, while `WARNING` allows `WARNING` and `SEVERE`. The overlap is therefore `WARNING` and `SEVERE`. The closest trap is assuming the logger level alone controls output, but handlers independently filter records.

-   **Logger-only filtering** fails because the handler still rejects `INFO` records.
-   **Exact level matching** is not required; thresholds include more severe levels.
-   **All levels** fails because levels below `INFO` are rejected before handler publication.

---

### Q039 [Handling Date, Time, Text, Numeric, and Boolean Values]

A test team runs this Java 21 program, but the question does not specify the machine’s default time zone. What is the result?

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

**選項：**

- A. It always prints `2025-03-29` because local dates are behind UTC.
- B. It does not compile because `ofInstant` requires a `ZoneOffset`.
- C. It compiles, but the printed date depends on the default time zone.（✓ 正確）
- D. It always prints `2025-03-30` because the `Instant` is UTC.

**答：C。** The code compiles, but the output is not fixed by the snippet. `Instant` represents a moment in UTC, while `LocalDate.ofInstant` needs a zone to convert that moment to a calendar date, and the code uses the JVM’s default zone.

The core issue is reliance on an unspecified default time zone. `Instant.parse("2025-03-30T00:30:00Z")` creates a fixed moment, but `LocalDate.ofInstant(stamp, ZoneId.systemDefault())` converts that moment using the machine’s default zone. In a zone west of UTC, the local date could still be March 29; in UTC or many zones east of UTC, it is March 30. Since the stem does not provide the default zone, an exact printed date cannot be asserted. Use an explicit `ZoneId`, such as `ZoneId.of("UTC")`, when a deterministic result is required.

-   **UTC assumption** fails because an `Instant` is UTC-based, but converting it to `LocalDate` applies a time zone.
-   **West-of-UTC assumption** fails because not every runtime default zone is west of UTC.
-   **ZoneOffset requirement** is incorrect because `LocalDate.ofInstant` accepts any `ZoneId`, including the system default.

---

### Q040 [Implementing Localization]

A reporting service receives an `Instant` and must produce a localized date-time string using `FormatStyle.LONG`. The output must use French language/conventions and the `Europe/Paris` civil time, regardless of the JVM defaults. Which formatter setup best satisfies this requirement before calling `format(instant)`?

**選項：**

- A. `ofLocalizedDateTime(LONG).withZone(ZoneId.of("Europe/Paris"))`
- B. `ofLocalizedDateTime(LONG).withLocale(Locale.FRANCE)`
- C. `ofPattern("dd MMMM uuuu HH:mm").withLocale(Locale.FRANCE)`
- D. `ofLocalizedDateTime(LONG).withLocale(Locale.FRANCE).withZone(ZoneId.of("Europe/Paris"))`（✓ 正確）

**答：D。** Localized date-time formatting separates presentation locale from time zone. `Locale.FRANCE` controls language and localized conventions, while `ZoneId.of("Europe/Paris")` supplies the civil time needed to format an `Instant`.

`DateTimeFormatter.ofLocalizedDateTime(FormatStyle.LONG)` creates a formatter whose date and time layout are localized. The locale controls text such as month names and ordering conventions, but it does not choose a time zone. An `Instant` represents a point on the timeline and has no calendar date or local time until a zone is supplied. Chaining both `withLocale(Locale.FRANCE)` and `withZone(ZoneId.of("Europe/Paris"))` makes the output independent of JVM defaults.

The key distinction is that locale affects how temporal values are displayed; zone affects which local date and time the instant becomes.

-   **Locale only** fails because an `Instant` still needs a zone to become a local date-time.
-   **Zone only** fails because the language and localized conventions could still come from the default locale.
-   **Custom pattern** avoids the localized style requirement and still omits the Paris zone.

---

### Q041 [Packaging and Deploying Java Code]

A migration team is compiling `app` as a named module. `util-api.jar` has no `module-info.class`, contains public class `util.Tool`, is on the module path, and has `Automatic-Module-Name: util.api`. `legacy.jar` has no `module-info.class`, contains public class `legacy.Helper`, and is on the class path.

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

**選項：**

- A. Compilation succeeds and the program prints both names.
- B. Compilation fails because `app` cannot read the unnamed module.（✓ 正確）
- C. Compilation fails because automatic modules cannot be required.
- D. Compilation succeeds, but running throws `NoClassDefFoundError`.

**答：B。** The automatic JAR on the module path becomes a named automatic module, so `requires util.api;` is legal. The class-path JAR is in the unnamed module, and an explicit named module such as `app` does not read the unnamed module.

During module migration, a JAR without a module descriptor becomes an automatic module only when placed on the module path. That module has a name and can be required by an explicit named module. A JAR on the class path belongs to the unnamed module. Code in a named module cannot depend on packages from the unnamed module, so the import of `legacy.Helper` prevents `app` from compiling. The failure occurs before runtime; it is not a class-loading exception after successful compilation.

-   **Automatic module rule** fails as a distractor because `util.api` is a valid automatic module name supplied by the manifest.
-   **Runtime failure** is too late because the named module cannot compile against `legacy.Helper` from the class path.
-   **Both names printed** assumes named modules read the unnamed module, which JPMS does not allow.

---

### Q042 [Using Java I/O API]

A method receives a `BufferedReader br` and a `Writer out`. The input contains at least five characters, and no mark has been set before the fragment starts. The method must read the first character into `first`, reset to the beginning, skip the first five characters, transfer the remaining characters to `out`, and flush the destination. The method declares `throws IOException`. Which fragment is valid Java SE 21 and meets the goal?

**選項：**

- A. `br.mark(10); int first = br.read(); br.reset(); br.skip(5); br.transferTo(out); out.flush();`（✓ 正確）
- B. `br.mark(10); int first = br.read(); br.reset(); out.skip(5); out.transferTo(br); br.flush();`
- C. `int first = br.read(); br.reset(); br.skip(5); br.transferTo(out); out.flush();`
- D. `br.mark(10); int first = br.read(); br.skip(5); br.reset(); br.transferTo(out); out.flush();`

**答：A。** The valid sequence uses source-side operations on the `BufferedReader` and destination-side flushing on the `Writer`. `Reader.transferTo(Writer)` copies remaining characters from the reader to the writer, so the reset and skip must happen before that transfer.

In Java I/O, `read()`, `skip()`, `mark()`, and `reset()` are operations on a character source such as `BufferedReader`. A `BufferedReader` supports marking, but `reset()` requires a valid earlier mark. `Reader.transferTo(Writer)` then copies all remaining characters from the source reader to the destination writer; it is not a `Writer` method and it does not replace `flush()`. In the valid fragment, the code marks before peeking, resets to the beginning, skips five characters, transfers the rest, and finally flushes `out`. Skipping before `reset()` would be undone by the reset.

-   **Missing mark** fails because `reset()` requires a valid prior mark on the `BufferedReader`.
-   **Skip before reset** fails because the reset returns to the mark, undoing the skip before transfer.
-   **Wrong endpoint** fails because `Writer` has no `skip()` or `transferTo()` method, and readers are not flushed.

---

### Q043 [Handling Exceptions]

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

**選項：**

- A. `TCRF:IllegalArgumentException`（✓ 正確）
- B. `2`
- C. `TCF:IllegalArgumentException`
- D. `TCRF:IllegalStateException`

**答：A。** A `finally` block runs after the `try` or `catch` path starts to complete, including when that path has a pending `return`. The `return value()` expression is evaluated before `finally`, but the exception thrown from `finally` replaces the pending return.

In Java, a `return` from a `catch` block is not completed until the associated `finally` block has run. Here, the `try` appends `T` and throws `IllegalStateException`; the `catch` appends `C` and evaluates `value()`, which appends `R` and prepares to return `2`. Before that return can leave `run()`, `finally` appends `F` and throws `IllegalArgumentException`. That new exception prevents the pending return from completing, so `main` catches `IllegalArgumentException` and prints the accumulated log with its simple class name.

-   The plain `2` result ignores that `finally` runs before a pending `return` completes.
-   The original-exception result ignores that the `IllegalStateException` was caught before `finally` threw a new exception.
-   The `TCF` log misses that the catch block’s return expression is evaluated before entering `finally`.

---

### Q044 [Handling Date, Time, Text, Numeric, and Boolean Values]

Assume the Java runtime uses the IANA time-zone rule that in `America/New_York` on March 9, 2025, clocks move forward from 02:00 to 03:00, changing the offset from `-05:00` to `-04:00`. What is the result of running this Java 21 code?

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

**選項：**

- A. It prints `2025-03-09T03:30-04:00[America/New_York]` and `120`.
- B. It prints `2025-03-09T03:30-04:00[America/New_York]` and `60`.（✓ 正確）
- C. It throws `DateTimeException` because 02:30 does not exist.
- D. It prints `2025-03-09T02:30-05:00[America/New_York]` and `60`.

**答：B。** The code compiles and runs. `start` is a valid local time before the DST gap, and `plusHours(1)` advances the actual instant by one hour, landing at 03:30 after the clock jump. The elapsed duration is still 60 minutes.

`ZonedDateTime` combines a local date-time with zone rules. In this stem, 02:00 through 02:59 does not exist in `America/New_York` on that date, so adding one hour from 01:30 crosses directly to 03:30 with offset `-04:00`. `Duration.between(start, later)` measures elapsed time on the instant timeline, not the apparent wall-clock label difference, so it reports 60 minutes.

The key takeaway is that DST gaps can skip local clock times without making elapsed time larger.

-   **Nonexistent local time** fails because the result cannot be `02:30-05:00` in the supplied zone rules.
-   **Wall-clock subtraction** fails because `Duration` measures elapsed instants, not the numeric difference between local hour labels.
-   **Exception assumption** fails because the original `01:30` is valid, and `plusHours` resolves through the DST transition.

---

### Q045 [Managing Concurrent Code Execution]

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

**選項：**

- A. Submit a `Callable<String>` to a virtual-thread executor.（✓ 正確）
- B. Add `throws IOException` to `start` and keep the `Runnable`.
- C. Submit a `Runnable` and return `Future<String>`.
- D. Pass a `Callable<String>` directly to `Thread.startVirtualThread`.

**答：A。** `Runnable.run()` does not declare checked exceptions and does not produce a result. `Callable.call()` declares `throws Exception` and returns a value, making it the better fit when a concurrent task may throw `IOException` and must provide a result through `Future`.

The defect is caused by targeting the lambda to `Runnable`, because `Thread.startVirtualThread` accepts a `Runnable`. A `Runnable` task cannot throw `IOException` from its `run()` method, and it cannot return the loaded text. Refactoring the work into a `Callable<String>` and submitting it to an executor, such as one created by `Executors.newVirtualThreadPerTaskExecutor()`, matches both requirements: the task can return the file contents, and checked exceptions are captured for the caller. When the caller invokes `Future.get()`, the loaded string is returned, or the failure is reported as an `ExecutionException` whose cause may be the `IOException`. The key distinction is that `Runnable` is for fire-and-forget work, while `Callable` is for result-bearing work that may throw checked exceptions.

-   **Direct virtual thread call** fails because `Thread.startVirtualThread` accepts `Runnable`, not `Callable`.
-   **Declaring IOException** fails because the checked exception occurs inside `Runnable.run()`, whose signature cannot throw it.
-   **Runnable Future result** fails because a `Runnable` does not compute and return the file contents.

---

### Q046 [Using Object-Oriented Concepts in Java]

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

**選項：**

- A. It prints `6 9 3 13`.
- B. It does not compile because `sum(data)` is invalid.
- C. It prints `6 9 3 2`.
- D. It does not compile because `count(6, 7)` is invalid.（✓ 正確）

**答：D。** The varargs method `sum(int...)` can be called with either an `int[]` or repeated `int` arguments. The method `count(int[])` is not varargs, so it cannot be called as `count(6, 7)`. Compilation fails before any output is produced.

In Java, a varargs parameter such as `int... nums` is treated like an array parameter inside the method, but it changes what calls are allowed. Callers may pass either one compatible array or zero or more individual `int` arguments. A normal array parameter such as `int[] nums` has no such call-site flexibility; the caller must pass a single `int[]` value. Here, `sum(data)` and `sum(4, 5)` are valid, and `count(data)` is valid. The final call, `count(6, 7)`, supplies two separate `int` arguments to a method that requires one `int[]`, so the class does not compile.

-   **Printed output** assumes `count` is varargs, but `count` has a plain `int[]` parameter.
-   **Array to varargs** is allowed, so `sum(data)` is not the compilation problem.
-   **Runtime behavior** is never reached because overload checking fails at compile time.

---

### Q047 [Handling Exceptions]

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

**選項：**

- A. Initialize `br` before `try`, use `try (br; label)`, and keep the multi-catch.
- B. Declare `br` in `try`, move `label` inside, and keep `FileNotFoundException | IOException`.
- C. Declare `br` in `try`, move `label` inside, catch `IOException`, and remove `finally`.（✓ 正確）
- D. Declare `br` in `try`, move `label` inside, catch `IOException`, and keep the `finally` return.

**答：C。** The best refactor makes the reader the only try-with-resources resource, because `BufferedReader` is `AutoCloseable`. It also replaces the invalid multi-catch with a single `IOException` catch and removes the `finally` return that would override the method’s real result or exception.

A try-with-resources header must contain resource declarations or valid resource variables whose types implement `AutoCloseable`; an assignment such as `br = ...` is not a resource declaration, and `StringBuilder` is not closeable. Multi-catch alternatives cannot be related by subclassing, so `FileNotFoundException | IOException` is invalid because `FileNotFoundException` is an `IOException`; additionally, a multi-catch parameter is implicitly final and cannot be reassigned. A `return` in `finally` runs after the `try` or `catch` and can mask both normal returns and thrown exceptions. The clean fix is to declare the `BufferedReader` in the resource list, use `StringBuilder` as a normal local variable, catch `IOException`, and omit the `finally` return.

-   **Resource misuse** remains when `StringBuilder` is treated as a resource, because it does not implement `AutoCloseable`.
-   **Related multi-catch** remains invalid even without reassignment, because `FileNotFoundException` is a subtype of `IOException`.
-   **Finally return** may compile, but it violates the requirement by hiding the returned line or the wrapped exception.

---

### Q048 [Working with Arrays and Collections]

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

**選項：**

- A. Both fragments compile and store `3.14` successfully.
- B. Both fragments compile, but both fail at runtime.
- C. Fragment 1 compiles but throws `ArrayStoreException`; Fragment 2 does not compile.（✓ 正確）
- D. Fragment 1 does not compile; Fragment 2 compiles but throws `ClassCastException`.

**答：C。** The array assignment is legal because Java arrays are covariant: an `Integer[]` can be referenced as a `Number[]`. The attempted `Double` store is rejected at runtime. Generic collections are invariant, so `List<Integer>` cannot be assigned to `List<Number>` at compile time.

Array covariance means `Integer[]` is considered a subtype of `Number[]`, so `Number[] numbers = values;` compiles. However, the actual array object is still an `Integer[]`, and arrays perform a runtime store check. Assigning `3.14` boxes to `Double`, which cannot be stored in an `Integer[]`, causing `ArrayStoreException`. Generics are different: `List<Integer>` is not a subtype of `List<Number>`, even though `Integer` is a subtype of `Number`. The compiler rejects `List<Number> numbersList = valuesList;` to prevent adding a non-`Integer` value through the wider reference. The key distinction is runtime checking for covariant arrays versus compile-time invariance for generic types.

-   **Reversed behavior** is wrong because the array assignment compiles, while the generic assignment does not.
-   **Both runtime failures** is wrong because Fragment 2 is rejected before runtime.
-   **Successful storage** is wrong because the actual array type remains `Integer[]`, so storing a `Double` is invalid.

---

### Q049 [Working with Arrays and Collections]

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

**選項：**

- A. Create `new Box<T>()` inside `first` before returning
- B. Change `items` to `private static final List<T> items`
- C. Declare `first` as `static <T> T first(List<T> list)`（✓ 正確）
- D. Change the class declaration to `class Box<static T>`

**答：C。** The class type parameter `T` belongs to instances of `Box<T>`, not to the class itself. A static method has no instance-specific `T`, so the method must declare its own type parameter with `static <T> T first(...)`.

In a generic class, the type parameter declared on the class is available to instance fields, instance methods, and constructors. Static members are associated with the class, not with a particular `Box<String>` or `Box<Integer>` instance, so they cannot refer to the class’s `T`. To make `first` generic, declare a method type parameter before the return type: `static <T> T first(List<T> list)`. That `T` is scoped to the method and is inferred from the argument at each call site. The key distinction is class-level type parameters for instances versus method-level type parameters for static utilities.

-   **Static type parameter syntax** like `class Box<static T>` is not valid Java syntax.
-   **Static generic field** does not solve the problem because it still tries to use the instance type parameter `T` from a static context.
-   **Creating an instance** cannot make the class type parameter available to the static method signature.

---

### Q050 [Handling Exceptions]

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

**選項：**

- A. Remove `throws IOException` from `readConfig()`.
- B. Declare `run()` with `throws IOException`.
- C. Change the handler to `catch (Exception e)`.
- D. Declare `load()` with `throws IOException`.（✓ 正確）

**答：D。** A checked exception must be caught or declared at each method boundary where it can escape. `readConfig()` declares `IOException`, so `load()` must either handle it or declare it. Declaring it on `load()` lets the exception propagate to `run()` as intended.

Exception propagation follows the call stack, but checked exceptions are verified at compile time one method at a time. Because `load()` calls `readConfig()`, and `readConfig()` declares `throws IOException`, `load()` cannot ignore that possibility. If `load()` declares `throws IOException`, the exception can move up to `run()`, where the existing `catch (IOException e)` handles it and prints `recovered`.

Adding `throws` only to a higher method does not fix the unchecked boundary inside `load()`. The method that directly calls the checked-exception method must catch or declare it.

-   **Higher declaration only** fails because `load()` still directly calls a method that declares a checked exception.
-   **Broader catch** in `run()` does not remove `load()`’s compile-time responsibility.
-   **Removing the declaration** from `readConfig()` makes its own `throw new IOException(...)` invalid unless handled there.

---

---

