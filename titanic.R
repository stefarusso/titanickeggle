#ANALISI DATI---------------------------------------------------------
test = read.csv(file = 'data/test.csv')
train = read.csv(file = 'data/train.csv')
test = data.frame(test)
train = data.frame(train)
train$Survived = as.factor(train$Survived)
train$Pclass = as.factor(train$Pclass)
test$Pclass = as.factor(test$Pclass)
#write.table(head(test),sep = " | ")
library(ggplot2)
library(RColorBrewer)
#display.brewer.all()
#GRAFICI
#plot = ggplot(train)+
#+ geom_bar(mapping=aes(x=Pclass,fill=Survived))
# png("pclass.png")
# print(plot)
# dev.off()
#tmp = train[c("Survived","Pclass")]
#rates = table(tmp)[2,]/(colSums(table(tmp)))
#rates = data.frame("pclass" = names(rates),"survival_rates"=unname(rates))
#ggplot(rates,aes(x=pclass,y=surv_rates))+
#+ geom_bar(stat="identity",fill=rev(brewer.pal(3,"Blues")))
# png("pclass_surv.png")
# print(plot)
# dev.off()
#rm(rates,tmp,plot)
#plot = ggplot(train,aes(x=Sex, fill=Survived))+
#geom_bar()+
#facet_grid(cols=vars(Pclass),scales = "free_y")

#Age
#
#median
train$Age_median=train$Age
train$Age_median[is.na(train$Age)]=summary(train$Age)["Median"]


#Titles cleaning
library(stringr)
train$Title = str_split_fixed(str_split_fixed(train$Name,",",2)[,2], ". ", 2)[,1]
train$Title = as.factor(train$Title)
train$Title[760]=" Miss" #the countess
train[which(train$Title==" Ms"),"Title"]=" Miss"
train[which(train$Title==" Capt"),"Title"]=" Mr"
train[which(train$Title==" Col"),"Title"]=" Mr"
train$Title[which(train$Title==" Major")] = " Mr"
train$Title[which(train$Title==" Dr" & train$Sex=="female")] = " Miss"
train$Title[which(train$Title==" Dr" & train$Sex=="male")] = " Mr"
train$Title[which(train$Title==" Jonkheer")] = " Mr"
train$Title[which(train$Title==" Lady")]=" Mrs"
train$Title[which(train$Title==" Mlle")] = " Miss"
train$Title[which(train$Title==" Mme")] = " Mrs"
train$Title[which(train$Title==" Sir")] = " Mr"
train$Title[which(train$Title==" Rev")] = " Mr"
train$Title=droplevels(train$Title)

# plot = ggplot(train, aes(x=Title,fill=Survived))+
# geom_bar()
# png("titles_surv.png")
# print(plot)
# dev.off()

#SibSp
#
#tmp=table(train[,c("SibSp","Survived")])
#tmp=data.frame(SibSp=names(tmp),Surv_Rates=unname(tmp))
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
#
# tmp=table(train[which(train$SibSp[which(train$Survived == 1)]==1),c("Age","Sex")])
# tmp=data.frame(tmp)
# as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
# tmp$Age = as.numeric.factor(tmp$Age)
#
#plot = ggplot(tmp)+
# geom_jitter(mapping=aes(x=Age,y=Freq))+
# facet_grid(cols=vars(Sex))
# png('surv_1sbsp.png')
# print(plot)
# dev.off()
#
#
#Parch
#
#tmp = table(train[,c("Survived","Parch")])
#tmp = tmp[2,]/colSums(tmp)
#tmp = data.frame(Parch = names(tmp),Surv_rates=unname(tmp) )
#plot = ggplot(tmp,aes(x=Parch,y=Surv_rates))+
# geom_bar(stat='identity')+
# labs(title="Survival probability while having parents or children on board")
# png("parch.png")
# print(plot)
# dev.off
#
#FamiliSize
train$FamilySize = train$SibSp + train$Parch
#tmp = table(train[,c("Survived","FamilySize")])
#tmp = tmp[2,]/colSums(tmp)
#tmp = data.frame(Family_size=names(tmp),surv_rates=unname(tmp))
#rm(tmp,plot)



#ML--------------------------------------------------
train_BAK=train
train=train_BAK[,c(1:5,13,14:15)]
#write.csv(train,file='train_clean.csv')


