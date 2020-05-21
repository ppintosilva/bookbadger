library(tidyverse)

cycle_nodes <- tribble(
  ~label, ~color,
  "init", NA,
  "structuring", "#00bfff",
  "writing", "#4682B4",
  "ready to review", "#DA70D6",
  "reviewing (self)", "#B22222",
  "reviewing (peer)", "#B22222",
  "stable", "#3cb371"
) %>%
  mutate(cycle = row_number()) %>%
  select(cycle, everything())

cycle_edges <- tribble(
  ~from, ~to, ~action,
  1,2,"use dev version",
  2,3,NA,
  3,4,NA,
  4,5,NA,
  4,6,NA,
  5,7,"use minor/major version",
  5,3,"increment iteration",
  6,7,"use minor/major version",
  6,3,"increment iteration",
  7,2,"use dev version"
) %>%
  mutate(
    from = factor(from, levels = cycle_nodes$cycle, labels = cycle_nodes$label),
    to = factor(to, levels = cycle_nodes$cycle, labels = cycle_nodes$label)
  )

cycle_viz <- DiagrammeR::grViz("data-raw/writing-cycle.dot")

usethis::use_data(cycle_viz, overwrite = TRUE)

# run script 02
