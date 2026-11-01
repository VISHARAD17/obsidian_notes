public class Solution {
    public static void main(String [] args){
        System.out.println("Hello world");
    }

    public boolean isValid(String s) {
        Stack<Character> stk = new Stack<>();

        for(char c: s.toCharArray()){
            if(isOpening(c)) stk.push(c);
            else if(isClosing(c) && stk.empty()) return false;
            else if (isClosing(c) && isValid(stk.peek(), c)) stk.pop();
            else return false;
        }
        return stk.empty() ? true: false;
    }

    private boolean isValid(char c1, char c2){
        return (c1 == '(' && c2 == ')') || (c1 == '[' && c2 == ']') || ( c1 == '{' && c2 == '}');
    }

    private boolean isOpening(char c){
        return (c == '(' || c == '{' || c == '[');
    }

    private boolean isClosing(char c){
        return (c == ')' || c == ']' || c == '}');
    }
}
