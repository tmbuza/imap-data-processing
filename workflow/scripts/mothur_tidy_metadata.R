library(tidyverse, suppressPackageStartupMessages())

# MOTHUR  metadata
mothur_tidy_metadata <- read_tsv("data/mothur_metadata.tsv", 
                            show_col_types = FALSE) %>% 
  rename_all(tolower) %>% 
  dplyr::filter(!grepl("Mock*", sample_id))

write_csv(mothur_tidy_metadata, "data/mothur_tidy_metadata.csv")
