setwd('~/Desktop')
dataset_original <- read.csv("BodyFat.csv",header=TRUE,sep=',')
summary(dataset_original)
dataset <- read.csv("BodyFat_clean.csv",header=TRUE,sep=',')
dataset <- dataset[,-1]
#16 variables including density
dataset <- dataset[,-2]
summary(dataset)
model <- lm(BODYFAT~.,dataset)
#model_1 <- lm(BODYFAT~AGE+WEIGHT+HEIGHT+NECK+CHEST+ABDOMEN+HIP+THIGH+KNEE+ANKLE+BICEPS+FOREARM+WRIST,dataset)

model_3 <- lm(BODYFAT~AGE+WEIGHT+HEIGHT+NECK+CHEST+ABDOMEN+HIP+THIGH+KNEE+ANKLE+BICEPS+FOREARM+WRIST+res,dataset)

#Boruta feature selection
library(Boruta)
boruta_output <- Boruta(BODYFAT ~ AGE+WEIGHT+HEIGHT+NECK+CHEST+ABDOMEN+HIP+THIGH+KNEE+ANKLE+BICEPS+FOREARM+WRIST+res, data=na.omit(dataset), doTrace=0)  
boruta_signif <- getSelectedAttributes(boruta_output, withTentative = TRUE)
print(boruta_signif)
roughFixMod <- TentativeRoughFix(boruta_output)
boruta_signif <- getSelectedAttributes(roughFixMod)
imps <- attStats(roughFixMod)
imps2 = imps[imps$decision != 'Rejected', c('meanImp', 'decision')]
#Top five variables
head(imps2[order(-imps2$meanImp), ])
#Graph
plot(boruta_output, cex.axis=.7, las=2, xlab="", main="Variable Importance") 
#Cook's distance: 1. delete observations one at a time, refit the regression model on remaining (n-1) observations,
#examine how much all of the fitter values change when the ith observation is deleted.

#install.packages('relaimpo')
library(relaimpo)
# calculate relative importance
relImportance <- calc.relimp(model_3, type = "lmg", rela = F)  
# Sort
cat('Relative Importances: \n')
sort(round(relImportance$lmg, 3), decreasing=TRUE)
bootsub <- boot.relimp(BODYFAT~., data=dataset,b = 1000, type = 'lmg', rank = TRUE, diff = TRUE)
plot(booteval.relimp(bootsub, level=.95))

#Model Selection
model_se_1 <- lm(BODYFAT~ABDOMEN+CHEST,dataset)
summary(model_se_1)
model_se_2 <- lm(BODYFAT~ABDOMEN+HEIGHT,dataset)
summary(model_se_2)
model_se_3 <- lm(BODYFAT~ABDOMEN+WEIGHT,dataset)
summary(model_se_3)

#summary table of raw data
data_raw <- read.csv('BodyFat.csv',header=TRUE,sep=',')
summary(data_raw)