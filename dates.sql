/*SELECT 
    job_schedule_type AS schedule_type,
    AVG(salary_year_avg) AS year_salary,
    AVG(salary_hour_avg) AS hour_salary
FROM 
    job_postings_fact
WHERE 
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    schedule_type;*/

/* Has una consulta que me cuente el numero de trabajos subidos por cada mes en 2023, ajustando
el job_posted_date para ser en 'America/new york' time zone antes de extraer el mes. Asume que el 
job_posted_dates esta almacenada en UTC, agrupa y ordena por cada mes.*/

SELECT
    COUNT (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS number_job,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
    
FROM job_postings_fact
GROUP by
    date_month
ORDER BY 
    date_month;

/* Has una consulta para encontrar empresas (incluyendo su nombre) que hayan subido trabajos
donde ofrescan seguro medico, en donde estos trabajos hayan sido subidos durante el segundo
cuarto del año 2023. Usa date extraction para filtrar por cuarto.*/

SELECT
    job_health_Insurance AS Health_ensurance,
    EXTRACT (MONTH FROM job_posted_date) AS date,
    companies.company_id,
    companies.name
FROM job_postings_fact
LEFT JOIN company_dim AS companies
    ON job_postings_fact.company_id = companies.company_id
WHERE 
    job_health_insurance = 'TRUE'
ORDER BY date ASC;

