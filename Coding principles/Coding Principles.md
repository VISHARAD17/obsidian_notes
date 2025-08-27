**These principles  are guidelines to when building software that is easier to maintain and scale. SOLID principle provides a blueprint for writing code that is easy to adjust, extend and maintain over time.

#### **S - Single Responsibility**
**A Single class should only have one responsibility.**
If a single class has many responsibilities it increases the possibility of bugs while making changes to one of its responsibilities. The goal of this principle if to separate behaviours so that if bugs arise as result of any change it would not affect other unrelated behaviours.
```java
class UserMangement {
	void authenticateUser(){};
	void updateUser(){};
	void sendEmailNotification(){};
}
```
above class has multiple responsibilities, authorization, user management, notification, etc. This violates the single responsibility principle. We need to separate these unique behaviours into different classes.
```java
class UserAuthentication {
	void authentication(){};	
}
class UserManagement{
	void updateUser(){}:
}
class UserNotifications{
	void sentEmailNotifications(){};
}
```

#### **O - Open-Closed**
**Classes should be open for extension closed for modification**
Changing the current behaviour of the class would affect the system using the class. If we want a class to perform more functions, we should **add that extra function** instead of changing that class. Goal of this principle is to extend the behaviour of the class without changing the existing behaviour of the class.
```java
class ShapeCalculator{
	private int l;
	private int r;
	private int b;
	ShapeCalculator(int b, int l, int r){
		this.b = b;
		this.l = l;
		this.r = r;
	}
	void calculate_area(String type){
		if(type.equalIgnoreCase("rectange")){
			log.info(l*b);
		}
		if(type.equalIgnoreCase("circle")){
			log.info(Math.pi * r * r);
		}
	}
}
```
Above class violates Open-closed principle because if we want to use this class for square then we would require to modify the existing function.
instead we can create a abstract class, that would handle this functionality and we can use to to extend for different shapes.
```java
abstract class Shape{
	abstract void claculate_area(){
	}
}
// implementation for rectangle
class RectangleCalculator {
	private int l;
	private int b;

	RectangleCalculator(int l, int b){
		this.l = l;
		this.b = b;
	}
	
	@override
	public calculate_area(){
		log.info(l*b);
	}
}

// implementation for square
class SquareCalculator {
	private int l;

	SquareCalculator(int l, int b){
		this.l = l;
	}
	
	@override
	public calculate_area(){
		log.info(l*l);
	}
}
```
This way we can add functionality to our system without modifying any or our existing code.
#### **L - LisKov Substitution**
**Instance of main class can be replaced by the instance of its derived class, without changing the behaviour of the system.**
A child class can perform all the actions of its parent class. A child class can deliver **same result** or **result of same type.** Goal of this rule is to enforce consistency via inheritance, so that the child class can be used in place of parent class without any errors.

```java
class Bird{
	public fly(){
		log.info("Bird is flying");
	}
}

class Sparrow extends Bird{
	@override
	public fly(){
		log.info("Sparrow is flying");
	}
}
```
Here, we can replace Bird class ( main class ) with its derived class i.e. sparrow class without breaking any functionalities in the system. We should not implement any other class ( derive ) that shows different behaviour or throws exception ex. ostrich class ( because ostrich cannot fly it would throw UnsupportedOperationException)
#### **I - Interface segregation Principle**
**Client should not be dependent on the methods that they do not use**
This principle aims at splitting the actions into smaller sets so that a class executed only the set of actions it requires or represents.
If we have a media-player interface
```java
interface MediaPlayerInterface {
	void playAudio();
	void stopAudio();
	void playVideo();
	void stopViode();
}
```
now, if we want to create a MP3player class using this interface we would need to implements methods related to video even if we do not use it. This violets interface segregation principle. Instead we can split this interface into to different and unique interfaces.
```java
interface AudioPlayerInterface {
	void playAudio();
	void stopAudio();
}
	
interface VideoPlayerInterface {
	void playVideo();
	void stopViode();
}
```
This would prevent us from creating bloated interfaces with unnecessary methods.
#### **D - Dependency Inversion**
**High level modules should not depend on low level modules, instead both should depend on abstraction**
Here, High level module represents a class that performs a certain action, low level module is a class that is required to perform that action and abstraction represents the interface that connects the two classes. Basically this principle says that the main class ( high level module ) should not use the low level class directly instead it should use the interface instead. This decouples both the classes.

----
## **








