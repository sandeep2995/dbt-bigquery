# dbt-bigquery
Integrates dbt (data build tool) with the gcp bigquery

Step-1: Setup dbt cloud as noted at [set-up-dbt-cloud](https://learn.getdbt.com/learn/course/dbt-fundamentals/set-up-dbt-cloud-55min/getting-started?page=2) 

Step-2: Connect git repo to the dbt using [join-a-project-in-dbt-cloud-and-bigquery](https://learn.getdbt.com/learn/course/dbt-cloud-and-bigquery-for-developers/join-a-project-in-dbt-cloud-and-bigquery-15min/getting-started?page=3)

Step-3: Establish connection between git and bigquery using [dbt-cloud-and-bigquery-for-developers](https://learn.getdbt.com/courses/dbt-cloud-and-bigquery-for-developers).

Step-4: Finish the process as detailed [here](https://docs.getdbt.com/guides/bigquery?step=1).

## Summary of Project files:
### dbt_project.yml
You can set project-level configuration in this file.
In this file, you can metion the paths to different project modules including models, tests, etc.
You can also mention the project/folder level materializations.

### Models
Models directory contains **marts** and **staging** subdirectories.

**staging**: contains the sources and staging models that form the initial stages of the data pipeline.

**marts**: contains models that perform advanced transformations/materializations.

yml files in this directory also contains generic tests (unique, not_null, accepted_values, relationships) and documentation.

### Tests
Contains singular tests. That is, the tests speicific to the business purposes.

Rest of the directories are kept for the purpose of future project extension while preserving the modularity.

### Analyses
Stores the advanced analyses that result in the higher-level materializations.

### Macros
Stores the user-defined macros to be used like dbt-provided macros such as src, ref.

### Seeds
Stores seeds for the sake of reproducability.

### Snapshots
Snapshots to help preserve the desired state of the database.
