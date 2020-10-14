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


library(stringr)
train$Title = str_split_fixed(str_split_fixed(train$Name,",",2)[,2], ". ", 2)[,1]
train$Title = as.factor(train$Title)
train$Title[760]=" Miss" #the countess
train$Title=droplevels(train$Title)

