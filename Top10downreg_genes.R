# Load necessary library
library(dplyr)

# Define input and output paths
input_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/Downregulated_DEG_results.csv"
output_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/Top10_Downregulated_DEG_results.csv"

# Read the CSV file
deg_results <- read.csv(input_path, header = TRUE)

# Ensure column names are correctly formatted
colnames(deg_results) <- trimws(colnames(deg_results))

# Convert padj to numeric (if necessary)
deg_results$padj <- as.numeric(deg_results$padj)

# Filter for downregulated genes (log2FoldChange < -2 and padj < 0.05), then sort in ascending order
top10_downregulated <- deg_results %>%
  filter(log2FoldChange < -2, padj < 0.05) %>% 
  arrange(log2FoldChange) %>%  # Sorting from most negative (most downregulated) to least
  head(10)  # Select top 10

# Print the top 10 downregulated genes
print(top10_downregulated)

# Save the results to the specified output path
write.csv(top10_downregulated, output_path, row.names = FALSE)

# Message confirming file save
cat("Top 10 downregulated genes saved to:", output_path, "\n")
