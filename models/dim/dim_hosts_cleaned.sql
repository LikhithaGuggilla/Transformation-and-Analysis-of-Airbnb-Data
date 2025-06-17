
{{
    config(
        materialized = 'view'
    )
}}

WITH SRC_HOSTS AS (
    SELECT * FROM {{ref('src_hosts')}}
)

SELECT
HOST_ID,
NVL(HOST_NAME,'Anonymus') AS HOST_NAME,
NVL(IS_SUPERHOST,'N/A') AS IS_SUPERHOST,
CREATED_AT,
UPDATED_AT
FROM SRC_HOSTS
