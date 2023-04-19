INPUTDIR="../imap-bioinformatics-qiime2/resources/metadata/qiime2_sample_metadata.tsv"
OUTDIR="data/qiime2"

echo PROGRESS: Importing QIIME2 metadata

mkdir -p "${OUTDIR}"

cp "${INPUTDIR}" "${OUTDIR}/qiime2_sample_metadata.tsv"