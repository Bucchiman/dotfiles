using System;

namespace FuncSample02{
    class Program{
        static void Main(string[] argv){
            Func<int> funcstore = Function;
            var num = funcstore();
            Console.WriteLine($"number is {num}.");
        }

        private static int Function(){
            return 3;
        }
    }
}
