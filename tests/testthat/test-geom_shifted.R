test_that("Manually-created shifted geometric distribution gives expected values; test1", {
  prob = 0.7
  expect_equal(dgeom_shifted_manual(x = 2, prob = prob), dgeom(x = 1, prob = prob))
})

test_that("Programmatically-created shifted geometric distribution gives expected values; test1", {
  prob = 0.7
  expect_equal(dgeom_shifted_programmatic(x = 2, prob = prob), dgeom(x = 1, prob = prob))
})
