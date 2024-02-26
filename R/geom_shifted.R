#' Geometric Distribution Supported on Positive Integers
#'
#' @inheritParams stats::Geometric
#' @param log logical; if TRUE, probabilities p are given as log(p).
#' @param x vector of quantiles representing the number of trials in a sequence of Bernoulli trials before success occurs.
#'
#' @name geom_shifted
NULL

### This hard-coding achieves my goal. However, my actual application is much
### more complicated, so this is not a good solution.
#' @rdname geom_shifted
#' @export
dgeom_shifted_manual <- function(x, prob, log = FALSE) {
  stats::dgeom(x = x-1, prob = prob, log = log)
}

#' @rdname geom_shifted
#' @export
dgeom_shifted_programmatic <- function(x,prob,log = FALSE) {
  dgeom_shifted_programmatic_wrapped()(x = x, prob = prob, log = log)
}


dgeom_shifted_programmatic_wrapped <- function(...) {
  shift_support(args = formals(stats::dgeom),
                distribution_function = stats::dgeom,
                shift_args = list("x = x - 1"))
}

