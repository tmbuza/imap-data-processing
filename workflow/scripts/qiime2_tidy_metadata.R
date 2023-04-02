library(tidyverse, suppressPackageStartupMessages())

# QIIME2  metadata
qiime2_tidy_metadata <- read_tsv("data/qiime2_metadata.tsv", 
                            show_col_types = FALSE) %>% 
  rename(sample_id="sample-id") %>% 
  dplyr::filter(!grepl("Mock*", sample_id))

write_csv(qiime2_tidy_metadata, "data/qiime2_tidy_metadata.csv")
