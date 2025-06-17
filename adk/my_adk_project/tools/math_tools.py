from typing import Union

def calculate(a: float, b: float, operation: str) -> Union[float, str]:
    """
    Performs a basic arithmetic operation (addition, subtraction, multiplication, or division).
    This function is designed to be used as a tool by an LLM agent.

    Args:
        a: The first number.
        b: The second number.
        operation: The operation to perform. Must be one of 'add', 'subtract', 'multiply', or 'divide'.

    Returns:
        The result of the calculation, or an error message string.
    """
    if operation == 'add':
        return a + b
    elif operation == 'subtract':
        return a - b
    elif operation == 'multiply':
        return a * b
    elif operation == 'divide':
        if b == 0:
            return "Error: Division by zero."
        return a / b
    else:
        return f"Error: Unknown operation '{operation}'. Valid operations are 'add', 'subtract', 'multiply', 'divide'."

if __name__ == '__main__':
    print(f"10 + 5 = {calculate(10, 5, 'add')}")
    print(f"10 - 5 = {calculate(10, 5, 'subtract')}")
    print(f"10 * 5 = {calculate(10, 5, 'multiply')}")
    print(f"10 / 5 = {calculate(10, 5, 'divide')}")
    print(f"10 / 0 = {calculate(10, 0, 'divide')}")
    print(f"10 ? 5 = {calculate(10, 5, 'unknown')}") 