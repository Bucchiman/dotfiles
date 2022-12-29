using System;

class FuncTest{
    static void Main(){
        string str = "This is a pen.";
        int len = 4;
        //Func<string, int, string> func = GetLeftStr;
        //Console.WriteLine($"No. {len}: {func(str, len)}");
        Func<string, int, string> func = (s, l) => {string ret = s.Substring(0, l); return ret;};
        Console.WriteLine(func(str, len));
    }
    static string GetLeftStr(string str, int len){
        string ret = str.Substring(0, len);
        return ret;
    }
}
