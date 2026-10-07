# Repository manifest

This manifest documents the intended contents of the reproducibility repository accompanying the revised manuscript.

## `code/`

- `Reviewer1_Comment2_Reproducibility_Functions.R` — portable signed-score, continuous-weight, and deterministic Top-K helper functions.
- `S03I2A_Overall_PRIMARY_8CellType_SLDSC_PORTABLE.sh` — repository-ready reproduction of the eight primary one-at-a-time broad-program S-LDSC regressions.
- `S03N1_Reviewer1_AnnotationCorrelation_PORTABLE.py` — repository-ready LD-score correlation and condition-number audit for the eight broad cellular programs.
- `S03N2_Reviewer1_Conditional_SLDSC_PORTABLE.sh` — repository-ready reproduction of the seven pairwise conditional models and the exploratory all-eight joint model.

## `program_scores_or_manifests/`

Expected frozen analysis files:

- `S03A_ALL_broad_celltype_specificity_rankings.csv.gz`
- `S03B2_FINAL_gene_program_summary.csv`
- `S03B2_FINAL_CellType_B_lineage_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_cDC_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Endothelial_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Myeloid_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Neutrophil_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Pericyte_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_Stromal_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_CellType_T_NK_CONTINUOUS_official_0to1.txt`
- `S03B2_FINAL_Stromal_DiseaseDependent_ALLCHANGE_official_0to1.txt`
- `S03B2_FINAL_Myeloid_DiseaseDependent_ALLCHANGE_official_0to1.txt`
- `README.md`

Only the final S03B2 official-weight outputs are included; superseded continuous-weight versions are intentionally excluded.

## `sldsc_commands_and_key_outputs/`

This directory contains compact outputs required to audit the reported S-LDSC results:

- `S03I2A_Overall_PRIMARY_8CellType_SLDSC_summary.tsv`
- `S03I2A_Overall_PRIMARY_8CellType_SLDSC_ranked.tsv`
- eight primary broad-program `.results` files;
- `S03N1_8Broad_LDscore_Pearson_correlation.tsv`;
- `S03N1_8Broad_LDscore_Spearman_correlation.tsv`;
- `S03N1_Stromal_vs_other_LDscore_correlations.tsv`;
- `S03N1_AnnotationCorrelation_report.txt`;
- seven pairwise conditional `.results` files and their corresponding `.cov` matrices;
- `Overall_ALL8_BroadPrograms_JOINT_plus_baselineLD_v2.2.results`;
- `Overall_ALL8_BroadPrograms_JOINT_plus_baselineLD_v2.2.cov`;
- `README.md`.

Full `.delete`, `.part_delete`, console logs, and other large/intermediate LDSC outputs are intentionally omitted from the public repository.

## `donor_robustness/`

- `S02B_primary_vs_ageSensitivity_concordance.csv`
- `S02B_Stromal_SENSITIVITY_sexAgeAdjusted.csv`
- `S02C_LODO_global_ranking_correlations.csv`
- `S02C_male_only_sensitivity_correlations.csv`
- `S02C_Stromal_gene_level_LODO_robustness.csv`
- `S02C_Stromal_MALE_ONLY_sensitivity.csv`
- `README.md`

The male-only analysis is a directional sensitivity analysis rather than independent replication.

## `candidate_evidence_tables/`

- `S04F_colocalization_dataset_trait_summary.csv`
- `S04F_Data02_candidate_variant_rows.csv`
- `S04F_Data05_exact_rsid_finemap_rows.csv`
- `S04F_Data10_fastBAT_rows.csv`
- `S04F_Data11_MAGMA_rows.csv`
- `S04F_Data12_exact_rsid_coloc_rows.csv`
- `S04F_six_gene_evidence_dossier_summary.csv`
- `S05A_CRLF1_candidate_specific_molecular_coloc_7rows.csv`
- `S05A_CRLF1_OverallGWAS_rs2074177_pm500kb.csv`
- `S05A_CRLF1_preflight_summary.csv`
- `S05B_CRLF1_QTL_x_LSS_GWAS_overlap_by_rsid_FINAL.csv`
- `S05B_GTEx_Muscle_GE_CRLF1_rs2074177_pm500kb_PLOTREADY_FINAL.csv`
- `README.md`

These are compact derived/audit tables. The original third-party Salo supplementary workbook and other public source files are not redistributed here.

## `environment/`

- `sessionInfo.txt` — R session information generated from the analysis environment.
- `software_versions.txt` — Python, LDSC, reference-model, and operating-environment information used for the revision analyses.

## Root metadata

- `README.md`
- `MANIFEST.md`
- `CITATION.cff`

## Intentionally not redistributed

The repository intentionally excludes large public raw/source datasets, standard LDSC reference resources, the full chromosome-level regression bundle, project archives, RDS working objects, internal reports containing local paths, temporary files, superseded scripts, reviewer-only drafts, and unrelated project files.

Public data sources are identified in the root `README.md` by accession, study, or dataset identifier.
