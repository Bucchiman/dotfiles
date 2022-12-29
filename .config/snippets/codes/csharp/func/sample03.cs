using System;

namespace FuncSample03{
    class Program{
        static void Main(string[] argv){
            Func<int, int> func = CreateNumber;
            var result = func(100);
            Console.WriteLine($"{result}");
        }

        private static int CreateNumber(int max){
            var random = new Random();
            return random.Next(0, max);
        }
    }
}
