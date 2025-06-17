SELECT 
*
FROM {{ref('dim_listings_cleaned')}} l
INNER JOIN {{ref('fct_reviews')}} r
USING (LISTING_ID)
WHERE l.CREATED_AT > r.REVIEW_DATE