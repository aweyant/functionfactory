#' The joint distribution of a geometrically-stopped sums of IID exponential
#' RVs
#'

#' @rdname gse
#'
cdf_gse <- function(duration,
                    q, rate, prob) {
  cdf_gse_wrapped()(duration = duration,
                    q = q, shape = NULL, rate = rate, lower.tail = TRUE, log.p = FALSE,
                    x = NULL, prob = prob, log = FALSE)
}

cdf_gse_wrapped <- function(...) {
  factory_cdf_randomly_stopped_sum(args = c(alist(duration = ),
                                            formals(stats::pgamma),
                                            formals(dgeom_shifted_programmatic)),
                                   conditional_cdf = stats::pgamma,
                                   duration_pmf = dgeom_shifted_programmatic,
                                   conditional_cdf_argument_transformations = list("shape = k; rm(scale)"))
}
