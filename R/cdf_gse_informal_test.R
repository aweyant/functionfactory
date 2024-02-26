# library(events)
# library(ggplot2)
#
# N = 1000
# rate = 1/10
# prob = 0.7
#
# random_events <- rgtetlg(n = N,
#                          beta = rate,
#                          prob_p = prob, prob_q = prob)
#
# random_events <- within(random_events,
#                         {
#                           enep = vapply(X = seq_len(nrow(random_events)),
#                                         FUN = function(i) {
#                                           sum((x <= x[i]) * (n <= n[i]))/nrow(random_events)
#                                         },
#                                         FUN.VALUE = numeric(1))
#                           nep = vapply(X = seq_len(nrow(random_events)),
#                                        FUN = function(i) {
#                                          cdf_gse(duration = n[i], q = x[i], rate = rate, prob = prob)
#                                        },
#                                        FUN.VALUE = numeric(1))
#                         }
#                         )
# ggplot(data = random_events,
#        aes(x = nep,
#            y = enep)) +
#   geom_point() +
#   geom_abline(slope = 1, intercept = 0) +
#   coord_equal() +
#   facet_wrap(~n)
# # with(random_events,
# #      {
# #        plot(enep ~ nep, asp = 1)
# #        abline(b = 1, a = 0)
# #      })
#
