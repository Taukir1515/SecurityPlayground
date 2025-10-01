print("**** WELCOME TO ROCK-PAPER-SCISSOR ****")
from random import randint
print("Enter 0 to stop playing")
print("--------Rules-------")
print("press 1 for rock")
print("press 2 for paper")
print("press 3 for scissor")
print("----------- Let's Play ------------")
win_count=0
tie_count=0
iteration=0
while True:
    rand_number=randint(1,3)
    try:
        user_value=int(input("Enter a random number within 1 to 3: "))
    except ValueError:
        print("Invalid Input. Enter a random number within 1 to 3: ")
        continue
    
    if user_value==0:
        break
    elif user_value<1 or user_value>3:
        print("Invalid Input. Enter a random number within 1 to 3: ")
        continue
    
    iteration=iteration+1
    
    if user_value==1 and rand_number==3:
        print("You win. You break the scissor.")
        win_count=win_count+1
    elif user_value==2 and rand_number==1:
        print("You win. You cover the rock.")
        win_count=win_count+1
    elif user_value==3 and rand_number==2:
        print("You win. You cut the paper.")
        win_count=win_count+1
    elif rand_number==1 and user_value==3:
        print("You lose. Rock broke your scissor.")
    elif rand_number==2 and user_value==1:
        print("You lose. paper covered your rock.")
    elif rand_number==3 and user_value==2:
        print("You lose. Scissor cut your paper.") 
    else:
        print("It's a tie.")
        tie_count=tie_count+1 


print("--------Result--------")

if iteration==0:
    print("Total try: ",iteration)
    print("Total win: ",win_count)   
    print(f"Win percentage: 0.00%")
else:
    win_percentage=win_count*100/(iteration)
    tie_percentage=tie_count*100/(iteration)
    
    print(f"Total try:{iteration}")
    print(f"Total win:{win_count}")
    print(f"Total tie:{tie_count}")
    print(f"Win percentage {win_percentage:.2f}%")
    print(f"Tie percentage:{tie_percentage:.2f}%")

        
