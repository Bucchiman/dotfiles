/*
 * FileName:     Program
 * Author: 8ucchiman
 * CreatedDate:  2023-03-25 12:39:03 +0900
 * LastModified: 2023-03-25 12:43:41 +0900
 * Reference: 8ucchiman.jp
 */

using System;
using System.Threading.Tasks;
using System.Threading;

namespace ConsoleApps{
    class TaskSample{
        static void Main(string[] argv){
            const int N = 3;
            Parallel.For(0, N, id => {
                Random rnd = new Random();
                for (int i=0; i<4; i++) {
                    Thread.Sleep(rnd.Next(50, 100));
                    Console.WriteLine("{0} (ID: {1})", i, id);
                }
            });
        }
    }
}
