###############################################################################
############ COMPUTATIONAL BIOLOGY - ADELPHI UNIVERSITY #######################
############ PROFESSOR DOMINIC EVANGELISTA              #######################
###############################################################################
############ last updated Fall 2021                   #########################
###############################################################################

######################### Unit 0: Intro to this document#######################

#What is this document?
#This is an r-script document (a dot-r file). It is th most basic type of
#document that we can write R code in. If you are viewing this file in RStudio 
#(which you should be) you should be able to edit, and run code directly from
#this document with no need to compile anything (if you don't know what that is
#don't worry about it). When you run your code you will see the output in the 
#console window-pane or the viewer (if your output is a graphic).
#
#Throughout the semester we will be using other types of documents to write R
#code in, but for this first tutorial we are using the most fundamental kind.

######################### Unit 1: Intro to object-oriented programming#########

#What is programming? What is an object? 

# -programming, or "code" is text-based instructions that a computer can read
# -an object is a string of characters that is defined to contain some kind of
#  information (for example: a list of data, a function, or another object)

#By combining objects and methods (instructions, operations) in the proper way
#we can write programs to do lots of useful things. Of course we could do these
#things manually but we are limited by our mechanical speed and memory limits.


#1.1 R Syntax#

#R (like Java, C++, Python etc.) is a coding language. Just like regular
#language it has rules (syntax) that must be followed in order for it to make
#sense. If your syntax isn't right, then your code will either (a) throw an 
#error or (b) not give the output you intended.

#Using Google, find how the following characters are used in R and write what
# they do. I have completed the first one for you

#   #     comment character. Everything written on a line after # will not be executed. This is used for making notes in your code books.
#   =     
#   <-    
#   <<- 
#   ==  
#   ()    
#   $     
#   {}    
#   []    
#   [[]]  
#   ;     
#   :
#   %%
#   ~
#   \     
#   \\    

#There are many more symbols with special meanings in R. You can find many of
#them here: https://www.tutorialspoint.com/r/r_operators.htm
#I suggest you either take notes by adding them below, or bookmark the link for
#future reference.



#1.2 Importing data, and creating objects#

#Now that we have the basic tools to construct simple code we can try to import
#some data.

#You have already seen how we use the comment character "#". Execute the code
#below (one line at a time). Figure out what each of the outer functions do by 
#googling the function name. Then, to the right of the code, write a comment 
#explaining what that line of code is doing. I have done the first one for you.

setwd("C:\\Google Drive\\Projects\\PHY_Blab_2\\wing evolution paper\\morphological analysis") #This sets the "working directory" to whatever directory is specified in the quotes. You should change this to whatever folder you have put your data in. 
library(ape); library(phytools)

#Now let's define two objects. What do read.delim() and read.tree() do?
contData<-read.delim("continuous.Morpho4june2021.txt",row.names=1, sep="\t", colClasses = c("character",rep("numeric",12)), na.strings = "?")
BlattTree<-read.tree("bestTree.renamed.tre")

#We can see what those objects look like by asking R to evaluate them like this.
contData
BlattTree

#or we can do it like this. (Please continue making commented notes about what 
#each function does)
head(contData)

#contData is a very straightforward data type. It's a table of some kind.
#BlattTree is a bit more interesting. It gives a description of the data instead
#of showing us the actual data. Let's get more information about what these 
#objects might be and how they are structured. (Please continue making commented
#notes about what each function does)

typeof(contData)
str(contData)
dim(contData)

typeof(BlattTree)
str(BlattTree)
dim(BlattTree)

#1.3 Dataframes#

#Read the following tutorial https://www.tutorialspoint.com/r/r_data_frames.htm

#Why do we use dataframes? They seem overly complicated, but having data 
#packaged into a dataframe is useful. For instance, run...

str(contData)

#it gives us a lot of useful information about the data, including the variable
#names. We can then use those variable names to retrieve certain parts of our
#data and reorganize it for what we want to do.

#What do the following lines of code do?
contData$Wing.length
contData[c("Body.Length","Wing.length")]

#What does c() do? Try using the same functions to call other variables.


#Notice you are using the operator [] in the above function. Refer back to your
#notes on the use of [] and [[]] and how they are different. Now let's try some
#usage examples to see what they do. 

head(contData[1])
head(contData[2])
head(contData[1,])
head(contData[,1])
head(contData[2,1])

head(contData[[1]])
head(contData[[1]][[1]])
head(contData[[1]][[2]])

#I like to think of the [] operator to mean "part" and depending upon what you
#write inside the 'square brackets" you get a different part. You might think
# or it like this...
contData[1]   #gets variable 1 of the data on the top level (includes data.frame variable names)
contData[1,]  #gets the part of the data.frame that is in row 1 on the top level (includes data.frame variable names)
contData[,1]  #gets the part of the data.frame that is in column 1 below the top level (doesn't include data.frame variable names)
contData[2,1] #gets the part of the data.frame that is in row 2, column 1 


#Keep in mind that the square brackets operate like this
#object[row, column]

#Now explain what the following code does

contData[[1]]
contData[[1]][[1]]
contData[[1]][[2]]


#1.4 Basic scatter plot and linear model#

#If we want to take a look at our data, R offers some great visual options. 
#(Please continue making commented notes about what each new function does)
plot(contData[,c("Body.Length","Wing.length")], xlab="Body Length", ylab="Wing length",pch=21,bg="grey", cex=1.4)

#There looks like a correlation between the variables but we can't be sure
#unless we do a statistical test. Let's simply fit a linear model. (Please 
#continue making commented notes about what each new function does)

fit.ols<-lm(Body.Length~Wing.length,data=contData[,c("Body.Length","Wing.length")])
summary(fit.ols)

#Now that we know it's a significant correlation let's add a the model to our plot
{plot(contData[,c("Body.Length","Wing.length")], xlab="Body Length", ylab="Wing length",pch=21,bg="grey", cex=1.4)
abline(fit.ols,lwd=2,lty="dashed",col="red")}

  #Why are there "curly brackets" around the above code? What happens if you remove them?

#so what is fit.ols?
typeof(fit.ols)
str(fit.ols)

#Now we have an object called fit.ols that contains a linear model. As you can 
#see from the output of the above code we can treat fit.ols just like a list, or
#a data.frame.

#For example, if we want to know what the residuals are we can just do...
fit.ols$residuals

#or 

fit.ols[2]

#1.5 Loops and maps#

#Above, we did a regression to test if there is a relationship between wing
#length and body length in cockroaches. But wing length and body length are only
#two of the variables we have data on. We should check if there is a relationship
#between body length and some other variables too.

dependantVariables<-c("Total.wing.area","No..anal.veins", "Apical.field.area")
allLinearModels<<-c() 
for (i in 1:length(dependantVariables)) {
  allLinearModels[[length(allLinearModels)+1]]<-lm(Body.Length ~ . ,data=contData[,c("Body.Length",dependantVariables[i])]) #Note: the "." here tells the lm() function to include all other variables in the data as dependant variables. Since we are specifying that there is only one other variable in the data it does the job correctly.
  
}

#Now take a look at the new object we made "allLinearModels". First, we created 
#a list object with no values in it. Then we added values to it iteratively.

allLinearModels

#What are the dimensions of this object, what class is it and what is it's structure?

#When you need to do an iterative process for() is a very simple and useful
#function. However, there are other methods of iteration. A useful one is called
#mapping. Here you take a function and "map" it onto something (e.g., a subset
#of data, a row in a list, an object in a list of objects). Usually, the map
#function finishes when there is nothing left to map it on. That is one reason
#why it can be more efficient than using for(), which you have to specify the 
#stopping point.

#In R there are a series of mapping functions but a common one is lapply(). 
#Let's use lapply() to repeat what we did above.

dependantVariables<-c("Total.wing.area","No..anal.veins", "Apical.field.area")

allLinearModels<<-lapply(dependantVariables, function(x) lm(Body.Length ~ . ,data=contData[,c("Body.Length", x)]))

#Now take a look at the redefined "allLinearModels" object.

allLinearModels

#Is it at all different from the previous version of allLinearModels?

#Based on what you just did, how are "for loops" and "apply maps" different 
#from each other? Do you think one is better than the other?


#1.6 Logical tests, if-then statements and switches#

#Take a look at our data

contData[c("Body.Length","Wing.length")]

#It contains a few outliers. Archimandrita and Megaloblatta are massive compared
#to most of the other species. Perhaps removing them will result in a more fair 
#comparison of body length and wing length.

corrData1<-as.data.frame(lapply( contData[c("Body.Length","Wing.length")], function(x) ifelse(x>45, NA, x)))
plot(corrData1, xlab="Body Length", ylab="Wing length",pch=21,bg="grey", cex=1.4)


#Explain what the ifelse() function does and why we used the number "45" in it.


#What happens if you remove as.data.frame() from the above code? Does it work?
#Why?

#Where does the logical test occur in the above code?

#Read this short tutorial about logical values in R: http://www.r-tutor.com/r-introduction/basic-data-types/logical

#Now go to the following link and then list all the logical operators below
#including a description of their function: https://www.tutorialgateway.org/logical-operators-in-r/





print("CONGRATULATIONS! You now have completed your introduction to R coding.")
print("All of the tools and concepts used in this notebook will be revisited in later units. Therefore, the better your notes are in this document the better you will do in the rest of the class. Trust me, coding is 1000% easier when you have examples of working code you wrote before to refer back to. So make sure everything above is completed in an organized and thorough manner.")

