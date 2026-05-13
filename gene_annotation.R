library(biomaRt)

# Connect to Ensembl Protists
mart <- useMart("protists_mart", dataset = "tbrucei_eg_gene", host = "https://protists.ensembl.org")

# List available attributes
attributes <- listAttributes(mart)
print(attributes)
# Load required packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("biomaRt")

library(biomaRt)
library(dplyr)

# Define file paths
input_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/DEG_results.csv"
output_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/DEG_annotated.csv"

# Read the DEG results file
deg_data <- read.csv(input_path, header = TRUE)

# Ensure 'gene_id' column exists
if (!"gene_id" %in% colnames(deg_data)) {
  stop("Error: 'gene_id' column not found in DEG file. Check the column names.")
}

# Connect to the Ensembl database for Trypanosoma brucei
mart <- useMart("protists_mart", dataset = "tbrucei_eg_gene", host = "https://protists.ensembl.org")

# Extract gene IDs
gene_ids <- unique(deg_data$gene_id)  # Remove duplicates

# Check if gene IDs are valid
if (length(gene_ids) == 0) {
  stop("Error: No valid gene IDs found in the input file.")
}

# Retrieve annotations (use correct attributes from listAttributes)
annotations <- getBM(
  attributes = c("ensembl_gene_id", "description", "go_id", "name_1006"),  # Update based on valid attributes
  filters = "ensembl_gene_id",
  values = gene_ids,
  mart = mart
)

# Check if annotations were retrieved
if (nrow(annotations) == 0) {
  stop("Error: No annotations retrieved. Check if the gene IDs match Ensembl IDs.")
}

# Merge DEG data with annotations
deg_annotated <- merge(deg_data, annotations, by.x = "gene_id", by.y = "ensembl_gene_id", all.x = TRUE)

# Save the annotated file
write.csv(deg_annotated, output_path, row.names = FALSE)

print("Gene annotation completed and saved successfully!")
