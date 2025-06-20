# Transformation-and-Analysis-of-Airbnb-Data
Developed DBT models for airbnb data transformation in snowflake &amp; published an executive dashboard leveraging this transformed data informing listings, reviews and hosts insights on preset (BI tool)

# Airbnb Executive Dashboard & Data Pipeline
This project delivers an Executive Dashboard for Airbnb analytics, providing insights into host activity, listing trends, and pricing. It features a transformational data pipeline transforming raw Airbnb data (listings, reviews, hosts) into actionable metrics.
## Tech Stack Used
Snowflake | dbt | Preset | SQL | VS Code | Git 

## Dashboard Key Insights

The Preset (Apache Superset) dashboard visualizes:
*   "Number of hosts" (14.1k) monitor the overall size of the host community & gives a snapshot of the platform's capacity to offer accommodations.
*   "New listings" (2.07k in Nov 2021) track the rate at which new listings are being added and its accompanying trend line shows growth trajectory, highlighting recent spikes or dips.
*   "Superhost distribution" (84.27% 'f' - not Superhost, 15.65% 't' - Superhost) assess the proportion of high-quality, experienced hosts and indicates the segment of hosts recognized for exceptional hospitality.
*   "Price distribution" histogram shows the concentration of listings across different price brackets, helping to understand market positioning.
*   "Full Moon vs Reviews" investigates unconventional correlations that might (or might not) affect guest experience. It attempts to see if there's any correlation between lunar cycles and the sentiment of reviews (positive, neutral, negative). Based on the visual, there appears to be no significant difference.

## Data & Transformations

- **Source Data:** Airbnb data for `listings`, `reviews`, and `hosts` sourced from Amazon s3
- **dbt (Data Build Tool):**
    -   **Staging:** Cleand and standardized raw data (e.g., `src_listings`, `src_reviews`, `src_hosts`).
    -   **Marts:** 
Created aggregated analytics tables (e.g., `dim_listings_w_hosts`, `fct_reviews`, `mart_fullmoon_reviews `) that directly feed the dashboard.
These models are primarily SQL-based and focus on joining datasets, metrics like [XXX]
-   **Snowflake:** Serves as the data warehouse for both raw source data and the transformed analytical tables created by dbt.

[DATA LINEAGE]

## Orchestration & Visualization

*   **Dagster:** Defined assets based on dbt models; And orchestrated the dbt transformation pipeline, ensuring data models are updated reliably[XXX schedule] for the executive dashboard. 

[DAGSTER LINEAGE]

* **Preset:** Connects directly to the Snowflake analytics marts to build and display the interactive dashboard. Access for the dashboard, typically through a dedicated `REPORTER` role, which is managed via dbt post-hooks that grant necessary `SELECT` permissions on the transformed data models after each dbt run.** 

[DASHBOARD]


## Running This Project

To replicate this dashboard and pipeline:

1.  **Prerequisites:**
    *   Access to Snowflake, Preset.
    *   Python 3.8+, Git.
    *   Install dbt (`dbt-snowflake==1.9.0`), Dagster (`dagster`, `dagster-dbt==1.1.0`).

2.  **Setup:**
    *   Clone this repository [URL]
    *   Configure `dbt` (via `profiles.yml`) to connect to your Snowflake instance.
    *   Configure `Dagster` (via `workspace.yaml`) to locate the pipeline definitions.
    *   Ensure your Snowflake user has permissions for the target database/schemas.

3.  **Pipeline Execution:**
- Load source data (CSVs for listings, reviews, hosts) from Amazon S3 [URL] into your Snowflake staging area.
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
    *   Create datasets from the dbt-generated analytics tables (e.g., `fct_listings_daily`, `dim_hosts`).
    *   Recreate or adapt the charts and dashboard shown in the screenshot.

## Repo Structure




