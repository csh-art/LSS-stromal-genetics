# Candidate evidence tables

This directory contains compact derived tables used to audit the six prioritized genes and the CRLF1/rs2074177 locus.

## Six-gene and gene-based evidence

- `S04F_six_gene_evidence_dossier_summary.csv` — integrated six-gene evidence summary.
- `S04F_Data02_candidate_variant_rows.csv` — candidate-associated variant rows used in the locus dossier.
- `S04F_Data10_fastBAT_rows.csv` — fastBAT evidence for the candidate genes.
- `S04F_Data11_MAGMA_rows.csv` — MAGMA evidence for the candidate genes.
- `S04F_colocalization_dataset_trait_summary.csv` — summary of molecular colocalization datasets/traits considered in the target-aware audit.

## Fine-mapping and target-aware colocalization

- `S04F_Data05_exact_rsid_finemap_rows.csv` — exact-rsID fine-mapping rows from the source locus evidence used in the audit.
- `S04F_Data12_exact_rsid_coloc_rows.csv` — exact-rsID molecular colocalization rows, including alternative molecular targets at the locus.

The public Salo source table used in this analysis reports credible-set size but does not provide a canonical per-variant posterior-probability column in the release used here. No per-variant posterior probability is inferred or invented in this repository.

## CRLF1 regional and molecular-QTL evidence

- `S05A_CRLF1_candidate_specific_molecular_coloc_7rows.csv` — seven candidate-specific CRLF1 molecular-QTL colocalization rows.
- `S05A_CRLF1_OverallGWAS_rs2074177_pm500kb.csv` — regional LSS GWAS extract around rs2074177.
- `S05A_CRLF1_preflight_summary.csv` — compact CRLF1 regional-analysis preflight summary.
- `S05B_GTEx_Muscle_GE_CRLF1_rs2074177_pm500kb_PLOTREADY_FINAL.csv` — final plot-ready GTEx skeletal-muscle CRLF1 gene-expression eQTL regional table.
- `S05B_CRLF1_QTL_x_LSS_GWAS_overlap_by_rsid_FINAL.csv` — exact-rsID GWAS/eQTL overlap and allele-orientation audit table.

The Figure 5 molecular-QTL resource is the GTEx skeletal-muscle CRLF1 gene-expression eQTL dataset from eQTL Catalogue study **QTS000015**, dataset **QTD000281**.

## Interpretation

PP.H4 denotes posterior support for a shared association signal under the colocalization model. It is not the posterior probability that rs2074177 itself is causal and does not establish mediation through CRLF1.

The skeletal-muscle eQTL evidence is cross-tissue regulatory evidence. It does not establish an LF-specific regulatory mechanism. Alternative exact-rsID molecular targets at the same locus are retained in the audit rather than suppressed, and CRLF1 is interpreted as showing the most complete cross-layer regulatory convergence rather than as a definitively proven causal gene.

The original third-party Salo supplementary workbook and other large/public source files are not redistributed here; source access is documented in the root `README.md`.
