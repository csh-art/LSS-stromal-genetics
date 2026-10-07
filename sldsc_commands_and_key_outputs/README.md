# S-LDSC commands and key outputs

This directory contains compact outputs supporting the primary and reviewer-requested stratified LD score regression (S-LDSC) analyses.

Executable repository-ready scripts are stored in `../code/` rather than duplicated here.

## Primary one-at-a-time analysis

- `S03I2A_Overall_PRIMARY_8CellType_SLDSC_summary.tsv` — combined summary across the eight broad cellular programs.
- `S03I2A_Overall_PRIMARY_8CellType_SLDSC_ranked.tsv` — ranked primary summary.
- `Overall_PRIMARY_*_ABC_Road_ALL_plus_baselineLD_v2.2.results` — frozen LDSC `.results` outputs for the eight broad programs.

Each primary broad cellular annotation was tested separately together with baselineLD v2.2.

## LD-score correlation audit

- `S03N1_8Broad_LDscore_Pearson_correlation.tsv`
- `S03N1_8Broad_LDscore_Spearman_correlation.tsv`
- `S03N1_Stromal_vs_other_LDscore_correlations.tsv`
- `S03N1_AnnotationCorrelation_report.txt`

These files quantify shared genomic annotation structure among the eight custom broad-program LD-score predictors.

## Conditional analyses

Seven pairwise models jointly include the Broad Stromal annotation, one companion broad cellular annotation, and baselineLD v2.2. Each pairwise model is represented by a `.results` file and the corresponding `.cov` matrix.

The exploratory all-eight joint model is represented by:

- `Overall_ALL8_BroadPrograms_JOINT_plus_baselineLD_v2.2.results`
- `Overall_ALL8_BroadPrograms_JOINT_plus_baselineLD_v2.2.cov`

The covariance matrices are retained because they are needed for covariance-aware coefficient-difference auditing.

## Reproduction scripts

- `../code/S03I2A_Overall_PRIMARY_8CellType_SLDSC_PORTABLE.sh`
- `../code/S03N1_Reviewer1_AnnotationCorrelation_PORTABLE.py`
- `../code/S03N2_Reviewer1_Conditional_SLDSC_PORTABLE.sh`

The shell scripts require user-supplied paths to LDSC, the frozen regression bundle, the munged LSS GWAS file, baselineLD v2.2, HapMap3 regression weights, and 1000 Genomes Phase 3 EUR frequency files. See the root `README.md` for usage.

The full chromosome-level regression bundle, `.delete`/`.part_delete` intermediates, console logs, and standard public LDSC reference resources are not redistributed in this compact repository.
