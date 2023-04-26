
rule mothur_phyloseq_objects:
    input:
        metadata=rules.process_mothur_tidy_metadata.output,
        otutable=rules.process_mothur_tidy_otutable.output,
        taxonomy=rules.process_mothur_tidy_taxonomy.output,
    output:
        "data/mothur/mothur_phyloseq_objects.rda",
    conda:
        "../envs/environment.yml"
    script:
        "../scripts/mothur_phyloseq_objects.R"
