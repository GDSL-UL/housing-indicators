# `build_db`

This folder contains all the code required to replicate the database of
housing prices from the original data sourced from Land Registry.

## Original datasets

#### Land Registry Price Paid data:
http://prod1.publicdata.landregistry.gov.uk.s3-website-eu-west-1.amazonaws.com/pp-complete.csv
#### National Statistics Postcode Lookup (August 2016) Version 2
http://ons.maps.arcgis.com/home/item.html?id=ad13ce429d9644b88fc1e85af2e6ed8a
<br>
<br>
#### Metadata available at:
Price Paid Data: https://www.gov.uk/guidance/about-the-price-paid-data#explanations-of-column-headers-in-the-ppd <br>
NSPL: https://data.gov.uk/dataset/f68942ff-7fa4-4767-8dc7-5bb4fa52249e/resource/4b6b1c57-9eea-45e8-bc16-bed91f35e459


## Building the database

To recreate the database, step by step, the following scripts need to be run
in the following order:

* `pull_data.R`: this will generate `LR_Transactions_GEOREF.csv`
* `build_sqlite3_db.sql`: This will generate the SQLite Database `HSIN.db`

