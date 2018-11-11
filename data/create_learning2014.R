
 
 # Mikael
 
 # 6.11.2018
 
 # The script file for exercise two
 
 learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=TRUE, 
                            "\t" )
 dim(learning2014)
 #The function shows how many rows and columns the data has
 
 str(learning2014)
 #The structure of the data organizes parts of the information on the data and 
 #shows and outlines different aspects of it

 
 library("dplyr")
 
 deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
 surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
 strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
 
 deep_columns <- select(learning2014, one_of(deep_questions))
 learning2014$deep <- rowMeans(deep_columns)
 
 surface_columns <- select(learning2014, one_of(surface_questions))
 learning2014$surf <- rowMeans(surface_columns)
 
 strategic_columns <- select(learning2014, one_of(strategic_questions))
 learning2014$stra <- rowMeans(strategic_columns)
 
 c <- c("learning2014$gender", "Age", "Attitude", "deep", "stra", "surf", "Points")
 
 keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
 
 
 learned2014 <- select(learning2014, one_of(keep_columns))
 str(learned2014)

 learned2014 <- filter(learned2014, Attitude > 0, deep > 0, stra > 0, surf > 0, Points > 0)
 str(learned2014)

 
 
 write.table(learned2014, file = "learning2014.txt", append = FALSE, quote = TRUE, sep = " ",
             eol = "\n", na = "NA", dec = ".", row.names = TRUE,
             col.names = TRUE, qmethod = c("escape", "double"),
             fileEncoding = "")
 
Save_file <- read.table("~/Documents/IODS-project/data/learning2014/learning2014.txt")

str(Save_file)
head(Save_file)


#Analysis part
library("GGally")

Students2014 <- read.table("~/Documents/IODS-project/data/learning2014/learning2014.txt")
#The students2014-data is a modification of a collection of results from a survey on learning. 
#It is restricted to seven important variables. Observations where exam points are zero are excluded.

str(Students2014)
dim(Students2014) 


plot(Students2014)

pairs(Students2014[-1])


ggpairs(Students2014, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))


library(ggplot2)
qplot(Attitude, Points, data = Students2014) + geom_smooth(method = "lm")
qplot(Age, Points, data = Students2014) + geom_smooth(method = "lm")
qplot(gender, Points, data = Students2014) + geom_smooth(method = "lm")
qplot(deep, Points, data = Students2014) + geom_smooth(method = "lm")
qplot(stra, Points, data = Students2014) + geom_smooth(method = "lm")
qplot(surf, Points, data = Students2014) + geom_smooth(method = "lm")


M_Attitude <- lm(Points ~ Attitude, data = Students2014)
summary(M_Attitude)

M_Age <- lm(Points ~ Age, data = Students2014)
summary(M_Age)

M_gender <- lm(Points ~ gender, data = Students2014)
summary(M_gender)

M_deep <- lm(Points ~ deep, data = Students2014)
summary(M_deep)

M_stra <- lm(Points ~ stra, data = Students2014)
summary(M_stra)

M_surf <- lm(Points ~ surf, data = Students2014)
summary(M_surf)


sapply(Students2014, mean, na.rm = TRUE)
sapply(Students2014, sd, na.rm = TRUE)


Model3 <- lm(Points ~ Attitude + Age + stra, data = Students2014)
plot(Model3)

r.squared(Model3, model = NULL, type = c("Attitude", "Age", "stra"), dfcor = TRUE) #Normal Q-Q
r.squared(Model3, model = NULL, type = c("Attitude", "Age", "stra"), dfcor = FALSE)
r.squared(Model3, model = "lm", type = c("Attitude", "Age", "stra"), dfcor = TRUE) #Res vs Lev
r.squared(Model3, model = "lm", type = c("Attitude", "Age", "stra"), dfcor = FALSE) #Res vs Fit

summary(Model3)

par(mfrow = c(2,2))
plot(Model3, which = c(1,2,5))





