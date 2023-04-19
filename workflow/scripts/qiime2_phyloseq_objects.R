library(tidyverse)
library(phyloseq)
library(microbiome)
library(ape)

metadata <- read_csv("data/qiime2/qiime2_tidy_metadata.csv",show_col_types = FALSE) %>% 
  tibble::column_to_rownames("sample_id") %>% 
  sample_data(metadata)

otutable <- read_csv("data/qiime2/qiime2_tidy_features.csv",show_col_types = FALSE) %>% 
  pivot_wider(id_cols = sample_id, names_from = feature, values_from = count) %>% 
  tibble::column_to_rownames("sample_id") %>% 
  otu_table(otutable, taxa_are_rows = FALSE)

taxonomy <- read_csv("data/qiime2/qiime2_tidy_taxonomy.csv", show_col_types = FALSE) %>%
  tibble::column_to_rownames("feature") %>%
  as.matrix() %>% 
  tax_table(taxonomy)

ps_raw_basic <- merge_phyloseq(metadata, otutable, taxonomy)

library(ape)
ps_tree = rtree(ntaxa(ps_raw_basic), rooted=TRUE, tip.label=taxa_names(ps_raw_basic))
ps_raw <- phyloseq::merge_phyloseq(ps_raw_basic, ps_tree)

ps_rel <- phyloseq::transform_sample_counts(ps_raw, function(x){x / sum(x)})

save(ps_tree, ps_raw, ps_rel,  file = "data/qiime2/qiime2_phyloseq_objects.rda")
