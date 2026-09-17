# 1Z0-830 Java SE 21 Developer — OpenExamPrep 免費題庫 182 題（全）

> 來源：OpenExamPrep 官方 JSON 資料 https://open-exam-prep.com/practice/oracle-java-se21（免費、免註冊）
> data/question-bank/oracle-java-se21.json，共 182 題，含題目、選項、正確答案與詳解。
> 整理時間：2026-09-17 · 難度標示：EASY / MEDIUM / HARD


---

## Java 21 新特性（25 題）

### Q001 [EASY] What is a record in Java 21?

- A. A type of logging mechanism
- B. A compact, immutable data carrier class that auto-generates constructor, accessors, equals(), hashCode(), and toString()（✓ 正確）
- C. A database table reference
- D. A type of annotation

**答：B。** Records, introduced as a preview in Java 14 and finalized in Java 16, are compact classes designed as transparent carriers for immutable data. A record automatically generates a canonical constructor, accessor methods, equals(), hashCode(), and toString() based on its components, reducing boilerplate code significantly.

### Q002 [EASY] What is a sealed class in Java 21?

- A. A class that cannot be instantiated
- B. A class that restricts which other classes can extend or implement it using the 'permits' clause（✓ 正確）
- C. A class stored in a sealed JAR file
- D. A final class with no methods

**答：B。** Sealed classes, finalized in Java 17, restrict which classes can extend them by using the 'sealed' modifier and a 'permits' clause listing the allowed subclasses. This gives developers explicit control over their class hierarchies and works well with pattern matching in switch expressions.

### Q003 [EASY] What are virtual threads in Java 21?

- A. Threads that run in a virtual machine only
- B. Lightweight threads managed by the JVM that enable high-throughput concurrent applications without the overhead of platform threads（✓ 正確）
- C. Threads used in virtual reality applications
- D. Simulated threads for testing

**答：B。** Virtual threads, finalized in Java 21 (JEP 444), are lightweight threads managed by the JVM rather than the operating system. They enable applications to create millions of concurrent threads with minimal memory overhead, making it practical to use a thread-per-request model for high-throughput I/O-bound applications.

### Q004 [EASY] What is pattern matching for instanceof in Java 21?

- A. A regex matching feature
- B. An enhancement where instanceof checks can include a pattern variable that is automatically cast, eliminating explicit cast statements（✓ 正確）
- C. Matching design patterns
- D. Pattern recognition for image processing

**答：B。** Pattern matching for instanceof (finalized in Java 16) allows combining a type check and cast in a single expression. For example, 'if (obj instanceof String s)' both checks the type and creates a variable 's' of type String, eliminating the need for a separate explicit cast.

### Q005 [EASY] What is a text block in Java?

- A. A block of commented-out text
- B. A multi-line string literal delimited by triple quotes (""") that preserves formatting and reduces the need for escape sequences（✓ 正確）
- C. A text input field
- D. A block of encrypted text

**答：B。** Text blocks (finalized in Java 15) are multi-line string literals delimited by triple double-quote characters ("""). They preserve the formatting of the string content, automatically handle line terminators, and reduce the need for escape sequences, making it easier to write HTML, JSON, SQL, and other multi-line strings.

### Q006 [MEDIUM] How do you create a virtual thread in Java 21?

- A. new VirtualThread()
- B. Thread.ofVirtual().start(runnable) or Thread.startVirtualThread(runnable)（✓ 正確）
- C. Thread.createVirtual()
- D. new Thread(runnable, VIRTUAL)

**答：B。** In Java 21, virtual threads can be created using Thread.ofVirtual().start(runnable) for the builder API or Thread.startVirtualThread(runnable) as a convenience method. Virtual threads can also be created using ExecutorService via Executors.newVirtualThreadPerTaskExecutor().

### Q007 [MEDIUM] What is the 'permits' clause used for with sealed classes?

- A. Granting file permissions
- B. Specifying the exhaustive list of classes that are allowed to extend or implement the sealed class（✓ 正確）
- C. Permitting module access
- D. Allowing method access

**答：B。** The 'permits' clause in a sealed class declaration specifies the complete list of classes or interfaces that are permitted to directly extend or implement the sealed type. For example: 'sealed class Shape permits Circle, Rectangle, Triangle'. Each permitted subclass must be either final, sealed, or non-sealed.

### Q008 [MEDIUM] How does pattern matching work in switch expressions in Java 21?

- A. Using regex patterns in switch cases
- B. Switch cases can use type patterns, guarded patterns (with when clause), and null cases to match against the selector expression（✓ 正確）
- C. Matching design patterns in code
- D. Pattern-based file matching

**答：B。** Pattern matching for switch (finalized in Java 21) allows switch cases to use type patterns like 'case Integer i' and guarded patterns like 'case String s when s.length() > 5'. It also supports null cases and exhaustiveness checking with sealed types, enabling concise and safe type-based dispatch.

### Q009 [MEDIUM] What is a record pattern in Java 21?

- A. A pattern for recording audio
- B. A destructuring pattern that matches a record type and extracts its components in a single step（✓ 正確）
- C. A logging pattern
- D. A database record query pattern

**答：B。** Record patterns (finalized in Java 21, JEP 440) allow destructuring of record values in instanceof checks and switch statements. For example, 'case Point(int x, int y)' matches a Point record and extracts its x and y components into variables. Record patterns can be nested for deep destructuring.

### Q010 [MEDIUM] A developer declares: record Point(int x, int y) {}. What members does this record automatically provide?

- A. Only a no-arg constructor
- B. A canonical constructor, accessor methods x() and y(), equals(), hashCode(), and toString()（✓ 正確）
- C. Only getter and setter methods
- D. Only the toString() method

**答：B。** A record declaration automatically provides: a canonical constructor with parameters matching the components, accessor methods named after each component (x() and y(), not getX()), equals() based on all components, hashCode() based on all components, and toString() showing the record name and component values. Records are implicitly final.

### Q011 [MEDIUM] What is the switch expression syntax in Java (as enhanced through Java 21)?

- A. Same as traditional switch statement
- B. Switch can be used as an expression that returns a value, using arrow syntax (->), supporting multiple labels per case, and pattern matching（✓ 正確）
- C. Switch can only match integers
- D. Switch expressions require break statements

**答：B。** Switch expressions (finalized in Java 14, enhanced in Java 21) use arrow syntax (case X ->) and return a value. They support multiple labels per case (case 1, 2 ->), yield for block cases, pattern matching with type patterns and guards, exhaustiveness checking, and don't require break statements as there's no fall-through.

### Q012 [MEDIUM] In Java 21, what does 'when' do in a switch pattern case?

- A. Specifies when the switch should execute
- B. Acts as a guard clause that adds a boolean condition to a pattern case, refining the match（✓ 正確）
- C. Indicates when the feature was added
- D. Triggers a timed execution

**答：B。** The 'when' clause (guard) in Java 21 switch pattern matching adds a boolean condition to refine a pattern match. For example: 'case String s when s.length() > 5 -> ...' matches only if the value is a String AND its length exceeds 5. This replaces the previous use of '&&' in preview versions.

### Q013 [HARD] How do virtual threads in Java 21 handle blocking operations differently from platform threads?

- A. Virtual threads cannot perform blocking operations
- B. When a virtual thread blocks (I/O, sleep, lock), the JVM unmounts it from the carrier platform thread, allowing that platform thread to execute other virtual threads（✓ 正確）
- C. Virtual threads skip blocking operations
- D. Virtual threads convert blocking to non-blocking automatically

**答：B。** When a virtual thread performs a blocking operation (I/O, Thread.sleep(), lock acquisition), the JVM unmounts it from its carrier platform thread. The carrier thread is then free to run other virtual threads. When the blocking operation completes, the virtual thread is remounted on an available carrier thread. This enables millions of concurrent blocked threads without wasting platform thread resources.

### Q014 [HARD] What is the Sequenced Collections feature introduced in Java 21?

- A. Collections sorted in sequence
- B. New interfaces (SequencedCollection, SequencedSet, SequencedMap) that provide uniform APIs for accessing first/last elements and reversed views of ordered collections（✓ 正確）
- C. Collections that can only be iterated once
- D. Collections with sequence numbers

**答：B。** Sequenced Collections (JEP 431 in Java 21) introduces SequencedCollection, SequencedSet, and SequencedMap interfaces. They provide uniform methods like getFirst(), getLast(), addFirst(), addLast(), and reversed() for ordered collections. List, Deque, SortedSet, and LinkedHashSet now implement SequencedCollection, providing consistent first/last access APIs.

### Q015 [MEDIUM] What is the purpose of the 'yield' keyword in a switch expression?

- A. Yielding processor time to other threads
- B. Returning a value from a switch expression block case when the case body requires multiple statements（✓ 正確）
- C. Yielding to higher priority operations
- D. Pausing execution

**答：B。** The 'yield' keyword is used in switch expression block cases (with curly braces) to return a value. When a case requires multiple statements, you use a block with 'yield value;' to specify the result. For single expressions, the arrow syntax (case X -> value) is used instead without needing yield.

### Q016 [HARD] A developer writes: sealed interface Shape permits Circle, Square {} record Circle(double r) implements Shape {} record Square(double s) implements Shape {}. What is the advantage for switch pattern matching?

- A. No advantage over regular interfaces
- B. The compiler can verify exhaustiveness ??a switch over Shape cases covering Circle and Square needs no default case since the sealed hierarchy is fully covered（✓ 正確）
- C. It runs faster
- D. It allows adding new implementations

**答：B。** Sealed types enable exhaustive switch expressions. Since the compiler knows all permitted subtypes of Shape (Circle and Square), a switch expression covering both cases is complete without a default branch. If a new permitted type is added later, the compiler flags all non-exhaustive switches, ensuring they're updated. This combines sealed types with pattern matching for type-safe dispatch.

### Q017 [HARD] What are unnamed patterns and unnamed variables (preview in Java 21)?

- A. Variables without values
- B. Patterns and variables using underscore (_) as a placeholder when the variable's value is not needed, reducing boilerplate（✓ 正確）
- C. Anonymous classes
- D. Private variables

**答：B。** Unnamed patterns and variables (JEP 443, preview in Java 21) use underscore (_) as a placeholder when a binding variable is declared but never used. For example, 'case Point(var x, _)' matches a Point but discards the y component. This reduces warnings about unused variables and improves code readability.

### Q018 [HARD] What is the compact canonical constructor in a Java record?

- A. A constructor with fewer parameters
- B. A shorthand constructor syntax for records that omits the parameter list and assignment statements, used primarily for validation and normalization（✓ 正確）
- C. A private constructor
- D. A no-arg constructor

**答：B。** A compact canonical constructor in a record omits the parameter list and field assignments (which happen automatically). It's used for validation and normalization. For example: record Range(int lo, int hi) { Range { if (lo > hi) throw new IllegalArgumentException(); } }. The parameters are implicitly available and assigned to fields after the constructor body executes.

### Q019 [HARD] What happens if a non-sealed subclass of a sealed class is extended?

- A. It causes a compilation error
- B. A non-sealed subclass removes the sealing restriction, allowing any class to extend it freely, opening the hierarchy at that point（✓ 正確）
- C. It inherits the sealed restriction
- D. The JVM prevents it at runtime

**答：B。** When a permitted subclass of a sealed class is declared 'non-sealed', it reopens the class hierarchy at that point. Any class can freely extend the non-sealed subclass without restrictions. This provides a way to partially seal a hierarchy ??the sealed parent controls its direct children, but a non-sealed child allows unrestricted further extension.

### Q020 [HARD] What is the Structured Concurrency API (preview) in Java 21?

- A. Organizing code into folders
- B. An API (StructuredTaskScope) that treats multiple concurrent tasks as a single unit of work, simplifying error handling and cancellation in concurrent code（✓ 正確）
- C. Structuring database tables
- D. Structured exception handling

**答：B。** Structured Concurrency (JEP 453, preview in Java 21) introduces StructuredTaskScope which groups related concurrent tasks into a single scope. When the scope completes, all subtasks are guaranteed to finish. It supports ShutdownOnFailure (cancel remaining tasks if one fails) and ShutdownOnSuccess (cancel remaining when first succeeds), simplifying concurrent code reliability.

### Q021 [HARD] What is a Scoped Value (preview in Java 21) and how does it differ from ThreadLocal?

- A. A variable with limited scope
- B. An immutable, inheritable value bound to a scope that is automatically shared with child threads; unlike ThreadLocal, it's immutable, uses less memory, and works efficiently with virtual threads（✓ 正確）
- C. A local variable in a method
- D. A scope-limited database value

**答：B。** Scoped Values (JEP 446, preview in Java 21) provide a mechanism to share immutable data within and across threads for a bounded scope. Unlike ThreadLocal, scoped values are immutable (set once per scope), automatically inherited by child threads (efficient with virtual threads), don't leak memory, and have better performance characteristics for virtual thread workloads.

### Q022 [HARD] What is the purpose of Stream.gather() (preview in Java 21)?

- A. Gathering data from multiple sources
- B. A new intermediate operation that enables custom, stateful, and potentially short-circuiting stream transformations using user-defined Gatherer implementations（✓ 正確）
- C. Collecting garbage
- D. Assembling thread groups

**答：B。** Stream.gather() (JEP 461, preview in Java 21) introduces a new intermediate stream operation that accepts a Gatherer. Gatherers can define custom stateful transformations that existing intermediate operations (map, filter, flatMap) cannot express. They support initialization, element processing with state, short-circuiting, and finalization, enabling window operations, scan, and fold patterns.

### Q023 [MEDIUM] What happens when you try to modify a record's component after creation?

- A. The component is updated normally
- B. Records are immutable ??components are final fields with no setters, so modification is not possible; you must create a new record instance with the desired values（✓ 正確）
- C. Only the first component is immutable
- D. Records become mutable after the first access

**答：B。** Records are designed to be immutable data carriers. All components are implicitly final, and no setter methods are generated. To create a modified version, you must construct a new record instance with the desired values. This immutability makes records inherently thread-safe and suitable for use as map keys and in concurrent data structures.

### Q024 [MEDIUM] What is the purpose of the String.formatted() method added in Java 15?

- A. Checking if a string is formatted
- B. An instance method equivalent to String.format() that allows formatting using the string itself as the format template: "Hello %s".formatted(name)（✓ 正確）
- C. Formatting a string as HTML
- D. Removing formatting from a string

**答：B。** String.formatted() is an instance method (added in Java 15) that uses the string itself as the format template. Instead of writing String.format("Hello %s, age %d", name, age), you can write "Hello %s, age %d".formatted(name, age). It's functionally equivalent to String.format() but reads more naturally, especially with text blocks.

### Q025 [HARD] What is the Executors.newVirtualThreadPerTaskExecutor() method in Java 21?

- A. An executor for virtual reality tasks
- B. An ExecutorService that creates a new virtual thread for each submitted task, ideal for high-throughput I/O-bound applications that need millions of concurrent tasks（✓ 正確）
- C. An executor limited to virtual machine threads
- D. A testing executor that simulates threads

**答：B。** Executors.newVirtualThreadPerTaskExecutor() creates an ExecutorService that spawns a new virtual thread for every task submitted. Since virtual threads are lightweight (using kilobytes vs megabytes for platform threads), this enables a thread-per-task model for millions of concurrent I/O-bound tasks. It's ideal for servers handling many concurrent requests with blocking I/O.


---

## OOP 基礎（21 題）

### Q026 [EASY] Which keyword is used to define a class in Java?

- A. struct
- B. class（✓ 正確）
- C. define
- D. object

**答：B。** The 'class' keyword is used to define a class in Java. A class is a blueprint for creating objects and encapsulates data (fields) and behavior (methods). Java is an object-oriented language where classes are the fundamental building blocks.

### Q027 [EASY] What is the correct way to declare the main method in Java?

- A. public void main(String[] args)
- B. public static void main(String[] args)（✓ 正確）
- C. static void main()
- D. public static int main(String[] args)

**答：B。** The correct signature for the main method is 'public static void main(String[] args)'. It must be public (accessible by the JVM), static (called without creating an object), void (returns nothing), and accept a String array parameter for command-line arguments.

### Q028 [EASY] What is encapsulation in Java?

- A. Inheriting properties from a parent class
- B. Bundling data and methods that operate on that data within a single unit (class) and restricting direct access to the data（✓ 正確）
- C. Converting objects to strings
- D. Running multiple threads simultaneously

**答：B。** Encapsulation is an OOP principle that bundles data (fields) and methods that operate on that data within a single class, and restricts direct access to the internal state using access modifiers (private, protected). It promotes data hiding and provides controlled access through getter and setter methods.

### Q029 [EASY] Which access modifier makes a member accessible only within the same class?

- A. public
- B. protected
- C. private（✓ 正確）
- D. default

**答：C。** The 'private' access modifier restricts access to only within the same class. Private members cannot be accessed by subclasses or other classes in the same package. This is the most restrictive access level and is fundamental to encapsulation.

### Q030 [EASY] What is the purpose of the 'extends' keyword in Java?

- A. To extend the length of an array
- B. To establish an inheritance relationship where a subclass inherits from a superclass（✓ 正確）
- C. To extend the timeout of a method
- D. To increase memory allocation

**答：B。** The 'extends' keyword establishes an inheritance relationship in Java. A subclass uses 'extends' to inherit fields and methods from a superclass. Java supports single inheritance for classes (one superclass only), promoting code reuse and establishing is-a relationships between types.

### Q031 [EASY] What is polymorphism in Java?

- A. The ability to create multiple constructors
- B. The ability of objects of different types to be treated as instances of a common supertype, with method calls resolved at runtime（✓ 正確）
- C. The ability to have multiple packages
- D. The ability to run on multiple platforms

**答：B。** Polymorphism allows objects of different classes to be treated as instances of a common supertype. Method calls on a supertype reference are resolved at runtime based on the actual object type (dynamic dispatch). This enables writing flexible, extensible code that works with families of related types.

### Q032 [EASY] Which interface must a class implement to allow its objects to be compared for ordering?

- A. Serializable
- B. Comparable<T>（✓ 正確）
- C. Iterable<T>
- D. Cloneable

**答：B。** The Comparable<T> interface defines the compareTo() method, which establishes a natural ordering for objects of a class. Implementing Comparable allows objects to be sorted using Collections.sort(), Arrays.sort(), and used in sorted collections like TreeSet and TreeMap.

### Q033 [EASY] What is the purpose of the 'var' keyword introduced in Java 10?

- A. To declare a variable-length array
- B. To enable local variable type inference, where the compiler determines the type from the initializer（✓ 正確）
- C. To declare a variable as volatile
- D. To create a varargs parameter

**答：B。** The 'var' keyword enables local variable type inference in Java. When used with an initializer, the compiler infers the variable's type from the right-hand side expression. It can only be used for local variables with initializers, not for method parameters, return types, or fields.

### Q034 [EASY] What is the difference between an interface and an abstract class in Java?

- A. They are identical concepts
- B. An interface defines a contract with abstract methods (and default/static methods), while an abstract class can have state (fields), constructors, and both abstract and concrete methods（✓ 正確）
- C. Interfaces are faster than abstract classes
- D. Abstract classes cannot have methods

**答：B。** Interfaces define contracts with abstract methods and can include default and static methods (since Java 8). Abstract classes can have instance fields, constructors, and a mix of abstract and concrete methods. A class can implement multiple interfaces but extend only one abstract class. Interfaces support multiple inheritance of type.

### Q035 [EASY] What is the purpose of the 'try-with-resources' statement in Java?

- A. To try different resource configurations
- B. To automatically close resources (like streams, connections) that implement AutoCloseable when the try block completes（✓ 正確）
- C. To retry failed resource allocations
- D. To test resource availability

**答：B。** The try-with-resources statement (introduced in Java 7) ensures that resources implementing AutoCloseable are automatically closed when the try block finishes, whether normally or due to an exception. This eliminates the need for explicit finally blocks to close resources and prevents resource leaks.

### Q036 [MEDIUM] What is the difference between method overloading and method overriding in Java?

- A. They are the same thing
- B. Overloading defines multiple methods with the same name but different parameters in the same class, while overriding redefines a superclass method in a subclass with the same signature（✓ 正確）
- C. Overloading is for static methods, overriding is for instance methods
- D. Overloading changes the return type only

**答：B。** Method overloading (compile-time polymorphism) occurs when a class has multiple methods with the same name but different parameter lists. Method overriding (runtime polymorphism) occurs when a subclass provides a specific implementation of a method already defined in its superclass, with the same name, return type, and parameters.

### Q037 [MEDIUM] What is the difference between checked and unchecked exceptions in Java?

- A. Checked are faster than unchecked
- B. Checked exceptions must be declared or handled (extends Exception), while unchecked exceptions (extends RuntimeException) don't require explicit handling（✓ 正確）
- C. Checked exceptions are verified at runtime
- D. Unchecked exceptions cannot be caught

**答：B。** Checked exceptions (subclasses of Exception but not RuntimeException) must be either caught in a try-catch block or declared in the method's throws clause. Unchecked exceptions (subclasses of RuntimeException) don't require explicit handling. This distinction enforces error handling for predictable exceptional conditions at compile time.

### Q038 [MEDIUM] What is the purpose of the @Override annotation?

- A. To override the JVM settings
- B. To indicate that a method is intended to override a superclass method, enabling compile-time verification（✓ 正確）
- C. To override access modifiers
- D. To override final methods

**答：B。** The @Override annotation indicates that a method is intended to override a method from a superclass or implement an interface method. If the annotated method doesn't actually override anything (due to a typo or signature mismatch), the compiler generates an error, catching mistakes at compile time.

### Q039 [MEDIUM] How do you create an unmodifiable list in Java using the List.of() factory method?

- A. List.of() creates a mutable list
- B. List.of(elements) creates an immutable list that throws UnsupportedOperationException on modification attempts（✓ 正確）
- C. List.of() creates an empty array
- D. List.of() is not a valid method

**答：B。** List.of() (introduced in Java 9) creates an unmodifiable (immutable) list. Any attempt to add, remove, or modify elements throws UnsupportedOperationException. It does not allow null elements. Similar factory methods exist for Set.of() and Map.of() for creating unmodifiable collections.

### Q040 [MEDIUM] What is the difference between == and .equals() when comparing objects in Java?

- A. They are always equivalent
- B. == compares reference identity (same object in memory), while .equals() compares logical equality (object content), though .equals() must be properly overridden（✓ 正確）
- C. == is for strings only
- D. .equals() is for primitives only

**答：B。** The == operator compares reference identity ??whether two references point to the same object in memory. The .equals() method compares logical equality ??whether two objects have equivalent content. Classes must override .equals() (inherited from Object) to define meaningful equality. For example, two different String objects with the same characters are == false but .equals() true.

### Q041 [MEDIUM] What is the difference between String, StringBuilder, and StringBuffer?

- A. They are all interchangeable
- B. String is immutable, StringBuilder is mutable and not thread-safe (faster), StringBuffer is mutable and thread-safe (synchronized)（✓ 正確）
- C. String is the fastest
- D. StringBuffer is immutable

**答：B。** String objects are immutable ??any modification creates a new object. StringBuilder is mutable and not synchronized, making it faster for single-threaded string manipulation. StringBuffer is mutable and thread-safe (all methods are synchronized), making it safe for multi-threaded use but slower. Use StringBuilder for most cases and StringBuffer only when thread safety is needed.

### Q042 [HARD] What is the diamond problem and how does Java handle it?

- A. A problem with diamond-shaped inheritance in Java classes
- B. An ambiguity that arises when a class inherits conflicting default methods from multiple interfaces; Java requires the class to override the conflicting method to resolve it（✓ 正確）
- C. A performance issue with diamond operators
- D. A graphical rendering problem

**答：B。** The diamond problem occurs when a class implements two interfaces that both provide default implementations of the same method. Java resolves this by requiring the implementing class to explicitly override the conflicting method. The class can then choose which interface's implementation to call using InterfaceName.super.method() or provide its own implementation.

### Q043 [HARD] What is type erasure and how does it affect generics in Java?

- A. Erasing types from source code
- B. The compiler removes generic type information during compilation, replacing type parameters with their bounds (or Object), which is why you can't create generic arrays or use instanceof with parameterized types at runtime（✓ 正確）
- C. A way to delete classes
- D. Removing type annotations

**答：B。** Type erasure is Java's approach to implementing generics where the compiler removes (erases) generic type information during compilation. List<String> becomes List at runtime. This means you can't use 'new T()', 'T[].class', or 'instanceof List<String>' at runtime. It maintains backward compatibility with pre-generics code but creates limitations like inability to create generic arrays.

### Q044 [MEDIUM] What is the difference between 'final', 'finally', and 'finalize' in Java?

- A. They are all related to cleanup operations
- B. 'final' prevents modification (constants, no subclassing, no overriding), 'finally' is a block that always executes after try/catch, 'finalize()' is a deprecated method called by GC before object destruction（✓ 正確）
- C. They all mean the same thing
- D. They are all keywords for exception handling

**答：B。** 'final' is a modifier: final variables are constants, final methods can't be overridden, final classes can't be extended. 'finally' is a block in try-catch that always executes (for cleanup). 'finalize()' is a deprecated Object method called by the garbage collector before reclaiming an object ??replaced by Cleaners and try-with-resources.

### Q045 [HARD] What is the difference between a WeakReference and a SoftReference in Java?

- A. They are identical
- B. A WeakReference allows GC to collect the referent at any GC cycle, while a SoftReference keeps the referent until memory pressure requires collection ??useful for caching（✓ 正確）
- C. WeakReference is stronger than SoftReference
- D. SoftReference prevents garbage collection entirely

**答：B。** WeakReference allows the garbage collector to reclaim the referent at any GC cycle regardless of memory availability ??used for canonical mappings (WeakHashMap). SoftReference keeps the referent until the JVM needs memory, guaranteeing collection before OutOfMemoryError ??ideal for caches. Both are cleared before their referents are collected.

### Q046 [HARD] What is the difference between List.of() and List.copyOf() in Java?

- A. They create the same type of list
- B. List.of() creates an unmodifiable list from provided elements, while List.copyOf() creates an unmodifiable list from an existing collection; copyOf() rejects null elements and returns the input if it's already unmodifiable（✓ 正確）
- C. List.copyOf() creates a mutable copy
- D. List.of() allows null elements

**答：B。** List.of() creates an unmodifiable list from directly provided elements. List.copyOf() creates an unmodifiable list by copying elements from an existing collection. Both reject null elements (throwing NullPointerException). List.copyOf() optimizes by returning the same instance if the input is already an unmodifiable list of the same implementation.


---

## 流程控制（15 題）

### Q047 [MEDIUM] What does assert x > 0 : "x must be positive"; do when assertions are enabled and x is 0?

- A. Prints the message and continues
- B. Throws AssertionError with detail "x must be positive"（✓ 正確）
- C. Throws IllegalArgumentException
- D. Nothing ??assertions are always ignored

**答：B。** When assertions are enabled (-ea), a failed assert throws AssertionError. The expression after ':' becomes the error's detail message. With assertions disabled (default on many launches), the assert is a no-op.

### Q048 [MEDIUM] What is printed by: var count = 1; do { System.out.print(count + " "); } while (count++ < 3);?

- A. 1 2
- B. 1 2 3（✓ 正確）
- C. 2 3
- D. 1 2 3 4

**答：B。** do-while executes the body before testing. count starts at 1; body prints then count++ is used in the condition (post-increment). The loop runs while the value before increment is < 3, so body runs for count 1, 2, and 3 ??printing "1 2 3 ".

### Q049 [EASY] In a traditional switch statement on an int, what happens if a matching case has no break?

- A. Compilation error
- B. Execution falls through into subsequent case bodies until break or end（✓ 正確）
- C. Only that case runs; fall-through was removed in Java 21
- D. The JVM throws FallThroughException

**答：B。** Classic switch statements allow fall-through when break (or return/throw) is omitted. Switch expressions with arrow labels (->) do not fall through. Pattern-matching switch expressions also do not fall through between cases.

### Q050 [EASY] Which loop construct is guaranteed to execute its body at least once?

- A. for (;;)
- B. do { ... } while (condition);（✓ 正確）
- C. while (condition) { ... }
- D. for (item : collection)

**答：B。** A do-while checks the condition after the body, so the body always runs at least once. while and enhanced for may run zero times if the condition is initially false or the collection is empty.

### Q051 [MEDIUM] What is the effect of a labeled break outer; inside nested loops?

- A. It always exits only the innermost loop
- B. It terminates the loop (or switch) labeled outer, transferring control to the statement after that labeled statement（✓ 正確）
- C. It is a synonym for System.exit
- D. Labels are only allowed on methods

**答：B。** Java supports labeled break and continue. break outer; exits the statement marked with label outer:, which is useful to leave nested loops in one step. Labels apply to statements (commonly loops), not methods.

### Q052 [MEDIUM] Given Object value = 10L; what does switch (value) { case Integer i -> "int"; case Long l -> "long"; case String s -> "string"; default -> "unknown"; } yield?

- A. int
- B. long（✓ 正確）
- C. unknown
- D. Compilation error ??cannot switch on Object

**答：B。** 10L autoboxes to Long. Pattern matching for switch (final in Java 21) selects case Long l. Switching on Object is allowed with type patterns; exhaustiveness may require default for non-sealed hierarchies.

### Q053 [EASY] Which for-loop header correctly iterates an int[] nums without an index variable?

- A. for (int n : nums)（✓ 正確）
- B. for (n in nums)
- C. for each (int n in nums)
- D. for (int n <<- nums)

**答：A。** The enhanced for-loop syntax is for (elementType identifier : arrayOrIterable). It works for arrays and Iterable implementations. Java has no for-each keyword or in operator like some other languages.

### Q054 [EASY] What happens when continue is executed in a for-loop?

- A. The entire method returns
- B. Control jumps to the next iteration's update expression (then the condition), skipping the rest of the current body（✓ 正確）
- C. The loop terminates immediately
- D. It restarts the loop from the first iteration only

**答：B。** continue skips the remainder of the current iteration. In a for-loop, the update expression still runs before the next condition check. A labeled continue can continue an outer loop.

### Q055 [MEDIUM] Which switch expression case uses a guard correctly in Java 21?

- A. case String s && s.length() > 5 -> s
- B. case String s when s.length() > 5 -> s（✓ 正確）
- C. case String s if s.length() > 5 -> s
- D. case (String s | s.length() > 5) -> s

**答：B。** Java 21 finalized pattern switch guards with the when clause. Preview versions briefly used && after the pattern; the standard syntax is case Type pattern when booleanExpression. if is not valid in this position.

### Q056 [MEDIUM] What is x after: int x = 0; for (int i = 0; i < 3; i++) { if (i == 1) continue; x += i; }?

- A. 3
- B. 2（✓ 正確）
- C. 1
- D. 0

**答：B。** Iterations: i=0 adds 0; i=1 hits continue and skips; i=2 adds 2. Final x is 2.

### Q057 [MEDIUM] How does the dangling-else rule work in Java?

- A. else always binds to the farthest if
- B. else binds to the nearest unmatched if（✓ 正確）
- C. else requires braces always in Java
- D. Java forbids else without braces

**答：B。** In Java, an else associates with the innermost if that lacks an else. Use braces to make nesting explicit and avoid dangling-else mistakes.

### Q058 [MEDIUM] Which types can appear as switch selectors?

- A. Only int
- B. Integral types except long (and wrappers), String, enum, and with pattern matching other reference types such as Object（✓ 正確）
- C. Only enum and String
- D. float and double without casting

**答：B。** Traditional switch allows byte/short/char/int and wrappers, String, and enum. Pattern-matching switch extends selectors to reference types with type patterns. float and double are not valid selector types; long is not either.

### Q059 [HARD] What happens if you call list.remove during an enhanced for-loop over an ArrayList?

- A. Always safe
- B. Typically ConcurrentModificationException for fail-fast iterators; use Iterator.remove or removeIf instead（✓ 正確）
- C. The JVM deadlocks
- D. It silently corrupts only LinkedList

**答：B。** Fail-fast iterators from ArrayList detect structural modification other than through Iterator.remove and throw ConcurrentModificationException. Prefer iterator.remove(), Collection.removeIf, or iterate a copy.

### Q060 [EASY] What is printed: int i = 0; while (i < 3) { i++; if (i == 2) break; } System.out.print(i);?

- A. 0
- B. 1
- C. 2（✓ 正確）
- D. 3

**答：C。** i becomes 1, then 2; when i==2, break exits. Printed value is 2.

### Q061 [MEDIUM] Which statement about yield in switch expressions is true?

- A. yield always pauses the current thread like Thread.yield()
- B. Inside a switch expression block case, yield value; produces the switch result; it is unrelated to Thread.yield()（✓ 正確）
- C. yield is required for every arrow case
- D. yield replaces break in classic switch statements only

**答：B。** In switch expressions, block cases use yield to produce the value. Arrow cases return a value directly without yield. Thread.yield() is a separate concurrency API.


---

## 日期時間與文字（16 題）

### Q062 [MEDIUM] What is the difference between Period and Duration in java.time?

- A. They are interchangeable aliases
- B. Period measures date-based amounts (years/months/days); Duration measures time-based amounts (hours/minutes/seconds/nanos) based on seconds（✓ 正確）
- C. Period is for wall-clock time only; Duration is for calendar dates only
- D. Duration works only with LocalDate; Period works only with Instant

**答：B。** Period represents human calendar units (years, months, days) and is typically used with LocalDate. Duration represents an exact time-based amount in seconds and nanoseconds and is used with Instant, LocalTime, or LocalDateTime. Duration.between(LocalDate, LocalDate) throws UnsupportedTemporalTypeException because LocalDate has no time component.

### Q063 [MEDIUM] Which local variable declarations using var are valid?

- A. var x; and var y = null;
- B. var n = 10; and var arr = new int[]{1, 2, 3};（✓ 正確）
- C. var a = {1, 2, 3};
- D. var f = () -> 5; without a target type

**答：B。** var requires an initializer with an inferable non-null type. var n = 10 is valid (int). var arr = new int[]{1,2,3} is valid. var x without initializer, var y = null, array initializer {1,2,3} without new, and a lambda without a target functional type are all invalid.

### Q064 [MEDIUM] What does Period.between(LocalDate.of(2022, 1, 1), LocalDate.of(2023, 1, 1)) return when printed?

- A. P365D
- B. P1Y（✓ 正確）
- C. PT8760H
- D. UnsupportedTemporalTypeException

**答：B。** Period.between computes the period in years, months, and days between two LocalDates. From 2022-01-01 to 2023-01-01 the result is exactly one year, printed as P1Y in ISO-8601 period format.

### Q065 [HARD] Why does Duration.between(LocalDate.of(2022, 1, 1), LocalDate.of(2023, 1, 1)) fail?

- A. Duration cannot span more than 24 hours
- B. Duration requires temporal types with time (or Instant); LocalDate has only date fields, so UnsupportedTemporalTypeException is thrown（✓ 正確）
- C. The dates are in the wrong order
- D. Duration only accepts ZonedDateTime

**答：B。** Duration measures seconds-based amounts and needs types that support time-based units (Instant, LocalTime, LocalDateTime, ZonedDateTime). LocalDate supports only date-based units, so Duration.between on two LocalDates throws UnsupportedTemporalTypeException. Use Period for date-only amounts.

### Q066 [MEDIUM] Which statement about primitive wrappers and autoboxing is correct?

- A. Integer a = 127; Integer b = 127; always guarantees a != b
- B. Integer.valueOf(127) may reuse a cached instance so == can be true for values in the cached range, but equals() is the correct equality check（✓ 正確）
- C. Autoboxing never boxes null
- D. int cannot be assigned from an Integer without an explicit cast

**答：B。** Integer.valueOf caches values typically from -128 to 127, so == may compare equal for cached values but must not be relied on. Prefer equals() for wrapper equality. Unboxing a null Integer throws NullPointerException. Assignment Integer ??int uses unboxing automatically.

### Q067 [EASY] What does "Hello %s".formatted("World") return in Java 15+?

- A. Hello %s
- B. Hello World（✓ 正確）
- C. A Formatter object
- D. Compilation error ??formatted is static only

**答：B。** String.formatted(...) is an instance method equivalent to String.format(this, args). "Hello %s".formatted("World") produces "Hello World". It is especially convenient with text blocks.

### Q068 [EASY] Which Boolean expression correctly uses short-circuit evaluation?

- A. x & y always skips evaluating y if x is false
- B. x && y does not evaluate y when x is false; x || y does not evaluate y when x is true（✓ 正確）
- C. & and | never evaluate both operands
- D. && and || are bitwise operators on ints

**答：B。** Logical && and || short-circuit: the right operand is skipped when the left already determines the result. Bitwise & and | on booleans always evaluate both sides. &&/|| apply to boolean operands; &/| also overload as bitwise operators on integral types.

### Q069 [HARD] Given LocalDate d = LocalDate.of(2024, 2, 29); what does d.plusYears(1) return?

- A. 2025-02-29
- B. 2025-02-28（✓ 正確）
- C. 2025-03-01
- D. DateTimeException

**答：B。** 2024 is a leap year so Feb 29 is valid. Adding one year adjusts to 2025-02-28 because 2025 is not a leap year ??java.time resolves invalid dates by adjusting to the last valid day of the month rather than throwing.

### Q070 [MEDIUM] What is the result of Math.addExact(Integer.MAX_VALUE, 1)?

- A. Integer.MIN_VALUE due to wraparound
- B. Throws ArithmeticException because the int sum overflows（✓ 正確）
- C. Returns Long value silently
- D. Returns Integer.MAX_VALUE unchanged

**答：B。** Math.addExact (and multiplyExact, etc.) throw ArithmeticException on overflow instead of silently wrapping. Plain int addition of MAX_VALUE + 1 wraps to MIN_VALUE; addExact is used when overflow must be detected.

### Q071 [EASY] Which text-block statement is true?

- A. Text blocks use single quotes as delimiters
- B. A text block is a multi-line String literal delimited by """ that manages incidental indentation and line terminators（✓ 正確）
- C. Text blocks are mutable CharSequence builders
- D. Text blocks cannot contain double quotes

**答：B。** Text blocks (Java 15+) are String literals opened and closed with triple double-quotes. The compiler strips incidental indentation relative to the closing delimiter and normalizes line terminators. Embedded " usually need not be escaped; """ inside content uses \""".

### Q072 [HARD] What does Character.isDigit('晻') return for the Arabic-Indic digit three?

- A. false ??only ASCII 0-9 are digits
- B. true ??Character.isDigit recognizes Unicode decimal digits（✓ 正確）
- C. Compilation error
- D. true only if Locale is ARABIC

**答：B。** Character.isDigit(char) returns true for any Unicode decimal digit character, not only ASCII '0'-'9'. Locale does not affect Character.isDigit; use NumericShaper or locale-sensitive formatters for display.

### Q073 [MEDIUM] Which Instant statement is correct?

- A. Instant always stores a time zone offset
- B. Instant represents a moment on the UTC timeline as seconds and nanos since the epoch; convert to ZonedDateTime via atZone(ZoneId)（✓ 正確）
- C. Instant.parse accepts LocalDate-only strings like 2024-01-01
- D. Instant.now() returns a LocalDateTime

**答：B。** Instant is a machine timeline timestamp (UTC-based) without a zone. Attach a zone with instant.atZone(zoneId) to get ZonedDateTime. Parsing requires an ISO instant string (with time and usually Z or offset), not a bare LocalDate.

### Q074 [EASY] What is printed by System.out.println(1 + 2 + "3" + 4 + 5);?

- A. 15
- B. 3345（✓ 正確）
- C. 12345
- D. 33 + 4 + 5

**答：B。** Evaluation is left-to-right. 1+2 yields int 3; then 3+"3" concatenates to "33"; then "33"+4 and +5 concatenate to "3345". Once a String appears, further + operations are string concatenation.

### Q075 [MEDIUM] Given ZoneId zone = ZoneId.of("America/New_York"); what does LocalDateTime.of(2024, 6, 1, 12, 0).atZone(zone) represent?

- A. An Instant only
- B. A ZonedDateTime for noon on that date in the New York zone, including offset and zone rules (e.g., DST)（✓ 正確）
- C. A Period
- D. A LocalTime stripped of the date

**答：B。** LocalDateTime.atZone(ZoneId) creates a ZonedDateTime applying zone rules (offset, DST). Convert to Instant via toInstant() for a UTC timeline moment. LocalDateTime itself has no zone.

### Q076 [EASY] What does LocalTime.parse("10:15:30") return?

- A. A LocalDateTime
- B. A LocalTime representing 10:15:30 with no date or zone（✓ 正確）
- C. An Instant
- D. A Duration of 10 hours

**答：B。** LocalTime.parse parses an ISO-8601 local time string into hours/minutes/seconds/nanos without a date or time-zone. Combine with LocalDate via LocalDateTime.of(date, time) when both are needed.

### Q077 [MEDIUM] Which call correctly counts whole days between two LocalDates?

- A. ChronoUnit.SECONDS.between(date1, date2)
- B. ChronoUnit.DAYS.between(date1, date2)（✓ 正確）
- C. ChronoUnit.FOREVER.between(date1, date2)
- D. Duration.between(date1, date2).toDaysPart() always

**答：B。** ChronoUnit.DAYS.between counts whole days between date-based temporals. SECONDS between LocalDates fails because LocalDate lacks time fields. Prefer Period.between when you need years/months/days components.


---

## 陣列與集合（14 題）

### Q078 [MEDIUM] Given TreeSet<String> cities with Amsterdam, Berlin, Lisbon, Madrid, Zurich added, what does cities.headSet("Madrid") return?

- A. [Amsterdam, Berlin, Lisbon, Madrid]
- B. [Amsterdam, Berlin, Lisbon]（✓ 正確）
- C. [Madrid, Zurich]
- D. [Berlin, Lisbon, Madrid]

**答：B。** TreeSet stores elements in sorted (natural) order. headSet(toElement) returns a view of elements strictly less than toElement. Alphabetically, Amsterdam, Berlin, and Lisbon are before Madrid; Madrid itself is excluded. The view is backed by the set.

### Q079 [MEDIUM] What does Arrays.compare(new int[]{1, 2}, new int[]{1, 3}) return?

- A. 0
- B. A negative value because 2 < 3 at the first differing index（✓ 正確）
- C. A positive value
- D. true

**答：B。** Arrays.compare performs lexicographic comparison of two arrays. At index 1, 2 compared to 3 is less, so the result is negative. Equal arrays return 0. This is distinct from Arrays.equals which returns boolean.

### Q080 [EASY] Which collection allows duplicate elements and preserves insertion order?

- A. HashSet
- B. ArrayList（✓ 正確）
- C. TreeSet
- D. HashMap keys view

**答：B。** List implementations such as ArrayList allow duplicates and maintain insertion order. HashSet and TreeSet reject duplicates (TreeSet sorts). A Map's keySet does not allow duplicate keys.

### Q081 [MEDIUM] What does Map.of("a", 1, "b", 2) create?

- A. A mutable HashMap
- B. An unmodifiable map with those entries; null keys/values are rejected（✓ 正確）
- C. A ConcurrentHashMap
- D. A TreeMap sorted by value

**答：B。** Map.of (Java 9+) creates a compact unmodifiable map. Null keys or values throw NullPointerException. Duplicate keys in the argument list throw IllegalArgumentException. For more than 10 entries use Map.ofEntries.

### Q082 [HARD] Which Deque method inserts at the front and returns false if capacity is exhausted (for bounded deques)?

- A. addFirst
- B. offerFirst（✓ 正確）
- C. push which always throws
- D. putFirst which blocks forever on ArrayDeque

**答：B。** offerFirst returns false rather than throwing when a capacity-restricted Deque cannot accept the element. addFirst throws IllegalStateException if full. ArrayDeque is resizable and unbounded, so capacity failure is mainly relevant for bounded implementations.

### Q083 [MEDIUM] What is true of SequencedCollection in Java 21?

- A. It replaces List entirely
- B. It adds a uniform API for encounter-order collections including getFirst(), getLast(), and reversed()（✓ 正確）
- C. It only applies to concurrent collections
- D. reversed() mutates the original collection in place for all implementations

**答：B。** JEP 431 Sequenced Collections introduce SequencedCollection, SequencedSet, and SequencedMap with getFirst/getLast/addFirst/addLast/reversed. List, LinkedHashSet, SortedSet, and Deque participate. reversed() typically returns a view.

### Q084 [EASY] Given int[] a = {1, 2, 3}; what does Arrays.binarySearch(a, 2) return if a is sorted ascending?

- A. true
- B. 1（✓ 正確）
- C. 2
- D. -2

**答：B。** Arrays.binarySearch returns the zero-based index of the key if found (index 1 for value 2). If not found it returns (-(insertion point) - 1). The array must be sorted in ascending order for the contract to hold.

### Q085 [MEDIUM] Which statement about HashMap and null is correct?

- A. HashMap forbids null keys and null values
- B. HashMap allows one null key and multiple null values; Hashtable and ConcurrentHashMap do not allow null keys（✓ 正確）
- C. ConcurrentHashMap allows a single null key
- D. TreeMap always allows null keys with natural ordering

**答：B。** HashMap permits one null key and any number of null values. Hashtable and ConcurrentHashMap disallow null keys and values. TreeMap with natural ordering forbids null keys because compareTo cannot be invoked on null.

### Q086 [HARD] What does List.copyOf(list) return when list is already an unmodifiable List created by List.of?

- A. Always a defensive mutable ArrayList copy
- B. An unmodifiable list; implementations may return the same instance if already an unmodifiable list of a compatible kind（✓ 正確）
- C. The original list made mutable
- D. null if list is empty

**答：B。** List.copyOf creates an unmodifiable List from a Collection. If the argument is already an unmodifiable List from the same family, the JDK may return it directly. Null elements are rejected with NullPointerException.

### Q087 [EASY] Which Queue method removes and returns the head, or returns null if empty?

- A. remove()
- B. poll()（✓ 正確）
- C. element()
- D. peek() which also removes

**答：B。** poll() retrieves and removes the head, returning null if the queue is empty. remove() throws NoSuchElementException if empty. peek()/element() inspect without removing (element throws if empty).

### Q088 [HARD] What does Collections.unmodifiableList(mutableList) guarantee?

- A. Deep immutability of all nested objects
- B. The returned list rejects structural modification; changes to the backing mutableList are still visible through the view（✓ 正確）
- C. It copies elements into List.of
- D. It freezes the backing list so even direct mutableList.add fails

**答：B。** Collections.unmodifiableList returns a read-only view. Calls like add on the view throw UnsupportedOperationException, but mutating the original list is still reflected in the view. For a true independent immutable snapshot use List.copyOf.

### Q089 [MEDIUM] What is the compile-time type of var list = List.of(1, 2, 3);?

- A. ArrayList<Integer>
- B. List<Integer>（✓ 正確）
- C. List<Object>
- D. Collection<int>

**答：B。** List.of returns List<E>. With integer literals, E is Integer (boxed). var infers List<Integer>. The runtime class is a compact unmodifiable list implementation, not necessarily ArrayList.

### Q090 [MEDIUM] What does Set.of("a", "a") do?

- A. Creates a set with one "a"
- B. Throws IllegalArgumentException because duplicate elements are not allowed in Set.of（✓ 正確）
- C. Creates a mutable HashSet with one element
- D. Silently ignores the duplicate

**答：B。** Set.of rejects duplicate elements at creation time with IllegalArgumentException. It also rejects null. For a mutable set use new HashSet<>(List.of(...)) or Collectors.toSet.

### Q091 [EASY] What is the difference between Comparable and Comparator?

- A. They are identical
- B. Comparable defines a type's natural order via compareTo; Comparator is an external ordering passed to sort/TreeSet（✓ 正確）
- C. Comparator replaces equals
- D. Comparable is only for primitives

**答：B。** Comparable<T>.compareTo establishes natural ordering inside the class. Comparator<T> provides alternate orderings without modifying the class. Collections.sort(list, comparator) and TreeSet(comparator) use Comparator.


---

## Streams 與 Lambda（20 題）

### Q092 [EASY] What is a lambda expression in Java?

- A. A named method in a class
- B. A concise representation of an anonymous function that can be passed as an argument or stored in a variable（✓ 正確）
- C. A type of loop construct
- D. A debugging tool

**答：B。** A lambda expression is a concise way to represent an anonymous function (a method without a name). Introduced in Java 8, lambdas enable functional programming by allowing you to pass behavior as arguments to methods, store them in variables, and use them with functional interfaces like Predicate, Function, and Consumer.

### Q093 [EASY] What does the Stream API in Java provide?

- A. File I/O streaming
- B. A functional-style API for processing sequences of elements with operations like filter, map, and reduce（✓ 正確）
- C. Network socket streaming
- D. Audio/video streaming

**答：B。** The Java Stream API (java.util.stream) provides a functional-style approach to processing sequences of elements. Streams support operations like filter, map, flatMap, reduce, collect, and forEach, enabling declarative data processing pipelines that can be executed sequentially or in parallel.

### Q094 [EASY] What is a functional interface in Java?

- A. An interface with no methods
- B. An interface with exactly one abstract method, which can be implemented using a lambda expression（✓ 正確）
- C. An interface used only for functions
- D. An interface that extends Function

**答：B。** A functional interface is an interface with exactly one abstract method (SAM - Single Abstract Method). It can have multiple default and static methods but only one abstract method. Functional interfaces can be annotated with @FunctionalInterface and serve as the target type for lambda expressions and method references.

### Q095 [EASY] What is the purpose of the Optional class in Java?

- A. To make method parameters optional
- B. A container object that may or may not contain a non-null value, used to avoid NullPointerException（✓ 正確）
- C. To create optional threads
- D. To define optional module dependencies

**答：B。** Optional<T> is a container that may or may not contain a non-null value. It provides methods like isPresent(), ifPresent(), orElse(), orElseGet(), and map() to handle the presence or absence of a value safely, reducing NullPointerExceptions and making APIs more expressive about nullable return values.

### Q096 [MEDIUM] Given the code: List.of(1,2,3,4,5).stream().filter(n -> n > 2).map(n -> n * 2).toList() ??what is the result?

- A. [2, 4, 6, 8, 10]
- B. [6, 8, 10]（✓ 正確）
- C. [3, 4, 5]
- D. [1, 2, 3, 4, 5]

**答：B。** The stream pipeline first filters elements greater than 2 (leaving 3, 4, 5), then maps each to its double (producing 6, 8, 10). The toList() terminal operation (added in Java 16) collects the results into an unmodifiable list. The result is [6, 8, 10].

### Q097 [MEDIUM] What is the purpose of the Collectors.groupingBy() method?

- A. Grouping files in a directory
- B. Classifying stream elements into groups based on a classification function, returning a Map where keys are group identifiers and values are lists of elements（✓ 正確）
- C. Grouping threads in a pool
- D. Grouping modules together

**答：B。** Collectors.groupingBy() is a collector that classifies stream elements into groups. It takes a classification function that maps elements to keys and returns a Map<K, List<T>>. It can be combined with downstream collectors for more complex operations like counting, summing, or further grouping.

### Q098 [MEDIUM] What is the difference between Stream.map() and Stream.flatMap()?

- A. map() is faster than flatMap()
- B. map() transforms each element to one output element, while flatMap() transforms each element to zero or more elements by flattening nested streams into a single stream（✓ 正確）
- C. flatMap() only works with flat collections
- D. map() works with primitives only

**答：B。** Stream.map() applies a function to each element producing a one-to-one transformation (each input produces exactly one output). Stream.flatMap() applies a function that returns a stream for each element and flattens all resulting streams into a single stream, enabling one-to-many transformations and handling nested collections.

### Q099 [MEDIUM] What is a method reference in Java and what are its types?

- A. A reference variable pointing to a method's memory address
- B. A shorthand notation for a lambda expression that calls an existing method, with four types: static, instance of object, instance of type, and constructor reference（✓ 正確）
- C. A URL pointing to API documentation
- D. A pointer to a native method

**答：B。** Method references are shorthand for lambdas that simply call an existing method. Four types exist: static (ClassName::staticMethod), bound instance (object::instanceMethod), unbound instance (ClassName::instanceMethod), and constructor (ClassName::new). For example, String::toUpperCase is equivalent to s -> s.toUpperCase().

### Q100 [MEDIUM] What is the purpose of the Predicate<T> functional interface?

- A. Predicting future values
- B. Representing a boolean-valued function that takes one argument and returns true or false, commonly used for filtering（✓ 正確）
- C. Preprocessing data
- D. Predetermining outcomes

**答：B。** Predicate<T> is a functional interface that takes an argument of type T and returns a boolean. It's commonly used for filtering in streams (stream.filter(predicate)). It provides default methods and(), or(), and negate() for composing predicates. For example: Predicate<String> isLong = s -> s.length() > 10.

### Q101 [MEDIUM] What is the difference between Stream.reduce() and Stream.collect()?

- A. They produce identical results
- B. reduce() combines elements into a single result using an associative accumulator function, while collect() performs mutable reduction into a container (like List, Set, or Map)（✓ 正確）
- C. reduce() is for numbers only
- D. collect() is slower

**答：B。** Stream.reduce() performs immutable reduction, combining elements into a single value using an associative function (e.g., summing numbers). Stream.collect() performs mutable reduction, accumulating elements into a mutable container (List, Set, Map, StringBuilder). collect() with Collectors provides rich operations like grouping, partitioning, and joining.

### Q102 [HARD] What is a parallel stream in Java and when should it be used?

- A. A stream that runs on a parallel computer
- B. A stream that divides its elements into sub-streams processed concurrently using the Fork/Join framework; best for CPU-intensive operations on large datasets（✓ 正確）
- C. A stream with parallel data structures
- D. Two streams running side by side

**答：B。** A parallel stream divides its elements into sub-streams that are processed concurrently using the Fork/Join framework's common pool. Created via .parallelStream() or .stream().parallel(), they can improve performance for CPU-intensive operations on large datasets. However, they add overhead and can degrade performance for small datasets, I/O-bound operations, or operations with shared mutable state.

### Q103 [MEDIUM] What happens when you use Stream.peek() in a stream pipeline?

- A. It returns the first element
- B. peek() performs an action on each element as it passes through the pipeline without modifying elements, primarily used for debugging; it only executes when a terminal operation is invoked（✓ 正確）
- C. It always executes immediately
- D. It removes elements from the stream

**答：B。** Stream.peek() is an intermediate operation that performs a Consumer action on each element as it flows through the pipeline, returning the stream unchanged. It is primarily used for debugging (e.g., printing elements). Like all intermediate operations, peek() is lazy and only executes when a terminal operation triggers pipeline evaluation.

### Q104 [HARD] What is the difference between Collectors.toList() and Stream.toList()?

- A. They are identical
- B. Collectors.toList() returns a mutable List (typically ArrayList; mutability not guaranteed by older specs), while Stream.toList() (Java 16+) returns an unmodifiable list and is more concise（✓ 正確）
- C. toList() is slower
- D. Collectors.toList() is deprecated

**答：B。** Collectors.toList() used with collect() historically returns a mutable ArrayList in the JDK, though the Collector contract historically did not guarantee the concrete type. Stream.toList() (Java 16+) is a terminal operation that returns an unmodifiable List and does not require importing Collectors. Use Stream.toList() when immutability is desired; use collect(Collectors.toCollection(ArrayList::new)) when you need an explicitly mutable ArrayList.

### Q105 [HARD] What is the purpose of the Stream.teeing() collector?

- A. Teeing up golf balls
- B. A collector that passes each element to two downstream collectors simultaneously and then merges their results using a BiFunction（✓ 正確）
- C. Creating T-shaped data structures
- D. Duplicating streams

**答：B。** Collectors.teeing() (Java 12+) takes two downstream collectors and a merge function. Each stream element is processed by both collectors simultaneously, and then the merge function combines the two results into a final value. For example: teeing(counting(), summingDouble(x->x), (count, sum) -> sum/count) calculates an average in a single pass.

### Q106 [MEDIUM] What is the difference between intermediate and terminal operations in the Stream API?

- A. Terminal operations come first
- B. Intermediate operations are lazy and return a new stream (filter, map, sorted), while terminal operations are eager and trigger pipeline execution returning a result (collect, forEach, count)（✓ 正確）
- C. Intermediate operations modify the source
- D. Terminal operations can be chained

**答：B。** Intermediate operations (filter, map, flatMap, sorted, distinct, peek) are lazy ??they return a new Stream and don't process elements until a terminal operation is invoked. Terminal operations (collect, forEach, count, reduce, findFirst, anyMatch) trigger the processing pipeline and produce a result or side-effect. A stream can only have one terminal operation.

### Q107 [HARD] What is the difference between map() and flatMap() in Optional?

- A. They are identical
- B. map() wraps the result in Optional (possibly nested Optional<Optional<T>>), while flatMap() expects the mapping function to return Optional and flattens it, avoiding nested Optionals（✓ 正確）
- C. flatMap() is for collections only
- D. map() is deprecated

**答：B。** Optional.map() applies a function and wraps the result in Optional. If the function itself returns Optional, you get Optional<Optional<T>>. Optional.flatMap() expects the function to return Optional<T> and doesn't wrap it again, preventing nesting. Use flatMap() when the mapping function already returns Optional to maintain a flat structure.

### Q108 [HARD] How do you create a custom Collector for the Stream API?

- A. Extend the ArrayList class
- B. Implement Collector<T,A,R> with supplier(), accumulator(), combiner(), finisher(), and characteristics() methods, or use Collector.of() factory method（✓ 正確）
- C. Override the collect() method
- D. Use the @Collector annotation

**答：B。** A custom Collector implements Collector<T,A,R> providing: supplier() (creates accumulator container), accumulator() (adds element to container), combiner() (merges two containers for parallel), finisher() (transforms accumulator to result), and characteristics() (CONCURRENT, UNORDERED, IDENTITY_FINISH). The Collector.of() factory method provides a convenient alternative.

### Q109 [MEDIUM] What is the difference between findFirst() and findAny() in the Stream API?

- A. They always return the same element
- B. findFirst() returns the first element in encounter order (deterministic), while findAny() may return any element and performs better in parallel streams（✓ 正確）
- C. findAny() returns all elements
- D. findFirst() only works with sorted streams

**答：B。** findFirst() returns the first element in encounter order, which is deterministic for sequential and ordered parallel streams. findAny() may return any matching element and has relaxed ordering constraints, making it more efficient for parallel streams since it can return whichever element any thread finds first without synchronization overhead.

### Q110 [MEDIUM] What is the purpose of the @FunctionalInterface annotation?

- A. Making any interface functional
- B. An informative annotation indicating the interface is intended to be a functional interface; the compiler will generate an error if the interface has more than one abstract method（✓ 正確）
- C. Converting a class to an interface
- D. Enabling lambda support for the class

**答：B。** @FunctionalInterface is an informative annotation that indicates the interface is designed as a functional interface (exactly one abstract method). While not required for lambda usage, it causes a compile-time error if the interface has more than one abstract method, preventing accidental addition of abstract methods that would break lambda compatibility.

### Q111 [HARD] What is the purpose of Collectors.partitioningBy() and how does it differ from groupingBy()?

- A. They produce identical results
- B. partitioningBy() divides elements into exactly two groups based on a Predicate (true/false), returning Map<Boolean, List<T>>, while groupingBy() can create any number of groups based on a classification function（✓ 正確）
- C. partitioningBy() creates more groups
- D. groupingBy() only works with numbers

**答：B。** Collectors.partitioningBy() takes a Predicate and divides stream elements into exactly two groups: a true list and a false list, returning Map<Boolean, List<T>>. Both lists are always present (possibly empty). groupingBy() takes a Function and can create any number of groups based on the key returned. partitioningBy() is a special case of groupingBy().


---

## 模組與套件（14 題）

### Q112 [EASY] What is the purpose of the 'module-info.java' file in Java?

- A. To store module documentation
- B. To define a Java module's dependencies, exported packages, and service declarations（✓ 正確）
- C. To configure the JVM runtime
- D. To list module test cases

**答：B。** The module-info.java file defines a Java module introduced in Java 9 (Project Jigsaw). It declares the module name, its dependencies (requires), which packages it exports (exports), which services it provides or uses, and which packages it opens for reflection. This enables strong encapsulation at the package level.

### Q113 [MEDIUM] What does the 'requires' directive do in a module-info.java file?

- A. Requires a specific Java version
- B. Declares a dependency on another module, making that module's exported packages available（✓ 正確）
- C. Requires user authentication
- D. Requires a minimum memory allocation

**答：B。** The 'requires' directive in module-info.java declares that the current module depends on another module. This means the required module's exported packages become accessible to the current module. For example, 'requires java.sql;' makes the java.sql module's exported packages available for use.

### Q114 [MEDIUM] What is the purpose of the 'exports' directive in a Java module?

- A. Exporting files to another server
- B. Making a package accessible to other modules that require this module（✓ 正確）
- C. Exporting data to CSV
- D. Exporting configuration settings

**答：B。** The 'exports' directive in module-info.java makes a package from the current module accessible to other modules. Only exported packages can be accessed by modules that 'require' this module. Packages not exported are strongly encapsulated. You can also use 'exports ... to ...' for qualified exports to specific modules.

### Q115 [MEDIUM] What is the purpose of the 'opens' directive in a Java module?

- A. Opening a file for reading
- B. Allowing deep reflection access to a package at runtime, which is needed by frameworks like Spring and Hibernate（✓ 正確）
- C. Opening a network connection
- D. Opening a database cursor

**答：B。** The 'opens' directive in module-info.java allows deep reflection access to a package at runtime. Unlike 'exports' which provides compile-time access, 'opens' enables frameworks like Spring, Hibernate, and JPA to access private members via reflection. You can use 'opens ... to ...' for qualified access to specific modules.

### Q116 [MEDIUM] What is the difference between a package and a module in Java?

- A. They are the same concept
- B. A package organizes related classes under a namespace, while a module groups related packages and defines explicit dependencies and access rules at a higher level（✓ 正確）
- C. Modules replaced packages in Java 9
- D. Packages are for source code, modules are for compiled code

**答：B。** Packages organize classes into namespaces using the package statement. Modules (introduced in Java 9) operate at a higher level, grouping related packages together and defining explicit dependencies (requires) and access control (exports, opens) through module-info.java. Modules provide strong encapsulation that packages alone cannot enforce.

### Q117 [MEDIUM] What is the purpose of the 'provides...with' directive in a Java module?

- A. Providing resources to users
- B. Declaring that a module provides an implementation of a service interface, enabling the ServiceLoader mechanism（✓ 正確）
- C. Providing default values
- D. Providing documentation

**答：B。** The 'provides ServiceInterface with ImplementationClass' directive in module-info.java declares that the module provides an implementation of a service interface. This is part of the Java ServiceLoader mechanism (SPI), enabling loose coupling where modules can discover and use service implementations without direct dependencies on implementing classes.

### Q118 [HARD] How does the 'requires transitive' directive differ from 'requires' in Java modules?

- A. It's the same as requires
- B. 'requires transitive' not only declares a dependency but also makes that dependency transitively available to any module that requires the current module（✓ 正確）
- C. Transitive requires is optional
- D. Transitive means temporary

**答：B。** 'requires transitive moduleB' in moduleA means that moduleA depends on moduleB, AND any module that requires moduleA will also implicitly have access to moduleB's exported packages. This is called implied readability. Without 'transitive', each module must explicitly declare its own dependencies.

### Q119 [HARD] How does the ServiceLoader work in the Java module system?

- A. It loads services from a web server
- B. ServiceLoader discovers and loads service implementations by scanning module declarations (provides/uses directives) or META-INF/services files, enabling loose coupling through SPI（✓ 正確）
- C. It loads microservices
- D. It loads class files from disk

**答：B。** ServiceLoader provides a Service Provider Interface (SPI) mechanism. A service module declares 'uses ServiceInterface' and provider modules declare 'provides ServiceInterface with ImplementationClass'. ServiceLoader.load(ServiceInterface.class) discovers and lazily instantiates all implementations, enabling plugin-like architectures with loose coupling between service consumers and providers.

### Q120 [HARD] What is the purpose of the 'uses' directive in a Java module?

- A. Tracking software usage
- B. Declaring that the module uses a service interface, enabling it to discover implementations via ServiceLoader（✓ 正確）
- C. Using other modules' resources
- D. Recording user activity

**答：B。** The 'uses ServiceInterface' directive declares that the module is a consumer of a service. This enables the module to discover and load implementations of that service interface using ServiceLoader.load(). Without this directive, the module system would not allow the module to discover service providers, even if they are on the module path.

### Q121 [HARD] How does the module system handle split packages (same package in multiple modules)?

- A. Packages are automatically merged
- B. The Java module system prohibits split packages ??the same package cannot be exported by two modules, causing a compile-time or startup error（✓ 正確）
- C. Split packages are allowed but deprecated
- D. The first module found wins

**答：B。** The Java module system strictly prohibits split packages ??a situation where the same package exists in two different modules. If two modules export or contain the same package, the JVM reports an error at startup. This eliminates the classpath ambiguity where the same package could come from multiple JARs, improving reliability.

### Q122 [HARD] What is the difference between 'exports' and 'exports...to' in a Java module?

- A. No difference
- B. 'exports pkg' makes the package accessible to all modules, while 'exports pkg to moduleA, moduleB' is a qualified export making it accessible only to the specified modules（✓ 正確）
- C. 'exports...to' is deprecated
- D. 'exports' is for classes, 'exports...to' is for packages

**答：B。** 'exports pkg' (unqualified export) makes the package accessible to all other modules. 'exports pkg to moduleA, moduleB' (qualified export) restricts access to only the specified modules. Qualified exports are useful for allowing access to internal APIs for specific trusted modules (like test modules) while keeping them hidden from all other modules.

### Q123 [HARD] What is an automatic module in the Java module system?

- A. A module that compiles automatically
- B. A JAR placed on the module path that becomes a module automatically (its name derived from the JAR filename), with all packages exported and reading all other modules（✓ 正確）
- C. A module with automatic updates
- D. A self-executing module

**答：B。** An automatic module is a regular JAR (without module-info.java) placed on the module path. It automatically gets a module name derived from the JAR filename (or Automatic-Module-Name manifest entry), exports all its packages, and can read all other modules. This provides a migration path for non-modular libraries to be used in the module system.

### Q124 [HARD] What is the unnamed module in Java's module system?

- A. A module with no exported packages
- B. The module containing all code on the classpath that isn't part of any named module; it can read all other modules but doesn't export any packages to named modules（✓ 正確）
- C. A deleted module
- D. A hidden system module

**答：B。** The unnamed module contains all classes loaded from the classpath (not the module path). It can read all named modules and access all exported packages. However, named modules cannot read the unnamed module. This provides backward compatibility, allowing non-modular applications to run unchanged while modular code transitions to the module system.

### Q125 [MEDIUM] Which module directive is used so frameworks can reflectively access private members of a package at runtime?

- A. exports com.example.internal
- B. opens com.example.internal;（✓ 正確）
- C. requires com.example.internal;
- D. uses com.example.internal;

**答：B。** opens grants deep reflective access at runtime (needed by many frameworks). exports grants compile-time access to public types. requires declares a module dependency. uses declares a service consumption.


---

## 並行（17 題）

### Q126 [EASY] What does the 'synchronized' keyword do in Java?

- A. Synchronizes the system clock
- B. Ensures that only one thread can execute a block of code or method at a time, preventing race conditions（✓ 正確）
- C. Synchronizes two databases
- D. Synchronizes file contents

**答：B。** The 'synchronized' keyword provides mutual exclusion by ensuring that only one thread can execute a synchronized block or method at a time. It acquires an intrinsic lock (monitor) on the specified object, preventing concurrent access to shared mutable state and avoiding race conditions.

### Q127 [MEDIUM] What is the CompletableFuture class used for in Java?

- A. Completing unfinished code
- B. Representing a future result of an asynchronous computation with support for chaining, combining, and handling completion stages（✓ 正確）
- C. Completing forms automatically
- D. Future date calculations

**答：B。** CompletableFuture<T> represents a future result of an asynchronous computation. It supports chaining (thenApply, thenCompose), combining results (thenCombine, allOf, anyOf), exception handling (exceptionally, handle), and async execution. It implements both Future and CompletionStage interfaces, enabling complex asynchronous programming patterns.

### Q128 [MEDIUM] What is the difference between Runnable and Callable in Java?

- A. They are identical interfaces
- B. Runnable's run() method returns void and cannot throw checked exceptions, while Callable's call() method returns a value and can throw checked exceptions（✓ 正確）
- C. Runnable is newer than Callable
- D. Callable cannot be used with threads

**答：B。** Runnable defines run() which returns void and cannot throw checked exceptions. Callable<V> defines call() which returns a value of type V and can throw checked exceptions. Callable is typically used with ExecutorService.submit() which returns a Future<V> to retrieve the result of the computation.

### Q129 [MEDIUM] What is the ExecutorService interface used for in Java concurrency?

- A. Executing SQL queries
- B. Managing a pool of threads and providing methods to submit, execute, and manage asynchronous tasks（✓ 正確）
- C. Executing system commands
- D. Managing service executables

**答：B。** ExecutorService is a higher-level replacement for manually creating and managing threads. It manages a thread pool and provides methods like submit() (returns Future), execute() (fire-and-forget), invokeAll(), and invokeAny() for managing asynchronous task execution. It also supports graceful shutdown via shutdown() and shutdownNow().

### Q130 [MEDIUM] What is the volatile keyword used for in Java concurrency?

- A. Marking temporary variables
- B. Ensuring that reads and writes to a variable are visible to all threads by preventing CPU cache-related visibility issues（✓ 正確）
- C. Making variables immutable
- D. Marking variables for garbage collection

**答：B。** The volatile keyword ensures visibility of changes to a variable across threads. When a variable is declared volatile, reads and writes go directly to main memory rather than thread-local caches. This prevents one thread from seeing stale values cached by another thread. However, volatile does not provide atomicity for compound operations.

### Q131 [MEDIUM] What is the purpose of the ReentrantLock class compared to synchronized?

- A. They are identical in functionality
- B. ReentrantLock provides advanced features like tryLock(), timed locking, interruptible locking, fair ordering, and multiple condition variables that synchronized doesn't offer（✓ 正確）
- C. ReentrantLock is slower than synchronized
- D. ReentrantLock is deprecated

**答：B。** ReentrantLock provides more flexible locking than synchronized. It supports tryLock() (non-blocking lock attempt), tryLock(timeout) (timed locking), lockInterruptibly() (interruptible locking), fair ordering (FIFO), and multiple Condition objects for wait/notify. However, it requires explicit lock/unlock in try-finally blocks unlike synchronized's automatic release.

### Q132 [MEDIUM] What is the ConcurrentHashMap and how does it differ from HashMap?

- A. It's a slower version of HashMap
- B. ConcurrentHashMap allows safe concurrent access by multiple threads without locking the entire map, while HashMap is not thread-safe and can cause data corruption with concurrent access（✓ 正確）
- C. ConcurrentHashMap uses more memory
- D. They have different key types

**答：B。** ConcurrentHashMap is a thread-safe Map that allows concurrent reads and writes without external synchronization. Since Java 8 it uses CAS and fine-grained per-bin locking rather than locking the entire map. HashMap is not thread-safe and concurrent mutation can corrupt its structure. Prefer ConcurrentHashMap over Collections.synchronizedMap for high-concurrency maps.

### Q133 [HARD] What is the Fork/Join framework in Java?

- A. A dining utensil management system
- B. A framework for parallel execution that recursively divides tasks into subtasks (fork), processes them in parallel, and combines results (join), using work-stealing for load balancing（✓ 正確）
- C. A source control branching tool
- D. A network routing protocol

**答：B。** The Fork/Join framework (java.util.concurrent.ForkJoinPool) implements a divide-and-conquer approach to parallelism. Tasks extend RecursiveTask<V> (returns result) or RecursiveAction (no result), recursively forking subtasks when the workload is large and joining results when complete. Work-stealing allows idle threads to take tasks from busy threads' queues.

### Q134 [HARD] What is the AtomicInteger class and when should it be used?

- A. An integer that can't be changed
- B. A thread-safe integer that supports atomic operations (compareAndSet, incrementAndGet, etc.) without synchronization, ideal for lock-free concurrent counters（✓ 正確）
- C. An integer for atomic physics calculations
- D. A very small integer type

**答：B。** AtomicInteger (java.util.concurrent.atomic) provides thread-safe integer operations using hardware-level compare-and-swap (CAS) instructions without locking. Methods like incrementAndGet(), compareAndSet(), and getAndAdd() are atomic. It's ideal for concurrent counters, sequence generators, and lock-free algorithms where synchronized or volatile alone aren't sufficient.

### Q135 [HARD] What is the difference between a deadlock and a livelock in concurrent programming?

- A. They are the same thing
- B. A deadlock occurs when threads are permanently blocked waiting for each other's locks, while a livelock occurs when threads keep responding to each other without making progress（✓ 正確）
- C. Deadlocks are worse than livelocks
- D. Livelocks only happen with virtual threads

**答：B。** A deadlock occurs when two or more threads are permanently blocked, each waiting to acquire a lock held by another. A livelock occurs when threads keep responding to each other's actions (e.g., constantly yielding) without making progress ??they're not blocked but still can't complete. Both prevent forward progress but deadlocked threads are stuck while livelocked threads are active.

### Q136 [HARD] What is the ReadWriteLock interface and when is it beneficial?

- A. A lock for file read/write operations
- B. An interface providing separate locks for reading (shared) and writing (exclusive), improving throughput when reads greatly outnumber writes（✓ 正確）
- C. A lock on database read/write modes
- D. A two-factor authentication lock

**答：B。** ReadWriteLock (typically ReentrantReadWriteLock) provides two locks: a read lock (shared ??multiple threads can read simultaneously) and a write lock (exclusive ??only one thread can write, blocking all readers). This improves throughput in read-heavy scenarios where multiple concurrent reads are safe but writes need exclusive access.

### Q137 [HARD] What is the purpose of the CountDownLatch in Java concurrency?

- A. Counting down time
- B. A synchronization aid that allows one or more threads to wait until a set of operations being performed by other threads completes, using a count that reaches zero（✓ 正確）
- C. Counting database rows
- D. A countdown timer for tasks

**答：B。** CountDownLatch is initialized with a count. Threads call await() to wait until the count reaches zero. Other threads call countDown() to decrement the count. When it reaches zero, all waiting threads are released. It's useful for waiting until N tasks complete before proceeding. The count cannot be reset (use CyclicBarrier for reusable synchronization).

### Q138 [HARD] What is the Semaphore class used for in Java concurrency?

- A. A traffic signal implementation
- B. A synchronization primitive that controls access to a shared resource by maintaining a set of permits, allowing a specified number of threads to access the resource concurrently（✓ 正確）
- C. A semaphore flag signaling system
- D. An error signaling mechanism

**答：B。** Semaphore maintains a set of permits. Threads call acquire() to obtain a permit (blocking if none available) and release() to return one. A Semaphore(1) acts like a mutex. Semaphore(N) allows up to N concurrent accesses, useful for connection pools, rate limiting, or bounded resource access. Supports fair ordering via the constructor.

### Q139 [HARD] What is the purpose of the Phaser class in Java concurrency?

- A. A Star Trek-inspired class
- B. A flexible synchronization barrier that supports a dynamic number of parties and multiple phases, combining features of CountDownLatch and CyclicBarrier（✓ 正確）
- C. A phase converter for electrical systems
- D. A sound phase analyzer

**答：B。** Phaser is a flexible synchronization barrier that supports a dynamic number of participating threads (parties can register and deregister at runtime) and multiple synchronization phases. It combines the one-shot nature of CountDownLatch with the reusability of CyclicBarrier while adding dynamic party management. arriveAndAwaitAdvance() synchronizes threads at each phase.

### Q140 [HARD] What is the StampedLock class and how does it improve on ReadWriteLock?

- A. A lock that uses physical stamps
- B. A lock supporting three modes ??read, write, and optimistic read ??where optimistic reads allow reading without acquiring a lock, improving performance when writes are rare（✓ 正確）
- C. A timestamped logging lock
- D. A postal service lock

**答：B。** StampedLock adds an optimistic read mode to traditional read/write locking. Optimistic reads don't acquire a lock ??instead, they obtain a stamp, perform the read, then validate the stamp. If no write occurred during the read, the stamp is valid and the read succeeds without locking overhead. If invalid, it falls back to a regular read lock.

### Q141 [MEDIUM] What is the ThreadLocal class used for in Java?

- A. Local threads within a method
- B. A mechanism that provides thread-confined storage where each thread has its own independent copy of a variable, avoiding the need for synchronization（✓ 正確）
- C. A local network thread manager
- D. A thread priority manager

**答：B。** ThreadLocal provides thread-confined storage where each thread accessing the variable gets its own independent copy. This eliminates the need for synchronization since no sharing occurs. Common uses include storing per-request context, database connections, and date formatters. However, ThreadLocal can cause memory leaks if not properly cleaned up.

### Q142 [HARD] What is the purpose of the CyclicBarrier class in Java concurrency?

- A. A physical barrier between threads
- B. A synchronization point where a fixed number of threads must arrive before any can proceed, and the barrier can be reused for multiple synchronization rounds（✓ 正確）
- C. A one-time barrier like CountDownLatch
- D. A barrier for preventing deadlocks

**答：B。** CyclicBarrier allows a fixed number of threads (parties) to wait for each other at a barrier point. When all parties call await(), the barrier trips, optionally running a barrier action, and all threads proceed. Unlike CountDownLatch, the barrier is reusable (cyclic) for multiple rounds of synchronization, making it ideal for iterative parallel algorithms.


---

## I/O API（14 題）

### Q143 [MEDIUM] Which statement about java.nio.file.Path is correct?

- A. Path is a concrete class that always represents an absolute filesystem path
- B. Path is an interface representing a hierarchical path; Paths.get() or Path.of() create Path instances that may be relative or absolute（✓ 正確）
- C. Path can only be created from a File object via new Path(file)
- D. Path operations always throw checked IOException even for pure path manipulation like resolve()

**答：B。** Path (java.nio.file) is an interface for a filesystem path. Create instances with Path.of(...) or Paths.get(...). A Path may be relative or absolute. Pure path operations such as resolve(), relativize(), getFileName(), and normalize() do not access the filesystem and do not throw IOException; filesystem operations like Files.readAllBytes(path) do.

### Q144 [EASY] Which call creates a Path on Java 11+ most idiomatically?

- A. new Path("/tmp/a.txt")
- B. Path.of("/tmp", "a.txt")（✓ 正確）
- C. Paths.create("/tmp/a.txt")
- D. FileSystems.getDefault().newPath()

**答：B。** Path.of (Java 11+) is the preferred factory. Paths.get remains valid and equivalent. Path is an interface ??you cannot construct it with new Path(...).

### Q145 [EASY] What does Files.readString(path) return?

- A. byte[]
- B. The entire file contents as a String using UTF-8 by default（✓ 正確）
- C. Stream<String> of lines
- D. A MappedByteBuffer

**答：B。** Files.readString(Path) (Java 11+) reads all characters from a file into a String, defaulting to UTF-8. An overload accepts Charset. For large files prefer streaming APIs such as Files.lines or streaming readers.

### Q146 [HARD] Which statement about serialization is correct for a class implementing Serializable?

- A. All fields are always serialized including static and transient
- B. transient instance fields are skipped; static fields are not part of object instance state; serialVersionUID should be maintained for compatibility（✓ 正確）
- C. Serializable requires implementing readObject and writeObject
- D. Deserialization always calls the class's public no-arg constructor for Serializable classes

**答：B。** Default serialization writes non-transient, non-static instance fields. transient excludes fields. serialVersionUID documents compatibility. Custom readObject/writeObject are optional. For Serializable, deserialization reconstitutes objects without calling the class's normal constructors (unlike Externalizable).

### Q147 [MEDIUM] What does Files.walk(start, depth) return?

- A. List<Path>
- B. Stream<Path> lazily walking the file tree up to the given max depth（✓ 正確）
- C. Only immediate children as an array
- D. A WatchService

**答：B。** Files.walk returns a Stream<Path> that depth-first walks the file tree. It is lazy and should be used in try-with-resources so the stream (and underlying directory iterators) close. depth limits how deep the walk descends.

### Q148 [EASY] Which I/O class is character-oriented for reading text files efficiently with buffering?

- A. FileInputStream
- B. BufferedReader wrapping a FileReader or Files.newBufferedReader(path)（✓ 正確）
- C. DataInputStream only
- D. ObjectInputStream

**答：B。** BufferedReader buffers character input and provides readLine(). Prefer Files.newBufferedReader(path, charset) over raw FileReader (which uses the default charset). FileInputStream/DataInputStream are byte-oriented.

### Q149 [MEDIUM] What is the difference between Path.resolve("b") on Path "/a" versus Path.relativize?

- A. They are identical
- B. resolve combines paths (e.g., /a + b ??/a/b); relativize computes a relative path between two paths（✓ 正確）
- C. relativize always returns an absolute path
- D. resolve deletes the original path

**答：B。** resolve joins a path with another path or string (if the other is absolute, it replaces). relativize returns a relative path that, when resolved against the original, locates the other path. Both are pure Path operations without I/O.

### Q150 [MEDIUM] Which Console method reads a password without echoing characters?

- A. readLine()
- B. readPassword()（✓ 正確）
- C. readSecret() ??standard since Java 8
- D. System.stdin.readPassword()

**答：B。** java.io.Console.readPassword() reads a password without echoing and returns char[] (prefer clearing the array after use). Obtain the console via System.console(), which may be null in some environments (IDEs).

### Q151 [HARD] What does Files.exists(path) return for a broken symbolic link by default?

- A. true always
- B. false ??the target is missing, so the link does not resolve to an existing file（✓ 正確）
- C. throws IOException always
- D. true if the link inode exists regardless of options

**答：B。** By default Files.exists follows links. A dangling symbolic link yields false. To test the link itself use LinkOption.NOFOLLOW_LINKS. exists does not throw for ordinary absence; other attributes methods may.

### Q152 [EASY] Which statement about InputStream and Reader is correct?

- A. Both always read 16-bit chars
- B. InputStream reads bytes; Reader reads characters (applying charset decoding)（✓ 正確）
- C. Reader is only for network sockets
- D. InputStream cannot be buffered

**答：B。** Byte streams (InputStream/OutputStream) handle raw bytes. Character streams (Reader/Writer) handle text with encoding. Bridge with InputStreamReader/OutputStreamWriter specifying Charset. Buffering wrappers exist for both hierarchies.

### Q153 [MEDIUM] What does ObjectOutputStream.writeObject require of the object graph?

- A. Only the root type needs Serializable; referenced objects never do
- B. The object and reachable non-transient non-static fields' types must be serializable (or marked transient), else NotSerializableException（✓ 正確）
- C. All classes must extend Externalizable
- D. writeObject only works with records

**答：B。** Default serialization walks the object graph. Every non-transient instance field must be serializable (or null). Encountering a non-serializable instance throws NotSerializableException. Externalizable is an alternative protocol; records can be Serializable too.

### Q154 [EASY] Which Files method creates a new file, failing if it already exists?

- A. Files.write(path, bytes) always
- B. Files.createFile(path)（✓ 正確）
- C. Files.touch(path)
- D. new FileOutputStream(path) never fails if present

**答：B。** Files.createFile creates a new empty file and throws FileAlreadyExistsException if the file exists. Files.write may create or truncate depending on options (default CREATE, TRUNCATE_EXISTING, WRITE).

### Q155 [EASY] Which Files method copies a file, optionally replacing the target?

- A. Files.move only
- B. Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING)（✓ 正確）
- C. Files.clone
- D. Path.copyTo

**答：B。** Files.copy copies bytes from source to target. Without REPLACE_EXISTING, an existing target causes FileAlreadyExistsException. Other options include COPY_ATTRIBUTES and NOFOLLOW_LINKS.

### Q156 [MEDIUM] Which stream closes underlying resources and should be used in try-with-resources?

- A. Arrays.stream(array)
- B. Files.lines(path) or Files.walk(path)（✓ 正確）
- C. IntStream.range(0, 10)
- D. Stream.of("a", "b")

**答：B。** Files.lines and Files.walk return Streams that hold open directory/file resources. They implement AutoCloseable and should be closed via try-with-resources to avoid resource leaks. In-memory streams like Stream.of do not need closing.


---

## 本地化（11 題）

### Q157 [MEDIUM] How does ResourceBundle locate localized strings for Locale.FRANCE when the base name is messages?

- A. It only loads messages.properties and ignores locale
- B. It searches candidate bundles such as messages_fr_FR, then messages_fr, then messages (default), using the locale's language and country（✓ 正確）
- C. It requires an exact messages_FRANCE.properties filename
- D. It loads only from the module-info.java exports list

**答：B。** ResourceBundle.getBundle("messages", Locale.FRANCE) looks up candidate names in order: messages_fr_FR, messages_fr, then the base messages bundle (and parent chain). Properties files or ListResourceBundle subclasses supply key/value pairs. Missing keys fall back through the parent chain; a missing base bundle throws MissingResourceException.

### Q158 [MEDIUM] What does NumberFormat.getCompactNumberInstance(Locale.US, NumberFormat.Style.SHORT).format(12500) typically produce?

- A. 12,500.00
- B. 12.5K（✓ 正確）
- C. 12500L
- D. XII.VK

**答：B。** Compact number formatting (Java 12+) with Style.SHORT in Locale.US formats 12500 as a short compact form such as 12.5K. LONG style would use words like "12.5 thousand". Exact grouping symbols follow the locale.

### Q159 [MEDIUM] Which Locale factory is preferred in modern Java?

- A. new Locale("en", "US") only
- B. Locale.of("en", "US") (Java 19+) or Locale.forLanguageTag("en-US")（✓ 正確）
- C. Locale.getLocale("en_US")
- D. ResourceBundle.toLocale("en_US")

**答：B。** Locale.of (Java 19+) constructs locales without using the deprecated constructors. Locale.forLanguageTag parses BCP 47 tags like en-US. Prefer these over new Locale(String,...) which is deprecated.

### Q160 [MEDIUM] What does DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM).withLocale(Locale.GERMANY).format(LocalDate.of(2024, 3, 5)) produce conceptually?

- A. Always 2024-03-05 ISO
- B. A Germany-localized medium date string (e.g., 05.03.2024 style), not the ISO local date format（✓ 正確）
- C. An Instant timestamp
- D. A Period

**答：B。** ofLocalizedDate uses locale-sensitive patterns. withLocale(Locale.GERMANY) selects German conventions for order and separators. ISO_LOCAL_DATE would yield 2024-03-05 regardless of locale.

### Q161 [EASY] If ResourceBundle.getBundle("msg", locale) cannot find any candidate bundle including the base, what happens?

- A. Returns an empty ResourceBundle
- B. Throws MissingResourceException（✓ 正確）
- C. Returns null
- D. Creates msg.properties automatically

**答：B。** When no matching properties/class bundle is found for the base name, getBundle throws MissingResourceException. If the base exists but a key is missing, getString throws MissingResourceException for that key after parent lookup fails.

### Q162 [EASY] Which API formats currency for a locale?

- A. String.format always uses USD
- B. NumberFormat.getCurrencyInstance(locale)（✓ 正確）
- C. CurrencyFormat.getInstance only in java.util
- D. MathContext.currency

**答：B。** NumberFormat.getCurrencyInstance(Locale) returns a formatter that applies the locale's currency symbol and grouping. Currency.getInstance provides ISO currency metadata; formatting still goes through NumberFormat or DecimalFormat.

### Q163 [MEDIUM] What is the parent chain role in ResourceBundle?

- A. Parents are unused in Java 21
- B. More specific bundles (e.g., _en_US) have parents (_en, then base) so missing keys fall back to less specific bundles（✓ 正確）
- C. Parents override child values always
- D. Only ListResourceBundle has parents

**答：B。** Candidate bundles form a parent chain from most specific to base. getObject/getString search the child then parents. This enables defaults in the base bundle with locale-specific overrides in more specific files.

### Q164 [HARD] Which statement about Locale.ROOT is correct?

- A. It is an alias for Locale.US
- B. It is a locale-neutral locale useful for root bundle lookups and locale-insensitive operations（✓ 正確）
- C. It forces French formatting
- D. It cannot be used with ResourceBundle

**答：B。** Locale.ROOT represents the root locale (empty language/country/variant). ResourceBundle uses it as the ultimate base. It is also used when locale-insensitive identifiers are required.

### Q165 [EASY] What does MessageFormat.format("Hello, {0}!", "Ada") return?

- A. Hello, {0}!
- B. Hello, Ada!（✓ 正確）
- C. Compilation error
- D. An array of strings

**答：B。** MessageFormat replaces {0}, {1}, ... placeholders with argument values and supports locale-sensitive subformats (dates, numbers, choice). It is commonly paired with ResourceBundle patterns for localized messages.

### Q166 [MEDIUM] What is Collator.getInstance(Locale.FRANCE) used for?

- A. Encrypting strings
- B. Locale-sensitive String ordering and comparison for French text conventions（✓ 正確）
- C. Compiling regex only
- D. Converting char to int

**答：B。** Collator provides locale-sensitive comparison for sorting and searching text. French collation rules differ from binary Unicode code-point order. Compare via collator.compare(s1, s2).

### Q167 [HARD] Which DecimalFormat pattern formats with at least two integer digits and exactly two fraction digits?

- A. #.##
- B. 00.00（✓ 正確）
- C. 0
- D. %

**答：B。** In DecimalFormat, 0 is a required digit place and # is optional. Pattern 00.00 ensures at least two integer digits (leading zero if needed) and exactly two fraction digits.


---

## 例外處理（15 題）

### Q168 [HARD] In try { throw new IllegalArgumentException(); } catch (IllegalArgumentException e) { throw new RuntimeException(); } finally { throw new NullPointerException(); } which exception propagates?

- A. IllegalArgumentException
- B. RuntimeException
- C. NullPointerException（✓ 正確）
- D. Both RuntimeException and NullPointerException as a suppressed pair only

**答：C。** An exception thrown in finally suppresses the exception pending from try/catch. Here finally's NullPointerException is what propagates to the caller; the RuntimeException from catch is suppressed (accessible via getSuppressed()).

### Q169 [MEDIUM] Which multi-catch declaration is valid?

- A. catch (IOException | Exception e)
- B. catch (FileNotFoundException | SQLException e) when neither is a subclass of the other（✓ 正確）
- C. catch (Exception | RuntimeException e)
- D. catch (IOException e | SQLException e)

**答：B。** Multi-catch alternatives must be disjoint ??one type cannot subclass another in the same multi-catch. FileNotFoundException and SQLException are siblings under Exception, so that form is valid. Exception | RuntimeException is invalid because RuntimeException extends Exception. A single parameter name applies to the entire alternatives list.

### Q170 [HARD] What is printed by try (Demo d = new Demo()) { System.out.print("start "); throw new Exception(); } catch (Exception e) { System.out.print("catch "); } when Demo.close() prints "close " and throws RuntimeException?

- A. start catch
- B. start close catch（✓ 正確）
- C. start catch close
- D. close start catch

**答：B。** try-with-resources closes resources before catch/finally. Order: try body prints start, throws; close() runs and prints close (its RuntimeException is suppressed on the primary Exception); then catch handles the primary Exception and prints catch.

### Q171 [EASY] Which exception must be declared or caught?

- A. NullPointerException
- B. IOException from a method that throws IOException（✓ 正確）
- C. ArrayIndexOutOfBoundsException
- D. IllegalArgumentException

**答：B。** IOException is a checked exception (extends Exception, not RuntimeException). Callers must catch it or declare throws. NullPointerException, ArrayIndexOutOfBoundsException, and IllegalArgumentException are unchecked.

### Q172 [EASY] What does try-with-resources require of the resource type?

- A. It must extend Thread
- B. It must implement AutoCloseable (or Closeable), so close() is called automatically（✓ 正確）
- C. It must be a java.io.File
- D. It must be declared final explicitly in all Java versions

**答：B。** Resources in try-with-resources must be AutoCloseable. Closeable extends AutoCloseable for I/O streams. Effective from Java 9, the resource may be a final or effectively final variable declared earlier; earlier Java required declaration inside the try.

### Q173 [MEDIUM] When close() on a try-with-resources resource throws after the try body also threw, what happens?

- A. Only the close exception propagates
- B. The try-body exception propagates; the close exception is attached as a suppressed exception（✓ 正確）
- C. Both are wrapped in UndeclaredThrowableException
- D. The close exception is silently discarded

**答：B。** The primary exception from the try body (or from an earlier resource close) propagates. Exceptions from subsequent close() calls are added via addSuppressed. This preserves the original failure while retaining close failures for diagnostics.

### Q174 [EASY] What is the difference between throw and throws?

- A. They are interchangeable keywords
- B. throw transfers control by throwing an exception instance; throws declares checked exceptions a method may propagate（✓ 正確）
- C. throws creates the exception object
- D. throw only appears in method signatures

**答：B。** throw new SomeException() actually throws. throws IOException in a method signature declares that checked exceptions may propagate to the caller. A method may both throw and declare throws.

### Q175 [HARD] Can a catch block catch Error subclasses like OutOfMemoryError?

- A. No ??catch can only catch Exception
- B. Yes ??catch (Throwable t) or catch (Error e) can catch Errors, but catching Error is rarely appropriate（✓ 正確）
- C. Only if declared in throws
- D. Errors are converted to Exceptions automatically

**答：B。** catch can target any Throwable subtype, including Error. In practice, catching OutOfMemoryError or LinkageError is discouraged except for specialized frameworks. Checked-exception rules apply only under Exception excluding RuntimeException.

### Q176 [HARD] What does precise rethrow (Java 7+) allow for a catch (Exception e) { throw e; } parameter?

- A. Rethrowing only as Exception
- B. If e is effectively final and the try only throws certain checked types, the compiler may treat the rethrow as those more specific checked types（✓ 正確）
- C. Removing throws clauses entirely
- D. Converting checked to unchecked automatically

**答：B。** When a catch parameter is effectively final and the try block only throws certain checked exceptions, rethrowing that parameter can be typed as those specific checked exceptions rather than the broad catch type Exception. This enables precise throws clauses.

### Q177 [MEDIUM] Which is true about overriding methods and checked exceptions?

- A. An override may add any new checked exceptions
- B. An overriding method cannot throw new checked exceptions not allowed by the overridden method; it may throw fewer or narrower checked exceptions（✓ 正確）
- C. Overrides must declare exactly the same throws clause
- D. Unchecked exceptions cannot be thrown from overrides

**答：B。** Overriding methods may omit checked exceptions or declare subclasses of the superclass checked exceptions, but cannot declare additional checked exceptions outside that set. Unchecked exceptions may always be thrown.

### Q178 [MEDIUM] What does try-with-resources do when multiple resources are declared?

- A. Closes them in declaration order
- B. Closes them in reverse declaration order（✓ 正確）
- C. Closes only the first resource
- D. Closes randomly

**答：B。** Resources declared in try (R1 r1 = ...; R2 r2 = ...) are closed in reverse order of declaration ??r2 then r1 ??analogous to nested try-with-resources. Close exceptions may be suppressed on a primary exception.

### Q179 [EASY] Which custom exception declaration is most appropriate for a recoverable business-rule violation?

- A. class Bad extends Error
- B. class Bad extends Exception (checked) or a suitable RuntimeException if the API prefers unchecked（✓ 正確）
- C. class Bad extends Thread
- D. class Bad without extending Throwable

**答：B。** Application exceptions extend Exception (checked) or RuntimeException (unchecked). Extending Error is reserved for serious JVM issues. Every exception must extend Throwable (typically via Exception).

### Q180 [HARD] What is returned by: try { return "try"; } finally { return "finally"; } in a String method?

- A. try
- B. finally（✓ 正確）
- C. tryfinally
- D. Compilation error ??return forbidden in finally

**答：B。** A return in finally overrides a return (or exception) from try/catch. The method returns "finally". Returning from finally is legal but discouraged because it discards the try result and suppresses exceptions.

### Q181 [MEDIUM] Which statement about Throwable.getSuppressed() is correct?

- A. getSuppressed() exists only on Error
- B. getSuppressed() returns exceptions attached via addSuppressed, commonly from try-with-resources close failures（✓ 正確）
- C. Suppressed exceptions replace the primary exception
- D. Only one suppressed exception is ever allowed

**答：B。** When try-with-resources close() fails after a primary exception, the close failure is addSuppressed onto the primary. getSuppressed() returns that array. Multiple suppressed exceptions can accumulate.

### Q182 [EASY] Does a method that catches IOException and does not rethrow need throws IOException?

- A. Yes always
- B. No ??if the checked exception is caught and not rethrown, the method need not declare throws IOException（✓ 正確）
- C. Only if the method is public
- D. Only in modules

**答：B。** throws is required for checked exceptions that propagate out of the method. Fully handling IOException in a catch block means callers need not declare or catch it for that reason.


