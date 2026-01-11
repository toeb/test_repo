namespace Tsp.Core.Tests;

public class Class1Tests
{
    [Fact]
    public void GetMessage_ReturnsExpectedMessage()
    {
        // Arrange
        var instance = new Class1();

        // Act
        var result = instance.GetMessage();

        // Assert
        Assert.Equal("Hello from Tsp.Core", result);
    }
}
