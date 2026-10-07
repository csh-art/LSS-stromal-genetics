# Reproducibility repository for the LSS stromal-program study

## Manuscript

**Working revised title:** *Genetic anchoring of stromal cellular programs relevant to ligamentum flavum remodeling in lumbar spinal stenosis*

This repository contains the code, frozen derived program files, compact audit tables, and key statistical outputs used to support the revised manuscript. It is designed to document the computational workflow and the reviewer-requested reproducibility analyses without unnecessarily redistributing large public source datasets.

## Public data sources

- **GSE271018** — donor-resolved spinal-ligament / ligament-tissue single-cell RNA-seq resource used for atlas reconstruction, broad cellular programs, and disease-associated Stromal analyses.
- **GSE113212** — external ligamentum-flavum bulk-expression dataset used as a directional tissue-sensitivity analysis.
- **LSS GWAS summary statistics and locus-level evidence** — public release accompanying the study by Salo et al.
- **eQTL Catalogue** — CRLF1 cis-eQTL resource used for the regional analysis: study **QTS000015**, dataset **QTD000281**.

Public source datasets are referenced by accession/source and are not redistributed here unless redistribution is necessary and permitted.

## Repository structure

```text
code/
    Reviewer1_Comment2_Reproducibility_Functions.R
    S03I2A_Overall_PRIMARY_8CellType_SLDSC_PORTABLE.sh
    S03N1_Reviewer1_AnnotationCorrelation_PORTABLE.py
    S03N2_Reviewer1_Conditional_SLDSC_PORTABLE.sh

program_scores_or_manifests/
    frozen broad-cell and disease-associated program files
    broad-cell specificity ranking table
    final program summary table
    README.md

sldsc_commands_and_key_outputs/
    primary one-at-a-time S-LDSC summaries and results
    LD-score correlation outputs
    seven pairwise conditional models
    exploratory all-eight joint model
    covariance matrices used for coefficient-difference auditing
    README.md

donor_robustness/
    age-adjusted sensitivity summaries
    leave-one-donor-out summaries
    male-only directional sensitivity summaries
    README.md

candidate_evidence_tables/
    six-gene evidence summaries
    MAGMA / fastBAT / fine-mapping / exact-rsID colocalization extracts
    CRLF1 regional and molecular-QTL audit tables
    rs2074177 allele-orientation overlap table
    README.md

environment/
    sessionInfo.txt
    software_versions.txt

README.md
MANIFEST.md
CITATION.cff
```

## Broad-program score and weight reproduction

`code/Reviewer1_Comment2_Reproducibility_Functions.R` contains portable helper functions implementing the frozen transformations used in the revised analysis. In brief:

1. For each gene and broad lineage, the edgeR two-sided P value and sign of the log-fold change are converted to a signed normal-equivalent statistic.
2. Negative signed scores are set to zero for the enrichment-oriented downstream annotation.
3. The non-negative score is converted to a two-sided normal-theory P value, transformed as `X = -2*log(p + 1e-8)`, and min-max scaled to the final 0–1 program weight.
4. Positive genes used for Top500/Top1000/Top1500 sensitivity sets are ranked by ascending edgeR P value, then decreasing log-fold change, with gene symbol used only as a deterministic final tie-breaker.

The frozen program files used for downstream analysis are provided in `program_scores_or_manifests/`. Earlier superseded program-weight versions are intentionally not included.

## S-LDSC reproduction

The S-LDSC regression scripts in `code/` are repository-ready versions of the frozen analysis logic with project-specific absolute paths removed. They require the user to supply local paths to LDSC and to the external/frozen regression inputs through environment variables.

Required variables for the shell scripts are:

```bash
export LDSC_DIR=/path/to/ldsc
export REGRESSION_BUNDLE_DIR=/path/to/regression_bundle
export GWAS_FILE=/path/to/Salo2026_Overall_LSS_PRIMARY.sumstats.gz
export BASELINELD_PREFIX=/path/to/baselineLD_v2.2/baselineLD.
export WEIGHTS_PREFIX=/path/to/weights_hm3_no_MHC/weights.hm3_noMHC.
export FRQ_PREFIX=/path/to/1000G_Phase3_frq/1000G.EUR.QC.
```

The primary one-at-a-time models can then be run with:

```bash
bash code/S03I2A_Overall_PRIMARY_8CellType_SLDSC_PORTABLE.sh
```

The reviewer-requested conditional analyses can be run with:

```bash
bash code/S03N2_Reviewer1_Conditional_SLDSC_PORTABLE.sh
```

The eight-program LD-score correlation audit can be run with:

```bash
python code/S03N1_Reviewer1_AnnotationCorrelation_PORTABLE.py \
  --bundle-dir /path/to/regression_bundle
```

The repository provides the compact key outputs from the frozen analyses in `sldsc_commands_and_key_outputs/`. The full chromosome-level regression bundle and standard public LDSC reference resources are not redistributed here because they are large intermediates/reference resources; the portable scripts therefore accept their locations explicitly.

The S-LDSC environment used for the frozen analysis was LDSC **3.0.1** under Python **3.9.23**, with **baselineLD v2.2**. Additional environment information is recorded in `environment/`.

## Donor robustness

`donor_robustness/` contains compact outputs for the donor-aware sensitivity analyses used in the revision, including leave-one-donor-out (LODO), male-only directional sensitivity, and age-adjusted sensitivity. These analyses assess within-cohort robustness and should not be interpreted as independent external replication.

## Candidate and locus evidence

`candidate_evidence_tables/` contains compact derived tables used to audit the six prioritized genes and the CRLF1 locus. The materials separate gene-based association, fine-mapping context, candidate-specific molecular colocalization, alternative molecular targets at the same locus, and allele-direction harmonization.

At the rs2074177 locus, PP.H4 is interpreted as posterior support for a shared association signal under the colocalization model. It is **not** interpreted as the posterior probability that rs2074177 itself is causal and does not prove mediation through CRLF1. The GTEx skeletal-muscle CRLF1 eQTL evidence is cross-tissue regulatory evidence and is not ligamentum-flavum-specific mechanism validation.

## Interpretation boundaries

The materials in this repository should be interpreted consistently with the revised manuscript:

- Broad Stromal genetic localization and disease-associated Stromal transcription are distinct analytical layers.
- The disease-associated Stromal program is not presented as a demonstrated mediator of inherited LSS susceptibility.
- The primary Broad Stromal result localizes inherited susceptibility to a stromal cellular/regulatory context; it does not establish that Stromal is statistically stronger than every other broad cellular program or independent of all correlated annotations.
- CRLF1 and rs2074177 are not described as a proven causal gene or causal variant.
- GSE113212 is used as an external directional tissue-sensitivity analysis; because age and hypertrophy status are aligned in that dataset, it is not treated as independent validation.
- GSE271018-derived programs are described as spinal-ligament/ligament-tissue derived rather than as exclusively ligamentum-flavum specific.

## Versioning and citation

The exact repository state used for resubmission should be archived as a versioned GitHub release (planned tag: `v1.0.0-revision`) and then deposited in Zenodo. After Zenodo assigns a DOI, the DOI and release URL should be added to the manuscript, reviewer response, and `CITATION.cff`.

See `CITATION.cff` for repository citation metadata.

## Contact

Corresponding author: **Xin Jiang, MD, PhD**  
Department of Orthopaedics, China-Japan Friendship Hospital, Beijing, China

## License

No repository license is asserted in this revision package. A license should be added only after the authors decide the intended reuse terms and confirm that those terms are compatible with all included materials.
