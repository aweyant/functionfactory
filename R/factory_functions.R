#' Function-building utilities
#'
#'
#' @name factory_function_utils
NULL

#' @rdname factory_function_utils
#'
#' @param args arguments passed by the user to the created function
#' @param distribution_function (...)
#' @param shift_args string describing transformations to inputs of the
#' distribution function, usually a 'rigid shift' indicating a different support
#' @param env environment in which to evaluate the new function
#'
#' @export
shift_support <- function(args, distribution_function, shift_args, env = parent.frame()) {
  body = substitute({
    arguments = c(as.list(environment()))
    temp_str = paste(shift_args, collapse = ";")
    transformed_args = within(data = arguments,
                              expr = {
                                eval(parse(text = temp_str))
                              })
    do.call(what = distribution_function,
            args = transformed_args)
  })
  args <- as.pairlist(args)
  eval(call("function", args, body), env)
}

#' @rdname factory_function_utils
factory_cdf_randomly_stopped_sum <- function(args,
                                             conditional_cdf,
                                             duration_pmf,
                                             conditional_cdf_argument_transformations,
                                             env = parent.frame()) {
  body = substitute({
    arguments = c(as.list(environment()))
    #print(arguments)
    #print(names(arguments) %in% names(formals(duration_pmf)))
    pmf_arguments = arguments[names(arguments) %in% names(formals(duration_pmf))]
    #print(pmf_arguments)
    cdf_arguments = arguments[names(arguments) %in% names(formals(conditional_cdf))]
    #print("...")
    #print(names(arguments) %in% names(formals(conditional_cdf)))
    #print(cdf_arguments)

    sum(vapply(X = seq.int(1,duration,1),
               FUN = function(k) {

                 temp_str = paste(conditional_cdf_argument_transformations, collapse = ";")
                 transformed_cdf_arguments = within(data = cdf_arguments,
                                                    expr = {
                                                      eval(parse(text = temp_str))
                                                      })

                 pmf_arguments$x <- k

                 #print(pmf_arguments)
                 #print(".....")
                 #print(transformed_cdf_arguments)

                 do.call(what = duration_pmf,
                         args = pmf_arguments) *
                   do.call(what = conditional_cdf,
                           transformed_cdf_arguments)
               },
               FUN.VALUE = numeric(1)))
  })
  args <- as.pairlist(args)
  eval(call("function", args, body), env)
}
