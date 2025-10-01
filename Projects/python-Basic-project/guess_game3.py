from random import randint

print("press 0 to stop trying")
count=0
iteration=0

while True:
    rand=randint(1,5)
    
    try:
        value = int(input("Enter a random value within 1 to 5: "))
    except ValueError:
        print("Invalid input. Please enter a number within 1 to 5: ")
        continue
    
    
    if value==0:
        break
    elif value<1 or value>5:
        print("Value should be 1 to 5")
        continue

    iteration=iteration+1
    
    if rand==value:
        print("You won!!")
        count=count+1
    else:
        print(f"You lose. Correct guess is {rand}")

print("------------Result-----------------")        


if iteration==0:
    print("Total try: ",iteration)
    print(f"Total win(s): {count}")
else:
    correct_guess=count/iteration*100
    print("Total try: ",iteration)
    print(f"Total win(s): {count}")
    print(f"Correct guess:{correct_guess:.2f}%")
    print("If win percentage is below 25%, you lose.")
    if correct_guess >25:
        print(f"Result: Winner Winner Chicken Dinner!! ({correct_guess:.2f}%)")
    else:
        print(f"Result: Better Luck Next Time ({correct_guess:.2f}%)")