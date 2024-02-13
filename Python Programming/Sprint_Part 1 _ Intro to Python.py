# -*- coding: utf-8 -*-

# -- Sheet --

# # Review Python Langauge


# ## Variable


my_name = "Ton" # 'ton'
my_age = 23

print(my_name)
print(my_age)

print(1 + 1)
print(2 * 2)
print(5 / 2)
print(8 - 5)

# ## String


# string & fstring in Python
my_name = "Ton"
my_university = "Silpakorn"

my_long_string = """This is a very long
    This is a second line
    This is a third line
"""

print(my_name, my_university, my_long_string)

# ### fstring


# fstring template
my_name = "Ton" 
my_age = 23

text = f"my name is {my_name}, and I am {my_age} years old."
print(text)

# ## String Methods


# function designed for string (string methods)
text = "a duck walks into a bar"

# ### Upper


text.upper()

# ### Lower


"HELLO WORLD".lower()

# ### Count


text.count("duck")

# ### Replace


text2 = text.replace('duck', 'lion')
print(text)
print(text2)

# ## List


# list 
shopping_list = ['egg', 'milk', 'bread']
print(shopping_list)

print(shopping_list[0])
print(shopping_list[1])
print(shopping_list[2])
print(shopping_list[0:2])

# ### Append


# list method = append
shopping_list.append('orange juice')
print(shopping_list)

shopping_list.append('water bottle')
print(shopping_list)

# ### Pop


# list method .pop()
shopping_list.pop()

shopping_list

# ### Len


len(shopping_list)

# ## Dictionary


# dictionary key-value pair

student = {
    "id": 1,
    "name": "Marry",
    "age": 22,
    "movies": ["Spider Man", "Thor", "Iron Man 3"]
}

print(student['name'])
print(student['movies'])
print(student['movies'][0])
print(student['movies'][1])
print(student['movies'][2])

student['city'] = 'London'
student

# ### Update key-values


# update value
student['city'] = 'Manchester'
student

# ### Remove key-value


# remove key-value
del student['city']
student

# ## Function


# user-defined function
def hello(username): 
    print("Hello! " + username)

hello("Ton")

def my_sum (val1, val2):
    return val1 + val2

result = my_sum(5, 15)

print(result)

# ## OOP : Object Oriented Programming


class Dog:
    name ="Ton"
    age = 5
    color = "Brown"
    breed = "French Bulldog"

    # function (Dog method)
    def sitting(self):
        print("I am sitting now!")

    def hungry(self, food_name):
        print(f"I am hungry, I need {food_name}!")

my_dog =  Dog()
type(my_dog)

my_dog.breed

my_dog.sitting()

my_dog.hungry("Hamburger")

