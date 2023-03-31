library(tidyverse, suppressPackageStartupMessages())

# QIIME2  metadata
qiime2_tidy_metadata <- read_tsv("../imap-bioinformatics-qiime2/resources/metadata/qiime2_metadata_file.tsv", 
                            show_col_types = FALSE) %>% 
  rename(sample_id="sample-id") %>% 
  dplyr::filter(!grepl("Mock*", sample_id))

write_csv(qiime2_tidy_metadata, "data/qiime2_tidy_metadata.csv")


# QIIME2  otutable
qiime2_otutable_wider <- read_tsv("../imap-bioinformatics-qiime2/qiime2_process//transformed/feature-table.tsv", skip = 1, show_col_types = FALSE) %>%
  rename(feature='#OTU ID') %>%
  select(-starts_with('Mock')) %>% 
  mutate_at(2:ncol(.), as.numeric) %>% 
  mutate_if(is.numeric, ~replace(., is.na(.), 0))

qiime2_tidy_otutable <- qiime2_otutable_wider %>% 
  pivot_longer(-feature, names_to = "sample_id", values_to = "count") %>% 
  relocate(sample_id, .before = feature)

write_csv(qiime2_tidy_otutable, "data/qiime2_tidy_otutable.csv")


# QIIME2 taxonomy
qiime2_tidy_taxonomy <- read_tsv("../imap-bioinformatics-qiime2/qiime2_process/transformed/taxonomy.tsv", show_col_types=FALSE) %>% 
  rename(feature="Feature ID") %>% 
  distinct() %>%
  mutate_if(is.numeric, ~replace(., is.na(.), 0)) %>%
  mutate(Taxon = str_replace_all(Taxon, "; s__$", ""),
         Taxon = str_replace_all(Taxon, "; g__$", ""),
         Taxon = str_replace_all(Taxon, "; f__$", ""),
         Taxon = str_replace_all(Taxon, "; o__$", ""),
         Taxon = str_replace_all(Taxon, "; c__$", ""),
         Taxon = str_replace_all(Taxon, "; p__$", ""),
         Taxon = str_replace_all(Taxon, "; k__$", ""),
         Taxon = str_replace_all(Taxon, "\\[|\\]", ""),
         Taxon = str_replace_all(Taxon, "\\s", "")) %>%
  dplyr::filter(!grepl("s__*", Taxon)) %>%
  dplyr::filter(grepl("g__*", Taxon)) %>% 
  select(-Confidence) %>% 
  mutate(Taxon = str_replace_all(Taxon, "\\w__", "")) %>% 
  separate(Taxon, into = c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus"), sep = ";")

write_csv(qiime2_tidy_taxonomy, "data/qiime2_tidy_taxonomy.csv")


# QIIME2 composite
qiime2_composite <- inner_join(qiime2_tidy_metadata, qiime2_tidy_otutable, by = "sample_id") %>% 
  inner_join( ., qiime2_tidy_taxonomy, by = "feature") %>% 
  group_by(sample_id) %>% 
  mutate(rel_abund = count/sum(count)) %>% 
  ungroup() %>% 
  mutate_if(is.numeric, ~replace(., is.na(.), 0)) %>%
  relocate(count, .before = rel_abund) 

write_csv(qiime2_composite, "data/qiime2_composite.csv")