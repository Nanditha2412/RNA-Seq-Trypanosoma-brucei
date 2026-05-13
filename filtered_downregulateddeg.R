# Load necessary library
library(dplyr)

# Define input and output paths
input_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/DEG_results.csv"
output_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/Downregulated_DEG_results.csv"

# Read the CSV file
deg_results <- read.csv(input_path, header = TRUE)

# Ensure column names are correctly formatted
colnames(deg_results) <- trimws(colnames(deg_results))

# Convert padj to numeric (if necessary)
deg_results$padj <- as.numeric(deg_results$padj)

# Filter for downregulated genes (log2FoldChange < -2 and padj < 0.05), then sort in ascending order
downregulated_deg <- deg_results %>%
  filter(log2FoldChange < -2, padj < 0.05) %>%
  arrange(log2FoldChange)  # Sorting in ascending order (most downregulated first)

# Print the filtered and sorted results
print(downregulated_deg)

# Save the results to the specified output path
write.csv(downregulated_deg, output_path, row.names = FALSE)

# Message confirming file save
cat("Downregulated genes saved to:", output_path, "\n")
