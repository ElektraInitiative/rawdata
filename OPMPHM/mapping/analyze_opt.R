#!/usr/bin/env Rscript

if(!require (ggplot2)) install.packages ('ggplot2', dep = TRUE, repos = "http://cran.us.r-project.org")
if(!require (tikzDevice)) install.packages ('tikzDevice', dep = TRUE, repos = "http://cran.us.r-project.org")

library (ggplot2)
library (scales)
library (grid)
library (tikzDevice)

integerEqual <- function (a, b)
{
	return (identical (as.integer (a), as.integer (b)))
}

#~ max Mapping invocations
maxMappings <- 10

#~ load parts
parts <- 5

inputDatas <- list()

for (i in 1:parts)
{
	inputDatas[[i]] <- read.csv (sprintf ("data_optimal_mapping_benchmark/benchmark_opmphm_mapping_opt_%i.csv", i), header = TRUE, sep = ";")
}

# merge

inputData <- inputDatas[[1]]

for (cI in 2:ncol (inputData))
{
	if (!integerEqual (parts, 1))
	{
		for (p in 2:parts)
		{
			for (rI in 1:nrow (inputData))
			{
				inputData[rI,cI] <- inputData[rI,cI] + inputDatas[[p]][rI,cI]
			}
		}
	}
}

# analyse 

data <- data.frame (n = integer(), r = integer(), c = numeric (), q = integer(), max = integer())

for (cI in 2:ncol (inputData))
{
	# process
	print(cI)
	# expand data
	colData <- c ()
	for (rI in 1:nrow (inputData))
	{
		colData <- c (colData, rep (rI,inputData[rI,cI]))
	}
	# parse n, r and c
	colName <-  strsplit (colnames (inputData)[cI], "r_")
	nIndex <- as.integer(substring (colName[[1]][1], first=3))
	colName <-  strsplit (colName[[1]][2], "c_")	
	rIndex <- as.integer (colName[[1]][1])
	cIndex <- as.numeric (colName[[1]][2])

	# actual analyse
	q <- quantile (colData, 0.995)
	max <- max (colData)

	# if quantile is maxMappings than the result in incorrect
	if (!integerEqual (q, maxMappings))
	{
		data <- rbind (data, c (nIndex, rIndex, cIndex, q, max))
	}
}

colnames (data) <- c ("n", "r", "c", "q", "max")

outputFileName <- "output/optimal_mapping_benchmark.tex"

tikz(file = outputFileName, width = 4.26, height = 3.2, engine = "pdftex")

plot <- ggplot (data, aes (x = n)) +
	geom_line (aes (y = q, color="q")) +
	geom_line (aes (y = max, color="max")) +
	scale_color_manual (values = c ("q" = "black", "max" = "gray"), breaks = c ("q", "max"), labels = c ("$x_{n,0.995}$", "$max_n$")) +
	scale_x_continuous (name = "Keyset size ($n$)", breaks = seq (0, 13000, by = 100), limit = c(0,1300)) +
	scale_y_continuous (name = "hypergraphs", breaks = seq(1, 7, by = 1), limit = c(1,7)) +
	theme_bw () +
	theme(legend.position="bottom",
		panel.border = element_rect(colour = "black", fill=NA),
		legend.box.background = element_rect(colour = "black"),
		legend.title = element_blank ())

print(plot)
dev.off()
