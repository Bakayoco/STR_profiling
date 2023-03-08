library(purrr)
library(dplyr)
library(readr)

#ab <- read_delim("E:/Bách/Studying/Thesis/VCF/Kinh.Vietnamese/KHV_AF.frq")
# Read in the file
df <- read_delim("E:/Bách/Studying/Thesis/VCF/locus/AF_KHV_25DP.tab")

# Extract the column containing the allele frequency information
allele_freq_col <- df$afreq

# Split the allele frequency information into separate frequency values
allele_freqs <- strsplit(allele_freq_col, ",")
allele_freqs <- lapply(allele_freqs, function(x) {
  freqs <- strsplit(x, ":")
  freqs <- sapply(freqs, function(y) as.numeric(y[2]))
  if (length(freqs) == 1) {
    freqs <- freqs[1]
  }
  freqs
})

# Calculate the sum of the squares of the allele frequencies for each row
pic <- sapply(allele_freqs, function(x) 1-sum(x^2)-sum(x^2)^2+sum(x^4))
#e_hete <- sapply(allele_freqs, function(x) 1-sum(x^2))
# Add the PIC column to the data frame
#df$e_hete <- e_hete
df$PIC <- pic
# Remove 5th column
df <- df[, -4]
# Write the resulting data frame to a file
write_tsv(df, "E:/Bách/Studying/Thesis/VCF/locus/PIC_25DP.tsv", row.names = FALSE, sep = "\t")
