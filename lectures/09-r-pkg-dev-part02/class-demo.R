###############################
#### 1. Create an R package
###############################

library(usethis)
create_package("~/Desktop/thanksRgiving")

###############################
#### 2. Create two new functions in a .R file in the R/ folder 
###############################

use_r("give_thanks")
use_r("thanks_to")

#' Give a random Thanksgiving gratitude message
#'
#' @return A character string containing something to be thankful for.
#' 
#' @export
#' 
#' @examples
#' give_thanks()
#' 
give_thanks <- function() {
  items <- c(
    "family", "friends", "pecan pie", "warm bread",
    "coffee", "pecan pie", "cozy sweaters", 
    "time to rest", "kind people"
  )
  sample(items, size = 1)
}


#' Give a personalized Thanksgiving message
#'
#' @param name A character string of someone's name.
#'
#' @return A personalized greeting
#' 
#' @export
#' 
#' @examples
#' thanks_to("Mom")
thanks_to <- function(name) {
  if (!is.character(name) || length(name) != 1) {
    stop("`name` must be a single character string.", call. = FALSE)
  }
  paste0("Happy Thanksgiving ", name, "! I'm thankful for you.")
}


###############################
#### 3. Editing the DESCRIPTION file
###############################

Package: thanksRgiving
Title: Create Thanksgiving gratitude messages
Version: 0.0.0.9000
Authors@R: 
    person(given = "Stephanie",
           family = "Hicks",
           role = c("aut", "cre"),
           email = "shicks19@jhu.edu", 
           comment = c(ORCID = "0000-0002-5682-5998"))
Description: This package displays gratitude messages for Thanksgiving. 
License: GPL (>= 3)
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.3.2

###############################
#### 4. Add a README.md and license filesfile
###############################

use_readme_md()
use_gpl3_license()

###############################
#### 5. Check package using devtools
###############################

library(devtools)
load_all()
document()
check()

###############################
#### 6. Set up test infrastructure for unit testing
###############################
# This function creates the tests/testthat/ directory, 
#   the tests/testthat.R file (which runs all tests), and 
#   adds testthat to the Suggests field in your DESCRIPTION file. 

usethis::use_testthat()

###############################
#### 7. Create test files
###############################
# To create a new test file for a specific part
#    of your code (e.g., a function), use use_test()

usethis::use_test("give_thanks")
usethis::use_test("thanks_to")

###############################
#### 8. Add unit tests for give_thanks() and thanks_to()
###############################

# add this to test-give_thanks.R
test_that("give thanks functionality works", {
  out <- give_thanks()
  
  # give_thanks should return a character string
  expect_type(out, "character")
  
  # give_thanks should return only one string
  expect_equal(length(out), 1)
})


# add these two unit tests to test-thanks_to.R
test_that("thanks_to returns a personalized message", {
  expect_equal(
    thanks_to("Mom"),
    "Happy Thanksgiving Mom! I'm thankful for you."
  )
})

test_that("test thanks_to for non-character input or more than one", {
  expect_error(thanks_to(123))
  expect_error(thanks_to(c("A", "B")))
  expect_error(thanks_to(NULL))
})

###############################
#### 9. Run all tests
###############################

devtools::test()

###############################
#### 10. Check packge using devtools
###############################

load_all()
document()
test() # new from last time
check()
build()
install()


###############################
#### 11. Push to github and build pkgdown website
###############################

usethis::use_pkgdown_github_pages() 







############################
#### sloop 
############################

library(sloop)
otype(1:10) # base OOP system

library(palmerpenguins)
otype(penguins) # S3 OOP system

mle_obj <- stats4::mle(function(x = 1) (x - 2) ^ 2)
otype(mle_obj) # S4 OOP system

# Let's guess these as a group
library(tidyverse)
otype("Happy Fall Yall")
otype(rpois(10, lambda = 1))
otype(read.csv)
otype(mtcars)
otype(tibble(mtcars))







############################
#### is.object() = tell diff between base an OO object
############################

# A base object
is.object(1:10)

# An OO object
is.object(mtcars)

# Technically, the difference between base and OO objects 
#   is that OO objects have a “class” attribute:
attr(1:10, "class")
attributes(1:10)
attr(mtcars, "class")
attributes(mtcars)




############################
#### class() = find out class of an object in R 
#### typeof() = All objects (base or OO objects) have a base type
############################
class(1:10)
class("is in session.")
class(factor("is in session."))
class(mtcars)
class(class)
otype(class)

typeof(1:10)
typeof(mtcars)
typeof(NULL)
typeof(1L)
typeof(1i)


############################
#### Create a S3 class called 'dog' 
############################

new_dog <- function(name, age, sleep_status) {
  structure(
    list(
      name = name,
      age = age,
      sleep_status = sleep_status
    ),
    class = "dog"
  )
}

# Create our first dog (or object)
d <- new_dog(name = "Milo", age = 4, sleep_status = "asleep")
d

# We can interact with our object using $ to retrieve
#   fields of the object and try to print it:
d$name
d$age
d$sleep_status
print(d)
attr(d, "class")
attributes(d)

# We can see that our dog gets printed out like a regular list.
#   Let’s fix that by defining a print() function for our dog class.
#
#   **IMPORTANT**: As the print() generic function is already available in R,
#                  the only thing we need to do is to define a function 
#                  with a specific naming scheme print.<NAME_OF_OUR_CLASS>:

print.dog <- function(x) {
  cat("Dog: \n")
  cat("\tName: ", x$name, "\n", sep = "")
  cat("\tAge: ", x$age, "\n", sep = "")
  cat("\tSleep status: ", x$sleep_status, "\n", sep = "")
}

# Now our dog class provides its own implementation of the print() function. 
#   Let’s try to print our dog again:
print(d)


# Let's try to create another dog named Max who is 1 years old and is awake
## add here 



# If you want to create a new method (beyond print), it's called a generic
#   Let's create a generic method that returns if the dog is asleep or awake

# Step 1 is always to create the generic method UseMethod()
is_awake <- function(x) { UseMethod("is_awake") }

# Step 2: Define what’s inside the method
#   Note: You define a method for each class or 
#         <NAME_OF_OUR_GENERIC>.<NAME_OF_OUR_CLASS>:
is_awake.dog <- function(x){
    x$sleep_status == "awake"
}
is_awake(d)

# Let's create a generic method that makes the sound a dog makes
make_sound <- function(x) { UseMethod("make_sound") }
make_sound.dog <- function(x) { cat(x$name, "says", "Wooof!\n") }
make_sound(d)

