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
>summary(train$Age)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   0.42   20.12   28.00   29.70   38.00   80.00     177 

```

There are 177 missing value on 891 total records, that can be a problem. There are few kind of way to deal with this issue, someone add the median value to the missing value, it's a cheap solution that I don't like particulary; if there was more records it could been possible to use the existing 714 record as dataset to exitimate the missing ones with an another ML algoritm. But in this case I have seen many other people use another feature as indicator of passengers age, the name titles. Every name record it's composes as `Last_name, Title First_name (Maiden_name)` so with some string handling it's possible to extract all the titles from the names:

```
>table(train$Title)

     Capt       Col       Don        Dr  Jonkheer      Lady     Major    Master 
        1         2         1         7         1         1         2        40 
     Miss      Mlle       Mme        Mr       Mrs        Ms       Rev       Sir 
      183         2         1       517       125         1         6         1 

```
most of the passangers can be classified as Mr and Mrs or Master and Miss, the other titles risk to lead an overfitting result so it's need to move those passenger titles in the most common four levels. For exemple Capt, Col and other military titles are indicative of men between 20 and 50 years old so they can be add to the Mr title. While looking inside the exeptions in the spare titles I have find something interesting:

```
    Survived Pclass                          Name    Sex Age Title
246        0      1   Minahan, Dr. William Edward   male  44    Dr
318        0      2          Moraweck, Dr. Ernest   male  54    Dr
399        0      2              Pain, Dr. Alfred   male  23    Dr
633        1      1     Stahelin-Maeglin, Dr. Max   male  32    Dr
661        1      1 Frauenthal, Dr. Henry William   male  50    Dr
767        0      1     Brewe, Dr. Arthur Jackson   male  NA    Dr
**797        1      1   Leader, Dr. Alice (Farnham) female  49    Dr**

```

in my ingeniuity I assumed that Dr would be all old men, but there is a woman, a surprise for the time of Titanic.
Looking at the probablity of surviving the sinking it's clear that the joung titles (Miss and Master) have much higher probability to survive rather than the older ones (Mrs and Mr).

<img style="float: center;" src="/plot/titles_surv.png" width="40%" ><img style="float: center;" src="/plot/sex_pclass.png" width="40%" >

Next coloumn is SibSp that is the abreviation of Siblings and Spouse, it's clear that more sibsp you have less is your probability to survive.

<img style="float: center;" src="/plot/sibsp.png" width="40%" ><img style="float: center;" src="/plot/surv_1sbsp.png" width="40%" >

 The peak in 1 sibsp it's probably relate to couple of marryed people. Analyzing how it is distribuited the population of the ones who survived and had 1 sibsp we can see that it's pretty homogeneous beside the peak in 20-30y men, they are probably the ones who was on the boat only with their spouse. For sure even the Parch (Parents or children) has an important role in defining how is likley to died on a sinking boat, probably the ones with bigger family as less probability to survive like the lonely ones. in some part Sibsp and Parch overlap the same information so it's more practical to unite the two info in only one FamilySize information: 

<img style="float: center;" src="/plot/family.png" width="40%" >

The more likely to survive were the people who had a small family around 2-4 people. If your family was above 5 people or you was alone on boat your probability rapidly drop.

The other coloumns don't seems to be particular interesting: the number of the ticket or the cabin, such as the fare paid are linked to the class of the passangers; the site where the passengers embarked on titanic has nothing to do on their probability to survive so don't interest us and we can drop those coloumns.
In the end I have the cleaned dataframe whose will be exported as csv to be imported to python were all the popular ML algorithms have libraries that in few cases are more practical than the ones on R.

```
>str(train)
'data.frame':	891 obs. of  6 variables:
 $ Survived  : Factor w/ 2 levels "0","1": 1 2 2 2 1 1 1 1 2 2 ...
 $ Pclass    : Factor w/ 3 levels "1","2","3": 3 1 3 1 3 3 1 3 3 2 ...
 $ Name      : Factor w/ 891 levels "Abbing, Mr. Anthony",..: 109 191 358 277 16 559 520 629 417 581 ...
 $ Sex       : Factor w/ 2 levels "female","male": 2 1 1 1 2 2 2 2 1 1 ...
 $ Title     : Factor w/ 5 levels " Don"," Master",..: 4 5 3 5 4 4 4 2 5 5 ...
 $ FamilySize: int  1 1 0 1 0 0 0 4 2 1 ...
```
