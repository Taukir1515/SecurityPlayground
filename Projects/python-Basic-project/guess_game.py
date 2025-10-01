from random import randint
# OR import random
# rand= random.random(1,4)

win_count=0
total_iterations=5
for x in range(total_iterations):        
    guess=int(input(f"#{x+1} Enter your guess value between 1 to 5: "))
    rand=randint(1,5)

    if guess==rand:
        print("You win")
        win_count=win_count+1
    else:
        print(f"You Lose. The correct guess was {rand}.")
    
print(f"Total win(s):{win_count} out of {total_iterations}") 
print(f"Win Percentage:{win_count/total_iterations *100:.2f}%")
