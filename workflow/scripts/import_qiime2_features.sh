INPUTDIR="../imap-bioinformatics-qiime2/qiime2_process/transformed/feature-table.tsv"
OUTDIR="data"

echo PROGRESS: Importing QiiME2 features

mkdir -p "${OUTDIR}"

cp "${INPUTDIR}" "${OUTDIR}/qiime2_features.tsv"
