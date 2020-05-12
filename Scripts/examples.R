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

#Regular expresiions

#Match a pattern in text
#<FUNCTION>(<TEXT>, <PATTERN>)

####REgular Expressions patterns

#Match text exactly (capitalisation/spacing matters
#... finish photo on camera


###WEEK 8########

#Anchoring

#  ^ - start 
#  $ - end


birds %>% 
  mutate(is_colourful =str_detect(species, "Rosella|Parrot"))

birds %>% 
  mutate(ainslie =str_detect(location, "Ainslie"))

#ainslie at the start
birds %>% 
  mutate(starts_ainslie =str_detect(location, "^Ainslie"))


#ainslie at the end
birds %>% 
  mutate(end_ainslie =str_detect(location, "Ainslie$"))

#Problem
#Using groupings with (), create a regex pattern that will match all the mountains in the location column using str_detect().

#Modify your pattern above with an anchoring to exclude ‘Black Mtn’ from the matched values.

birds %>% 
  mutate(is_mountain =str_detect(location, "Mount|Mt"))

#or

birds %>% 
  mutate(is_mountain =str_detect(location, "M(ount|t)"))

#or

birds %>% 
  mutate(is_mountain_start =str_detect(location, "^M(ount|t)"))

#or very simple..

birds %>% 
  mutate(is_mountain_start =str_detect(location, "^M"))

#from Stephen
birds %>% 
  mutate(mountain_start =str_detect(location, "^M(ount|t|tn)"))

#Quantifying  {}


birds %>% 
  mutate(double_o = str_detect(species,"oo"))

#or

birds %>% 
  mutate(double_o = str_detect(species,"o{2}"))

# o{2} is oo
# [a-z]{3} is [a-z][a-z][a-z]

birds %>% 
  mutate(any_doubled= str_detect(species, "[a-z]{2}")) 
#will pull out everything

birds %>% 
  mutate(any_doubled= str_extract(species, "[a-z]{2}"))

#Range {2,5}
birds %>% 
  mutate(any_doubled= str_detect(species, "[a-z]{2,5}"))

# 2 but it can repeat as many time as you want
birds %>% 
  mutate(any_doubled= str_detect(species, "[a-z]{2,}"))

#less than or equall to 2 times
birds %>% 
  mutate(any_doubled= str_detect(species,"[a-z]{,4}"))# doesn't work

#shortcut quantification
#? - {0,1}

birds %>% 
  mutate(short_mts= str_extract(location,"Mtn|Mt"))




birds %>% 
  mutate(short_mts= str_detect(location,"M(oun)?tn?"))

# ? works on last letter/entry

#shortcut
# * - {0,}
# + - {1,}


birds %>% 
  mutate(all =str_extract(species, ".+"))


birds %>% 
  mutate(gg= str_extract(species, ".ang +")) %>% 
  select(-count)
# + applies to the space

birds %>% 
  mutate(gg= str_extract(species, "(.ang )+")) %>% 
  select(-count)


#Problem
#Using the birds data, write a regex pattern using str_detect() or str_extract() that will match values in the date column that start with two digits, followed by a separator (/ or -).


birds %>% 
  mutate(double_digit = str_extract(date, "^[0-9]{2}(-|/)")) %>%
  select(-count)
#Can you modify this pattern so that it matches dates with two digits for the day, month, and year?
birds %>% 
  mutate(double_digit = str_extract(date, "[0-9]{2}(-|/)[0-9]{2}(-|/)[0-9]{2}$")) %>%
  select(-count)


#stephen

birds %>% 
  mutate(double_digit =str_extract(date, "^[0-9]{2}(/|-)")) #or

birds %>% 
  mutate(double_digit =str_extract(date, "^[0-9]{2}[/|-]")) #or

birds %>% 
  mutate(double_digit =str_extract(date, "^[0-9]{2}(/?-?)"))

birds %>% 
  mutate(double_digit =str_extract(date, "^[0-9]{2}[/-]"))
#second question
birds %>% 
  mutate(date_format = str_extract(date, "^[0-9]{2}[-/][0-9]{2}[-/][0-9]{2}$")) %>%
  select(-count)
#or
birds %>% 
  mutate(date_format = str_extract(date, "^([0-9]{2}[-/]?){3}$"))
   # ? means optional, can be there but doesn't have to be

birds %>% 
  mutate(has_dot =str_detect(location, "."))
# . is a regular expression wildcard so isn't meaning a dot
# this is a problem with lots of special characters eg | ? $

#escaping a character by starting with a backslash \
birds %>% 
  mutate(has_dot =str_detect(location, "\\."))

#bString "\\." <- pattern \. <- matches text .

#to identify a \\ put "\\\\"

#challenge
#The grouping characters – ( and ) – are special symbols in regex patterns. 
#What string do you need to write in R to match a ( character?
            
     #      "\\("
#Write a regex pattern using str_extract() that will extract the entire 
# bracketed statement in the count column of the birds data.
           
birds %>% 
  mutate(within_bracket =str_extract(count, "\\((.+)\\)")) 

birds %>% 
  mutate(within_bracket =str_extract(count, "\\(.+\\)"))
#do not need the brackets around .+

#shortcut ranges

# \\w means any word, same as [a-zA-Z0-9_]

#\\W means NOT a word character

#\\s - whitespace

#\\S - NOT whitespace

#\\d means any digit, same as [0-9]

#\\D means NOT a digit

birds %>% 
  mutate(double_space=str_detect(location, "\\w\\s\\s\\w"))

birds %>% 
  mutate(double_space=str_detect(location, "\\w\\s{2}\\w"))

birds %>% 
  mutate(double_space=str_detect(location, "\\s{2}")) #or "\\s\\s"

birds %>% 
  mutate(full_year=str_extract(date, "\\d{4}"))


#Challenge
#Take the regex pattern you wrote for the date challenge at the end of the last episode. 
#Can you rewrite it using \d and \D?
  birds %>% 
    mutate(date_format = str_extract(date, "^(\\d{2}\\D?){3}$"))
  
  
  #Using str_extract(), write a regex pattern that uses \w and \s to extract the first two words of each entry from the location column of the birds data. 
  #Is your result any different if you use \S and \s instead?

  birds %>% 
    mutate(two_word = str_extract(location, "^(\\w+\\W+\\w+)"))
  
  birds %>% 
    mutate(two_word = str_extract(location, "^(\\S+\\s+\\S+)"))

  #Shortcut
  #\\b - word boundary
  
  birds %>% 
    mutate(with_space=str_extract(species, "\\sgang\\s"))
  
  birds %>% 
    mutate(with_space=str_extract(species, "\\b[Gg]ang\\b"))

  
  #Backreferences
  
  #  \\1
  #() capture the match and then replicates it, so (A)\\1 equates to AA and 
  # (.)\\1 matches the first one and then reference s back to it to find a match eg finds a double letter
  
  birds %>% mutate(doubled= str_extract(species, "(.)\\1"))
  
#Challenge extract double letters from location column
  #Extract the doubled letters from the location column of the
  #birds data using backreferences.
  
  birds %>% 
    mutate(double_letter= str_extract(location, "(\\w)\\1"))
  
  
  birds %>% 
    mutate(repeat_digit =str_extract(date, "(\\d)\\1\\D"))
  
  
  birds %>% 
    mutate(palindrone =str_extract(date, "(\\d)(\\d)\\D\\2\\1"))
  
  
  #So the number goes back to the capture argument eg 1 goes back to the first 2 goes back to the second etc
  
  #challenge, what does this do
  
  birds %>% 
    mutate(pattern_one = str_detect(species, "(\\w)(\\w)\\1"),
           pattern_two=str_detect(species, "(\\w)(\\w)\\2"))
  
  #will look at extract
  birds %>% 
    mutate(pattern_one = str_extract(species, "(\\w)(\\w)\\1"),
           pattern_two=str_extract(species, "(\\w)(\\w)\\2"))
  
  #Woohoo replacing text
  
  #need to provide text to replace it with
  
  #str_replace() finda and replaces text
  
  birds %>% 
    mutate(fixed_date = str_replace(date, "Last Sunday", "19/1/20"))

  
  birds %>% 
    mutate(first = str_replace(location,"^\\w+", "First"))

  #challenge
  #Using str_replace() and the birds data:
    #Replace the “Eight” in the count column with the character “8”
  #Replace all hyphens (“-“) in the species column with spaces (“ “)
 # Replace the digits for the year in the date column with the text “Year”
  
  birds %>% 
    mutate(count= str_replace(count, "Eight","8")) %>% 
    mutate(species= str_replace(species, "-"," ")) %>% 
    mutate(date= str_replace(date, "\\d+$","Year"))
  
  #stephen answer
  birds %>% 
    mutate(replaced = str_replace(species, "-", " "))
  
  birds %>% 
    mutate(replaced = str_replace(count, "Eight", "8"))

  birds %>% 
    mutate(replaced = str_replace(date, "\\d+$", "Year"))  

  
  #sometimes not what you expetc
  
  birds %>% 
    mutate(no_caps=str_replace(location, "[A-Z]", "_"))
  #once it replaces once it stops and doesn't match all times
  
  #have to use  str_replace_all
  
  birds %>% 
    mutate(no_caps=str_replace_all(location, "[A-Z]", "_"))
  
  #deletes but can use str_remove or remove all
  

  
  birds %>% 
    mutate(no_caps=str_replace_all(location, "[A-Z]", ""))
  
  
  #this doesn't work
  birds %>% 
    mutate(no_caps=str_replace_all(location, "[A-Z]", "[a-z]"))
   # useful str_to_lower, lots of other ways to do this
  
  birds %>% 
    mutate(no_vowel=str_remove_all(species, "[aeiou]"))
  # can use Back references 
  birds %>% 
    mutate(fancy = str_replace_all(species, "(\\w+)", "*\\1*"))
  
  birds %>% 
    mutate(first_last = str_replace(species, "^(\\w).+(\\w)$", 
           "First: \\1, Last: \\2"))
##The END  
  
  