### 2. Question: What are class loaders?
"Class loaders are a component of the JRE responsible for dynamically loading Java classes into memory during runtime. They follow a delegation model where a class loader first delegates the loading request to its parent before attempting to load the class itself. The three main types are:  
1. **Bootstrap Class Loader**: Loads core Java classes from `rt.jar` (e.g., `java.lang.*`).  
2. **Extension Class Loader**: Loads classes from the `jre/lib/ext` directory or paths specified in `java.ext.dirs`.  
3. **System Class Loader**: Loads classes from the application’s classpath, such as project-specific classes or JARs.  
This hierarchy ensures efficient and secure class loading, avoiding duplicate loading and maintaining class namespace isolation."

---

### 3. Question: Can we call non-static instance variables or methods from static methods? Why not?
**Answer**:  
No, we can’t call non-static instance variables or methods from static methods because static methods don’t require an object to be called, while non-static methods or variables require an object instance.
**Improved Answer**:  
"No, we cannot directly call non-static instance variables or methods from static methods. Static methods belong to the class and are loaded into memory when the class is loaded, without requiring an object. Non-static members, however, are tied to a specific instance of the class and reside in the heap, so they require an object to be accessed. To call a non-static method or variable from a static context, we need to create an instance of the class, e.g., `MyClass obj = new MyClass(); obj.nonStaticMethod();`."

---

### 4. Question: Why is String immutable in Java?
**Answer**:  
Strings are immutable in Java to ensure expected results in a multi-threaded environment. Since String is widely used, making it mutable could allow multiple threads to modify the same String object, leading to unexpected results. Immutability ensures thread safety and consistency.

**Improved Answer**:  
"Strings are immutable in Java for several reasons:  
1. **Thread Safety**: In a multi-threaded environment, immutability ensures that multiple threads can safely use the same String without race conditions, as no thread can modify it.  
2. **Security**: Immutability prevents unauthorized changes to sensitive data, like file paths or database connection strings.  
3. **String Pool Efficiency**: Immutability allows Java to cache Strings in the String pool, reducing memory usage by reusing identical Strings.  
4. **Hash Code Consistency**: Since Strings are often used as keys in hash-based collections like HashMap, immutability ensures their hash code remains consistent, preventing issues in retrieval.  
For example, if a String key in a HashMap were mutable, changing its value could break the map’s integrity."

---

### 5. Question: Why do we prefer using char[] to store passwords instead of String?
**Answer**:  
Storing passwords in a String keeps them in the String Constant Pool (SCP), where they remain until the application shuts down or the pool is garbage-collected. This poses a security risk because anyone with access to the heap can potentially read the password. Using `char[]` allows the password to be cleared after use, reducing the risk of exposure.

**Improved Answer**:  
"Using `char[]` to store passwords is preferred over String for security reasons. Strings are immutable and stored in the String Constant Pool, where they remain until the pool is garbage-collected, potentially exposing sensitive data if the heap is accessed (e.g., via memory dumps). In contrast, `char[]` is mutable, allowing the password to be overwritten (e.g., with zeros) immediately after use, minimizing the time sensitive data exists in memory. This reduces the risk of unauthorized access, especially in critical applications like banking systems."

---

### 6. Question: Why was OOPs introduced in Java?
**Answer**:  
OOPs (Object-Oriented Programming) was introduced to manage objects efficiently, as it would be complex to handle objects without it. It makes code reusable, modular, and structured, splitting code into manageable modules.

**Improved Answer**:  
"Object-Oriented Programming (OOP) was introduced in Java to make software development more intuitive, manageable, and scalable. OOP allows modeling real-world entities as objects, enabling:  
1. **Encapsulation**: Hides data and exposes only necessary functionality, improving security and maintainability.  
2. **Inheritance**: Promotes code reuse by allowing classes to inherit properties and methods from others.  
3. **Polymorphism**: Enables flexibility by allowing objects to be treated as instances of their parent class, supporting dynamic behavior.  
4. **Modularity**: Breaks code into independent, reusable modules (classes), simplifying maintenance and collaboration.  
These features make Java code more organized, reusable, and easier to scale, aligning with real-world problem-solving."

---

### 7. Question: Why was Java 8 introduced?
**Answer**:  
Java 8 was introduced to move from imperative to declarative programming, reducing the need to define every step explicitly. It addressed issues like null pointer exceptions (via Optional), simplified date and time handling (via `java.time` package), and improved development efficiency.

**Improved Answer**:  
"Java 8 was introduced to enhance developer productivity, support functional programming, and address limitations in prior versions. Key reasons include:  
1. **Functional Programming**: Lambda expressions and functional interfaces enable concise, declarative code, reducing boilerplate compared to imperative programming.  
2. **Stream API**: Simplifies data processing with functional-style operations like map, filter, and reduce, improving readability and performance.  
3. **Optional Class**: Reduces null pointer exceptions by providing a wrapper for potentially null values.  
4. **Date and Time API**: The `java.time` package simplifies and standardizes date/time handling, replacing cumbersome classes like `Date` and `Calendar`.  
5. **Default Methods**: Allow interfaces to have method implementations, enabling backward compatibility for evolving APIs.  
These changes made Java more modern, efficient, and aligned with functional programming trends."

---

### 8. Question: Write a Java program to find the sum of odd numbers from a list using Stream API.
**Answer**:  

**Improved Answer**:  
```java
List<Integer> numbers = Arrays.asList(1, 3, 4, 5, 4, 9);
int sum = numbers.stream()
                .filter(n -> n % 2 != 0) // Filter odd numbers
                .reduce(0, Integer::sum); // Sum using method reference
System.out.println(sum); // Output: 16
```
**Explanation**:  
The Stream API filters odd numbers using `n % 2 != 0` and uses `reduce` with an initial value of 0 to sum them. The `Integer::sum` method reference makes the code more concise. For an empty list, the result is 0, avoiding the need for Optional handling. If robustness is needed, we could add a check for an empty list before streaming.

---

### 9. Question: Modify the program to find the sum of squares of odd numbers.
**Improved Answer**:  
```java
List<Integer> numbers = Arrays.asList(1, 3, 4, 5, 4, 9);
int sumOfSquares = numbers.stream()
                         .filter(n -> n % 2 != 0) // Filter odd numbers
                         .map(n -> n * n) // Square each number
                         .reduce(0, Integer::sum); // Sum the squares
System.out.println(sumOfSquares); // Output: 84
```
**Explanation**:  
The pipeline filters odd numbers, maps each to its square using `n -> n * n`, and reduces the stream to a single sum using `Integer::sum`. The initial value of 0 ensures the result is 0 for an empty stream, making the code robust.

---

### 10. Question: How do you externalize configurations in a Spring Boot application?
**Answer**:  
In the current project, we use `application.yml` for configuration. Other ways include environment variables and command-line arguments. The candidate prefers YAML over properties due to its hierarchical structure, which avoids repetitive variable definitions.


**Improved Answer**:  
"In Spring Boot, configurations can be externalized in several ways to make applications flexible and environment-agnostic:  
1. **application.yml or application.properties**: Store configurations in YAML or properties files under `src/main/resources`. YAML is preferred for its hierarchical structure, reducing redundancy.  
2. **Environment Variables**: Use variables like `SPRING_DATASOURCE_URL` to override file-based configs.  
3. **Command-Line Arguments**: Pass arguments like `--spring.datasource.url=...` when running the application.  
4. **Spring Cloud Config**: Fetch configurations from a centralized server for distributed systems.  
5. **Profiles**: Use profile-specific files (e.g., `application-dev.yml`) for environment-specific settings.  
Spring Boot follows a precedence order, where command-line arguments override environment variables, which override file-based configs. In my project, we use `application.yml` for database credentials and API keys, with profiles for dev, test, and prod environments."