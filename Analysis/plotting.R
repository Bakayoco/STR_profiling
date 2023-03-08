
library(purrr)
library(dplyr)
library(readr)
df <- read_delim("E:/Bách/Studying/Thesis/VCF/locus/downstream/PIC/high_PIC.GC.sort.tsv")
x <- df$meanDP

# Create density plot
dens <- density(x)
n.obs <- length(x)

# Multiply density values by number of observations
dens$y <- dens$y * n.obs

# Plot density using base R graphics
plot(dens, main = "", xlab="Mean coverage per samples", ylab="Number of samples",col="red",lwd = 2)
polygon(dens, col = "pink", border=NA)
# Generate some example data



# Create a data frame with columns for expected and observed heterozygosity
data <- data.frame(df$e_het,
                   df$o_het)

# Plot the relationship between expected and observed heterozygosity
plot(data$df.e_het, data$df.o_het, 
     xlab = "Expected Heterozygosity", ylab = "Observed Heterozygosity", 
     main = "Expected vs Observed Heterozygosity", 
     pch = 16, col = "blue")

# Add a diagonal line to show perfect agreement between expected and observed heterozygosity
abline(0, 1, col = "red")


# create example data
expected <- df$e_het
observed <- df$o_het
data <- data.frame(category = rep(c("Expected", "Observed"), each = length(expected)),
                   value = c(expected, observed))

# create violin plot
library(ggplot2)
ggplot(data, aes(x = category, y = value, fill = category)) +
  geom_violin()  +
  geom_boxplot(width = 0.1, fill = "white")+
  xlab("") +
  ylab("Heterozygosity") +
  ggtitle("") +
  theme_bw()


library(readr)
data <- read_delim("D:/So_tay.csv")
library(reshape2)

# Convert data to long format
data_long <- tidyr::gather(data, key = "Allele", value = "Frequency", -Locus)

# Calculate proportions
data_long$Frequency <- as.numeric(data_long$Frequency)
data_long <- data_long %>%
  filter(!is.na(Frequency)) %>%
  #filter(!is.na(Proportion)) %>%
  group_by(Locus) %>%
  mutate(Proportion = Frequency / sum(Frequency))

allele_order <- gtools::mixedsort(unique(data_long$Allele))

# Convert the Allele column to factor with the desired levels
data_long$Allele <- factor(data_long$Allele, levels = allele_order)

data_long$Locus <- factor(data_long$Locus, levels = paste0("Locus_", 1:22))
allele_colors <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b", "#e377c2", "#7f7f7f", "#bcbd22", "#17becf", "#393b79")
allele_colors_subset <- allele_colors[1:length(unique(data_long$Allele))]
names(allele_colors_subset) <- unique(data_long$Allele)



ggplot(data_long, aes(x = Locus, y = Frequency, fill=Allele)) +
  geom_bar(stat = "identity") +
  labs(x = "Locus", y = "Frequency") +
  scale_fill_manual(values = allele_colors_subset) +
  theme_minimal()
  theme_bw()
