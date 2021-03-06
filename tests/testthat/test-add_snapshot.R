m <- tibble::rownames_to_column(mtcars, "car")

test_that("add_snapshot with same structure works", {

  expect_equal(add_snapshot(vibble::vibble(m, as_of="2022-01-01") |> magrittr::set_class("data.frame"), m, as_of="2022-01-02")[,1:12], m)
  expect_equal(add_snapshot(vibble::vibble(m, as_of="2022-01-01"), m, as_of="2022-01-02"), vibble::vibble(m, as_of="2022-01-01"))

})


md <- add_snapshot(vibble::vibble(m, as_of="2022-01-01"), m[,1:3], as_of="2022-01-02")

test_that("add_snapshot with different structure works", {
  expect_equal(as_of(md, "2022-01-01"), m)
  expect_equal(as_of(md, "2022-01-02"), m[,1:3])
  expect_equal(magrittr::set_rownames(md[1:32,1:3], NULL), magrittr::set_rownames(md[33:64,1:3], NULL))
  expect_true(all(is.na(md[33:64,4:12])))
  expect_true(all(md[1:32,"ValidFrom"]=="2022-01-01"))
  expect_true(all(md[33:64,"ValidFrom"]=="2022-01-02"))
  expect_true(all(md[1:32,"ValidTo"]=="2022-01-02"))
  expect_true(all(is.na(md[33:64,"ValidTo"])))
})
