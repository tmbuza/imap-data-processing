INPUTDIR="../imap-bioinformatics-qiime2/resources/metadata/qiime2_metadata_file.tsv"
OUTDIR="data"

echo PROGRESS: Importing QIIME2 metadata

mkdir -p "${OUTDIR}"

cp "${INPUTDIR}" "${OUTDIR}/qiime2_metadata.tsv"