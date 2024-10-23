SELECT * 
FROM ( -- AQUI EMPIEZA LA SUBCONSULTA
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- AQUI TERMINA LA SUBCONSULTA

WITH january_jobs AS ( -- DEFINICION CTE EMPIEZA AQUI
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) -- DEFINICION DE CTE TERMINA AQUI 

SELECT *
FROM january_jobs;


SELECT name AS company_name
FROM company_dim 
WHERE company_id IN (
    SELECT 
        company_id
    FROM
        job_postings_fact 
    WHERE
        job_no_degree_mention = true 
)

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT (*) AS total_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
) 

SELECT company_dim.name AS company_name,
       company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count
    ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC


WITH skill_count AS (
    SELECT 
        skill_id,
        COUNT (*) AS Total_skill
    FROM 
        skills_job_dim
    GROUP BY
        skill_id 
        )

SELECT 
    skills_dim.skills AS skills_name,
    skill_count.Total_skill
FROM skills_dim
LEFT JOIN skill_count
    ON skill_count.skill_id = skills_dim.skill_id
ORDER BY Total_skill DESC