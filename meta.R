# Read the Excel file
metadata <- read_excel("C:/Users/WIN 10/OneDrive/Documents/Featurecounts/Meta.xlsx")

# Save as CSV
write.csv(metadata, "C:/Users/WIN 10/OneDrive/Documents/Featurecounts/metadata.csv", row.names = FALSE)

# Verify
print("CSV file saved successfully!")
