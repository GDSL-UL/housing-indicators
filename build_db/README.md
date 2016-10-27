# `build_db`

This folder contains all the code required to replicate the database of
housing prices from the original data sourced from Land Registry.

## Original dataset

**ENTER LINKS FOR SOURCE FILES HERE**

## Building the database

To recreate the database, step by step, the following scripts need to be run
in the following order:

* `pull_data.R`: this will generate `LR_Transactions_GEOREF.csv`
* `build_sqlite3_db.sql`

