## objects created in global.R
## can be used in server.R

# packages ----------------------------------------------------------------

# packages that are used
library(shiny)
library(DT)
library(tidyverse)
library(explore)


# data --------------------------------------------------------------------

data <- Titanic %>% 
  tibble::as_tibble() %>% 
  tidyr::uncount(weights = n) %>% 
  rename(Gender = Sex) %>% 
  mutate(Survived = ifelse(Survived == "Yes", 1, 0))

# add description for help-tab
data_title <- "Would you have survived the Titanic?"
  
data_description <- paste(
  "This dataset contains all passengers of the Titanic.",
  "The Titanic crashed an iceberg on April 14th 1912."
)

data_variables <- tribble(
  ~variable, ~description,
  "Class", "ticket class",
  "Gender", "gender of passenger (Male, Female)",
  "Age", "age group of passenger (Child, Adult)",
  "Survived", "did this passenger survive? (0 = no, 1 = yes)"
)

# prepare for exploration -------------------------------------------------

data <- data
data_title <- data_title
data_description <- data_description
data_variables <- data_variables

target_quo = NA
target_text = NA

# define variables for CRAN-package check
type <- NULL
variable <- NULL

tbl_guesstarget <- describe(data) %>%
  filter(type %in% c("lgl","int","dbl","num","fct","chr")) %>%
  select(variable)
guesstarget <- as.character(tbl_guesstarget[[1]])

# check all variables if usable
for (i in names(data))  {
  if (explore::get_type(data[[i]]) == "other")  {
    data[[i]] <- "<hide>"
  }
}
