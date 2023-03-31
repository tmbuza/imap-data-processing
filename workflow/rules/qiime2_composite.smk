# qiime2_composite
rule R_merge_features_taxonomy_metadata:
    output:
        "data/qiime2_composite.csv"
    conda:
        "../envs/environment.yml"
    script:
        "../scripts/qiime2_composite_table.R"