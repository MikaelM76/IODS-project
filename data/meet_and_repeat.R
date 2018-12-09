#1. Reading the data and exploring it

rm(list=ls()) 
library(data.table)
library(dplyr)
library(stringr)
library(ggplot2)
library(GGally)
library(tidyr)

bprs <- fread("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T) 
rats <- fread("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", stringsAsFactors = F, na.strings = "..", drop = 1)

str(bprs)
str(rats)

dim(bprs)
dim(rats)


head(bprs)
head(rats)

summary(bprs)
summary(rats)



# BPRS is a "wide format"-dataset. All individual participates have their own rows and all responses are in separate columns (sorted by week)
# The first column indicates whether the participant is in the treatment group or the control group. 
# The second column consists of the "numbers" of the subjects, sorting all of the subjects individually, by number.
# The amount of participants is 40 and there are 11 variables on them (treatment, subject number, and observations for weeks 0 - 11)


# The RATS dataset is also in wide form so that there are 16 participants who are assigned an "ID",
# a number group from one to three and the rest of the variables provide the observations from differing times .


# 2. Turning cathegorical variables to factors
bprs$treatment <- factor(bprs$treatment) 
bprs$subject <- factor(bprs$subject)
bprs$week0 <- factor(bprs$week0)
bprs$week1 <- factor(bprs$week1)
bprs$week2 <- factor(bprs$week2)
bprs$week3 <- factor(bprs$week3)
bprs$week4 <- factor(bprs$week4)
bprs$week5 <- factor(bprs$week5)
bprs$week6 <- factor(bprs$week6)
bprs$week7 <- factor(bprs$week7)
bprs$week8 <- factor(bprs$week8)
#
rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)
rats$WD1 <- factor(rats$WD1)
rats$WD22 <- factor(rats$WD22)
rats$WD8 <- factor(rats$WD8)
rats$WD15 <- factor(rats$WD15)
rats$WD29 <- factor(rats$WD29)
rats$WD36 <- factor(rats$WD36)
rats$WD43 <- factor(rats$WD43)
rats$WD44 <- factor(rats$WD44)
rats$WD50 <- factor(rats$WD50)
rats$WD57 <- factor(rats$WD57)
rats$WD64 <- factor(rats$WD64)

rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)


# 3. Wide to long
bprsl <- bprs %>%
  gather(week, bprs, week0:week8)

ratsl <- rats %>%
  gather(Time, Weight, WD1:WD64)


# 4. Comparing the wide and long
names(bprsl)
names(ratsl)

str(bprsl)
str(ratsl)

summary(bprsl)
summary(ratsl)

glimpse(bprs)
glimpse(bprsl)
glimpse(rats)
glimpse(ratsl)


write.csv(bprsl, "bprsl.csv")
write.csv(ratsl, "ratsl.csv")

?fread

# The difference between the wide and long forms is their different ways of listing observations
# In the "long form", the variables are individually arranged to their own columns. This is also called
# the tidy data form, a standard method used to arrange data before analysing it.
# Instead, in the wide form, the observations from different points in time
# are all listed as different variables. This is the reason there are more variables in the wide form.

# The long form is convenient while using regression tools. The wide form also has it's own benefits and use, since it
# provides better summaries for variables (more information). The wide form is probably better for collecting data and studying the relevant variables
# individually