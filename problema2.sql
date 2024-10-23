/* Find job postings from the first quarter that has salary greater than > 70 k
- Combine job posting tables from the first quarter of 2023
- Gets job postings with an average yearly salary > 70 k
*/
SELECT 
    first_quarter_jobs.job_title_short,
    first_quarter_jobs.job_location,
    first_quarter_jobs.job_posted_date::DATE,
    first_quarter_jobs.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
     ) AS first_quarter_jobs
WHERE first_quarter_jobs.salary_year_avg > 70000 AND
      first_quarter_jobs.job_title_short = 'Data Analyst'
ORDER BY first_quarter_jobs.salary_year_avg DESC