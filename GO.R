deg_file <- read.csv("C:\\Users\\WIN 10\\OneDrive\\Documents\\Featurecounts\\significant_genes.csv")

# Display first few rows
head(deg_file)

# Check column names
colnames(deg_file)

deg_list <- as.character(deg_file$GeneID)  # Change 'GeneID' to the correct column name

# Verify list is not empty
length(deg_list)  # Should return a positive number
head(deg_list)  # Should show actual gene IDs


install.packages("gprofiler2")  # Install if not already installed
library(gprofiler2)

# Load DEG file
deg_file <- read.csv("C:\\Users\\WIN 10\\OneDrive\\Documents\\Featurecounts\\significant_genes.csv")
deg_list <- as.character(deg_file$GeneID)  # Extract gene IDs

# Run GO Enrichment for Trypanosoma brucei
go_results <- gost(
  query = deg_list,
  organism = "tbrucei",
  significant = TRUE
)

# View and save results
head(go_results$result)
write.csv(go_results$result, "GO_enrichment_results.csv", row.names = FALSE)

# Plot results
plot(go_results)
