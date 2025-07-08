### [SQL Project : The Movie Industry Analysis](https://github.com/TheWorldAtMyFingerTips/My_Projects/blob/main/SQL/Movies.sql)

---

### Abstract  
There are many factors that contribute to a movie’s success. This project is built from the perspective of someone planning to enter the movie industry and wanting a broad overview of how the industry performs. Using SQL, the project analyzes trends in movie releases, genres, revenue, and return on investment to help guide decisions for a debut film. The findings are presented through an Excel dashboard for easy interpretation and stakeholder use.

---

### Dataset Introduction  
[The Movies Dataset](https://www.kaggle.com/rounakbanik/the-movies-dataset) from Kaggle consists of 7 CSV files, including credits, keywords, links, movies_metadata, ratings, and more. For this project, four key files were used:  
- movies_metadata.csv – Contains detailed information on over 45,000 movies, including release dates, genres, budget, revenue, production companies, and more.  
- credits.csv – Includes cast and crew data for each movie, stored as stringified JSON.  
- ratings.csv – Contains over 1 million user ratings, linking users to movies via TMDB IDs.  
- links.csv – Provides mappings between TMDB, IMDB, and MovieLens IDs.  

Due to the large size of the files—especially ratings.csv (~693 MB)—Excel was not suitable for processing. SQL was used to efficiently load, clean, and analyze the data at scale.

---

### Problem Statement  
**What is the direction I should take in coming up with my debut movie?**  

Some of the questions answered include:  
* How does the trend of released movies look like from the angles of year-on-year, month-on-month?  
* What are the most often produced genres?  
* What movies have the highest return-on-investment?  
* What movies raked in the most revenue?

---

### Process Workflow  

#### *Planning*  
As Benjamin Franklin said,  
> "If you fail to plan, you are planning to fail."

Likewise when dealing with databases, it is good practice (an essential, for me), to start off with planning.  
I did this by doing up an ER-diagram:

###### ER-Diagram  
![ER-Diagram](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/ER-Diagram.JPG)

---

#### *Creating Database, Loading Data, Data Preparation*  
In the `SQL` Server, I created a new database named `MOVIES`, uploaded the files, linked the relationships, and then checked for duplicate rows in the files.  
You can see my code in the image below.

![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/2.%20Process%20-%20Creating%20Database%2C%20Loading%20Data%2C%20Data%20Preparation.png)

---

#### *Data Analysis*  
Moving on to the Data Analysis part, I took a top-down approach in analysing the data as I usually like to have an overall feel of what the dataset is about before I drill down into the nitty gritties (which might overwhelm if I started off there).

I was interested in looking at the data in the time frame of "years" rather than "dates", so I created a new column and filled this in by extracting it from the `release_date` column. I then did a query to get a sense of the number of movies released in a year, with the conditions that they are not `adult` movies (this is a clean presentation after all 😄), and that budget and revenue are not 0.

You can see my **code** and the **quick insight** in the image below.

![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/3.%20Data_Analysis_1.png)

Next, I wanted to compare the trend of movies released monthly for the years of 2012 to 2016. Did they increase or decrease over the years? When were the peak/lull periods? Viewing this in 3 columns of `released_year`, `released_month`, and count of movies wouldn't help much in comparing (unless you have an awesome brain that can reformat and do visualizations like a computer). And so I did a `pivot` to present the data in a more intuitive format. You can see my **code** and the **results** in the image below.

![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/4.%20Data%20Analysis_2.png)

> “If you do not know how to ask the right question, you discover nothing.” - W. Edwards Deming

In business (especially a profiteering one), where the bottom line is maximize profits with minimal resources, an important question in this case, would be "what are the movies with the highest return on investment?" My **code** below brings up the top 30 movies with the highest ROI in descending order. For conciseness sake, I have only displayed the top 10.

The top 2 movies with the highest ROI are "Paranormal Activity" and "The Blair Witch Project". Both are thriller movies.

![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/5.%20Data%20Analysis_3.png)

I did queries to see what are the movies which bring in the most revenue, and are the most expensive to produce as well. But let's leave this knowledge for later in the Dashboard Takeaways where it looks more aesthetically pleasing.  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/SQL%20code%20for%20highest%20revenue%20and%20cost.JPG)

![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/6.%20Data%20Analysis_4.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/7.%20Data%20Analysis_5.png)

---

#### *Data Manipulation*  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/8.%20Data_Manipulation_1.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/9.%20Data_Manipulation_2.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/10.%20Data_Manipulation_3.png)

---

#### *Excel Dashboard & Presentation*  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/11.%20Process%20-%20Import%20data%20into%20Excel.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/12.%20Dashboard_Takeaways_1.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/13.%20Dashboard_Takeaways_2.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/14.%20Dashboard_Takeaways_3.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/15.%20Dashboard_Takeaways_4.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/16.%20Dashboard_Takeaways_5.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/17.%20Dashboard_Takeaways_6.png)  
![](https://github.com/JoySeedhe/Movie-Industry-Analysis-SQL-Project/blob/main/SQL/images/18.%20Dashboard_Takeaways_7.png)

---

### 📊 Dashboard Takeaways

Over the last 5 years:
- The number of movies released remained fairly stable, averaging above 165 per year, with a peak of 192 in 2016.
- September consistently saw the highest number of releases, followed by October.
- In 2016, November had an unusual spike in releases—possibly a market test.

Most produced genres:
- **Drama** is the most frequently produced genre, followed by **Comedy**, **Thriller**, and **Action**.

Revenue and ROI insights:
- Movies generating the highest revenue are typically big-budget blockbusters.
- The most expensive movies to produce also tend to be blockbusters.
- Movies with the highest ROI are often **Horror/Thriller** (e.g., *Paranormal Activity*, *The Blair Witch Project*) and **Comedy** (e.g., *Super Size Me*, *The Full Monty*).

Franchise performance:
- The most released franchise is **Harry Potter**, followed by **Fast & Furious**, **Saw**, and **James Bond**.

Audience engagement:
- Movies with the highest number of ratings include *The Matrix* and *Fight Club*.
- Movies with extremely high average ratings (4.5–5) often have very few raters and may not be representative.

Example: *Star Wars Collection*
- Released in 1999, 2002, 2005, 2015, and 2016
- Most releases occurred in **May** and **December**
- Genres: **Action**, **Adventure**, **Science Fiction**, **Fantasy**

The dashboard allows stakeholders to:
- View revenue, budget, and ROI per movie
- Identify top-rated and most-rated films
- Filter by genre, year, and franchise using slicers

📌 **Final Suggestion**: Start with a high-ROI genre like **Horror** or **Thriller** for a debut film.

---


