# Install & Load Required Packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install(c("DESeq2", "ggplot2", "pheatmap"))

library(DESeq2)
library(ggplot2)
library(pheatmap)

# 🔹 STEP 1: Define Input and Output Paths
count_file <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/normalized_combined_counts.csv"
pca_output_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/pca/PCA_plot.png"
output_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/"

# 🔹 STEP 2: Load Normalized Count Data
countData <- read.csv(count_file, row.names = 1)

# 🔹 STEP 3: Generate Artificial Metadata (If Missing)
sample_names <- colnames(countData)
conditions <- rep(c("Group1", "Group2"), length.out = length(sample_names))  # Modify as needed

colData <- data.frame(row.names = sample_names, condition = factor(conditions))

# 🔹 STEP 4: Create DESeq2 Object
dds <- DESeqDataSetFromMatrix(countData = round(countData), colData = colData, design = ~ condition)

# 🔹 STEP 5: Run Differential Expression Analysis
dds <- DESeq(dds)

# 🔹 STEP 6: Extract DEG Results
res <- results(dds, contrast = c("condition", "Group1", "Group2"))  # Adjust condition names if needed
res <- res[order(res$padj), ]  # Sort by adjusted p-value

# 🔹 STEP 7: Save DEG Results
write.csv(as.data.frame(res), paste0(output_path, "DEG_results.csv"))

# 🔹 STEP 8: Generate MA Plot
png(paste0(output_path, "MA_plot.png"), width = 800, height = 600)
plotMA(res, main = "MA Plot", ylim = c(-5, 5))
dev.off()

# 🔹 STEP 9: Volcano Plot
res_df <- as.data.frame(res)
res_df$significant <- res_df$padj < 0.05

volcano_plot <- ggplot(res_df, aes(x = log2FoldChange, y = -log10(padj), color = significant)) +
  geom_point() +
  scale_color_manual(values = c("black", "red")) +
  ggtitle("Volcano Plot of DEGs") +
  theme_minimal()

ggsave(paste0(output_path, "Volcano_Plot.png"), plot = volcano_plot, width = 6, height = 4, dpi = 300)

# 🔹 STEP 10: Heatmap of Top 50 DEGs
topGenes <- rownames(res)[1:50]  # Select top 50 genes
heatmapData <- assay(vst(dds))[topGenes, ]

png(paste0(output_path, "DEG_Heatmap.png"), width = 800, height = 800)
pheatmap(heatmapData, main = "Top 50 Differentially Expressed Genes")
dev.off()

# 🔹 Completion Message
print("DEG analysis completed! Results and plots saved.")
