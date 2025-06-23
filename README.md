# Airbnb Executive Dashboard & Data Pipeline
This project features a transformational data pipeline transforming raw Airbnb data (listings, reviews, hosts) into actionable metrics and delivers an Executive Dashboard for Airbnb analytics, providing insights into host activity, listing trends, and pricing.

**Tech Stack**
Snowflake | dbt | Preset | SQL | VS Code | Git 

---

#### Data & Transformations

- **Source Data:** Airbnb data for `listings`, `reviews`, and `hosts` sourced from Amazon s3
- **DBT (Data Build Tool):**
    -   **Staging:** Cleaned and standardized raw data (e.g., `src_listings`, `src_reviews`, `src_hosts`).
    -   **Marts:** Created aggregated analytics models (e.g., `dim_listings_w_hosts`, `fct_reviews`, `mart_fullmoon_reviews `) that directly feed the dashboard. These models are primarily SQL-based and     focus on joining datasets.
    -   `dbt_utils`
    -   **Snapshots:** Implemented Type II SCD (`scd_raw_listings`, `scd_raw_hosts`) using Timestamp strategy on listings and hosts data.
-   **Snowflake:** Served as the data warehouse for both raw source data and the transformed analytical models created by dbt.

![DATALINEAGE](https://github.com/LikhithaGuggilla/Transformation-and-Analysis-of-Airbnb-Data/raw/main/Project%20Images/Data%20Lineage.png)

---

#### Visualization

- **Preset:** Connected directly to the Snowflake analytics marts to build and display the interactive dashboard. Access for the dashboard, typically through a dedicated `REPORTER` role, is managed via dbt post-hooks that grant necessary `SELECT` permissions on the transformed data models after each dbt run.** 

![DASHBOARD](https://github.com/LikhithaGuggilla/Transformation-and-Analysis-of-Airbnb-Data/blob/main/Project%20Images/Executive%20Dashboard.png)

The Preset (Apache Superset) dashboard visualizes:
*   "Number of hosts" (14.1k) monitor the overall size of the host community & gives a snapshot of the platform's capacity to offer accommodations.
*   "New listings" (2.07k in Nov 2021) track the rate at which new listings are being added and its accompanying trend line shows growth trajectory, highlighting recent spikes or dips.
*   "Superhost distribution" (84.27% 'f' - not Superhost, 15.65% 't' - Superhost) assess the proportion of high-quality, experienced hosts and indicates the segment of hosts recognized for exceptional hospitality.
*   "Price distribution" histogram shows the concentration of listings across different price brackets, helping to understand market positioning.
*   "Full Moon vs Reviews" investigates unconventional correlations that might (or might not) affect guest experience. It attempts to see if there's any correlation between lunar cycles and the sentiment of reviews (positive, neutral, negative). Based on the visual, there appears to be no significant difference.


#### Running This Project

1.  **Prerequisites:**
    *   Access to Snowflake, Preset.
    *   Python 3.8+, Git.
    *   Install dbt (`dbt-snowflake==1.9.0`)

2.  **Setup:**
    *   Clone this repository [https://github.com/LikhithaGuggilla/Transformation-and-Analysis-of-Airbnb-Data.git]
    *   Configure `dbt` (via `profiles.yml`) to connect to your Snowflake instance.
    *   Ensure your Snowflake user has permissions for the target database/schemas.

3.  **Execution:**
    * Load source data (CSVs for listings, reviews, hosts) from Amazon S3 [ https://dbtlearn.s3.amazonaws.com/hosts.csv, https://dbtlearn.s3.amazonaws.com/reviews.csv ,https://dbtlearn.s3.amazonaws.com/listings.csv] into your Snowflake staging area.
    * Navigate to the `dbt_project` directory and run:
        ```bash
        dbt run  # To execute transformations
        dbt test # To validate data quality
        ```

4.  **Dashboard Setup:**
    *   In Preset, connect to your Snowflake database.
    *   Create datasets from the dbt-generated analytics tables (e.g., `fct_reviews`, `dim_listings_w_hosts`, `mart_full_moon_reviews`).
    *   Recreate or adapt the charts and dashboard shown in the screenshot.

#### Repo Structure

```text
Transformation-and-Analysis-of-Airbnb-Data
├── analyses/                  
│   ├── .gitkeep
│   ├── analyses.yml           
│   └── full_moon_no_sleep.sql        # Analysis evaluating correlation between full moon dates and bad review
├── assets/                   
├── dbt_packages/              
├── logs/                                     
├── macros/                    
│   ├── .gitkeep
│   ├── logging.sql                   # Macro for custom logging
│   ├── no_nulls_in_columns.sql      # Macro for checking nulls
│   ├── positive_value.sql           # Macro for checking positive values
├── models/                  
│   ├── src/                         # Staging layer
│   │   ├── src_hosts.sql
│   │   ├── src_listings.sql
│   │   └── src_reviews.sql
│   ├── dim/                         # Dimensional models
│   │   ├── dim_hosts_cleaned.sql
│   │   ├── dim_listings_cleaned.sql
│   │   └── dim_listings_w_hosts.sql # Joins listings with host information
│   ├── fct/                         # Fact model
│   │   └── fct_reviews.sql
│   └── mart/                        
│       └── mart_fullmoon_reviews.sql # Mart for reviews during full moon
├── seeds/                     
│   ├── .gitkeep
│   └── seed_full_moon_dates.csv     # Data for full moon dates
├── snapshots/                 
│   ├── .gitkeep
│   ├── scd_raw_hosts.sql            # SCD II for capturing hosts data
│   └── scd_raw_listings.sql         # SCD II for capturing listings data
├── target/                    
├── tests/                     
│   ├── .gitkeep
│   ├── consistent_created_at.sql         # Test for date consistency
│   ├── dim_listings_minimum_nights.sql  # Test related to minimum nights in listings
│   └── no_nulls_in_dim_listings.sql     # Test for no nulls in listings columns
├── .gitignore                       
├── .gitmodules                      
├── dashboards.yml                    # dbt exposures: defining downstream uses of dbt models (e.g., preset dashboard)
├── dbt_project.yml                   # Main dbt project configuration file
├── overview.md                       # Overview documentation for the project
├── packages.yml                      # Declares dbt package dependencies (dbt_date, dbt_expectations, dbt_utils)
├── schema.yml                        # Defines model schemas, descriptions, and generic tests (not_null, unique, accepted values)
└── sources.yml                       # Defines data sources and their properties
