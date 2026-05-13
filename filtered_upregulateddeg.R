# Load necessary library
library(dplyr)

# Define input and output paths
input_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/DEG_results.csv"
output_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/Filtered_Sorted_DEG_results.csv"

# Read the CSV file
deg_results <- read.csv(input_path, header = TRUE)

# Ensure column names are correctly formatted (remove leading/trailing spaces)
colnames(deg_results) <- trimws(colnames(deg_results))

# Filter for log2FoldChange > 2 and padj == 0.005, then sort in descending order
filtered_sorted_deg <- deg_results %>%
  filter(log2FoldChange > 2, padj< 0.05) %>%
  arrange(desc(log2FoldChange))

# Print the filtered and sorted results
print(filtered_sorted_deg)

# Save the results to the specified output path
write.csv(filtered_sorted_deg, output_path, row.names = FALSE)

# Message confirming file save
cat("Filtered and sorted results saved to:", output_path, "\n")
