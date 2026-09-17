# 1Z0-830 OCP Java SE 21 Developer - Esteban Herrera Study Guide 考題集

> 來源：https://github.com/eh3rrera/ocpj21-book （免費 CC BY-NC-SA 4.0 線上書籍 ocpj21.javastudyguide.com）
> 整理自各章 `## Practice Questions`（題目）與對應 `chXXa.md`（解答與解析），原書為英文內容，本檔保留原文並加中文說明。

| 章節 | 主題 | 題數 |
|---|---|---|
| 第 01 章 | Utilizing Java Object-Oriented Approach - Part 1 | 24 |
---
### Q001　Utilizing Java Object-Oriented Approach - Part 1

Consider the following code snippet:

**選項：**
```java
public class Main {
    public static void main(String[] args) {
        StringBuilder sb1 = new StringBuilder("Java");
        StringBuilder sb2 = new StringBuilder("Python");
        sb1 = sb2;
        // More code here
    }
}
```
After the execution of the above code, which of the following statements is true regarding garbage collection?
- A. Both `sb1` and `sb2` are eligible for garbage collection.  
- B. Only the `StringBuilder` object initially referenced by `sb1` is eligible for garbage collection.  （✓ 正確）
- C. Only the `StringBuilder` object initially referenced by `sb2` is eligible for garbage collection.  
- D. Neither of the `StringBuilder` objects are eligible for garbage collection.   

**答：B。**

**解析：**

**Explanation:**

- **A)** Both `sb1` and `sb2` are eligible for garbage collection.
  - This option is incorrect because `sb2` still holds a reference to the `StringBuilder` object it was initially assigned. Therefore, it is not eligible for garbage collection.

- **B)** Only the `StringBuilder` object initially referenced by `sb1` is eligible for garbage collection.
  - This option is correct. After `sb1` is reassigned to reference the same object as `sb2`, the original `StringBuilder` object created with `new StringBuilder("Java")` and initially referenced by `sb1` is no longer accessible. Since there are no references pointing to it, it becomes eligible for garbage collection.

- **C)** Only the `StringBuilder` object initially referenced by `sb2` is eligible for garbage collection.
  - This option is incorrect because after the assignment `sb1 = sb2;`, both `sb1` and `sb2` reference the same object (`new StringBuilder("Python")`). This object is still accessible through `sb2` (and now `sb1` as well), so it is not eligible for garbage collection.

- **D)** Neither of the `StringBuilder` objects are eligible for garbage collection.
  - This option is incorrect because, as explained, the object initially referenced by `sb1` becomes eligible for garbage collection after `sb1` is reassigned to `sb2`.

---
### Q002　Utilizing Java Object-Oriented Approach - Part 1

Which of the following are reserved keywords in Java? (Choose all that apply.)

**選項：**
- A. `implement`  
- B. `array`  
- C. `volatile`  （✓ 正確）
- D. `extends`   （✓ 正確）

**答：C、D。**

**解析：**

**Explanation:**

- **A)** `implement` is incorrect. The correct keyword for implementing an interface in Java is `implements`.

- **B)** `array` is incorrect. Java does not have a reserved keyword named `array`. Arrays are declared with square brackets `[ ]`.

- **C)** `volatile` is correct. `volatile` is a reserved keyword that is used to indicate that a variable's value will be modified by different threads.

- **D)** `extends` is correct. `extends` is a reserved keyword used in class declarations to inherit from a superclass.

---
### Q003　Utilizing Java Object-Oriented Approach - Part 1

Consider the following code snippet:

**選項：**
```java
1. // calculates the sum of numbers
2. public class Calculator {
3.     /* Adds two numbers
4.      * @param a the first number
5.      * @param b the second number
6.      * @return the sum of a and b
7.      */
8.     public int add(int a, int b) {
9.         // return the sum
10.        return a + b;
11.    }
12.    //TODO: Implement subtract method
13.}
```
Which of the following statements are true about the comments in the above code? (Choose all that apply.)
- A. Line 1 is an example of a single-line comment.  （✓ 正確）
- B. Lines 3-7 demonstrate the use of a javadoc comment.  
- C. Line 9 uses a javadoc comment to explain the `add` method.  
- D. Line 12 uses a special `TODO` comment, different from a single-line comment.  
- E. Lines 3-7 is a block comment that is used as if it were a javadoc comment.    （✓ 正確）

**答：A、E。**

**解析：**

**Explanation:**

- **A)** Line 1 is an example of a single-line comment.
  - This option is correct. Line 1 uses `//` to start a single-line comment, which is a common way to add notes or explain a part of code that does not affect the execution.

- **B)** Lines 3-7 demonstrate the use of a javadoc comment.
  - This option is incorrect. Lines 3-7 use a block comment. Javadoc comments start with `/**` and end with `*/`.

- **C)** Line 9 uses a javadoc comment to explain the `add` method.
  - This option is incorrect. Line 9 is a single-line comment, not a javadoc comment. Javadoc comments in Java are defined with `/**` at the beginning and `*/` at the end, and are specifically used to describe classes, methods, and fields.

- **D)** Line 12 uses a special `TODO` comment, different from a single-line comment.
  - This option is incorrect. Line 12 uses a `TODO` comment, which is a convention many developers follow to mark parts of the code that require further development or attention but is still a single-line comment.

- **E)** Lines 3-7 is a block comment that is used as if it were a javadoc comment.
  - This option is correct. Lines 3-7 use a block comment, which is not processed by javadoc tools and therefore not suitable for generating official documentation.

---
### Q004　Utilizing Java Object-Oriented Approach - Part 1

Consider you have the following two Java files located in the same directory:

**選項：**
```java
// File 1: Calculator.java
package math;
public class Calculator {
    public int add(int a, int b) {
        return a + b;
    }
}
// File 2: Application.java
package app;
import math.Calculator;
public class Application {
    public static void main(String[] args) {
        Calculator calc = new Calculator();
        System.out.println(calc.add(5, 3));
    }
}
```
Which of the following statements is true regarding the `package` and `import` statements in Java?
- A. The `import` statement in `Application.java` is unnecessary because both classes are in the same directory.  
- B. The `import` statement in `Application.java` is necessary for using the `Calculator` class because they belong to different packages.  （✓ 正確）
- C. The `Calculator` class will not be accessible in `Application.java` due to being in a different directory.  
- D. Removing the `package` statement from both files will allow `Application.java` to use `Calculator` without an `import` statement, regardless of directory structure.   （✓ 正確）

**答：B、D。**

**解析：**

**Explanation:**

- **A)** The `import` statement in `Application.java` is unnecessary because both classes are in the same directory.
  - This option is incorrect. In Java, the `import` statement is used to bring a class or an entire package into visibility, and its necessity is determined by the package membership of the classes, not their directory location. Even if classes are in the same directory, if they belong to different packages, the `import` statement is required to use one in the other.

- **B)** The `import` statement in `Application.java` is necessary for using the `Calculator` class because they belong to different packages.
  - This is the correct answer. The `Calculator` class is in the `math` package, and the `Application` class is in the `app` package. Despite being in the same directory, the different packages require an `import` statement to use `Calculator` in `Application`.

- **C)** The `Calculator` class will not be accessible in `Application.java` due to being in a different directory.
  - This option is incorrect. Java's access control is not based on the directory structure but on the `package` and `import` declarations. As long as the classes are correctly packaged and imported, they can be accessed across different directories.

- **D)** Removing the `package` statement from both files will allow `Application.java` to use `Calculator` without an `import` statement, regardless of directory structure.
  - This option is correct. Removing the `package` statement from both files will place them in the default package, and they will be able to access each other without an `import` statement. However, this is not recommended for anything beyond very simple or temporary code due to namespace management and readability concerns.

---
### Q005　Utilizing Java Object-Oriented Approach - Part 1

Consider the default access levels provided by Java's four access modifiers: `public`, `protected`, `default` (no modifier), and `private`. Which of the following statements correctly describe the access levels granted by these modifiers? (Choose all that apply.)

**選項：**
- A. A `public` class or member can be accessed by any other class in the same package or in any other package.  （✓ 正確）
- B. A `protected` member can be accessed by any class in its own package, but from outside the package, only by classes that extend the class containing the `protected` member.  （✓ 正確）
- C. A member with `default` (no modifier) access can be accessed by any class in the same package but not from a class in a different package.  （✓ 正確）
- D. A `private` member can be accessed only by methods that are members of the same class or within the same file.  
- E. A `protected` member can be accessed by any class in the Java program, regardless of package.   

**答：A、B、C。**

**解析：**

**Explanation:**

- **A)** A `public` class or member can be accessed by any other class in the same package or in any other package.
  - This is correct. The `public` modifier grants the highest level of access. A `public` class or member is accessible from any other class, regardless of the packages they belong to.

- **B)** A `protected` member can be accessed by any class in its own package, but from outside the package, only by classes that extend the class containing the protected member.
  - This is correct. The `protected` access level allows a member to be accessed within its own package and by subclasses in any package. It offers a more restrictive level of access than `public`.

- **C)** A member with `default` (no modifier) access can be accessed by any class in the same package but not from a class in a different package.
  - This is correct. If no access modifier (also known as `default` access level) is specified, the member is accessible only within classes in the same package. This is more restrictive than `protected` and `public`.

- **D)** A `private` member can be accessed only by methods that are members of the same class or within the same file.
  - This option is incorrect because `private` members can be accessed only within the same class. It's not about being within the same file, as Java allows only one public top-level class per file.

- **E)** A `protected` member can be accessed by any class in the Java program, regardless of package.
  - This is incorrect. `Protected` access does not grant universal access across all classes in a program. Access from outside the package is limited to subclasses only.

---
### Q006　Utilizing Java Object-Oriented Approach - Part 1

Which of the following class declarations correctly demonstrates the use of access modifiers, `class` keyword, and class naming conventions in Java?

**選項：**
- A. `class public Vehicle { }`  
- B. `public class vehicle { }`  
- C. `Public class Vehicle { }`  
- D. `public class Vehicle { }`  （✓ 正確）
- E. `classVehicle public { }`   

**答：D。**

**解析：**

**Explanation:**

- **A)** `class public Vehicle { }`
  - This option is incorrect because the syntax is wrong. The correct order is the access modifier followed by the `class` keyword, and then the class name.

- **B)** `public class vehicle { }`
  - This option is incorrect mainly due to the class naming convention. In Java, class names should start with an uppercase letter, so `vehicle` should be `Vehicle`.

- **C)** `Public class Vehicle { }`
  - This option is incorrect because `Public` is incorrectly capitalized. Java is case-sensitive, and the correct keyword is `public`.

- **D)** `public class Vehicle { }`
  - This is the correct answer. The syntax follows the proper order: the access modifier (`public`), followed by the `class` keyword, and then the class name (`Vehicle`), which correctly starts with an uppercase letter as per Java naming conventions.

- **E)** `classVehicle public { }`
  - This option is incorrect due to several reasons: the syntax order is wrong, there is no space between `class` and the class name, and the access modifier's position is incorrect.

---
### Q007　Utilizing Java Object-Oriented Approach - Part 1

Consider the following code snippet:

**選項：**
```java
public class Counter {
    public static int COUNT = 0;
    public Counter() {
        COUNT++;
    }
    public static void resetCount() {
        COUNT = 0;
    }
    public int getCount() {
        return COUNT;
    }
}
```
Which of the following statements are true about `static` and instance members within the `Counter` class? (Choose all that apply.)
- A. The `COUNT` variable can be accessed directly using the class name without creating an instance of `Counter`.  （✓ 正確）
- B. The `getCount()` method is an example of a static method because it returns the value of a static variable.  
- C. Every time a new instance of `Counter` is created, the `COUNT` variable is incremented.  （✓ 正確）
- D. The `resetCount()` method resets the `COUNT` variable to 0 for all instances of `Counter`.    （✓ 正確）

**答：A、C、D。**

**解析：**

**Explanation:**

- **A)** The `COUNT` variable can be accessed directly using the class name without creating an instance of `Counter`.
  - This option is correct. Static variables belong to the class and can be accessed directly with the class name, such as `Counter.COUNT`, without needing to instantiate the class.

- **B)** The `getCount()` method is an example of a static method because it returns the value of a static variable.
  - This option is incorrect. Although `getCount()` returns a static variable's value, it is not defined as a static method. Static methods are declared using the `static` modifier. The method's instance or non-static nature does not change based on the variables it accesses or returns.

- **C)** Every time a new instance of `Counter` is created, the `COUNT` variable is incremented.
  - This option is correct. The constructor increments the `COUNT` variable by 1 each time a new instance of `Counter` is created, demonstrating the shared nature of static variables across all instances.

- **D)** The `resetCount()` method resets the `COUNT` variable to 0 for all instances of `Counter`.
  - This option is correct. The `resetCount()` static method sets the `COUNT` variable to zero. Since `COUNT` is static, this change affects all instances of the class, as there is only one `COUNT` variable shared among them.

---
### Q008　Utilizing Java Object-Oriented Approach - Part 1

Which of the following are valid field name identifiers in Java? (Choose all that apply.)

**選項：**
- A. `int _age;`  （✓ 正確）
- B. `double 2ndValue;`  
- C. `boolean is_valid;`  （✓ 正確）
- D. `String $name;`  （✓ 正確）
- E. `char #char;`   

**答：A、C、D。**

**解析：**

**Explanation:**

- **A)** `int _age;` is correct. Identifiers in Java can begin with a letter, an underscore (_), or a dollar sign ($). Therefore, `_age` is a valid identifier.

- **B)** `double 2ndValue;` is incorrect. Identifiers cannot start with a digit. The correct format would be to start with a letter or a non-digit character such as an underscore or a dollar sign.

- **C)** `boolean is_valid;` is correct. Similar to `_age`, `is_valid` is a valid identifier because it starts with a letter and can contain underscores.

- **D)** `String $name;` is correct. Identifiers can also start with a dollar sign ($), making `$name` a valid identifier.

- **E)** `char #char;` is incorrect. The hash (#) character is not allowed as a starting character in identifiers. Identifiers can only start with letters, `$`, or `_`.

---
### Q009　Utilizing Java Object-Oriented Approach - Part 1

Consider the syntax used to declare methods in a class. Which of the following method declarations is correct according to Java syntax rules?

**選項：**
- A. `int public static final computeSum(int num1, int num2) { return num1 + num2 }`  
- B. `private void updateRecord(int id) throws IOException {}`  （✓ 正確）
- C. `synchronized boolean checkStatus [int status] { return status == 1; }`  
- D. `float calculateArea() {}`   

**答：B。**

**解析：**

**Explanation:**

- **A)** `int public static final computeSum(int num1, int num2)  { return num1 + num2 }` is incorrect because the return type in method declarations goes right before the name of the method, not at the beginning.

- **B)** `private void updateRecord(int id) throws IOException {}` is correct. This method declaration is syntactically correct in Java. It uses the `private` access modifier, specifies a return type (`void`), includes an exception (`IOException`) that this method might throw, and correctly defines the parameter list.

- **C)** `synchronized boolean checkStatus [int status] { return status == 1; }` Correct syntax requires parentheses for the parameter list, even when there are no parameters, making the correct declaration `synchronized boolean checkStatus(int status)`.

- **D)** `float calculateArea() {}` is incorrect because a method that returns `float` cannot have an empty method body.

---
### Q010　Utilizing Java Object-Oriented Approach - Part 1

Given the method declarations below, which of them have the same method signature?

**選項：**
- A. `public void update(int id, String value)`  （✓ 正確）
- B. `private void update(int identifier, String data)`  （✓ 正確）
- C. `public boolean update(String value, int id)`  （✓ 正確）
- D. `void update(String value, int id)`  （✓ 正確）
- E. `protected void update(int id, int value) throws IOException`   

**答：A、B、C、D。**

**解析：**

**Explanation:**

In Java, a method signature consists of the method name and the parameter list. The return type, access modifier, and exception list are not considered part of the method signature.

- **A)** (`public void update(int id, String value)`) 
- **B)** (`private void update(int identifier, String data)`) 
  - The above options have the same method signature (`update(int, String)`) because they both have the same method name and parameter list (an `int` and a `String`, in that order). The difference in parameter names (`id` vs. `identifier` and `value` vs. `data`) does not affect the method signature.

- **C)** `public boolean update(String value, int id)` 
- **D)** `void update(String value, int id)`
  - This option has the same method signature (`update(String, int)`) as C because they both have the same method name and parameter list (a `String` and an `int`, in that order). The different access modifier and return type does not affect the method signature.

- **E)** `protected void update(int id, int value) throws IOException`
  - This option also has a different parameter list (`update(int, int)`).

---
### Q011　Utilizing Java Object-Oriented Approach - Part 1

Given this class:

**選項：**
```java
public class AccountManager {
    private void resetAccountPassword(String accountId) {
        // Implementation code here
    }
    void auditTrail(String accountId) {
        // Implementation code here
    }
    protected void notifyAccountChanges(String accountId) {
        // Implementation code here
    }
    public void updateAccountInformation(String accountId) {
        // Implementation code here
    }
}
```
Which of the following statements correctly describe the accessibility of the methods within the `AccountManager` class from a class in the same package and from a class in a different package?
- A. The `resetAccountPassword` method can be accessed from any class within the same package but not from a class in a different package.  
- B. The `auditTrail` method can be accessed from any class within the same package and from subclasses in different packages.  
- C. The `notifyAccountChanges` method can be accessed from any class within the same package and from subclasses in different packages.  （✓ 正確）
- D. The `updateAccountInformation` method can be accessed from any class, regardless of its package.   （✓ 正確）

**答：C、D。**

**解析：**

**Explanation:**

- **A)** The `resetAccountPassword` method can be accessed from any class within the same package but not from a class in a different package.
  - This option is incorrect. The `resetAccountPassword` method has `private` access, which means it is accessible only within the `AccountManager` class itself, not from any class, even within the same package. The initial statement was slightly incorrect in suggesting package-level access for a `private` method.

- **B)** The `auditTrail` method can be accessed from any class within the same package and from subclasses in different packages.
  - This option is incorrect because the `auditTrail` method has package-private access (no access modifier), which means it is accessible from any class within the same package but not from subclasses in different packages unless they are also within the same package.

- **C)** The `notifyAccountChanges` method can be accessed from any class within the same package and from subclasses in different packages.
  - This option is correct. The `notifyAccountChanges` method has `protected` access, meaning it can be accessed within the same package and by subclasses, even if the subclasses are in different packages.

- **D)** The `updateAccountInformation` method can be accessed from any class, regardless of its package.
  - This option is correct. The `updateAccountInformation` method is `public`, so it can be accessed from any class, regardless of the package it belongs to.

---
### Q012　Utilizing Java Object-Oriented Approach - Part 1

What will be the output of this program?

**選項：**
```java
public class TestPassByValue {
    public static void main(String[] args) {
        int originalValue = 10;
        TestPassByValue test = new TestPassByValue();
        System.out.println("Before calling changeValue: " + originalValue);
        test.changeValue(originalValue);
        System.out.println("After calling changeValue: " + originalValue);
    }
    public void changeValue(int value) {
        value = 20;
    }
}
```
- A.  ``` Before calling changeValue: 10 After calling changeValue: 20 ``` 
- B.  ``` Before calling changeValue: 10 After calling changeValue: 10 ``` （✓ 正確）
- C.  ``` Before calling changeValue: 20 After calling changeValue: 20 ``` 
- D.  ``` Before calling changeValue: 20 After calling changeValue: 10 ```  

**答：B。**

**解析：**

**Explanation:**

Java is strictly pass-by-value. This means that when passing a variable to a method, Java passes a copy of the variable's value, not the variable itself. Changes to the parameter inside the method do not affect the original variable.

- **A)** 
```
Before calling changeValue: 10  
After calling changeValue: 20  
 ```
  - This option is incorrect because, although the `changeValue` method changes the `value` parameter to 20, this change does not affect the original variable `originalValue` outside the method. The change to `value` is made on its copy, not on `originalValue` itself.

- **B)** 
```
Before calling changeValue: 10  
After calling changeValue: 10  
```
  - This is the correct answer. `originalValue` is passed by value to the `changeValue` method. Thus, modifications to `value` inside `changeValue` do not affect `originalValue`. The output confirms that `originalValue` remains unchanged after the method call.

- **C)**
```
Before calling changeValue: 20  
After calling changeValue: 20  
```
- **D)** 
```
Before calling changeValue: 20  
After calling changeValue: 10  
```
  - These options are incorrect as they suggest changes to the method parameters can affect the original variables, which is not how Java's pass-by-value semantics work.

---
### Q013　Utilizing Java Object-Oriented Approach - Part 1

What will be the output of the following program?

**選項：**
```java
public class Test {
    public static void main(String[] args) {
        print(null);
    }
    public static void print(Object o) {
        System.out.println("Object");
    }
    public static void print(String s) {
        System.out.println("String");
    }
}
```
- A. `Object`  
- B. `String`  （✓ 正確）
- C. Compilation fails  
- D. A runtime exception is thrown     

**答：B。**

**解析：**

**Explanation:**

- **A)** `Object`
  - This option is incorrect because Java uses the most specific method that is applicable to the parameters. In this case, `String` is more specific than `Object`, so the `print(String s)` method is called.

- **B)** `String`
  - This option is correct. Even though `null` can be assigned to any reference type, Java prefers the most specific method applicable to the method parameters. Since `String` is a more specific type than `Object`, the `print(String s)` method is chosen over the `print(Object o)` method.

- **C)** Compilation fails
  - Compilation does not fail because both `print` methods are correctly defined and can potentially match the call `print(null)`. Java's method overloading mechanism allows this to compile without any issues.

- **D)** A runtime exception is thrown
  - No runtime exception is thrown because the method call to `print` successfully resolves to the `print(String s)` method at compile time. Since the method is correctly invoked, and there is no other code that could cause a runtime exception, this program runs successfully.

---
### Q014　Utilizing Java Object-Oriented Approach - Part 1

Which of the following method declarations correctly uses varargs? Choose all that apply.

**選項：**
- A. `public void print(String... messages, int count)`  
- B. `public void print(int count, String... messages)`  （✓ 正確）
- C. `public void print(String messages...)`  
- D. `public void print(String[]... messages)`  （✓ 正確）
- E. `public void print(String... messages, String lastMessage)`      

**答：B、D。**

**解析：**

**Explanation:**

- **A)** `public void print(String... messages, int count)`
  - This option is incorrect because varargs (variable arguments) must be the last parameter in a method's parameter list. Having `int count` after `String... messages` violates this rule.

- **B)** `public void print(int count, String... messages)`
  - This option is correct. It correctly places the varargs parameter `String... messages` at the end of the method's parameter list, which is the required syntax for using varargs.

- **C)** `public void print(String messages...)`
  - This option is incorrect because the syntax `String messages...` is invalid. The correct syntax for varargs is to place the ellipsis (`...`) after the type and before the variable name, like `String... messages`.

- **D)** `public void print(String[]... messages)`
  - This option is correct. It demonstrates the use of varargs with an array type, which is allowed. Here, each argument passed to `messages` can itself be an array of `String`, and `messages` will be treated as an array of arrays (`String[][]`).

- **E)** `public void print(String... messages, String lastMessage)`
  - This option is incorrect, similar to option A, because varargs must be the last parameter in the method's parameter list. Having another parameter after the varargs parameter is not allowed.

---
### Q015　Utilizing Java Object-Oriented Approach - Part 1

Given the class `Vehicle`:

**選項：**
```java
public class Vehicle {
    private String type;
    private int maxSpeed;
    public Vehicle(String type) {
        this.type = type;
    }
    public Vehicle(int maxSpeed) {
        this.maxSpeed = maxSpeed;
    }
    // Additional methods here
}
```
Which of the following statements is true regarding its constructors?
- A. The class `Vehicle` demonstrates constructor overloading by having multiple constructors with different parameter lists.  （✓ 正確）
- B. The class `Vehicle` will compile with an error because it does not provide a default constructor.  
- C. It is possible to create an instance of `Vehicle` with both `type` and `maxSpeed` set to specific values through a single constructor call. 
- D. Calling either constructor will initialize both `type` and `maxSpeed` fields of the `Vehicle` class.   

**答：A。**

**解析：**

**Explanation:**

- **A)** The class `Vehicle` demonstrates constructor overloading by having multiple constructors with different parameter lists.
  - This option is correct. Constructor overloading in Java is a technique of having more than one constructor with different parameter lists in the same class. It allows objects of the class to be initialized in different ways. The `Vehicle` class has two constructors, one that takes a `String` (for the vehicle type) and another that takes an `int` (for the max speed), which is a perfect example of constructor overloading.

- **B)** The class `Vehicle` will compile with an error because it does not provide a default constructor.
  - This option is incorrect. Java does not require an explicit default constructor if the class provides any other constructors. The absence of a default constructor (one that takes no arguments) is not a compilation error; it simply means that the programmer cannot instantiate the class using a no-argument constructor unless it's explicitly defined.

- **C)** It is possible to create an instance of `Vehicle` with both `type` and `maxSpeed` set to specific values through a single constructor call.
  - This option is incorrect because none of the existing constructors accept both a `String` and an `int` parameter. Each constructor only sets one field to a caller-specified value; the other field retains its default value (`null` or `0`).

- **D)** Calling either constructor will initialize both `type` and `maxSpeed` fields of the `Vehicle` class.
  - This option is incorrect. Calling either constructor only initializes the parameter that is provided to it. The first constructor initializes the `type`, and the second initializes the `maxSpeed`. Without additional code, such as a constructor that accepts both parameters or setter methods, there's no way for either constructor alone to initialize both fields.

---
### Q016　Utilizing Java Object-Oriented Approach - Part 1

Consider the following class with an instance initializer block:

**選項：**
```java
public class Library {
    private int bookCount;
    private List<String> books;
    {
        books = new ArrayList<>();
        books.add("Book 1");
        books.add("Book 2");
        // Instance initializer block
    }
    public Library(int bookCount) {
        this.bookCount = bookCount + books.size();
    }
    public int getBookCount() {
        return bookCount;
    }
    // Additional methods here
}
```
Given the `Library` class above, which of the following statements accurately describe the role and effect of the instance initializer block?
- A. The instance initializer block is executed before the constructor, initializing the `books` list and adding two books to it.  （✓ 正確）
- B. The instance initializer block replaces the need for a constructor in the `Library` class.  
- C. Instance initializer blocks cannot initialize instance variables like `books`.  
- D. If multiple instances of `Library` are created, the instance initializer block will execute each time before the constructor, ensuring the `books` list is initialized and populated for each object.   （✓ 正確）

**答：A、D。**

**解析：**

**Explanation:**

- **A)** The instance initializer block is executed before the constructor, initializing the `books` list and adding two books to it.
  - This option is correct. The instance initializer block is executed each time an instance of the class is created, before the constructor code runs. It initializes the `books` list and adds two books to it.

- **B)** The instance initializer block replaces the need for a constructor in the `Library` class.
  - This option is incorrect. The instance initializer block does not replace the need for a constructor. It is used in addition to constructors, often to initialize common parts of various constructors in a class.

- **C)** Instance initializer blocks cannot initialize instance variables like `books`. 
  - This option is incorrect. Instance initializer blocks can indeed initialize instance variables. In this case, the `books` list is an instance variable that is being initialized and populated within the instance initializer block.

- **D)** If multiple instances of `Library` are created, the instance initializer block will execute each time before the constructor, ensuring the `books` list is initialized and populated for each object.
  - This option is correct. For each new instance of the `Library` class, the instance initializer block runs before the constructor is invoked. This ensures that the `books` list is initialized and populated with `"Book 1"` and `"Book 2"` for every `Library` object created.

---
### Q017　Utilizing Java Object-Oriented Approach - Part 1

Consider the following Java class with a `static` initializer block:

**選項：**
```java
public class Configuration {
    private static Map<String, String> settings;
    static {
        settings = new HashMap<>();
        settings.put("url", "https://eherrera.net");
        settings.put("timeout", "30");
        // Static initializer block
    }
    public static String getSetting(String key) {
        return settings.get(key);
    }
    // Additional methods here
}
```
Given the `Configuration` class above, which of the following statements accurately describe the role and effect of the `static` initializer block?
- A. The `static` initializer block is executed only once when the class is first loaded into memory, initializing the `settings` map with default values.  （✓ 正確）
- B. The `static` initializer block allows instance methods to modify the `settings` map without creating an instance of the `Configuration` class.  
- C. `static` initializer blocks are executed each time a new instance of the `Configuration` class is created.  
- D. The `static` initializer block is executed before any instance initializer blocks or constructors, when an instance of the class is created.   

**答：A。**

**解析：**

**Explanation:**

- **A)** The `static` initializer block is executed only once when the class is first loaded into memory, initializing the `settings` map with default values.
  - This option is correct. Static initializer blocks are executed a single time, when the class is first loaded into the JVM memory. In this case, it initializes the `settings` map with default configuration values.

- **B)** The `static` initializer block allows instance methods to modify the `settings` map without creating an instance of the `Configuration` class.
  - This option is misleading. While static methods like `getSetting` can access and modify static fields like `settings` without needing an instance of the class, this capability is not due to the static initializer block itself but rather the nature of static fields and methods.

- **C)** `static` initializer blocks are executed each time a new instance of the `Configuration` class is created.
  - This option is incorrect. Static initializer blocks are not executed each time a new instance of the class is created. They are executed only once: when the class is first loaded.

- **D)** The `static` initializer block is executed before any instance initializer blocks or constructors, when an instance of the class is created.
  - This statement is partially correct in that static initializer blocks are executed before any instance initializer blocks or constructors, but it's misleading as it implies a sequence with instance creation. The key point is that static initializer blocks run once upon class loading, irrespective of the creation of any instances.

---
### Q018　Utilizing Java Object-Oriented Approach - Part 1

Consider the following class definition:

**選項：**
```java
public class InitializationOrder {
    static {
        System.out.println("1. Static initializer");
    }
    private static int staticValue = initializeStaticValue();
    private int instanceValue = initializeInstanceValue();
    {
        System.out.println("3. Instance initializer");
    }
    public InitializationOrder() {
        System.out.println("4. Constructor");
    }
    private static int initializeStaticValue() {
        System.out.println("2. Static value initializer");
        return 0;
    }
    private int initializeInstanceValue() {
        System.out.println("3. Instance value initializer");
        return 0;
    }
    public static void main(String[] args) {
        new InitializationOrder();
    }
}
```
When the `main` method of the `InitializationOrder` class is executed, what is the correct order of execution for the initialization blocks, method calls, and constructor?
- A.  ``` 1. Static initializer 2. Static value initializer 3. Instance initializer 3. Instance value initializer 4. Constructor ``` 
- B.  ``` 1. Static initializer 2. Static value initializer 3. Instance value initializer 3. Instance initializer 4. Constructor ``` （✓ 正確）
- C.  ``` 1. Static initializer 3. Instance initializer 2. Static value initializer 3. Instance value initializer 4. Constructor ``` 
- D.  ``` 2. Static value initializer 1. Static initializer 3. Instance value initializer 3. Instance initializer 4. Constructor ```  

**答：B。**

**解析：**

**Explanation:**

In Java, the order of initialization when a class is loaded and an instance of that class is created is as follows:

1. **Static fields and static initializers** are processed in the order they appear in the class definition. First, the static initializer block prints `"1. Static initializer"`. Then, the static field `staticValue` is initialized by calling `initializeStaticValue()`, which prints `"2. Static value initializer".`

2. **Instance fields and instance initializers** are processed in the order they appear when an instance of the class is created. First, the instance field `instanceValue` is initialized by calling `initializeInstanceValue()`, which prints `"3. Instance value initializer"`. Then, the instance initializer block prints `"3. Instance initializer"`.

3. **Constructors** are executed after all fields and instance initializers have been processed. The constructor in this case prints `"4. Constructor"`.

The numbering of the output for `"3. Instance initializer"` and `"3. Instance value initializer"` in the question might seem to suggest they are executed simultaneously or out of order, but it's important to remember that instance fields and instance initializers execute in the order they appear in the class, before the constructor is executed. The duplicate numbering means that instance field initializers run first, followed by instance initializers, and finally, the constructor runs.

- **A)**
```
1. Static initializer
2. Static value initializer
3. Instance initializer
3. Instance value initializer
4. Constructor 
```
  - This option is incorrect.

- **B)** 
```
1. Static initializer
2. Static value initializer
3. Instance value initializer
3. Instance initializer
4. Constructor
```
  - This option is correct.

- **C)** 
```
1. Static initializer
3. Instance initializer
2. Static value initializer
3. Instance value initializer
4. Constructor
``` 
  - This option is incorrect. 

- **D)** 
```
2. Static value initializer
1. Static initializer
3. Instance value initializer
3. Instance initializer
4. Constructor 
```
  - This option is incorrect.

---
### Q019　Utilizing Java Object-Oriented Approach - Part 1

Consider a class `CustomObject` that does not explicitly override any methods from `java.lang.Object`:

**選項：**
```java
public class CustomObject {
    // Class implementation goes here
}
```
Which of the following statements correctly reflect the outcomes when methods from `java.lang.Object` are used with instances of `CustomObject`? (Choose all that apply.)
- A. Invoking `toString()` on an instance of `CustomObject` will return a `String` that includes the class name followed by the `@` symbol and the object's hashcode.  （✓ 正確）
- B. Calling `equals(Object obj)` on two different instances of `CustomObject` that have identical content will return `true` because they are instances of the same class.  
- C. Using `hashCode()` on any instance of `CustomObject` will generate a unique integer that remains consistent across multiple invocations within the same execution of a program.  （✓ 正確）
- D. The `clone()` method can be used to create a shallow copy of an instance of `CustomObject` without the need for `CustomObject` to implement the `Cloneable` interface.     

**答：A、C。**

**解析：**

**Explanation:**

- **A)** Invoking `toString()` on an instance of `CustomObject` will return a `String` that includes the class name followed by the `@` symbol and the object's hashcode.
  - This option is correct. The `toString()` method in `java.lang.Object` returns a string that includes the class name, the `@` symbol, and the object's hashcode in hexadecimal. If `CustomObject` does not override `toString()`, this default format is used.

- **B)** Calling `equals(Object obj)` on two different instances of `CustomObject` that have identical content will return `true` because they are instances of the same class. 
  - This option is incorrect. The default implementation of `equals(Object obj)` in `java.lang.Object` checks for reference equality, meaning it returns `true` only if both references point to the exact same object. Without overriding `equals`, two different instances of `CustomObject`, even with identical content, would not be considered equal.

- **C)** Using `hashCode()` on any instance of `CustomObject` will generate a unique integer that remains consistent across multiple invocations within the same execution of a program.  
  - This option is correct. The `hashCode()` method is designed to return an integer representation of the object's memory address or a value derived from it. While the exact implementation is not specified and can vary, it is consistent during the execution of a program for any given object.

- **D)** The `clone()` method can be used to create a shallow copy of an instance of `CustomObject` without the need for `CustomObject` to implement the `Cloneable` interface. 
  - This option is incorrect. The `clone()` method in `java.lang.Object` is protected, and it throws a `CloneNotSupportedException` unless the class implements the `Cloneable` interface. Without `CustomObject` explicitly implementing `Cloneable` and overriding `clone()` to make it `public`, it cannot be used to clone instances of `CustomObject`.

---
### Q020　Utilizing Java Object-Oriented Approach - Part 1

Consider the code snippet below that demonstrates the use of a static nested class:

**選項：**
```java
public class OuterClass {
    private static String message = "Hello, World!";
    static class NestedClass {
        void printMessage() {
            // Note: A static nested class can access the static members of its outer class.
            System.out.println(message);
        }
    }
    public static void main(String[] args) {
        OuterClass.NestedClass nested = new OuterClass.NestedClass();
        nested.printMessage();
    }
}
```
Which of the following statements is true regarding static nested classes in Java?
- A. A static nested class can access both static and non-static members of its enclosing class directly.  
- B. Instances of a static nested class can exist without an instance of its enclosing class.  （✓ 正確）
- C. A static nested class can only be instantiated within the static method of its enclosing class.  
- D. Static nested classes are not considered members of their enclosing class and cannot access any members of the enclosing class.   

**答：B。**

**解析：**

**Explanation:**

- **A)** A static nested class can access both static and non-static members of its enclosing class directly. 
  - This option is incorrect because a static nested class cannot directly access non-static members of its enclosing class. It can only access static members directly.

- **B)** Instances of a static nested class can exist without an instance of its enclosing class.
  - This is the correct answer. A static nested class is associated with its outer class, and unlike inner classes, it does not need an instance of the outer class to be instantiated. This makes it useful for grouping classes that will be used in a static context.

- **C)** A static nested class can only be instantiated within the static method of its enclosing class.
  - This option is incorrect. A static nested class can be instantiated from any context (static or non-static) as long as it is accessible (i.e., visibility allows it).

- **D)** Static nested classes are not considered members of their enclosing class and cannot access any members of the enclosing class.
  - This option is incorrect. Static nested classes are indeed considered members of their enclosing class and can access its static members and static methods. However, they do not have access to non-static members of the enclosing class unless they instantiate the enclosing class.

---
### Q021　Utilizing Java Object-Oriented Approach - Part 1

Consider the following code snippet that demonstrates the use of a non-static nested (inner) class:

**選項：**
```java
public class OuterClass {
    private String message = "Hello, World!";
    class InnerClass {
        void printMessage() {
            System.out.println(message);
        }
    }
    public static void main(String[] args) {
        OuterClass outer = new OuterClass();
        OuterClass.InnerClass inner = outer.new InnerClass();
        inner.printMessage();
    }
}
```
Which of the following statements is true regarding non-static nested (inner) classes in Java?
- A. A non-static nested class can directly access both static and non-static members of its enclosing class.  （✓ 正確）
- B. Instances of a non-static nested class can exist independently of an instance of its enclosing class.  
- C. A non-static nested class cannot access the non-static members of its enclosing class directly.  
- D. Non-static nested classes must be declared static to access the static members of their enclosing class.   

**答：A。**

**解析：**

**Explanation:**

- **A)** A non-static nested class can directly access both static and non-static members of its enclosing clas
  - This option is correct. A non-static nested class, or inner class, has access to all members (including both static and non-static) of its enclosing class, as demonstrated in the code snippet where `InnerClass` accesses the non-static `message` field of `OuterClass`.

- **B)** Instances of a non-static nested class can exist independently of an instance of its enclosing class. 
  - This option is incorrect. Instances of a non-static nested class (inner class) are implicitly associated with an instance of the enclosing class. Therefore, they cannot exist independently of an instance of the enclosing class. In the provided code snippet, the `InnerClass` instance is created through an instance of `OuterClass`.

- **C)** A non-static nested class cannot access the non-static members of its enclosing class directly.
  - This option is incorrect. As stated above, an inner class can directly access both static and non-static members of its enclosing class.

- **D)** Non-static nested classes must be declared static to access the static members of their enclosing class.
  - This option is incorrect. Non-static nested classes (inner classes) are designed to access members of their enclosing class directly without needing to be declared static. Declaring a nested class as static changes its type to a static nested class, which has different access properties from an inner class.

---
### Q022　Utilizing Java Object-Oriented Approach - Part 1

Consider the following code snippet demonstrating the use of a local class within a method:

**選項：**
```java
public class LocalClassExample {
    public void printEvenNumbers(int[] numbers, int max) {
        class EvenNumberPrinter {
            public void print() {
                for (int number : numbers) {
                    if (number % 2 == 0 && number <= max) {
                        System.out.println(number);
                    }
                }
            }
        }
        EvenNumberPrinter printer = new EvenNumberPrinter();
        printer.print();
    }
    public static void main(String[] args) {
        LocalClassExample example = new LocalClassExample();
        int[] numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        example.printEvenNumbers(numbers, 6);
    }
}
```
Which of the following statements correctly describe local classes in Java, based on the example provided?
- A. Local classes can be declared within any block that precedes a statement.  （✓ 正確）
- B. Instances of a local class can be created and used outside of the block where the local class is defined.  
- C. Local classes are a type of static nested class and can access both static and non-static members of the enclosing class directly.  
- D. Local classes can access local variables and parameters of the enclosing block only if they are declared `final` or effectively final.    （✓ 正確）

**答：A、D。**

**解析：**

**Explanation:**

- **A)** Local classes can be declared within any block that precedes a statement.
  - This option is correct. Local classes in Java can indeed be declared within any block that precedes a statement, such as a method body, a `for` loop, or an `if` statement.

- **B)** Instances of a local class can be created and used outside of the block where the local class is defined.
  - This option is incorrect. Instances of local classes cannot be created and used outside the block where they are defined. Their scope is limited to the block in which they are declared.

- **C)** Local classes are a type of static nested class and can access both static and non-static members of the enclosing class directly.
  - This option is incorrect. Local classes are not static; they are associated with an instance of the enclosing class and have access to its instance members. They do not have the static context that static nested classes have, and thus they can access both static and non-static members of the enclosing class.

- **D)** Local classes can access local variables and parameters of the enclosing block only if they are declared `final` or effectively final.
  - This is correct. Local classes can access local variables and parameters of the method (or any enclosing block) in which they are defined, but those variables must be declared `final` or effectively final (which means their values do not change after they are initialized).

---
### Q023　Utilizing Java Object-Oriented Approach - Part 1

Consider the following Java code snippet demonstrating the use of an anonymous class:

**選項：**
```java
public class HelloWorld {
    interface HelloWorldInterface {
        void greet();
    }
    public void sayHello() {
        HelloWorldInterface myGreeting = new HelloWorldInterface() {
            @Override
            public void greet() {
                System.out.println("Hello, world!");
            }
        };
        myGreeting.greet();
    }
    public static void main(String[] args) {
        new HelloWorld().sayHello();
    }
}
```
Which of the following statements is true about anonymous classes in Java?
- A. Anonymous classes can implement interfaces and extend classes without the need to declare a named class.  （✓ 正確）
- B. An anonymous class must override all methods in the superclass or interface it declares it is implementing or extending.  
- C. Anonymous classes can have constructors as named classes do.  
- D. Instances of anonymous classes cannot be passed as arguments to methods.  

**答：A。**

**解析：**

**Explanation:**

- **A)** Anonymous classes can implement interfaces and extend classes without the need to declare a named class.
  - This option is correct. Anonymous classes are a way to extend existing classes or implement interfaces on the spot without the need for a formal class declaration. This makes them useful for creating quick, one-off implementations.

- **B)** An anonymous class must override all methods in the superclass or interface it declares it is implementing or extending.
  - This option is incorrect. An anonymous class only needs to override abstract methods of the superclass or interface it extends or implements. If the superclass or interface has no abstract methods, then the anonymous class does not need to override any methods.

- **C)** Anonymous classes can have constructors as named classes do.
  - This option is incorrect. Anonymous classes do not have named constructors because they do not have names themselves. Instead, any initialization is done through an instance initializer block.

- **D)** Instances of anonymous classes cannot be passed as arguments to methods.
  - This option is incorrect. Instances of anonymous classes can indeed be passed as arguments to methods. They are useful for creating on-the-fly implementations for interfaces or subclasses that are required for a method call.

---
### Q024　Utilizing Java Object-Oriented Approach - Part 1

Which of the following statements accurately reflects a valid rule regarding how classes and source files are organized?

**選項：**
- A. A source file can contain multiple public classes.  
- B. Private classes can be declared at the top level in a source file.  
- C. A `public` class must be declared in a source file that has the same name as the class.  （✓ 正確）
- D. If a source file contains more than one class, none of the classes can be `public`.

**答：C。**

**解析：**

**Explanation:**

- **A)** A source file can contain multiple public classes.
  - This option is incorrect. A Java source file cannot contain more than one `public` class. If a class is declared `public`, it must be the only `public` class in the file, and the file name must match the class name.

- **B)** Private classes can be declared at the top level in a source file.
  - This option is incorrect. Java does not allow classes to be declared as `private` at the top level. Only `public`, or package-private (no access modifier) classes can be defined at the top level. Inner classes can be `private`.

- **C)** A `public` class must be declared in a source file that has the same name as the class.
  - This is correct. According to Java's rules, if a class is declared `public`, the source file in which it is defined must have the same name as the class, followed by the `.java` extension. This is a strict rule that helps the Java compiler easily locate source files.

- **D)** If a source file contains more than one class, none of the classes can be `public`.
  - This is incorrect. While it is true that if a source file contains a `public` class, the source file must be named after that `public` class, it is not true that none of the classes can be `public` if a source file contains more than one class. A source file can contain multiple classes, but only one of them can be `public`, and the source file must be named after that `public` class. The statement could imply that multiple non-public top-level classes are a common scenario without the context of the `public` class naming rule.

| 第 02 章 | Utilizing Java Object-Oriented Approach - Part 2 | 16 |
---
### Q025　Utilizing Java Object-Oriented Approach - Part 2

What is the result of compiling and executing the following code?

**選項：**
```java
void myMethod() {
    int x = 1;
    if (x > 0) { 
        int y = 2;
        System.out.println(x + y);
    }
    System.out.println(x);
    System.out.println(y);
}
```
- A. The code compiles and outputs `3` followed by `1`.  
- B. The code compiles and outputs `3` followed by `1` and an undefined value for `y`.  
- C. The code does not compile because `y` is accessed outside of its scope.  （✓ 正確）
- D. The code compiles but throws a runtime exception when trying to print `y`.  

**答：C。**

**解析：**

**Explanation:**

- **A)** The code compiles and outputs `3` followed by `1`.
  - This option is incorrect because, although the code prints `3` followed by `1` due to `x` being in scope, attempting to access `y` outside of its declaring block (the `if` block) will cause a compile-time error.

- **B)** The code compiles and outputs `3` followed by `1` and an undefined value for `y`.
  - This option is incorrect because Java does not allow access to local variables (`y` in this case) outside of their scope. The notion of an "undefined value for `y`" is not applicable here; the compiler will simply not compile the code.

- **C)** The code does not compile because `y` is accessed outside of its scope.
  - This is the correct option. Local variable `y` is declared inside the `if` block, and thus, it is only accessible within that block. Trying to access it outside of its scope, as done in the last `System.out.println(y);`, causes a compile-time error, specifically saying that `y` cannot be found.

- **D)** The code compiles but throws a runtime exception when trying to print `y`.
  - This option is incorrect because the issue with the code is at compile time, not runtime. The compiler will not allow the code to compile due to the scope violation of the local variable `y`, hence a runtime exception regarding `y` is out of the question.

---
### Q026　Utilizing Java Object-Oriented Approach - Part 2

Which of the following variable declarations statements are valid? (Choose all that apply.)

**選項：**
- A. `double x, double y;`  
- B. `int i = 0, String s = "hello";`  
- C. `float f1 = 3.14f, f2 = 6.28f;`  （✓ 正確）
- D. `char a = 'A', b, c = 'C';`    （✓ 正確）

**答：C、D。**

**解析：**

**Explanation:**

- **A)** `double x, double y;`
  - This option is incorrect because when declaring multiple variables of the same type in a single statement, you do not repeat the type before each variable. The correct syntax would be `double x, y;`.

- **B)** `int i = 0, String s = "hello";`
  - This option is incorrect for the same reason as A; you cannot declare variables of different types (`int` and `String` in this case) in a single statement. 

- **C)** `float f1 = 3.14, f2 = 6.28f;`
  - This is correct. You can declare multiple variables of the same type (`float` in this case) in a single statement, and it's also fine to initialize them with values in the same statement.

- **D)** `char a = 'A', b, c = 'C';`
  - This is correct. It's valid to declare multiple variables of the same type (`char` in this case), and initialize some, all, or none of them in the same statement.

---
### Q027　Utilizing Java Object-Oriented Approach - Part 2

Which of the following statements are true regarding the use of `var` in Java? (Choose all that apply.)

**選項：**
- A. `var` can be used to declare both local variables within methods and instance variables within classes.  
- B. The use of `var` is restricted to local variables within methods, constructors, or initializer blocks.  （✓ 正確）
- C. `var` can be used to declare method parameters.  
- D. `var` enhances readability by inferring types where it's clear from the context, but it's not allowed in method signatures to maintain clarity.  （✓ 正確）
- E. `var` can be used to declare class (static) variables.  

**答：B、D。**

**解析：**

**Explanation:**

- **A)** `var` can be used to declare both local variables within methods and instance variables within classes.
  - This option is incorrect because `var` cannot be used to declare instance variables. It is specifically restricted to local variables within methods, constructors, or initializer blocks, as using `var` for fields would reduce the clarity of a class's public API.

- **B)** The use of `var` is restricted to local variables within methods, constructors, or initializer blocks.
  - This option is correct. `var` is intended for local variable type inference, significantly reducing the verbosity of Java code in scenarios where the compiler can easily determine the type of the local variable from its initializer. Its use is restricted to ensure clarity and prevent ambiguity in more complex constructs like class fields or method parameters.

- **C)** `var` can be used to declare method parameters.
  - This option is incorrect. The example clearly demonstrates that `var` cannot be used to declare method parameters. This limitation ensures that method signatures remain explicit in their type requirements, a critical aspect of a class's contract with its callers.

- **D)** `var` enhances readability by inferring types where it's clear from the context, but it's not allowed in method signatures to maintain clarity.
  - This option is correct. While `var` is primarily used to improve code readability by reducing the need for explicit type declarations where the type can be inferred from the context, it is not allowed in method signatures. This restriction ensures that the types of parameters in methods are always explicitly defined, aiding in the readability and maintainability of public APIs.

- **E)** `var` can be used to declare class (static) variables.
  - This option is incorrect. Similar to instance variables, `var` is not permissible for declaring class (`static`) variables. The rationale behind this restriction aligns with the goal of maintaining explicit type declarations in the class's structure, ensuring the class's design remains clear and unambiguous to both the compiler and developers.

---
### Q028　Utilizing Java Object-Oriented Approach - Part 2

Which of the following statements correctly describe the use of inheritance in Java? (Choose all that apply.)

**選項：**
- A. Subclasses can directly access the `public` and `protected` members of their superclass, and package-private members when they are in the same package.  （✓ 正確）
- B. In Java, a class can extend multiple classes to achieve multiple inheritance.  
- C. The `extends` keyword is used in Java to create a subclass that inherits from a superclass.  （✓ 正確）
- D. A subclass in Java can directly access `private` members of its superclass.  

**答：A、C。**

**解析：**

**Explanation:**

- **A)** Subclasses can directly access the `public` and `protected` members of their superclass, and package-private members when they are in the same package.
  - This option is correct. A subclass can use the `public` and `protected` members of its superclass directly. Package-private members work too, but only when the subclass is in the same package. `private` members stay off-limits, so the superclass must expose them through accessors.

- **B)** In Java, a class can extend multiple classes to achieve multiple inheritance.
  - This option is incorrect. Java does not support multiple inheritance for classes. A class in Java can only extend one other class, preventing complications like the diamond problem and the complexity associated with multiple inheritance.

- **C)** The `extends` keyword is used in Java to create a subclass that inherits from a superclass.
  - This option is correct. `extends` creates a subclass that inherits the fields and methods of a single superclass, giving an is-a relationship between them.

- **D)** A subclass in Java can directly access `private` members of its superclass.
  - This option is incorrect. A subclass cannot directly access `private` members of its superclass. Instead, it can access them through `public` or `protected` accessors provided by the superclass. This encapsulation principle ensures a controlled interaction with the superclass's state.

---
### Q029　Utilizing Java Object-Oriented Approach - Part 2

Consider the following code snippet:

**選項：**
```java
abstract class Animal {
    abstract void eat();
}
class Dog extends Animal {
    void eat() {
        System.out.println("Dog eats");
    }
}
class Cat extends Animal {
    void eat() {
        System.out.println("Cat eats");
    }
}
public class Test {
    public static void main(String[] args) {
        Animal myAnimal = new Dog();
        myAnimal.eat();
    }
}
```
Which of the following statements is true regarding the above code? Choose all that apply.
- A. The code will compile and print `"Dog eats"` when executed.  （✓ 正確）
- B. The `Animal` class can be instantiated.  
- C. Removing the `eat` method from the `Dog` class will cause a compilation error.  （✓ 正確）
- D. The `Cat` class is necessary for the code to compile and run.  

**答：A、C。**

**解析：**

**Explanation:**

- **A)** The code will compile and print `"Dog eats"` when executed.
  - This option is correct. The `Dog` class has provided an implementation for the `eat` method, which is abstract in the superclass `Animal`. Since `myAnimal` is of type `Animal` but instantiated as a `Dog`, it will call the overridden `eat` method in the `Dog` class, printing `"Dog eats"`.

- **B)** The `Animal` class can be instantiated.
  - This option is incorrect. The `Animal` class is abstract and cannot be instantiated. Attempting to create an instance of `Animal` directly (`new Animal()`) would result in a compilation error.

- **C)** Removing the `eat` method from the `Dog` class will cause a compilation error.
  - This option is correct. Since `Dog` extends the abstract class `Animal` and `Animal` has an abstract `eat` method, `Dog` must provide an implementation for `eat`. Failing to do so will prevent the code from compiling because `Dog` would also be considered abstract.

- **D)** The `Cat` class is necessary for the code to compile and run.
  - This option is incorrect. The `Cat` class is not referenced in the `main` method or anywhere else in the provided code snippet. Thus, it is unnecessary for the compilation and execution of the given code segment.

---
### Q030　Utilizing Java Object-Oriented Approach - Part 2

Consider the following interfaces:

**選項：**
```java
interface Walkable {
    int distance = 10;
    void walk();
}
interface Runnable {
    void run();
    default void getSpeed() {
        System.out.println("Default speed");
    }
}
class Person implements Walkable, Runnable {
    public void walk() {
        System.out.println("Walking...");
    }
    public void run() {
        System.out.println("Running...");
    }
}
```
Which of the following statements is true?
- A. The `Person` class must override the `getSpeed` method.  
- B. The `distance` variable in the `Walkable` interface is implicitly `public`, `static`, and `final`.  （✓ 正確）
- C. A `Person` object can call the `getSpeed` method without any implementation in the `Person` class.  （✓ 正確）
- D. The `Runnable` interface causes a compilation error due to a naming conflict with `java.lang.Runnable`.  

**答：B、C。**

**解析：**

**Explanation:**

- **A)** The `Person` class must override the `getSpeed` method.
  - This option is incorrect. The `Person` class is not required to override the `getSpeed` method because it is a default method in the `Runnable` interface. Default methods provide an implementation that can be used or overridden by implementing classes, but overriding is not mandatory.

- **B)** The `distance` variable in the `Walkable` interface is implicitly `public`, `static`, and `final`. 
  - This option is correct. In Java, all variables declared in an interface are implicitly `public`, `static`, and `final`. This means the `distance` variable in the `Walkable` interface is a constant and must be initialized at the point of declaration. It is accessible with the interface name, like `Walkable.distance`.

- **C)** A `Person` object can call the `getSpeed` method without any implementation in the `Person` class.
  - This option is correct. Since the `Runnable` interface provides a default implementation for the `getSpeed` method, a `Person` object can call the `getSpeed` method without any additional implementation in the `Person` class itself. The default implementation from the interface will be used.

- **D)** The `Runnable` interface causes a compilation error due to a naming conflict with `java.lang.Runnable`.
  - This option is incorrect because Java fully supports namespace resolution. The `Runnable` interface declared in the code snippet and `java.lang.Runnable` exist in different packages. There is no compilation error unless there's an attempt to import both in the same file without using a fully qualified name. Plus, this situation does not directly relate to the functionality or declaration of interfaces per the exam's focus.

---
### Q031　Utilizing Java Object-Oriented Approach - Part 2

Consider the following code snippet related to sealed classes:

**選項：**
```java
sealed abstract class Shape permits Circle, Square {
    abstract double area();
}
final class Circle extends Shape {
    private final double radius;
    Circle(double radius) {
        this.radius = radius;
    }
    public double area() {
        return Math.PI * radius * radius;
    }
}
non-sealed class Square extends Shape {
    private final double side;
    Square(double side) {
        this.side = side;
    }
    public double area() {
        return side * side;
    }
}
public class TestShapes {
    public static void main(String[] args) {
        Shape shape = new Circle(10);
        System.out.println("Area: " + shape.area());
    }
}
```
Which of the following statements is true?
- A. The `Shape` class is correctly defined as a sealed class, allowing only specified classes to extend it.  （✓ 正確）
- B. The `Square` class does not correctly extend the `Shape` class because it is not marked as `final`.  
- C. The `Circle` class can be further extended by other classes.  
- D. The `area` method in the `Shape` class must provide a default implementation.  

**答：A。**

**解析：**

**Explanation:**

- **A)** The `Shape` class is correctly defined as a sealed class, allowing only specified classes to extend it.
  - This option is correct. The `Shape` class is declared as a sealed class, which means it can be extended only by the classes it explicitly permits through the `permits` clause. In this case, `Shape` permits `Circle` and `Square` to extend it, and both classes are correctly defined as permitted subclasses.

- **B)** The `Square` class does not correctly extend the `Shape` class because it is not marked as `final`. 
  - This option is incorrect. There's no requirement for classes extending a sealed class to be marked as `final` if they are non-sealed. The keyword `non-sealed` explicitly allows the `Square` class to extend the sealed `Shape` class without being final, indicating it can be further extended.

- **C)** The `Circle` class can be further extended by other classes. 
  - This option is incorrect. The `Circle` class is declared as `final`, which means it cannot be extended further and aligning with the constraints of extending a sealed class where the permitted subclass can be final, sealed, or non-sealed.

- **D)** The `area` method in the `Shape` class must provide a default implementation.
  - This option is incorrect. Abstract classes like `Shape` are not required to provide implementations for their abstract methods. The purpose of an abstract class is to define a template that its subclasses will follow, which includes implementing any abstract methods declared in the abstract class.

---
### Q032　Utilizing Java Object-Oriented Approach - Part 2

Consider the following class:

**選項：**
```java
public class Widget {
    private int size;
    public Widget() {
        this(10); // Line 5
    }
    public Widget(int size) {
        this.size = size;
    }
    public void resize(int size) {
        if (size > this.size) {
            this.size = size; // Line 14
            updateWidget();
        }
    }
    private void updateWidget() {
        System.out.println("Widget updated to size " + this.size);
    }
    public static void main(String[] args) {
        Widget widget = new Widget();
        widget.resize(15);
    }
}
```
In line 14, what does the `this` keyword represent in the context of the `Widget` class?
- A. A reference to the `static` context of the class, allowing access to static methods and fields.  
- B. A special variable that stores the return value of a method.  
- C. An optional keyword that can always be omitted without affecting the functionality of the code.  
- D. A reference to the current object, whose instance variable is being called.  （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** A reference to the `static` context of the class, allowing access to static methods and fields.
  - This option is incorrect. The `this` keyword does not refer to the static context of the class. It specifically refers to the current instance of the class. Static methods and fields belong to the class itself and are not part of any instance, so they cannot be accessed through `this`.

- **B)** A special variable that stores the return value of a method.
  - This option is incorrect. The `this` keyword does not store the return value of a method. It is used within an instance method or a constructor to refer to the current object the method or constructor is being invoked upon.

- **C)** An optional keyword that can always be omitted without affecting the functionality of the code.
  - This option is incorrect. While it is true that in some cases `this` can be omitted (for example, when accessing instance fields or methods without any naming conflict), its use is necessary for situations like constructor chaining (`this()` call) or when the method parameter names shadow the instance field names. In such scenarios, `this` clarifies to which variable the code is referring.

- **D)** A reference to the current object, whose instance variable is being called.
  - This option is correct. The `this` keyword in Java is used to refer to the current object?he object whose instance variable, method, or constructor is being called. You can see its usage in line 5 to call another constructor within the same class, in line 14 to differentiate between the method parameter `size` and the instance variable `size`, and in the `updateWidget` method to access the instance variable `size`. This usage demonstrates `this` as a way to refer explicitly to properties or methods of the current object.

---
### Q033　Utilizing Java Object-Oriented Approach - Part 2

Consider the following classes:

**選項：**
```java
class Animal {
    String name;
    Animal(String name) {
        this.name = name;
    }
    protected void eat() {
        System.out.println("Animal eats");
    }
}
class Dog extends Animal {
    Dog(String name) {
        super(name);
    }
    @Override
    protected void eat() {
        super.eat();
        System.out.println(name + " (Dog) eats");
    }
}
public class TestAnimal {
    public static void main(String[] args) {
        Animal myDog = new Dog("Buddy");
        myDog.eat();
    }
}
```
Which of the following statements are true regarding the use of `super` in the above code? (Choose all that apply.)
- A. The `super` keyword is used in the `Dog` constructor to call the superclass constructor.  （✓ 正確）
- B. The `eat` method in the `Dog` class uses `super` to invoke the superclass's `eat` method.  （✓ 正確）
- C. Removing the `super.eat();` call in the `Dog` class's `eat` method will prevent the `Dog` class from compiling.  
- D. The `super` keyword can be used inside a `static` method of the `Dog` class to access members of `Animal`.   

**答：A、B。**

**解析：**

**Explanation:**

- **A)** The `super` keyword is used in the `Dog` constructor to call the superclass constructor.
  - This option is correct. In the `Dog` constructor, `super(name);` is used to call the superclass (`Animal`) constructor with the `name` parameter. This is necessary to initialize the `name` field inherited from the `Animal` class in the `Dog` instance.

- **B)** The `eat` method in the `Dog` class uses `super` to invoke the superclass's `eat` method.
  - This option is correct. The `eat` method in the `Dog` class calls `super.eat();` to invoke the `eat` method defined in the superclass (`Animal`). This allows the `Dog` class to extend the functionality of the `eat` method beyond what is defined in the superclass, demonstrating method overriding and use of `super` to access the overridden method.

- **C)** Removing the `super.eat();` call in the `Dog` class's `eat` method will prevent the `Dog` class from compiling.
  - This option is incorrect. Removing the `super.eat();` call from the `Dog` class's `eat` method would not prevent the class from compiling. It would simply mean that the `Dog` class's `eat` method no longer calls the superclass's `eat` method, altering the program's behavior but not its compilability.

- **D)** The `super` keyword can be used inside a `static` method of the `Dog` class to access members of `Animal`.
  - This option is incorrect. `super` refers to the current instance viewed as the superclass type, so it may only appear where `this` is available. Inside a `static` method, a `static` initializer, or any other `static` context, there is no instance, and any use of `super` will result in a compile-time error.

---
### Q034　Utilizing Java Object-Oriented Approach - Part 2

Consider the following classes:

**選項：**
```java
class Vehicle {
    public void drive(int speed) {
        System.out.println("Vehicle driving at speed: " + speed);
    }
}
class Car extends Vehicle {
    @Override
    public void drive(long speed) {
        System.out.println("Car driving at speed: " + speed);
    }
}
public class TestDrive {
    public static void main(String[] args) {
        Vehicle myCar = new Car();
        myCar.drive(60);
    }
}
```
What is the result of compiling and executing the above code?
- A. It compiles and prints `"Car driving at speed: 60"`.  
- B. It does not compile because the `drive` method cannot be called using a `Vehicle` reference.  
- C. It does not compile because the `drive` method in the `Car` class does not properly override the `drive` method in the `Vehicle` class.  （✓ 正確）
- D. It compiles and prints `"Vehicle driving at speed: 60"` because the `drive` method in the `Car` class is an overload, not an override.  

**答：C。**

**解析：**

**Explanation:**

- **A)** It compiles and prints `"Car driving at speed: 60"`.
  - This option is incorrect because the `drive` method in the `Car` class has a different parameter type (`long`) than the method in the `Vehicle` class (`int`). Due to the difference in parameter types, the `Car` class's `drive` method does not override but rather overloads the `Vehicle` class's `drive` method. Since the method is called on a `Vehicle` reference, the `Vehicle` class's `drive` method is invoked.

- **B)** It does not compile because the `drive` method cannot be called using a `Vehicle` reference. 
  - This option is incorrect because `Vehicle` defines the `drive` method correctly.

- **C)** It does not compile because the `drive` method in the `Car` class does not properly override the `drive` method in the `Vehicle` class.
  - This option is correct. The `@Override` annotation explicitly tells the compiler that the annotated method is intended to override a method from a superclass. However, the `drive` method in the `Car` class has a parameter of type `long`, while the `drive` method in the `Vehicle` class has a parameter of type `int`. Since the parameter types differ, the `Car` method does not override the `Vehicle` method, it's an overload. The compiler enforces the `@Override` contract strictly, so it produces an error such as: `method does not override or implement a method from a supertype`. As a result, the code fails to compile.

- **D)** It compiles and prints `"Vehicle driving at speed: 60"` because the `drive` method in the `Car` class is an overload, not an override.
  - This option is incorrect. It correctly identifies that the `Car` method is an overload rather than an override, but it incorrectly concludes that the code compiles. The `@Override` annotation prevents compilation because the annotated method is not actually overriding anything (see option C). If the `@Override` annotation were removed, then this option would describe the correct behavior. But with the annotation present, the code does not compile.

---
### Q035　Utilizing Java Object-Oriented Approach - Part 2

Consider the following code snippet:

**選項：**
```java
class Fruit {
    public void flavor() {
        System.out.println("Fruit flavor");
    }
}
class Apple extends Fruit {
    @Override
    public void flavor() {
        System.out.println("Apple flavor");
    }
    public void color() {
        System.out.println("Red");
    }
}
public class TestFruit {
    public static void main(String[] args) {
        Fruit myFruit = new Apple();
        myFruit.flavor();
        // myFruit.color();
    }
}
```
If the commented line `// myFruit.color();` is uncommented, what will be the result of compiling and executing the above code?
- A. It compiles and prints `"Apple flavor"` followed by `"Red"`.  
- B. It compiles and prints `"Fruit flavor"`.  
- C. It compiles but throws a runtime exception when attempting to call `color()`.  
- D. It does not compile because `Apple` is not a valid type of `Fruit`.  
- E. It does not compile because the `color` method is not defined in the `Fruit` class.  （✓ 正確）

**答：E。**

**解析：**

**Explanation:**

- **A)** It compiles and prints `"Apple flavor"` followed by `"Red"`.
  - This option is incorrect because, while the `flavor` method will indeed print `"Apple flavor"` due to polymorphism (the `Apple` class overrides the `flavor` method of `Fruit`), the code will not compile if the `color()` method is called on a `Fruit` reference. This is because the `color` method is not part of the `Fruit` class's interface.

- **B)** It compiles and prints `"Fruit flavor"`.
  - This option is incorrect for a similar reason to A. The `flavor` method would print `"Apple flavor"` because of the overridden method in the `Apple` class, not `"Fruit flavor"`. However, the presence of the `color()` method call would still prevent compilation.

- **C)** It compiles but throws a runtime exception when attempting to call `color()`.
  - This option is incorrect because the issue occurs at compile time, not runtime. The Java compiler will not allow a method to be called on a reference type if that method is not defined in the reference type's class or its superclass hierarchy.

- **D)** It does not compile because `Apple` is not a valid type of `Fruit`.
  - This option is incorrect. `Apple` is a valid type of `Fruit` due to inheritance (`Apple extends Fruit`). This relationship allows an `Apple` object to be referenced by a `Fruit` variable.

- **E)** It does not compile because the `color` method is not defined in the `Fruit` class.
  - This option is correct. The `color` method is only defined in the `Apple` class and not in the `Fruit` class. Since the reference type of `myFruit` is `Fruit`, which does not have a `color` method, attempting to call `myFruit.color()` will result in a compilation error. This illustrates a key principle of polymorphism: the type of the reference (not the object) determines what methods can be called.

---
### Q036　Utilizing Java Object-Oriented Approach - Part 2

Consider the following code snippet:

**選項：**
```java
class Animal {}
class Dog extends Animal {
    public void bark() {
        System.out.println("Woof");
    }
}
class Cat extends Animal {
    public void meow() {
        System.out.println("Meow");
    }
}
public class TestCasting {
    public static void main(String[] args) {
        Animal animal = new Dog();
        ((Dog)animal).bark();
        Animal anotherAnimal = new Animal();
        // Line 1
    }
}
```
Which of the following lines of code, if inserted independently at Line 1, will compile without causing a runtime exception? (Choose all that apply.)
- A. `((Dog)anotherAnimal).bark();`  
- B. `if (anotherAnimal instanceof Dog) ((Dog)anotherAnimal).bark();`  （✓ 正確）
- C. `((Cat)animal).meow();`  
- D. `if (anotherAnimal instanceof Cat) ((Cat)anotherAnimal).meow();`  （✓ 正確）

**答：B、D。**

**解析：**

**Explanation:**

- **A)** `((Dog)anotherAnimal).bark();`
  - This option is incorrect because it tries to cast `anotherAnimal` to `Dog` without checking its actual type first. Since `anotherAnimal` is an instance of `Animal` (not `Dog`), attempting this cast will compile, but it will cause a `ClassCastException` at runtime.

- **B)** `if (anotherAnimal instanceof Dog) ((Dog)anotherAnimal).bark();` 
  - This option is correct. It uses `instanceof` to check whether `anotherAnimal` is an instance of `Dog` before attempting the cast and calling `bark()`. In this case, since `anotherAnimal` is not an instance of `Dog`, the check prevents the cast and method call, avoiding a `ClassCastException`.

- **C)** `((Cat)animal).meow();`
  - This option is incorrect because it casts `animal` to `Cat` and attempts to call `meow()`. Since `animal` is actually an instance of `Dog`, this cast will compile but will result in a `ClassCastException` at runtime.

- **D)** `if (anotherAnimal instanceof Cat) ((Cat)anotherAnimal).meow();`
  - This option is correct. It checks if `anotherAnimal` is an instance of `Cat` before casting it to `Cat` and calling `meow()`.

---
### Q037　Utilizing Java Object-Oriented Approach - Part 2

Consider the following code snippet:

**選項：**
```java
public class AdvancedPatternMatching {
    public static void process(Object input) {
        if (input instanceof String s && s.contains("Java")) {
            System.out.println("String with Java: " + s);
        } else if (input instanceof Integer i && i > 10) {
            System.out.println("Integer greater than 10: " + i);
        }
    }
    public static void main(String[] args) {
        process("Hello Java!");
        process(15);
        process("Just a string");
        process(5);
    }
}
```
Given the above code, which statement accurately describes its execution result?
- A. It compiles and prints `"String with Java: Hello Java!"` followed by `"Integer greater than 10: 15"`.  （✓ 正確）
- B. It compiles but only prints `"String with Java: Hello Java!"` because integers are not supported with pattern matching.  
- C. It does not compile because pattern matching in `instanceof` cannot be combined with logical operators like `&&`.  
- D. It compiles but prints all four lines due to incorrect use of pattern matching that always evaluates to `true`.  

**答：A。**

**解析：**

**Explanation:**

- **A)** It compiles and prints `"String with Java: Hello Java!"` followed by `"Integer greater than 10: 15"`.
  - This option is correct. The code snippet effectively demonstrates the use of pattern matching with the `instanceof` operator for both `String` and `Integer` types. The pattern matching feature checks if `input` is an instance of `String` or `Integer` and binds it to a variable (`s` for `String` and `i` for `Integer`) within the scope of the `if` and `else if` blocks. The logical operator `&&` is correctly used to further conditionally check properties of the variables (`s.contains("Java")` and `i > 10`). Thus, the method `process` prints output for inputs that are a `String` containing `"Java"` and an `Integer` greater than `10`, respectively.

- **B)** It compiles but only prints `"String with Java: Hello Java!"` because integers are not supported with pattern matching.
  - This option is incorrect because pattern matching works for any reference type, including `Integer`. The code does support integers and performs additional checks using pattern matching correctly.

- **C)** It does not compile because pattern matching in `instanceof` cannot be combined with logical operators like `&&`.
  - This option is incorrect. The code will compile and run as expected. Pattern matching in `instanceof` can indeed be combined with logical operators like `&&` for additional checks in the same conditional statement, as demonstrated in the code snippet.

- **D)** It compiles but prints all four lines due to incorrect use of pattern matching that always evaluates to `true`.
  - This option is incorrect because the use of pattern matching in the provided code is correct and does not always evaluate to `true`. The code correctly prints specific messages only for the inputs that match the given conditions.

---
### Q038　Utilizing Java Object-Oriented Approach - Part 2

Consider the encapsulation practices in the following class structure:

**選項：**
```java
package store;
public class Product {
    private String name;
    private double price;
    private int stock;
    public Product(String name, double price, int stock) {
        setName(name);
        setPrice(price);
        setStock(stock);
    }
    public String getName() {
        return name;
    }
    private void setName(String name) {
        this.name = name;
    }
    public double getPrice() {
        return price;
    }
    private void setPrice(double price) {
        if (price >= 0) {
            this.price = price;
        }
    }
    public int getStock() {
        return stock;
    }
    private void setStock(int stock) {
        if (stock >= 0) {
            this.stock = stock;
        }
    }
}
```
Which statement is true regarding the encapsulation of the `Product` class?
- A. Making the `setName`, `setPrice`, and `setStock` methods `public` would enhance the class's encapsulation.  
- B. The class is not encapsulated because the `Product` class's fields are `private`.  
- C. Encapsulation is weakened because the constructor allows direct setting of fields without validation.  
- D. The `Product` class should have package-private getters to improve encapsulation.  
- E. The class is properly encapsulated by providing `public` getters for all fields and `private` setters with validation, ensuring control over the state of its objects.  （✓ 正確）

**答：E。**

**解析：**

**Explanation:**

- **A)** Making the `setName`, `setPrice`, and `setStock` methods public would enhance the class's encapsulation.
  - This option is incorrect. Making the setters public would actually reduce the class's encapsulation by allowing external classes to modify the fields without restriction, potentially bypassing any validation logic contained within the setters.

- **B)** The class is not encapsulated because the `Product` class's fields are `private`. 
  - This option is incorrect. The use of `private` fields is a fundamental aspect of encapsulation. It prevents external classes from directly accessing and modifying the object's state, thus enforcing encapsulation.

- **C)** Encapsulation is weakened because the constructor allows direct setting of fields without validation.
  - This option is incorrect. The constructor does not weaken encapsulation; instead, it uses `private` setters that contain validation logic. This ensures that the object's state is correctly managed and validated upon creation.

- **D)** The `Product` class should have package-private getters to improve encapsulation.
  - This option is incorrect. Making getters package-private would limit the class's usability and does not inherently improve encapsulation. Public getters are necessary for external classes to view (but not modify) the object's state.

- **E)** The class is properly encapsulated by providing public getters for all fields and private setters with validation, ensuring control over the state of its objects.
  - This option is correct. The `Product` class demonstrates proper encapsulation practices by making its fields `private` and controlling access to them through `public` getters and `private` setters. The setters include validation logic, ensuring that only valid states are assigned to the fields. This design pattern ensures that the internal state of `Product` instances is both protected and correctly managed.

---
### Q039　Utilizing Java Object-Oriented Approach - Part 2

Consider the following classes defined in the same package:

**選項：**
```java
class Account {
    private double balance;
    Account(double initialBalance) {
        if (initialBalance > 0) {
            balance = initialBalance;
        }
    }
    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    protected double getBalance() {
        return balance;
    }
}
public class SavingsAccount extends Account {
    private double interestRate;
    public SavingsAccount(double initialBalance, double interestRate) {
        super(initialBalance);
        this.interestRate = interestRate;
    }
    public void applyInterest() {
        double interest = getBalance() * interestRate / 100;
        deposit(interest);
    }
}
```
Which statement(s) about encapsulation principles and the use of access modifiers accurately describes the code above? Choose all tha apply.
- A. The `SavingsAccount` class cannot access the `balance` field directly due to its `private` access modifier in the `Account` class.  （✓ 正確）
- B. The `getBalance` method should be `public` to allow `SavingsAccount` to access the account balance.  
- C. The `deposit` method in the `Account` class should be marked as `final` to prevent overriding.  
- D. The `interestRate` field in the `SavingsAccount` class violates encapsulation principles by being `private`.  
- E. The `Account` class correctly encapsulates the `balance` field, and `SavingsAccount` adheres to encapsulation by accessing `balance` through `getBalance` and `deposit`.  （✓ 正確）

**答：A、E。**

**解析：**

**Explanation:**

- **A)** The `SavingsAccount` class cannot access the `balance` field directly due to its `private` access modifier in the `Account` class.
  - This option is correct. The design intentionally restricts direct access to the `balance` field to maintain encapsulation.

- **B)** The `getBalance` method should be `public` to allow `SavingsAccount` to access the account balance.
  - This option is incorrect. Making `getBalance` `public` would increase its visibility unnecessarily. `protected` is sufficient for subclass access, and this change is not required for `SavingsAccount` to function correctly, making this statement incorrect.

- **C)** The `deposit` method in the `Account` class should be marked as `final` to prevent overriding.
  - This option is incorrect. Marking `deposit` as `final` would prevent it from being overridden in subclasses, which is not a requirement or suggestion indicated by the given code. The decision to make a method `final` should be based on the specific design needs rather than a general principle of encapsulation.

- **D)** The `interestRate` field in the `SavingsAccount` class violates encapsulation principles by being `private`.
  - This option is incorrect. Using a `private` access modifier for `interestRate` in `SavingsAccount` is an example of proper encapsulation. It restricts access to the field from outside the class, which is aligned with encapsulation principles, making this option incorrect.

- **E)** The `Account` class correctly encapsulates the `balance` field, and `SavingsAccount` adheres to encapsulation by accessing `balance` through `getBalance` and `deposit`.
  - This option is correct. The `Account` class uses `private` access for the `balance` field to encapsulate its state, providing `protected` and package-private methods (`getBalance` and `deposit`) for controlled access and modification. `SavingsAccount` respects this encapsulation by using these methods to interact with the `balance` field, demonstrating a proper understanding and application of encapsulation principles. This design allows `SavingsAccount` to leverage functionality provided by `Account` without breaking encapsulation, which is a key objective in object-oriented design.

---
### Q040　Utilizing Java Object-Oriented Approach - Part 2

Consider the following class:

**選項：**
```java
public final class Contact {
    private final String name;
    private final String email;
    private final Address address;
    public Contact(String name, String email, Address address) {
        this.name = name;
        this.email = email;
        this.address = new Address(address.getStreet(), address.getCity());
    }
    public String getName() {
        return name;
    }
    public String getEmail() {
        return email;
    }
    public Address getAddress() {
        return new Address(address.getStreet(), address.getCity());
    }
    public static class Address {
        private final String street;
        private final String city;
        public Address(String street, String city) {
            this.street = street;
            this.city = city;
        }
        public String getStreet() {
            return street;
        }
        public String getCity() {
            return city;
        }
    }
}
```
Given the above implementation, which statement accurately describes the `Contact` object?
- A. The `Contact` object is mutable because the `Address` class is not `final`.  
- B. The `Contact` object is immutable, but only because it does not provide setters.  
- C. The `Contact` object is immutable, and it properly prevents leakage of mutable internal state through defensive copying.  （✓ 正確）
- D. The `Contact` object is mutable because the `Address` object can be changed via the `getAddress` method.  
- E. The `Contact` object is immutable but fails to prevent access to its mutable internal state. 

**答：C。**

**解析：**

**Explanation:**

- **A)** The `Contact` object is mutable because the `Address` class is not `final`.
  - This option is incorrect because the `Address` class does not directly impact the immutability of the `Contact` object. The `Contact` class ensures its immutability by not providing setters and by making deep copies of mutable objects, such as `Address`, both in the constructor and the getter.

- **B)** The `Contact` object is immutable, but only because it does not provide setters.
  - This option is incorrect. While it's true that it does not provide setters, this option does not fully capture the essence of immutability. Thus, it doesn't highlight the fact that all fields in `Contact` are `final` and the defensive copying strategy.

- **C)** The `Contact` object is immutable, and it properly prevents leakage of mutable internal state through defensive copying.
  - This is the correct option. The `Contact` class is immutable because it meets all criteria for immutability: the class is declared as `final` (preventing subclassing), all its fields are `private` and `final`, and it does not provide any setters. Also, it implements defensive copying for the mutable `Address` field to ensure that the internal state cannot be altered by external changes to `Address` objects passed in or returned. This prevents the leakage of its mutable internal state.

- **D)** The `Contact` object is mutable because the `Address` object can be changed via the `getAddress` method. 
  - This option is incorrect because the `Contact` object's immutability is maintained through defensive copying. The `getAddress` method returns a new `Address` instance each time it is called, ensuring that the original `Address` object's state cannot be altered from outside the `Contact` object.

- **E)** The `Contact` object is immutable but fails to prevent access to its mutable internal state.
  - This option is incorrect because the `Contact` object does implement a strategy to prevent access to its mutable internal state: it uses defensive copying for the `Address` object in both the constructor and the getter method, which ensures that the internal state remains unchanged from outside modifications.

| 第 03 章 | Working with Records and Enums | 7 |
---
### Q041　Working with Records and Enums

Consider the following record definition:

**選項：**
```java
public record Employee(String name, int age) {}
```
Which of the following statements is true about the `Employee` record?
- A. The `Employee` record explicitly defines a public constructor that initializes its fields.  
- B. The fields `name` and `age` can be reassigned to new values after an `Employee` object is created.  
- C. The `Employee` record implicitly creates a public constructor and private final fields for `name` and `age`.  （✓ 正確）
- D. It is mandatory to define getters for the fields `name` and `age` in the `Employee` record.  

**答：C。**

**解析：**

**Explanation:**

- **A)** The `Employee` record explicitly defines a public constructor that initializes its fields. 
  - This option is incorrect because the record `Employee` does not explicitly define a `public` constructor. Records automatically generate a `public` constructor with the same parameters as the record's declaration.

- **B)** The fields `name` and `age` can be reassigned to new values after an `Employee` object is created.
  - This option is incorrect as the fields within a record are `final`, which means they cannot be reassigned to new values after an `Employee` object has been created. This immutability is one of the key characteristics of records.

- **C)** The `Employee` record implicitly creates a `public` constructor and `private` `final` fields for `name` and `age`.
  - This is the correct option. Records implicitly create a public constructor for the record's fields and also make these fields `private` and `final`. This means you don't have to manually write boilerplate code for constructor, getters, or to ensure immutability.

- **D)** It is mandatory to define getters for the fields `name` and `age` in the `Employee` record.
  - This option is incorrect because records automatically generate public methods to access the fields, known as accessor methods, which essentially act as getters. Therefore, it is not mandatory (or even possible) to define separate getters for the fields.

---
### Q042　Working with Records and Enums

Given the record definition below:

**選項：**
```java
public record Account(String id, double balance) {}
```
Which statement accurately describes the immutability of records?
- A. The `balance` field can be modified using a public setter method within the `Account` record.  
- B. Once an `Account` object is created, its `id` and `balance` cannot be changed.  （✓ 正確）
- C. Immutability of records can be bypassed by you define custom setter methods for the `id` and `balance` fields.  
- D. Records allow field values to be modified if accessed directly, without using setter methods.  

**答：B。**

**解析：**

**Explanation:**

- **A)** The `balance` field can be modified using a public setter method within the `Account` record.
  - This option is incorrect because records in Java do not support public setter methods for their fields. The fields of a record are `final` and cannot be modified after the object's construction, which is a key aspect of their design to enforce immutability.

- **B)** Once an `Account` object is created, its `id` and `balance` cannot be changed.
  - This is the correct option. Records are immutable by design, meaning that once a record object is created, the values of its fields (`id` and `balance` in this case) cannot be changed. This immutability is ensured by making the fields `private` and `final`, and by not providing setter methods.

- **C)** Immutability of records can be bypassed by you define custom setter methods for the `id` and `balance` fields. 
  - This option is incorrect. Custom setter methods cannot be defined for the record fields because records do not allow defining mutators for their components.

- **D)** Records allow field values to be modified if accessed directly, without using setter methods.
  - This option is incorrect because the fields in a record are implicitly `final` and private, which means they cannot be modified directly or through setter methods. The design of records enforces this immutability to ensure that instances of records act as true carriers of immutable data.

---
### Q043　Working with Records and Enums

Consider the following record declaration:

**選項：**
```java
public record Product(int id, String name, double price) {}
```
How can you correctly initialize an instance of the `Product` record?
- A. `Product p = new Product();`  
- B. `Product p = Product(101, "Coffee", 15.99);`  
- C. `Product p = {101, "Coffee", 15.99};`  
- D. `Product p = new Product(101, "Coffee", 15.99);`  （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** `Product p = new Product();`
  - This option is incorrect because the default constructor without parameters does not exist for records in Java. Records require all their fields to be specified at the time of instantiation.

- **B)** `Product p = Product(101, "Coffee", 15.99);`
  - This option is incorrect because the syntax used here is not valid for creating a new instance of a record in Java. The correct syntax for instantiating a record involves using the `new` keyword followed by the record name and the parameters in parentheses.

- **C)** `Product p = {101, "Coffee", 15.99};`
  - This option is incorrect as it mistakenly uses the syntax for array initialization. In Java, objects, including records, cannot be instantiated using curly braces without the `new` keyword and proper constructor.

- **D)** `Product p = new Product(101, "Coffee", 15.99);`
  - This is the correct option. Records in Java are instantiated using the `new` keyword followed by the record's constructor, which requires passing all the fields defined in the record. This syntax correctly creates a new `Product` record with the given `id`, `name`, and `price`.

---
### Q044　Working with Records and Enums

Consider a record that needs to implement the `Comparable` interface to allow sorting based on one of its fields. Given the following record definition:

**選項：**
```java
public record Item(int id, String name, double price) implements Comparable<Item> {
    public int compareTo(Item other) {
        return Double.compare(this.price, other.price);
    }
}
```
Which statement correctly describes how records can be customized by implementing interfaces?
- A. Records cannot implement interfaces because they are `final` and immutable by design, which prevents any form of behavior customization.  
- B. This record correctly implements the `Comparable` interface, allowing `Item` objects to be sorted based on their `price`.  （✓ 正確）
- C. Implementing interfaces in records is restricted only to functional interfaces due to their immutable nature.  
- D. The `compareTo` method cannot be overridden in records because method overriding is not supported in record types.  

**答：B。**

**解析：**

**Explanation:**

- **A)** Records cannot implement interfaces because they are `final` and immutable by design, which prevents any form of behavior customization.
  - This option is incorrect. Records in Java can implement interfaces. The finality and immutability of records do not preclude them from implementing interfaces, which can be used to add behaviors or contractual obligations to a record.

- **B)** This record correctly implements the `Comparable` interface, allowing `Item` objects to be sorted based on their `price`.
  - This is the correct option. The provided record definition correctly implements the `Comparable<Item>` interface by overriding the `compareTo` method. This customization allows instances of the `Item` record to be sorted based on the `price` field, demonstrating that records can indeed implement interfaces and override their methods as needed.

- **C)** Implementing interfaces in records is restricted only to functional interfaces due to their immutable nature.
  - This option is incorrect. There is no such restriction that limits records to implementing only functional interfaces. Records can implement any interface, including those with multiple abstract methods, as long as the record provides implementations for the abstract methods defined in the interface.

- **D)** The `compareTo` method cannot be overridden in records because method overriding is not supported in record types.
  - This option is incorrect. Records can override methods from the interfaces they implement, including the `compareTo` method from the `Comparable` interface in this example. Method overriding is a key aspect of implementing interfaces and is fully supported by record types in Java.

---
### Q045　Working with Records and Enums

Consider the ways to declare enums in Java. Which of the following declarations are valid? (Choose all that apply.)

**選項：**
- A.  ```java public enum Day { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY } ``` （✓ 正確）
- B.  ```java enum Month { private JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER; } ``` 
- C.  ```java protected enum Season { WINTER, SPRING, SUMMER, FALL } ``` 
- D.  ```java enum Status { ACTIVE, INACTIVE, DELETED;  public void printStatus() { System.out.println("Current status: " + this); } } ``` （✓ 正確）

**答：A、D。**

**解析：**

**Explanation:**

- **A)** 
```java
public enum Day {
    MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
}
```
  - This option is correct. It demonstrates a valid declaration of an enum in Java. Enums are used to define a set of named constants, and this syntax is the standard way to declare them. The `public` access modifier makes this enum accessible from any other class.

- **B)** 
```java
enum Month {
    private JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER;
}
```
  - This option is incorrect. Enums cannot have `private` access modifiers for their constants. Enum constants are implicitly `public`, `static`, and `final` and should be declared without access modifiers.

- **C)** 
```java
protected enum Season {
    WINTER, SPRING, SUMMER, FALL
}
```
  - This option is incorrect because enums cannot be declared with `protected` or `private` access levels. Enums are implicitly `public` if they are defined outside of a class. If defined within a class, they can have any access level, but the `protected` keyword cannot be used at the enum level itself.

- **D)** 
```java
enum Status {
    ACTIVE, INACTIVE, DELETED;

    public void printStatus() {
        System.out.println("Current status: " + this);
    }
}
```
  - This option is correct. It shows an enum `Status` with a method `printStatus()`. Enums in Java can contain methods, fields, constructors, and implement interfaces. This demonstrates the ability of enums to have methods, making this declaration valid.

---
### Q046　Working with Records and Enums

Consider the following enum declaration:

**選項：**
```java
public enum Color {
    RED, GREEN, BLUE;
}
```
What is the result of calling `Color.GREEN.ordinal()`?
- A. `1`  （✓ 正確）
- B. `2`  
- C. `0`  
- D. `Color.GREEN`  

**答：A。**

**解析：**

**Explanation:**

- **A)** `1`
   - This option is correct. The `ordinal()` method returns the ordinal of this enumeration constant (its position in its enum declaration, where the initial constant is assigned an ordinal of zero). Since `GREEN` is the second enum constant declared in the `Color` enum, its ordinal value is 1.

- **B)** `2`
  - This option is incorrect. The ordinal value of `BLUE` would be 2, not `GREEN`, because `BLUE` is the third declared constant in the `Color` enum.

- **C)** `0`
  - This option is incorrect. The ordinal value of `RED` is 0, as it is the first declared constant in the `Color` enum.

- **D)** `Color.GREEN`
  - This option is incorrect. The `ordinal()` method returns an integer representing the position of the enum constant in the declaration, not the enum constant itself.

---
### Q047　Working with Records and Enums

Consider an enum that needs to provide a custom method to display a message based on the enum constant. Which of the following implementations correctly defines such an enum?

**選項：**
- A.  ```java public enum Size { SMALL, MEDIUM, LARGE; public static void printSize() { System.out.println("The size is " + this.name()); } } ``` 
- B.  ```java enum Flavor { CHOCOLATE, VANILLA, STRAWBERRY; void printFlavor() { System.out.println("Flavor: " + Flavor.name); } } ``` 
- C.  ```java protected enum Direction { NORTH, SOUTH, EAST, WEST; private printDirection() { System.out.println("Going " + this.toString()); } } ``` 
- D.  ```java public enum Season { WINTER, SPRING, SUMMER, FALL; public void printSeason() { System.out.println("The season is " + this.name()); } } ```（✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** 
```java
public enum Size {
    SMALL, MEDIUM, LARGE;
    public static void printSize() {
        System.out.println("The size is " + this.name());
    }
}
```
  - This option is incorrect because the method `printSize()` is defined as `static`, which means it cannot access the `this` reference. Static methods in enums can't directly access the enum constants without specifying the constant explicitly or being passed a reference.

- **B)** 
```java
enum Flavor {
    CHOCOLATE, VANILLA, STRAWBERRY;
    void printFlavor() {
        System.out.println("Flavor: " + Flavor.name);
    }
}
```
  - This option is incorrect because the `name` property of an enum constant is `private`. You can only access it using the `this` reference and the `name()` method (`this.name()`).

- **C)** 
```java
protected enum Direction {
    NORTH, SOUTH, EAST, WEST;
    private printDirection() {
        System.out.println("Going " + this.toString());
    }
}
```
  - This option is incorrect for two reasons. First, `protected` is not a valid access modifier for a top-level enum, top-level enums can only be `public` or package-private (no modifier). Second, `printDirection()` method is missing a return type (e.g., `void`).

- **D)** 
```java
public enum Season {
    WINTER, SPRING, SUMMER, FALL;
    public void printSeason() {
        System.out.println("The season is " + this.name());
    }
}
```
  - This is the correct option. The `printSeason()` method is properly defined: it's `public`, non-static, and utilizes the `this` reference to access the name of the current enum constant. This method correctly provides custom behavior for each enum constant, allowing it to print a message indicating the current season.

| 第 04 章 | Working with Data | 5 |
---
### Q048　Working with Data

Which of the following statements about Java primitive and reference data types is true?

**選項：**
- A. A `double` can be directly assigned to a `float` without casting.  
- B. A `boolean` can be cast to an `int`.  
- C. A `String` can be assigned to an `Object` reference variable.  （✓ 正確）
- D. A `char` is a reference data type.  
- E. An `int` can store a `long` value without any explicit casting.  

**答：C。**

**解析：**

**Explanation:**

- **A)** A `double` can be directly assigned to a `float` without casting. 
  - This option is incorrect. A `double` cannot be directly assigned to a `float` without casting because `double` has a larger range and precision than a `float`.

- **B)** A `boolean` can be cast to an `int`.
  - This option is incorrect. `boolean` values cannot be cast to `int` in Java. They are not compatible types.

- **C)** A `String` can be assigned to an `Object` reference variable.
  - This option is correct. A `String` is an instance of the `Object` class, and hence it can be assigned to an `Object` reference variable.

- **D)** A `char` is a reference data type. 
  - This option is incorrect. `char` is a primitive data type, not a reference data type.

- **E)** An `int` can store a `long` value without any explicit casting.
  - This option is incorrect. an `int` cannot store a `long` value without explicit casting because `long` has a larger range than `int`.

---
### Q049　Working with Data

What is the output of the following code snippet?

**選項：**
```java
public class OperatorTest {
    public static void main(String[] args) {
        int a = 5;
        int b = 10;
        int c = 15;
        int result = a + b * c / a - b;
        System.out.println(result);
    }
}
```
- A. `25`  （✓ 正確）
- B. `35`  
- C. `20`  
- D. `15`  

**答：A。**

**解析：**

**Explanation:**

Let's break down the expression `a + b * c / a - b` step-by-step according to the order of operations:

1. **Multiplication and Division** are performed first from left to right:
   - `b * c` = `10 * 15` = `150`
   - `150 / a` = `150 / 5` = `30`

2. **Addition and Subtraction** are performed next from left to right:
   - `a + 30` = `5 + 30` = `35`
   - `35 - b` = `35 - 10` = `25`

So, the value of `result` is `25`, and the program prints `25`.

- **A)** `25`
  - This option is correct.

- **B)** `35`
  - This option is incorrect.

- **C)** `20` 
  - This option is incorrect.

- **D)** `15` 
  - This option is incorrect.

---
### Q050　Working with Data

Which of the following statements about `String` and `StringBuilder` is true?

**選項：**
- A. `StringBuilder` objects are immutable.  
- B. `String` objects can be modified after they are created.  
- C. `StringBuilder` is synchronized and thread-safe.  
- D. `StringBuilder` provides methods for mutable sequence of characters.  （✓ 正確）
- E. `String` and `StringBuilder` have the same performance characteristics for string manipulation.  

**答：D。**

**解析：**

**Explanation:**

- **A)** `StringBuilder` objects are immutable.
  - This option is incorrect. `StringBuilder` objects are mutable, meaning they can be changed after they are created.

- **B)** `String` objects can be modified after they are created. 
  - This option is incorrect. `String` objects are immutable, meaning once a `String` object is created, it cannot be modified. Any modification results in a new `String` object.

- **C)** `StringBuilder` is synchronized and thread-safe.
  - This option is incorrect. `StringBuilder` is not synchronized and is not thread-safe. If synchronization is required, `StringBuffer` should be used instead.

- **D)** `StringBuilder` provides methods for mutable sequence of characters.
  - This option is correct. `StringBuilder` provides methods for a mutable sequence of characters, allowing for modification of the object without creating new instances.

- **E)** `String` and `StringBuilder` have the same performance characteristics for string manipulation.
  - This option is incorrect. `String` and `StringBuilder` do not have the same performance characteristics for string manipulation. `StringBuilder` is generally more efficient for such operations because it is mutable and does not create new instances with each modification.

---
### Q051　Working with Data

Which of the following statements about text blocks are true? (Choose all that apply.)

**選項：**
- A. Text blocks can span multiple lines without needing escape sequences for new lines.  （✓ 正確）
- B. Text blocks preserve the exact format, including whitespace, of the code as written.  （✓ 正確）
- C. Text blocks can only be used within methods.  
- D. Text blocks automatically trim leading and trailing whitespace from each line.  
- E. Text blocks require a minimum indentation level of one space.   

**答：A、B。**

**解析：**

**Explanation:**

- **A)** Text blocks can span multiple lines without needing escape sequences for new lines.
  - This option is correct. Text blocks can indeed span multiple lines without needing escape sequences for new lines, making it easier to work with multi-line strings.

- **B)** Text blocks preserve the exact format, including whitespace, of the code as written.
  - This option is correct. Text blocks preserve the exact format, including whitespace, of the code as written. This is useful for maintaining the original layout of the text.

- **C)** Text blocks can only be used within methods.
  - This option is incorrect. Text blocks can be used anywhere a regular `String` can be used, not just within methods. They can be part of class fields, method parameters, etc.

- **D)** Text blocks automatically trim leading and trailing whitespace from each line. 
  - This option is incorrect. Text blocks do not automatically trim leading and trailing whitespace from each line. They preserve the exact whitespace as written in the code.

- **E)** Text blocks require a minimum indentation level of one space.
  - This option is incorrect. Text blocks do not require a minimum indentation level of one space. The leading indentation common to all lines is removed automatically, but lines within the text block can have zero or more leading spaces.

---
### Q052　Working with Data

Which of the following statements about the `Math` class is true?

**選項：**
- A. The `Math.round()` method returns a `double`.  
- B. The `Math.random()` method returns a random integer.  
- C. The `Math.max()` method can only be used with integers.  
- D. The `Math.pow()` method returns the result of raising the first argument to the power of the second argument.  （✓ 正確）
- E. The `Math.abs()` method can only be used with positive numbers.   

**答：D。**

**解析：**

**Explanation:**

- **A)** The `Math.round()` method returns a `double`.
  - This option is incorrect. The `Math.round()` method returns a `long` when given a `double` argument and an `int` when given a `float` argument.

- **B)** The `Math.random()` method returns a random integer.
  - This option is incorrect. The `Math.random()` method returns a `double` value between 0.0 (inclusive) and 1.0 (exclusive).

- **C)** The `Math.max()` method can only be used with integers.
  - This option is incorrect. The `Math.max()` method can be used with various numeric types, including `int`, `long`, `float`, and `double`.

- **D)** The `Math.pow()` method returns the result of raising the first argument to the power of the second argument.
  - This option is correct. The `Math.pow()` method returns the result of raising the first argument to the power of the second argument. Both arguments are of type `double`.

- **E)** The `Math.abs()` method can only be used with positive numbers.
  - This option is incorrect. The `Math.abs()` method can be used with negative numbers to return their absolute value, and it works with various numeric types including `int`, `long`, `float`, and `double`.

| 第 05 章 | Controlling Program Flow | 10 |
---
### Q053　Controlling Program Flow

What will be the output of the following program?

**選項：**
```java
public class IfStatementTest {
    public static void main(String[] args) {
        int x = 10;
        if (x > 5) {
            if (x < 20) {
                System.out.println("x is between 5 and 20");
            }
        } else {
            System.out.println("x is 5 or less");
        }
    }
}
```
- A. `x is between 5 and 20`  （✓ 正確）
- B. `x is 5 or less`  
- C. `x is greater than 20`  
- D. The program does not compile  
- E. The program compiles but does not produce any output  

**答：A。**

**解析：**

**Explanation:**

- **A)** `x is between 5 and 20`
  - This option is correct. The value of `x` is 10, which satisfies both conditions in the nested `if` statements (`x > 5` and `x < 20`). Therefore, the program prints `"x is between 5 and 20"`.

- **B)** `x is 5 or less` 
  - This option is incorrect. The value of `x` is 10, which does not satisfy the condition `x <= 5` in the `else` block. Therefore, this message will not be printed.

- **C)** `x is greater than 20`
  - This option is incorrect. The value of `x` is 10, which does not satisfy the condition `x > 20`. Therefore, this message will not be printed.

- **D)** The program does not compile 
  - This option is incorrect. The program compiles successfully without any errors.

- **E)** The program compiles but does not produce any output
  - This option is incorrect. The program produces output because the value of `x` satisfies the conditions within the nested `if` statements, leading to the output `"x is between 5 and 20"`.

---
### Q054　Controlling Program Flow

Given the following code:

**選項：**
```java
record Person(String name, int age) {}
record Employee(int id, Person person) {}
public class RecordPattern {
    public static void main(String[] args) {
        Employee emp = new Employee(1001, new Person("Alice", 30));
        // Insert code here
    }
}
```
Which of the following options correctly uses record pattern matching in an `if` statement to extract and print the name and age of a `Person` record in Java 21?
- A.  ```java if (emp instanceof Employee) { var (id, Person(name, age)) = emp; System.out.println(name + " is " + age + " years old."); } ``` 
- B.  ```java if (emp instanceof Employee(_, Person(var name, var age))) { System.out.println(name + " is " + age + " years old."); } ``` 
- C.  ```java if (emp instanceof Employee e) { System.out.println(e.person().name() + " is " + e.person().age() + " years old."); } ``` 
- D.  ```java if (emp instanceof Employee(var id, Person(var name, var age))) { System.out.println(name + " is " + age + " years old."); } ``` （✓ 正確）
- E.  ```java if (emp instanceof Employee(var id, var person)) { System.out.println(person.name() + " is " + person.age() + " years old."); } ```  

**答：D。**

**解析：**

**Explanation:**

- **A)** 
```java
if (emp instanceof Employee) {
    var (id, Person(name, age)) = emp;
    System.out.println(name + " is " + age + " years old.");
}
```
  - This option is incorrect. While it attempts to use destructuring, this syntax is not valid in Java. Java doesn't support destructuring assignment in this way.

- **B)** 
```java
if (emp instanceof Employee(_, Person(var name, var age))) {
    System.out.println(name + " is " + age + " years old.");
}
```
  - This option is incorrect. It uses the underscore (`_`) to ignore the `id` field, which is not a valid technique in Java 21.

- **C)**
```java
if (emp instanceof Employee e) {
    System.out.println(e.person().name() + " is " + e.person().age() + " years old.");
}
```
  - This option is incorrect. It uses traditional `instanceof` without pattern matching, relying on accessor methods to extract the data.

- **D)**
```java
if (emp instanceof Employee(var id, Person(var name, var age))) {
    System.out.println(name + " is " + age + " years old.");
}
```
  - This option is correct. It uses nested record pattern matching to extract both the `Employee` and `Person` data in a single step. It uses `var` for type inference and correctly names the variables `name` and `age` as required.

- **E)** 
```java
if (emp instanceof Employee(var id, var person)) {
    System.out.println(person.name() + " is " + person.age() + " years old.");
}
```
  - This option is incorrect. While it uses pattern matching for the `Employee` record, it doesn't nest the pattern matching for the `Person` record, so it still requires calling accessor methods on `person`.

---
### Q055　Controlling Program Flow

Which of the following code snippets compile without error?

**選項：**
```java
public class FlowScopingTest {
    public static void main(String[] args) {
        int x = 10;
        if (x > 5) {
            int y = x * 2;
        }
        // Code snippet 1
        System.out.println(y);
        if (x < 20) {
            int z = x + 5;
        }
        // Code snippet 2
        z += 5;
        int a = 5;
        if (a > 0) {
            a = 15;
        }
        // Code snippet 3
        System.out.println(a);
        if (x > 0) {
            int b = x + 3;
            if (b > 15) {
                b -= 2;
            }
        }
        // Code snippet 4
        System.out.println(b);
    }
}
```
- A. Code snippet 1  
- B. Code snippet 2  
- C. Code snippet 3  （✓ 正確）
- D. None of the above    

**答：C。**

**解析：**

**Explanation:**

- **A)** Code snippet 1
  - This option is incorrect. The variable `y` is declared inside the first `if` statement and is not accessible outside its block. Therefore, trying to print `y` outside its scope results in a compilation error.

- **B)** Code snippet 2
  - This option is incorrect. The variable `z` is declared inside the second `if` statement and is not accessible outside its block. Therefore, attempting to use `z` outside its scope results in a compilation error.

- **C)** Code snippet 3
  - This option is correct. The variable `a` is declared outside the `if` statement, so it is accessible both inside and outside the `if` block. Reassigning a inside the `if` block is allowed.

- **D)** None of the above
  - This option is incorrect. While it's true that code snippets 1, 2 and 4 will not compile, code snippet 3 does compile without any errors. Therefore, the answer cannot be "none of the above".

---
### Q056　Controlling Program Flow

What will be the output of the following program?

**選項：**
```java
public class SwitchTest {
    public static void main(String[] args) {
        int dayOfWeek = 3;
        String dayType;
        switch (dayOfWeek) {
            case 1:
            case 7:
                dayType = "Weekend";
                break;
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
                dayType = "Weekday";
                break;
            default:
                dayType = "Invalid day";
        }
        System.out.println(dayType);
    }
}
```
- A. `Weekend`  
- B. `Invalid day`  
- C. `Weekday`  （✓ 正確）
- D. The program does not compile  
- E. The program compiles but does not produce any output  

**答：C。**

**解析：**

**Explanation:**

- **A)** `Weekend` 
  - This option is incorrect. The value of `dayOfWeek` is 3, which does not match cases 1 or 7, so it does not print `"Weekend"`.

- **B)** `Invalid day`
  - This option is incorrect. The default case is not executed because the value of `dayOfWeek` matches one of the specific cases (2, 3, 4, 5, or 6).

- **C)** `Weekday`
  - This option is correct. The value of `dayOfWeek` is 3, which matches case 3. Therefore, the variable `dayType` is set to `"Weekday"`, and this value is printed.

- **D)** The program does not compile
  - This option is incorrect. The program compiles without errors.

- **E)** The program compiles but does not produce any output
  - This option is incorrect. The program compiles and produces output, which is `"Weekday"` based on the given `dayOfWeek` value.

---
### Q057　Controlling Program Flow

What will be the output of the following program?

**選項：**
```java
public class SwitchExpressionTest {
    public static void main(String[] args) {
        int score = 85;
        String grade = switch (score) {
            case 90, 100 -> "A";
            case 80, 89 -> "B";
            case 70, 79 -> "C";
            case 60, 69 -> "D";
            default -> "F";
        };
        System.out.println(grade);
    }
}
```
- A. `A`  
- B. `F`  （✓ 正確）
- C. The program does not compile  
- D. `B`  
- E. The program compiles but does not produce any output  

**答：B。**

**解析：**

**Explanation:**

- **A)** `A`
  - This option is incorrect. The value of `score` is 85, which does not match the cases for 90 or 100. Therefore, it does not print `"A"`.

- **B)** `F`
  - This option is correct. The default case is executed because the value of `score` doesn't match any of the other `case` statements.

- **C)** The program does not compile 
  - This option is incorrect. The program uses a `switch` expression correctly, compiling without errors.

- **D)** `B`
  - This option is incorrect. The value of `score` is 85, which doesn't match the case for 80 or 89.

- **E)** The program compiles but does not produce any output
  - This option is incorrect. The program compiles and produces output, which is `"F"` based on the given `score` value.

---
### Q058　Controlling Program Flow

Given the following code:

**選項：**
```java
public class SwitchEnums {
    sealed interface Vehicle permits CarType {}
    enum CarType implements Vehicle { SEDAN, SUV, HATCHBACK, CONVERTIBLE }
    void processVehicle(Vehicle v) {
        switch(v) {
            // Insert case statements here
        }
    }
}
```
Which of the following `case` statements are valid in Java 21 when inserted in the `switch` expression?
- A.  ```java case CarType.SEDAN, CarType.HATCHBACK -> System.out.println("Compact vehicle"); case CarType.SUV -> System.out.println("Large vehicle"); case CarType.CONVERTIBLE -> System.out.println("Open-top vehicle"); ``` （✓ 正確）
- B.  ```java case SEDAN, HATCHBACK -> System.out.println("Compact vehicle"); case SUV -> System.out.println("Large vehicle"); case CONVERTIBLE -> System.out.println("Open-top vehicle"); ``` 
- C.  ```java case CarType.SEDAN || CarType.HATCHBACK -> System.out.println("Compact vehicle"); case CarType.SUV -> System.out.println("Large vehicle"); case CarType.CONVERTIBLE -> System.out.println("Open-top vehicle"); ``` 
- D.  ```java case Vehicle.SEDAN, Vehicle.HATCHBACK -> System.out.println("Compact vehicle"); case Vehicle.SUV -> System.out.println("Large vehicle"); case Vehicle.CONVERTIBLE -> System.out.println("Open-top vehicle"); ```  

**答：A。**

**解析：**

**Explanation:**

- **A)** 
```java
case CarType.SEDAN, CarType.HATCHBACK -> System.out.println("Compact vehicle");
case CarType.SUV -> System.out.println("Large vehicle");
case CarType.CONVERTIBLE -> System.out.println("Open-top vehicle");
```
  - This option is correct. In Java 21, you can use fully qualified names of enum constants in switch statements, even when the selector expression is of a type that's assignment-compatible with the enum type (in this case, `Vehicle` is assignment-compatible with `CarType`).

- **B)** 
```java
case SEDAN, HATCHBACK -> System.out.println("Compact vehicle");
case SUV -> System.out.println("Large vehicle");
case CONVERTIBLE -> System.out.println("Open-top vehicle");
```
  - This option is incorrect. When using an interface type (`Vehicle`) as the selector expression, you must use fully qualified names for the enum constants. Using unqualified names (`SEDAN`, `HATCHBACK`, etc.) will result in a compilation error.

- **C)** 
```java
case CarType.SEDAN || CarType.HATCHBACK -> System.out.println("Compact vehicle");
case CarType.SUV -> System.out.println("Large vehicle");
case CarType.CONVERTIBLE -> System.out.println("Open-top vehicle");
```
  - This option is incorrect. It attempts to use the logical OR operator (`||`) in the case label, which is not valid syntax for switch statements. Multiple case labels should be separated by commas, not logical operators.

- **D)** 
```java
case Vehicle.SEDAN, Vehicle.HATCHBACK -> System.out.println("Compact vehicle");
case Vehicle.SUV -> System.out.println("Large vehicle");
case Vehicle.CONVERTIBLE -> System.out.println("Open-top vehicle");
```
  - This option is incorrect. Although it uses fully qualified names, it incorrectly prefixes the enum constants with `Vehicle` instead of `CarType`. The enum constants belong to the `CarType` enum, not the `Vehicle` interface, so this will result in a compilation error.

---
### Q059　Controlling Program Flow

Given the following code:

**選項：**
```java
sealed interface Shape permits Circle, Square, Triangle {}
record Circle(double radius) implements Shape {}
record Square(double side) implements Shape {}
record Triangle(double base, double height) implements Shape {}
Shape shape = new Circle(5);
double area = switch (shape) {
    // Insert case statements here
};
```
Which of the following `case` statements correctly implements pattern matching for the `Shap`e hierarchy when inserted in the `switch` expression?
- A.  ```java case Circle c -> Math.PI * c.radius() * c.radius(); case Square s -> s.side() * s.side(); case null -> 0; ``` 
- B.  ```java default -> 0; case Circle c -> Math.PI * c.radius() * c.radius(); case Square s -> s.side() * s.side(); case Triangle t -> 0.5 * t.base() * t.height(); ``` 
- C.  ```java case Shape s when s instanceof Circle -> Math.PI * ((Circle)s).radius() * ((Circle)s).radius(); case Shape s when s instanceof Square -> ((Square)s).side() * ((Square)s).side(); case Shape s when s instanceof Triangle -> 0.5 * ((Triangle)s).base() * ((Triangle)s).height(); ``` 
- D.  ```java case Circle c -> Math.PI * c.radius() * c.radius(); case Square s -> s.side() * s.side(); case Triangle t -> 0.5 * t.base() * t.height(); ```  （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** 
```java
case Circle c -> Math.PI * c.radius() * c.radius();
case Square s -> s.side() * s.side();
case null -> 0;
```
  - This option is incorrect. It doesn't compile because the `switch` expression is not exhaustive, it does not cover all possible `Shape` values.

- **B)** 
```java
default -> 0;
case Circle c -> Math.PI * c.radius() * c.radius();
case Square s -> s.side() * s.side();
case Triangle t -> 0.5 * t.base() * t.height();
```
   - This option is incorrect. It doesn't compile because the (unnecessary) `default` case comes before the rest of the `case` statements.

- **C)** 
```java
case Shape s when s instanceof Circle ->
        Math.PI * ((Circle)s).radius() * ((Circle)s).radius();
case Shape s when s instanceof Square ->
        ((Square)s).side() * ((Square)s).side();
case Shape s when s instanceof Triangle ->
        0.5 * ((Triangle)s).base() * ((Triangle)s).height();
```
  - This option is incorrect. It doesn't compile because it's not exhaustive. Since it uses verbose `instanceof` checks instead of leveraging pattern matching, it's missing a `default` branch.

- **D)** 
```java
case Circle c -> Math.PI * c.radius() * c.radius();
case Square s -> s.side() * s.side();
case Triangle t -> 0.5 * t.base() * t.height();
``` 
- This option is correct. It covers all possible subtypes of the sealed `Shape` interface without an unnecessary `default` case.

---
### Q060　Controlling Program Flow

What will be the output of the following program?

**選項：**
```java
public class LabeledBreakTest {
    public static void main(String[] args) {
        int count = 0;
        outerLoop:
        while (count < 5) {
            while (true) {
                count++;
                if (count == 3) {
                    break outerLoop;
                }
            }
        }
        System.out.println(count);
    }
}
```
- A. `2`  
- B. `3`  （✓ 正確）
- C. `4`  
- D. `5`  
- E. The program does not compile  

**答：B。**

**解析：**

**Explanation:**

- **A)** `2`
  - This option is incorrect. The value of `count` is incremented until it reaches 3. The labeled `break` statement breaks out of the outer loop when `count` equals 3.

- **B)** `3`
  - This option is correct. The value of `count` is incremented inside the inner `while` loop. When `count` reaches 3, the labeled `break` statement (`break outerLoop`) is executed, causing the control to exit the outer loop. Therefore, `count` is 3 when printed.

- **C)** `4`
  - This option is incorrect. The loop does not continue incrementing `count` to 4 because the labeled `break` statement exits the loop when `count` is 3.

- **D)** `5`
  - This option is incorrect. The loop does not continue incrementing `count` to 5 because the labeled `break` statement exits the loop when `count` is 3.

- **E)** The program does not compile
  - This option is incorrect. The program compiles successfully and runs without errors.

---
### Q061　Controlling Program Flow

What will be the output of the following program?

**選項：**
```java
public class ForLoopTest {
    public static void main(String[] args) {
        int sum = 0;
        for (int i = 1; i <= 5; i++) {
            sum += i;
        }
        System.out.println(sum);
    }
}
```
- A. `5`  
- B. `10`  
- C. `15`  （✓ 正確）
- D. `20`  
- E. The program does not compile  

**答：C。**

**解析：**

**Explanation:**

- **A)** `5`
  - This option is incorrect. The value 5 is just the upper limit of the loop and not the sum of the integers from 1 to 5.

- **B)** `10`
  - This option is incorrect. The value 10 is less than the sum of the integers from 1 to 5.

- **C)** `15`
  - This option is correct. The loop iterates from 1 to 5, adding each value of `i` to `sum`. The calculations are as follows: 1 + 2 + 3 + 4 + 5 = 15.

- **D)** `20`
  - This option is incorrect. The value 20 is more than the sum of the integers from 1 to 5.

- **E)** The program does not compile
  - This option is incorrect. The program compiles successfully and runs without errors.

---
### Q062　Controlling Program Flow

What will be the output of the following program?

**選項：**
```java
public class EnhancedForLoopTest {
    public static void main(String[] args) {
        int[] numbers = {1, 2, 3, 4, 5};
        int sum = 0;
        for (int num : numbers) {
            if (num % 2 == 0) {
                continue;
            }
            sum += num;
        }
        System.out.println(sum);
    }
}
```
- A. `9`  （✓ 正確）
- B. `10`  
- C. `12`  
- D. `15`  
- E. The program does not compile    

**答：A。**

**解析：**

**Explanation:**

- **A)** `9`
  - This option is correct. The `continue` statement skips the current iteration when the number is even (`num % 2 == 0`). The odd numbers in the array are 1, 3, and 5. Their sum is 1 + 3 + 5 = 9.

- **B)** `10`
  - This option is incorrect. The sum of the odd numbers (1, 3, and 5) is 9, not 10.

- **C)** `12`
  - This option is incorrect. The sum of the odd numbers (1, 3, and 5) is 9, not 12.

- **D)** `15`
  - This option is incorrect. The sum of all the numbers in the array (1 + 2 + 3 + 4 + 5) is 15, but the `continue` statement causes the loop to skip adding the even numbers.

- **E)** The program does not compile
  - This option is incorrect. The program compiles successfully and runs without errors.

| 第 06 章 | Arrays, Generics, and Collections | 9 |
---
### Q063　Arrays, Generics, and Collections

What is the output of the following program?

**選項：**
```java
public class MultiDimArray {
    public static void main(String[] args) {
        int[][] arr = new int[2][3];
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr[i].length; j++) {
                arr[i][j] = i + j;
            }
        }
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr[i].length; j++) {
                System.out.print(arr[i][j] + " ");
            }
            System.out.println();
        }
    }
}
```
- A.  ``` 0 0 0 0 0 0 ``` 
- B.  ``` 0 1 2 0 1 2 ``` 
- C.  ``` 0 0 0 1 1 1 ``` 
- D.  ``` 0 1 2 1 2 3 ```  （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** 
```
0 0 0 
0 0 0 
```
  - This option is incorrect because the array elements are initialized and modified within the loops. The values are not all zeros.

- **B)** 
```
0 1 2 
0 1 2 
```
  - This option is incorrect because each row is initialized with incremental values based on the sum of indices, not identical for both rows.

- **C)** 
```
0 0 0 
1 1 1 
```
  - This option is incorrect because the values should be the sum of the row index and the column index, not all zeros or all ones for the second row.

- **D)** 
```
0 1 2 
1 2 3 
```
  - This is the correct answer. Each element of the array is set to the sum of its indices. So, `arr[0][0] = 0 + 0 = 0`, `arr[0][1] = 0 + 1 = 1`, `arr[0][2] = 0 + 2 = 2`, `arr[1][0] = 1 + 0 = 1`, `arr[1][1] = 1 + 1 = 2`, `arr[1][2] = 1 + 2 = 3`.

---
### Q064　Arrays, Generics, and Collections

Which of the following generic method definitions correctly declares a method that returns the first element of a given array?

**選項：**
- A.  ```java public static T getFirstElement(T[] array) { return array[0]; } ``` 
- B.  ```java public static <T> T getFirstElement(T[] array) { return array[0]; } ``` （✓ 正確）
- C.  ```java public static <T> getFirstElement(T[] array) { return array[0]; } ``` 
- D.  ```java public static <T> T[] getFirstElement(T[] array) { return array[0]; } ```  

**答：B。**

**解析：**

**Explanation:**

- **A)** 
```java
public static T getFirstElement(T[] array) {
    return array[0];
}
```
  - This option is incorrect because the generic type `<T>` is missing before the return type `T`.

- **B)** 
```java
public static <T> T getFirstElement(T[] array) {
    return array[0];
}
```
  - This is the correct answer. The generic type `<T>` is correctly declared before the return type `T`.

- **C)** 
```java
public static <T> getFirstElement(T[] array) {
    return array[0];
}
```
  - This option is incorrect because the return type `T` is missing.

- **D)** 
```java
public static <T> T[] getFirstElement(T[] array) {
    return array[0];
}
```
  - This option is incorrect because the return type is `T[]`, which does not match the intended method return type.

---
### Q065　Arrays, Generics, and Collections

What is the result of compiling and running the following code?

**選項：**
```java
import java.util.*;
public class WildcardTest {
    public static void printList(List<? extends Number> list) {
        for (Number n : list) {
            System.out.print(n + " ");
        }
        System.out.println();
    }
    public static void main(String[] args) {
        List<Integer> ints = Arrays.asList(1, 2, 3);
        List<Double> doubles = Arrays.asList(1.1, 2.2, 3.3);
        List<String> strings = Arrays.asList("one", "two", "three");
        printList(ints);
        printList(doubles);
        printList(strings);
    }
}
```
- A. The code compiles and prints: ``` 1 2 3 1.1 2.2 3.3 one two three ``` 
- B. The code compiles and prints: ``` 1 2 3 1.1 2.2 3.3 ``` 
- C. The code does not compile due to an error in the `printList` method.  
- D. The code does not compile due to an error in the `main` method.  （✓ 正確）
- E. The code compiles but throws a runtime exception when executed.    

**答：D。**

**解析：**

**Explanation:**

**A)** The code compiles and prints:
```
1 2 3
1.1 2.2 3.3
one two three
```
  - This option is incorrect. The code does not compile, so it cannot produce any output.

**B)** The code compiles and prints:
```
1 2 3
1.1 2.2 3.3
```
  - This option is incorrect. While this would be the output if the `printList(strings)` line were removed, the code as written does not compile.

**C)** The code does not compile due to an error in the `printList` method.
  - This option is incorrect. The `printList` method is correctly defined using an upper bound wildcard `<? extends Number>`.

**D)** The code does not compile due to an error in the `main` method.
  - This option is correct. The code fails to compile due to an error in the `main` method. `printList(strings)` causes a compilation error because `String` is not a subclass of `Number`.

**E)** The code compiles but throws a runtime exception when executed.
  - This option is incorrect. The code fails to compile so it cannot be executed.

---
### Q066　Arrays, Generics, and Collections

What is the output of the following program?

**選項：**
```java
import java.util.*;
public class ListExample {
    public static void main(String[] args) {
        List<String> list = new ArrayList<>(Arrays.asList("A", "B", "C", "D"));
        list.add(2, "E");
        System.out.println(list);
    }
}
```
- A. `[A, B, E, C, D]`  （✓ 正確）
- B. `[A, E, B, C, D]`  
- C. `[A, B, C, E, D]`  
- D. `[A, B, C, D, E]`  
- E. `[A, C, B, E, D]`  

**答：A。**

**解析：**

**Explanation:**

- **A)** `[A, B, E, C, D]`
  - This option is correct. The `add` method with an index parameter inserts the specified element at the specified position in the list. All elements after the specified position are shifted to the right. Hence, `"E"` is inserted at index 2, pushing `"C"` and `"D"` to the right.

- **B)** `[A, E, B, C, D]`
  - This option is incorrect. This would be the result if `"E"` were added at index 1, not index 2.

- **C)** `[A, B, C, E, D]`
  - This option is incorrect. This would be the result if `"E"` were added at index 3, not index 2.

- **D)** `[A, B, C, D, E]`
  - This option is incorrect. This would be the result if `"E"` were added at the end of the list, not at index 2.

- **E)** `[A, C, B, E, D]`
  - This option is incorrect. This sequence does not follow the proper behavior of the `add` method with index 2. It seems like a random shuffle and doesn't correspond to how elements are shifted when a new element is added.

---
### Q067　Arrays, Generics, and Collections

Which of the following statements about the `Set` interface are true? (Choose all that apply.)

**選項：**
- A. A `Set` allows duplicate elements.  
- B. Elements in a `Set` are maintained in the order they were inserted.  
- C. The `Set` interface includes methods for adding, removing, and checking the presence of elements.  （✓ 正確）
- D. The `Set` interface is implemented by classes like `HashSet`, `LinkedHashSet`, and `TreeSet`.  （✓ 正確）
- E. A `Set` guarantees constant-time performance for the basic operations (add, remove, contains).  

**答：C、D。**

**解析：**

**Explanation:**

- **A)** A `Set` allows duplicate elements.
  - This option is incorrect. One of the primary characteristics of a `Set` is that it does not allow duplicate elements. Each element must be unique.

- **B)** Elements in a `Set` are maintained in the order they were inserted.
  - This option is incorrect. The ordering of elements depends on the specific implementation of the `Set` interface. For example, `HashSet` does not maintain any order, while `LinkedHashSet` maintains insertion order, and `TreeSet` maintains a sorted order.

- **C)** The `Set` interface includes methods for adding, removing, and checking the presence of elements.
  - This option is correct. The `Set` interface provides methods such as `add()`, `remove()`, and `contains()` to manage its elements.

- **D)** The `Set` interface is implemented by classes like `HashSet`, `LinkedHashSet`, and `TreeSet`.
  - This option is correct. `HashSet`, `LinkedHashSet`, and `TreeSet` are all concrete implementations of the `Set` interface, each with different characteristics regarding order and performance.

- **E)** A `Set` guarantees constant-time performance for the basic operations (add, remove, contains).
  - This option is incorrect. This statement is true for `HashSet` specifically, which provides average constant-time performance for these operations. However, it is not true for all `Set` implementations. For example, `TreeSet` provides logarithmic time performance for these operations because it is based on a Red-Black tree.

---
### Q068　Arrays, Generics, and Collections

What will be the output of the following program?

**選項：**
```java
import java.util.*;
public class DequeExample {
    public static void main(String[] args) {
        Deque<String> deque = new ArrayDeque<>();
        deque.addFirst("A");
        deque.addLast("B");
        deque.addFirst("C");
        deque.addLast("D");
        System.out.println(deque);
    }
}
```
- A. `[A, B, C, D]`  
- B. `[C, B, A, D]`  
- C. `[C, A, B, D]`  （✓ 正確）
- D. `[D, B, A, C]`  
- E. `[A, C, B, D]`  

**答：C。**

**解析：**

**Explanation:**

- **A)** `[A, B, C, D]`
  - This option is incorrect.This option ignores the order in which elements are added to the deque. It simply lists elements in the order they appear to be added without considering the `addFirst` and `addLast` methods.

- **B)** `[C, B, A, D]`
  - This option is incorrect. This option incorrectly assumes `"A"` is added after `"B"`, howerver, `addFirst("A")` puts `"A"` at the second position.

- **C)** `[C, A, B, D]`
  - This option is correct. This is indeed the correct output. The method `addFirst("C")` puts "C" at the front, `addFirst("A")` puts `"A"` at the second position, `addLast("B")` adds `"B"` after `"A"`, and `addLast("D")` adds `"D"` at the end. Thus, the final order is `[C, A, B, D]`.

- **D)** `[D, B, A, C]`
  - This option is incorrect. This option shows the reverse order, which does not match how elements are actually added to the deque.

- **E)** `[A, C, B, D]`
  - This option is incorrect. This option incorrectly assumes `"A"` is added before `"C"` despite `addFirst("C")` being called after `addFirst("A")`.

---
### Q069　Arrays, Generics, and Collections

What will be the output of the following program?

**選項：**
```java
import java.util.*;
public class MapExample {
    public static void main(String[] args) {
        Map<Integer, String> map = new HashMap<>();
        map.put(1, "A");
        map.put(2, "B");
        map.put(3, "C");
        map.put(2, "D");
        System.out.println(map);
    }
}
```
- A. `{1=A, 2=B, 3=C, 2=D}`  
- B. `{1=A, 2=B, 3=C}`  
- C. `{1=A, 2=D, 3=C, 2=D}`  
- D. `{1=A, 2=D, 3=C}`  （✓ 正確）
- E. `{1=A, 3=C, 2=B}`  

**答：D。**

**解析：**

**Explanation:**

- **A)** `{1=A, 2=B, 3=C, 2=D}`
  - This option is incorrect. This option suggests that the map would keep duplicate keys, which is not true for a `Map`. A key can only have one value associated with it at a time.

- **B)** `{1=A, 2=B, 3=C}`
  - This option is incorrect. This option ignores the fact that the value associated with key `2` is updated from `"B"` to `"D"`.

- **C)** `{1=A, 2=D, 3=C, 2=D}`
  - This option is incorrect. This option again suggests that the map can have duplicate keys, which it cannot.

- **D)** `{1=A, 2=D, 3=C}`
  - This option is correct. The `put` method updates the value associated with a key if the key already exists in the map. Therefore, the value associated with key `2` is updated from `"B"` to `"D"`.

- **E)** `{1=A, 3=C, 2=B}`
  - This option is incorrect. This option ignores the update to the value associated with key `2` from `"B"` to `"D"`.

---
### Q070　Arrays, Generics, and Collections

What is the result of running the following program?

**選項：**
```java
import java.util.*;
public class ComparableExample {
    public static void main(String[] args) {
        List<Person> people = new ArrayList<>();
        people.add(new Person("Alice", 30));
        people.add(new Person("Bob", 25));
        people.add(new Person("Charlie", 35));
        Collections.sort(people);
        for (Person p : people) {
            System.out.println(p.getName() + " " + p.getAge());
        }
    }
}
class Person implements Comparable<Person> {
    private String name;
    private int age;
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    public String getName() {
        return name;
    }
    public int getAge() {
        return age;
    }
    @Override
    public int compareTo(Person other) {
        return Integer.compare(this.age, other.age);
    }
}
```
- A.  ``` Alice 30 Bob 25 Charlie 35 ``` 
- B.  ``` Charlie 35 Alice 30 Bob 25 ``` 
- C.  ``` Bob 25 Alice 30 Charlie 35 ``` （✓ 正確）
- D.  ``` Bob 25 Charlie 35 Alice 30 ``` 
- E.  ``` Alice 30 Charlie 35 Bob 25 ```  

**答：C。**

**解析：**

**Explanation:**

- **A)**
```
Alice 30  
Bob 25  
Charlie 35
```
  - This option is incorrect. This option lists the elements in their original order, not the sorted order based on age.

- **B)** 
```
Charlie 35  
Alice 30  
Bob 25
```
  - This option is incorrect. This option lists the elements in descending order of age, but the `compareTo` method sorts in ascending order of age.

- **C)** 
```
Bob 25  
Alice 30  
Charlie 35
```
  - This option is correct. The `compareTo` method sorts the `Person` objects in ascending order based on their age. Hence, the sorted order is `Bob (25)`, `Alice (30)`, and `Charlie (35)`.

- **D)** 
```
Bob 25  
Charlie 35  
Alice 30
```
  - This option is incorrect. This option does not correctly follow the ascending order of age.

- **E)** 
```
Alice 30  
Charlie 35  
Bob 25
```
  - This option is incorrect. This option does not correctly follow the ascending order of age.

**9 .The correct answer is A.**

**Explanation:**

- **A)** 
```
Bob 25  
Alice 30  
Charlie 35
```
  - This option is incorrect. The `AgeComparator` sorts the `Person` objects in ascending order based on their age. Hence, the sorted order is `Bob (25)`, `Alice (30)`, and `Charlie (35)`.

- **B)** 
```
Charlie 35  
Alice 30  
Bob 25
```
  - This option is incorrect. This option lists the elements in descending order of age, but the `AgeComparator` sorts in ascending order of age.

- **C)** 
```
Alice 30  
Bob 25  
Charlie 35
```
  - This option is incorrect. This option does not correctly follow the ascending order of age.

- **D)** 
```
Bob 25  
Charlie 35  
Alice 30
```
  - This option is incorrect. This option does not correctly follow the ascending order of age.

- **E)** 
```
Alice 30  
Charlie 35  
Bob 25
```
  - This option is incorrect. This option does not correctly follow the ascending order of age.

---
### Q071　Arrays, Generics, and Collections

What will be the output of the following program when using the provided `Comparator`?

**選項：**
```java
import java.util.*;
public class ComparatorExample {
    public static void main(String[] args) {
        List<Person> people = new ArrayList<>();
        people.add(new Person("Alice", 30));
        people.add(new Person("Bob", 25));
        people.add(new Person("Charlie", 35));
        Collections.sort(people, new AgeComparator());
        for (Person p : people) {
            System.out.println(p.getName() + " " + p.getAge());
        }
    }
}
class Person {
    private String name;
    private int age;
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    public String getName() {
        return name;
    }
    public int getAge() {
        return age;
    }
}
class AgeComparator implements Comparator<Person> {
    @Override
    public int compare(Person p1, Person p2) {
        return Integer.compare(p1.getAge(), p2.getAge());
    }
}
```
- A.  ``` Bob 25 Alice 30 Charlie 35 ``` 
- B.  ``` Charlie 35 Alice 30 Bob 25 ``` 
- C.  ``` Alice 30 Bob 25 Charlie 35 ``` 
- D.  ``` Bob 25 Charlie 35 Alice 30 ``` 
- E.  ``` Alice 30 Charlie 35 Bob 25 ```  

**答：**（原書 ch06 a 未提供本題解答）

| 第 07 章 | Error Handling and Exceptions | 8 |
---
### Q072　Error Handling and Exceptions

Which of the following statements correctly describes a checked exception in Java?

**選項：**
**A.** A checked exception is a type of exception that inherits from the `java.lang.RuntimeException` class.  
**B.** A checked exception must be either caught or declared in the method signature using the `throws` keyword.  
**C.** A checked exception is an error that is typically caused by the environment in which the application is running, and it cannot be handled by the application.  
**D.** A checked exception can be thrown by the Java Virtual Machine when a severe error occurs, such as an out-of-memory error.

**答：B。**

**解析：**

**Explanation:**

- **A.** A checked exception is a type of exception that inherits from the `java.lang.RuntimeException` class.
  - This option is incorrect. A checked exception does not inherit from `java.lang.RuntimeException`. Checked exceptions are subclasses of `java.lang.Exception` but not of `java.lang.RuntimeException`.

- **B.** A checked exception must be either caught or declared in the method signature using the `throws` keyword.
  - This option is correct. Checked exceptions must be either caught using a `try-catch` block or declared in the method signature with the `throws` keyword. This is to ensure that the exception is properly handled at some point in the code.

- **C.** A checked exception is an error that is typically caused by the environment in which the application is running, and it cannot be handled by the application.
  - This option is incorrect. It describes errors more accurately than checked exceptions. Errors are typically caused by the environment and are not expected to be handled by the application.

- **D.** A checked exception can be thrown by the Java Virtual Machine when a severe error occurs, such as an out-of-memory error.
  - This option is incorrect. It describes errors rather than checked exceptions. Errors like out-of-memory errors are thrown by the JVM and are not meant to be caught or handled by applications in most cases.

---
### Q073　Error Handling and Exceptions

Which of the following code snippets correctly defines and throws a custom checked exception?

**選項：**
```java
public class CustomException extends Exception {
    public CustomException(String message) {
        super(message);
    }
}
public class TestCustomException {
    public static void main(String[] args) {
        try {
            methodThatThrowsException();
        } catch (CustomException e) {
            System.out.println(e.getMessage());
        }
    }
    public static void methodThatThrowsException() throws CustomException {
        throw new CustomException("This is a custom checked exception");
    }
}
```
**A.** This code defines a custom checked exception and correctly throws and handles it.  
**B.** This code defines a custom unchecked exception.  
**C.** This code will not compile because the custom exception is not declared correctly in the method signature.  
**D.** This code will compile but will not throw the custom exception at runtime.

**答：A。**

**解析：**

**Explanation:**

- **A.** This code defines a custom checked exception and correctly throws and handles it.
  - This option is correct. The code defines a custom checked exception by extending `Exception`. The `methodThatThrowsException` method throws this custom exception, which is then caught and handled in the `main` method.

- **B.** This code defines a custom unchecked exception. 
  - This option is incorrect. The code extends `Exception`, not `RuntimeException`, making it a checked exception rather than an unchecked one.

- **C.** This code will not compile because the custom exception is not declared correctly in the method signature.
  - This option is incorrect. The custom exception is correctly declared in the method signature of `methodThatThrowsException`, so it will compile without issues.

- **D.** This code will compile but will not throw the custom exception at runtime.
  - This option is incorrect. The code will throw the custom exception at runtime as expected, and it will be caught and handled in the `catch` block.

---
### Q074　Error Handling and Exceptions

Given the following class, what is the result?

**選項：**
```java
public class Main {
    protected static int myMethod() {
        try {
            throw new RuntimeException();
        } catch(RuntimeException e) {
             return 1;
        } finally {
             return 2;
        }
    }
    public static void main(String[] args) {
        System.out.println(myMethod());
    }
}
```
**A.** `1`  
**B.** `2`  
**C.** Compilation fails  
**D.** An exception occurs at runtime

**答：B。**

**解析：**

**Explanation:**

- **A.** `1`
  - This option is incorrect. Although the `catch` block returns `1`, the `finally` block will override this return value with `2`.

- **B.** `2`
  - This option is correct. The `finally` block always executes and its return value overrides the return value from the `catch` block, resulting in `2` being printed.

- **C.** Compilation fails
  - This option is incorrect. The code compiles without any errors.

- **D.** An exception occurs at runtime
  - This option is incorrect. While a `RuntimeException` is thrown in the `try` block, it is caught by the `catch` block, and no exception propagates to cause a runtime error.

---
### Q075　Error Handling and Exceptions

Given the following class, which of the following statement is true?

**選項：**
```java
public class Main {
    public static void main(String[] args) {
        try {
            // Do nothing
        } finally {
            // Do nothing
        }
    }
}
```
**A.** The code doesn't compile correctly.  
**B.** The code would compile correctly if we add a `catch` block.  
**C.** The code would compile correctly if we remove the `finally` block.  
**D.** The code compiles correctly as it is.

**答：D。**

**解析：**

**Explanation:**

- **A.** The code doesn't compile correctly.
  - This option is incorrect. The code does compile correctly. A `try` block can be followed by a `finally` block without a `catch` block.

- **B.** The code would compile correctly if we add a `catch` block.
  - This option is incorrect. While adding a `catch` block is valid, it is not necessary for the code to compile. The `try` block can be used with only a `finally` block.

- **C.** The code would compile correctly if we remove the `finally` block.
  - This option is incorrect. Removing the `finally` block is not necessary for the code to compile. The code is valid with the `finally` block present.

- **D.** The code compiles correctly as it is.
  - This option is correct. The code compiles correctly as it is. A `try` block must be followed by either a `catch` block, a `finally` block, or both. 

---
### Q076　Error Handling and Exceptions

Which of the following statements are true? (Choose all that apply)

**選項：**
**A.** In a `try-with-resources`, the `catch` block is required.  
**B.** The `throws` keyword is used to throw an exception.  
**C.** In a `try-with-resources` block, if you declare more than one resource, they have to be separated by a semicolon.  
**D.** If a `catch` block is defined for an exception that couldn't be thrown by the code in the `try` block, a compile-time error is generated.

**答：C、D。**

**解析：**

**Explanation:**

- **A.** In a `try-with-resources`, the `catch` block is required.
  - This option is incorrect. In a `try-with-resources` statement, the catch block is optional. The primary purpose of `try-with-resources` is to ensure that each resource is closed at the end of the statement, whether an exception is thrown or not.

- **B.** The `throws` keyword is used to throw an exception. 
  - This option is incorrect. The `throws` keyword is used in method declarations to specify that the method can throw an exception, not to throw an exception. The `throw` keyword is used to actually throw an exception.

- **C.** In a `try-with-resources` block, if you declare more than one resource, they have to be separated by a semicolon.
  - This option is correct. In a `try-with-resources` block, if you declare more than one resource, they must be separated by a semicolon.

- **D.** If a `catch` block is defined for an exception that couldn't be thrown by the code in the `try` block, a compile-time error is generated.
  - This option is correct. If a `catch` block is defined for an exception that cannot be thrown by the code in the `try` block, the compiler will generate an error because the `catch` block is unreachable.

---
### Q077　Error Handling and Exceptions

Given the following class, what is the result?:

**選項：**
```java
class Connection implements java.io.Closeable {
    public void close() throws IOException {
        throw new IOException("Close Exception");
    }
}
public class Main {
    public static void main(String[] args) {
        try (Connection c = new Connection()) {
            throw new RuntimeException("RuntimeException");
        } catch (IOException e) {
            System.err.println(e.getMessage());
        }
    }
}
```
**A.** `Close Exception`  
**B.** `RuntimeException`  
**C.** `RuntimeException` and then `CloseException`  
**D.** Compilation fails  
**E.** The stack trace of an uncaught exception is printed

**答：E。**

**解析：**

**Explanation:**

- **A.** `Close Exception`
  - This option is incorrect. While the `IOException` from `close()` will occur, it will be suppressed by the `RuntimeException`.

- **B.** `RuntimeException`
  - This option is incorrect. The primary exception is `RuntimeException`, but it will not print its message directly because the catch block does not handle it.

- **C.** `RuntimeException` and then `CloseException` 
  - This option is incorrect. Although both exceptions occur, the `RuntimeException` is primary, and the `IOException` is suppressed. Both messages are not printed in sequence.

- **D.** Compilation fails
  - This option is incorrect. The code compiles without any errors.

- **E.** The stack trace of an uncaught exception is printed.
  - This option is correct. The `RuntimeException` thrown in the try block is not caught by the `catch (IOException e)` block. Hence, the stack trace of the `RuntimeException` is printed.

---
### Q078　Error Handling and Exceptions

Which of the following exceptions are direct subclasses of `RuntimeException`?

**選項：**
**A.** `java.io.FileNotFoundException`  
**B.** `java.lang.ArithmeticException`  
**C.** `java.lang.ClassCastException`  
**D.** `java.lang.InterruptedException`

**答：B、C。**

**解析：**

**Explanation:**

- **A.** `java.io.FileNotFoundException` is incorrect. It is a subclass of `java.io.IOException`, which in turn is a subclass of `java.lang.Exception`, making it a checked exception.

- **B.** `java.lang.ArithmeticException` is correct. It is a direct subclass of `java.lang.RuntimeException` and represents arithmetic errors such as division by zero.

- **C.** `java.lang.ClassCastException` is correct. It is a direct subclass of `java.lang.RuntimeException` and indicates an invalid cast operation.

- **D.** `java.lang.InterruptedException` is incorrect. It is a direct subclass of `java.lang.Exception`, making it a checked exception. It indicates that a thread has been interrupted.

---
### Q079　Error Handling and Exceptions

Given the following code, what is the result?

**選項：**
```java
class MyResource implements AutoCloseable {
    public void close() {
        throw new RuntimeException("Close Exception");
    }
}
public class Main {
    public static void main(String[] args) {
        try (MyResource resource = new MyResource()) {
            throw new RuntimeException("Try Block Exception");
        } catch (RuntimeException e) {
            Throwable[] suppressed = e.getSuppressed();
            if (suppressed.length > 0) {
                for (Throwable t : suppressed) {
                    System.out.println("Suppressed: " + t.getMessage());
                }
            } else {
                System.out.println(e.getMessage());
            }
        }
    }
}
```
**A.** Only `"Try Block Exception"` is printed.  
**B.** Only `"Close Exception"` is printed.  
**C.** Both `"Try Block Exception"` and `"Close Exception"` are printed.  
**D.** `"Suppressed: Close Exception"` is printed.  

**答：D。**

**解析：**

**Explanation:**

- **A.** Only `"Try Block Exception"` is printed.
  - This option is incorrect. The `Try Block Exception` is the main exception and is not directly printed because the `catch` block checks for suppressed exceptions first.

- **B.** Only `"Close Exception"` is printed.
  - This option is incorrect. The `Close Exception` is not directly printed; it is suppressed and accessed via the `getSuppressed` method.

- **C.** Both `"Try Block Exception"` and `"Close Exception"` are printed.
  - This option is incorrect. The code only prints suppressed exceptions, not the main exception message directly.

- **D.** `"Suppressed: Close Exception"` is printed.
  - This option is correct. The `RuntimeException` thrown in the `try` block is the main exception, and the `RuntimeException` from the `close` method is suppressed. The `catch` block prints the suppressed exception message, `"Suppressed: Close Exception"`.

| 第 08 章 | Functional Interfaces and Lambda Expressions | 5 |
---
### Q080　Functional Interfaces and Lambda Expressions

Which of the following statements are true about functional interfaces in Java? (Choose all that apply.)

**選項：**
- A. A functional interface can have multiple `abstract` methods.  
- B. A functional interface can have default and `static` methods.  （✓ 正確）
- C. The `@FunctionalInterface` annotation is mandatory to declare a functional interface.  
- D. Lambda expressions can be used to instantiate functional interfaces.   （✓ 正確）

**答：B、D。**

**解析：**

**Explanation:**

- **A)** A functional interface can have multiple `abstract` methods.
  - This option is incorrect. A functional interface can have only one abstract method. Having multiple abstract methods would disqualify it from being a functional interface.

- **B)** A functional interface can have default and `static` methods.
  - This option is correct. A functional interface is allowed to have default and static methods, which are not counted as abstract methods.

- **C)** The `@FunctionalInterface` annotation is mandatory to declare a functional interface. 
  - This option is incorrect. The `@FunctionalInterface` annotation is not mandatory; it is only a marker to indicate that the interface is intended to be a functional interface. An interface can be a functional interface without this annotation as long as it has exactly one abstract method.

- **D)** Lambda expressions can be used to instantiate functional interfaces.
  - This option is correct. Lambda expressions are used to provide implementations for the single abstract method of a functional interface, making them a key feature for functional programming in Java.

---
### Q081　Functional Interfaces and Lambda Expressions

Which of the following lambda expressions correctly implements the `Comparator<String>` interface?

**選項：**
```java
Comparator<String> comparator = /* lambda expression */;
```
- A. `(s1, s2) -> s1.compareTo(s2)`  （✓ 正確）
- B. `(String s1, s2) -> s1.compareTo(s2)`  
- C. `s1, s2 -> s1.compareTo(s2)`  
- D. `(s1, s2) -> return s1.compareTo(s2);`  
- E. `(s1, s2) -> { s1.compareTo(s2); }`   

**答：A。**

**解析：**

**Explanation:**

- **A)** `(s1, s2) -> s1.compareTo(s2)`
  - This option is correct. This lambda expression correctly implements the `Comparator<String>` interface. It uses the correct syntax for a lambda expression, with parameters enclosed in parentheses and a single expression for the body.

- **B)** `(String s1, s2) -> s1.compareTo(s2)`
  - This option is incorrect. The syntax is invalid because if you specify the type of one parameter, you must specify the type for all parameters. It should be `(String s1, String s2)`.

- **C)** `s1, s2 -> s1.compareTo(s2)`
  - This option is incorrect. Parameters must be enclosed in parentheses. The correct syntax is `(s1, s2)`.

- **D)** `(s1, s2) -> return s1.compareTo(s2);`
  - This option is incorrect. When using a return statement, you must also include curly braces.

- **E)** `(s1, s2) -> { s1.compareTo(s2); }`
  - This option is incorrect. When using curly braces, you must include a return statement for expressions that return a value. The correct syntax would be `(s1, s2) -> { return s1.compareTo(s2); }`.

---
### Q082　Functional Interfaces and Lambda Expressions

Which of the following Java built-in lambda interfaces represents a function that accepts two arguments and produces a result?

**選項：**
- A. `java.util.function.Function`  
- B. `java.util.function.BiFunction`  （✓ 正確）
- C. `java.util.function.Supplier`  
- D. `java.util.function.Consumer`  
- E. `java.util.function.Predicate`   

**答：B。**

**解析：**

**Explanation:**

- **A)** `java.util.function.Function`
  - This option is incorrect. `Function` represents a function that takes one argument and produces a result.

- **B)** `java.util.function.BiFunction`
  - This option is correct. `BiFunction` represents a function that takes two arguments and produces a result.

- **C)** `java.util.function.Supplier`
  - This option is incorrect. `Supplier` represents a function that takes no arguments and produces a result.

- **D)** `java.util.function.Consumer`
  - This option is incorrect. `Consumer` represents a function that takes one argument and does not produce a result.

- **E)** `java.util.function.Predicate`
  - This option is incorrect. `Predicate` represents a function that takes one argument and returns a `boolean` value.

---
### Q083　Functional Interfaces and Lambda Expressions

What is the output of the following code?

**選項：**
```java
import java.util.function.Function;
public class Main {
    public static void main(String[] args) {
        Function<Integer, Integer> multiplyByTwo = x -> x * 2;
        Function<Integer, Integer> addThree = x -> x + 3;
        Function<Integer, Integer> combinedFunction = multiplyByTwo.andThen(addThree);
        System.out.println(combinedFunction.apply(5));
    }
}
```
- A. `13`  （✓ 正確）
- B. `16`  
- C. `10`  
- D. `11`  
- E. `8`   

**答：A。**

**解析：**

**Explanation:**

- **A)** `13`
  - This option is correct. The `combinedFunction` first multiplies 5 by 2 to get 10, then adds 3, resulting in 13.

- **B)** `16`
  - This option is incorrect. It incorrectly assumes that 5 is added after doubling and doubling again.

- **C)** `10`
  - This option is incorrect. It represents only the result of the first function without applying the second function.

- **D)** `11`
  - This option is incorrect. It seems to mistakenly represent 5 plus the first function (double).

- **E)** `8`
  - This option is incorrect. It seems to incorrectly represent the input value doubled without adding 3.

---
### Q084　Functional Interfaces and Lambda Expressions

Which of the following method references correctly replaces the lambda expression in the code below?

**選項：**
```java
import java.util.function.Function;
public class Main {
    public static void main(String[] args) {
        Function<String, Integer> func = str -> Integer.parseInt(str);
        System.out.println(func.apply("123"));
    }
}
```
- A. `String::valueOf`  
- B. `Integer::valueOf`  
- C. `Integer::parseInt`  （✓ 正確）
- D. `String::parseInt`  
- E. `Integer::toString` 

**答：C。**

**解析：**

**Explanation:**

- **A)** `String::valueOf` 
  - This option is incorrect. `String::valueOf` converts an integer to a string, not a string to an integer.

- **B)** `Integer::valueOf`
  - This option is incorrect. `Integer::valueOf` returns an `Integer` object, while the lambda returns an `int`.

- **C)** `Integer::parseInt`
  - This option is correct. `Integer::parseInt` is a method reference that matches the lambda expression `str -> Integer.parseInt(str)` which converts a string to an integer.

- **D)** `String::parseInt`
  - This option is incorrect. `String` class does not have a `parseInt` method.

- **E)** `Integer::toString`
  - This option is incorrect. `Integer::toString` converts an integer to a string, not a string to an integer.

| 第 09 章 | Streams | 9 |
---
### Q085　Streams

Which of the following lines of code demonstrates the use of the `Optional` class to handle a potentially `null` value to avoid an exception?

**選項：**
```java
import java.util.Optional;
public class Main {
    public static void main(String[] args) {
        String value = getValue();
        // Insert code here
    }
    public static String getValue() {
        return null; // This method may return null
    }
}
```
- A. `Optional<String> optional = new Optional<>(value);`  
- B. `Optional<String> optional = Optional.of(value);`  
- C. `Optional<String> optional = Optional.ofNullable(value);`  （✓ 正確）
- D. `Optional<String> optional = Optional.empty(value);`  
- E. `Optional<String> optional = Optional.nullable(value);`   

**答：C。**

**解析：**

**Explanation:**

- **A)** `Optional<String> optional = new Optional<>(value);`
  - This option is incorrect because `Optional` does not have a public constructor. Instead, static factory methods like `of` and `ofNullable` should be used.

- **B)** `Optional<String> optional = Optional.of(value);`
  - This option is incorrect because `Optional.of(value)` throws a `NullPointerException` if `value` is `null`. In this scenario, since `getValue()` can return `null`, this line could lead to an exception.

- **C)** `Optional<String> optional = Optional.ofNullable(value);`
  - This option is correct because `Optional.ofNullable(value)` will return an `Optional` describing the specified value if non-null, or an empty `Optional` if the value is `null`. This is the appropriate way to handle a potentially `null` value.

- **D)** `Optional<String> optional = Optional.empty(value);`
  - This option is incorrect because `Optional.empty()` does not accept any arguments. It simply returns an empty `Optional`.

- **E)** `Optional<String> optional = Optional.nullable(value);`
  - This option is incorrect because there is no method `nullable` in the `Optional` class. The correct method for this purpose is `ofNullable`. 

---
### Q086　Streams

Which of the following lines of code correctly demonstrates the use of a terminal operation?

**選項：**
```java
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
public class Main {
    public static void main(String[] args) {
        List<String> list = List.of("apple", "banana", "cherry", "date");
        Stream<String> stream = list.stream()
                                    .filter(s -> s.length() > 5)
                                    .peek(System.out::println)
                                    .map(String::toUpperCase);
        // Insert terminal operation here
    }
}
```
- A. `stream.filter(s -> s.contains("A"));`  
- B. `stream.map(String::toLowerCase);`  
- C. `stream.distinct();`  
- D. `stream.limit(2);`  
- E. `stream.collect(Collectors.toList());`  （✓ 正確）

**答：E。**

**解析：**

**Explanation:**

- **A)** `stream.filter(s -> s.contains("A"));` 
  - This option is incorrect because `filter` is an intermediate operation. It returns a new stream with elements that match the given predicate.

- **B)** `stream.map(String::toLowerCase);`
  - This option is incorrect because `map` is an intermediate operation. It returns a new stream with elements that are the results of applying the given function.

- **C)** `stream.distinct();`
  - This option is incorrect because `distinct` is an intermediate operation. It returns a new stream with distinct elements.

- **D)** `stream.limit(2);`
  - This option is incorrect because `limit` is an intermediate operation. It returns a new stream that is truncated to be no longer than the given size.

- **E)** `stream.collect(Collectors.toList());`
  - This option is correct because `collect` is a terminal operation. It triggers the processing of the stream and collects the elements into a `List`.

---
### Q087　Streams

Which of the following lines of code correctly uses a primitive stream to calculate the sum of an array of integers?

**選項：**
```java
import java.util.stream.IntStream;
public class Main {
    public static void main(String[] args) {
        int[] numbers = {1, 2, 3, 4, 5};
        // Insert code here to calculate sum
    }
}
```
- A. `int sum = numbers.stream().sum();`  
- B. `int sum = IntStream.range(0, numbers.length).sum();`  
- C. `int sum = IntStream.from(numbers).sum();`  
- D. `int sum = IntStream.of(numbers).sum();`  （✓ 正確）
- E. `int sum = IntStream.range(numbers).sum();`  

**答：D。**

**解析：**

**Explanation:**

- **A)** `int sum = numbers.stream().sum();` 
  - This option is incorrect because arrays do not have a `stream` method directly on them. You need to use a method from a utility class like `IntStream` to create a stream.

- **B)** `int sum = IntStream.range(0, numbers.length).sum();` 
  - This option is incorrect because `IntStream.range(0, numbers.length)` generates a stream of integers from 0 to the length of the array, not the elements of the array itself.

- **C)** `int sum = IntStream.from(numbers).sum();`
  - This option is incorrect because `IntStream` does not have a `from` method. The correct method is `of`.

- **D)** `int sum = IntStream.of(numbers).sum();`
  - This option is correct because `IntStream.of(numbers).sum()` correctly creates an `IntStream` from the array and calculates the sum of its elements.

- **E)** `int sum = IntStream.range(numbers).sum();`
  - This option is incorrect because `IntStream.range` requires two arguments (a start and an end index) and is used to generate a stream of numbers within a range, not to sum an array.

---
### Q088　Streams

Which of the following lines of code correctly filters a stream to include only strings with a length greater than 3?

**選項：**
```java
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
public class Main {
    public static void main(String[] args) {
        List<String> list = List.of("one", "two", "three", "four");
        Stream<String> stream = list.stream();
        // Insert code here to filter the stream
    }
}
```
- A. `Stream<String> filteredStream = stream.filter(s -> s.length() > 3);`  （✓ 正確）
- B. `Stream<String> filteredStream = stream.map(s -> s.length() > 3);`  
- C. `Stream<String> filteredStream = stream.collect(Collectors.filtering(s -> s.length() > 3));`  
- D. `Stream<String> filteredStream = stream.filtering(s -> s.length() > 3);`  
- E. `Stream<String> filteredStream = stream.filterByLength(3);`  

**答：A。**

**解析：**

**Explanation:**

- **A)** `Stream<String> filteredStream = stream.filter(s -> s.length() > 3);`  
  - This option is correct because `filter` is the correct intermediate operation to apply a predicate to each element of the stream and return a new stream containing only elements that match the predicate.

- **B)** `Stream<String> filteredStream = stream.map(s -> s.length() > 3);` 
  - This option is incorrect because `map` is used to transform elements of the stream and does not filter them. The result would be a stream of `Boolean` values instead of the original strings.

- **C)** `Stream<String> filteredStream = stream.collect(Collectors.filtering(s -> s.length() > 3));` 
  - This option is incorrect because `Collectors.filtering` is not a valid method. Filtering is done through the `filter` method on the stream itself, not via collectors.

- **D)** `Stream<String> filteredStream = stream.filtering(s -> s.length() > 3);` 
  - This option is incorrect because there is no `filtering` method on the stream. The correct method is `filter`.

- **E)** `Stream<String> filteredStream = stream.filterByLength(3);`
  - This option is incorrect because there is no `filterByLength` method on the stream. The correct method to use is `filter`.

---
### Q089　Streams

Which of the following lines of code correctly maps a stream of strings to their lengths?

**選項：**
```java
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
public class Main {
    public static void main(String[] args) {
        List<String> list = List.of("apple", "banana", "cherry", "date");
        Stream<String> stream = list.stream();
        // Insert code here to map the stream
    }
}
```
- A. `Stream<String> lengthStream = stream.map(s -> s.length());`  
- B. `Stream<String> lengthStream = stream.mapToInt(s -> s.length());`  
- C. `Stream<Integer> lengthStream = stream.map(s -> s.length());`  （✓ 正確）
- D. `IntStream lengthStream = stream.map(s -> s.length());`  
- E. `Stream<String> lengthStream = stream.flatMap(s -> Stream.of(s.length()));`   

**答：C。**

**解析：**

**Explanation:**

- **A)** `Stream<String> lengthStream = stream.map(s -> s.length());`
  - This option is incorrect because the `map` method will transform the elements to `Integer`, not `String`. The correct type for the resulting stream should be `Stream<Integer>`.

- **B)** `Stream<String> lengthStream = stream.mapToInt(s -> s.length());`
  - This option is incorrect because `mapToInt` produces an `IntStream`, not a `Stream<String>`. Additionally, the resulting stream type would not be `Stream<String>`.

- **C)** `Stream<Integer> lengthStream = stream.map(s -> s.length());`
  - This option is correct because `map` transforms each string in the stream to its length, resulting in a `Stream<Integer>`.

- **D)** `IntStream lengthStream = stream.map(s -> s.length());` 
  - This option is incorrect because `map` produces a `Stream<R>`, not an `IntStream`. The correct method for producing an `IntStream` would be `mapToInt`.

- **E)** `Stream<String> lengthStream = stream.flatMap(s -> Stream.of(s.length()));`
  - This option is incorrect because `flatMap` is used to flatten nested streams and not simply map to another type. Additionally, the resulting stream type would not be `Stream<String>`.

---
### Q090　Streams

Which of the following lines of code correctly limits the stream to the first 3 elements after skipping the first 2 elements?

**選項：**
```java
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
public class Main {
    public static void main(String[] args) {
        List<String> list = List.of("one", "two", "three", "four", "five", "six");
        Stream<String> stream = list.stream();
        // Insert code here to skip and limit the stream
    }
}
```
- A. `Stream<String> resultStream = stream.skip(2).limit(3);`  （✓ 正確）
- B. `Stream<String> resultStream = stream.limit(3).skip(2);`  
- C. `Stream<String> resultStream = stream.skip(3).limit(2);`  
- D. `Stream<String> resultStream = stream.limit(2).skip(3);`  
- E. `Stream<String> resultStream = stream.slice(2, 5);`  

**答：A。**

**解析：**

**Explanation:**

- **A)** `Stream<String> resultStream = stream.skip(2).limit(3);`
  - This option is correct because `skip(2)` skips the first 2 elements of the stream, and `limit(3)` limits the stream to the next 3 elements. Therefore, the resulting stream will contain the 3rd, 4th, and 5th elements of the original list.

- **B)** `Stream<String> resultStream = stream.limit(3).skip(2);`
  - This option is incorrect because `limit(3)` first limits the stream to the first 3 elements, and then `skip(2)` skips 2 of those elements, resulting in a stream with only the 3rd element.

- **C)** `Stream<String> resultStream = stream.skip(3).limit(2);`
  - This option is incorrect because `skip(3)` skips the first 3 elements, and `limit(2)` then limits the stream to the next 2 elements, resulting in a stream with the 4th and 5th elements.

- **D)** `Stream<String> resultStream = stream.limit(2).skip(3);`
  - This option is incorrect because `limit(2)` first limits the stream to the first 2 elements, and then `skip(3)` would attempt to skip more elements than are available, resulting in an empty stream.

- **E)** `Stream<String> resultStream = stream.slice(2, 5);`
  - This option is incorrect because there is no `slice` method in the Stream API. The correct methods to achieve the desired result are `skip` and `limit`.

---
### Q091　Streams

Which of the following lines of code correctly concatenates two streams?

**選項：**
```java
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
public class Main {
    public static void main(String[] args) {
        List<String> list1 = List.of("one", "two", "three");
        List<String> list2 = List.of("four", "five", "six");
        Stream<String> stream1 = list1.stream();
        Stream<String> stream2 = list2.stream();
        // Insert code here to concatenate the streams
    }
}
```
- A. `Stream<String> resultStream = Stream.concat(stream1, stream2.collect(Collectors.toList()));`  
- B. `Stream<String> resultStream = Stream.concat(stream1, stream2);`  （✓ 正確）
- C. `Stream<String> resultStream = stream1.concat(stream2);`  
- D. `Stream<String> resultStream = stream1.merge(stream2);`  
- E. `Stream<String> resultStream = Stream.of(stream1, stream2);`  

**答：B。**

**解析：**

**Explanation:**

- **A)** `Stream<String> resultStream = Stream.concat(stream1, stream2.collect(Collectors.toList()));`
  - This option is incorrect because `Stream.concat` expects two streams as arguments. `stream2.collect(Collectors.toList())` converts `stream2` into a `List`, not a `Stream`.

- **B)** `Stream<String> resultStream = Stream.concat(stream1, stream2);`
  - This option is correct because `Stream.concat(stream1, stream2)` correctly concatenates the two streams into a single stream containing all elements from both streams.

- **C)** `Stream<String> resultStream = stream1.concat(stream2);`
  - This option is incorrect because `Stream` does not have an instance method `concat`. The `concat` method is a static method of the `Stream` class.

- **D)** `Stream<String> resultStream = stream1.merge(stream2);`
  - This option is incorrect because there is no `merge` method in the `Stream` API. The correct method for concatenating streams is `Stream.concat`.

- **E)** `Stream<String> resultStream = Stream.of(stream1, stream2);`
  - This option is incorrect because `Stream.of(stream1, stream2)` creates a stream of streams, resulting in `Stream<Stream<String>>` rather than a single concatenated `Stream<String>`.

---
### Q092　Streams

Which of the following lines of code uses the reduce method to correctly calculate the product of all elements in a stream of integers?

**選項：**
```java
import java.util.List;
import java.util.stream.Stream;
public class Main {
    public static void main(String[] args) {
        List<Integer> numbers = List.of(1, 2, 3, 4, 5);
        Stream<Integer> stream = numbers.stream();
        // Insert code here to calculate the product
    }
}
```
- A. `int product = stream.reduce(1, (a, b) -> a + b);`  
- B. `int product = stream.reduce((a, b) -> a * b);`  
- C. `int product = stream.reduce(0, (a, b) -> a * b);`  
- D. `Optional<Integer> product = stream.reduce(1, (a, b) -> a * b);`  
- E. `int product = stream.reduce(1, (a, b) -> a * b, (a, b) -> a * b);`   （✓ 正確）

**答：E。**

**解析：**

**Explanation:**

- **A)** `int product = stream.reduce(1, (a, b) -> a + b);`
  - This option is incorrect because the reduction operation is using addition instead of multiplication. The correct operation for calculating the product should be `(a, b) -> a * b`.

- **B)** `int product = stream.reduce((a, b) -> a * b);`
  - This option is incorrect because it does not provide an identity value, which is necessary for the reduction operation when dealing with an empty stream. Without an identity value, the result is an `Optional<Integer>` rather than an `int`.

- **C)** `int product = stream.reduce(0, (a, b) -> a * b);`
  - This option is incorrect because the identity value for multiplication should be `1`, not `0`. Using `0` as the identity value would result in a product of `0` regardless of the stream elements.

- **D)** `Optional<Integer> product = stream.reduce(1, (a, b) -> a * b);`
  - This option is incorrect because the correct use of the `reduce` method with an identity value does not return an `Optional`. It should return the result directly as `int`.

- **E)** `int product = stream.reduce(1, (a, b) -> a * b, (a, b) -> a * b);`
  - This option is correct because it correctly uses the `reduce` method with an identity value of `1` and a combiner function that multiplies the results. This form of `reduce` is suitable for parallel processing as well, ensuring the product is correctly calculated across multiple segments of the stream.

---
### Q093　Streams

Which of the following lines of code correctly collects the elements of a stream into a `Set` and also ensures that the original order of the elements is maintained?

**選項：**
```java
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.LinkedHashSet;
public class Main {
    public static void main(String[] args) {
        List<String> list = List.of("apple", "banana", "cherry", "date");
        Stream<String> stream = list.stream();
        // Insert code here to collect the elements into a Set while maintaining order
    }
}
```
- A. `Set<String> resultSet = stream.collect(Collectors.toSet());`  
- B. `Set<String> resultSet = stream.collect(Collectors.toCollection(LinkedHashSet::new));`  （✓ 正確）
- C. `Set<String> resultSet = stream.collect(Collectors.toCollection(TreeSet::new));`  
- D. `Set<String> resultSet = stream.collect(Collectors.toList());`  
- E. `Set<String> resultSet = stream.collect(Collectors.toMap());`  

**答：B。**

**解析：**

**Explanation:**

- **A)** `Set<String> resultSet = stream.collect(Collectors.toSet());` 
  - This option is incorrect because `Collectors.toSet()` does not guarantee the order of the elements. The implementation returned by this collector does not preserve the order of insertion.

- **B)** `Set<String> resultSet = stream.collect(Collectors.toCollection(LinkedHashSet::new));`
  - This option is correct because `Collectors.toCollection(LinkedHashSet::new)` collects the elements into a `LinkedHashSet`, which maintains the order of insertion.

- **C)** `Set<String> resultSet = stream.collect(Collectors.toCollection(TreeSet::new));` 
  - This option is incorrect because `TreeSet` sorts the elements according to their natural ordering (or by a comparator, if provided). This does not necessarily preserve the original order of the stream elements.

- **D)** `Set<String> resultSet = stream.collect(Collectors.toList());` 
  - This option is incorrect because `Collectors.toList()` collects the elements into a `List`, not a `Set`.

- **E)** `Set<String> resultSet = stream.collect(Collectors.toMap());`
  - This option is incorrect because `Collectors.toMap()` is used to collect the elements into a `Map`, not a `Set`.

| 第 10 章 | Concurrency and Multithreading | 9 |
---
### Q094　Concurrency and Multithreading

Which of the following lines of code correctly creates and starts a new virtual thread?

**選項：**
```java
public class Main {
    public static void main(String[] args) {
        Runnable task = () -> {
            for (int i = 0; i < 5; i++) {
                System.out.println("Task is running");
            }
        };
        // Insert code here to create and start a new virtual thread
    }
}
```
- A. `Thread thread = Thread.ofVirtual(); thread.start(task);`  
- B. `Thread thread = Thread.ofVirtual().unstarted(task).run();`  
- C. `Thread thread = Thread.ofVirtual().start(task);`  （✓ 正確）
- D. `Thread thread = Thread.ofVirtual(); task.run();`  
- E. `Thread thread = Thread.start(task);`  

**答：C。**

**解析：**

**Explanation:**

- **A)** `Thread thread = Thread.ofVirtual(); thread.start(task);`
  - This option is incorrect because `Thread.ofVirtual()` returns a `Thread.Builder`, not a `Thread`. The `start()` method on `Thread.Builder` takes a `Runnable`, but this syntax is incorrect.

- **B)** `Thread thread = Thread.ofVirtual().unstarted(task).run();`
  - This option is incorrect because calling `run()` directly does not start a new thread. It executes the task in the current thread.

- **C)** `Thread thread = Thread.ofVirtual().start(task);`
  - This option is correct. It uses the new thread builder API in Java 21 to create and start a virtual thread in one step.

- **D)** `Thread thread = Thread.ofVirtual(); task.run();`
  - This option is incorrect because it doesn't actually start a new thread. It creates a thread builder but doesn't use it, and then runs the task in the current thread.

- **E)** `Thread thread = Thread.start(task);`
  - This option is incorrect because `Thread.start(task)` is not a valid static method in Java 21.

---
### Q095　Concurrency and Multithreading

Which of the options correctly uses a `synchronized` block to ensure that only one thread at a time can execute a critical section that increments a shared counter?

**選項：**
```java
public class Main {
    private static int counter = 0;
    public static void main(String[] args) {
        Runnable task = () -> {
            for (int i = 0; i < 1000; i++) {
                // Insert synchronized block here
            }
        };
        Thread thread1 = Thread.ofPlatform().start(task);
        Thread thread2 = Thread.ofPlatform().start(task);
        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Final counter value: " + counter);
    }
}
```
- A. `synchronized (this) { counter++; }`  
- B. `synchronized (Main.class) { counter++; }`  （✓ 正確）
- C. `synchronized (task) { counter++; }`  
- D. `synchronized (counter) { counter++; }`  
- E. `synchronized (System.out) { counter++; }`  

**答：B。**

**解析：**

**Explanation:**
- **A)** `synchronized (this) { counter++; }`
  - This option is incorrect because `this` cannot be used in a static context. In the `main` method, `this` is not available. For a static field like `counter`, you need to synchronize on a static object or class.

- **B)** `synchronized (Main.class) { counter++; }`
  - This option is correct because synchronizing on `Main.class` ensures that only one thread can enter the synchronized block at a time for all instances of `Main`, which is appropriate for protecting static fields like `counter`.

- **C)** `synchronized (task) { counter++; }`
  - This option is incorrect because `task` is a `Runnable` object, and synchronizing on it does not effectively control access to the shared static field `counter`.

- **D)** `synchronized (counter) { counter++; }`
  - This option is incorrect because `counter` is a primitive type (`int`), and you cannot synchronize on a primitive type. Synchronization requires an object.

- **E)** `synchronized (System.out) { counter++; }`
  - This option is incorrect because synchronizing on `System.out` is not related to controlling access to `counter`. It would also interfere with other potential uses of `System.out`.

---
### Q096　Concurrency and Multithreading

Which of the following statements about atomic classes is correct? (Choose all that apply)

**選項：**
- A. `AtomicInteger` is part of the `java.util.concurrent.atomic` package, but it does not provide atomic operations for increment and decrement.  
- B. `AtomicReference` can only be used with reference types, not primitive types.  （✓ 正確）
- C. `AtomicLong` supports atomic operations on `long` values, including `getAndIncrement()` and `compareAndSet()` methods.  （✓ 正確）
- D. `AtomicBoolean` can be used to perform atomic arithmetic operations on `boolean` values.   

**答：B、C。**

**解析：**

**Explanation:**

- **A)** `AtomicInteger` is part of the `java.util.concurrent.atomic` package, but it does not provide atomic operations for increment and decrement.
  - This statement is incorrect. `AtomicInteger` provides atomic operations for increment and decrement, such as `incrementAndGet()` and `decrementAndGet()`.

- **B)** `AtomicReference` can only be used with reference types, not primitive types.
  - This statement is correct. `AtomicReference` is designed to work with reference types and cannot be used with primitive types directly.

- **C)** `AtomicLong` supports atomic operations on `long` values, including `getAndIncrement()` and `compareAndSet()` methods. 
  - This statement is correct. `AtomicLong` provides atomic operations on `long` values, including `getAndIncrement()` and `compareAndSet()` methods.

- **D)** `AtomicBoolean` can be used to perform atomic arithmetic operations on `boolean` values.
  - This statement is incorrect. `AtomicBoolean` is used for atomic updates to `boolean` values, but it does not support atomic arithmetic operations.

---
### Q097　Concurrency and Multithreading

Which of the following code snippets correctly uses the `Lock` interface to ensure thread-safe access to a shared resource?

**選項：**
```java
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
public class Counter {
    private int count = 0;
    private Lock lock = new ReentrantLock();
    public void increment() {
        // Insert code here
    }
    public int getCount() {
        return count;
    }
}
```
- A.  ```java lock.lock(); try { count++; } finally { lock.unlock(); } ``` （✓ 正確）
- B.  ```java lock.lock(); count++; lock.unlock(); ``` 
- C.  ```java try { lock.lock(() -> { count++; }); } finally { lock.unlock(); } ``` 
- D.  ```java synchronized(lock) { count++; } ```  

**答：A。**

**解析：**

**Explanation:**

- **A)** 
```java
lock.lock();
try {
    count++;
} finally {
    lock.unlock();
}
```
  - This option correctly acquires the lock before modifying the shared resource and ensures the lock is released in the `finally` block, which is the proper use of the `Lock` interface.

- **B)** 
```java
lock.lock();
count++;
lock.unlock();
```
  - This option is incorrect because if an exception occurs between `lock.lock()` and `lock.unlock()`, the lock will not be released, potentially causing a deadlock.

- **C)** 
```java
try {
    lock.lock(() -> {
        count++;
    });
} finally {
    lock.unlock();
}
```
  - This option is incorrect because that's not a valid `lock.lock()` call.

- **D)** 
```java
synchronized(lock) {
    count++;
}
```
  - This option is incorrect because the `synchronized` block is used with the `lock` object itself, which is not the correct usage of the `Lock` interface and does not provide the intended functionality.

---
### Q098　Concurrency and Multithreading

Which of the following code snippets correctly demonstrates the usage of an `ExecutorService` with a `try-with-resources` block?

**選項：**
```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
public class ExecutorExample {
    public static void main(String[] args) {
        // Insert code here to create and use an ExecutorService with try-with-resources
    }
}
```
- A.  ```java try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) { executor.submit(() -> System.out.println("Task executed")); } ``` （✓ 正確）
- B.  ```java try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) { executor.submit(() -> System.out.println("Task executed")); } finally { executor.shutdown(); } ``` 
- C.  ```java ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor(); try { executor.submit(() -> System.out.println("Task executed")); } finally { executor.close(); } ``` 
- D.  ```java try (var executor = Executors.newVirtualThreadPerTaskExecutor()) { executor.submit(() -> System.out.println("Task executed")); executor.awaitTermination(1, TimeUnit.SECONDS); } ```  

**答：A。**

**解析：**

**Explanation:**

- **A)** 
```java
try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) {
    executor.submit(() -> System.out.println("Task executed"));
}
```
  - This option is correct. It uses the `try-with-resources` block with the new `Executors.newVirtualThreadPerTaskExecutor()` method introduced in Java 21. The `ExecutorService` will be automatically closed when the `try` block exits, eliminating the need for explicit shutdown calls.

- **B)** 
```java
try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) {
    executor.submit(() -> System.out.println("Task executed"));
} finally {
    executor.shutdown();
}
```
  - This option is incorrect because it unnecessarily calls `shutdown()` in the finally block. With `try-with-resources`, the `ExecutorService` is automatically closed, making the explicit `shutdown()` call redundant and potentially harmful.

- **C)** 
```java
ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor();
try {
    executor.submit(() -> System.out.println("Task executed"));
} finally {
    executor.close();
}
```
  - This option is incorrect because it doesn't use `the try-with-resources` syntax. While it does correctly close the `ExecutorService`, it doesn't take advantage of the automatic resource management provided by `try-with-resources`.

- **D)** 
```java
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    executor.submit(() -> System.out.println("Task executed"));
    executor.awaitTermination(1, TimeUnit.SECONDS);
}
```
  - This option is incorrect because it unnecessarily calls `awaitTermination()`. In a `try-with-resources` block, the `ExecutorService` is automatically closed when the block exits, making the explicit wait for termination unnecessary and potentially causing the thread to block for 1 second.

---
### Q099　Concurrency and Multithreading

Which of the following code snippets correctly demonstrates how to get a result from a `Callable` task using an `ExecutorService` with `try-with-resources`?

**選項：**
```java
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
public class CallableExample {
    public static void main(String[] args) {
        Callable<Integer> task = () -> {
            return 123;
        };
        // Insert code here
    }
}
```
- A.  ```java try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) { Future<Integer> future = executor.submit(task); System.out.println(future.get()); } ``` 
- B.  ```java try (var executor = Executors.newVirtualThreadPerTaskExecutor()) { Future<Integer> future = executor.submit(task); Integer result = future.get(1, TimeUnit.SECONDS); System.out.println(result); } ``` 
- C.  ```java try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) { Future<Integer> future = executor.submit(task); executor.shutdown(); System.out.println(future.get()); } ``` 
- D.  ```java try (var executor = Executors.newVirtualThreadPerTaskExecutor()) { Future<Integer> future = executor.submit(task); try { Integer result = future.get(); System.out.println(result); } catch (InterruptedException | ExecutionException e) { // Handle exceptions } } ```  （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** 
```java
try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) {
    Future<Integer> future = executor.submit(task);
    System.out.println(future.get());
}
```
  - This option is incorrect because it doesn't handle the potential `InterruptedException` and `ExecutionException` that `future.get()` can throw.

- **B)**
```java
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    Future<Integer> future = executor.submit(task);
    Integer result = future.get(1, TimeUnit.SECONDS);
    System.out.println(result);
}
```
  - This option is incorrect because it doesn't handle the potential exceptions (`InterruptedException`, `ExecutionException`, and `TimeoutException`) that `future.get(long, TimeUnit)` can throw.

- **C)**
```java
try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) {
    Future<Integer> future = executor.submit(task);
    executor.shutdown();
    System.out.println(future.get());
}
```
  - This option is incorrect because it unnecessarily calls `executor.shutdown()`. In a `try-with-resources` block, the `ExecutorService` is automatically closed when the block exits. Also, it doesn't handle the potential exceptions from `future.get()`.

- **D)**
```java
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    Future<Integer> future = executor.submit(task);
    try {
        Integer result = future.get();
        System.out.println(result);
    } catch (InterruptedException | ExecutionException e) {
        e.printStackTrace();
    }
}
```
  - This option is correct. It uses `try-with-resources` to automatically close the `ExecutorService`, properly submits the `Callable` task, retrieves the result using `Future.get()`, and handles the potential `InterruptedException` and `ExecutionException` that might be thrown.

---
### Q100　Concurrency and Multithreading

Which of the following statements about Java's concurrent collections is correct?

**選項：**
- A. `ConcurrentHashMap` allows concurrent read and write operations, and retrieval operations do not block even when updates are being made.  （✓ 正確）
- B. `CopyOnWriteArrayList` is optimized for scenarios with a high number of write operations compared to read operations.  
- C. `ConcurrentSkipListSet` does not kept elements sorted.  
- D. `BlockingQueue` implementations like `LinkedBlockingQueue` allow elements to be added and removed concurrently without any internal locking mechanisms.  

**答：A。**

**解析：**

**Explanation:**

- **A)** `ConcurrentHashMap` allows concurrent read and write operations, and retrieval operations do not block even when updates are being made.
  - This statement is correct. `ConcurrentHashMap` is designed to handle concurrent access, allowing multiple threads to read and write simultaneously without blocking read operations during updates.

- **B)** `CopyOnWriteArrayList` is optimized for scenarios with a high number of write operations compared to read operations. 
  - This statement is incorrect. `CopyOnWriteArrayList` is optimized for scenarios where read operations are far more frequent than write operations because it creates a new copy of the array on each write, which can be costly if writes are frequent.

- **C)** `ConcurrentSkipListSet` does not kept elements sorted.
  - This statement is incorrect. `ConcurrentSkipListSet` keep elements according to their natural ordering, or by a `Comparator` provided at set creation time.

- **D)** `BlockingQueue` implementations like `LinkedBlockingQueue` allow elements to be added and removed concurrently without any internal locking mechanisms.
  - This statement is incorrect. `BlockingQueue` implementations like `LinkedBlockingQueue` do use internal locking mechanisms to handle concurrent access safely.

---
### Q101　Concurrency and Multithreading

Which of the following statements about parallel streams is correct?

**選項：**
- A. Parallel streams always improve the performance of a program by utilizing multiple threads.  
- B. Parallel streams can lead to incorrect results if the operations performed are not thread-safe.  （✓ 正確）
- C. The order of elements in a parallel stream is always preserved compared to the original stream.  
- D. Using parallel streams guarantees that the operations on elements will execute in a fixed order.  

**答：B。**

**解析：**

**Explanation:**

- **A)** Parallel streams always improve the performance of a program by utilizing multiple threads.
  - This statement is incorrect because parallel streams do not always improve performance. The overhead of managing multiple threads can sometimes outweigh the benefits, especially for small datasets or simple operations.

- **B)** Parallel streams can lead to incorrect results if the operations performed are not thread-safe.
  - This statement is correct. When using parallel streams, care must be taken to ensure that the operations performed on the elements are thread-safe. Failure to do so can lead to race conditions and incorrect results.

- **C)** The order of elements in a parallel stream is always preserved compared to the original stream.
  - This statement is incorrect. The order of elements in a parallel stream is not guaranteed to be the same as in the original stream unless special care is taken to preserve the order, such as using ordered stream operations.

- **D)** Using parallel streams guarantees that the operations on elements will execute in a fixed order.
  - This statement is incorrect because parallel streams do not guarantee the order of execution of operations on elements. The operations may execute in a non-deterministic order due to the concurrent nature of parallel processing.

---
### Q102　Concurrency and Multithreading

Which of the following code snippets correctly demonstrates how to reduce a parallel stream to compute the sum of its elements?

**選項：**
```java
import java.util.Arrays;
import java.util.List;
public class ParallelStreamExample {
    public static void main(String[] args) {
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6);
        // Insert code here
    }
}
```
- A.  ```java int sum = numbers.parallelStream().reduce(1, Integer::sum); System.out.println(sum); ``` 
- B.  ```java int sum = numbers.parallelStream().reduce(0, Integer::sum); System.out.println(sum); ``` （✓ 正確）
- C.  ```java int sum = numbers.stream().reduce(0, Integer::sum); System.out.println(sum); ``` 
- D.  ```java int sum = numbers.parallelStream().collect(reduce(0, Integer::sum)); System.out.println(sum); ```

**答：B。**

**解析：**

**Explanation:**

- **A)** 
```java
int sum = numbers.parallelStream().reduce(1, Integer::sum);
System.out.println(sum);
```
  - This option is incorrect because it uses `1` as the identity value. The identity value for sum should be `0`, as it is the neutral element for addition. Starting the reduction with `1` will result in an incorrect sum that is incremented by `1`.

- **B)** 
```java
int sum = numbers.parallelStream().reduce(0, Integer::sum).collect();
System.out.println(sum);
```
  - This option is correct. It correctly uses `parallelStream()` to create a parallel stream and the `reduce` method with the identity value `0` and the method reference `Integer::sum` to sum the elements.

- **C)** 
```java
int sum = numbers.stream().reduce(0, Integer::sum);
System.out.println(sum);
```
  - This option is incorrect because it uses a sequential stream (`stream()`) instead of a parallel stream. While it correctly sums the elements, it does not demonstrate the use of a parallel stream as specified in the question.

- **D)** 
```java
int sum = numbers.parallelStream().collect(reduce(0, Integer::sum));
System.out.println(sum);
```
  - This option is incorrect because it attempts to use the `collect()` method in combination with `reduce()`, which is not the correct syntax. The `collect()` method is used for mutable reduction and is typically used with collectors, not with the `reduce()` operation directly.

| 第 11 章 | The Date/Time API | 15 |
---
### Q103　The Date/Time API

Which of the following are valid ways to create a `LocalDate` object?

**選項：**
**A.** `LocalDate.of(2014);`  
**B.** `LocalDate.with(2014, 1, 30);`  
**C.** `LocalDate.of(2014, 0, 30);`  
**D.** `LocalDate.now().plusDays(5);`

**答：D。**

**解析：**

**Explanation:**

- **A)** `LocalDate.of(2014);` 
  - This option is incorrect. The `LocalDate.of()` method requires a year, month, and day to be specified. Providing only a year will result in a compilation error.

- **B)** `LocalDate.with(2014, 1, 30);`
  - This option is incorrect. The `LocalDate` class does not have a `with()` method that takes three int arguments for year, month, and day. The correct method to use is `LocalDate.of(int year, int month, int dayOfMonth)`.

- **C)** `LocalDate.of(2014, 0, 30);`
  - This option is incorrect. The month value is 0, but months in the `LocalDate` class are indexed starting from 1. Valid month values are from 1 to 12, so using 0 will throw a `DateTimeException`.

- **D)** `LocalDate.now().plusDays(5);`
  - This option is correct. It accurately obtains the current date using `LocalDate.now()` and then adds 5 days to it using the `plusDays()` method. This will create a new `LocalDate` object representing the date 5 days from now.

---
### Q104　The Date/Time API

Which of the following options is the result of executing this line?

**選項：**
```java
LocalDate.of(2014, 1, 2).atTime(14, 30, 59, 999999)
```
**A.** A `LocalDate` instance representing `2014-01-02`  
**B.** A `LocalTime` instance representing `14:30:59:999999`  
**C.** A `LocalDateTime` instance representing `2014-01-02 14:30:59:999999`  
**D.** An exception is thrown

**答：C。**

**解析：**

**Explanation:**

- **A)** A `LocalDate` instance representing `2014-01-02` 
  - This option is incorrect. The `atTime` method does not return a `LocalDate`, but rather combines the `LocalDate` with the provided time parameters to create a `LocalDateTime` object.

- **B)** A `LocalTime` instance representing `14:30:59:999999`
  - This option is incorrect. The `atTime` method does not return a `LocalTime`, but rather combines the `LocalDate` with the provided time parameters to create a `LocalDateTime` object. Additionally, `LocalTime` does not have nanosecond precision, so `999999` nanoseconds would be an invalid `LocalTime`.

- **C)** A `LocalDateTime` instance representing `2014-01-02 14:30:59:999999` 
  - This option is correct. The `atTime` method takes a `LocalDate` and combines it with the provided hour, minute, second, and nanosecond parameters to create a `LocalDateTime` object representing that date and time. The resulting `LocalDateTime` will be `2014-01-02 14:30:59:999999`.

- **D)** An exception is thrown
  - This option is incorrect. The provided parameters of 14 for hour, 30 for minute, 59 for second, and 999999 for nanosecond are all valid values for their respective fields, so combining them with the `LocalDate` will not throw an exception.

---
### Q105　The Date/Time API

Which of the following are valid `ChronoUnit` values for `LocalTime`? (Choose all that apply)

**選項：**
**A.** `YEAR`  
**B.** `NANOS`  
**C.** `DAY`  
**D.** `HALF_DAYS`

**答：B、D。**

**解析：**

**Explanation:**

- **A)** `YEAR`
  - This option is incorrect. `YEAR` is not a valid `ChronoUnit` for `LocalTime`. `LocalTime` represents a time of day without any date information, so units of `YEAR` do not apply.

- **B)** `NANOS`
  - This option is correct. `NANOS` is a valid `ChronoUnit` for `LocalTime`. `LocalTime` has nanosecond precision, so you can perform operations on `LocalTime` using the `NANOS` unit.

- **C)** `DAY`
  - This option is incorrect. `DAY` is not a valid `ChronoUnit` for `LocalTime`. Similar to `YEAR`, `LocalTime` has no concept of days since it only represents a time, not a date.

- **D)** `HALF_DAYS`
  - This option is correct. `HALF_DAYS` is a valid `ChronoUnit` for `LocalTime`. A day can be divided into two 12-hour periods (AM and PM), so `HALF_DAYS` can be used with `LocalTime` to represent a difference or addition of 12 hour chunks of time.

---
### Q106　The Date/Time API

Which of the following statements are true? (Choose all that apply)

**選項：**
**A.** `java.time.Period` implements `java.time.temporal.Temporal`  
**B.** `java.time.Instant` implements `java.time.temporal.Temporal`  
**C.** `LocalDate` and `LocalTime` are thread-safe  
**D.** `LocalDateTime.now()` will return the current time in UTC zone

**答：B、C。**

**解析：**

**Explanation:**

- **A)** `java.time.Period` implements `java.time.temporal.Temporal`
  - This option is incorrect. `java.time.Period` does not implement the `java.time.temporal.Temporal` interface. `Period` represents a span of time between two dates and is not itself a temporal object.

- **B)** `java.time.Instant` implements `java.time.temporal.Temporal`
  - This option is correct. `java.time.Instant` does implement the `java.time.temporal.Temporal` interface. `Instant` represents a point in time on the timeline and can be thought of as a temporal object.

- **C)** `LocalDate` and `LocalTime` are thread-safe.
  - This option is correct. `LocalDate` and `LocalTime` are indeed thread-safe. All the core Java Time classes, including `LocalDate`, `LocalTime`, `LocalDateTime`, `Instant`, etc., are designed to be immutable and thread-safe.

- **D)** `LocalDateTime.now()` will return the current time in UTC zone
  - This option is incorrect. `LocalDateTime.now()` returns the current date and time using the system clock in the default time zone, not necessarily in the UTC zone. To get the current time in UTC, you would use `LocalDateTime.now(ZoneOffset.UTC)` or `Instant.now()`.

---
### Q107　The Date/Time API

Which of the following options is a valid way to get the nanoseconds part of an `Instant` object referenced by `i`?

**選項：**
**A.** `int nanos = i.getNano();`  
**B.** `long nanos = i.get(ChronoField.NANOS);`  
**C.** `long nanos = i.get(ChronoUnit.NANOS);`  
**D.** `int nanos = i.getEpochNano();`

**答：A。**

**解析：**

**Explanation:**

- **A)** `int nanos = i.getNano();`
  - This option is correct. The `Instant` class does have a `getNano()` method that returns the nanosecond part of the `Instant` as an `int`. This is a valid way to get the nanoseconds.

- **B)** `long nanos = i.get(ChronoField.NANOS);`
  - This option is incorrect. You can use the `get(TemporalField)` method of `Instant` to get the value of a specific `ChronoField`. Passing `ChronoField.NANO_OF_SECOND` (not `ChronoField.NANO`) will return the nanosecond part of the `Instant` as a `long`.

- **C)** `long nanos = i.get(ChronoUnit.NANOS);`
  - This option is incorrect. While `Instant` does have a `get(TemporalUnit)` method, `ChronoUnit.NANOS` is not a valid argument for it. `ChronoUnit` values are used for durations and periods, not for fields of a temporal object.

- **D)** `int nanos = i.getEpochNano();`
  - This option is incorrect. The `Instant` class does have a `getEpochSecond()` method that returns the number of seconds since the Unix epoch, but there is no corresponding `getEpochNano()` method.

---
### Q108　The Date/Time API

Which of the following options is the result of executing this line?

**選項：**
```java
System.out.println(
   Period.between(
       LocalDate.of(2025, 3, 20),
       LocalDate.of(2025, 2, 20))
);
```
**A.** `P29D`  
**B.** `P-29D`  
**C.** `P1M`  
**D.** `P-1M`

**答：D。**

**解析：**

**Explanation:**

- **A)** `P29D`
  - This option is incorrect. The `Period.between` method calculates the period between the second date and the first date, in that order. Since the first date (2025-03-20) is later than the second date (2025-02-20), the resulting period will be negative, not positive.

- **B)** `P-29D`
  - This option is incorrect. While the resulting period will be negative, it will not be represented as `-29D`. A `Period` first counts the number of complete months, then the remaining days.

- **C)** `P1M`
  - This option is incorrect. The resulting period will be negative because the first date is later than the second date.

- **D)** `P-1M`
  - This option is correct. The `Period.between` method subtracts the second date from the first date. In this case, `2025-03-20` minus `2025-02-20` results in a period of -1 month, which is represented as `P-1M`. The `Period` class first calculates the difference in complete months, and then any remaining days. Since the difference is exactly one month, the result is `P-1M`.

---
### Q109　The Date/Time API

Which of the following options is the result of executing this line?

**選項：**
```java
System.out.println(
   Duration.between(
       LocalDateTime.of(2025, 3, 20, 18, 0),
       LocalTime.of(18, 5) )
);
```
**A.** `PT5M`  
**B.** `PT-5M`  
**C.** `PT300S`  
**D.** An exception is thrown

**答：D。**

**解析：**

**Explanation:**

- **A)** `PT5M`
  - This option is incorrect. `PT5M` represents a duration of 5 minutes, which would be the result if the second time point was 5 minutes after the first. However, since `LocalTime.of(18, 5)` is being compared to a `LocalDateTime`, this causes an issue because they are not of the same type.

- **B)** `PT-5M`
  - This option is incorrect. `PT-5M` represents a duration of negative 5 minutes. Similar to option A, this would only be the case if the second time point was before the first. The main issue is that there is a type mismatch between `LocalDateTime` and `LocalTime`.

- **C)** `PT300S`
  - This option is incorrect. `PT300S` represents a duration of 300 seconds (or 5 minutes), which again would be the result if the second time point was 5 minutes after the first. However, this still doesn't resolve the type mismatch issue between `LocalDateTime` and `LocalTime`. 

- **D)** An exception is thrown
  - This option is correct. An exception is thrown because there is a type mismatch between `LocalDateTime.of(2025, 3, 20, 18, 0)` and `LocalTime.of(18, 5)`. The `Duration.between` method requires two temporal objects of the same type.

---
### Q110　The Date/Time API

Which of the following are valid `ChronoField` values for `LocalDate`?

**選項：**
**A.** `DAY_OF_WEEK`  
**B.** `HOUR_OF_DAY`  
**C.** `DAY_OF_MONTH`  
**D.** `MILLI_OF_SECOND`

**答：A、C。**

**解析：**

**Explanation:**

- **A)** `DAY_OF_WEEK`
  - This option is correct. `DAY_OF_WEEK` is a valid `ChronoField` value for `LocalDate`. It represents the day of the week, an integer from 1 (Monday) to 7 (Sunday), which can be extracted from a `LocalDate`.

- **B)** `HOUR_OF_DAY`
  - This option is incorrect. `HOUR_OF_DAY` is not a valid `ChronoField` value for `LocalDate`. `HOUR_OF_DAY` pertains to `LocalTime` or `LocalDateTime`, which include time components, whereas `LocalDate` only deals with date components.

- **C)** `DAY_OF_MONTH`
  - This option is correct. `DAY_OF_MONTH` is a valid `ChronoField` value for `LocalDate`. It represents the day of the month, which can be extracted from a `LocalDate`.

- **D)** `MILLI_OF_SECOND`
  - This option is incorrect. `MILLI_OF_SECOND` is not a valid `ChronoField` value for `LocalDate`. `MILLI_OF_SECOND` pertains to time components, specifically for `LocalTime` or `LocalDateTime`, and `LocalDate` only deals with date components.

---
### Q111　The Date/Time API

Which of the following are valid ways to create a `ZoneId` object?

**選項：**
**A.** `ZoneId.ofHours(2);`  
**B.** `ZoneId.of("2");`  
**C.** `ZoneId.of("-1");`  
**D.** `ZoneId.of("America/Canada");`

**答：C。**

**解析：**

**Explanation:**

- **A)** `ZoneId.ofHours(2);`
  - This option is incorrect. The method `ofHours(int)` belongs to the `ZoneOffset` class, not `ZoneId`.

- **B)** `ZoneId.of("2");`
  - This option is incorrect. The format of the offset is incorrect for `ZoneId`. It should be a proper time-zone ID or start with a sign (`+` or `-`).

- **C)** `ZoneId.of("-1");`
  - This option is correct. `ZoneId.of("-1")` is valid since it follows the correct format for time-zone offsets.

- **D)** `ZoneId.of("America/Canada");`
  - This option is incorrect. The format for zone regions should be in the `"Area/City"` format, not `"Area/Country"`. A valid example would be `"America/Montreal"`.

---
### Q112　The Date/Time API

Which of the following options is the result of executing these lines?

**選項：**
```java
ZoneOffset offset = ZoneOffset.of("Z");
System.out.println(
   offset.get(ChronoField.HOUR_OF_DAY)
);
```
**A.** `0`  
**B.** `1`  
**C.** `12:00`  
**D.** An exception is thrown

**答：D。**

**解析：**

**Explanation:**

- **A)** `0`
  - This option is incorrect. The method `offset.get(ChronoField.HOUR_OF_DAY)` does not return the hour value of the `ZoneOffset`. `ZoneOffset` represents a time-zone offset from UTC/Greenwich, and calling `get(ChronoField.HOUR_OF_DAY)` on it is not appropriate.

- **B)** `1`
  - This option is incorrect. Similar to option A, the `get` method of `ZoneOffset` with `ChronoField.HOUR_OF_DAY` does not produce this result. The `ZoneOffset` class is not meant to provide such a field directly.

- **C)** `12:00`
  - This option is incorrect. `12:00` is not a valid response for the method call as it implies a time representation, while `ZoneOffset` is dealing with offset values rather than specific time of day values.

- **D)** An exception is thrown
  - This option is correct. An exception is thrown because `ZoneOffset` does not support the field `ChronoField.HOUR_OF_DAY`. The `ZoneOffset` class provides offset values in terms of seconds rather than specific chrono fields like hour of day.

---
### Q113　The Date/Time API

Assuming a local time zone of `+2:00`, which of the following options is the result of executing these lines?

**選項：**
```java
ZonedDateTime zdt =
   ZonedDateTime.of(2025, 02, 28, 5, 0, 0, 0,
       ZoneId.of("+05:00"));
System.out.println(zdt.toLocalTime());
```
**A.** `05:00`  
**B.** `17:00`  
**C.** `02:00`  
**D.** `03:00`

**答：A。**

**解析：**

**Explanation:**

- **A)** `05:00` 
  - This option is correct. `ZonedDateTime.of(2025, 02, 28, 5, 0, 0, 0, ZoneId.of("+05:00"))` creates a `ZonedDateTime` instance with the specified date, time, and time zone offset of +05:00. Calling `toLocalTime()` on this instance returns the local time, which is `05:00`, as no conversion to the local time zone of +2:00 is done in this code snippet.

- **B)** `17:00`
  - This option is incorrect. `17:00` would be the time if the code converted the given time (05:00) from the +05:00 time zone to the local time zone of +02:00, which it does not. 

- **C)** `02:00`
  - This option is incorrect. `02:00` does not correspond to any logical result based on the given time and time zone offset.

- **D)** `03:00`
  - This option is incorrect. `03:00` also does not correspond to any logical result based on the given time and time zone offset.

---
### Q114　The Date/Time API

Assuming that DST starts on October, 4, 2025 at 0:00:00, which of the following is the result of executing the above lines?

**選項：**
   ```java
   ZonedDateTime zdt =
       ZonedDateTime.of(2025, 10, 4, 0, 0, 0, 0,
           ZoneId.of("America/Asuncion"))
       .plus(Duration.ofHours(1));
   System.out.println(zdt);
   ```
**A.** `2025-10-04T00:00-03:00[America/Asuncion]`  
**B.** `2025-10-04T01:00-03:00[America/Asuncion]`  
**C.** `2025-10-04T02:00-03:00[America/Asuncion]`  
**D.** `2025-10-03T23:00-03:00[America/Asuncion]`

**答：C。**

**解析：**

**Explanation:**

- **A)** `2025-10-04T00:00-03:00[America/Asuncion]` 
  - This option is incorrect. The initial time is `2025-10-04T00:00-03:00[America/Asuncion]` before DST starts. When 1 hour is added, the time will shift forward by 1 hour, but since DST starts at this moment, the offset will change.

- **B)** `2025-10-04T01:00-03:00[America/Asuncion]` 
  - This option is incorrect. Adding 1 hour to the initial time `2025-10-04T00:00-03:00[America/Asuncion]` while considering the start of DST (which typically adds 1 hour to the local time) means that the effective time would be adjusted by the DST transition.

- **C)** `2025-10-04T02:00-03:00[America/Asuncion]`
  - This option is correct. Initially, the time is `2025-10-04T00:00-03:00[America/Asuncion]`. With the addition of 1 hour and considering the DST start at `2025-10-04T00:00`, the time advances to `2025-10-04T02:00-03:00[America/Asuncion]`, as it effectively skips the 01:00 hour.

- **D)** `2025-10-03T23:00-03:00[America/Asuncion]`
  - This option is incorrect. The date and time `2025-10-03T23:00-03:00[America/Asuncion]` does not correlate correctly with the 1 hour addition from the initial time and does not account for the DST transition. 

---
### Q115　The Date/Time API

Which of the following statements are true? (Choose all that apply)

**選項：**
**A.** `java.time.ZoneOffset` is a subclass of `java.time.ZoneId`.  
**B.** `java.time.Instant` can be obtained from `java.time.ZonedDateTime`.  
**C.** `java.time.ZoneOffset` can manage DST.  
**D.** `java.time.OffsetDateTime` represents a point in time in the UTC time zone.

**答：B。**

**解析：**

**Explanation:**

- **A)** `java.time.ZoneOffset` is a subclass of `java.time.ZoneId`.
  - This option is incorrect. `java.time.ZoneOffset` is not a subclass of `java.time.ZoneId`. `java.time.ZoneOffset` is a final class that extends `java.time.ZoneId` but it is not a subclass.

- **B)** `java.time.Instant` can be obtained from `java.time.ZonedDateTime`. 
  - This option is correct. `java.time.Instant` can indeed be obtained from `java.time.ZonedDateTime` using the `toInstant()` method.

- **C)** `java.time.ZoneOffset` can manage DST.
  - This option is incorrect. `java.time.ZoneOffset` represents a fixed offset from UTC and does not manage Daylight Saving Time (DST). DST is managed by `java.time.ZoneId`.

- **D)** `java.time.OffsetDateTime` represents a point in time in the UTC time zone.
  - This option is incorrect. `java.time.OffsetDateTime` represents a date-time with an offset from UTC, but it does not necessarily represent a point in the UTC time zone. The offset can be any valid `ZoneOffset`.

---
### Q116　The Date/Time API

Which of the following options is the result of executing these lines?

**選項：**
```java
DateTimeFormatter formatter =
   DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT);
System.out.println(
   formatter
   .withLocale(Locale.ENGLISH)
   .format(LocalDateTime.of(2025, 5, 7, 16, 0))
);
```
**A.** `5/7/15 4:00 PM`  
**B.** `5/7/15`  
**C.** `4:00 PM`  
**D.** `4:00:00 PM`

**答：C。**

**解析：**

**Explanation:**

- **A)** `5/7/15 4:00 PM`
  - This option is incorrect. The `DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT)` method is used to format only the time portion of a `LocalDateTime` object, and it does not include the date. Therefore, the output will not include `5/7/15`.

- **B)** `5/7/15`
  - This option is incorrect. As mentioned earlier, the `DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT)` formats only the time portion and does not include the date. Thus, the output `5/7/15` is not possible.

- **C)** `4:00 PM`
  - This option is correct. The `DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT)` formats the time portion of the `LocalDateTime` object in a short style. Given the input time `16:00`, in the `Locale.ENGLISH`, the formatted output is `4:00 PM`.

- **D)** `4:00:00 PM`
  - This option is incorrect. The `DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT)` formats the time portion without including seconds. Therefore, the output will not include `4:00:00 PM`.

---
### Q117　The Date/Time API

Which of the following statements is true about these lines?

**選項：**
```java
DateTimeFormatter formatter =
   DateTimeFormatter.ofPattern("HH:mm:ss X");
OffsetDateTime odt =
   OffsetDateTime.parse("11:50:20 Z", formatter);
```
**A.** The pattern `HH:mm:ss X` is invalid.  
**B.** An `OffsetDateTime` is created successfully.  
**C.** `Z` is an invalid offset.  
**D.** An exception is thrown at runtime.

**答：D。**

**解析：**

**Explanation:**

- **A)** The pattern `HH:mm:ss X` is invalid.
  - This option is incorrect. The pattern `HH:mm:ss X` is valid. `HH` represents the hour of the day (00-23), `mm` represents the minute of the hour, `ss` represents the second of the minute, and `X` represents the ISO 8601 time zone offset.

- **B)** An `OffsetDateTime` is created successfully. 
  - This option is incorrect. The pattern `HH:mm:ss X` is valid, but the `OffsetDateTime.parse` method requires a date and time format along with the offset. Since the input string `"11:50:20 Z"` does not contain a date part, this will cause a `DateTimeParseException`.

- **C)** `Z` is an invalid offset.
  - This option is incorrect. `Z` is a valid offset representing UTC (Coordinated Universal Time).

- **D)** An exception is thrown at runtime.
  - This option is correct. An exception is thrown at runtime because the input string `"11:50:20 Z"` does not match the expected pattern for an `OffsetDateTime`, which typically includes a date part as well as the time and offset.

| 第 12 章 | File I/O | 9 |
---
### Q118　File I/O

What is the result of the following code snippet?

**選項：**
```java
import java.nio.file.Path;
import java.nio.file.Paths;
public class PathExample {
    public static void main(String[] args) {
        Path basePath = Paths.get("/home/user");
        Path relativePath = Paths.get("documents/notes.txt");
        Path resultPath = basePath.resolve(relativePath);
        System.out.println(resultPath);
    }
}
```
- A. `/home/user`  
- B. `/home/user/documents`  
- C. `/documents/notes.txt`  
- D. `/home/user/documents/notes.txt`     （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** `/home/user`
  - This option is incorrect. The `resolve` method appends the given path to the base path. It does not return the base path alone.

- **B)** `/home/user/documents` 
  - This option is incorrect. The `resolve` method includes the entire relative path provided as an argument, not just part of it.

- **C)** `/documents/notes.txt`
  - This option is incorrect. The `resolve` method combines the base path with the given relative path; it does not replace the base path with the relative path.

- **D)** `/home/user/documents/notes.txt`
  - This option is correct. The `resolve` method appends the relative path to the base path, resulting in `/home/user/documents/notes.txt`.

---
### Q119　File I/O

What is the result of the following code snippet?

**選項：**
```java
import java.nio.file.Path;
import java.nio.file.Paths;
public class PathExample {
    public static void main(String[] args) {
        Path path = Paths.get("/home/user/../documents/./notes.txt");
        Path normalizedPath = path.normalize();
        System.out.println(normalizedPath);
    }
}
```
- A. `/home/user/../documents/./notes.txt`  
- B. `/home/user/documents/notes.txt`  
- C. `/home/documents/notes.txt`  （✓ 正確）
- D. `/documents/notes.txt`   

**答：C。**

**解析：**

**Explanation:**

- **A)** `/home/user/../documents/./notes.txt` 
  - This option is incorrect. The `normalize` method removes redundant `.` and `..` elements, so it wouldn't leave the path as is.

- **B)** `/home/user/documents/notes.txt`
  - This option is incorrect. While the `.` is removed, the `..` navigates one directory up, resulting in an incorrect final path.

- **C)** `/home/documents/notes.txt`
  - This option is correct. The `normalize` method processes the path by removing the `.` and moving one directory up due to `..`, resulting in `/home/documents/notes.txt`.

- **D)** `/documents/notes.txt`
  - This option is incorrect. The `normalize` method does not completely remove the leading part of the path up to `documents`. It only processes the `.` and `..` elements.

---
### Q120　File I/O

Which of the following classes is used for reading character streams in Java?

**選項：**
- A. `FileOutputStream`  
- B. `FileReader`  （✓ 正確）
- C. `BufferedOutputStream`  
- D. `ObjectInputStream`   

**答：B。**

**解析：**

**Explanation:**

- **A)** `FileOutputStream`
  - This option is incorrect. `FileOutputStream` is used for writing binary data to a file, not for reading character streams.

- **B)** `FileReader`
  - This option is correct. `FileReader` is designed for reading character streams from a file, making it the appropriate class for this purpose.

- **C)** `BufferedOutputStream`
  - This option is incorrect. `BufferedOutputStream` is used to write binary data to an output stream, buffering the data for efficient writing. It is not used for reading character streams.

- **D)** `ObjectInputStream`
  - This option is incorrect. `ObjectInputStream` is used for deserializing objects from an input stream, not for reading character streams.

---
### Q121　File I/O

Which of the following code snippets correctly copies a file using the `Files` class, ensuring that an existing target file is overwritten?

**選項：**
- A.   ```java Path source = Paths.get("source.txt"); Path target = Paths.get("target.txt"); Files.copy(source, target, StandardCopyOption.ATOMIC_MOVE); ``` 
- B.   ```java Path source = Paths.get("source.txt"); Path target = Paths.get("target.txt"); Files.move(source, target, StandardCopyOption.REPLACE_EXISTING); ``` 
- C.   ```java Path source = Paths.get("source.txt"); Path target = Paths.get("target.txt"); Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING); ``` （✓ 正確）
- D.   ```java Path source = Paths.get("source.txt"); Path target = Paths.get("target.txt"); Files.copy(source, target, StandardCopyOption.APPEND); ```  

**答：C。**

**解析：**

**Explanation:**

- **A)** 
```java
Path source = Paths.get("source.txt");
Path target = Paths.get("target.txt");
Files.copy(source, target, StandardCopyOption.ATOMIC_MOVE);
```
  - This option is incorrect. `StandardCopyOption.ATOMIC_MOVE` is used for moving files atomically, not for copying. It does not ensure that an existing file is overwritten.

- **B)** 
```java
Path source = Paths.get("source.txt");
Path target = Paths.get("target.txt");
Files.move(source, target, StandardCopyOption.REPLACE_EXISTING);
```
  - This option is incorrect. `Files.move` is used to move or rename a file, not to copy it. `StandardCopyOption.REPLACE_EXISTING` ensures the target file is overwritten during a move, not a copy.

- **C)** 
```java
Path source = Paths.get("source.txt");
Path target = Paths.get("target.txt");
Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING);
```
  - This option is correct. `Files.copy` with `StandardCopyOption.REPLACE_EXISTING` ensures the target file is overwritten if it exists, which is the correct way to copy a file with overwriting.

- **D)** 
```java
Path source = Paths.get("source.txt");
Path target = Paths.get("target.txt");
Files.copy(source, target, StandardCopyOption.APPEND);
```
  - This option is incorrect. `StandardCopyOption.APPEND` does not exist in the `StandardCopyOption` enum, making this code snippet invalid.

---
### Q122　File I/O

Which of the following code snippets correctly reads all lines from a file into a `List<String>` using the `java.nio.file` API?

**選項：**
- A.   ```java Path path = Paths.get("file.txt"); List<String> lines = Files.readAllBytes(path); ``` 
- B.   ```java Path path = Paths.get("file.txt"); List<String> lines = Files.readString(path); ``` 
- C.   ```java Path path = Paths.get("file.txt"); List<String> lines = Files.lines(path); ``` 
- D.   ```java Path path = Paths.get("file.txt"); List<String> lines = Files.readAllLines(path); ```  （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** 
```java
Path path = Paths.get("file.txt");
List<String> lines = Files.readAllBytes(path);
```
  - This option is incorrect. `Files.readAllBytes(path)` returns a byte array, not a `List<String>`.

- **B)** 
```java
Path path = Paths.get("file.txt");
List<String> lines = Files.readString(path);
```
  - This option is incorrect. `Files.readString(path)` returns a single `String` containing the entire content of the file, not a `List<String>`.

- **C)** 
```java
Path path = Paths.get("file.txt");
List<String> lines = Files.lines(path);
```
  - This option is incorrect. `Files.lines(path)` returns a `Stream<String>`, not a `List<String>`. It provides a lazy-loaded stream of lines.

- **D)** 
```java
Path path = Paths.get("file.txt");
List<String> lines = Files.readAllLines(path);
```
  - This option is correct. `Files.readAllLines(path)` reads all lines from the file and returns them as a `List<String>`, which is the desired behavior.

---
### Q123　File I/O

Which of the following code snippets correctly writes a `List<String>` to a file using the `Files` class in Java?

**選項：**
- A.   ```java Path path = Paths.get("output.txt"); List<String> lines = Arrays.asList("line1", "line2", "line3"); Files.write(path, lines); ``` （✓ 正確）
- B.   ```java Path path = Paths.get("output.txt"); List<String> lines = Arrays.asList("line1", "line2", "line3"); Files.writeString(path, lines); ``` 
- C.   ```java Path path = Paths.get("output.txt"); List<String> lines = Arrays.asList("line1", "line2", "line3"); Files.writeLines(path, lines); ``` 
- D.   ```java Path path = Paths.get("output.txt"); List<String> lines = Arrays.asList("line1", "line2", "line3"); Files.write(path, lines, StandardOpenOption.READ); ```  

**答：A。**

**解析：**

**Explanation:**

- **A)** 
```java
Path path = Paths.get("output.txt");
List<String> lines = Arrays.asList("line1", "line2", "line3");
Files.write(path, lines);
```
  - This option is correct. `Files.write(path, lines)` writes the given list of strings to the file at the specified path, creating the file if it does not exist.

- **B)** 
```java
Path path = Paths.get("output.txt");
List<String> lines = Arrays.asList("line1", "line2", "line3");
Files.writeString(path, lines);
```
  - This option is incorrect. `Files.writeString(path, lines)` does not exist. `Files.writeString` expects a single `String` as the second argument, not a `List<String>`.

- **C)** 
```java
Path path = Paths.get("output.txt");
List<String> lines = Arrays.asList("line1", "line2", "line3");
Files.writeLines(path, lines);
```
  - This option is incorrect. `Files.writeLines(path, lines)` does not exist. There is no such method in the `Files` class.

- **D)** 
```java
Path path = Paths.get("output.txt");
List<String> lines = Arrays.asList("line1", "line2", "line3");
Files.write(path, lines, StandardOpenOption.READ);
```
  - This option is incorrect. `StandardOpenOption.READ` is not a valid option for writing files. It is used for reading files.

---
### Q124　File I/O

Which of the following methods from the `BasicFileAttributes` class retrieves the creation time of a file?

**選項：**
- A.   ```java BasicFileAttributes attrs = Files.readAttributes(path, BasicFileAttributes.class); attrs.lastModifiedTime(); ``` 
- B.   ```java BasicFileAttributes attrs = Files.readAttributes(path, BasicFileAttributes.class); attrs.creationTime(); ``` （✓ 正確）
- C.   ```java BasicFileAttributes attrs = Files.readAttributes(path, BasicFileAttributes.class); attrs.lastAccessTime(); ``` 
- D.   ```java BasicFileAttributes attrs = Files.readAttributes(path, BasicFileAttributes.class); attrs.size(); ```  

**答：B。**

**解析：**

**Explanation:**

- **A)** 
```java
BasicFileAttributes attrs = Files.readAttributes(path, BasicFileAttributes.class);
attrs.lastModifiedTime();
```
  - This option is incorrect. `attrs.lastModifiedTime()` retrieves the last modified time of the file, not the creation time.

- **B)** 
```java
BasicFileAttributes attrs = Files.readAttributes(path, BasicFileAttributes.class);
attrs.creationTime();
```
  - This option is correct. `attrs.creationTime()` retrieves the creation time of the file, which is the correct method from `BasicFileAttributes` for this purpose.

- **C)** 
```java
BasicFileAttributes attrs = Files.readAttributes(path, BasicFileAttributes.class);
attrs.lastAccessTime();
```
  - This option is incorrect. `attrs.lastAccessTime()` retrieves the last access time of the file, not the creation time.

- **D)** 
```java
BasicFileAttributes attrs = Files.readAttributes(path, BasicFileAttributes.class);
attrs.size();
```
  - This option is incorrect. `attrs.size()` retrieves the size of the file, not the creation time.

---
### Q125　File I/O

Which of the following code snippets correctly traverses a directory tree using the `Files.walkFileTree` method in Java?

**選項：**
- A.   ```java Path start = Paths.get("start_directory"); Files.walkFileTree(start, new SimpleFileVisitor<Path>() { @Override public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException { return FileVisitResult.SKIP_SUBTREE; } }); ``` 
- B.   ```java Path start = Paths.get("start_directory"); Files.walkFileTree(start, new SimpleFileVisitor<Path>() { @Override public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException { throw new IOException("Error visiting file"); } }); ``` 
- C.   ```java Path start = Paths.get("start_directory"); Files.walkFileTree(start, new SimpleFileVisitor<Path>() { @Override public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException { System.out.println("Visited file: " + file); return FileVisitResult.TERMINATE; } }); ``` 
- D.   ```java Path start = Paths.get("start_directory"); Files.walkFileTree(start, EnumSet.noneOf(FileVisitOption.class), Integer.MAX_VALUE, new SimpleFileVisitor<Path>() { @Override public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException { System.out.println("Visited file: " + file); return FileVisitResult.CONTINUE; }  @Override public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException { return FileVisitResult.CONTINUE; }  @Override public FileVisitResult visitFileFailed(Path file, IOException exc) throws IOException { return FileVisitResult.CONTINUE; }  @Override public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException { return FileVisitResult.CONTINUE; } }); ```  （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** 
```java
Path start = Paths.get("start_directory");
Files.walkFileTree(start, new SimpleFileVisitor<Path>() {
    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
        return FileVisitResult.SKIP_SUBTREE;
    }
});
```
  - This option is incorrect. `FileVisitResult.SKIP_SUBTREE` will skip the traversal of the entire subtree, not allowing the complete traversal of the directory tree.

- **B)** 
```java
Path start = Paths.get("start_directory");
Files.walkFileTree(start, new SimpleFileVisitor<Path>() {
    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
        throw new IOException("Error visiting file");
    }
});
```
  - This option is incorrect. Throwing an `IOException` inside `visitFile` will stop the traversal due to an unhandled exception.

- **C)** 
```java
Path start = Paths.get("start_directory");
Files.walkFileTree(start, new SimpleFileVisitor<Path>() {
    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
        System.out.println("Visited file: " + file);
        return FileVisitResult.TERMINATE;
    }
});
```
  - This option is incorrect. The use of `FileVisitResult.TERMINATE` will stop the traversal after visiting the first file, not allowing the complete traversal of the directory tree.

- **D)** 
```java
Path start = Paths.get("start_directory");
Files.walkFileTree(start, EnumSet.noneOf(FileVisitOption.class), Integer.MAX_VALUE, new SimpleFileVisitor<Path>() {
    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
        System.out.println("Visited file: " + file);
        return FileVisitResult.CONTINUE;
    }

    @Override
    public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) throws IOException {
        return FileVisitResult.CONTINUE;
    }

    @Override
    public FileVisitResult visitFileFailed(Path file, IOException exc) throws IOException {
        return FileVisitResult.CONTINUE;
    }

    @Override
    public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException {
        return FileVisitResult.CONTINUE;
    }
});
```
  - This option is correct. It uses `Files.walkFileTree` with `SimpleFileVisitor`, specifying no special `FileVisitOption` and setting the maximum depth to `Integer.MAX_VALUE`, ensuring full traversal of the directory tree. Additionally, it correctly handles directory pre-visit, file visit, file visit failure, and directory post-visit events.

---
### Q126　File I/O

Which of the following code snippets correctly serializes an object to a file?

**選項：**
- A.   ```java class Animal implements Serializable { private static final long serialVersionUID = 1L; private String species; private int age;  public Animal(String species, int age) { this.species = species; this.age = age; } }  Animal animal = new Animal("Lion", 5); try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream("animal.ser"))) { ois.writeObject(animal); } catch (IOException e) { e.printStackTrace(); } ``` 
- B.   ```java class Animal implements Serializable { private static final long serialVersionUID = 1L; private String species; private int age;  public Animal(String species, int age) { this.species = species; this.age = age; } }  Animal animal = new Animal("Lion", 5); try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("animal.ser"))) { oos.writeObject(animal); } catch (IOException e) { e.printStackTrace(); } ``` （✓ 正確）
- C.   ```java class Animal { private String species; private int age;  public Animal(String species, int age) { this.species = species; this.age = age; } }  Animal animal = new Animal("Lion", 5); try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("animal.ser"))) { oos.writeObject(animal); } catch (IOException e) { e.printStackTrace(); } ``` 
- D.   ```java class Animal implements Serializable { private static final long serialVersionUID = 1L; private String species; private int age;  public Animal(String species, int age) { this.species = species; this.age = age; } }  Animal animal = new Animal("Lion", 5); try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream("animal.ser"))) { bos.write(animal); } catch (IOException e) { e.printStackTrace(); } ``` 

**答：B。**

**解析：**

**Explanation:**

- **A)** 

    ```java
    class Animal implements Serializable {
        private static final long serialVersionUID = 1L;
        private String species;
        private int age;

        public Animal(String species, int age) {
            this.species = species;
            this.age = age;
        }
    }

    Animal animal = new Animal("Lion", 5);
    try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream("animal.ser"))) {
        ois.writeObject(animal);
    } catch (IOException e) {
        e.printStackTrace();
    }
    ```
  - This option is incorrect. `ObjectInputStream` is used for deserialization (reading objects from a stream), not serialization. It should be `ObjectOutputStream`.

- **B)** 

    ```java
    class Animal implements Serializable {
        private static final long serialVersionUID = 1L;
        private String species;
        private int age;

        public Animal(String species, int age) {
            this.species = species;
            this.age = age;
        }
    }

    Animal animal = new Animal("Lion", 5);
    try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("animal.ser"))) {
        oos.writeObject(animal);
    } catch (IOException e) {
        e.printStackTrace();
    }
    ```
  - This option is correct. `ObjectOutputStream` is used to serialize an object to a file, which is what this code snippet does correctly.

- **C)** 

    ```java
    class Animal {
        private String species;
        private int age;

        public Animal(String species, int age) {
            this.species = species;
            this.age = age;
        }
    }

    Animal animal = new Animal("Lion", 5);
    try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("animal.ser"))) {
        oos.writeObject(animal);
    } catch (IOException e) {
        e.printStackTrace();
    }
    ```
  - This option is incorrect. The `Animal` class does not implement `Serializable`, so it cannot be serialized using `ObjectOutputStream`.

- **D)** 

    ```java
    class Animal implements Serializable {
        private static final long serialVersionUID = 1L;
        private String species;
        private int age;

        public Animal(String species, int age) {
            this.species = species;
            this.age = age;
        }
    }

    Animal animal = new Animal("Lion", 5);
    try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream("animal.ser"))) {
        bos.write(animal);
    } catch (IOException e) {
        e.printStackTrace();
    }
    ```
  - This option is incorrect. `BufferedOutputStream` cannot be used to write objects directly; `ObjectOutputStream` should be used for serialization.

| 第 13 章 | The Java Platform Module System | 13 |
---
### Q127　The Java Platform Module System

Which of the following are types of modules in the Java Platform Module System (JPMS)? (Choose all that apply.)

**選項：**
- A. Automatic module  （✓ 正確）
- B. Default module  
- C. Unnamed module  （✓ 正確）
- D. Core module  
- E. Primary module  

**答：A、C。**

**解析：**

**Explanation:**

- **A)** Automatic module
  - This option is correct. An automatic module is created from a JAR file that is placed on the module path but does not have a module descriptor (`module-info.java`). The module system infers a module name from the JAR file name and exports all packages in the JAR.

- **B)** Default module
  - This option incorrect. There is no concept of a "default module" in JPMS. The term might be confused with unnamed modules or other types of configurations, but it is not a recognized type.

- **C)** Unnamed module
  - This option is correct. The unnamed module is a special module that includes all classes on the classpath. It does not have a module descriptor and can access other unnamed modules but cannot be required by named modules.

- **D)** Core module
  - This option is incorrect. There is no specific type called "core module" in JPMS. JPMS does not categorize modules this way.

- **E)** Primary module
  - This option is incorrect. Similar to "core module," there is no type called "primary module" in JPMS.

---
### Q128　The Java Platform Module System

Which of the following is the correct way to declare a module named `com.example` in the Java Platform Module System (JPMS)?

**選項：**
- A. `module com.example { export com.example.api; }`  
- B. `declare module com.example { }`  
- C. `create module com.example { requires java.base; }`  
- D. `module com.example { }`  （✓ 正確）
- E. `module com.example requires java.base;`  

**答：D。**

**解析：**

**Explanation:**

- **A)** `module com.example { export com.example.api; }`
  - This option is incorrect. In this case, `exports`is missing an "s". The correct syntax to export a package would be `exports com.example.api;`.

- **B)** `declare module com.example { }`
  - This option is incorrect. There is no `declare` keyword used in the JPMS for defining a module.

- **C)** `create module com.example { requires java.base; }`
  - This option is incorrect. The correct syntax does not use the `create` keyword for module declaration.

- **D)** `module com.example { }`
  - This option is correct. This is the correct way to declare a module named `com.example` without any additional requirements.

- **E)** `module com.example requires java.base;`
  - This option is incorrect. The syntax is invalid because it lacks braces `{ }` to define the module body.

---
### Q129　The Java Platform Module System

Which of the following access control statements correctly restricts access to the `com.example.internal` package so that it is only accessible to the `com.example.client` module?

**選項：**
- A. `module com.example { exports com.example.internal to com.example.client; }`  （✓ 正確）
- B. `module com.example { opens com.example.internal to com.example.client; }`  
- C. `module com.example { requires com.example.internal; }`  
- D. `module com.example { provides com.example.internal to com.example.client; }`  
- E. `module com.example { uses com.example.internal; }`  

**答：A。**

**解析：**

**Explanation:**

- **A)** `module com.example { exports com.example.internal to com.example.client; }`
  - This option is correct. The `exports` directive with the `to` clause restricts the export of the `com.example.internal` package to only the specified module `com.example.client`.

- **B)** `module com.example { opens com.example.internal to com.example.client; }`
  - This option is incorrect. The `opens` directive is used for reflection purposes, not for compile-time access control.

- **C)** `module com.example { requires com.example.internal; }`
  - This option is incorrect. The `requires` directive is used to specify module dependencies, not to control package accessibility.

- **D)** `module com.example { provides com.example.internal to com.example.client; }`
  - This option is incorrect. The `provides` directive is used to specify service providers in the module system, not for restricting package access.

- **E)** `module com.example { uses com.example.internal; }`
  - This option is incorrect. The `uses` directive is used to specify service consumers in the module system, not for restricting package access.

---
### Q130　The Java Platform Module System

Given the following module declarations, which statement is correct regarding the accessibility of the `com.example.api` package for deep reflection by the `com.example.client` module?

**選項：**
```java
module com.example {
    exports com.example.api;
    opens com.example.internal to com.example.client;
}
module com.example.client {
    requires com.example;
}
```
- A. The `com.example.client` module can access the `com.example.api` package for deep reflection.  
- B. The `com.example.client` module cannot access the `com.example.api` package for deep reflection.  （✓ 正確）
- C. The `com.example.api` package is opened to all modules for deep reflection.  
- D. The `com.example.internal` package is exported to the `com.example.client` module.  
- E. The `com.example.api` package is exported to the `com.example.client` module for deep reflection.  

**答：B。**

**解析：**

**Explanation:**

- **A)** The `com.example.client` module can access the `com.example.api` package for deep reflection.
  - This option is incorrect. The `com.example.api` package is exported, not opened, meaning it is available for use but not for deep reflection by other modules.

- **B)** The `com.example.client` module cannot access the `com.example.api` package for deep reflection.
  - This option is correct. The `com.example.api` package is not opened for deep reflection; it is only exported for use by other modules.

- **C)** The `com.example.api` package is opened to all modules for deep reflection.
  - This option is incorrect. The `com.example.api` package is exported to all modules, but it is not opened for deep reflection to any module.

- **D)** The `com.example.internal` package is exported to the `com.example.client` module.
  - This option is incorrect. The `com.example.internal` package is opened to `com.example.client` for deep reflection but not exported.

- **E)** The `com.example.api` package is exported to the `com.example.client` module for deep reflection.
  - This option is incorrect. The `com.example.api` package is exported to the `com.example.client` module, but exporting does not include deep reflection capabilities.

---
### Q131　The Java Platform Module System

Which of the following statements is correct regarding core Java modules and their functionalities?

**選項：**
- A. The `java.base` module provides the Swing and AWT libraries for building graphical user interfaces.  
- B. The `java.logging` module is responsible for handling collections, including lists, sets, and maps.  
- C. The `java.desktop` module provides the classes for implementing standard input and output streams.  
- D. The `java.xml` module includes the classes for processing XML documents.  （✓ 正確）
- E. The `java.naming` module provides APIs for accessing and processing annotations.  

**答：D。**

**解析：**

**Explanation:**

- **A)** The `java.base` module provides the Swing and AWT libraries for building graphical user interfaces.
  - This option is incorrect. The `java.base` module does not provide the Swing and AWT libraries. These libraries are provided by the `java.desktop` module.

- **B)** The `java.logging` module is responsible for handling collections, including lists, sets, and maps.
  - This option is incorrect. The `java.logging` module is responsible for the logging framework in Java, not for handling collections. The collections framework is part of the `java.base` module.

- **C)** The `java.desktop` module provides the classes for implementing standard input and output streams.
  - This option is incorrect. The `java.desktop` module includes classes for building graphical user interfaces (Swing and AWT), not for standard input and output streams. Standard I/O is part of the `java.base` module.

- **D)** The `java.xml` module includes the classes for processing XML documents.
  - This option is correct. The `java.xml` module includes classes for processing XML documents, such as those for parsing and transforming XML using APIs like DOM, SAX, and StAX.

- **E)** The `java.naming` module provides APIs for accessing and processing annotations.
  - This option is incorrect. The `java.naming` module provides APIs for accessing naming and directory services (JNDI), not for processing annotations. Annotations are part of the `java.base` module.

---
### Q132　The Java Platform Module System

Which of the following command-line statements correctly compiles the module located in the `src/com.example` directory and outputs the compiled module to the `out` directory?

**選項：**
- A. `javac -d out src/com.example/module-info.java src/com.example/com/example/*.java`  
- B. `javac -sourcepath src -d out com.example/module-info.java com.example/com/example/*.java`  
- C. `javac -d out --module-source-path src -m com.example`  （✓ 正確）
- D. `javac -modulepath out -d src src/com.example/module-info.java src/com.example/com/example/*.java`  
- E. `javac --module-path src --module com.example -d out`  

**答：C。**

**解析：**

**Explanation:**

- **A)** `javac -d out src/com.example/module-info.java src/com.example/com/example/*.java`
  - This option is incorrect. While it correctly specifies the output directory and the source files, it does not use the `--module-source-path` option and does not specify the module name with `-m`.

- **B)** `javac -sourcepath src -d out com.example/module-info.java com.example/com/example/*.java`
  - This option is incorrect. The `-sourcepath` option is not used for module compilation. The correct option should be `--module-source-path`.

- **C)** `javac -d out --module-source-path src -m com.example`
  - This option is correct. The `javac -d out --module-source-path src -m com.example` command correctly compiles the module `com.example` located in the `src` directory and outputs the compiled classes to the `out` directory.

- **D)** `javac -modulepath out -d src src/com.example/module-info.java src/com.example/com/example/*.java`
  - This option is incorrect. The `-modulepath` option is incorrectly placed, and the source and destination directories are swapped.

- **E)** `javac --module-path src --module com.example -d out`
  - This option is incorrect. The command incorrectly uses `--module-path` instead of `--module-source-path` and the module name is specified with `--module` instead of `-m`.

---
### Q133　The Java Platform Module System

Given the following multi-module application structure, which command compiles both modules correctly?

**選項：**
```
src/
??? com.foo/
??  ??? module-info.java
??  ??? com/foo/Foo.java
??? com.bar/
    ??? module-info.java
    ??? com/bar/Bar.java
```
- A. `javac --module-source-path src -d out $(find src -name "*.java")`  （✓ 正確）
- B. `javac -d out --module com.foo,com.bar --module-source-path src`  
- C. `javac -sourcepath src -d out src/com.foo/module-info.java src/com.foo/com/foo/*.java src/com.bar/module-info.java src/com.bar/com/bar/*.java`  
- D. `javac -modulepath src -d out src/com.foo/*.java src/com.bar/*.java`  
- E. `javac --module-source-path src/com.foo,src/com.bar -d out`  

**答：A。**

**解析：**

**Explanation:**

- **A)** `javac --module-source-path src -d out $(find src -name "*.java")`
  - This option is correct. The command `javac --module-source-path src -d out $(find src -name "*.java")` correctly compiles both modules by specifying the module source path and finding all Java files in the source directory.

- **B)** `javac -d out --module com.foo,com.bar --module-source-path src`
  - This option is incorrect. The `--module` option does not accept multiple modules separated by commas in this context.

- **C)** `javac -sourcepath src -d out src/com.foo/module-info.java src/com.foo/com/foo/*.java src/com.bar/module-info.java src/com.bar/com/bar/*.java`
  - This option is incorrect. Although it specifies the source files, it does not use the `--module-source-path` option and is unnecessarily verbose.

- **D)** `javac -modulepath src -d out src/com.foo/*.java src/com.bar/*.java`
  - This option is incorrect. The `-modulepath` option is misused, and the path should point to the directory containing the module source code.

- **E)** `javac --module-source-path src/com.foo,src/com.bar -d out`
  - This option is incorrect. The `--module-source-path` option should point to the base directory (`src`), not individual module directories.

---
### Q134　The Java Platform Module System

Which of the following statements correctly specifies a service provider implementation for the service `com.example.Service` in the `module-info.java` of the `com.provider` module?

**選項：**
- A. `requires com.example.Service with com.provider.ServiceImpl;`  
- B. `exports com.example.Service with com.provider.ServiceImpl;`  
- C. `provides com.example.Service with com.provider.ServiceImpl;`  （✓ 正確）
- D. `uses com.example.Service with com.provider.ServiceImpl;`  

**答：C。**

**解析：**

**Explanation:**

- **A)** `requires com.example.Service with com.provider.ServiceImpl;`
  - This option is incorrect. The `requires` keyword is used to declare dependencies on other modules, not for specifying service providers.

- **B)** `exports com.example.Service with com.provider.ServiceImpl;`
  - This option is incorrect. The `exports` keyword is used to make packages accessible to other modules, not for specifying service providers.

- **C)** `provides com.example.Service with com.provider.ServiceImpl;`
  - This option is correct. The `provides com.example.Service with com.provider.ServiceImpl;` statement correctly specifies that the `com.provider` module provides an implementation of the `com.example.Service`.

- **D)** `uses com.example.Service with com.provider.ServiceImpl;`
  - This option is incorrect. The `uses` keyword is used to declare that the module relies on a service but does not provide an implementation.

---
### Q135　The Java Platform Module System

Which of the following command-line statements correctly describes the `com.example` module using the `--describe-module` option?

**選項：**
- A. `java --describe-module com.example/module-info.java`  
- B. `javac --describe-module com.example`  
- C. `jar --describe-module com.example`  
- D. `java --describe-module com.example`  （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** `java --describe-module com.example/module-info.java`
  - This option is incorrect. The `--describe-module` option is not used with a specific file path like `module-info.java`; it requires a module name.

- **B)** `javac --describe-module com.example`
  - This option is incorrect. The `--describe-module` option is not valid for the `javac` command; it is used with the `java` command.

- **C)** `jar --describe-module com.example`
  - This option is incorrect. The `--describe-module` option is not valid for the `jar` command; it is used with the `java` command.

- **D)** `java --describe-module com.example`
  - This option is correct. The `java --describe-module com.example` command correctly describes the module `com.example` using the `--describe-module` option.

---
### Q136　The Java Platform Module System

Which of the following command-line statements correctly uses `jdeps` to analyze the dependencies of a JAR file named `example.jar`? (Choose all that apply)

**選項：**
- A. `jdeps --list-deps example.jar`  
- B. `jdeps -verbose example.jar`  （✓ 正確）
- C. `jdeps -s example.jar`  （✓ 正確）
- D. `jdeps --check example.jar`  

**答：B、C。**

**解析：**

**Explanation:**

- **A)** `jdeps --list-deps example.jar` 
  - This option is incorrect. The `--list-deps` option does not exist for `jdeps`.

- **B)** `jdeps -verbose example.jar`
  - This option is correct. While `-verbose` is a valid option, it provides more information.

- **C)** `jdeps -s example.jar`
  - This option is correct. The `-s` option with `jdeps` provides a summary of the dependencies of the `example.jar` file.

- **D)** `jdeps --check example.jar`
  - This option is incorrect. The `--check` option does not exist for `jdeps`.

---
### Q137　The Java Platform Module System

Which of the following command-line statements correctly creates a JMOD file from the contents of the `mods/com.example` directory?

**選項：**
- A. `jmod create --class-path mods/com.example --output com.example.jmod`  （✓ 正確）
- B. `jmod --create --class-path mods/com.example --output com.example.jmod`  
- C. `jmod --create --dir mods/com.example --output com.example.jmod`  
- D. `jmod create --dir mods/com.example --output com.example.jmod`  

**答：A。**

**解析：**

**Explanation:**

- **A)** `jmod create --class-path mods/com.example --output com.example.jmod`
  - This option is correct. It uses the correct syntax for the `jmod` command to create a JMOD file. The `create` operation is specified, followed by the `--class-path` option to indicate the source directory, and finally the name of the output JMOD file. This command will create a JMOD file named `com.example.jmod` using the contents of the `mods/com.example` directory.

- **B)** `jmod --create --class-path mods/com.example --output com.example.jmod`
  - This option is incorrect. The `create` operation in the `jmod` command should not be prefixed with `--`. The correct format is `jmod create`, not `jmod --create`. The rest of the command is correct, but this syntax error makes the entire command invalid.

- **C)** `jmod --create --dir mods/com.example --output com.example.jmod`
  - This option is incorrect. First, like option B, it incorrectly uses `--create` instead of `create`. Second, it uses the `--dir` option, which is not used for creating JMOD files, but for specifying the output directory when extracting files from a JMOD. When creating a JMOD file, we use `--class-path` to specify the source directory. The `--output` option is also not a valid option for the `jmod` command.

- **D)** `jmod create --dir mods/com.example --output com.example.jmod`
  - This option is incorrect. It uses the `--dir` option instead of `--class-path` for specifying the source directory, and it incorrectly includes an `--output` option, which is not valid for the `jmod` command. When creating a JMOD file, the output file name is simply specified as the last argument, not with an `--output` option.

---
### Q138　The Java Platform Module System

Which of the following command-line statements correctly creates a custom runtime image using the `jlink` tool with the modules `java.base` and `com.example` and outputs it to the `myimage` directory?

**選項：**
- A. `jlink --module-path java.base:com.example --output myimage`  
- B. `jlink --module-path mods --add-modules java.base,com.example --output myimage`  （✓ 正確）
- C. `jlink --add-modules java.base,com.example --image myimage`  
- D. `jlink --modules java.base,com.example --dir myimage`  

**答：B。**

**解析：**

**Explanation:**

- **A)** `jlink --module-path java.base:com.example --output myimage`
  - This option is incorrect. The `--module-path` option should specify the directory containing the modules, not the module names directly.

- **B)** `jlink --module-path mods --add-modules java.base,com.example --output myimage`
  - This option is correct. The command `jlink --module-path mods --add-modules java.base,com.example --output myimage` correctly specifies the module path and adds the necessary modules, outputting the custom runtime image to the `myimage` directory.

- **C)** `jlink --add-modules java.base,com.example --image myimage` 
  - This option is incorrect. The `--image` option is not valid; the correct option is `--output`.

- **D)** `jlink --modules java.base,com.example --dir myimage`
  - This option is incorrect. The `--modules` option is incorrect; the correct option is `--add-modules`, and `--dir` should be `--output`.

---
### Q139　The Java Platform Module System

Which of the following statements is correct regarding the migration of a legacy application to the Java Platform Module System using unnamed and automatic modules?

**選項：**
- A. An unnamed module can depend on named modules and other unnamed modules.  
- B. Automatic modules must have a `module-info.java` file to be placed on the module path.  
- C. Unnamed modules can export their packages to named modules using `module-info.java`.  
- D. An automatic module is created when a JAR file without a `module-info.java` is placed on the module path, and it can read all other modules. （✓ 正確）

**答：D。**

**解析：**

**Explanation:**

- **A)** An unnamed module can depend on named modules and other unnamed modules.
  - This option is incorrect. An unnamed module can depend on named modules, which is true. However, unnamed modules cannot depend on other unnamed modules. Unnamed modules are created when classes are loaded from the classpath, and they cannot read other unnamed modules. They can only read the named modules of the platform and other modules explicitly added to the module path.

- **B)** Automatic modules must have a `module-info.java` file to be placed on the module path.
  - This option is incorrect. Automatic modules do not require a `module-info.java` file. Their module name is inferred from the JAR file name.

- **C)** Unnamed modules can export their packages to named modules using `module-info.java`. 
  - This option is incorrect. Unnamed modules cannot export packages because they do not use `module-info.java`.

- **D)** An automatic module is created when a JAR file without a `module-info.java` is placed on the module path, and it can read all other modules.
  - This option is correct. An automatic module is created by placing a JAR file without a `module-info.java` on the module path. This automatic module can read all other modules, both named and unnamed.

| 第 14 章 | Localization | 7 |
---
### Q140　Localization

Consider the following code snippet:

**選項：**
```java
import java.util.Locale;
public class LocaleTest {
    public static void main(String[] args) {
        Locale locale1 = new Locale("fr", "CA");
        Locale locale2 = new Locale("fr", "CA", "UNIX2024");
        Locale locale3 = Locale.CANADA_FRENCH;
        System.out.println(locale1.equals(locale2));
        System.out.println(locale1.equals(locale3));
        System.out.println(locale2.equals(locale3));
        System.out.println(locale1.getDisplayName(Locale.ENGLISH));
        System.out.println(locale2.getDisplayName(Locale.ENGLISH));
        System.out.println(locale3.getDisplayName(Locale.ENGLISH));
    }
}
```
What will be the output when this code is executed?
- A.  ``` true true true French (Canada) French (Canada) French (Canada) ``` 
- B.  ``` false true false French (Canada) French (Canada, UNIX2024) French (Canada) ``` 
- C.  ``` false true false French (Canada) French (Canada, UNIX2024) Canadian French ``` （✓ 正確）
- D.  ``` false false false French (Canada) French (Canada, UNIX2024) Canadian French ``` 
- E. The code will throw a `IllegalArgumentException` because `UNIX2024` is not a valid variant.  

**答：C。**

**解析：**

**Explanation:**

- **A)** 
```
true
true
true
French (Canada)
French (Canada)
French (Canada)
```
  - This option is incorrect because it doesn't account for the differences caused by the variant in `locale2`.

- **B)** 
```
false
true
false
French (Canada)
French (Canada, UNIX2024)
French (Canada)
```
  - This option is incorrect because it doesn't correctly represent the display name for `Locale.CANADA_FRENCH`.

- **C)** 
```
false
true
false
French (Canada)
French (Canada, UNIX2024)
Canadian French
```
  - This option is correct. Let's break it down:

    1. `locale1.equals(locale2)` is `false` because `locale2` has a variant (`"UNIX2024"`) while `locale1` doesn't.
    2. `locale1.equals(locale3)` is `true` because `Locale.CANADA_FRENCH` is equivalent to `new Locale("fr", "CA")`.
    3. `locale2.equals(locale3)` is `false` because `locale2` has a variant while `locale3` doesn't.
    4. `locale1.getDisplayName(Locale.ENGLISH)` returns `"French (Canada)"`.
    5. `locale2.getDisplayName(Locale.ENGLISH)` returns `"French (Canada, UNIX2024)"`, including the variant.
    6. `locale3.getDisplayName(Locale.ENGLISH)` returns `"Canadian French"`, which is the special display name for this constant.

- **D)** 
```
false
false
false
French (Canada)
French (Canada, UNIX2024)
Canadian French
```
  - This option is incorrect because it suggests that `locale1` and `locale3` are not equal, which they are.

- **E)** The code will throw a `IllegalArgumentException` because `UNIX2024` is not a valid variant.
  - This option is incorrect. While `UNIX2024` is not a standard ISO 639 variant code, the `Locale` constructor accepts any string as a variant without throwing an exception.

---
### Q141　Localization

Which of the following statements about `Locale` categories is correct?

**選項：**
- A. The `Locale.Category` enum has three values: `DISPLAY`, `FORMAT`, and `LANGUAGE`.  
- B. The `Locale.setDefault(Locale.Category, Locale)` method can only set the default locale for the `FORMAT` category.  
- C. Using `Locale.getDefault(Locale.Category)` always returns the same locale regardless of the category specified.  
- D. The `DISPLAY` category affects the language used for displaying user interface elements, while the `FORMAT` category affects the formatting of numbers, dates, and currencies.  （✓ 正確）
- E. Locale categories were introduced in Java 8 to replace the older `Locale` methods.  

**答：D。**

**解析：**

**Explanation:**

- **A)** The `Locale.Category` enum has three values: `DISPLAY`, `FORMAT`, and `LANGUAGE`.
  - This option is incorrect. The `Locale.Category` enum has only two values: `DISPLAY` and `FORMAT`. There is no `LANGUAGE` category.

- **B)** The `Locale.setDefault(Locale.Category, Locale)` method can only set the default locale for the `FORMAT` category.
  - This option is incorrect. The `Locale.setDefault(Locale.Category, Locale)` method can set the default locale for both the `DISPLAY` and `FORMAT` categories, not just `FORMAT`.

- **C)** Using `Locale.getDefault(Locale.Category)` always returns the same locale regardless of the category specified.
  - This option is incorrect. `Locale.getDefault(Locale.Category)` can return different locales depending on the category specified. The `DISPLAY` and `FORMAT` categories can have different default locales.

- **D)** The `DISPLAY` category affects the language used for displaying user interface elements, while the `FORMAT` category affects the formatting of numbers, dates, and currencies.
  - This option is correct. The `DISPLAY` category indeed affects the language used for displaying user interface elements (like error messages or GUI labels), while the `FORMAT` category affects how numbers, dates, currencies, and other locale-sensitive data are formatted.

- **E)** Locale categories were introduced in Java 8 to replace the older `Locale` methods.
  - This option is incorrect. Locale categories were added to provide more granular control over localization aspects, complementing (not replacing) the existing `Locale` methods.

---
### Q142　Localization

Which of the following statements about Resource Bundles is correct?

**選項：**
- A. Resource bundles can only be stored in `.properties` files.  
- B. The `ResourceBundle.getBundle()` method always throws a `MissingResourceException` if the requested bundle is not found.  
- C. When searching for a resource bundle, Java only considers the specified locale and its language.  
- D. If a key is not found in a specific locale's resource bundle, Java will look for it in the parent locale's bundle.  （✓ 正確）
- E. Resource bundles are loaded dynamically at runtime, so changes to `.properties` files are immediately reflected in the running application.  

**答：D。**

**解析：**

**Explanation:**

- **A)** Resource bundles can only be stored in `.properties` files.
  - This option is incorrect. While `.properties` files are commonly used for resource bundles, Java also supports class-based resource bundles. These are Java classes that extend `ResourceBundle` and provide localized resources programmatically.

- **B)** The `ResourceBundle.getBundle()` method always throws a `MissingResourceException` if the requested bundle is not found.
  - This option is incorrect. The `ResourceBundle.getBundle()` method does not always throw a `MissingResourceException` if the requested bundle is not found. It follows a fallback mechanism, trying to find the most specific bundle, then falling back to more general bundles, and finally to the default bundle.

- **C)** When searching for a resource bundle, Java only considers the specified locale and its language.
  - This option is incorrect. When searching for a resource bundle, Java considers not only the specified locale and its language but also the country, variant, and even the default locale. It follows a well-defined lookup procedure to find the most appropriate bundle.

- **D)** If a key is not found in a specific locale's resource bundle, Java will look for it in the parent locale's bundle.
  - This option is correct. Java implements a parent chain fallback mechanism for resource bundles. If a key is not found in the specific locale's bundle, it will look in the parent locale's bundle. For example, if a key is not found in a `fr_FR` (French France) bundle, it will look in the `fr` (French) bundle, and then in the default bundle.

- **E)** Resource bundles are loaded dynamically at runtime, so changes to `.properties` files are immediately reflected in the running application.
  - This option is incorrect. Resource bundles are typically loaded when `ResourceBundle.getBundle()` is called and then cached. Changes to .properties files are not immediately reflected in a running application. The application usually needs to be restarted or the resource bundle cache cleared for changes to take effect.

---
### Q143　Localization

Consider the following code snippet:

**選項：**
```java
import java.util.*;
import java.io.*;
public class ConfigTest {
    public static void main(String[] args) throws IOException {
        Properties props = new Properties();
        props.setProperty("color", "blue");
        props.setProperty("size", "medium");
        try (OutputStream out = new FileOutputStream("config.properties")) {
            props.store(out, "Config File");
        }
        props.clear();
        System.out.println(props.getProperty("color", "red"));
        try (InputStream in = new FileInputStream("config.properties")) {
            props.load(in);
        }
        System.out.println(props.getProperty("color", "red"));
    }
}
```
What will be the output when this code is executed?
- A.  ``` red blue ``` （✓ 正確）
- B.  ``` blue blue ``` 
- C.  ``` red red ``` 
- D. The code will throw a `FileNotFoundException`. 
- E.  ``` null blue ```  

**答：A。**

**解析：**

**Explanation:**

- **A)** 
```
red
blue
```
  - This option is correct. Let's break down the code execution:
      1. Properties are set and stored in the `config.properties` file.
      2. `props.clear()` removes all properties from the `props` object.
      3. `System.out.println(props.getProperty("color", "red"))` prints `red` because the properties have been cleared, so it uses the default value.
      4. The properties are loaded from the file.
      5. `System.out.println(props.getProperty("color", "red"))` now prints `blue` because it's loaded from the file.

- **B)** 
```
blue
blue
```
  - This option is incorrect. It doesn't account for the `clear()` method call which empties the properties before the first print statement.

- **C)** 
```
red
red
```
  - This option is incorrect. It doesn't account for the successful loading of properties from the file before the second print statement.

- **D)** The code will throw a `FileNotFoundException`.
  - This option is incorrect. The code creates the file in the first `try-with-resources` block, so it should exist for the second block to read from.

- **E)** 
```
null
blue
```
  - This option is incorrect. `getProperty()` returns the default value `red` when the property is not found, not `null`.

---
### Q144　Localization

Consider the following code snippet:

**選項：**
```java
import java.text.MessageFormat;
import java.util.Date;
import java.util.Locale;
public class MessageFormatTest {
    public static void main(String[] args) {
        String pattern = "On {0, date, long}, {1} bought {2,number,integer} {3} for {4,number,currency}.";
        Object[] params = {
            new Date(),
            "Alice",
            3,
            "apples",
            19.99
        };
        MessageFormat mf = new MessageFormat(pattern, Locale.US);
        String result = mf.format(params);
        System.out.println(result);
    }
}
```
Which of the following statements about this code is correct?
- A. The code will throw a `IllegalArgumentException` because the date format is invalid.  
- B. The output will include the date in long format, the name `"Alice"`, the number 3, the word `"apples"`, and the price in US currency format.（✓ 正確）
- C. The `{2,number,integer}` format will display 3 as `"3.0"`.  
- D. The code will not compile because `MessageFormat` doesn't accept a `Locale` in its constructor.  
- E. The `{4,number,currency}` format will always display the price in USD, regardless of the `Locale`.   

**答：B。**

**解析：**

**Explanation:**

- **A)** The code will throw a `IllegalArgumentException` because the date format is invalid. 
  - This option is incorrect. The date format `"long"` is valid in `MessageFormat` and will not throw an exception.

- **B)** The output will include the date in long format, the name `"Alice"`, the number 3, the word `"apples"`, and the price in US currency format.
  - This option is correct. The `MessageFormat` will correctly format each parameter according to the specified pattern:
   - `{0, date, long}` will format the `Date` in long format (`"June 1, 2023"`)
   - `{1}` will simply insert `"Alice"`
   - `{2,number,integer}` will format 3 as an integer
   - `{3}` will insert "apples"
   - `{4,number,currency}` will format 19.99 as currency according to the US locale (`"$19.99"`)

- **C)** The `{2,number,integer}` format will display 3 as `"3.0"`.
  - This option is incorrect. The `{2,number,integer}` format will display 3 as `"3"`, not `"3.0"`. The integer format doesn't include decimal places.

- **D)** The code will not compile because `MessageFormat` doesn't accept a `Locale` in its constructor.
  - This option is incorrect. `MessageFormat` does have a constructor that accepts a `Locale`. The code will compile successfully.

- **E)** The `{4,number,currency}` format will always display the price in USD, regardless of the `Locale`.
  - This option is incorrect. The currency format will use the locale specified in the `MessageFormat` constructor, which in this case is `Locale.US`. If a different locale were used, the currency symbol and formatting could change.

---
### Q145　Localization

Which of the following statements about the `NumberFormat` class in Java is correct?

**選項：**
- A. The `NumberFormat.getCurrencyInstance()` method returns a formatter that can format monetary amounts according to the specified locale's conventions.  （✓ 正確）
- B. `NumberFormat` is a concrete class that can be instantiated directly using its constructor.  
- C. The `setMaximumFractionDigits()` method in `NumberFormat` can only accept values between 0 and 3.  
- D. When parsing strings, `NumberFormat` always throws a `ParseException` if the input doesn't exactly match the expected format.  
- E. The `NumberFormat` class can only format and parse integer values, not floating-point numbers.  

**答：A。**

**解析：**

**Explanation:**

- **A)** The `NumberFormat.getCurrencyInstance()` method returns a formatter that can format monetary amounts according to the specified locale's conventions.
  - This option is correct. The `getCurrencyInstance()` method of `NumberFormat` returns a currency formatter for the specified locale (or the default locale if none is specified). This formatter applies the appropriate currency symbol, digit grouping, and decimal separator according to the locale's conventions.

- **B)** `NumberFormat` is a concrete class that can be instantiated directly using its constructor.
  - This option is incorrect. `NumberFormat` is an abstract class and cannot be instantiated directly. Instead, you obtain instances through its static factory methods like `getInstance()`, `getCurrencyInstance()`, or `getPercentInstance()`.

- **C)** The `setMaximumFractionDigits()` method in `NumberFormat` can only accept values between 0 and 3.
  - This option is incorrect. The `setMaximumFractionDigits()` method is not limited to the range of 0 to 3.

- **D)** When parsing strings, `NumberFormat` always throws a `ParseException` if the input doesn't exactly match the expected format.
  - This option is incorrect. `NumberFormat` is generally lenient when parsing. It will attempt to parse as much of the string as it can recognize as a number, and will only throw a `ParseException` if it can't parse any part of the string as a number.

- **E)** The `NumberFormat` class can only format and parse integer values, not floating-point numbers.
  - This option is incorrect. `NumberFormat` can format and parse both integer and floating-point numbers. It provides methods like `setMaximumFractionDigits()` and `setMinimumFractionDigits()` specifically for handling decimal places in floating-point numbers.

---
### Q146　Localization

Consider the following code snippet:

**選項：**
```java
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
public class DateTimeFormatterTest {
    public static void main(String[] args) {
        LocalDateTime ldt = LocalDateTime.of(2023, 6, 15, 10, 30);
        ZoneId zoneNY = ZoneId.of("America/New_York");
        ZonedDateTime zdtNY = ldt.atZone(zoneNY);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm z VV");
        System.out.println(formatter.format(zdtNY));
        ZoneId zoneTokyo = ZoneId.of("Asia/Tokyo");
        ZonedDateTime zdtTokyo = zdtNY.withZoneSameInstant(zoneTokyo);
        System.out.println(formatter.format(zdtTokyo));
    }
}
```
What will be the output when this code is executed?
- A.  ``` 2023-06-15 10:30 EDT America/New_York 2023-06-15 23:30 JST Asia/Tokyo ``` （✓ 正確）
- B.  ``` 2023-06-15 10:30 EDT New_York 2023-06-15 23:30 JST Tokyo ``` 
- C.  ``` 2023-06-15 10:30 -04:00 America/New_York 2023-06-15 23:30 +09:00 Asia/Tokyo ``` 
- D.  ``` 2023-06-15 10:30 America/New_York 2023-06-15 23:30 Asia/Tokyo ``` 
- E. The code will throw a `DateTimeException` because the formatter pattern is invalid. 

**答：A。**

**解析：**

**Explanation:**

- **A)** 
```
2023-06-15 10:30 EDT America/New_York
2023-06-15 23:30 JST Asia/Tokyo
```
  - This option is correct. Let's break down the formatter pattern:
       - `"yyyy-MM-dd HH:mm"` formats the date and time
       - `"z"` outputs the short name of the zone, like EDT or JST
       - `"VV"` outputs the full time zone ID, like `America/New_York` or `Asia/Tokyo`
       The second line shows the correct time in Tokyo, which is 13 hours ahead of New York.

- **B)** 
```
2023-06-15 10:30 EDT New_York
2023-06-15 23:30 JST Tokyo
```
  - This option is incorrect. The `"VV"` pattern outputs the full time zone ID, not just the city name.

- **C)** 
```
2023-06-15 10:30 -04:00 America/New_York
2023-06-15 23:30 +09:00 Asia/Tokyo
```
  - This option is incorrect. The `"z"` pattern outputs the short name of the zone (EDT, JST), not the offset.

- **D)** 
```
2023-06-15 10:30 America/New_York
2023-06-15 23:30 Asia/Tokyo
```
  - This option is incorrect. It's missing the short zone names (EDT, JST) that the `"z"` pattern should output.

- **E)** The code will throw a `DateTimeException` because the formatter pattern is invalid.
  - This option is incorrect. The formatter pattern is valid and will not throw an exception.
