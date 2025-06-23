# Airbnb Executive Dashboard & Data Pipeline
This project features a transformational data pipeline transforming raw Airbnb data (listings, reviews, hosts) into actionable metrics and delivers an Executive Dashboard for Airbnb analytics, providing insights into host activity, listing trends, and pricing.

**Tech Stack**
Snowflake | dbt | Preset | SQL | VS Code | Git 

---

## Data & Transformations

- **Source Data:** Airbnb data for `listings`, `reviews`, and `hosts` sourced from Amazon s3
- **DBT (Data Build Tool):**
    -   **Staging:** Cleaned and standardized raw data (e.g., `src_listings`, `src_reviews`, `src_hosts`).
    -   **Marts:** Created aggregated analytics models (e.g., `dim_listings_w_hosts`, `fct_reviews`, `mart_fullmoon_reviews `) that directly feed the dashboard. These models are primarily SQL-based and     focus on joining datasets.
    -   `dbt_utils`
-   **Snowflake:** Served as the data warehouse for both raw source data and the transformed analytical models created by dbt.

![DATALINEAGE](https://github.com/LikhithaGuggilla/Transformation-and-Analysis-of-Airbnb-Data/raw/main/Project%20Images/Data%20Lineage.png)

---

## Orchestration & Visualization

- **Dagster:** Defined assets based on dbt models and orchestrated the dbt transformation pipeline, ensuring data models are updated reliably for the executive dashboard. 

- **Preset:** Connected directly to the Snowflake analytics marts to build and display the interactive dashboard. Access for the dashboard, typically through a dedicated `REPORTER` role, is managed via dbt post-hooks that grant necessary `SELECT` permissions on the transformed data models after each dbt run.** 

![DASHBOARD](https://github.com/LikhithaGuggilla/Transformation-and-Analysis-of-Airbnb-Data/blob/main/Project%20Images/Executive%20Dashboard.png)

The Preset (Apache Superset) dashboard visualizes:
*   "Number of hosts" (14.1k) monitor the overall size of the host community & gives a snapshot of the platform's capacity to offer accommodations.
*   "New listings" (2.07k in Nov 2021) track the rate at which new listings are being added and its accompanying trend line shows growth trajectory, highlighting recent spikes or dips.
*   "Superhost distribution" (84.27% 'f' - not Superhost, 15.65% 't' - Superhost) assess the proportion of high-quality, experienced hosts and indicates the segment of hosts recognized for exceptional hospitality.
*   "Price distribution" histogram shows the concentration of listings across different price brackets, helping to understand market positioning.
*   "Full Moon vs Reviews" investigates unconventional correlations that might (or might not) affect guest experience. It attempts to see if there's any correlation between lunar cycles and the sentiment of reviews (positive, neutral, negative). Based on the visual, there appears to be no significant difference.


## Running This Project

To replicate this dashboard and pipeline:

1.  **Prerequisites:**
    *   Access to Snowflake, Preset.
    *   Python 3.8+, Git.
    *   Install dbt (`dbt-snowflake==1.9.0`), Dagster (`dagster`, `dagster-dbt==1.1.0`).

2.  **Setup:**
    *   Clone this repository [https://github.com/LikhithaGuggilla/Transformation-and-Analysis-of-Airbnb-Data.git]
    *   Configure `dbt` (via `profiles.yml`) to connect to your Snowflake instance.
    *   Configure `Dagster` (via `workspace.yaml`) to locate the pipeline definitions.
    *   Ensure your Snowflake user has permissions for the target database/schemas.

3.  **Pipeline Execution:**
- Load source data (CSVs for listings, reviews, hosts) from Amazon S3 [ https://dbtlearn.s3.amazonaws.com/hosts.csv, https://dbtlearn.s3.amazonaws.com/reviews.csv ,https://dbtlearn.s3.amazonaws.com/listings.csv] into your Snowflake staging area.
    - Navigate to the `dbt_project` directory and run:
        ```bash
        dbt run  # To execute transformations
        dbt test # To validate data quality
        ```
- Start Dagster UI:
        ```bash
        dagster dev
        ```
        And trigger the dbt assets/jobs.

4.  **Dashboard Setup:**
    *   In Preset, connect to your Snowflake database.
    *   Create datasets from the dbt-generated analytics tables (e.g., `fct_reviews`, `dim_listings_w_hosts`, `mart_full_moon_reviews`).
    *   Recreate or adapt the charts and dashboard shown in the screenshot.

## Repo Structure




