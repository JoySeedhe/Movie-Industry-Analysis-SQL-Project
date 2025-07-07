# SQL

### Introduction
Structured Query Language was the fourth core in the curriculum after the modules of Basics of Data Science, Power Query, and Excel. We started off with an introduction to databases, schemas, Entity-Relationship Diagrams, then moved on to SQL datatypes, basic commands, conditional operators, functions and aggregate functions, set operators, joins, and  finished off with stored procedures.

This Capstone Project was designed to ignite our cognitive process, reinforce and apply our knowledge to "real-life" cases so as to solidify our learnings. We were graded on our ability to showcase and exhibit the five stages of the data lifecycle through the use of SQL and Excel (data collection, creating tables and loading data into SQL databases, data preparation, data analysis using SQL, creating Excel interactive dashboard and visualizations, presentation to stakeholders).</br></br>

### [Capstone Project 2: The Movie Industry, An Overview](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/Movies.sql)

### Abstract
As like most things in life, there are a plethora of variables as to what makes a movie a "success". This project is based off the angle that my target audience is looking towards going into the movie business and would like to get a overall sense of the movie industry.</br></br>

### Dataset Introduction
[The Movies Dataset](https://www.kaggle.com/rounakbanik/the-movies-dataset) consists of 7 csv files (credits, keywords, links, moview_metadata, ratings, etc.). The files are too massive to process in excel, and so SQL comes in to save the day!</br></br>

### Problem Statement
**What is the direction I should take in coming up with my debut movie?** </br></br>
Some of the questions answered include:
* How does the trend of released movies look like from the angles of year-on-year, month-on-month?
* What are the most often produced genres?
* What movies have the highest return-on-investment?
* What movies raked in the most revenue?</br></br>

### Process Workflow
#### *Planning*
As Benjamin Franklin said,
> "If you fail to plan, you are planning to fail."

Likewise when dealing with databases, it is good practice (an essential, for me), to start off with planning.</br>
I did this by doing up an ER-diagram:

###### ER-Diagram
![ER-Diagram](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/ER-Diagram.JPG)</br></br>

#### *Creating Database, Loading Data, Data Preparation*
In the `SQL` Server, I created a new database named `MOVIES`, uploaded the files, linked the relationships, and then checked for duplicate rows in the files. </br>
You can see my code in the image below.</br></br>
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/2.%20Process%20-%20Creating%20Database%2C%20Loading%20Data%2C%20Data%20Preparation.png)</br>

#### *Data Analysis*
Moving on to the Data Analysis part, I took a top-down approach in analysing the data as I usually like to have an overall feel of what the dataset is about before I drill down into the nitty gritties (which might overwhelm if I started off there).

I was interested in looking at the data in the time frame of "years" rather than "dates", so I created a new column and filled this in by extracting it from the `release_date` column. I then did a query to get a sense of the number of movies released in a year, with the conditions that they are not `adult` movies (this is a clean presentation afterall :grin:), and that budget and revenue are not 0.

You can see my **code** and the **quick insight** in the image below.</br></br>
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/3.%20Data_Analysis_1.png)</br></br>

Next, I wanted to compare the trend of movies released monthly for the years of 2012 to 2016. Did they increase or decrease over the years? When were the peak/lull periods? Viewing this in 3 columns of `released_year`, `released_month`, and count of movies wouldn't help much in comparing (unless you have an awesome brain that can reformat and do visualizations like a computer). And so I did a `pivot` to present the data in a more intuitive format. You can see my **code** and the **results** in the image below.</br></br>
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/4.%20Data%20Analysis_2.png)</br>

> “If you do not know how to ask the right question, you discover nothing.” - W. Edwards Deming

In business (especially a profiteering one), where the bottom line is maximize profits with minimal resources, an important question in this case, would be "what are the movies with the highest return on investment?" My **code** below brings up the top 30 movies with the highest ROI in descending order. For conciseness sake, I have only displayed the top 10.

The top 2 movies with the highest ROI are "Paranormal Activity" and "The Blair Witch Project". Both are thriller movies.

![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/5.%20Data%20Analysis_3.png)

I did queries to see what are the movies which bring in the most revenue, and are the most expensive to produce as well. But let's leave this knowledge for later in the Dashboard Takeaways where it looks more aesthetically pleasing.
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/SQL%20code%20for%20highest%20revenue%20and%20cost.JPG)


![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/6.%20Data%20Analysis_4.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/7.%20Data%20Analysis_5.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/8.%20Data_Manipulation_1.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/9.%20Data_Manipulation_2.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/10.%20Data_Manipulation_3.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/11.%20Process%20-%20Import%20data%20into%20Excel.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/12.%20Dashboard_Takeaways_1.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/13.%20Dashboard_Takeaways_2.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/14.%20Dashboard_Takeaways_3.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/15.%20Dashboard_Takeaways_4.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/16.%20Dashboard_Takeaways_5.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/17.%20Dashboard_Takeaways_6.png)
![](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/images/18.%20Dashboard_Takeaways_7.png)


