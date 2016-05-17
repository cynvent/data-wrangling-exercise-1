#Set working directory
setwd("~/Desktop/Data Wrangling Exercise 1")

#Upload csv into RStudio
refine_original <- read.csv("~/Desktop/Data Wrangling Exercise 1/refine_original.csv")


#1 - clean up company name - is there a more elegant way to do this?
refine_original$company[refine_original$company == "unilver"] <- "unilever"
refine_original$company[refine_original$company == "Unilever"] <- "unilever"
refine_original$company[refine_original$company == "unilever"] <- "unilever"
refine_original$company[refine_original$company == "unilver"] <- "unilever"
refine_original$company[refine_original$company == "ak zo"] <- "akzo"
refine_original$company[refine_original$company == "akz0"] <- "akzo"
refine_original$company[refine_original$company == "Akzo"] <- "akzo"
refine_original$company[refine_original$company == "Akz0"] <- "akzo"
refine_original$company[refine_original$company == "AKZO"] <- "akzo"
refine_original$company[refine_original$company == "akzo"] <- "akzo"
refine_original$company[refine_original$company == "van houten"] <- "van houten"
refine_original$company[refine_original$company == "Van Houten"] <- "van houten"
refine_original$company[refine_original$company == "van Houten"] <- "van houten"
refine_original$company[refine_original$company == "van Houten"] <- "van houten"
refine_original$company[refine_original$company == "Phillips"] <- "philips"
refine_original$company[refine_original$company == "phillips"] <- "philips"
refine_original$company[refine_original$company == "philips"] <- "philips"
refine_original$company[refine_original$company == "phillipS"] <- "philips"
refine_original$company[refine_original$company == "phlips"] <- "philips"
refine_original$company[refine_original$company == "fillips"] <- "philips"
refine_original$company[refine_original$company == "phillps"] <- "philips"
refine_original$company[refine_original$company == "phllips"] <- "philips"


#2 - separate the Product.code...number into separate columns
refine_original <- refine_original %>% separate(Product.code...number, c("product_code", "product_number"), sep = "-", remove = FALSE)


#3 - add product catgory variable
refine_original$product_category <- "Smartphone"
refine_original$product_category[refine_original$product_code == "v"] <- "TV"
refine_original$product_category[refine_original$product_code == "x"] <- "Laptop"
refine_original$product_category[refine_original$product_code == "q"] <- "Tablet"

#4 - Create a new column full_address that concatenates the three address fields (address, city, country), separated by commas.
refine_original <- refine_original %>% unite(full_address, address, city, country, sep = ",")

#5 - Create dummy variables for company and product category. Replace NA with "0".

refine_original$company_philips <- 0

refine_original$company_philips[refine_original$company == "philips"] <- 1
refine_original$company_akzo[refine_original$company == "akzo"] <- 1
refine_original$company_van_houten[refine_original$company == "van houten"] <- 1
refine_original$company_unilever[refine_original$company == "unilever"] <- 1

refine_original$company_philips[is.na(refine_original$company_philips)] <- 0
refine_original$company_akzo[is.na(refine_original$company_akzo)] <- 0
refine_original$company_van_houten[is.na(refine_original$company_van_houten)] <- 0
refine_original$company_unilever[is.na(refine_original$company_unilever)] <- 0

refine_original$product_smartphone[refine_original$product_category == "Smartphone"] <- 1
refine_original$product_tv[refine_original$product_category == "TV"] <- 1
refine_original$product_laptop[refine_original$product_category == "Laptop"] <- 1
refine_original$product_tablet[refine_original$product_category == "Tablet"] <- 1

refine_original$product_smartphone[is.na(refine_original$product_smartphone)] <- 0
refine_original$product_tv[is.na(refine_original$product_tv)] <- 0
refine_original$product_laptop[is.na(refine_original$product_laptop)] <- 0
refine_original$product_tablet[is.na(refine_original$product_tablet)] <- 0



#Write final csv
write.csv(refine_original, file = "refine_clean.csv", row.names=FALSE)
