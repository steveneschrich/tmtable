m <- tibble::rownames_to_column(mtcars, "cars")

test_that("creating vibble works", {
  expect_equal(nrow(x<-vibble::vibble(m, as_of="v1")),nrow(m))
  expect_equal(ncol(x), ncol(m)+2)
  expect_equal(colnames(x), c(colnames(m),"ValidFrom","ValidTo"))
  expect_true(all(is.na(x$ValidTo)))
  expect_true(all(x$ValidFrom == "v1"))
  expect_equal(class(x), c("vibble","data.frame"))
  expect_equal(vibble::vibble(m), vibble::vibble(m, as_of=lubridate::today()))
})

test_that("as_vibble works", {
  expect_equal(as_vibble(m, as_of="v1"), vibble(m, as_of="v1"))
})
