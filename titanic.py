import pandas as pd

train = pd.read_csv("train_clean.csv")
test = pd.read_csv("test_clean.csv")
#train.head()
#train["Survived"].describe()
#train.dtypes
#train_x["Pclass"].value_counts(dropna=False)
train["Sex"]=train["Sex"].astype("category")
train_y = train["Survived"] #Algoritmi vogliono labels separate
train_x = train.drop(columns=["Unnamed: 0","PassengerId","Survived"])
train_id = train["PassengerId"]
train_x = train_x.drop(["Name"],axis=1)
#faccio la stessa cosa con i dati raw su cui trovare i valori attesi
final_x = test.drop(["Unnamed: 0","PassengerId","Name"],axis=1)
#final_x["Age_median"].isnull().values.any()
#cerca se ci sono null

from sklearn.model_selection import train_test_split #per estrarre outofbag
#one-hot encoding of categorical data
#Pclass
train_x = pd.concat([train_x,pd.get_dummies(train_x["Pclass"],prefix="Pclass")],axis=1).drop(["Pclass"],axis=1)
#Sex
train_x = pd.concat([train_x,pd.get_dummies(train_x["Sex"],prefix="Sex")],axis=1).drop(["Sex"],axis=1)
#titles
train_x = pd.concat([train_x,pd.get_dummies(train_x["Title"],prefix="Title")],axis=1).drop(["Title"],axis=1)
#stessa cosa su final
final_x = pd.concat([final_x,pd.get_dummies(final_x["Pclass"],prefix="Pclass")],axis=1).drop(["Pclass"],axis=1)
final_x = pd.concat([final_x,pd.get_dummies(final_x["Sex"],prefix="Sex")],axis=1).drop(["Sex"],axis=1)
final_x = pd.concat([final_x,pd.get_dummies(final_x["Title"],prefix="Title")],axis=1).drop(["Title"],axis=1)

#data normalization per valori int e float, in modo che incrementi nei valori siano esplicativi in qualsiasi delle feature
#IMPORTANTE USARE LE STESSE MU E SIGMA SU TEST E TRAIN
train_mean_age = train_x["Age_median"].describe()["mean"]
train_std_age = train_x["Age_median"].describe()["std"]

train_x["Age_median"] = (train_x["Age_median"]-train_mean_age)/(train_std_age)
final_x["Age_median"] = (final_x["Age_median"]-train_mean_age)/(train_std_age)

train_mean_family = train_x["FamilySize"].describe()["mean"]
train_std_family = train_x["FamilySize"].describe()["std"]

train_x["FamilySize"] = (train_x["FamilySize"]-train_mean_family)/(train_std_family)
final_x["FamilySize"] = (final_x["FamilySize"]-train_mean_family)/(train_std_family)


