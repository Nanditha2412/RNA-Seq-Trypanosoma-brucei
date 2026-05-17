# RNA-Seq-Trypanosoma-brucei
RNA-Seq Transcriptomic Analysis of Trypanosoma brucei
A complete end-to-end RNA-Seq differential expression analysis pipeline built in R, applied to Trypanosoma brucei — the parasite responsible for African Sleeping Sickness.
---
Project Overview
This project performs transcriptomic profiling of Trypanosoma brucei using publicly available RNA-Seq data (GEO accession samples: SRR13501253–SRR13501260). The goal is to identify differentially expressed genes (DEGs) and understand their biological relevance through functional enrichment and gene annotation.
---
Pipeline Workflow
```
Raw FeatureCounts Data
        ↓
1. Data Conversion       (Rcode.R)
        ↓
2. Metadata Preparation  (meta.R)
        ↓
3. Normalisation         (normalization.R)
        ↓
4. DEG Analysis          (DEG.R / newdeg.R)
        ↓
5. PCA \& Clustering      (pca.R)
        ↓
6. Filter Up/Downregulated DEGs  (filtered\_upregulateddeg.R / filtered\_downregulateddeg.R)
        ↓
7. Top Downregulated Genes       (Top10downreg\_genes.R)
        ↓
8. Gene Annotation       (gene\_annotation.R)
        ↓
9. GO Enrichment Analysis        (GO.R)
```
---
Scripts Description
Script	Purpose
`Rcode.R`	Converts raw `.tabular` FeatureCounts output files to `.csv` format
`meta.R`	Reads and converts sample metadata from Excel to CSV
`normalization.R`	Merges count data from 8 samples and performs DESeq2 normalisation
`Rpackages.R`	Installs and loads all required R/Bioconductor packages
`degs.R`	Installs full suite of DEG analysis packages (DESeq2, edgeR, limma, clusterProfiler)
`DEG.R` / `newdeg.R`	Runs DESeq2 differential expression analysis; generates MA plot, Volcano plot, and Heatmap of top 50 DEGs
`pca.R`	Performs PCA, hierarchical clustering, K-means, and t-SNE on normalised counts
`filtered\_upregulateddeg.R`	Filters significantly upregulated DEGs (log2FC > 2, padj < 0.05)
`filtered\_downregulateddeg.R`	Filters significantly downregulated DEGs (log2FC < -2, padj < 0.05)
`Top10downreg\_genes.R`	Extracts top 10 most downregulated genes sorted by fold change
`gene\_annotation.R`	Annotates DEGs using Ensembl BioMart for Trypanosoma brucei
`GO.R`	Performs Gene Ontology (GO) enrichment analysis using gprofiler2
---
Tools & Packages Used
R (v4.x)
DESeq2 — Differential expression analysis
edgeR, limma — Alternative DEG methods
ggplot2 — Volcano plots, PCA plots
pheatmap — Heatmaps
clusterProfiler — GO and pathway enrichment
gprofiler2 — GO enrichment for non-model organisms
biomaRt — Gene annotation via Ensembl
Rtsne — t-SNE dimensionality reduction
dplyr — Data filtering and manipulation
---
Key Results
Identified differentially expressed genes in T. brucei with padj < 0.05 and |log2FC| > 2
Filtered upregulated and downregulated gene sets separately
Extracted top 10 most downregulated genes as priority candidates
Annotated DEGs with gene descriptions and GO terms via Ensembl Protists
Performed GO enrichment analysis to identify enriched biological processes and pathways
---
Data Source
Organism: Trypanosoma brucei
Data: Publicly available RNA-Seq data from NCBI GEO
Samples: SRR13501253, SRR13501254, SRR13501255, SRR13501256, SRR13501257, SRR13501258, SRR13501259, SRR13501260
Pre-processing: Read alignment and feature counting performed using Galaxy platform
---
How to Run
Clone this repository
Install required packages by running `Rpackages.R` and `degs.R`
Update file paths in each script to match your local directory
Run scripts in the order shown in the Pipeline Workflow above
---
Author
S. Nanditha  
M.Sc. Bioinformatics, Pondicherry University  
LinkedIn
