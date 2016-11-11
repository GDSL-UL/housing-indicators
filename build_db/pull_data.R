# Code to download all csv and merge them into `LR_Transactions_GEOREF.csv`
# Land Registry Price Paid Data Input

# Download files into a [Data] folder, or run line below
dir.create("Data")

# Files that must be manually downloaded into 'Data':
# 'NSPL_AUG_2016_UK.csv', available at: http://ons.maps.arcgis.com/home/item.html?id=ad13ce429d9644b88fc1e85af2e6ed8a

# Download LRPP data
data_url <- "http://prod1.publicdata.landregistry.gov.uk.s3-website-eu-west-1.amazonaws.com/pp-complete.csv"
download.file(data_url, "Data/pp-complete.csv")
LRPP_raw <- read.csv("Data/pp-complete.csv")

# Read variable descriptions 
# Taken from https://www.gov.uk/guidance/about-the-price-paid-data#explanations-of-column-headers-in-the-ppd
# Accessed October 10th 2016

LR_Metadata <- data.frame(Var=c("Transaction_unique_identifier", "Price", "Date_of_Transfer",
                            "Postcode", "Property_Type", "Old_New", "Duration", "PAON", "SAON", 
                            "LRPP_Street", "LRPP_Locality", "LRPP_Town_City", "LRPP_District", 
                            "LRPP_County", "PPD_Category_Type", "Record_Status_monthly_file_only"),
                          Description = c("A reference number which is generated automatically recording each published sale. The number is unique and will change each time a sale is recorded.",
                            "Sale price stated on the transfer deed.", "Date when the sale was completed, as stated on the transfer deed.",
                            "This is the postcode used at the time of the original transaction. Note that postcodes can be reallocated and these changes are not reflected in the Price Paid Dataset.",
                            "D = Detached, S = Semi-Detached, T = Terraced, F = Flats/Maisonettes, O = Other",
                            "Indicates the age of the property and applies to all price paid transactions, residential and non-residential. Y = a newly built property, N = an established residential building.",
                            "Relates to the tenure: F = Freehold, L= Leasehold etc. Note that Land Registry does not record leases of 7 years or less in the Price Paid Dataset.",
                            "Primary Addressable Object Name. If there is a sub-building for example the building is divided into flats, see Secondary Addressable Object Name (SAON).",
                            "Secondary Addressable Object Name. If there is a sub-building, for example the building is divided into flats, there will be a SAON.", "", "", "", "", "",
                            "Indicates the type of Price Paid transaction. A = Standard Price Paid entry, includes single residential property sold for full market value. B = Additional Price Paid entry including transfers under a power of sale/repossessions, buy-to-lets (where they can be identified by a Mortgage) and transfers to non-private individuals. Note that category B does not separately identify the transaction types stated. Land Registry has been collecting information on Category A transactions from January 1995. Category B transactions were identified from October 2013.",
                            "Indicates additions, changes and deletions to the records.(see guide below). A = Addition C = Change D = Delete. Note that where a transaction changes category type due to misallocation (as above) it will be deleted from the original category type and added to the correct category with a new transaction unique identifier."
                            )
                          )

# Get column names from LR_Metadata
colnames(LRPP_raw) <- LR_Metadata$Var

# Postcode lookup 
# available at: http://ons.maps.arcgis.com/home/item.html?id=ad13ce429d9644b88fc1e85af2e6ed8a
# Metadata available at:
# https://data.gov.uk/dataset/f68942ff-7fa4-4767-8dc7-5bb4fa52249e/resource/4b6b1c57-9eea-45e8-bc16-bed91f35e459
# Please insert manually into [Data] folder; it cannot be downloaded automatically 
postcode_lkup <- read.csv("Data/NSPL_AUG_2016_UK.csv")

# Delete postcode spaces
postcode_lkup$pcd <- gsub(pattern = " ", replacement = "", postcode_lkup$pcd)
LRPP_raw$Postcode <- gsub(pattern = " ", replacement = "", LRPP_raw$Postcode)

# Join Tables for postcode, OA, LSOA and other ONS geographies 
LRPP_db_OA <- merge(LRPP_raw, postcode_lkup, by.x = "Postcode", by.y = "pcd", all.x = T)

# Remove 2016 records: 643,458, LRPP update: 28th October 2016 
LRPP_db_OA <- LRPP_db_OA[-grep("2016", LRPP_db_OA$Date_of_Transfer), ]

# Make numeric date columns for easier access
LRPP_db_OA$Year <- as.numeric(substring(LRPP_db_OA$Date_of_Transfer, 1, 4))
LRPP_db_OA$Month <- as.numeric(substring(LRPP_db_OA$Date_of_Transfer, 6, 7))
LRPP_db_OA$Day <- as.numeric(substring(LRPP_db_OA$Date_of_Transfer, 9, 10))

# Remove monthly records variable
LRPP_db_OA$Record_Status_monthly_file_only <- NULL 

# Rearrange columns
LRPP_db_OA <- LRPP_db_OA[, c(2, 1, 3:4, 53:55, 5:52)]

# Create csv file
write.csv(LRPP_db_OA, "LR_Transactions_GEOREF.csv")
