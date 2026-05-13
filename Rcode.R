# Define the folder path containing the .tabular files
folder_path <- "C:/Users/WIN 10/OneDrive/Documents/Featurecounts"

# List all files with a .tabular extension (full names)
tabular_files <- list.files(folder_path, pattern = "\\.tabular$", full.names = TRUE)

# Loop through each file and convert to CSV
for (file in tabular_files) {
  # Read the tabular file (assuming tab-separated values)
  df <- read.table(file, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
  
  # Create output file name by replacing .tabular with .csv
  output_file <- sub("\\.tabular$", ".csv", file)
  
  # Write the data frame to a CSV file
  write.csv(df, file = output_file, row.names = FALSE)
  
  # Print a confirmation message
  cat("Converted", file, "to", output_file, "\n")
}
