using System;

#if false
class ActionTest{
    static void Main(){
        var action = new Action<int>((n) => {Console.WriteLine("{0} is called.", n);});
        action(256);
    }
}
#endif

#if true
class ActionTest{
    static void Main(){
        Action<int> action;
        action = A;
        action(256);
    }
    static void A(int n){
        Console.WriteLine("{0} is called", n);
    }
}
#endif


/* 
 * Action + anonymous
 * https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/lambda-expressions 
 * Expression lambda
 *      (input-parameters) => expression
 *
 * Statement lambda
 *      (input-parameters) => {<sequence-of-statements>}
 *
*/


/*
 * 引数なし                                                     | 引数あり
 * 1. delegateキーワードを使った古典的な書き方                  |
 *      Action action1 = delegate() {num++;}                    |           Action<int> action1 = delegate (int num) {num++;}
 * 2. varを使った書き方                                         |
 *      var action2 = new Action(delegate () {num++;});         |           var action2 = new Action<int>(delegate (int num) {num++;});
 * 3. ラムダ式で書く                                            |
 *      Action action3 = () => num++;                           |           Action<int> action3 = num => num++;
 * 4. varを使った書き方                                         |
 *      var action4 = new Action(() => num++);                  |           var action4 = new Action<int>(num => num++);
*/

