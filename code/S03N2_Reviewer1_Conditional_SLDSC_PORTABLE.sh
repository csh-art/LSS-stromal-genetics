#!/usr/bin/env bash
# Portable reproduction of Reviewer 1 Comment 3 conditional S-LDSC.
# Statistical model/order/flags mirror the frozen S03N2 v2 analysis; only path
# handling is changed so that no project-specific absolute paths are embedded.

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
OUTPUT_DIR="${OUTPUT_DIR:-${REPO_ROOT}/sldsc_commands_and_key_outputs/conditional_reproduced}"
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

prefix() {
  local program="$1"
  printf '%s/%s/%s.' "${REGRESSION_BUNDLE_DIR}" "${program}" "${program}"
}

STROMAL="$(prefix Stromal)"
MYELOID="$(prefix Myeloid)"
BLINEAGE="$(prefix B_lineage)"
CDC="$(prefix cDC)"
ENDOTHELIAL="$(prefix Endothelial)"
NEUTROPHIL="$(prefix Neutrophil)"
PERICYTE="$(prefix Pericyte)"
TNK="$(prefix T_NK)"

check_prefix() {
  local name="$1"
  local pfx="$2"
  for suffix in "1.l2.ldscore.gz" "1.l2.M" "1.l2.M_5_50" "1.annot.gz"; do
    if [[ ! -f "${pfx}${suffix}" ]]; then
      echo "ERROR: ${name} regression-bundle file missing: ${pfx}${suffix}" >&2
      exit 1
    fi
  done
}

check_prefix "Stromal" "${STROMAL}"
check_prefix "Myeloid" "${MYELOID}"
check_prefix "B_lineage" "${BLINEAGE}"
check_prefix "cDC" "${CDC}"
check_prefix "Endothelial" "${ENDOTHELIAL}"
check_prefix "Neutrophil" "${NEUTROPHIL}"
check_prefix "Pericyte" "${PERICYTE}"
check_prefix "T_NK" "${TNK}"

run_model() {
  local name="$1"
  local refs="$2"

  echo
  echo "============================================================"
  echo "Running: ${name}"
  echo "============================================================"

  "${LDSC_PYTHON}" "${LDSC_DIR}/ldsc.py" \
    --out "${OUTPUT_DIR}/${name}" \
    --h2 "${GWAS_FILE}" \
    --ref-ld-chr "${refs}" \
    --w-ld-chr "${WEIGHTS_PREFIX}" \
    --overlap-annot \
    --print-coefficients \
    --frqfile-chr "${FRQ_PREFIX}" \
    --print-cov \
    --print-delete-vals \
    2>&1 | tee "${OUTPUT_DIR}/${name}.console.txt"
}

run_model "Overall_Stromal_plus_Pericyte_plus_baselineLD_v2.2" \
  "${STROMAL},${PERICYTE},${BASELINELD_PREFIX}"
run_model "Overall_Stromal_plus_Endothelial_plus_baselineLD_v2.2" \
  "${STROMAL},${ENDOTHELIAL},${BASELINELD_PREFIX}"
run_model "Overall_Stromal_plus_Myeloid_plus_baselineLD_v2.2" \
  "${STROMAL},${MYELOID},${BASELINELD_PREFIX}"
run_model "Overall_Stromal_plus_Neutrophil_plus_baselineLD_v2.2" \
  "${STROMAL},${NEUTROPHIL},${BASELINELD_PREFIX}"
run_model "Overall_Stromal_plus_T_NK_plus_baselineLD_v2.2" \
  "${STROMAL},${TNK},${BASELINELD_PREFIX}"
run_model "Overall_Stromal_plus_B_lineage_plus_baselineLD_v2.2" \
  "${STROMAL},${BLINEAGE},${BASELINELD_PREFIX}"
run_model "Overall_Stromal_plus_cDC_plus_baselineLD_v2.2" \
  "${STROMAL},${CDC},${BASELINELD_PREFIX}"

run_model "Overall_ALL8_BroadPrograms_JOINT_plus_baselineLD_v2.2" \
  "${STROMAL},${MYELOID},${BLINEAGE},${CDC},${ENDOTHELIAL},${NEUTROPHIL},${PERICYTE},${TNK},${BASELINELD_PREFIX}"

echo
echo "All conditional models completed."
echo "Outputs: ${OUTPUT_DIR}"
