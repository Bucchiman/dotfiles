/*
 * 非同期処理を実行
 *
 * using System;
 * using System.Threading.Tasks;
 * using System.Threading;
 *
 * const int num_threads = 3;
 * 
 */



// 
// Parallel.For
//    Args:
//          fromInclusive    開始インデックス
//          toExclusive      終了インデックス
//          body             デリゲート
// https://learn.microsoft.com/ja-jp/dotnet/api/system.threading.tasks.parallel.for?view=net-7.0
//
Parallel.For(0, num_threads, id =>
{
    Random rnd = new Random();

    for (int i = 0; i < 4; ++i)
    {
        Thread.Sleep(rnd.Next(50, 100)); // ランダムな間隔で処理を一時中断

        Console.Write("{0} (ID: {1})\n", i, id);
    }
});
// 並行して動かしている処理がすべて終わるまで、自動的に待つ
