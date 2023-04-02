# mothur_metadata
rule import_mothur_metadata:
    output:
        "data/mothur_metadata.tsv"
    conda:
        "../envs/environment.yml"
    shell:
        "bash workflow/scripts/import_mothur_metadata.sh"


# mothur_shared_file
rule import_mothur_otutable:
    output:
        "data/mothur_otutable.tsv"
    conda:
        "../envs/environment.yml"
    shell:
        "bash workflow/scripts/import_mothur_otutable.sh"


# mothur_taxonomy
rule import_mothur_taxonomy:
    output:
        "data/mothur_taxonomy.tsv"
    conda:
        "../envs/environment.yml"
    shell:
        "bash workflow/scripts/import_mothur_taxonomy.sh"

# mothur_metadata
rule process_mothur_tidy_metadata:
    input:
        metadata=rules.import_mothur_metadata.output
    output:
        "data/mothur_tidy_metadata.csv"
    conda:
        "../envs/environment.yml"
    script:
        "../scripts/mothur_tidy_metadata.R"


# mothur_shared_file
rule process_mothur_tidy_otutable:
    input:
        otutable=rules.import_mothur_otutable.output
    output:
        "data/mothur_tidy_otutable.csv"
    conda:
        "../envs/environment.yml"
    script:
        "../scripts/mothur_tidy_otutable.R"


# mothur_taxonomy
rule process_mothur_tidy_taxonomy:
    input:
        taxonomy=rules.import_mothur_taxonomy.output
    output:
        "data/mothur_tidy_taxonomy.csv"
    conda:
        "../envs/environment.yml"
    script:
        "../scripts/mothur_tidy_taxonomy.R"


# mothur_composite
rule mothur_composite:
    input:
        metadata=rules.process_mothur_tidy_metadata.output,
        otutable=rules.process_mothur_tidy_otutable.output,
        taxonomy=rules.process_mothur_tidy_taxonomy.output,
    output:
        "data/mothur_composite.csv"
    conda:
        "../envs/environment.yml"
    script:
        "../scripts/mothur_composite.R"