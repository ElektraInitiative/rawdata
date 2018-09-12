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

args <- commandArgs (trailingOnly = TRUE)

if (length (args) < 1) {
  stop ("OPMPHMR_PARTITE and PARTS missing")
}

#~ max Mapping invocations
maxMappings <- 10

#~ load parts
parts <- c (0, 1, 3, 3, 3, 3, 3)
rUinPar <- as.integer (args[1])

inputDatas <- list()

for (i in 1:parts[rUinPar])
{
	inputDatas[[i]] <- read.csv (sprintf ("data_mapping_benchmark/benchmark_opmphm_mapping%i_%i.csv", rUinPar, i), header = TRUE, sep = ";")
}

# merge

inputData <- inputDatas[[1]]

for (cI in 2:ncol (inputData))
{
	if (!integerEqual (parts[rUinPar], 1))
	{
		for (p in 2:parts[rUinPar])
		{
			for (rI in 1:nrow (inputData))
			{
				inputData[rI,cI] <- inputData[rI,cI] + inputDatas[[p]][rI,cI]
			}
		}
	}
}

# analyse 

data <- data.frame (n = integer(), c = numeric(), q = integer())
nValues <- list ()
cValues <- list ()

for (cI in 2:ncol (inputData))
{
	# expand data
	colData <- c ()
	for (rI in 1:nrow (inputData))
	{
		colData <- c (colData, rep (rI,inputData[rI,cI]))
	}
	# parse n and c
	colName <-  strsplit (colnames (inputData)[cI], "c_")
	nIndex <- as.integer(substring (colName[[1]][1], first=3))
	cIndex <- as.numeric(colName[[1]][2])
	# save c and n
	nValues <- append (nValues, nIndex)
	cValues <- append (cValues, cIndex)

	# actual analyse
	q <- quantile (colData, 0.995)

	# if quantile is maxMappings than the result in incorrect
	if (!integerEqual (q, maxMappings))
	{
		data <- rbind (data, c (nIndex,cIndex,q))
	}
}

colnames (data) <- c ("n", "c", "q")

outputFileName <- sprintf ("output/mapping_benchmark_%i.tex", rUinPar)

tikz(file = outputFileName, width = 4.26, height = 3.2, engine = "pdftex")

plot <- ggplot (data, aes (y = c, x = n)) +
	geom_point (show.legend = FALSE, size=5, color="black") +
	geom_point (aes (color = factor (q,ordered=TRUE)), show.legend = FALSE, size=4.5) +
	scale_color_grey (start=1, end=0.25) +
	geom_text (aes(label=q), size=3) +
	scale_x_continuous (name = "Keyset size ($n$)", trans = "log2", breaks = unlist (unique (nValues))) +
	scale_y_continuous (name = "c", breaks = round(seq(min(unlist(cValues)), max(unlist(cValues)), by = 0.1),2)) +
	theme_bw ()

print(plot)
dev.off()
