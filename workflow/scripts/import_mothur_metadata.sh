METADATA="../imap-bioinformatics-mothur/resources/metadata/mothur_metadata_file.tsv"
DESIGN="../imap-bioinformatics-mothur/resources/metadata/mothur_design_file.tsv"
OUTDIR="data"

echo PROGRESS: Importing MOTHUR metadata

mkdir -p "${OUTDIR}"

cp "${METADATA}" "${OUTDIR}/mothur_metadata.tsv"
cp "${DESIGN}" "${OUTDIR}/mothur_design.tsv"