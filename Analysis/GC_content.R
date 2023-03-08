library(stringr)
library(readr)

data <- read_delim("E:/Bách/Studying/Thesis/VCF/locus/downstream/PIC/high_PIC.GC.sort.tsv")

df_filtered <- df[
  #abs(df$e_het - df$o_het) < 0.4 &
                    df$PIC > 0.7 &
                    df$numcalled > 80 &
                    df$nalleles > 7 &
                    str_count(df$RU, "[GC]")/str_count(df$RU, "[ATCG]") >= 0.4 &
                    str_count(df$RU, "[GC]")/str_count(df$RU, "[ATCG]") <= 0.6, ]

write_tsv(df_filtered, "E:/Bách/Studying/Thesis/VCF/locus/downstream/PIC/GC_filter.new.tsv")
