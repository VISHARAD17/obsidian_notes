# React & JavaScript Interview Study Guide

  

## JavaScript Fundamentals

  

### ES6+ Features

  

**Arrow Functions**

```javascript

// Regular function

function add(a, b) { return a + b; }

  

// Arrow function

const add = (a, b) => a + b;

  

// With block body

const multiply = (a, b) => {

const result = a * b;

return result;

};

```

  

**Destructuring**

```javascript

// Array destructuring

const [first, second, ...rest] = [1, 2, 3, 4, 5];

  

// Object destructuring

const { name, age, ...others } = { name: 'John', age: 30, city: 'NYC' };

  

// Function parameters

const greet = ({ name, age }) => `Hello ${name}, you are ${age}`;

```

  

**Template Literals**

```javascript

const name = 'World';

const message = `Hello, ${name}!`;

const multiline = `

This is a

multiline string

`;

```

  

**Spread Operator**

```javascript

// Arrays

const arr1 = [1, 2, 3];

const arr2 = [...arr1, 4, 5]; // [1, 2, 3, 4, 5]

  

// Objects

const obj1 = { a: 1, b: 2 };

const obj2 = { ...obj1, c: 3 }; // { a: 1, b: 2, c: 3 }

```

  

### Closures and Scope

  

```javascript

function outerFunction(x) {

// Outer scope

return function innerFunction(y) {

// Inner function has access to outer scope

return x + y;

};

}

  

const addFive = outerFunction(5);

console.log(addFive(3)); // 8

```

  

### Promises and Async/Await

  

```javascript

// Promise

const fetchData = () => {

return new Promise((resolve, reject) => {

setTimeout(() => {

resolve('Data received');

}, 1000);

});

};

  

// Async/Await

const getData = async () => {

try {

const data = await fetchData();

console.log(data);

} catch (error) {

console.error(error);

}

};

```

  

### Array Methods

  

```javascript

const numbers = [1, 2, 3, 4, 5];

  

// map - transform each element

const doubled = numbers.map(n => n * 2);

  

// filter - select elements that match condition

const evenNumbers = numbers.filter(n => n % 2 === 0);

  

// reduce - accumulate values

const sum = numbers.reduce((acc, n) => acc + n, 0);

  

// find - get first matching element

const found = numbers.find(n => n > 3);

  

// some/every - test conditions

const hasEven = numbers.some(n => n % 2 === 0);

const allPositive = numbers.every(n => n > 0);

```

  

### Event Loop and Hoisting

  

```javascript

// Hoisting example

console.log(x); // undefined (not error)

var x = 5;

  

// let/const are not hoisted

console.log(y); // ReferenceError

let y = 10;

  

// Event loop example

console.log('1');

setTimeout(() => console.log('2'), 0);

Promise.resolve().then(() => console.log('3'));

console.log('4');

// Output: 1, 4, 3, 2

```

  

## React Core Concepts

  

### Components

  

**Functional Components**

```jsx

// Basic functional component

const Welcome = ({ name }) => {

return <h1>Hello, {name}!</h1>;

};

  

// Component with default props

const Button = ({ children, onClick, variant = 'primary' }) => {

return (

<button className={`btn btn-${variant}`} onClick={onClick}>

{children}

</button>

);

};

```

  

**Class Components** (Legacy but still important to know)

```jsx

class Counter extends React.Component {

constructor(props) {

super(props);

this.state = { count: 0 };

}

  

render() {

return (

<div>

<p>Count: {this.state.count}</p>

<button onClick={() => this.setState({ count: this.state.count + 1 })}>

Increment

</button>

</div>

);

}

}

```

  

### Hooks

  

**useState**

```jsx

const Counter = () => {

const [count, setCount] = useState(0);

const [user, setUser] = useState({ name: '', email: '' });

  

const increment = () => setCount(count + 1);

const updateUser = (field, value) =>

setUser(prev => ({ ...prev, [field]: value }));

  

return (

<div>

<p>Count: {count}</p>

<button onClick={increment}>+</button>

</div>

);

};

```

  

**useEffect**

```jsx

const UserProfile = ({ userId }) => {

const [user, setUser] = useState(null);

const [loading, setLoading] = useState(true);

  

// Effect with cleanup

useEffect(() => {

let isCancelled = false;

  

const fetchUser = async () => {

try {

const response = await api.getUser(userId);

if (!isCancelled) {

setUser(response.data);

setLoading(false);

}

} catch (error) {

if (!isCancelled) {

console.error(error);

setLoading(false);

}

}

};

  

fetchUser();

  

// Cleanup function

return () => {

isCancelled = true;

};

}, [userId]); // Dependency array

  

if (loading) return <div>Loading...</div>;

return <div>{user?.name}</div>;

};

```

  

**useContext**

```jsx

// Create context

const ThemeContext = createContext();

  

// Provider

const ThemeProvider = ({ children }) => {

const [theme, setTheme] = useState('light');

return (

<ThemeContext.Provider value={{ theme, setTheme }}>

{children}

</ThemeContext.Provider>

);

};

  

// Consumer

const ThemedButton = () => {

const { theme, setTheme } = useContext(ThemeContext);

return (

<button

className={`btn-${theme}`}

onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}

>

Toggle Theme

</button>

);

};

```

  

**useMemo and useCallback**

```jsx

const ExpensiveComponent = ({ items, filter }) => {

// Memoize expensive calculation

const filteredItems = useMemo(() => {

return items.filter(item => item.category === filter);

}, [items, filter]);

  

// Memoize callback function

const handleClick = useCallback((id) => {

console.log('Clicked item:', id);

}, []);

  

return (

<div>

{filteredItems.map(item => (

<Item key={item.id} data={item} onClick={handleClick} />

))}

</div>

);

};

```

  

**useRef**

```jsx

const FocusInput = () => {

const inputRef = useRef(null);

const countRef = useRef(0);

  

const focusInput = () => {

inputRef.current.focus();

};

  

const incrementCount = () => {

countRef.current += 1;

console.log('Count:', countRef.current);

};

  

return (

<div>

<input ref={inputRef} />

<button onClick={focusInput}>Focus Input</button>

<button onClick={incrementCount}>Increment</button>

</div>

);

};

```

  

**Custom Hooks**

```jsx

// Custom hook for API calls

const useApi = (url) => {

const [data, setData] = useState(null);

const [loading, setLoading] = useState(true);

const [error, setError] = useState(null);

  

useEffect(() => {

const fetchData = async () => {

try {

setLoading(true);

const response = await fetch(url);

const result = await response.json();

setData(result);

} catch (err) {

setError(err);

} finally {

setLoading(false);

}

};

  

fetchData();

}, [url]);

  

return { data, loading, error };

};

  

// Usage

const UserList = () => {

const { data: users, loading, error } = useApi('/api/users');

  

if (loading) return <div>Loading...</div>;

if (error) return <div>Error: {error.message}</div>;

return (

<ul>

{users.map(user => <li key={user.id}>{user.name}</li>)}

</ul>

);

};

```

  

### Props and State Management

  

**Props**

```jsx

// Prop types validation (with PropTypes)

import PropTypes from 'prop-types';

  

const UserCard = ({ user, onEdit, isEditable = false }) => {

return (

<div className="user-card">

<h3>{user.name}</h3>

<p>{user.email}</p>

{isEditable && (

<button onClick={() => onEdit(user.id)}>Edit</button>

)}

</div>

);

};

  

UserCard.propTypes = {

user: PropTypes.shape({

id: PropTypes.number.isRequired,

name: PropTypes.string.isRequired,

email: PropTypes.string.isRequired,

}).isRequired,

onEdit: PropTypes.func,

isEditable: PropTypes.bool,

};

```

  

**State Lifting**

```jsx

const TodoApp = () => {

const [todos, setTodos] = useState([]);

  

const addTodo = (text) => {

setTodos(prev => [...prev, { id: Date.now(), text, completed: false }]);

};

  

const toggleTodo = (id) => {

setTodos(prev => prev.map(todo =>

todo.id === id ? { ...todo, completed: !todo.completed } : todo

));

};

  

return (

<div>

<TodoForm onSubmit={addTodo} />

<TodoList todos={todos} onToggle={toggleTodo} />

</div>

);

};

```

  

### Event Handling

  

```jsx

const FormComponent = () => {

const [formData, setFormData] = useState({ name: '', email: '' });

  

const handleChange = (e) => {

const { name, value } = e.target;

setFormData(prev => ({ ...prev, [name]: value }));

};

  

const handleSubmit = (e) => {

e.preventDefault();

console.log('Form submitted:', formData);

};

  

return (

<form onSubmit={handleSubmit}>

<input

name="name"

value={formData.name}

onChange={handleChange}

placeholder="Name"

/>

<input

name="email"

value={formData.email}

onChange={handleChange}

placeholder="Email"

/>

<button type="submit">Submit</button>

</form>

);

};

```

  

### Conditional Rendering

  

```jsx

const ConditionalExample = ({ user, isLoggedIn, items }) => {

return (

<div>

{/* Ternary operator */}

{isLoggedIn ? <WelcomeMessage /> : <LoginForm />}

{/* Logical AND */}

{user && <UserProfile user={user} />}

{/* Conditional with multiple conditions */}

{isLoggedIn && user?.role === 'admin' && <AdminPanel />}

{/* Conditional lists */}

{items.length > 0 ? (

<ul>

{items.map(item => <li key={item.id}>{item.name}</li>)}

</ul>

) : (

<p>No items found</p>

)}

</div>

);

};

```

  

### Lists and Keys

  

```jsx

const ProductList = ({ products }) => {

return (

<div>

{products.map(product => (

<ProductCard

key={product.id} // Always use unique, stable keys

product={product}

/>

))}

</div>

);

};

  

// Avoid using array index as key when list can change

// Bad: key={index}

// Good: key={item.id} or key={item.uniqueProperty}

```

  

## Advanced React Patterns

  

### Higher-Order Components (HOC)

  

```jsx

const withAuth = (WrappedComponent) => {

return (props) => {

const { isAuthenticated } = useAuth();

if (!isAuthenticated) {

return <Redirect to="/login" />;

}

return <WrappedComponent {...props} />;

};

};

  

// Usage

const ProtectedDashboard = withAuth(Dashboard);

```

  

### Render Props

  

```jsx

const DataFetcher = ({ url, children }) => {

const [data, setData] = useState(null);

const [loading, setLoading] = useState(true);

  

useEffect(() => {

fetch(url)

.then(res => res.json())

.then(data => {

setData(data);

setLoading(false);

});

}, [url]);

  

return children({ data, loading });

};

  

// Usage

const App = () => (

<DataFetcher url="/api/users">

{({ data, loading }) => (

loading ? <Spinner /> : <UserList users={data} />

)}

</DataFetcher>

);

```

  

### Error Boundaries

  

```jsx

class ErrorBoundary extends React.Component {

constructor(props) {

super(props);

this.state = { hasError: false };

}

  

static getDerivedStateFromError(error) {

return { hasError: true };

}

  

componentDidCatch(error, errorInfo) {

console.error('Error caught by boundary:', error, errorInfo);

}

  

render() {

if (this.state.hasError) {

return <h1>Something went wrong.</h1>;

}

  

return this.props.children;

}

}

  

// Usage

<ErrorBoundary>

<MyComponent />

</ErrorBoundary>

```

  

## Performance Optimization

  

### React.memo

  

```jsx

const ExpensiveChild = React.memo(({ name, count }) => {

console.log('ExpensiveChild rendered');

return <div>{name}: {count}</div>;

});

  

// With custom comparison

const OptimizedComponent = React.memo(

({ user }) => <div>{user.name}</div>,

(prevProps, nextProps) => prevProps.user.id === nextProps.user.id

);

```

  

### Code Splitting

  

```jsx

import { lazy, Suspense } from 'react';

  

const LazyComponent = lazy(() => import('./LazyComponent'));

  

const App = () => (

<div>

<Suspense fallback={<div>Loading...</div>}>

<LazyComponent />

</Suspense>

</div>

);

```

  

## Common Patterns and Best Practices

  

### Form Handling

  

```jsx

const useForm = (initialValues, validationRules) => {

const [values, setValues] = useState(initialValues);

const [errors, setErrors] = useState({});

  

const handleChange = (name, value) => {

setValues(prev => ({ ...prev, [name]: value }));

// Clear error when user starts typing

if (errors[name]) {

setErrors(prev => ({ ...prev, [name]: '' }));

}

};

  

const validate = () => {

const newErrors = {};

Object.keys(validationRules).forEach(field => {

const rule = validationRules[field];

const value = values[field];

if (rule.required && !value) {

newErrors[field] = `${field} is required`;

}

});

setErrors(newErrors);

return Object.keys(newErrors).length === 0;

};

  

return { values, errors, handleChange, validate };

};

```

  

### API Integration

  

```jsx

const useApiCall = () => {

const [loading, setLoading] = useState(false);

const [error, setError] = useState(null);

  

const callApi = async (apiFunction, ...args) => {

try {

setLoading(true);

setError(null);

const result = await apiFunction(...args);

return result;

} catch (err) {

setError(err.message);

throw err;

} finally {

setLoading(false);

}

};

  

return { callApi, loading, error };

};

```

  

## Testing Concepts

  

### Component Testing

  

```jsx

// Example component

const Counter = ({ initialCount = 0 }) => {

const [count, setCount] = useState(initialCount);

return (

<div>

<span data-testid="count">{count}</span>

<button onClick={() => setCount(c => c + 1)}>+</button>

<button onClick={() => setCount(c => c - 1)}>-</button>

</div>

);

};

  

// Test example (Jest + React Testing Library)

test('increments count when + button is clicked', () => {

render(<Counter />);

const countElement = screen.getByTestId('count');

const incrementButton = screen.getByText('+');

expect(countElement).toHaveTextContent('0');

fireEvent.click(incrementButton);

expect(countElement).toHaveTextContent('1');

});

```

  

## Commonly Asked Interview Questions & Answers

  

### JavaScript Questions

  

**1. Explain closures and provide an example**

  

**Answer:** A closure is a function that has access to variables in its outer (enclosing) scope even after the outer function has finished executing. The inner function "closes over" the variables from the outer scope.

  

```javascript

function outerFunction(x) {

// This is the outer scope

return function innerFunction(y) {

// This inner function has access to 'x'

return x + y;

};

}

  

const addFive = outerFunction(5);

console.log(addFive(3)); // 8

  

// Real-world example: Module pattern

function createCounter() {

let count = 0;

return {

increment: () => ++count,

decrement: () => --count,

getCount: () => count

};

}

  

const counter = createCounter();

console.log(counter.increment()); // 1

console.log(counter.getCount()); // 1

// 'count' is private and cannot be accessed directly

```

  

**2. What is the difference between `let`, `const`, and `var`?**

  

**Answer:**

- **`var`**: Function-scoped, hoisted, can be redeclared and updated

- **`let`**: Block-scoped, hoisted but not initialized, can be updated but not redeclared

- **`const`**: Block-scoped, hoisted but not initialized, cannot be updated or redeclared

  

```javascript

// var example

function varExample() {

if (true) {

var x = 1;

}

console.log(x); // 1 (accessible outside block)

}

  

// let example

function letExample() {

if (true) {

let y = 1;

}

console.log(y); // ReferenceError: y is not defined

}

  

// const example

const obj = { name: 'John' };

obj.name = 'Jane'; // This works (modifying property)

// obj = {}; // This would throw an error (reassigning)

```

  

**3. How does the event loop work?**

  

**Answer:** The event loop is JavaScript's mechanism for handling asynchronous operations. It continuously checks the call stack and processes tasks from the task queue when the stack is empty.

  

```javascript

console.log('1'); // Synchronous - goes to call stack

  

setTimeout(() => {

console.log('2'); // Macro task - goes to task queue

}, 0);

  

Promise.resolve().then(() => {

console.log('3'); // Micro task - goes to microtask queue

});

  

console.log('4'); // Synchronous - goes to call stack

  

// Output: 1, 4, 3, 2

// Microtasks have higher priority than macrotasks

```

  

**4. What are promises and how do they work?**

  

**Answer:** Promises are objects representing the eventual completion or failure of an asynchronous operation. They have three states: pending, fulfilled, or rejected.

  

```javascript

// Creating a promise

const myPromise = new Promise((resolve, reject) => {

const success = true;

if (success) {

resolve('Operation successful');

} else {

reject('Operation failed');

}

});

  

// Using a promise

myPromise

.then(result => console.log(result))

.catch(error => console.error(error));

  

// Promise chaining

fetch('/api/user')

.then(response => response.json())

.then(user => fetch(`/api/posts/${user.id}`))

.then(response => response.json())

.then(posts => console.log(posts))

.catch(error => console.error(error));

```

  

**5. Difference between `==` and `===`?**

  

**Answer:**

- **`==`** (loose equality): Performs type coercion before comparison

- **`===`** (strict equality): Compares both value and type without coercion

  

```javascript

// Loose equality (==)

'5' == 5; // true (string converted to number)

null == undefined; // true

0 == false; // true

  

// Strict equality (===)

'5' === 5; // false (different types)

null === undefined; // false

0 === false; // false

```

  

**6. What is hoisting?**

  

**Answer:** Hoisting is JavaScript's behavior of moving variable and function declarations to the top of their scope during compilation.

  

```javascript

// Variables

console.log(x); // undefined (not error)

var x = 5;

  

// Functions

sayHello(); // "Hello!" (works)

function sayHello() {

console.log('Hello!');

}

  

// Let/const are hoisted but not initialized

console.log(y); // ReferenceError

let y = 10;

```

  

**7. Explain prototypal inheritance**

  

**Answer:** JavaScript uses prototypal inheritance where objects can inherit properties and methods from other objects through the prototype chain.

  

```javascript

// Constructor function

function Animal(name) {

this.name = name;

}

  

Animal.prototype.speak = function() {

console.log(`${this.name} makes a sound`);

};

  

function Dog(name, breed) {

Animal.call(this, name);

this.breed = breed;

}

  

// Set up inheritance

Dog.prototype = Object.create(Animal.prototype);

Dog.prototype.constructor = Dog;

  

Dog.prototype.bark = function() {

console.log(`${this.name} barks`);

};

  

const dog = new Dog('Buddy', 'Golden Retriever');

dog.speak(); // "Buddy makes a sound"

dog.bark(); // "Buddy barks"

```

  

### React Questions

  

**8. What is the Virtual DOM and how does it work?**

  

**Answer:** The Virtual DOM is a JavaScript representation of the actual DOM. React uses it to optimize rendering by:

1. Creating a virtual copy of the DOM in memory

2. When state changes, creating a new virtual DOM tree

3. Comparing (diffing) the new tree with the previous one

4. Updating only the changed parts in the real DOM (reconciliation)

  

```javascript

// When you write JSX:

const element = <h1>Hello, World!</h1>;

  

// React creates a virtual DOM object:

const element = {

type: 'h1',

props: {

children: 'Hello, World!'

}

};

```

  

**Benefits:** Faster updates, batch updates, cross-browser compatibility

  

**9. Explain the component lifecycle (Class components)**

  

**Answer:** React components go through three phases:

  

**Mounting:**

- `constructor()` - Initialize state and bind methods

- `componentDidMount()` - After component is mounted (API calls, subscriptions)

  

**Updating:**

- `componentDidUpdate()` - After component updates

- `shouldComponentUpdate()` - Control whether component should re-render

  

**Unmounting:**

- `componentWillUnmount()` - Cleanup (remove listeners, cancel API calls)

  

```javascript

class MyComponent extends React.Component {

constructor(props) {

super(props);

this.state = { data: null };

}

  

componentDidMount() {

// API calls, event listeners

this.fetchData();

}

  

componentDidUpdate(prevProps, prevState) {

if (prevProps.userId !== this.props.userId) {

this.fetchData();

}

}

  

componentWillUnmount() {

// Cleanup

clearTimeout(this.timeoutId);

}

  

render() {

return <div>{this.state.data}</div>;

}

}

```

  

**10. What are hooks and why were they introduced?**

  

**Answer:** Hooks are functions that let you use state and lifecycle features in functional components. They were introduced to:

- Reuse stateful logic between components

- Simplify complex components

- Avoid "wrapper hell" from HOCs and render props

- Make components easier to understand

  

```javascript

// Before hooks (class component)

class Counter extends React.Component {

constructor(props) {

super(props);

this.state = { count: 0 };

}

  

componentDidMount() {

document.title = `Count: ${this.state.count}`;

}

  

componentDidUpdate() {

document.title = `Count: ${this.state.count}`;

}

  

render() {

return (

<button onClick={() => this.setState({ count: this.state.count + 1 })}>

{this.state.count}

</button>

);

}

}

  

// With hooks (functional component)

const Counter = () => {

const [count, setCount] = useState(0);

  

useEffect(() => {

document.title = `Count: ${count}`;

});

  

return (

<button onClick={() => setCount(count + 1)}>

{count}

</button>

);

};

```

  

**11. Difference between controlled and uncontrolled components**

  

**Answer:**

- **Controlled**: Form data is handled by React state

- **Uncontrolled**: Form data is handled by the DOM itself

  

```javascript

// Controlled component

const ControlledInput = () => {

const [value, setValue] = useState('');

  

return (

<input

value={value}

onChange={(e) => setValue(e.target.value)}

/>

);

};

  

// Uncontrolled component

const UncontrolledInput = () => {

const inputRef = useRef();

  

const handleSubmit = () => {

console.log(inputRef.current.value);

};

  

return <input ref={inputRef} />;

};

```

  

**12. How do you optimize React app performance?**

  

**Answer:**

1. **React.memo** - Prevent unnecessary re-renders

2. **useMemo** - Memoize expensive calculations

3. **useCallback** - Memoize functions

4. **Code splitting** - Lazy load components

5. **Virtual scrolling** - For large lists

6. **Avoid inline objects/functions** in JSX

  

```javascript

// React.memo

const ExpensiveComponent = React.memo(({ data }) => {

return <div>{data.name}</div>;

});

  

// useMemo

const ExpensiveList = ({ items, filter }) => {

const filteredItems = useMemo(() => {

return items.filter(item => item.category === filter);

}, [items, filter]);

  

return <div>{filteredItems.map(item => <Item key={item.id} {...item} />)}</div>;

};

  

// useCallback

const Parent = () => {

const [count, setCount] = useState(0);

const handleClick = useCallback(() => {

console.log('Button clicked');

}, []);

  

return <Child onClick={handleClick} />;

};

```

  

**13. What is prop drilling and how to avoid it?**

  

**Answer:** Prop drilling is passing props through multiple component levels even when intermediate components don't need them.

  

**Solutions:**

1. **Context API**

2. **State management libraries** (Redux, Zustand)

3. **Component composition**

  

```javascript

// Problem: Prop drilling

const App = () => {

const [user, setUser] = useState({ name: 'John' });

return <Parent user={user} />;

};

  

const Parent = ({ user }) => <Child user={user} />;

const Child = ({ user }) => <GrandChild user={user} />;

const GrandChild = ({ user }) => <div>{user.name}</div>;

  

// Solution: Context API

const UserContext = createContext();

  

const App = () => {

const [user, setUser] = useState({ name: 'John' });

return (

<UserContext.Provider value={user}>

<Parent />

</UserContext.Provider>

);

};

  

const GrandChild = () => {

const user = useContext(UserContext);

return <div>{user.name}</div>;

};

```

  

**14. Explain the difference between state and props**

  

**Answer:**

- **Props**: Data passed from parent to child, immutable, external

- **State**: Internal component data, mutable, causes re-renders when changed

  

```javascript

// Props example

const Parent = () => {

return <Child name="John" age={25} />;

};

  

const Child = ({ name, age }) => {

// Props are read-only

// name = "Jane"; // This would be wrong

return <div>{name} is {age} years old</div>;

};

  

// State example

const Counter = () => {

const [count, setCount] = useState(0); // State

  

return (

<div>

<p>{count}</p>

<button onClick={() => setCount(count + 1)}>+</button>

</div>

);

};

```

  

**15. What are keys in React and why are they important?**

  

**Answer:** Keys help React identify which list items have changed, been added, or removed. They should be stable, predictable, and unique.

  

```javascript

// Bad: Using array index

{items.map((item, index) => (

<div key={index}>{item.name}</div>

))}

  

// Good: Using unique identifier

{items.map((item) => (

<div key={item.id}>{item.name}</div>

))}

  

// Why keys matter:

// Without proper keys, React might:

// - Re-render unnecessary components

// - Lose component state

// - Have performance issues

```

  

**16. What is the difference between useMemo and useCallback?**

  

**Answer:**

- **useMemo**: Memoizes the result of a calculation

- **useCallback**: Memoizes a function definition

  

```javascript

const MyComponent = ({ items, multiplier }) => {

// useMemo - memoizes the calculated value

const expensiveValue = useMemo(() => {

return items.reduce((sum, item) => sum + item.value * multiplier, 0);

}, [items, multiplier]);

  

// useCallback - memoizes the function itself

const handleClick = useCallback((id) => {

console.log('Clicked item:', id);

}, []); // Function stays the same across re-renders

  

return (

<div>

<p>Total: {expensiveValue}</p>

{items.map(item => (

<button key={item.id} onClick={() => handleClick(item.id)}>

{item.name}

</button>

))}

</div>

);

};

```

  

**17. How do you handle side effects in React?**

  

**Answer:** Use the `useEffect` hook for side effects like API calls, subscriptions, timers, etc.

  

```javascript

const DataComponent = ({ userId }) => {

const [data, setData] = useState(null);

  

useEffect(() => {

// Side effect: API call

const fetchData = async () => {

const response = await fetch(`/api/users/${userId}`);

const userData = await response.json();

setData(userData);

};

  

fetchData();

}, [userId]); // Dependency array

  

useEffect(() => {

// Side effect: Timer

const timer = setInterval(() => {

console.log('Timer tick');

}, 1000);

  

// Cleanup function

return () => {

clearInterval(timer);

};

}, []);

  

return <div>{data?.name}</div>;

};

```

  

**18. What is JSX?**

  

**Answer:** JSX is a syntax extension for JavaScript that looks like HTML. It gets transpiled to React.createElement() calls.

  

```javascript

// JSX

const element = <h1 className="greeting">Hello, World!</h1>;

  

// Transpiles to:

const element = React.createElement(

'h1',

{ className: 'greeting' },

'Hello, World!'

);

```

  

**19. Explain React's reconciliation process**

  

**Answer:** Reconciliation is the process React uses to update the DOM efficiently:

1. When state changes, React creates a new virtual DOM tree

2. It compares (diffs) the new tree with the previous tree

3. It calculates the minimum changes needed

4. It updates only the changed parts in the real DOM

  

**Diffing Algorithm:**

- Different element types → Replace the entire subtree

- Same element type → Update only changed attributes

- Lists → Use keys to identify moved/added/removed items

  

**20. What are React Fragments?**

  

**Answer:** Fragments let you group multiple elements without adding extra DOM nodes.

  

```javascript

// Without Fragment (adds extra div)

const Component = () => {

return (

<div>

<h1>Title</h1>

<p>Description</p>

</div>

);

};

  

// With Fragment

const Component = () => {

return (

<React.Fragment>

<h1>Title</h1>

<p>Description</p>

</React.Fragment>

);

};

  

// Short syntax

const Component = () => {

return (

<>

<h1>Title</h1>

<p>Description</p>

</>

);

};

```

  

### Coding Challenges to Practice

1. Build a todo list with add/delete/toggle functionality

2. Create a search/filter component

3. Implement a counter with increment/decrement

4. Build a form with validation

5. Create a data fetching component with loading states

6. Implement a modal component

7. Build a pagination component

8. Create an accordion/collapsible component

  

## Quick Reference Commands

  

```bash

# Create React App

npx create-react-app my-app

cd my-app

npm start

  

# Install common packages

npm install axios react-router-dom

npm install -D @testing-library/react @testing-library/jest-dom

```

  

Remember: Focus on understanding concepts rather than memorizing syntax. Practice building small components and explaining your thought process out loud. Good luck with your interview!