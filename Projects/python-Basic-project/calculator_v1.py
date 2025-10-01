value1=int(input("Enter 1st number: "))
value2=int(input("Enter 2nd number: "))

# Addition
def addition(value1,value2):
    add=value1+value2
    return add

# Subtraction
def subtraction(value1,value2):
    sub=value1-value2
    return sub

# Multiplication
def multi(value1,value2):
    mul=value1*value2
    return mul

# Division
def div(value1,value2):
    if value2==0:
        raise ValueError("Can't be divided by zero")
    else:
        div=value1/value2
    return div

print("For addition, press 1 \nFor Subtraction, press 2 \nFor Multiplication, press 3 \nFor Division, press 4")
operator=input("Enter your value: ")

if "1" in operator:
    print("Result of addition:",addition(value1,value2))
elif "2" in operator:
    print("Result of subtraction:",subtraction(value1,value2))
elif "3" in operator:
    print("Result of multiplication:",multi(value1,value2))
elif "4" in operator:
    print(f"Result of division: {div(value1,value2):.4f}")    
else:
    print("Oops!! Value not found")