# titanickeggle

## Data Handling
Train dataset has few features, but not all of them can be used as dataset for the alghoritm.

"PassengerId" | "Pclass" | "Name" | "Sex" | "Age" | "SibSp" | "Parch" | "Ticket" | "Fare" | "Cabin" | "Embarked"
--------------|----------|--------|-------|-------|---------|---------|----------|--------|---------|-----------|
 892 | 3 | "Kelly, Mr. James" | "male" | 34.5 | 0 | 0 | "330911" | 7.8292 | "" | "Q"

Pclass refers to the ticket class of the passenger and is a direct information of social class and economical wellness of the passenger whose surely changed the probability of surviving during sinking.
Looking at the survival rate it clear that the class of the passenger change their survival probability.

<img style="float: center;" src="/plot/pclass.png" width="40%" ><img style="float: center;" src="/plot/pclass_surv.png" width="40%" >

The gender of the passanger has effects on the chance of surviving, even if the passenger class continue to be the most diagnostic feature. Looking at the women it can be seen how they have much higher probability to survive than men, but when they come from third class their probability drop to 0.5.

<img style="float: center;" src="/plot/sex.png" width="40%" ><img style="float: center;" src="/plot/sex_pclass.png" width="40%" >

Another important feature of the dataset is the age. Young men are very likley to not survive if they are compared to children. But this coloumn has a problem: 

```
summary(train$Age)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.42   20.12   28.00   29.70   38.00   80.00     177 

```

There are 177 missing value on 891 total records, that can be a problem. There are few kind of way to deal with this issue, someone add the median value to the missing value, it's a cheap solution that has problem with; if there was more records it could been possible to use the existing 714 record as dataset to exitimate the missing ones with an another ML algoritm. But in this case I have seen many other people use another feature as indicator of passengers age, the name titles. Every name record it's composes as `Last_name, Title First_name (Maiden_name)` 

