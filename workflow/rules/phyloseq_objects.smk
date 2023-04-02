# Merge Mothur and Qiime2 otutable
rule phyloseq_objects:
    input:
        mothurotu="data/mothur_composite.csv",
        qiime2otu="data/qiime2_composite.csv",
    output:
        "data/mothur_phyloseq_objects.rda",
        "data/qiime2_phyloseq_objects.rda",
    conda:
        "../envs/environment.yml"
    script:
        "../scripts/phyloseq_objects.R"



        