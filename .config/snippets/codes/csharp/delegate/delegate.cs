/*
 *
 * delegate (引数リスト) {メソッド定義}
 * -> (int n) => {return n > 10;}
 *
*/

using System;
# if false
// デリゲート型の定義
delegate void SomeDelegate(int a);

class DelegateTest{
    static void Main(){
        SomeDelegate a = new SomeDelegate(A);
        a(256);
    }
    static void A(int n){
        Console.WriteLine("{0} is called.", n);
    }
}
#endif

# if true
class DelegateTest{
    static void Main(){
        var a = delegate(int n) {Console.WriteLine("{0} is called.", n);};
        a(256);
    }
}
#endif
