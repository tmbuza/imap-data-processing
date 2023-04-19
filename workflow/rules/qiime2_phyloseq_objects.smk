# Merge Mothur and Qiime2 otutable
rule phyloseq_objects:
    input:
        "data/qiime2/qiime2_composite.csv",
    output:
        "data/qiime2/qiime2_phyloseq_objects.rda",
    conda:
        "../envs/environment.yml"
    script:
        "../scripts/qiime2_phyloseq_objects.R"



        