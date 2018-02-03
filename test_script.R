source("functions.R")

context('Testing Data type and dimensions')
test_that('Correct data type and dimensions',{
  tdata = envelope(3)
  expect_is(tdata,'data.table')
  expect_equal(ncol(tdata),4)
  expect_true(max(tdata$sum) == 3)
  expect_true(min(tdata$sum) == 0)
})

context('Testing PD values')
test_that('PD',{
  cpd = cdist(10,2)
  hpd = hdist(30,1)
  npd = ndist(5,1)
  expect_true(cpd <= 1)
  expect_true(hpd <= 1)
  expect_true(npd <= 1)
})

context('Data integrity')
test_that('Data',{
  niso = 3
  tdata = envelope(niso)
  tmat = tdata[sum == 2]
  tabund = pred.int(tdata,niso)
  expect_equal(unique(tmat$sum),2)
  expect_true(is.vector(tabund))
  expect_length(tabund,4)
  expect_is(tabund,"numeric")
})
          
