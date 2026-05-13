# Load necessary library
library(DESeq2)

# Define the list of CSV file paths
files <- c(
  "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/SRR13501253.csv",
  "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/SRR13501254.csv",
  "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/SRR13501255.csv",
  "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/SRR13501256.csv",
  "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/SRR13501257.csv",
  "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/SRR13501258.csv",
  "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/SRR13501259.csv",
  "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/SRR13501260.csv"
)

# Read each CSV and extract counts.
# Here we assume each CSV has a header with gene IDs in the first column and counts in the second column.
data_list <- lapply(files, function(file) {
  df <- read.csv(file, header = TRUE)
  rownames(df) <- df[,1]                # Set row names as gene IDs
  counts <- df[,2, drop = FALSE]        # Extract counts (second column)
  colnames(counts) <- sub(".csv", "", basename(file))  # Rename column based on file name
  return(counts)
})

# Combine all counts by column. Assumes all files share the same genes in the same order.
combined_counts <- do.call(cbind, data_list)

# Create a dummy colData data frame.
# Since all samples are the same (e.g., "control"), we use design = ~1.
colData <- data.frame(condition = rep("control", ncol(combined_counts)))
rownames(colData) <- colnames(combined_counts)

# Construct the DESeq2 dataset using design = ~1 because there's no group variation.
dds <- DESeqDataSetFromMatrix(countData = combined_counts,
                              colData = colData,
                              design = ~ 1)

# Estimate size factors to normalize for sequencing depth differences.
dds <- estimateSizeFactors(dds)

# Extract normalized counts from the DESeq2 object.
normalized_counts <- counts(dds, normalized = TRUE)

# Define the output file path for the normalized counts.
output_file <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/normalized_combined_counts.csv"

# Write the normalized counts to a CSV file.
write.csv(normalized_counts, file = output_file, row.names = TRUE)

cat("Normalization complete. Normalized counts have been written to", output_file, "\n")
