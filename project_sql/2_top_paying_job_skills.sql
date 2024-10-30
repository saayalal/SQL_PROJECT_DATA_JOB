/*
Question: What skills are required for the top-paying data analyst job?
-Use top 10 highiest-paying data analyst job from the first query
-Add the specific skills required for these roles
-Why? It'll provide a detailed loo at which high-peyin job demand certain skills, 
 helping job seekers to understand wich skills to develop.
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id    
    WHERE 
        job_title = 'Data Analyst' AND
        job_location = 'Anywhere'  AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
LIMIT 15