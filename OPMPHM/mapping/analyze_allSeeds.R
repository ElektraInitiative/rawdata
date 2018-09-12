#!/usr/bin/env Rscript

if(!require (ggplot2)) install.packages ('ggplot2', dep = TRUE, repos = "http://cran.us.r-project.org")
if(!require (tikzDevice)) install.packages ('tikzDevice', dep = TRUE, repos = "http://cran.us.r-project.org")

library (ggplot2)
library (scales)
library (grid)
library (tikzDevice)

#~ max Mapping invocations
maxMappings <- 4

labelFunction <- function (s)
{
#~ 	n <- ifelse (s == 1, 9, ifelse (s == 6, 29, ifelse (s == 11, 49, 0)))
	n <- ifelse (s == 1, 9, ifelse (s == 6, 29, ifelse (s == 11, 49, ifelse (s == 16, 69, ifelse (s == 21, 89, ifelse (s == 26, 109, ifelse (s == 31, 129, 0)))))))
	s <- s %% (maxMappings + 1)
	return (ifelse (n == 0, s, (paste(s,n,sep = "\n"))))
}

#~ load data
inputData <- read.csv ("data_all_seeds_mapping_benchmark/benchmark_opmphm_mapping_allSeeds.csv", header = TRUE, sep = ";")

data <-  data.frame (n = integer(), trails = integer(), show = integer(), count = integer())

showValues <- list()

for (cI in 2:ncol (inputData))
{
	# parse n
	colName <-  strsplit (colnames (inputData)[cI], "r_")
	nIndex <- as.integer(substring (colName[[1]][1], first=3))

	# unite data
	for (rI in 1:maxMappings)
	{
		count <- inputData[rI,cI]
		data <- rbind (data, c (nIndex, rI, rI + (cI - 2) * (maxMappings + 1), count))
		showValues[length(showValues) + 1] = rI + (cI - 2) * (maxMappings + 1)
	}
}

colnames (data) <- c ("n", "trails", "show", "count")

outputFileName <- sprintf ("output/all_seeds_mapping_benchmark.tex", nIndex)

tikz(file = outputFileName, width = 4.26, height = 3.2, engine = "pdftex")

plot <- ggplot (data, aes (y = count, x = show)) +
	geom_bar (stat="identity", fill="black") +
	scale_x_continuous (name = "hypergraphs\nKeyset size ($n$)", breaks = unlist (showValues), labels = labelFunction) +
	theme_bw ()

print(plot)

dev.off()
