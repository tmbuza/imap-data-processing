library(tidyverse)
library(phyloseq)
library(microbiome)
library(ape)

metadata <- read_csv("data/mothur_tidy_metadata.csv",show_col_types = FALSE) %>% 
  tibble::column_to_rownames("sample_id") %>% 
  sample_data(metadata)

otutable <- read_csv("data/mothur_tidy_otutable.csv",show_col_types = FALSE) %>% 
  pivot_wider(id_cols = sample_id, names_from = otu, values_from = count) %>% 
  tibble::column_to_rownames("sample_id") %>% 
  otu_table(otutable, taxa_are_rows = FALSE)

taxonomy <- read_csv("data/mothur_tidy_taxonomy.csv", show_col_types = FALSE) %>%
  tibble::column_to_rownames("otu") %>%
  as.matrix() %>% 
  tax_table(taxonomy)

ps_raw_basic <- merge_phyloseq(metadata, otutable, taxonomy)

library(ape)
ps_raw_taxa_tree = rtree(ntaxa(ps_raw_basic), rooted=TRUE, tip.label=taxa_names(ps_raw_basic))
ps_raw <- phyloseq::merge_phyloseq(ps_raw_basic, ps_raw_taxa_tree)
ps_rel <- phyloseq::transform_sample_counts(ps_raw, function(x){x / sum(x)})

# Validate phyloseq matrices
ps_metadata <- sample_data(ps_raw)
ps_otutable <- otu_table(ps_raw)
ps_taxonomy <- tax_table(ps_raw)
ps_phylotree <- phy_tree(ps_raw)

save(ps_metadata, ps_otutable, ps_taxonomy, ps_phylotree, ps_raw, ps_rel,  file = "data/mothur_phyloseq_objects.rda")

# load("data/mothur_phyloseq_objects.rda", verbose = TRUE)



metadata <- read_csv("data/qiime2_tidy_metadata.csv",show_col_types = FALSE) %>% 
  tibble::column_to_rownames("sample_id") %>% 
  sample_data(metadata)

otutable <- read_csv("data/qiime2_tidy_features.csv",show_col_types = FALSE) %>% 
  pivot_wider(id_cols = sample_id, names_from = feature, values_from = count) %>% 
  tibble::column_to_rownames("sample_id") %>% 
  otu_table(otutable, taxa_are_rows = FALSE)

taxonomy <- read_csv("data/qiime2_tidy_taxonomy.csv", show_col_types = FALSE) %>%
  tibble::column_to_rownames("feature") %>%
  as.matrix() %>% 
  tax_table(taxonomy)

ps_raw_basic <- merge_phyloseq(metadata, otutable, taxonomy)

library(ape)
ps_raw_taxa_tree = rtree(ntaxa(ps_raw_basic), rooted=TRUE, tip.label=taxa_names(ps_raw_basic))
ps_raw <- phyloseq::merge_phyloseq(ps_raw_basic, ps_raw_taxa_tree)
ps_rel <- phyloseq::transform_sample_counts(ps_raw, function(x){x / sum(x)})

# Validate phyloseq matrices
ps_metadata <- sample_data(ps_raw)
ps_otutable <- otu_table(ps_raw)
ps_taxonomy <- tax_table(ps_raw)
ps_phylotree <- phy_tree(ps_raw)


plot(ps_phylotree)

save(ps_metadata, ps_otutable, ps_taxonomy, ps_phylotree, ps_raw, ps_rel,  file = "data/qiime2_phyloseq_objects.rda")

# load("data/phyloseq_objects.rda", verbose = TRUE)

