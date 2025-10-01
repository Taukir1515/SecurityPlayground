# Creates Secret passwords to a file

import string
import secrets
from random import randint

string_pass=string.ascii_letters+string.digits+string.punctuation

passwdlen=randint(10,12)
passw=0
for y in range(10):
    list_pass=[]
    for x in range(passwdlen):
        list_pass.append(secrets.choice(string_pass))

    password="".join(list_pass)
    passw=passw+1
    print(f"Password {passw} is {password}")

    pass_file=open("password_list.txt","a")
    pass_file.write(password + "\n") # creating new line for passwords
    pass_file.close()


