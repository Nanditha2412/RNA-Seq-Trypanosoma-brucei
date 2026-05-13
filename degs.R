# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Install Bioconductor package manager (if not installed)
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Install RNA-Seq & DEG Analysis Packages
BiocManager::install(c("DESeq2", "edgeR", "limma", "apeglm", "tximport"), force = TRUE)

# Install Clustering & Visualization Packages
install.packages(c("ggplot2", "pheatmap", "Rtsne", "umap"))

# Install Functional Enrichment Analysis Packages
BiocManager::install(c("clusterProfiler", "org.Hs.eg.db", "org.Mm.eg.db", "GOstats", "ReactomePA"), force = TRUE)

# Load Installed Libraries
library(DESeq2)         # Differential Expression Analysis
library(edgeR)          # Alternative DEG Analysis
library(limma)          # For low-count datasets
library(apeglm)         # Shrinkage for DESeq2
library(tximport)       # Import transcript-level quantification
library(ggplot2)        # Data visualization
library(pheatmap)       # Heatmaps
library(Rtsne)          # t-SNE clustering
library(umap)           # UMAP clustering
library(clusterProfiler) # Gene Ontology (GO) & Pathway Enrichment
library(ReactomePA)     # Reactome Pathway Analysis
