#!/usr/bin/env Rscript

# -- Imports -------------------------------------------------------------------

library(tidyverse)

# -- Main ----------------------------------------------------------------------

# ========
# = Read =
# ========

memory_usage <- read.csv(file="YAML/Results/Memory Usage/memory.csv",
                         header=TRUE, sep=";")

memory_usage$Plugin <- memory_usage$Plugin %>%
  map_chr(~ sub(".* ([a-z]+) get$", "\\1", .)) %>%
  map_chr(~ sub("yambi", "YAMBi", .)) %>%
  map_chr(~ sub("yamlcpp", "YAML CPP", .)) %>%
  map_chr(~ sub("yanlr", "Yan LR", .)) %>%
  map_chr(~ sub("yawn", "YAwn", .)) %>%
  map_chr(~ sub("yaypeg", "YAy PEG", .))

memory <- tibble(plugin = character(),
                 file = character(),
                 bytes = numeric())

for (row in 1:nrow(memory_usage)) {
  memory <- add_row(memory,
                    plugin = memory_usage$Plugin[row],
                    file = memory_usage$File[row],
                    bytes = as.numeric(memory_usage$Bytes[row]))
}

# =============
# = Visualize =
# =============

ggplot(data = memory, aes(x = plugin, y = bytes, color = plugin)) +
  scale_color_manual(values = c("YAML CPP" = "#FD7D23",
                                "Yan LR" = "#FFD300",
                                "YAMBi" = "#20C5CC",
                                "YAwn" = "#1992FB",
                                "YAy PEG" = "#983BC9")) +
  geom_point()
