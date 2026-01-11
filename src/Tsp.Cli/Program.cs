using Tsp.Core;

namespace Tsp.Cli;

class Program
{
    static void Main(string[] args)
    {
        var core = new Class1();
        Console.WriteLine(core.GetMessage());
        Console.WriteLine("Tsp.Cli is running!");
    }
}
