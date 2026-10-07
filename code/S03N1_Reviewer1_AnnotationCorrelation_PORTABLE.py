#!/usr/bin/env python3
"""Portable reproduction of Reviewer 1 Comment 3 annotation-correlation audit.

Input
-----
A regression-bundle directory containing these subdirectories/prefixes:
  Stromal/Stromal.{1..22}.l2.ldscore.gz
  Myeloid/Myeloid.{1..22}.l2.ldscore.gz
  B_lineage/B_lineage.{1..22}.l2.ldscore.gz
  cDC/cDC.{1..22}.l2.ldscore.gz
  Endothelial/Endothelial.{1..22}.l2.ldscore.gz
  Neutrophil/Neutrophil.{1..22}.l2.ldscore.gz
  Pericyte/Pericyte.{1..22}.l2.ldscore.gz
  T_NK/T_NK.{1..22}.l2.ldscore.gz

Example
-------
python code/S03N1_Reviewer1_AnnotationCorrelation_PORTABLE.py \
  --bundle-dir /path/to/regression_bundle

By default outputs are written to ../sldsc_commands_and_key_outputs relative
 to this script. An explicit --output-dir may be supplied.
"""

from argparse import ArgumentParser
from pathlib import Path
import numpy as np
import pandas as pd

PROGRAMS = [
    "Stromal",
    "Myeloid",
    "B_lineage",
    "cDC",
    "Endothelial",
    "Neutrophil",
    "Pericyte",
    "T_NK",
]


def load_program(bundle_dir: Path, name: str) -> pd.DataFrame:
    prefix = bundle_dir / name / name
    pieces = []
    for chrom in range(1, 23):
        path = Path(f"{prefix}.{chrom}.l2.ldscore.gz")
        if not path.exists():
            raise FileNotFoundError(path)
        x = pd.read_csv(path, sep="\t", compression="gzip")
        required = {"CHR", "SNP", "BP", "L2"}
        if not required.issubset(x.columns):
            raise ValueError(f"Unexpected columns in {path}: {list(x.columns)}")
        pieces.append(x[["CHR", "SNP", "BP", "L2"]].rename(columns={"L2": name}))
    return pd.concat(pieces, ignore_index=True)


def main() -> None:
    parser = ArgumentParser()
    parser.add_argument("--bundle-dir", required=True, type=Path,
                        help="Path to the frozen S03I2A regression_bundle directory.")
    default_out = Path(__file__).resolve().parent.parent / "sldsc_commands_and_key_outputs"
    parser.add_argument("--output-dir", type=Path, default=default_out,
                        help="Output directory (default: repository sldsc_commands_and_key_outputs/).")
    args = parser.parse_args()

    bundle_dir = args.bundle_dir.expanduser().resolve()
    out = args.output_dir.expanduser().resolve()
    out.mkdir(parents=True, exist_ok=True)

    merged = None
    for name in PROGRAMS:
        x = load_program(bundle_dir, name)
        if merged is None:
            merged = x
        else:
            merged = merged.merge(
                x,
                on=["CHR", "SNP", "BP"],
                how="inner",
                validate="one_to_one",
            )

    pearson = merged[PROGRAMS].corr(method="pearson")
    spearman = merged[PROGRAMS].corr(method="spearman")

    pearson.to_csv(out / "S03N1_8Broad_LDscore_Pearson_correlation.tsv", sep="\t")
    spearman.to_csv(out / "S03N1_8Broad_LDscore_Spearman_correlation.tsv", sep="\t")

    others = [p for p in PROGRAMS if p != "Stromal"]
    stromal = pd.DataFrame({
        "program": others,
        "pearson_r_with_Stromal": [pearson.loc["Stromal", p] for p in others],
        "spearman_rho_with_Stromal": [spearman.loc["Stromal", p] for p in others],
    }).sort_values("pearson_r_with_Stromal", ascending=False)
    stromal.to_csv(out / "S03N1_Stromal_vs_other_LDscore_correlations.tsv", sep="\t", index=False)

    X = merged[PROGRAMS].to_numpy(dtype=float)
    X = (X - X.mean(axis=0)) / X.std(axis=0, ddof=0)
    condition_number = np.linalg.cond(X)

    report = out / "S03N1_AnnotationCorrelation_report.txt"
    with report.open("w", encoding="utf-8") as f:
        f.write("Reviewer 1 Comment 3: broad-program LD-score correlation audit\n")
        f.write("================================================================\n")
        f.write(f"Common SNPs across 8 custom LD-score predictors: {len(merged):,}\n")
        f.write(f"Condition number of standardized 8-predictor custom matrix: {condition_number:.4f}\n\n")
        f.write("Stromal correlations (sorted by Pearson r):\n")
        f.write(stromal.to_string(index=False))
        f.write("\n")

    print(stromal.to_string(index=False))
    print(f"\nCommon SNPs: {len(merged):,}")
    print(f"Condition number (8 custom predictors only): {condition_number:.4f}")
    print(f"\nOutputs written to: {out}")


if __name__ == "__main__":
    main()
