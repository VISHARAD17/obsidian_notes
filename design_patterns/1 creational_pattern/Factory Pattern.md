#creationalPattern 

> Is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created

#### Applications :
- Exact type of object to be created is not known util runtime.
- to follow open/close principle from SOLID
- we have to create a object class whose only job is to **centralize and encapsulate object creation**.
#### Implementation
- Interface for notification :
```java
// interface for notification
interface Notification {
    void notifyUser();
}
```

- Different types of notifications :
```java
// different types of notifications
class EmailNotification implements Notification{
    @Override
    public void notifyUser(){
        System.out.println("Email Notification Send");
    }
}

class SMSNotification implements Notification{
    @Override
    public void notifyUser(){
        System.out.println("SMS Notification Send");
    }
}
```

- Single class to encapsulate all
```java
public class FactoryPattern {
	// main class
    public static void main(String[] args) {
        Notification notification = createNotification("SMS");
        notification.notifyUser();
    }

	// factory class
    public static Notification createNotification(String type) {
        switch (type) {
            case "EMail":
                return new EmailNotification();
            case "SMS":
                return new SMSNotification();
            default:
                throw new IllegalArgumentException("Unknown notification type: " + type);
        }
    }
};
```

instead of doing all this in a class, which requires further change in case we introduce new notification system, instead we can create abstract `factoryMethod` which will allow the subclass to handle the creation

```java
public abstract class NotificationCreator{
	public abstract Notification createNotification();

	public void send(String msg){
		Notification notification = createNotification();
		notificaton.notifyUser();	
	}
}
```

Let the subclass handle the implementation ( we can add as many as we want without changing the other methods code )
```java
public class EmailNotificatoinCreator extends NotificationCreator {
	@Override
	public Notification createNotification(){
		return new EmailNotification();
	}
}
```
