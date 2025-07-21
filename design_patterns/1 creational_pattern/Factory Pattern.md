**The Factory Design Pattern** is a creational pattern, defined an interface for creating an object but lets subclass decides which class to instantiate. 

**Used When**:
- Exact type of object to be created is unknown until runtime.
- Object creation logic is complex, repetitive or needs encapsulation.
- Need to follow **open/closed principle** -- open for extension and close for modification

Let's say we want to create a pizza store:
**Pizza interface**
```java
public interface Pizza {
	void eat();
}
```
**Mozzarella pizza**
```java
public MozzarellaPizza implements Pizza {
	@override
	void serve(){
		System.out.println("eating mozzarella pizza");
	}
}
```
**Pizza store**
```java
public class PizzaStore {
	void serverPizza(String type){
		if(type == "Mozzerella"){
			Pizza mozzarellaPizaa = new MozzarellaPiza();
			mozzarellaPizza.serve();	
		}
		// more pizza types
	}
	// common method among all subclasses, which are not supposed to change
	void getIngredients(){
		System.out.println("getting ingredients");
	}	
	void makeDough(){
		System.out.println("making dough");
	}
}
```
As the Pizza type grows pizza store class becomes more complex, and then if we need different flavours of pizza store, we again need to create a diff class, this will lead to inconsistencies.

So, **factory design pattern** suggests to use a abstract class to define a pizza store and concrete implementation of its common functionalities like making dough, getting raw ingredient, etc, and keeping the flavoured methods like **serverPizza** abstract to let subclass decide what kind of pizza that new pizza store will make.

**Pizza store abstract class ( Factory class )**
```java
abstract class PizzaStore {
	abstract void servePizza(String type); // let the concret pizzstore subclass decide the types of pizza it will serve
	void getIngredients(){
		System.out.println("getting ingredients");
	}	
	void makeDough(){
		System.out.println("making dough");
	}
}
```

**Concrete class implementations**
- **IndianPizzaStore**
```java
public class IndianPizzaStore implements PizzaStore{
	void servePizza(String type){
		if(type == "Mozzarella"){
			Pizza indianMozzarellaPizza = new IndianMozzarellaPiza();
			indianMozzarellaPizza.server();
		}
		// more such indian pizza
	}
	// concrete method from parent class ( no need to write they will imported automatically )
}
```

- This way we can have concrete implementation of common methods to maintain consistency across different families of pizza stores.
- This design pattern also makes such that PizzaStore is open for extension buy letting subclass add any extra/new method, but can't modify the core methods ( close for modification )
