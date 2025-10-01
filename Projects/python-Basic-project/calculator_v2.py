value=input("Enter numbers separated by comma: \n")
numbers=value.split(",")

print("For addition & subtraction(with sign), press 1\nFor Multiplication, press 2 \nFor Division, press 3")
operator=input("Enter value: ")

# Addition & Subtraction
def add(numbers):
    addition=0
    for a in numbers:
        addition=addition+int(a)
    return addition

# Multiplication
def multi(numbers):
    result=1
    for b in numbers:
        result=result*int(b)
    return result

# Division
def div(numbers):
    result=int(numbers[0])
    if "0" in numbers[1:]:
        raise ValueError("Can not be divided by zero")
    else:
        for c in numbers[1:]:
            result=result/int(c)
    return result

if "1" in operator:
    print(f"Summation is {add(numbers)}")

if "2" in operator:
    print(f"Multiplication is {multi(numbers)}")

if "3" in operator:
    print(f"Division is {div(numbers):.4f}")

    





