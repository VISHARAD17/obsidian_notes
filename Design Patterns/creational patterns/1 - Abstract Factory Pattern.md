
> This creational pattern provides an interface for creating families of related or dependent objects, without specifying their concrete classes

### Application
- when we need to use multiple objects together and are part of a consistent family, ex. GUI elements like buttons, checkboxes and menus.
- Multiple configurations
- To enforce consistency across related objects

#### Code
```
for(int i=0; i<n; i++){
	log.info("something");
}
```

#### Notification
```
public interface IService {
	void write(String s);
	String read(String s);
}
```

#### Interface implementation
```
public class MainService implements IService {
	public void write(String s){
		String s = "visharad";
		log.info("string = {}", s);
	}
	
	public String read(String s){
		return s + s;
	}
}
```