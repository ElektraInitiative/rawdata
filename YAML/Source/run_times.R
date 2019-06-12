#!/usr/bin/env Rscript

# -- Imports -------------------------------------------------------------------

library(jsonlite)
library(tidyverse)
library(scales)
library(ggpubr)

# -- Main ----------------------------------------------------------------------

# ========
# = Read =
# ========

result_directory = "YAML/Results/Run Time"
plugin_times <- tibble(plugin = character(),
                       runtime = double(),
                       lines = numeric(),
                       os = character(),
                       compiler = character())

files <- list.files(result_directory, pattern = "generated_[1-9].*\\.json")
for (filepath in files) {
  fields <- strsplit(filepath, "_")
  fields <- fields[[1]]

  lines <- as.numeric(fields[2])

  os <- fields[3]
  os <- sub("linux", "Linux", os)
  os <- sub("mac", "macOS", os)

  compiler <- fields[4]
  compiler <- sub("(.*)\\.json$", "\\1", compiler)
  compiler <- sub("clang", "Clang ", compiler)
  compiler <- sub("gcc", "GCC  ", compiler)

  data <- read_json(paste(result_directory, filepath, sep = "/"),
                    simplifyVector = TRUE)
  data <- data$results

  plugins <- data$command %>%
    map_chr(~ sub(".* ([a-z]+) get$", "\\1", .)) %>%
    map_chr(~ sub("yambi", "YAMBi", .)) %>%
    map_chr(~ sub("yamlcpp", "YAML CPP", .)) %>%
    map_chr(~ sub("yanlr", "Yan LR", .)) %>%
    map_chr(~ sub("yawn", "YAwn", .)) %>%
    map_chr(~ sub("yaypeg", "YAy PEG", .))

  times <-data$times

  for (index in c(1:length(plugins))) {
    plugin_times <- add_row(plugin_times,
                            plugin = plugins[[index]],
                            runtime = times[[index]],
                            lines = lines,
                            os = os,
                            compiler = compiler)
  }
}

# =============
# = Visualize =
# =============

ggplot(data = plugin_times, aes(x = lines, y = runtime, color = plugin)) +
  scale_color_manual(values = c("YAML CPP" = "#FD7D23",
                                "Yan LR" = "#FFD300",
                                "YAMBi" = "#20C5CC",
                                "YAwn" = "#1992FB",
                                "YAy PEG" = "#983BC9")) +
  scale_x_continuous(name = "Number of Lines/Scalars", trans = "log10",
                     breaks = trans_breaks("log10", function(x) 10^x),
                     labels = trans_format("log10", math_format(10^.x))) +
  scale_y_continuous(name = "Execution Time [s]", trans = "log10") +
  labs(color = "Plugin") +
  annotation_logticks() +
  geom_point() +
  geom_smooth() +
  stat_cor(show.legend = FALSE) +
  facet_wrap(os ~ compiler, nrow = 3)
