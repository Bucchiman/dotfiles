/*
 * FileName:     Program
 * Author: 8ucchiman
 * CreatedDate:  2023-03-25 01:09:04 +0900
 * LastModified: 2023-03-25 01:11:56 +0900
 * Reference: 8ucchiman.jp
 */

using System;
using System.Threading.Tasks;
using System.Threading;

namespace ConsoleApplication{
    class TaskSample{
        static void Main(string[] argv){
            const int N = 3;
            Parallel.For(0, N, id => {
                    Random rnd = new Random();
                    for (int i=0; i<4; i++) {
                        Thread.Sleep(rnd.Next(50, 1000));
                        Console.Write("{0} (ID: {1})\n", i, id);
                    }
            });
        }
    }
}
