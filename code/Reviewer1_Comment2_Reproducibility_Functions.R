# Reviewer 1, Comment 2 - portable reproducibility helpers
# Manuscript: Genetic anchoring of ligamentum flavum stromal remodeling in lumbar spinal stenosis
#
# Purpose:
#   Reproduce the exact frozen transformations used in S03A/S03B2 without
#   project-specific absolute paths. These functions are intended for a
#   versioned revision repository and mirror the audited analysis logic.

signed_normal_equivalent <- function(logFC, PValue) {
  logFC <- as.numeric(logFC)
  p <- as.numeric(PValue)
  p[!is.finite(p) | is.na(p)] <- 1
  p[p < 0] <- 0
  p[p > 1] <- 1
  p_safe <- pmax(p, 1e-300)
  sign(logFC) * qnorm(p_safe / 2, lower.tail = FALSE)
}

continuous_grade_from_signed_score <- function(score) {
  x <- as.numeric(score)
  x[!is.finite(x)] <- 0
  x[x < 0] <- 0

  p_star <- 2 * pnorm(
    abs(x),
    mean = 0,
    sd = 1,
    lower.tail = FALSE
  )

  X <- -2 * log(p_star + 1e-8)
  xmin <- min(X, na.rm = TRUE)
  xmax <- max(X, na.rm = TRUE)

  if (!is.finite(xmin) || !is.finite(xmax) || xmax <= xmin) {
    return(rep(0, length(x)))
  }

  grade <- (X - xmin) / (xmax - xmin)
  grade[grade < 0] <- 0
  grade[grade > 1] <- 1
  grade
}

rank_positive_topk <- function(df, top_k = c(500L, 1000L, 1500L)) {
  required <- c("gene", "logFC", "PValue")
  stopifnot(all(required %in% colnames(df)))

  x <- df[is.finite(df$logFC) & df$logFC > 0, , drop = FALSE]

  # Frozen ranking logic: ascending edgeR P value, then decreasing logFC.
  # Gene symbol is included only as a final deterministic tie-breaker.
  x <- x[order(x$PValue, -x$logFC, x$gene), , drop = FALSE]
  x$positive_rank <- seq_len(nrow(x))

  for (k in top_k) {
    x[[paste0("Top", k)]] <- x$positive_rank <= k
  }
  x
}

# Example use with a frozen broad-lineage ranking table:
# ranked <- read.csv("S03A_ALL_broad_celltype_specificity_rankings.csv.gz")
# stromal <- ranked[ranked$celltype == "Stromal", ]
# stromal$rederived_signed_z <- signed_normal_equivalent(stromal$logFC, stromal$PValue)
# stromal$weight <- continuous_grade_from_signed_score(stromal$rederived_signed_z)
# top_sets <- rank_positive_topk(stromal)
#
# Numerical note:
#   Because X = -2*log(p + 1e-8), X approaches -2*log(1e-8) = 36.84136
#   for extremely small p values. This intentionally compresses the upper tail
#   and avoids infinite weights.
