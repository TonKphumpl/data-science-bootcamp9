# load library
library(tidyverse)
library(glue)
library(lubridate)

# glue messages
my_name <- "ton"
my_ages <- "22"

glue("Hi! my name is {my_name}. Today I'm {my_ages} years old.")

# library tidyverse
# data transformation => dplyr

# 1. select
# 2. filter
# 3. arrange
# 4. mutate => create new column
# 5. summarise + group_by

rownames(mtcars)
colnames(mtcars)

# new column name : model
mtcars <- rownames_to_column(mtcars, "model")

# select column 
select(mtcars, 1:5, 11)
select(mtcars, 1,2,5,8)
select(mtcars, mpg, hp, wt, 11)
select(mtcars, 11, mpg, wt)
select(mtcars, starts_with("a"))
select(mtcars, ends_with("p"))
select(mtcars, contains("a"))

m1 <- select(mtcars, mpg, hp, wt, 10)
view(m1)

# filter
filter(mtcars, hp > 200)
filter(mtcars, hp > 200 & mpg >= 15) # And
filter(mtcars, hp > 200 | mpg >= 15) # Or

#  piping : create pipeline in R
## pipeline
select(mtcars, mpg, hp, wt)

m2 <- mtcars %>%
  select(mpg, hp, wt) %>%
  filter(hp > 200) 

# Regular expression in R
state.name
# grep return position,value VS grepl return logical:true false
grep("^S", state.name, value = F) #  40 41
grep("^S", state.name, value = T) # "South Carolina" "South Dakota"
grepl("^S", state.name) # TRUE FALSE

# filter cars am==0 ;0 auto 1 manual
m3 <- mtcars %>%
  select(model, mpg, hp, wt, am) %>%
 #filter(am == 0)
 #filter(grepl("^M", model) & hp > 150)
 #filter(hp >= 100 & hp <= 200)
  filter(between(hp, 100, 200)) %>%  
  arrange(am, desc(hp))

# arrange
arrange(mtcars, desc(hp))
arrange(mtcars, am, desc(hp))

## write csv file
write_csv(m3,"result.csv")

# Part 2 
## mutate to create new columns
mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(mpg >= 20) %>%
# mutate(model_upper = toupper(model),
       # mpg_double = mpg*2,
       # mpg_hahah = mpg_double+10)
       ## =IF(am==0, "auto", "Manual")
  mutate(am = if_else(am==0, "auto", "Manual"))
      

## summarise, summarize
## aggregate function in SQL
m4 <- mtcars %>%
  mutate(am = if_else(am==0, 
                      "Auto", "Manual")) %>%
  group_by(am) %>%         
  summarise(avg_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_hp = max(hp),
            n = n()) # can use only in summarise

write_csv(m4, "datayouask.csv")

## Join in R
band_members
band_instruments

left_join(band_members, band_instruments, by="name")

inner_join(band_members, band_instruments, by="name")

full_join(band_members, band_instruments, by="name")

band_members %>%
  mutate(name_upper = toupper(name)) %>%
  left_join(band_instruments, by="name")

# case : join df but column name not same 
m5 <- band_members %>%
  select(member_name = name,
         band_name = band) %>%
  left_join(band_instruments,
            by = c("member_name" = "name"))

## random sampling
mtcars %>%
  sample_n(2) %>%
 #select(model)
  pull(model) 
# pull() : datatype = vector 
# for easy to use next time

mtcars %>%
  sample_frac(0.20) %>%
  summarise(avg_hp = mean(hp))

## summary
## 100% => Analytics
## 20%  => Statistics

## count
mtcars %>%
  mutate(am = if_else(am==0, "Auto",
                      "Manual")) %>%
  count(am) %>%
  mutate(pct = n / sum(n))

