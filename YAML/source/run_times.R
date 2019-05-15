#!/usr/bin/env Rscript

library(jsonlite)
library(tidyverse)

data <- read_json("YAML/results/generated.json", simplifyVector = TRUE)
data <- data$results

plugins <- data$command %>%
  map_chr(~ sub(".* ([a-z]+) get$", "\\1", .))
times <-data$times

plugin_times <- tibble(plugin = character(), runtime = double())
for (index in c(1:length(plugins))) {
  plugin_times <- add_row(plugin_times, plugin = plugins[[index]],
                          runtime = times[[index]])
}

ggplot(data = plugin_times) + 
  geom_point(mapping = aes(x = plugin, y = runtime, color = plugin))
