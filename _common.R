knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  cache = FALSE,
  warning = FALSE,
  message = FALSE,
  echo = TRUE,
  dpi = 300,
  out.width = "90%",
  fig.align = "center",
  fig.topcaption=TRUE
)

options(digits = 3, dplyr.print_min = 6, dplyr.print_max = 6)
options(crayon.enabled = FALSE)
suppressPackageStartupMessages(library(tidyverse))
theme_set(theme_light())