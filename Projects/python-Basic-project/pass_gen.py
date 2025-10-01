import random
import string
import secrets

passlen=random.randint(8,12)
rand_string=string.ascii_letters + string.digits+string.punctuation
rand_value=[] 

for x in range(passlen):        
   rand_value.append(random.choice(rand_string))

password="".join(rand_value)
print(f"Random {passlen} digit password is {password}")

secrets_list=[]
for x in range(passlen):
    secrets_list.append(secrets.choice(rand_string))
pass2="".join(secrets_list)
print(f"Secure {passlen} digit password is {pass2}")

        
        