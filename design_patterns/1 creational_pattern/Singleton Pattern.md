#creationalPattern 

>This design pattern that guarantees a class has only one instance and provides a global point of access to it

#### Applications :
- we often requires classes that can only have one object. For ex. thread pools, caches, loggers, etc. Creating more than one objets of these could lead to issues such incorrect program behaviour, overuse of resources
- Also to store user preference, we need only one preference object ( multiple objects will create confusion for system to choose )

#### Implementation :
- prevent external objects from creating instances of the singleton class. Only the singleton class should be permitted to create its own objects
- declare constructor as private and return a static object `vector<int>` 

```java
class SingletonClass {

    private static SingletonClass instance;
    // Private constructor to prevent instantiation
    private SingletonClass(){}
    // Public method to provide access to the instance
    public static SingletonClass getInstance() {
        if (instance == null) {
            instance = new SingletonClass();
        }
        return instance;
    }
    // Example method
    public void showMessage() {
        System.out.println("Hello from Singleton!");
    }
}

// Main class to test the Singleton SingletonPattern
public class SingletonPattern {
    public static void main(String[] args) {
        // Get the only instance of SingletonPattern
        SingletonClass singleton = SingletonClass.getInstance();
        // Call a method on the singleton instance
        singleton.showMessage();
    }
}
```
