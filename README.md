# Introduction
Dive into the data job market! Focusing on data
analyst roles, this project explores top—paying
jobs, in—demand skills, and where high
demand meets high salary in data analytics.

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job
market more effectively, this project was born
from a desire to pinpoint top—paid and in—demand
skills,streamlining others work to find optimal
jobs.

Data hails from my [SQL Course](/csv_files/). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:


1. What are the top-paying data analyst jobs?
2. What skills are required fitnese top—paying skills are most in demand for data analysts jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher
salaries?
5. What are the most optimal skills to learn?

# Toots I Used

For my deep dive into the data analyst job market,
I harnessed the power of several key toots:
- **SQL**: The backbone of my analysis, allowing me to
query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management
system, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database
management and executing SQL queries.
- **Git & GitHub**: Essential for version control and
sharing my SQL scripts and analysis, ensuring
collaboration and project tracking. 

# The Analysis

To identify the highest—paying roles, I filtered
data analyst positions by average yearly salary
and location, focusing on remote jobs. This query
highlights the high paying opportunities in the
field.

``` sql
SELECT 
    job_id,
    job_title,
    name as company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

```
Here's the breakdown of the top data analyst jobs
in 2023:
- **Wide Salary Range:** Top 10 paying data
analyst roles span from $184,øøø to $650,øøø,
indicating significant salary potential in the
field.
- **Diverse Employers:** Companies like
SmartAsset, Meta, and AT&T are among those
offering high salades, showing a broad interest
across different industries.

- **Job Title Variety:** There's a high diversity
in job titles, from Data Analyst to Director of
Analytics, reflecting varied roles and
specializations within data analytics.

! [Top Paying Roles in Data Analytics](assets\1_Bar.png)

*Bar graph visualizing the salary for the top 10
salaries for data analysts; ChatGPT generated this
graph from my SQL query results*

# What I Learned

Throughout this adventure, I've turbocharged my
SQL toolkit with some serious firepower:

- **Complex Query Crafting:** Mastered the art
of advanced SQL, merging tables like a pro and
wielding WITH clauses for ninja—level temp table
maneuvers.
- **Data Aggregation:** Got cozy with GROUP BY
and turned aggregate functions like COUNT() and AVG
() into my data-summarizing sidekicks.
- **Analytical Wizardry:** Leveled up my
real—world puzzle—solving skills, turning
questions into actionable, insightful SQL queries.

## Conclusion

 **Top-Paying Data Analyst Jobs**:

 The highest-paying jobs for data analysts that allow
remote work offer a wide range of salaries, the
highest at $650,000!

## Thoughts
This project enhanced my SQL skills and provided
valuable insights into the data analyst job
market. The findings from the analysis serve as a
guide to prioritizing skill development and job
search efforts. Aspiring data analysts can better
position themselves in a competitive job market by
focusing on high-demand, high-salary skills. This
exploration highlights the importance of
continuous learning and adaptation to emerging
trends in the field of data analytics



