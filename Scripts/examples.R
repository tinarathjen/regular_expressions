#regular expressions are not r code, they predate r and can be used 
#in other languages. So some of the ways of writing them are not the same as r.

library(tidyverse)

#or

library(stringr)

#stringr in tidyverse

#Bird counts
bird_counts <- read_csv("rawdata/bird_counts.csv")

#fruit is a vector

fruit

#answering questions
length(fruit)
fruit[1]
fruit[length(fruit)]

#str_detect is equivalent to excel find, but the output in TRUE or FALSE

str_detect(fruit, pattern='apricot')
fruit[2]


str_detect(fruit, "apple")

#detects part of word
str_detect(fruit, "rine")

#capital/lowercase specific
str_detect(fruit, "Banana")

str_detect(fruit, "berry")

#spaces are important
str_detect(fruit, " berry")

# putting str_detect inside sum 
# will tell you how many are true
# TRUE=1, FALSE=0
sum(str_detect(fruit, "apple"))
#apple pineapple

sum(str_detect(fruit, "rine"))
#nectarine mandarine tangerine

sum(str_detect(fruit, "Banana"))
# no Banana with capital, case matters
#Banana != banana
sum(str_detect(fruit, "berry"))
#lots of berries

sum(str_detect(fruit, " berry"))
# spaces are important, goji berry, salal berry

#using a pipe
str_detect(fruit, pattern= 'berry') %>% sum()


#sophia got one extra by
str_detect(fruit, pattern= 'berry') %>%
  sum(c(TRUE))
# always good to do a practice on a small set to make sure code working as you think it should work


#Write a str_detect() pattern that will find the following fruits:

#canary melon, rock melon, and watermelon.
sum(str_detect(fruit, pattern= 'melon')) 
str_detect(fruit, pattern= 'melon')
  
#kiwi fruit, star fruit, and ugli fruit (but not breadfruit, dragonfruit, etc.).
sum(str_detect(fruit, pattern= ' fruit')) 
str_detect(fruit, pattern= ' fruit')
  
#clementine and cloudberry.
sum(str_detect(fruit, pattern= 'cl')) 
str_detect(fruit, pattern= 'cl')

# In words, how could we identify ‘blackcurrant’ and ‘redcurrant’ from the list of fruits, 
# while ignoring the plain ‘currant’?
str_detect(fruit, pattern= '.currant')
sum(str_detect(fruit, pattern= '.currant'))

#special characters, . is a wildcard, anything being there

sum(str_detect(fruit, pattern='a..e'))
sum(str_detect(fruit, pattern='s..r'))
str_detect(fruit, pattern='s..r')
fruit[str_detect(fruit, pattern='s..r')]

#working on a tibble or data frame
framed_fruit <- tibble(fruit_name = fruit)
framed_fruit %>% 
  mutate(has_apple = str_detect(fruit_name, "apple"))

framed_fruit %>% 
  filter(str_detect(fruit_name, "apple"))

#All currants (blackcurrant, redcurrant, and currant)

currant <- framed_fruit %>% 
  filter(str_detect(fruit_name, "currant"))

#Just the blackcurrant and redcurrant

coloured_currants <- 
framed_fruit %>% 
  filter(str_detect(fruit_name, ".currant"))

#Bird counts
birds <- read_csv("rawdata/bird_counts.csv")
birds

# | OR - Allow alternative matches
birds %>% 
  mutate(is_colourful = str_detect(species, "Rosella|Parrot"))

birds %>% 
  mutate(not_cockatoo = str_detect(species, "Rosella|Parrot|Magpie"))


# [] alternatives for a single character

birds %>% 
  mutate(l_vowel=str_detect(location, "l[aeiou]"))

#case matters
# [abcde] same as [a-e]
#[0123456789] same as [0-9]
#[a-zA-Z] for both cases

#looking for two digits
birds %>%
  mutate(double_digits=str_detect(count, "[0-9][0-9]"))

#not a characters ^ is a not [^a-z]

birds %>% 
  mutate(non_numeric = str_detect(count, "[^0-9]"))

#Text containing either Magpie or cockatoo (case sensitive)
birds %>% 
  mutate(Magpie_cockatoo = str_detect(species, "Magpie|cockatoo"))

#Text with either an i, o or u character
birds %>% 
  mutate(iou_location = str_detect(location, "[iou]"))

#Any uppercase text character
birds %>% 
  mutate(capital_letter = str_detect(count, "[A-Z]"))

#Any character except for 3, 4, or 5.
birds %>% 
  mutate(numbers_345 = str_detect(date, "[^3-5]"))


# Grouping: uses regular brackets ()
birds %>% 
  mutate(lakes = str_detect(location, "Lake|BG"))

# grouping so L(ake|BG) means Lake or LBG 
birds %>% 
  mutate(lakes = str_detect(location, "L(ake|BG)"))

#all the gang gang with variations in spelling, capital, dashes/spaces
birds %>% 
  mutate(gang_gangs = str_detect(species, "Gang(-| )(G|g)ang"))
#or
birds %>% 
  mutate(gang_gangs = str_detect(species, "Gang(-| ).ang"))
#or
birds %>% 
  mutate(gang_gangs = str_detect(species, "Gang[- ][Gg]ang"))

#Regular Expressions, REGEX
#str_detect() T/F
#str_extract() gives you back the string

birds %>% 
  mutate(gang_gangs = str_extract(species, "Gang[- ][Gg]ang"))
