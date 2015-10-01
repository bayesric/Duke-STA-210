# Lab 6
# Created by Ye (Eric) Wang
# on 10/01/2015
# In this lab we will analyze a real-world dataset on housing values on suburbs of Boston

# library
#******************************************************
# <put any libraries that you need here>

#******************************************************

# import data
#******************************************************
# 1. directly import the dataset from http://archive.ics.uci.edu/ml/datasets/Housing
# 2. briefly read the data description at http://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.names
#    and manipulate your data frame to only contain CRIM, PTRATIO and MEDV. (Don't forget to properly name your columns)

#******************************************************

# EDA
#******************************************************
# 1. draw a pairwaise scatterplot of the three variables considered,
#    do you see a correlation between CRIM and MEDV and PTRATIO and MEDV?
#    what do you think of the normality of the data?
# 2. do a quick linear regression of MEDV agains CRIM and PTRATIO, check the model 
#    assumptions

#******************************************************

# transform the response variable
#******************************************************
# 1. choose the best box-cox transformation and do the regression again 
#    with the transformed response, check the model assumptions again
# 2. explain the coefficients

#******************************************************

# identifying the most influential point
#******************************************************
# 1. find the index of that point
# 2. draw two scatterplots, MEDV against CRIM and MEDV against PTRATIO, and annotate the influential point in theplots
# 3. delete that point from the dataset and redo regression analysis
# 4. is there a big difference between the coefficients with and without the influential point?
# 5. what should you do when such influential point exist?

#******************************************************
