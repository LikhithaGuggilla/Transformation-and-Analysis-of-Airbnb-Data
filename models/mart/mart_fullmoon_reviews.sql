{{
    config(
        materialized = 'table',
    )
}}

WITH FCT_REVIEWS AS (
    SELECT * FROM {{ref('fct_reviews')}}
),
SEED_FULL_MOON_DATES AS (
    SELECT * FROM {{ref('seed_full_moon_dates')}}
)

SELECT
r.*,
CASE WHEN fm.FULL_MOON_DATE IS NULL THEN 'not full moon'
     ELSE 'full moon'
END AS IS_FULL_MOON
FROM FCT_REVIEWS r
LEFT JOIN SEED_FULL_MOON_DATES fm 
ON TO_DATE(r.REVIEW_DATE) = DATEADD(DAY, 1, fm.FULL_MOON_DATE) 
