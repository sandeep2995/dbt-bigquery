# Execution in dbt Cloud IDE
- **dbt run**: runs all the models
- **dbt test**: test all the models
- **dbt build**: runs and tests each model one-be-one according to the DAG
- **dbt run --select < model-name >**: runs only the select model
- **dbt run-operation < macro-name > --args < args >**: invokes and runs the given macro.
- **dbt run -m < model-1 > < model-2 >**: runs the selected models
- **dbt docs generate**: generates the docs
- **dbt run --select < model-name >+**: runs the selected model and all its downstream models
- **dbt run --select +< model-name >**: runs the upstream models and then the selected model
- **dbt run --select +< model-name >+**: runs the upstream models, selected model and all its downstream models
- **dbt snapshot**: execute the snapshot models.

# dbt-bigquery
Integrates dbt (data build tool) with the gcp bigquery

Step-1: Setup dbt cloud as noted at [set-up-dbt-cloud](https://learn.getdbt.com/learn/course/dbt-fundamentals/set-up-dbt-cloud-55min/getting-started?page=2) 

Step-2: Connect git repo to the dbt using [join-a-project-in-dbt-cloud-and-bigquery](https://learn.getdbt.com/learn/course/dbt-cloud-and-bigquery-for-developers/join-a-project-in-dbt-cloud-and-bigquery-15min/getting-started?page=3)

Step-3: Establish connection between git and bigquery using [dbt-cloud-and-bigquery-for-developers](https://learn.getdbt.com/courses/dbt-cloud-and-bigquery-for-developers).

Step-4: Finish the process as detailed [here](https://docs.getdbt.com/guides/bigquery?step=1).

Just for the demonstration prupose, the resulting screenshots are stored in *images* directory.

## Summary of Project files:
### dbt_project.yml
You can set project-level configuration in this file.
In this file, you can metion the paths to different project modules including models, tests, etc.
You can also mention the project/folder level materializations.

### - Models
Models directory contains **marts** and **staging** subdirectories.

**staging**: contains the sources and staging models that form the initial stages of the data pipeline.

**marts**: contains models that perform advanced transformations/materializations.

yml files in this directory also contains generic tests (unique, not_null, accepted_values, relationships) and documentation.

### - Tests
Contains singular tests. That is, the tests speicific to the business purposes.

### - Macros
Stores the user-defined macros to be used like dbt-provided macros such as src, ref.

### - dbt_packages
contains the packages which we included in project, that is, in packages.yml. We need not explicitly create this directory.

### - target
contains the compiled and run code of our project. We need not explicitly create this directory.

### - Snapshots
Snapshots to help preserve the desired state of the database.

Rest of the directories are kept for the purpose of future project extension while preserving the modularity.

### - Analyses
Stores the advanced analyses that result in the higher-level materializations.

### - Seeds
Stores seeds for the sake of reproducability.


## Materializations:
### - Tables
  Materializes the model as a table in the destination warehouse.
### - Views
  Materializes the model as a view in the destination warehouse.
### - Ephemeral
  - No specific materializations like table or view. Just a CTE is created which can be utilized in other models.
  - Consider it as a just reusable code snippet. Whenever this model is referred, the corresponding code snippet gets copied over.
  
### - Incremental
  Appends the table with the newly available records only.
### - Snapshot
  - Based on a given criteria, any changes in the selected data would be appended as new rows to the table so that we do not loss the old records. 
  That is, change history is preserved. 
  - This is never fully refreshed unlike incremental model.
  - This is stored separately from the typical destination tables and views. As this is a raw data, we never want to lose it.
