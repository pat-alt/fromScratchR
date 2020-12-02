# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_package("data.table", min_version = T)
usethis::use_package("ggplot2", min_version = T)
usethis::use_package("expm", min_version = T)
usethis::use_package("testthat", "Suggests", min_version = T)

# Functions ----
golem::add_utils("complete_dt")

## Tests ----
## Add one line by test you want to create
# usethis::use_test( "compute_J" )

## Data ----
# usethis::use_data(canada, internal = F, overwrite = T)

# Documentation

## Vignette ----
usethis::use_vignette("fromScratchR")
devtools::build_vignettes()

## PDF manual ----
# Put "R CMD Rd2pdf ~/git/SVAA" into the terminal

## Code coverage ----
## (You'll need GitHub there)
# usethis::use_github()
# usethis::use_travis()
# usethis::use_appveyor()

