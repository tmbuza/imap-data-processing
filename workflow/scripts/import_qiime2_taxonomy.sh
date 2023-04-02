INPUTDIR="../imap-bioinformatics-qiime2/qiime2_process/transformed/taxonomy.tsv"
OUTDIR="data"

echo PROGRESS: Importing QIIME2 taxonomy

mkdir -p "${OUTDIR}"

cp "${INPUTDIR}" "${OUTDIR}/qiime2_taxonomy.tsv"