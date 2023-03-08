# Read in the .frq file
library(readr)
data <- read_delim("E:/Bách/Studying/Thesis/VCF/locus/downstream/AF_KHV_25DP.sort.tab", col_types = "ccc")

allele_freq_col <- data$afreq

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

maf <- sapply(allele_freqs, function(x) {
  if (length(x) == 1) {
    return(x)
  } else {
    sorted_freqs <- sort(x)
    return(min(sorted_freqs))
  }
})

# Filter out the rows where the MAF is less than 1%
filtered_data <- data[(maf >= 0.01 & maf < 1), ]

# Write the filtered data frame to a new file
write_tsv(filtered_data, "E:/Bách/Studying/Thesis/VCF/locus/downstream/MAF.tsv")


