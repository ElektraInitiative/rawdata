#!/usr/bin/env Rscript

# -- Imports -------------------------------------------------------------------

library(jsonlite)
library(tidyverse)

# -- Main ----------------------------------------------------------------------

# ========
# = Read =
# ========

result_directory = "YAML/Results"
plugin_times <- tibble(plugin = character(), runtime = double(), os = character())

files <- list.files(result_directory, pattern="generated.*\\.json")
for (filepath in files) {
  fields <- strsplit(filepath, "_")
  fields <- fields[[1]]
  
  lines <- fields[2]
  os <- fields[3]
  compiler <- fields[4]
  
  data <- read_json(paste(result_directory, filepath, sep="/"), simplifyVector = TRUE)
  data <- data$results
  
  plugins <- data$command %>%
    map_chr(~ sub(".* ([a-z]+) get$", "\\1", .))
  times <-data$times
  
  for (index in c(1:length(plugins))) {
    plugin_times <- add_row(plugin_times, plugin = plugins[[index]],
                            runtime = times[[index]], os = os)
  }
}

# =============
# = Visualize =
# =============

ggplot(data = plugin_times) +
  geom_point(mapping = aes(x = plugin, y = runtime, color = plugin))
