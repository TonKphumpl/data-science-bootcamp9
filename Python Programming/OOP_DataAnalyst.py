## OOP = Object Oriented Programming
# class DataAnalyst

class DataAnalyst:
    def __init__(self, name, age, skill, email, salary):
        self.name = name,
        self.age = age,
        self.skill = skill,
        self.email = email,
        self.salary = salary

    def change(self, newname, newsalary):
        self.name = str(self.name).replace(str(self.name), newname)
        self.salary = str(self.salary).replace(str(self.salary), newsalary)

    def greeting(self):
        print(f"Hello, my name is {self.name}, I'm {self.age} years old.")
        print(f"My skills for Data Analyst: {self.skill}.")
        print(f"Expected Salary is {self.salary} bath/month.")
        print(f"You can contact me by {self.email}.")

    def addskill(self, newskill):
        print("--------------------------------------")
        print(f"My new skill: {newskill}.")
        self.skill = str(self.skill) + ", " + newskill
        print(f"My skills for Data Analyst: {self.skill}")
