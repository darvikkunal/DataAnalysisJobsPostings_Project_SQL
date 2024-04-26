-- ::

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS Date 
FROM 
    job_postings_fact;

-- AT TIME ZONE

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS Date 
FROM 
    job_postings_fact
LIMIT 5;

-- EXTRACT
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS Date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM 
    job_postings_fact
LIMIT 5;

-- Example 

SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC;

-- Practice Problem 

SELECT 
    AVG(salary_year_avg) AS Average_Salary_Yearly,
    AVG(salary_hour_avg) AS Average_Salary_hour,
    job_schedule_type
FROM
    job_postings_fact
WHERE job_posted_date > 'June 1,2023'
GROUP BY job_schedule_type; 

-- Practice Problem 6

CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE feburary_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_jobs;

-- CASE 

SELECT 
    COUNT(job_id) AS number_of_jobs,
CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'OnSite'
END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

-- Practice Problem 1

SELECT 
job_id, job_title_short, salary_year_avg,
    CASE
        WHEN salary_year_avg <= 50000 THEN 'Low_Salary'
        WHEN salary_year_avg BETWEEN 51000 AND 70000 THEN 'Standard_salary'
        ELSE 'High_Salary'
    END AS Salary_Category

FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    job_id, job_title_short, salary_year_avg, Salary_Category
ORDER BY 
    Salary_Category ASC;


-- Practice Problem 7 

WITH remote_job_skills AS (
SELECT skill_id , COUNT(*) AS skill_count
FROM skills_job_dim AS skills_to_jobs
INNER JOIN job_postings_fact AS job_postings ON 
    job_postings.job_id = skills_to_jobs.job_id
WHERE job_postings.job_work_from_home = TRUE AND 
        job_postings.job_title_short = 'Data Analyst'
GROUP BY skill_id
)
SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER join skills_dim AS skills ON 
    skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;

-- Problem Subqueries 1

SELECT sd.skills,sjd.frequency
FROM (
select skill_id , count(*) as frequency
from skills_job_dim
GROUP BY skill_id
ORDER BY frequency DESC
LIMIT 5
)
AS sjd
JOIN skills_dim sd ON sjd.skill_id = sd.skill_id

--  Problem Subqueries 2

SELECT company_id,
total_postings,
CASE 
    WHEN total_postings < 10 THEN 'SMALL'
    WHEN total_postings BETWEEN 10 AND 50 THEN 'MEDIUM'
    ELSE 'LARGE'
END AS size_category 
FROM (
SELECT company_id, COUNT(*) AS total_postings
FROM job_postings_fact
GROUP BY company_id
ORDER BY total_postings DESC
)
AS job_count;

-- Practice Problem 8

SELECT 
    job_title_short , 
    job_location , 
    job_via, 
    job_posted_date :: DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT * 
    FROM feburary_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)
WHERE
    salary_year_avg >= 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC