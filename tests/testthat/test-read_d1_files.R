context("read_d1_files")

test_that("read_d1_files reads in csv format", {
  temp_dir <- tempdir()
  out <- download_d1_data("https://cn.dataone.org/cn/v2/resolve/urn:uuid:a2834e3e-f453-4c2b-8343-99477662b570", 
                          temp_dir)
  
  results <- read_d1_files(out)
  expect_length(results, 3)
  
  # check specific entries in each tibble
  expect_equal(results[["attribute_metadata"]]$attributeName[1], "Date")
  expect_equal(results[["summary_metadata"]]$value[1], "Alexander_Exp Burn Soil Mois 2012_2017")
  expect_equal(results[["data"]]$`Unburned Moisture (cm3 cm-3)`[1], 0.15)
  
  # remove files
  files <- list.files(out)
  file.remove(list.files(out, recursive = TRUE, full.names = TRUE))
  file.remove(out)
})

test_that("read_d1_files prints a warning for non-csv formats", {
  temp_dir <- tempdir()
  out <- download_d1_data("https://arcticdata.io/metacat/d1/mn/v2/object/urn:uuid:3a640853-8834-4662-b48f-c74025a336a6",
                          temp_dir)
  
  expect_warning(read_d1_files(out))
  
  # remove files
  files <- list.files(out)
  file.remove(list.files(out, recursive = TRUE, full.names = TRUE))
  file.remove(out)
})