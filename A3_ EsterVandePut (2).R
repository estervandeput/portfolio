########################## A3: Binary Classification with a Bank Churn Data Set ##########################

# Access my desktop
getwd()
setwd("/Users/estervandeput/Desktop")
getwd()

# Read the BankChurnDataset.csv file
df.bankchurn <- read.csv('BankChurnDataset.csv')

# Install all the package needed
# (1) Amelia package
install.packages("Amelia")
library(Amelia)
# (2)  caTools packages
install.packages("caTools")
library(caTools)
# (3) ggplot
library(ggplot2)
# (4) dplyr
install.packages("dplyr")
library(dplyr)
# (5) caret
install.packages("caret")
library(caret)

########################## STEP 1:  Handle missing value in the data set ##########################

# Checked for any missing values in the dataset.
any(is.na(df.bankchurn))
# Resulted in 'TRUE', meaning there are missing values in the data.

# *************** Extra Step: ****************

# Checked for missing value using missmap
# using that code: 
# missmap(df.bankchurn, main="Bank Churn Data - Missing Values", 
            #col=c("yellow", "black"), legend=TRUE)
# Showed 0% of data missing, which was not accurate (see row30)
# Took off missmap plot as it took space and made my file run slower
# ********************************************

# Checked for missing values column by column. 
# Found 9 missing values total.
# As the data set is huge, this explain why the missmap showed 0% missing for only 9 values. 

# Found missing values in 2 columns: 

# (1) Missing values in 'Age':
df.bankchurn[is.na(df.bankchurn$Age),]

# (2) Missing values in 'EstimatedSalary':
df.bankchurn[is.na(df.bankchurn$EstimatedSalary),]

# Calculated the median for 'Age' and 'EstimatedSalary'
# Created 'a_median' and 'es_median':

# (1) 'Age' Median
a_median <- median(df.bankchurn$Age, na.rm=T)
print(a_median)

# (2) 'EstimatedSalary' Median
es_median <- median(df.bankchurn$EstimatedSalary, na.rm=T)
print(es_median)

# Filled in missing values with 'a_median' and 'es_median'
# By filling in by [row, column]:

# (1) Fill 6 missing value with 'a_median'
df.bankchurn[3,'Age'] <- a_median
df.bankchurn[12, 'Age'] <- a_median
df.bankchurn[17, 'Age'] <- a_median
df.bankchurn[9023, 'Age'] <- a_median
df.bankchurn[29919, 'Age'] <- a_median
df.bankchurn[29927, 'Age'] <- a_median

# (1) Fill 3 missing value with 'es_median'
df.bankchurn[4,'EstimatedSalary'] <- es_median
df.bankchurn[14,'EstimatedSalary'] <- es_median
df.bankchurn[29930,'EstimatedSalary'] <- es_median

# Double-checked all all missing values were handled:

# (1) 'Age'column (0 rows)
df.bankchurn[is.na(df.bankchurn$Age),]

# (2) 'EstimatedSalary' column (0 rows)
df.bankchurn[is.na(df.bankchurn$EstimatedSalary),]

# ******************* NOTE:*******************
# Could have also handled missing value by using a function
# As covered in class:

# (1) Used ggplot and find the median
pl <- ggplot(df.bankchurn,aes(x = factor(Exited),y = Age, fill = factor(Exited, labels = c("Not Churned", "Churned")))) +
  geom_boxplot(aes(group=Exited), alpha=0.4) +
  scale_y_continuous(breaks = seq(min(0), max(80), by = 2)) + 
  labs(x = "Exited", y = "Age", fill = "Customer Status") +
  scale_fill_manual(values = c("Not Churned" = "skyblue", "Churned" = "salmon"))

# print ggplot            
print(pl)       
            
             
# (2) Created the function (e.g. 'impute_a').
# P.S.: IsActiveMember or Exited are the only 2 column who would work with Churning.
# Picked Exited 
impute_a <- function(Age,Exited){
  out <- Age
  for (i in 1:length(Age)){
    
    if (is.na(Age[i])){
      
      if (Exited[i] == 0){
        out[i] <- 36 # see Age vs Not Churned in graph
        
      }else if (Exited[i] == 1){
        out[i] <- 44 # see Age vs Churned median in graph
        
      }else{
        out[i] <- 37 # overall Age median (row60)
      }
    }else{
      out[i]<-Age[i]
    }
  }
  return(out)
}  

# Filled in missing value in age column using function:
fixed.age <- impute_a(df.bankchurn$Age)
df.bankchurn$Age <- fixed.age
# This is redundant but I wanted to show that I knew how to do it.  

# Finally, doible-checked data for missing values.
str(df.bankchurn)
head(df.bankchurn,3)

########################## STEP 2: Divide the "BankChurnDataset" into the training and testing dataset ##########################

# Remove the unnecessary columns : Surname, ID, and CustomerId.
df.bankchurn <-  df.bankchurn %>%select(-Surname, -id, -CustomerId)

# Check the remaining columns 
head(df.bankchurn,3)
str(df.bankchurn)

# Created the training the model using logistic regression
log.model <- glm(formula=Exited ~ . , family = binomial(link='logit'),data = df.bankchurn)
summary(log.model)

# NEXT, created a test set out of the training set  
# Meaning, splitting the data into training data and  test data

# (1) Used the split function to split data
set.seed(123) # Ensure reproducibility
split = sample.split(df.bankchurn$Exited, SplitRatio = 0.70)
final.train = subset(df.bankchurn, split == TRUE)
final.test = subset(df.bankchurn, split == FALSE)

# (2) Trained the logistic regression model
final.log.model <- glm(formula=Exited ~ . , family = binomial(link='logit'),data = final.train) #glm= generalized linear model
summary(final.log.model)

# THEN, evaluated the model on the test set
fitted.probabilities <- predict(final.log.model,newdata=final.test,type='response')
fitted.results <- ifelse(fitted.probabilities > 0.5,1,0)

# Converted to factors to calculate sensitivity and specifity : 
final.test$Exited <- factor(final.test$Exited)
fitted.results <- factor(fitted.results)

# THEN, calculated (1) accuracy:
misClasificError <- mean(fitted.results != final.test$Exited)
print(paste('Accuracy:',1-misClasificError))
# The accuracy of 83.46% shows a strong predictive capability,
# In other words, the model identify correctly the customer-exit status

# (2) sensitivity:
sensitivity <-sensitivity(final.test$Exited, fitted.results)
print(paste('Sensitivity:', sensitivity))
# Sensitivity is 85.21%, meaning the model has a high ability to identify customer who exited. 
# In other words, 85.21% of the customers who ACTUALLY exited were correctly predicted by the model. 

# (3) specificity:
specificity <- specificity(final.test$Exited, fitted.results)
print(paste('Specificity:', specificity))
# Specificity is 69.90% correct when identifying customer who did NOT exit. 
# In other words, the model correctly identify +/- 70% od the customer who remained. 

# ALSO, created a Confusion Matrix:
table(final.test$Exited, fitted.results)
# The result from this confusion matrix show ahigher number of true negative (37325) vs only 3998 true positive
# This could suggest that the model is more 'conservative' when predicting customer who are likely to 'exit'. 

# OVERALL, the result suggest that the model is 'strong' in predicting customer churn, but there is always room for improvement 
# Now, let's used this trained logistic regression model to try and predict Exited in the NewCustomerDataset". 

########################## STEP 3: Use the model to predict customer churn using the "NewCustomerDataset" ##########################

# Imported/read the NewCustomerDataset.csv file
df.nc <- read.csv('NewCustomerDataset.csv')

# Checked for missing values in the dataset
# P.S.: Assuming Age and EstimatedSalary are also relevant in df.nc 
df.nc[is.na(df.nc$Age),]
df.nc[is.na(df.nc$EstimatedSalary),]
# showed 0 data missing in both

# Removed unnecessary column (same as in df.bankchurn)
df.nc <-  df.nc%>%select(-Surname, -id, -CustomerId)

# THEN, used the training model to predict 'Exited' customers: 
nc_probabilities <- predict(final.log.model, newdata = df.nc, type = 'response')
nc_predictions <- ifelse(nc_probabilities > 0.5,1,0)

# Added the predictions to the new customer dataset(df.nc), and created column
df.nc$Exited <- nc_predictions

# Displayed the the results
head(df.nc)

########################## STEP 4: Plotting and exploring the data using ggplot ##########################

# (1)  - From before - Box Plot of Age vs Exited, for the Bank Churn dataset

# Created the ggplot
pl <- ggplot(df.bankchurn,aes(x = factor(Exited),y = Age, fill = factor(Exited, labels = c("Not Churned", "Churned")))) +
  # picked the type of plot
  geom_boxplot(aes(group=Exited), alpha=0.4) +
  scale_y_continuous(breaks = seq(min(0), max(80), by = 2)) + 
  # labeled my graph
  labs(x = "Exited", y = "Age", fill = "Customer Status") +
  # filled the graph
  scale_fill_manual(values = c("Not Churned" = "skyblue", "Churned" = "salmon"))

print(pl)

# (2) Customer Exited by Age (BoxPlot) for nc.df

nc_1 <- ggplot(df.nc, aes(x = factor(Exited), y = Age, fill = factor(Exited))) +
  geom_boxplot() +
  labs(title="Customer Exited by Age", 
       x = 'Exited', 
       y = 'Age') +
  scale_fill_manual(values = c("0"='skyblue', "1"='salmon'), 
                    labels = c("0"='Not Exited', "1" = 'Exited'))

print(nc_1)

# ********* INSIGHTS: ********* 
# The age of the customer who 'Exited' tend to be higher than the one who remained, based on the median. 
# This suggests that age could be a decisive factor in churning customers. 
# There is a wider interquartile range for 'Exited' customer than for 'Not Exited'.
# This shows that age varies more in the customers who left versus the one who stayed.
# This could be due to multiple factor that could correlated with age/life-stages. 
# There is a spread of age in both Exited and Not Exited customers, which shows that there are customers of ALL age in both category. 
# *****************************

# (3) Customer exited vs not exited by Country (Exited vs Geography)

nc_2 <- ggplot(df.nc, aes(x= Geography, fill = factor(Exited))) +
  geom_bar(position = "stack") + 
  labs( title= 'Customer exited vs not exited by Country ', 
        x = "Country", 
        y = "Count") +
  scale_fill_manual(values= c('0' = 'skyblue', '1' = 'salmon'),
                    labels = c('0'= 'Not Exited', '1'= 'Exited')) 
print(nc_2)

# ********* INSIGHTS: *********  
# There are only 3 countries/region in the dataset
# France has the highest number of customer remaining ('Not Exited')
# This could suggest that France has a 'loyal customers'; a strong clientele and customer retention. 
# Accordingly, and proportionally, France has the least amount of customers who have Exited, compared to Germany and Spain. 
# Germany has the least amount of customers overall. 
# Germany also has the biggest proportion of customers who have Exited relative to its customer base. 
# Germany also as the HIGHEST number of customers who Exited overall. 
# This suggest that Germany should improve various area to understand why they have a lower customer retention.
# Spain is between France and Germany. 
# Spain has a high level of customer retention, proportionally as well.
# Spain also has a lower customer count than France, but slightly higher than Germany. 
# ***************************** 


# (4) Customer Exited vs Active Customers (Bar plot)
nc_3 <- ggplot(df.nc, aes(x = factor(IsActiveMember),fill = factor(Exited))) +
  geom_bar(position = 'dodge') +
  labs(title="Customer Exited vs Active Customers", 
       x = 'Active Customers Customers', 
       y = 'Exited Status') +
  scale_fill_manual(values = c("0"='skyblue', "1"='salmon'), 
                    labels = c("0"='Not Exited', "1" = 'Exited')) 

print(nc_3)
# ********* INSIGHTS: ********* 
# There is a SIGNIFICANT higher number of customer who are still active (0), compared to the one who exited (1)
# This shows a high retention rate and thus a loyal customer base. 
# This also suggest that most customers are happy/satisfied with the service. 
# There is a difference in 'count' between Active and Exited customers.
# This may be due to a imbalance in the dataset, which definitely should be taken in consideration. 
# Especially during model training and evaluation, to make sure our model is ACCURATE. 
# In other words, to ensure our model accurately predict performance (for customer retention).
# ***************************** 

# ********* IN CONCLUSION : ********* 
# When looking at the insights from the model evaluation (accuracy, specificity and sensitivity), and the graph. 
# And when applying the model to the NewCustomerDataset
# We can conclude that those 'predictions' we made based on the model can help the bank identify customer who are at risk of churning/leaving. 
# That is, those who are OLDER or located in Germany.
# We also found out that France clearly has a high customer retention. 
# The company should therefore look into what strategy that branch has adopted and try to adopt it in the 2 other locations. 
# All of these can help the bank/company come up with new strategy to increase their customer retention and lower customer churning. 

# 