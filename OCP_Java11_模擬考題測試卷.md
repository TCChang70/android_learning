# OCP Java 11 (1Z0-819) 模擬考題測試卷

- 題數：75 題
- 作答時間：建議 120 分鐘
- 答題方式：請於各題選出唯一正確答案（多選題會特別標示「Choose N」）
- 答案卷請見文末「答案卷」章節

---

## Chapter 1 - Working with Java Data Types（共 6 題）

### Q1
How many of these compile?

```java
18: Comparator<String> c1=(j,k)->0;
19: Comparator<String> c2=(String j,String k)->0;
20: Comparator<String> c3=(var j,String k)->0;
21: Comparator<String> c4=(var j,k)->0;
22: Comparator<String> c5=(var j,var k)->0;
```

- A. 0
- B. 1
- C. 2
- D. 3
- E. 4
- F. 5

<!-- 答案：D -->

### Q2
What is the output of the following application?

```java
public class Airplane{
	static int start=2;
	final int end;
	public Airplane(int x)
	{
		x=4;
		end=x;
	}
	
	public void fly(int distance)
	{
		System.out.print(end-start+" ");
		System.out.print(distance);	
	}
	
	public static void main(String... start)
	{
		new Airplane(10).fly(5);
	}
}
```

- A. 2 5
- B. 8 5
- C. 6 5
- D. The code does not compile.
- E. None of the above

<!-- 答案：A -->

### Q3
Given the code fragment:

```java
var i=10;
var j=5;
i+=(j*5+i)/j-2;
System.out.println(i);
```

What is the result?

- A. 5
- B. 11
- C. 21
- D. 23
- E. 15

<!-- 答案：E -->

### Q4
Given:

```java
public class Tester{
	public static void main(String[] args){
		StringBuilder sb=new StringBuilder(5);
		sb.append("HOWDY");
		sb.insert(0,' ');
		sb.replace(3,5,"LL");
		sb.insert(6,"COW");
		sb.delete(2,7);
		System.out.println(sb.length());
	}
}
```

What is the result?

- A. 5
- B. 3
- C. An exception is thrown at runtime.
- D. 4

<!-- 答案：D -->

### Q5
Given:

```java
public class StrBldr{
	static StringBuilder sb1=new StringBuilder("yo ");
	StringBuilder sb2=new StringBuilder("hi ");
	
	public static void main(String[] args){
		sb1=sb1.append(new StrBldr().foo(new StringBuilder("hey")));
		System.out.println(sb1);
	}
	
	StringBuilder foo(StringBuilder s){
		System.out.print(s+" oh " +sb2);
		return new StringBuilder("ey");
	}
}
```

What is the result?

- A. oh hi hey
- B. hey oh hi
- C. A compile time error occurs.
- D. hey oh hi yo ey
- E. yo ey
- F. hey oh hi ey

<!-- 答案：D -->

### Q6
Given:

```java
public class Test{
	public void process(byte v){
		System.out.println("Byte value "+v);
	}
	public void process(short v){
		System.out.println("Short value "+v);
	}
	public void process(Object v){
		System.out.println("Object value "+v);
	}
	public static void main(String[] args){
		byte x=12;
		short y=13;
		new Test().process(x+y);// line 1
	}
}
```

What is the output?

- A. Object value 25
- B. Byte value 25
- C. Short value 25
- D. The compilation fails due to an error in line 1

<!-- 答案：A -->

---

## Chapter 2 - Controlling Program Flow（共 3 題）
### Q7
Variables declared as which of the following are never permitted in a switch statement?
（Choose two）

- A. var
- B. double
- C. int
- D. String
- E. char
- F. Object

<!-- 答案：B, F -->

### Q8
What is the output of the following application?

```java
package planning;
 public class ThePlan{
	 var plan=1;
	 plan=plan++ + --plan;
	 if(plan==1){
		 System.out.print("Plan A");
	 }else{ if(plan==2) System.out.print("Plan B");
	 }else System.out.print("Plan C");}
	}
}
```

- A. Plan A
- B. Plan B
- C. Plan C
- D. The class does not compile
- E. None of the above

<!-- 答案：D -->

### Q9
Given:

```java
int i=10;
do {
	for(int j=i/2;j>0;j--){
		System.out.print(j+" ");
	}
	i-=2;
}while(i>0);
```

What is the result?

- A. 5 4 3 2 1
- B. nothing
- C. 5
- D. 5 4 3 2 1 4 3 2 1 3 2 1 2 1 1

<!-- 答案：D -->

---

## Chapter 3 - Java Object Oriented Approach（共 18 題）

### Q10
Which statement about the Elephant program is correct?

```java
package stampede;
interface Long{
	Number length();
}

public class Elephant{
	public class Trunk implements Long{
		public Number length(){ return 6;} //k1
	}
	
	public class MyTrunk extends Trunk{		//k2
		public Integer length(){ return 9;} //k3
	}
	public static void charage(){
		System.out.print(new MyTrunk().length());
	}
	
	public static void main(String[] cute){
		new Elephant().charge();			//k4
	}
}
```

- A. It compiles and prints 6.
- B. The code does not compile because of line k1.
- C. The code does not compile because of line k2.
- D. The code does not compile because of line k3.
- E. The code does not compile because of line k4.
- F. None of the above

<!-- 答案：F -->

### Q11
What is the output of the following application?

```java
package sports;
abstract class Ball{
	protected final int size;
	public Ball(int size){
		this.size=size;
	}
}

interface Equipment{}

public class SoccerBall extends Ball implements Equipment{
	public SoccerBall(){
		super(5);
	}
	public Ball get(){ return this; }
	public static void main(String[] passes){
		var equipment=(Equipment)(Ball)new SoccerBall().get();
		System.out.print(((SoccerBall)equipment).size);
	}
}
```

- A. 5
- B. The code does not compile due to an invalid cast
- C. The code does not compile due to a different reason
- D. The code compiles but throws a ClassCastException at runtime

<!-- 答案：A -->

### Q12
Given:

```java
public class GameObject{
	public Object[] move(int x,int y){
		System.out.println("Move GameObject");
		return new Integer[]{x+10,y+10};
	}	
}
```

and

```java
public class Avatar extends GameObject{
	public Object[] move(Number x,Number y){
		System.out.println("Move Character");
		return super.move(x.intValue(),y.intValue());
	}
	
	public static void main(String... args)
	{
		var character=new Avatar();
		character.move(10.0,10.0);
		character.move(10,10);
	}
}
```

What is the result?

- A.
```java
Move Character
Move GameObject
Move GameObject
```
- B. `Move GameObject` `Move GameObject`
- C.
```java
Move GameObject
Move Character
Move GameObject
```
- D. `Move GameObject`

<!-- 答案：A -->

### Q13
Given:

```java
public class Menu{
	enum Machine{
		AUTO("Truck"),MEDICAL("Scanner");
		private String type;
		private Machine(String type){
			this.type=type;
		}
		private void setType(String type){
			this.type=type;			//line 1
		}
		private String getType()
		{
			return type;
		}
	}
	
	public static void main(String[] args)
	{
		Machine.AUTO.setType("Sedan");		//line 2
		for(Machine p:Machine.values())
		{
			System.out.println(p+": "+p.getType());	//line 3
		}	
	}
}
```

What is the result?

- A. The compilation fails due to an error on line 3.
- B. The compilation fails due to an error on line 2.
- C.
```java
AUTO: Truck
MEDICAL: Scanner
```
- D. An exception is throw at run time
- E. The compilation fails due to an error on line 1
- F.
```java
AUTO: Sedan
MEDICAL:Scanner
```

<!-- 答案：F -->

### Q14
Given:

```java
class Scope{
	static int myint=666;
	public static void main(String[] args){
		int myint=myint;
		System.out.println(myint);
	}
}
```

Which is true?

- A. Code compiles but throws a runtime exception when run.
- B. It prints 666
- C. The code compiles and runs successfully but with a wrong answer(i.e., a bug).
- D. The code does not compile successfully

<!-- 答案：D -->

### Q15
Given:

```java
package test.t1;
public class A{
	public int x=42;
	protected A(){}      //line 1
}
```

and

```java
package test.t2;
import test.t1.*;
public class B extends A{
	int x=17;				//line 2
	public B(){super();}	//line 3
}
```

and

```java
package test;
import test.t1.*;
import test.t2.*;
public class Tester{
	public static void main(String[] args){
		A obj=new B();					//line 4
		System.out.println(obj.x);		//line 5	
	}
}
```

What is the result?

- A. The compilation fails due to an error in line 4
- B. 17
- C. The compilation fails due to an error in line 2
- D. The compilation fails due to an error in line 3
- E. The compilation fails due to an error in line 1
- F. The compilation fails due to an error in line 5
- G. 42

<!-- 答案：G -->

### Q16
Given:

```java
public class DNASynth{
	int aCount;
	int tCount;
	int cCount;
	int gCount;
	
	DNASynth(int aCount,int tCount,int c,int g){
		// line 1
	}
	int setCCount(int c){
		return c;
	}
	void setGCount(int gCount){
		this.gCount=gCount;
	}
}
```

Which two lines of code when inserted in line 1 correctly modifies instance variables?
（Choose two）

- A. tCount=tCount;
- B. cCount=setCCount(c);
- C. setCCount(c)=cCount;
- D. aCount=aCount;
- E. setGCount(g);

<!-- 答案：B, E -->

### Q17
Given:

```java
public class Price{
	private final double value;
	public Price(String value){
		this(Double.parseDouble(value));
	}
	public Price(double value){
		this.value=value;
	}
	public Price(){}
	public double getValue(){ return value;}
	public static void main(String[] args)
	{
		Price p1=new Price("1.99");
		Price p2=new Price(2.99);
		Price p3=new Price();
		System.out.println(p1.getValue()+","+p2.getValue()+","+p3.getValue());
	}
}
```

What is the result?

- A. 1.99,2.99,0.0
- B. 1.99,2.99
- C. The compilation fails
- D. 1.99,2.99,0

<!-- 答案：C -->

### Q18
Given:

```java
public interface Builder{
	public A build(String str);
}
```

and

```java
public class BuilderImpl implements Builder{
	@Override
	public B build(String str){
		return new B(str);
	}
}
```

Assuming that this code compiles correctly, which three statements are true?
（Choose three）

- A. A cannot be abstract.
- B. A is a subtype of B.
- C. B cannot be final.
- D. B is a subtype of A.
- E. B cannot be abstract.
- F. A cannot be final.

<!-- 答案：D, E, F -->

### Q19
Given:

```java
public class Foo{
	public void foo(Collection arg){
		System.out.println("Bonjour le monde");	
	}
	
}
```

and

```java
public class Bar extends Foo{
	public void foo(Collection arg){
		System.out.println("Hello world");	
	}
	public void foo(List arg){
		System.out.println("Hello Mundol!");	
	}
}
```

and

```java
Foo f1=new Foo();
Foo f2=new Bar();
Bar b1=new Bar();
List<String> li=new ArrayList<>();
```

Which three are correct?
（Choose three）

- A. f2.foo(li) prints Bonjour le monde
- B. f1.foo(li) prints Hola Mundo!
- C. f2.foo(li) prints Hola Mundo!
- D. b1.foo(li) prints Hola Mundo!
- E. f2.foo(li) prints Hello world!
- F. b1.foo(li) prints Hello world!
- G. f1.foo(li) prints Bonjour le monde!
- H. f1.foo(li) prints Hello world!
- I. b1.foo(li) prints Bonjour le monde!

<!-- 答案：D, E, G -->

### Q20
Given:

```java
public class Test{
	public static void main(String[] args){
		AnotherClass ac=new AnotherClass();
		SomeClass sc=new AnotherClass();
		ac=sc;
		sc.methodA();
		ac.methodA();
	
	}
}

class SomeClass{
	public void methodA(){
		System.out.println("SomeClass#methodA()");	
	}
}

class AnotherClass extends SomeClass{
	public void methodA(){
		System.out.println("AnotherClass#methodA");
	}
}
```

What is the Result?

- A. A ClassCastException is thrown at runtime.
- B.
```java
SomeClass#methodA()
AnotherClass#methodA()
```
- C.
```java
AnotherClass#methodA()
AnotherClass#methodA()
```
- D. The compilation fails
- E.
```java
AnotherClass#methodA()
SomeClass#methodA()
```
- F.
```java
SomeClass#methodA()
SomeClass#methodA()
```

<!-- 答案：D -->

### Q21
Given:

```java
interface AbilityA{
	default void action(){
		System.out.println("a action");
	}
}
```

and

```java
interface AbilityB{
	void action();
}
```

and

```java
public class Test implements AbilityA,AbilityB{ // line 1
	public void action() {
		System.out.println("ab action");
	}
	public static void main(S[] args){ 
		AbilityB x=new Test(); 			//line 2
		x.action();	
	}
}
```

What is the result?

- A. The compilation fails on line 1
- B. An exception is thrown at run time
- C. The compilation fails on line 2
- D. a action
- E. ab action

<!-- 答案：E -->

### Q22
Given the enum declaration:

```java
1.enum Alphabet{
2.   A,B,C
3.
4.}
```

Example this code:

```java
System.out.println(Alphabet.getFirstLetter());
```

What code should be written at line 3 to make this code print A?

- A. `static String getFirstLetter() { return A.toString();}`
- B. `static String getFirstLetter() { return Alphabet.values().toString();}`
- C. `String getFirstLetter() { return A.toString();}`
- D. `final String getFirstLetter() { return A.toString();}`

<!-- 答案：A -->

### Q23
Given:

```java
public interface ExampleInterface{}
```

Which two statements are valid to be written in this interface?
（Choose two）

- A. `public String method();`
- B.
```java
public void methodF(){
		System.out.println("F");
}
```
- C. `public int x;`
- D. `final void methodE()`
- E.
```java
final void methodG(){
		System.out.println("G");
}
```
- F. `private abstract void methodC();`
- G. `public abstract void methodB();`

<!-- 答案：A, G -->

### Q24
Given:

```java
public class Person{
	private String name;
	private Person child;
	public Person(String name,Person child)
	{
		this(name);
		this.child=child;
	}
	public Person(String name){
		this.name=name;
	}
	public String toString(){
		return name+" "+child;
	}	

}
```

and

```java
public class Tester{
	public static Person createPeople(){
		Person jane=new Person("Jane");
		Person john=new Person("John",jane);
		return jane;
	}
	
	public static Person createPerson(Person person){
		person=new Person("Jack",person);
		return person;	
	}
	public static void main(String[] args)
	{
		Person person=createPeople();
		// line 1
		person=createPerson(person);
		// line 2
		String name=person.toString();
		System.out.println(name);	
	}
}
```

Which statement is true?

- A. The memory allocated for John object can be reused at line 1.
- B. The memory allocated for Jack object can be reused at line 2.
- C. The memory allocated for Jane object can be reused at line 2.
- D. The memory allocated for Jane object can be reused at line 1.

<!-- 答案：A -->

### Q25
Given:

```java
public interface A{
	public Iterable a();
}

public interface B extends A{
	public Collection a();
}
public interface C extends A{
	public Path a();
}
public interface D extends B,C{

}
```

Why does D cause a compilation error?

- A. D does not define any method.
- B. D inherits a() only from C.
- C. D inherits a() from B and C but the return types are incompatible.
- D. D extends more than one interface

<!-- 答案：C -->

### Q26
Given the code fragment:

```java
8. public class Test {
9.    private final int x=1;
10.   static final int y;
11.   public Test() {
12.       System.out.print(x);
13.       System.out.print(y);
14.   }
15.   public static void main(String args[]) {
16.        new Test();
17.   }
18.}
```

What is the result?

- A. The compilation fails at line 13
- B. The compilation fails at line 9
- C. The compilation fails at line 16
- D. 1
- E. 10

<!-- 答案：A -->

### Q27
Given:

```java
1. interface Pastry {
2.   void getIngredients();
3. }
4. abstract class Cookie implements Pastry{}

6. class ChocolateCookie implements Cookie {
7.    public void getIngredients(){}
8. }
9. class CoconutChoolateCookie extends ChocolateCookie {
10.   void getIngredients(int x){}
11. }
```

Which is true?

- A. The compilation fails due to an error in line 10.
- B. The compilation fails due to an error in line 9.
- C. The compilation fails due to an error in line 4.
- D. The compilation fails due to an error in line 6.
- E. The compilation succeeds
- F. The compilation fails due to an error in line 7.
- G. The compilation fails due to an error in line 2

<!-- 答案：D -->

---

## Chapter 4 - Exception Handling（共 9 題）

### Q28
Given the following application, which specific type of exception will be printed in the stack trace at runtime?

```java
package carnival;
public class WhackAnException{
	public static void main(String... hammer)
	{
		try{
			throw new ClassCastException();
		}catch(IllegalArgumentException e){
			throw new IlleaglArgumentException();
		}catch(RuntimeException e){
			throw new NullPointerException();
		}finally{
			throw new RuntimeException();
		}
	
	}
}
```

- A. ClassCastException
- B. IllegalArgumentException
- C. NullPointerException
- D. RuntimeException
- E. The code does not compile.
- F. None of the above

<!-- 答案：D -->

### Q29
Given the following application, what is the name of the class printed at line e1?

```java
package canyon;
final class FallenException extends Exception{}
final class HikingGer implements AutoCloseable{
	@Override public void close() throws Exception{
		throw new FallenException();
	}
}

public class Cliff{
	public final void climb() throws Exception{
		try(HikingGear gear=new HikingGear()){
			throw new RuntimeException();
		}	
	}
	public static void main(String... rocks){
		try{
			new Cliff().climb();		
		}catch(Throwable t){
			System.out.println(t); //e1
		}	
	}
}
```

- A. canyon.FallenException
- B. java.lang.RuntimeException
- C. The code does not compile.
- D. The code compile, but the answer cannot be determined until runtime.
- E. None of the above

<!-- 答案：B -->

### Q30
Given:

```java
import java.io.FileNotFoundException;
import java.io.IOException;

public class Tester{
	public static void main(String[] args){
		try{
			doA();
		}//line 1
	}
	private static void doA() throws Exception,IndexOutOfBoundsException{
		if(false){
			throw new FileNotFoundException();
		}else{
			throw now IndexOutOfBoundsException();
		}
	}
}
```

What must be added in line 1 to compile this class?

- A. `catch(FileNotFoundException | Exception e){}`
- B.
```java
catch(FileNotFoundException e){}
catch(IndexOutOfBoundsException e){}
```
- C. `catch(Exception e){}`
- D.
```java
catch(IndexOutOfBoundsEexception e){}
catch(FileNotFoundException e){}
```
- E. `catch(FileNotFoundException | IndexOutBoundException e){}`

<!-- 答案：C -->

### Q31
Given:

```java
   char[] characters=new char[100];
   try(FileReader reader=new FileReader("file_to_path");){
	// line 1
	  System.out.println(String.valueOf(characters));
	} catch(IOException e){
	  e.printStackTrace();	
	}
```

You want to read data through the reader object.

Which statement inserted on line 1 will accomplish this?

- A. reader.readLine();
- B. characters=reader.read();
- C. reader.read(characters);
- D. characters.read();

<!-- 答案：C -->

### Q32
Given:

```java
public class ExSuper extends Exception{
	private final int eCode;
	public ExSuper(int eCode,Throwable cause){
		super(cause);
		this.eCode=eCode;
	}
	
	public ExSuper(int eCode,String msg,Throwable cause){
		super(msg,cause);
		this.eCode=eCode;	
	}
	
	public String getMessage(){
		return this.eCode+": "+super.getMessage()+"_"+this.getCause().getMessage();	
	}
}
	
public class ExSub extends ExSuper{
	public ExSub(int eCode,String msg,Throwable cause)
	{
		super(eCode,msg,cause);
	}	
}
```

and the code fragment:

```java
try{
	String param1="oracle";
	if(param1.equalsIgnoreCase("oracle")) {
		throw new ExSub(9001, "APPLICATION ERROR-9001",new FileNotFoundException("MyFile.txt"));	
	}
		throw new ExSuper(9001, new FileNotFoundException("MyFile.txt")); // Line 1
}
catch(ExSuper ex)
{
	System.out.println(ex.getMessage());
}
```

What is the result?

- A. Compilations fails at Line 1;
- B. 9001: java.io.FileNotFoundException:MyFile.txt-MyFile.txt
- C. 9001: APPLICATION ERROR-9001-MyFile.txt
- D.
```java
9001: APPLICATION ERROR-9001-MyFile.txt
9001: java.io.FileNotFoundException: MyFile.txt-MyFile.txt
```

<!-- 答案：C -->

### Q33
Given:

```java
public class Option{
	public static void main(String[] args) {
		System.out.println("Ans: "+convert("a").get());	
	}
	
	private static Optional<Integer> convert(String s) {
		try{
			return Optional.of(Integer.parseInt(s));		
		} catch(Exception e) {
			return Optional.empty();
		}	
	}
}
```

What is the result?

- A. Ans:
- B. Ans: a
- C. A java.util.NoSuchElementException is thrown at run time
- D. The compilation fails

<!-- 答案：C -->

### Q34
Given:

```java
import java.io.*;
public class Tester {
	public static void main(String args[])
	{
		try{
			doA();
			doB();	
		} catch(IOException e) {
			System.out.print("C");
			return;	
		} finally {
			System.out.print("d");	
		}
		System.out.print("f");
	}
	private static void doA() {
		System.out.print("a");
		if(false) {
			throw new IndexOutOfBoundsException();
		}	
	}
	private static void doB() throws FileNotFoundException {
		System.out.print("b");
		if(true) {
			throw new FileNotFoundException();
		}	
	}
}
```

What is the result?

- A. The compilation fails.
- B. adf
- C. abd
- D. abcd
- E. abdf

<!-- 答案：D -->

### Q35
Given:

```java
public class Test{
	private int num=1;
	private int div=0;
	
	public void divide() {
		try {
			num=num/div;
			System.out.print("Exception");
		}
		catch(ArithmeticException ae) { num=100; }
		catch(Exception e) { num=200; }
		finally { num=300; }
		System.out.print(num);	
	}
	public static void main(String args[])
	{
		Test test=new Test();
		test.divide();	
	}
}
```

What is the output?

- A. 200
- B. 100
- C. 300
- D. Exception

<!-- 答案：C -->

### Q36
Given:

```java
public class Test {
	private int sum;
	public int compute() {
		int x=0;
		while(x<3) {
			sum+=++x;
		}
		return sum/4;	
	}
	
	public static void main(String[] args) {
		Test t=new Test();
		int sum=t.compute();
		sum=t.compute();
		System.out.print(sum);
	}
}
```

What is the output?

- A. 6
- B. 3
- C. An exception is thrown at runtime
- D. 9

<!-- 答案：B -->

---

## Chapter 5 - Working with Arrays and Collections（共 4 題）

### Q37
Which of the following fills in the blank so this code compiles?

```java
public static void getExceptions(Collection<__> coll){
	coll.add(new RuntimeException());
	coll.add(new Exception());
}
```

- A. ?
- B. ? extends Exception
- C. ? super Exception
- D. None of the above

<!-- 答案：C -->

### Q38
What does the following output?

```java
18: List<String> list=List.of(
19:  "Mary","had","a","little","lamb");
20:	Set<String> set=new HashSet<>(list);
21: set.addAll(list);
22: for(String sheep:set)
23:		if(sheep.length()>1)
24:			set.remove(sheep);
25: System.out.println(set);
```

- A. [a,lamb,had,Mary,little]
- B. [a]
- C. [a,a]
- D. The code does not compile.
- E. The code throws an exception at runtime

<!-- 答案：E -->

### Q39
Given:

```java
ArrayList<Integer> a1=new ArrayList<>();
a1.add(1);
a1.add(2);
a1.add(3);
Iterator<Integer> itr=a1.iterator();
while(itr.hasNext()) {
	if(itr.next()==2) {
			a1.remove(2);
		System.out.print(itr.next());
	}
}
```

What is the result?

- A. 1 2 followed by an exception
- B. 1 2 3 followed by an exception
- C. A ConcurrentModificationException is thrown at run time
- D. 1 2 4 5

<!-- 答案：C -->

### Q40
Given:

```java
import java.util.ArrayList;
import java.util.Arrays;
public class NewMain{
	public static void main(String[] args) {
		String[] catNames={"abyssinian","oxicat",
			"korat","laperm","bengal","sphynx"};
		var cats=new ArrayList<>(Arrays.asList(catNames));
		cats.sort((var a,var b)->-a.compareTo(b));
		cats.forEach(System.out::println);
	}
}
```

What is the result?

- A. nothing
- B.
```java
sphynx
oxicat
laperm
korat
bengal
abyssinian
```
- C.
```java
abyssinian
oxicat
korat
laperm
bengal
sphynx
```
- D.
```java
abyssinian
bengal
korat
laperm
oxicat
sphynx
```

<!-- 答案：B -->

---

## Chapter 6 - Working with Streams and Lambda（共 10 題）

### Q41
What is a possible output of the following application?

```java
import java.util.*;
import java.util.stream.*;
public class Thermometer {
	private String feelsLike;
	private double temp;
	@Override public String toString(){ return feelsLike;}
	// Constructor/Getters/Setters Omitted
	
	
	public static void main(String... season) {
		var readings=List.of(new Thermometer("HOT!",72),
			new Thermometer("Too Cold",0),
			new Thermometer("Just right!",72));
		readings
			.parallelStream()			   // k1
			.collect(Collectors.groupingByConcurrent(
				Thermometer::getTemp))     // k2
			.forEach(System.out::println); // k3
	
	}
}
```

- A. {0.0=[Cold!], 72.0=[Hot!, Just right!]}
- B. {0.0=[Cold!], 72.0=[Just right!], 72.0=[HOT!]}
- C. The code does not compile because of line k1
- D. The code does not compile because of line k2
- E. The code does not compile because of line k3
- F. None of the above

<!-- 答案：E -->

### Q42
What is the output of the following application?

```java
package lot;
import java.util.function.*;

public class Warehouse {
	private int quantity=40;
	private final BooleanSupplier stock;
	{
		stock=()->quantity>0;	
	}
	
	public void checkInventory() {
		if(stock.get())
			System.out.print("Plenty!");
		else {
		   System.out.print("On Backorder!");
		}	
	}
	
	
	public static void main(String... widget) {
		final Warehouse w13=new Warehouse();
		w13.checkInventory();	
	}
}
```

- A. Plenty
- B. On Backorder!
- C. The code does not compile because of the checkInventory() method.
- D. The code does not compile for a different reason

<!-- 答案：C -->

### Q43
Which code fragment represents a valid Comparator implementation?

- A.
```java
new Comparator<String>() {
	public int compareTo(String str1,String str2) {
		return str1.compareTo(str2);
	}
};
```
- B.
```java
public class Comps implements Comparator {
	public boolean compare(Object obj1,Object obj2) {
		return obj1.equals(obj2);		
	}
}
```
- C.
```java
public class Comps implements Comparator {
	public int compare(String str1,String str2) {
		return str1.length()-str2.length();
	}
}
```
- D.
```java
new Comparator<String>() {
	public int compare(String str1,String str2) {
		return str1.compareTo(str2);		
	}
};
```

<!-- 答案：D -->

### Q44
Given:

```java
var fruits=List.of("apple","orange","banana","lemon");
Optional<String> result=fruits.stream().filter(f->f.contains("n")).findAny();// line 1

System.out.println(result.get());
```

You replace the code on line 1 to use parallelStream.

Which one is correct?

- A. The compilation fails.
- B. The code will produce the same result
- C. A NoSuchElementException is thrown at run time
- D. The code may produce a different result

<!-- 答案：D -->

### Q45
Given the code fragment:

```java
 1. var list=List.of(1,2,3,4,5,6,7,8,9,10);
 2. UnaryOperator<Integer> u=i->i*2;
 3. list.replaceAll(u);
```

Which can replace line 2?

- A. `UnaryOperator<Integer> u=var i->{return i*2;}`
- B. `UnaryOperator<Integer> u=i->{return i*2;}`
- C. `UnaryOperator<Integer> u=(var i)->(i*2);`
- D. `UnaryOperator<Integer> u=(int i)->i*2;`

<!-- 答案：C -->

### Q46
Which two are valid statements?
（Choose two）

- A. `BiPredicate<Integer,Integer> test=(final var x,y)->(x.equals(y));`
- B. `BiPredicate<Integer,Integer> test=(Integer x,final Integer y)->(x.equals(y));`
- C. `BiPredicate<Integer,Integer> test=(final Integer var x,var y)->(x.equals(y));`
- D. `BiPredicate<Integer,Integer> test=(var x,final var y)->(x.equals(y));`
- E. `BiPredicate<Integer,Integer> test=(Integer var x,final var y)->(x.equals(y));`

<!-- 答案：B, D -->

### Q47
Why would you choose to use a peek operation instead of a forEach operation on a Stream?

- A. to process the current item and return a stream
- B. to process the current item and return void
- C. to remove an item from the beginning of the stream
- D. to remove an item from the end of the stream

<!-- 答案：A -->

### Q48
Given the content from `lines.txt`

```
C
C++
Java
Go
Kotlin
```

and

```java
String fileName="lines.txt";
List<String> list=new ArrayList<>();
try(Stream<String> stream=Files.lines(Paths.get(fileName))) {
		list=stream
		           .filter(line->!line.equalsIgnoreCase("JAVA"))
		           .map(String::toUpperCase)
		           .collect(Collectors.toList());
	} catch(IOException e) {

	}
list.forEach(System.out::println);
```

What is the Result?

- A.
```java
C
C++
Go
Kotlin
```
- B. `JAVA`
- C.
```java
C
C++
GO
KOTLIN
```
- D.
```java
C
C++
JAVA
GO
KOTLIN
```

<!-- 答案：C -->

### Q49
Given:

```java
public class Employee {
	private String name;
	private String neighborhood;
	private int salary;
	//Constructors and setter and getter methods go here
}
```

and the code fragment:

```java
List<Employee> roster=new ArrayList<>();
Predicate<Employee> p=e->e.getSalary()>30;
Function<Employee,Optional<String>> f=
      e->Optional.ofNullable(e.getNeighborhood());
```

Which two objects group all employees with a salary greater than 30 by neighborhood?
（Choose two）

- A.
```java
Map<Optional<String>,List<Employee>> r4=roster.stream()
       .collect(Collectors.groupingBy(f,Collectors.filtering(p,Collectors.toList())));
```
- B.
```java
Map<Optional<String>,List<Employee>> r2=roster.stream().filter(p)
       .collect(Collectors.groupingBy(f,Employee::getNeighborhood));
```
- C.
```java
Map<Optional<String>,List<Employee>> r5=roster.stream()
	       .collect(Collectors.groupingBy(Employee::getNeighborhood,
	               Collectors.filtering(p,Collectors.toList())));
```
- D.
```java
Map<Optional<String>,List<Employee>> r3=roster.stream().filter(p)
       .collect(Collectors.groupingBy(p));
```
- E.
```java
Map<String,List<Employee>> r1=roster.stream()
       .collect(Collectors.groupingBy(Employee::getNeighborhood,
               Collectors.filtering(p,Collectors.toList())));
```

<!-- 答案：A, E -->

### Q50
Given the code fragment:

```java
public class Main {
	public static void main(String[] args)
	{
		List<String> fruits=List.of("banana","orange","apple","lemon");
		Stream<String> s1=fruits.stream();
		Stream<String> s2=s1.peek(i->System.out.print(i+" "));
		System.out.println("--------");
		Stream<String> s3=s2.sorted();
		Stream<String> s4=s3.peek(i->System.out.print(i+" "));
		System.out.println("--------");
		String strFruits=s4.collect(Collectors.joining(","));	
	}
}
```

What is the output?

- A.
```java
--------
--------
banana orange apple lemon apple banana lemon orange
```
- B.
```java
banana orange apple lemon
------
apple banana lemon orange
------
```
- C.
```java
-----
banana orange apple lemon
-----
apple banana lemon orange
```
- D.
```java
-----
-----
```
- E.
```java
banana orange apple lemon apple banana lemon orange
------
------
```
<!-- 答案：A -->

---

## Chapter 7 - Java Platform Module System（共 5 題）

### Q51
What statements are true about `requires mandated java.base`?
（Choose two）

- A. This output is expected when running the `java --list-modules` command.
- B. This output is expected when running the `java --show-module-resolution` command.
- C. This output is expected when running the `jdeps` command.
- D. This output is expected when running the `jmod` command.
- E. All modules will include this in the output.
- F. Some modules will include this in the output.

<!-- 答案：C, E -->

### Q52
What is the name of a file that declares a module?

- A. mod.java
- B. mod-data.java
- C. mod-info.java
- D. module.java
- E. module-data.java
- F. module-info.java

<!-- 答案：F -->

### Q53
Suppose you have a module that contains a class with a call to `exports(ChocolateLab.class)`. Which part of the module service contains this class?

- A. Consumer
- B. Service locator
- C. Service provider
- D. Service provider interface
- E. None of the above

<!-- 答案：E -->

### Q54
How many of these keywords can be used in a module-info.java file: `close, export, import, require, and uses`?

- A. None
- B. One
- C. Two
- D. Three
- E. Four
- F. Five

<!-- 答案：B -->

### Q55
Which module provides the foundational APIs of the Java SE Platform?

- A. java.lang
- B. java.base
- C. java.object
- D. java.se

<!-- 答案：B -->

---

## Chapter 8 - Concurrency（共 4 題）

### Q56
What is the output of the following application?

```java
import java.util.*;

public class SearchList<T> {
	private List<T> data;
	private boolean foundMatch=false;
	public SearchList(List<T> list) {
		this.data=list;	
	}
	public void exists(T v,int start,int end) {
		if(end-start==0) {}
		else if(end-start==1) {
			foundMatch=foundMatch || v.equals(data.get(start));
		} else {
			final int middle=start+(end-start)/2;
			new Thread(()->exists(v,start,middle)).run();
			new Thread(()->exists(v,middle,end)).run();
		}
	
	}
	
	public static void main(String[] a) throws Exception {
		List<Integer> data=List.of(1,2,3,4,5,6);
		SearchList<Integer> t=new SearchList<Integer>(data);
		t.exists(5,0,data.size());
		System.out.print(t.foundMatch);	
	}
}
```

- A. true
- B. false
- C. The code does not compile
- D. The result is unknown until runtime
- E. An exception is thrown
- F. None of the above

<!-- 答案：A -->

### Q57
Which of the following methods is not available on an ExecutorService instance?
（Choose two）

- A. execute(Callable)
- B. shutdownNow()
- C. submit(Runnable)
- D. exit()
- E. submit(Callable)
- F. execute(Runnable)

<!-- 答案：A, D -->

### Q58
Given:

```java
var c=new CopyOnWriteArrayList<>(List.of("1","2","3","4"));
Runnable r=()->{
	try{
		Thread.sleep(150);
	}
	catch(InterruptedException e){
		System.out.println(e);	
	}
	c.set(3,"four");
	System.out.print(c+" ");
	};
Thread t=new Thread(r);
t.start();
for(var s:c)
{
	System.out.print(s+" ");
	Thread.sleep(100);
}
```

What is the output?

- A. 1 2 [1, 2, 3, four] 3 4
- B. 1 2 [1, 2, 3, 4] 3 four
- C. 1 2 [1, 2, 3, 4] 3 4
- D. 1 2 [1, 2, 3, four] 3 four

<!-- 答案：A -->

### Q59
Given:

```java
public interface Worker {
	public void doProcess();
}
```

and

```java
public class HardWorker implements Worker {
	public void doProcess() {
		System.out.println("doing things");
	}
}
```

and

```java
public class Cheater implements Worker {
	public void doProcess(){}
}
```

and

```java
public class Main<T extends Worker> extends Thread { // Line 1
	private List<T> processes=new ArrayList<>();     //line 2
	public void addProcess(HardWorker w) {			// line 3	
		processes.add(w);
	}
	
	public void run() {
		processes.forEach((p)->p.doProcess());	
	}
}
```

What needs to change to make these classes compile and still handle all types of Interface Worker?

- A. Replace Line 1 with `public class Main<T extends HardWorker> extends Thread {`
- B. Replace Line 3 with `public void addProcess(T w) {`
- C. Replace Line 3 with `public void addProcess(Worker w) {`
- D. Replace Line 2 with `private List<HardWorker> processes=new ArrayList<>();`

<!-- 答案：B -->

---

## Chapter 9 - Java I/O API（共 3 題）

### Q60
Why does Console `readPassword()` return a char array rather than a String?

- A. It improves performance
- B. It improves security
- C. Passwords must be stored as a char array
- D. String cannot hold the individual password characters
- E. It adds encryption
- F. None of the above

<!-- 答案：B -->

### Q61
Fill in the blanks: Writer is a(n) ___________ that related stream classes __________

- A. concrete class, extend
- B. abstract class, extend
- C. abstract class, implement
- D. interface, extend
- E. interface, implement
- F. None of the above

<!-- 答案：B -->

### Q62
Given:

```java
class MyPersistenceData {
	String str;
	private void methodA() {
		System.out.println("methodA");	
	}
}
```

You want to implement the `java.io.Serializable` interface to the MyPersistenceData class.

Which method should be overridden?

- A. the readExternal method
- B. the readExternal and writeExternal method
- C. the writeExternal method
- D. nothing

<!-- 答案：D -->

---

## Chapter 10 - Secure Coding in Java SE Application（共 3 題）

### Q63
Fill in the blanks: ___________ means the state of an object cannot be changed, while _________ means that it can

- A. Encapsulation, factory method
- B. Immutability, mutability
- C. Regidity, flexibility
- D. Static, instance
- E. Tightly coupled, loosely coupled
- F. None of the above

<!-- 答案：B -->

### Q64
How do you change the value of an instance variable in an immutable class?

- A. Call the setter method
- B. Remove the final modifier and set the instance variable directly
- C. Create a new instance with an inner class
- D. Use a method other than Option A, B, or C.
- E. You can't

<!-- 答案：E -->

### Q65
Given:

```java
public class Foo {
	public static String ALPHA="alpha";
	protected String beta="beta";
	private final String delta;
	public Foo(String d) {
		delta=ALPHA+d;	
	}
	public String foo() {
		return beta+=delta;	
	}
}
```

Which change would make Foo more secure?

- A. `private String delta;`
- B. `public String beta="beta";`
- C. `protected final String beta="beta";`
- D. `public static final String ALPHA="alpha";`

<!-- 答案：D -->

---

## Chapter 11 - Database Application with JDBC（共 3 題）

### Q66
What is the most likely outcome of this code if the bunnies table is empty?

```java
var url="jdbc:derby:bunnies";
var sql="insert into bunny(name,color) values(?,?)";
try(var conn=DriverManager.getConnection(url);
var stmt=conn.createStatement()){
	stmt.setString(1,"Hoppy");
	stmt.setString(2,"Brown");
	
	stmt.executeUpdate(sql);
}
```

- A. One row is inserted into the table.
- B. Two rows are inserted into the table.
- C. The code does not compile.
- D. The code throws a SQLException

<!-- 答案：C -->

### Q67
What must be the first characters of a database URL?

- A. db,
- B. db:
- C. jdbc,
- D. jdbc:
- E. None of the above

<!-- 答案：D -->

### Q68
Assuming the user credentials are correct, which expression will create a Connection?

- A. DriverManager.getConnection("jdbc:derby:com");
- B. DriverManager.getConnection("jdbc.derby.com");
- C. DriverManager.getConnection("http://database.jdbc.com","J_SMITH","dt12%2f3");
- D. DriverManager.getConnection();
- E. DriverManager.getConnection("J_SMITH","dt12%2f3");

<!-- 答案：A -->

---

## Chapter 12 - Localization（共 4 題）

### Q69
Which of the following are considered locales?
（Choose three）

- A. Culture region
- B. Local address
- C. City
- D. Time zone region
- E. Political region
- F. Geographical region

<!-- 答案：A, E, F -->

### Q70
When localizing an application, which type of data varies in presentation depending on locale?

- A. Currencies
- B. Dates
- C. Both
- D. Neither

<!-- 答案：C -->

### Q71
Given the code fragment:

```java
Locale locale=Locale.US;
// Line 1
double currency=1_00.00;
System.out.println(formatter.format(currency));
```

You want to display the value of currency as $100.00.

Which code inserted on line 1 will accomplish this?

- A. `NumberFormat formatter=NumberFormat.getInstance(locale).getCurrency();`
- B. `NumberFormat formatter=NumberFormat.getInstance(locale);`
- C. `NumberFormat formatter=NumberFormat.getCurrency(locale);`
- D. `NumberFormat formatter=NumberFormat.getCurrencyInstance(locale);`

<!-- 答案：D -->

### Q72
Which code fragment does a service use to load the service provider with a Print interface?

- A. `private java.util.ServiceLoader<Print> loader=ServiceLoader.load(Print.class);`
- B. `private Print print=com.service.Provider.getInstance();`
- C. `private java.util.ServiceLoader<Print> loader=new java.util.ServiceLoader<>();`
- D. `private Print print=new com.service.PrintImpl();`

<!-- 答案：A -->

---

## Chapter 13 - Annotations（共 3 題）

### Q73
What modifier is used to mark an annotation element as optional?

- A. optional
- B. default
- C. required
- D. value
- E. case
- F. None of the above

<!-- 答案：B -->

### Q74
Fill in the blank with the correct annotation usage that allows the code to compile without any warnings.

```java
@Deprecated(since="5.0")
public class ProjectPlanner<T>{
	ProjectPlanner create(T t) { return this; }
}

@SuppressWarnings(________)
class SystemPlanner {
	ProjectPlanner planner=new ProjectPlanner().create("TPS");
}
```

- A. `value=ignoreAll`
- B. `value="deprecation","unchecked"`
- C. `"unchecked","deprecation"`
- D. `{"deprecation","unchecked"}`
- E. `"deprecation"`
- F. None of the above

<!-- 答案：D -->

### Q75
Given the declaration:

```java
@interface Resource {
	String[] value();
}
```

Examine this code fragment:

```java
/** Loc1**/ class ProcessOrders{...}
```

Which two annotations may be applied at Loc1 in the code fragment?
（Choose two）

- A. `@Resource()`
- B. `@Resource(value={{}})`
- C. `@Resource`
- D. `@Resource({"Customer1","Customer2"})`
- E. `@Resource("Customer1")`

<!-- 答案：D, E -->

---

## 答案卷（Answer Key）

| 題號 | 答案 | 題號 | 答案 | 題號 | 答案 |
|------|------|------|------|------|------|
| Q1   | D    | Q26  | A    | Q51  | C,E |
| Q2   | A    | Q27  | D    | Q52  | F   |
| Q3   | E    | Q28  | D    | Q53  | E   |
| Q4   | D    | Q29  | B    | Q54  | B   |
| Q5   | D    | Q30  | C    | Q55  | B   |
| Q6   | A    | Q31  | C    | Q56  | A   |
| Q7   | B,F  | Q32  | C    | Q57  | A,D |
| Q8   | D    | Q33  | C    | Q58  | A   |
| Q9   | D    | Q34  | D    | Q59  | B   |
| Q10  | F    | Q35  | C    | Q60  | B   |
| Q11  | A    | Q36  | B    | Q61  | B   |
| Q12  | A    | Q37  | C    | Q62  | D   |
| Q13  | F    | Q38  | E    | Q63  | B   |
| Q14  | D    | Q39  | C    | Q64  | E   |
| Q15  | G    | Q40  | B    | Q65  | D   |
| Q16  | B,E  | Q41  | E    | Q66  | C   |
| Q17  | C    | Q42  | C    | Q67  | D   |
| Q18  | D,E,F| Q43  | D    | Q68  | A   |
| Q19  | D,E,G| Q44  | D    | Q69  | A,E,F |
| Q20  | D    | Q45  | C    | Q70  | C   |
| Q21  | E    | Q46  | B,D  | Q71  | D   |
| Q22  | A    | Q47  | A    | Q72  | A   |
| Q23  | A,G  | Q48  | C    | Q73  | B   |
| Q24  | A    | Q49  | A,E  | Q74  | D   |
| Q25  | C    | Q50  | A    | Q75  | D,E |

---

## 各章節題數統計

| 章節 | 主題 | 題數 |
|------|------|------|
| Chapter 1  | Working with Java Data Types | 6 |
| Chapter 2  | Controlling Program Flow | 3 |
| Chapter 3  | Java Object Oriented Approach | 18 |
| Chapter 4  | Exception Handling | 9 |
| Chapter 5  | Working with Arrays and Collections | 4 |
| Chapter 6  | Working with Streams and Lambda | 10 |
| Chapter 7  | Java Platform Module System | 5 |
| Chapter 8  | Concurrency | 4 |
| Chapter 9  | Java I/O API | 3 |
| Chapter 10 | Secure Coding in Java SE Application | 3 |
| Chapter 11 | Database Application with JDBC | 3 |
| Chapter 12 | Localization | 4 |
| Chapter 13 | Annotations | 3 |
| **合計** | | **75** |
