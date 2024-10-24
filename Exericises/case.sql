CREATE TABLE January_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE February_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE March_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT 
    COUNT(job_id) AS Number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category;
/* Quiero categorizar los salarios por cada trabajo posteado
para ver si encaja en mi salario deseado.
* Poner salarios en diferentes secciones
* Define un alto, bajo y medio estandar de salario
* Solo quiero mirar roles de analista de datos
* Ordena de mayor a menor */

SELECT 
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 20 THEN 'Low'
        WHEN salary_hour_avg > 35 THEN 'High'
        ELSE 'Medium'
    END AS salary_rate
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
AND salary_hour_avg IS NOT NULL
ORDER BY salary_hour_avg DESC;
