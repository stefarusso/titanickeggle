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
