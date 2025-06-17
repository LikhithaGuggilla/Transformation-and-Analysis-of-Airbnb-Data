WITH fullmoon_reviews AS (
    SELECT * FROM {{ ref('mart_fullmoon_reviews') }}
)

SELECT 
    IS_FULLMOON,
    REVIEW_SENTIMENT,
    COUNT(*) AS REVIEWS_COUNT
FROM full_moon_reviews
GROUP BY 
    IS_FULLMOON, 
    REVIEW_SENTIMENT
ORDER BY 
    IS_FULLMOON, 
    REVIEW_SENTIMENT
