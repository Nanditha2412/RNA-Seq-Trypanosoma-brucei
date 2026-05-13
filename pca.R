# Install & Load Required Packages
install.packages(c("ggplot2", "pheatmap", "Rtsne"))
library(ggplot2)
library(pheatmap)
library(Rtsne)

# Define Paths
input_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/normalized_combined_counts.csv"
output_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/"

# 🔹 STEP 1: Load Normalized Count Data
countData <- read.csv(input_path, row.names = 1)

# 🔹 STEP 2: Log2 Transform Data
log_counts <- log2(countData + 1)  # Avoid log(0) issues

# 🔹 STEP 3: Remove Zero-Variance Genes
log_counts_filtered <- log_counts[apply(log_counts, 1, var) > 0, ]

# 🔹 STEP 4: PCA Analysis
pcaData <- prcomp(t(log_counts_filtered), scale. = TRUE)
pca_df <- data.frame(PC1 = pcaData$x[,1], PC2 = pcaData$x[,2], Sample = colnames(countData))

# Save PCA Plot
pca_plot <- ggplot(pca_df, aes(x=PC1, y=PC2, label=Sample)) +
  geom_point(size=4, color="blue") +
  geom_text(vjust=2) +
  ggtitle("PCA Plot of Samples") +
  theme_minimal()

ggsave(filename = paste0(output_path, "PCA_plot.png"), plot = pca_plot, width = 6, height = 4, dpi = 300)

# 🔹 STEP 5: Hierarchical Clustering Heatmap
sampleDists <- dist(t(log_counts_filtered))  # Compute sample distances
sampleDistMatrix <- as.matrix(sampleDists)

# Save Heatmap
png(filename = paste0(output_path, "Sample_Clustering_Heatmap.png"), width = 800, height = 800)
pheatmap(sampleDistMatrix, clustering_distance_rows=sampleDists, clustering_distance_cols=sampleDists, main="Sample Clustering Heatmap")
dev.off()

# 🔹 STEP 6: K-Means Clustering
set.seed(123)
kmeans_result <- kmeans(t(log_counts_filtered), centers=2)  # Adjust 'centers' based on expected clusters
write.csv(kmeans_result$cluster, paste0(output_path, "KMeans_Clusters.csv"))

# 🔹 STEP 7: t-SNE Clustering
set.seed(123)
tsne_out <- Rtsne(t(log_counts_filtered), perplexity = 2)  # Adjust perplexity based on sample size
tsne_df <- data.frame(X = tsne_out$Y[,1], Y = tsne_out$Y[,2], Sample = colnames(countData))

# Save t-SNE Plot
tsne_plot <- ggplot(tsne_df, aes(x=X, y=Y, label=Sample)) +
  geom_point(size=4, color="red") +
  geom_text(vjust=2) +
  ggtitle("t-SNE Clustering of Samples") +
  theme_minimal()

ggsave(filename = paste0(output_path, "tSNE_plot.png"), plot = tsne_plot, width = 6, height = 4, dpi = 300)

# Completion Message
print("All clustering results saved successfully!")

