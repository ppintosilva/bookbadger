## download frequently used badges and
## make them available in 'inst/badges' directory

dl_save_badge <- function(url, path) {
  response <- httr::GET(url)
  svg_bin <- httr::content(response, "raw")
  writeBin(svg_bin, path)
}

badges <- tibble(
  subject = rep("iteration", 9),
  status = 1:9 %>% as.character(),
  color = rep("yellow", 9),
  style = "for-the-badge"
) %>%
  # make sure cycle_nodes is available (run '01-writing-cycle.R' first)
  bind_rows(
    cycle_nodes %>%
      filter(label != "init") %>%
      mutate(subject = "cycle") %>%
      mutate(style = "flat-square") %>%
      rename(status = label) %>%
      select(-cycle)
  ) %>%
  mutate(
    url = str_glue("https://img.shields.io/badge/{subject}-{status}-",
                   "{color}.svg?style={style}"),
    path = here::here(str_glue("inst/badges/{subject}_{status}.svg"))
  ) %>%
  mutate(
    url = str_replace(url, pattern = " ", replacement = "%20"),
    path = str_replace(path, pattern = " ", replacement = "_")
  ) %>%
  mutate(
    url = str_replace(url, pattern = "#", replacement = "")
  ) %>%
  mutate(
    group = row_number()
  ) %>%
  group_by(group) %>%
  # download by walking over every row
  group_walk(~{
    dl_save_badge(.x$url, .x$path)
  })

usethis::use_data(badges, cycle_nodes, cycle_edges,
                  internal = TRUE, overwrite = TRUE, version = 3)
