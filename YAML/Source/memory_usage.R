#!/usr/bin/env Rscript

# -- Imports -------------------------------------------------------------------

library(tidyverse)
library(scales)
library(ggpubr)

# -- Functions -----------------------------------------------------------------

memory.graph <- function(data) {
  ggplot(data = data, aes(x = lines, y = bytes, color = plugin)) +
    scale_color_manual(values = c("YAML CPP" = "#FD7D23",
                                  "Yan LR" = "#FFD300",
                                  "YAMBi" = "#20C5CC",
                                  "YAwn" = "#1992FB",
                                  "YAy PEG" = "#983BC9")) +
    scale_x_continuous(name = "Number of Lines/Scalars", trans = "log10",
                       breaks = trans_breaks("log10", function(x) 10^x),
                       labels = trans_format("log10", math_format(10^.x))) +
    scale_y_continuous(name = "Heap Usage [Bytes]",
                       trans = "log10",
                       labels = number_bytes_format(symbol = "MB",
                                                    units = "si")) +
    labs(color = "Plugin") +
    annotation_logticks() +
    stat_cor(show.legend = FALSE) +
    geom_smooth() +
    geom_point()
}

# -- Main ----------------------------------------------------------------------

# ========
# = Read =
# ========

memory <- tibble(plugin = character(),
                 file = character(),
                 bytes = numeric(),
                 lines = numeric(),
                 os = character(),
                 compiler = character())

result_directory = "YAML/Results/Memory Usage"
files <- list.files(result_directory, pattern = ".*\\.csv")
for (filepath in files) {
  memory_usage <- read.csv(file = paste(result_directory, filepath, sep = "/"),
                           header = TRUE, sep = ";")

  memory_usage$Plugin <- memory_usage$Plugin %>%
    map_chr(~ sub(".* ([a-z]+) get$", "\\1", .)) %>%
    map_chr(~ sub("yambi", "YAMBi", .)) %>%
    map_chr(~ sub("yamlcpp", "YAML CPP", .)) %>%
    map_chr(~ sub("yanlr", "Yan LR", .)) %>%
    map_chr(~ sub("yawn", "YAwn", .)) %>%
    map_chr(~ sub("yaypeg", "YAy PEG", .))

  memory_usage$OS <- memory_usage$OS %>%
    map_chr(~ sub("linux", "Linux", .)) %>%
    map_chr(~ sub("mac", "macOS", .))

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
                      lines = lines,
                      os = memory_usage$OS[row])
  }
}

# ==========
# = Filter =
# ==========

memory_all <- filter(memory, !is.na(lines) & lines >= 1)
memory_large <- filter(memory, !is.na(lines) & lines >= 1000)

# =============
# = Visualize =
# =============

memory.graph(memory_all)
memory.graph(memory_large)
