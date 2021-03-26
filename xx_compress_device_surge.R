# Libraries ---------------------------------------------------------------
library(here)
library(readr)
library(dplyr)
library(stringr)


# Readr Config ------------------------------------------------------------
surge_col_names = c("geoid",
                    "date",
                    "city",
                    "state",
                    "outside_perc_1wk",
                    "outside_perc_2wk",
                    "outside_perc_3wk",
                    "outside_perc_4wk",
                    "known_protest_today",
                    "known_protest_ever",
                    "xcoord",
                    "ycoord",
                    "outside_perc_wk1_above200",
                    "outside_perc_wk1_above300",
                    "outside_perc_wk1_above400",
                    "outside_perc_wk1_above500",
                    "outside_perc_wk2_above200",
                    "outside_perc_wk2_above300",
                    "outside_perc_wk2_above400",
                    "outside_perc_wk2_above500",
                    "outside_perc_wk3_above200",
                    "outside_perc_wk3_above300",
                    "outside_perc_wk3_above400",
                    "outside_perc_wk3_above500",
                    "outside_perc_wk4_above200",
                    "outside_perc_wk4_above300",
                    "outside_perc_wk4_above400",
                    "outside_perc_wk4_above500")

surge_col_types = cols(geoid    = col_character(),
                       date     = col_date(),
                       city     = col_skip(),
                       state    = col_skip(),
                       outside_perc_1wk = col_double(),
                       outside_perc_2wk = col_double(),
                       outside_perc_3wk = col_double(),
                       outside_perc_4wk = col_double(),
                       known_protest_today = col_skip(),
                       known_protest_ever  = col_skip(),
                       xcoord = col_skip(),
                       ycoord = col_skip(),
                       outside_perc_wk1_above200 = col_skip(),
                       outside_perc_wk1_above300 = col_skip(),
                       outside_perc_wk1_above400 = col_skip(),
                       outside_perc_wk1_above500 = col_skip(),
                       outside_perc_wk2_above200 = col_skip(),
                       outside_perc_wk2_above300 = col_skip(),
                       outside_perc_wk2_above400 = col_skip(),
                       outside_perc_wk2_above500 = col_skip(),
                       outside_perc_wk3_above200 = col_skip(),
                       outside_perc_wk3_above300 = col_skip(),
                       outside_perc_wk3_above400 = col_skip(),
                       outside_perc_wk3_above500 = col_skip(),
                       outside_perc_wk4_above200 = col_skip(),
                       outside_perc_wk4_above300 = col_skip(),
                       outside_perc_wk4_above400 = col_skip(),
                       outside_perc_wk4_above500 = col_skip())


# Load Data ---------------------------------------------------------------
message('Loading data...')
surge_raw = read_csv(here('data', 'device_surge.csv'),
                     col_names = surge_col_names,
                     col_types = surge_col_types,
                     skip = 1)


# Convert Types -----------------------------------------------------------
message('Coercing column types...')
surge = mutate(surge_raw,
               geoid = as.numeric(geoid),
               date  = as.integer(str_remove_all(date, '-')))


# Save --------------------------------------------------------------------
message('Saving...')
write_rds(surge, here('data', 'device_surge.rds'), compress = 'gz')


# Done --------------------------------------------------------------------
message('Done.')

