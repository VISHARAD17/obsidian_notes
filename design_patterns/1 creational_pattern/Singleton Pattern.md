#creationalPattern 

>This design pattern that guarantees a class has only one instance and provides a global point of access to it

Resources: [article-1](https://blog.algomaster.io/p/singleton-design-pattern)
#### **Applications** :
- we often requires classes that can only have one object. For ex. thread pools, caches, loggers, etc. Creating more than one objets of these could lead to issues such incorrect program behaviour, overuse of resources
- Also to store user preference, we need only one preference object ( multiple objects will create confusion for system to choose )

#### **Notes** :
- prevent external objects from creating instances of the singleton class. Only the singleton class should be permitted to create its own objects
- declare constructor as private and return a static object via different method `getInstance`.
- **Lazy Initialization**: Object is only created when it is needed first.
```java
class SingletonClass{
    private static SingletonClass instance;
    private String message;

    private SingletonClass() {
        // private constructor to prevent instantiation
        this.message = "singletonInstance";
    }

    public static SingletonClass getInstance(){
        if (instance == null) {
            instance = new SingletonClass();
        }
        return instance;
    }

    public String getMsg() {
        return this.message;
    }
};

public class SingletonPattern {
    public static void main(String[] args){
        System.out.println("Singleton Pattern Code");
        SingletonClass singleton = SingletonClass.getInstance();
        System.out.println(singleton.getMsg());
    }
}
```

- **Thread Safe singleton class**: Make the method creating the class `synchronized`
```java
public static synchronized SingletonClass getInstance(){
        if (instance == null) {
            instance = new SingletonClass();
        }
        return instance;
    }
```
