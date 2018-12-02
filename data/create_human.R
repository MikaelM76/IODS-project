hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


#3.
str(hd)
dim(hd)
str(gii)
dim(gii)
summary(hd)
summary(gii)

#4.
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "LifeExp"
colnames(hd)[5] <- "EdYears"
colnames(hd)[5] <- "EdExp"
colnames(hd)[6] <- "EdMean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNIpc"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "MatMor"
colnames(gii)[5] <- "AdoBirth"
colnames(gii)[6] <- "WomenInParl"
colnames(gii)[7] <- "SecEdF"
colnames(gii)[8] <- "SecEdM"
colnames(gii)[9] <- "LabourF"
colnames(gii)[10] <- "LabourM"


#5
library(dplyr); library(ggplot2)
gii <- mutate(gii, SecEdratio = SecEdF/SecEdM)
gii <- mutate(gii, LabourRatio = LabourF/LabourM)


6.
human <- inner_join(hd, gii)
colnames(human)




##### Week 5

human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep = ",")

# The variables within the data include HDI ranking, HDI, Life expectancy, Education expectancy (years), Mean education time, 
# Gross national income, GNI minus ranking, Gender inequality index ranking, GII, Maternal mortality,
# Adolescent birth rate, Females in the parliament, Secondary education for F and M, Labor force participation for F and M
# And the ratios of females and males in secondary education and labor force.
str(human)
dim(human) 

# 1.
# Transforming GNI variable to numeric with string manipulation by replacing commas
library(stringr)
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric
str(human)

# 2. 
# Excluding unnecessary data and removing NA values
library(dplyr)

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
# Printing the data showing the rows with complete values (no missing data)
data.frame(human[-1], comp = complete.cases(human))

# 3. 
# Filtering the missing values out of the data
human <- filter(human, complete.cases(human)) # Now 155 observarions, so 40 got filtered
View(human)

# 4. 
# Removing the regions and 'world' from the dataframe and defining rownames with country names.
last <- nrow(human) - 7 # Last index
human_ <- human[1:last, ] # choosing all rows until the last index
row.names(human_) <- human_$Country # Adding countries as rownames
human_ <- select(human_, -Country) # Removing the column "country" from the dataframe, 155 observations and 8 variables

View(human_)
# Overwriting the old file
write.csv(human_, file="~/Documents/IODS-project/data/create_human.R", row.names = TRUE)

