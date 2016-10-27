-- SQLite 3 Script; Creation of Housing Indicators Database (hsin.db)

-- Alekos Alexiou
-- Dani Arribas-Bel


-- Import data
sqlite3 hsin
.mode csv
-- Repalce by path to csv
.import LR_Transactions_GEOREF.csv lr_pcd

-- Open database HSIN (table name LR_PCD)
sqlite3 hsin

-- Convert prices into numeric

-- Convert date strings into timestamps

-- Create indices
CREATE UNIQUE INDEX Trans_ID ON LR_PCD (Transaction_unique_identifier);
CREATE INDEX OA_Code ON LR_PCD (oa11);
CREATE INDEX LSOA_Code ON LR_PCD (lsoa11);
CREATE INDEX LA_Code ON LR_PCD (laua);
CREATE INDEX Price_ID ON LR_PCD (Price);
CREATE INDEX Date_ID ON LR_PCD (Date_of_Transfer);
CREATE INDEX Property_ID ON LR_PCD (Property_Type);
CREATE INDEX PAON_ID ON LR_PCD (PAON);
CREATE INDEX X_BNG ON LR_PCD (oseast1m);
CREATE INDEX Y_BNG ON LR_PCD (osnrth1m);

-- Test indices
$ .indices lr_pcd

-- Possible future actions (for reference only)
-- To delete index:
-- $ DROP INDEX index;
-- Remove rubbish (rec. @Kostas); rewrites database:
-- $ VACUUM table_name; 
