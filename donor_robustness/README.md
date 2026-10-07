# Donor robustness

This directory contains compact outputs used to assess robustness of the donor-level Stromal disease-state analysis.

## Files

- `S02B_primary_vs_ageSensitivity_concordance.csv` — transcriptome-wide concordance between the primary model and the age-adjusted sensitivity analysis.
- `S02B_Stromal_SENSITIVITY_sexAgeAdjusted.csv` — Stromal age-adjusted sensitivity results.
- `S02C_LODO_global_ranking_correlations.csv` — transcriptome-wide correlations across leave-one-donor-out (LODO) refits.
- `S02C_male_only_sensitivity_correlations.csv` — genome-wide concordance between the primary and male-only analyses.
- `S02C_Stromal_gene_level_LODO_robustness.csv` — gene-level LODO robustness summary for the final Stromal analysis.
- `S02C_Stromal_MALE_ONLY_sensitivity.csv` — Stromal male-only sensitivity results.

## Interpretation

The primary disease-associated Stromal analysis uses donor-level pseudobulk profiles; individual cells are not treated as independent biological replicates. LODO analyses assess sensitivity to omission of individual donors. The male-only analysis is a small-sample directional sensitivity analysis, not independent replication. The age-adjusted analysis is also a sensitivity analysis and has reduced statistical power because of the small donor set.

These outputs support within-cohort robustness but do not establish external reproducibility or generalizability.
