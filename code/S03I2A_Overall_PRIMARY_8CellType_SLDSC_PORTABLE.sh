#!/usr/bin/env bash
# Portable reproduction of the primary prespecified one-at-a-time S-LDSC models.
# Each broad cellular annotation is tested separately together with baselineLD v2.2.
# No project-specific absolute paths are embedded.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

: "${LDSC_DIR:?Set LDSC_DIR to the directory containing ldsc.py}"
: "${REGRESSION_BUNDLE_DIR:?Set REGRESSION_BUNDLE_DIR to the frozen S03I2A regression_bundle directory}"
: "${GWAS_FILE:?Set GWAS_FILE to the munged LSS GWAS .sumstats.gz file}"
: "${BASELINELD_PREFIX:?Set BASELINELD_PREFIX, e.g. /path/to/baselineLD_v2.2/baselineLD.}"
: "${WEIGHTS_PREFIX:?Set WEIGHTS_PREFIX, e.g. /path/to/weights_hm3_no_MHC/weights.hm3_noMHC.}"
: "${FRQ_PREFIX:?Set FRQ_PREFIX, e.g. /path/to/1000G_Phase3_frq/1000G.EUR.QC.}"

LDSC_PYTHON="${LDSC_PYTHON:-python}"
OUTPUT_DIR="${OUTPUT_DIR:-${REPO_ROOT}/sldsc_commands_and_key_outputs/primary_reproduced}"
mkdir -p "${OUTPUT_DIR}"

if [[ ! -f "${LDSC_DIR}/ldsc.py" ]]; then
  echo "ERROR: ${LDSC_DIR}/ldsc.py not found" >&2
  exit 1
fi

for f in \
  "${GWAS_FILE}" \
  "${BASELINELD_PREFIX}1.l2.ldscore.gz" \
  "${WEIGHTS_PREFIX}1.l2.ldscore.gz" \
  "${FRQ_PREFIX}1.frq"; do
  if [[ ! -f "${f}" ]]; then
    echo "ERROR: required file missing: ${f}" >&2
    exit 1
  fi
done

PROGRAMS=(Stromal Myeloid B_lineage cDC Endothelial Neutrophil Pericyte T_NK)

check_program_prefix() {
  local program="$1"
  local prefix="${REGRESSION_BUNDLE_DIR}/${program}/${program}."
  for suffix in "1.l2.ldscore.gz" "1.l2.M" "1.l2.M_5_50" "1.annot.gz"; do
    if [[ ! -f "${prefix}${suffix}" ]]; then
      echo "ERROR: missing ${prefix}${suffix}" >&2
      exit 1
    fi
  done
}

for program in "${PROGRAMS[@]}"; do
  check_program_prefix "${program}"
done

run_model() {
  local program="$1"
  local custom_prefix="${REGRESSION_BUNDLE_DIR}/${program}/${program}."
  local name="Overall_PRIMARY_${program}_ABC_Road_ALL_plus_baselineLD_v2.2"

  echo "Running ${name}"
  "${LDSC_PYTHON}" "${LDSC_DIR}/ldsc.py" \
    --out "${OUTPUT_DIR}/${name}" \
    --h2 "${GWAS_FILE}" \
    --ref-ld-chr "${custom_prefix},${BASELINELD_PREFIX}" \
    --w-ld-chr "${WEIGHTS_PREFIX}" \
    --overlap-annot \
    --print-coefficients \
    --frqfile-chr "${FRQ_PREFIX}" \
    --print-cov \
    --print-delete-vals \
    2>&1 | tee "${OUTPUT_DIR}/${name}.console.txt"
}

for program in "${PROGRAMS[@]}"; do
  run_model "${program}"
done

echo "Primary one-at-a-time S-LDSC models completed."
echo "Outputs: ${OUTPUT_DIR}"
