# # let's learn python 101 together
# # today class abount 3 hours
# # create your own function
# # default argument
# # Ctrl + / = Comment all
#  def greeting(name="Trump", friend="Biden"): 
#      print(f"{name} is going to meet {friend} for lunch.")

# # call function
#  greeting(friend="Ton", name="Joey")

# # get user input
#  username = input("What's your name? ")
#  print("Hi! " + username)

# # greeting updated V2
#  def greeting_name():
#      username = input("What's your name?")
#      message = f"Hi {username}, what can I do for you today?"
#      print(message)

#  greeting_name()

# # double number
#  def fdouble():
#      # int float str bool
#      num = int(input("Give me one whole number: "))
#      print(num * 2)

#  fdouble()

# # string in python "hello"
# # function that is made for string => METHOD
#  text = "a duck walks into a bar"

#  print(text.upper() )

#  print(text.replace("duck","cat"))

#  print(text.capitalize())

#  print("python".capitalize())

#  print(text.split(" "))

#  name = "ton"
#  friend = "toy"
#  text2 = "{} is going to have lunch with {}".format(name, friend)

#  print(text2)

# # bool (boolean)
#  a = 10
#  b = 15
#  print(a > b) # False 0
#  print(a < b) # True 1
#  print(a == b)
#  print(a != b)
#  print(a >= b)
#  print(a <= b)

#  a = 10
#  b = 15
#  c = 20
#  d = 25

#  print(a > 5 and c < d)

#  print(10 == 5 or 6 > 2)

# ## 5 concepts essential for programming
# ## [1] variables : x =10
# ## [2] data types: int float str bool
# ## [3] data structure: list tuple dict set
# ## [4] control flow: if for while
# ## [5] function: def

# # string is IMMUTABLE
#  name = "Python"
#  print(name[0])
#  print(name[1])
#  print(name[5])
#  print(name[-1]) # the last char
#  print(name[-2]) # the 2nd last char

#  # replace P with C
#  print(name.replace("P", "C"))
#  print("C" + name[1:])


# # starts with list []
#  shopping_list = ["egg", "milk", "bread"
#                  "tissue", "salmon", "wine"]

#  # DRY: donot repeat yourself
#  for item in shopping_list:
#      if (item  == "milk" or item == "wine"):
#          continue # skip
#      else:
#          print(item)

# # start fresh
#  fruits = ["apple", "banana", "orange"]

#  # list method is mutable object
#  # .append() # add item
#  fruits.append("grape")
#  print(fruits)

#  # .pop() # remove item 
#  fruits.pop()
#  print(fruits)

#  # .remove()
#  fruits.remove("apple")
#  print(fruits)

# fav books
fav_books = [
    "Naked Statistics",
    "Think like a Freak",
    "Deep work"
  
]

fav_books.append("Bussiness Made Simple")

fav_books.insert(1, "Coach Builder")

print(fav_books)

fav_books.sort(reverse=True)
print(fav_books)

## Homework for Bootcamp 09

# Game: Pao Ying Chub

# def game():
    ## your code here
