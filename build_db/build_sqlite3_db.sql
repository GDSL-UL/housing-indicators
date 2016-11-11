-- SQLite 3 Script; Creation of Housing Indicators Database (HSIN.db)
-- To run, use .read build_sqlite3_db.sql

-- Alekos Alexiou
-- Dani Arribas-Bel

-- Create Housing Indicators Database, HSIN
sqlite3 HSIN

-- Import csv file with LRPP transactions
.mode csv
.import /home/alekos/Documents/Land_Registry/LR_Transactions_GEOREF.csv LRPP_PCD_RAW

-- Update null values in columns
UPDATE LRPP_PCD_RAW SET Postcode=NULL WHERE Postcode='NA';
UPDATE LRPP_PCD_RAW SET Price=NULL WHERE Price='NA';
UPDATE LRPP_PCD_RAW SET Year=NULL WHERE Year='NA';
UPDATE LRPP_PCD_RAW SET Month=NULL WHERE Month='NA';
UPDATE LRPP_PCD_RAW SET Day=NULL WHERE Day='NA';
UPDATE LRPP_PCD_RAW SET usertype=NULL WHERE usertype='NA';
UPDATE LRPP_PCD_RAW SET oseast1m=NULL WHERE oseast1m='NA';
UPDATE LRPP_PCD_RAW SET osnrth1m=NULL WHERE osnrth1m='NA';
UPDATE LRPP_PCD_RAW SET osgrdind=NULL WHERE osgrdind='NA';
UPDATE LRPP_PCD_RAW SET lat=NULL WHERE lat='NA';
UPDATE LRPP_PCD_RAW SET long=NULL WHERE long='NA';
UPDATE LRPP_PCD_RAW SET imd=NULL WHERE imd='NA';

-- Create new table with correct data types
CREATE TABLE LRPP_PCD(
  "ID" INT PRIMARY KEY NOT NULL, 
  "Transaction_unique_identifier" TEXT  NOT NULL,
  "Postcode" TEXT,
  "Price" INT NOT NULL,
  "Date_of_Transfer" TEXT,
  "Year" INT,
  "Month" INT,
  "Day" INT,
  "Property_Type" CHAR(1),
  "Old_New" CHAR(1),
  "Duration" CHAR(1),
  "PAON" TEXT,
  "SAON" TEXT,
  "LRPP_Street" TEXT,
  "LRPP_Locality" TEXT,
  "LRPP_Town_City" TEXT,
  "LRPP_District" TEXT,
  "LRPP_County" TEXT,
  "PPD_Category_Type" TEXT,
  "pcd2" TEXT,
  "pcds" TEXT,
  "dointr" TEXT,
  "doterm" TEXT,
  "usertype" INT,
  "oseast1m" NUMERIC,
  "osnrth1m" NUMERIC,
  "osgrdind" INT,
  "oa11" TEXT,
  "cty" TEXT,
  "laua" TEXT,
  "ward" TEXT,
  "hlthau" TEXT,
  "hro" TEXT,
  "ctry" TEXT,
  "gor" TEXT,
  "pcon" TEXT,
  "eer" TEXT,
  "teclec" TEXT,
  "ttwa" TEXT,
  "pct" TEXT,
  "nuts" TEXT,
  "park" TEXT,
  "lsoa11" TEXT,
  "msoa11" TEXT,
  "wz11" TEXT,
  "ccg" TEXT,
  "bua11" TEXT,
  "buasd11" TEXT,
  "ru11ind" TEXT,
  "oac11" TEXT,
  "lat" REAL,
  "long" REAL,
  "lep1" TEXT,
  "lep2" TEXT,
  "pfa" TEXT,
  "imd" INT
);

-- Copy raw data into new table with corrected data types
INSERT INTO LRPP_PCD SELECT * FROM LRPP_PCD_RAW;

-- Create Indexes
CREATE UNIQUE INDEX Trans_ID ON LRPP_PCD (Transaction_unique_identifier);
CREATE INDEX Price_ID ON LRPP_PCD (Price);
CREATE INDEX Date_Y ON LRPP_PCD (Year);
CREATE INDEX Date_M ON LRPP_PCD (Month);
CREATE INDEX Property_ID ON LRPP_PCD (Property_Type);
CREATE INDEX PAON_ID ON LRPP_PCD (PAON);
CREATE INDEX OA_Code ON LRPP_PCD (oa11);
CREATE INDEX LSOA_Code ON LRPP_PCD (lsoa11);
CREATE INDEX X_BNG ON LRPP_PCD (oseast1m);
CREATE INDEX Y_BNG ON LRPP_PCD (osnrth1m);

-- Delete old table
DROP TABLE LRPP_PCD_RAW

-- Test
SELECT * FROM LRPP_PCD LIMIT 5;

-- Cleans database, may take time
VACUUM; 
