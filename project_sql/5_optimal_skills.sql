/* 
What are the most optimal skills to learn (AKA it's in hight demand and a hight-paying skill)?
- Identify skills in high demand and associated with high average salaries for data analyst roles
- Concentrates on remote position with specified salaries 
- Why? Target skills that offer job_security (high demand) and financial benefits (high salaries)
    offering strategic insights for career development in data analyst 
*/

WITH skills_demands AS (
    SELECT 
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id, skills_dim.skills
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id, skills_dim.skills
)

SELECT
    skills_demands.skills,
    skills_demands.skill_id,
    skills_demands.demand_count,
    average_salary.avg_salary
FROM
    skills_demands
INNER JOIN average_salary ON skills_demands.skill_id = average_salary.skill_id
WHERE
    skills_demands.demand_count > 10 
ORDER BY
    skills_demands.demand_count DESC,
    average_salary.avg_salary DESC
LIMIT 30