from random import randint
rand=randint(1,5)

count=0
iteration=5
for x in range(iteration):
    value=int(input("Enter random value within 1 to 5: "))
    if rand==value:
        print("You won!!")
        count=count+1
    else:
        print(f"You lose.Correct guess is {rand}")
        
print(f"Total win(s): {count}")
correct_guess=count/iteration*100
print(f"Correct guess:{correct_guess}%")

print("If win percentage is below 60%, you lose.")

if correct_guess >60:
    print("Result: Winner Winner Chicken Dinner!!")
else:
    print("Result: Better Luck Next Time")