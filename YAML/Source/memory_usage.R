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
                 bytes = numeric(),
                 lines = numeric())

for (row in 1:nrow(memory_usage)) {
  filepath <- memory_usage$File[row]
  fields <- strsplit(toString(filepath), "_")[[1]]
  lines <- if (length(fields) >= 2)
             as.numeric(sub("(.*)\\.yaml$", "\\1", fields[[2]]))
           else NA

  memory <- add_row(memory,
                    plugin = memory_usage$Plugin[row],
                    file = filepath,
                    bytes = as.numeric(memory_usage$Bytes[row]),
                    lines = lines)
}

# ==========
# = Filter =
# ==========

memory_noline <- filter(memory, is.na(lines))
memory_line <- filter(memory, !is.na(lines))

# =============
# = Visualize =
# =============

ggplot(data = memory_noline, aes(x = file, y = bytes, color = plugin)) +
  scale_color_manual(values = c("YAML CPP" = "#FD7D23",
                                "Yan LR" = "#FFD300",
                                "YAMBi" = "#20C5CC",
                                "YAwn" = "#1992FB",
                                "YAy PEG" = "#983BC9")) +
  geom_point()

ggplot(data = memory_line, aes(x = lines, y = bytes, color = plugin)) +
  scale_color_manual(values = c("YAML CPP" = "#FD7D23",
                                "Yan LR" = "#FFD300",
                                "YAMBi" = "#20C5CC",
                                "YAwn" = "#1992FB",
                                "YAy PEG" = "#983BC9")) +
  geom_point()
