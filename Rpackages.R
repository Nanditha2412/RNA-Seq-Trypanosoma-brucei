# Load necessary library
library(DESeq2)

# Read in your feature counts data from a CSV file.
# Assumes the CSV file has gene IDs in the first column.
feature_counts <- read.csv("C:/Users/WIN 10/OneDrive/Documents/Featurecounts/feature_counts.csv", 
                           row.names = 1)

# Convert the data frame to a matrix (if not already)
counts_matrix <- as.matrix(feature_counts)

# Create a dummy colData data frame.
# If you don't have experimental groups, you can assign all samples to one condition.
colData <- data.frame(condition = rep("control", ncol(counts_matrix)))
rownames(colData) <- colnames(counts_matrix)

# Construct the DESeq2 dataset.
dds <- DESeqDataSetFromMatrix(countData = counts_matrix,
                              colData = colData,
                              design = ~ condition)

# Estimate size factors to normalize for sequencing depth differences.
dds <- estimateSizeFactors(dds)

# Extract normalized counts.
normalized_counts <- counts(dds, normalized = TRUE)

# Write the normalized counts to a CSV file.
output_file <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/normalized_feature_counts.csv"
write.csv(normalized_counts, file = output_file, row.names = TRUE)

cat("Normalization complete. Normalized counts have been written to", output_file, "\n")
