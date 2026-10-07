# Program scores and frozen manifests

This directory contains the frozen broad-cell and disease-associated program files used for downstream genetic analyses in the revised manuscript.

## Broad cellular programs

The eight final broad-program weight files are:

- `S03B2_FINAL_CellType_B_lineage_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_cDC_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Endothelial_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Myeloid_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Neutrophil_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Pericyte_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Stromal_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_T_NK_CONTINUOUS_official_0to1.txt`

`S03A_ALL_broad_celltype_specificity_rankings.csv.gz` provides the frozen broad-cell specificity ranking table, and `S03B2_FINAL_gene_program_summary.csv` provides the compact final program summary.

## Disease-associated programs

- `S03B2_FINAL_Stromal_DiseaseDependent_ALLCHANGE_official_0to1.txt`
- `S03B2_FINAL_Myeloid_DiseaseDependent_ALLCHANGE_official_0to1.txt`

The Broad Stromal program and disease-associated Stromal program have different inferential roles. The broad program represents lineage-level cellular identity relative to other broad compartments, whereas the disease-associated program represents within-Stromal transcriptional differences between degenerative LSS and traumatic controls.

## Weight construction

The exact portable helper functions for the signed-score and continuous 0–1 weight transformation are provided in `../code/Reviewer1_Comment2_Reproducibility_Functions.R`.

Negative signed scores are set to zero before the enrichment-oriented weight transformation. The `1e-8` offset in the transformed P-value step limits the upper tail, so multiple very strong genes may receive identical or near-identical maximum weights. These weights are annotation strengths and must not be interpreted as causal probabilities.

Only the final S03B2 official-weight outputs are included here; earlier superseded weight versions are intentionally excluded.
