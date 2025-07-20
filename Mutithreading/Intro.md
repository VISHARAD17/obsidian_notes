By default all programming languages are sequential in nature meaning each line would be executed one by one. 

```java
public class RunnerClass{
	public static void main(Stirng[] args){
		intitDB();
		downloadData();
		processDate();
		showResult();
	}
}
```

in this above code all the functions will be ran in sequential order, one after other. This is a single threaded program.
**Problem** --> The time consuming part of the code can freeze entire application
**Solution** --> figure out the time consuming tasks and decide if they can be run separately. If yes, run such tasks in separate thread.
