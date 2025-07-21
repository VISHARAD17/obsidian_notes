#LLD 
#### **ATM**
```java
public class ATM {  
    private static ATM INSTANCE;  
    private final BankService bankService;  
    private final CashDispenser cashDispenser;  
    private static final AtomicLong transactionCounter = new AtomicLong(0);  
    private ATMState currentState;  
    private Card currentCard;

	/** methods **/
	private ATM(){};  // private constructor
	public static ATM getInstance(){}; // static create instance method
	public void changeState(ATMState newState){};
	public void setCurrentCard(Card card){};
	public insertCard(String cardNumber){};
	public enterPin(String pin){};
	public void selectOperation(OperationType op, int... args){};
```
#### **ATMState (ENUM)**
```java
public ENUM {
	READY;
	NOTREADY;
}
```
#### **something**

