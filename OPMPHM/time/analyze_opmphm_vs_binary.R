#!/usr/bin/env Rscript

if(!require (ggplot2)) install.packages ('ggplot2', dep = TRUE, repos = "http://cran.us.r-project.org")
if(!require (tikzDevice)) install.packages ('tikzDevice', dep = TRUE, repos = "http://cran.us.r-project.org")

library (ggplot2)
library (scales)
library (grid)
library (tikzDevice)

optR <- function (n)
{
	r = ifelse (n < 15, 6, ifelse (n < 30, 5, ifelse (n < 240, 4, 3)))
	return (r)
}

shapeIds <- c (0, 1, 2, 3, 4, 5, 7)
systemId <- c (0, 1, 2)

data <-  data.frame (n = integer (), system = integer (), k = integer (), shape = integer ())

for (shapeI in shapeIds)
{
	print (shapeI)

	for (s in systemId)
	{
		binarySearchData <- read.csv (sprintf ("data/system_%i/benchmark_binary_search_time%i.csv", s, shapeI), header = TRUE, sep = ";")

		opmphmBuildInput <- read.csv (sprintf ("data/system_%i/benchmark_opmphm_build_time%i.csv", s, shapeI), header = TRUE, sep = ";")
		opmphmBuild <- aggregate (opmphmBuildInput, by=list (opmphmBuildInput$n, opmphmBuildInput$ks), FUN=function(x) quantile(x, 0.5))
		opmphmBuild <- aggregate (opmphmBuild, by=list (opmphmBuild$n), FUN=function(x) quantile(x, 0.5))

		opmphmSearchData <- read.csv (sprintf ("data/system_%i/benchmark_opmphm_search_time%i.csv", s, shapeI), header = TRUE, sep = ";")

		# add build times to search times
		for (rI in 1:nrow (opmphmSearchData))
		{
			time <- opmphmBuild[rI,6]
			for (cI in 2:ncol (opmphmSearchData))
			{
				opmphmSearchData[rI,cI] <- time + opmphmSearchData[rI,cI]
			}
		}

		for (rI in 1:nrow (binarySearchData))
		{
			nI <- binarySearchData[rI, 1]
			valueFound <- 0
			for (cI in 2:ncol (binarySearchData))
			{
				searchI <- as.integer (strsplit (colnames (binarySearchData)[cI], "_")[[1]][2])
				# binary search more expensive as opmphm
				if (binarySearchData[rI,cI] > opmphmSearchData[rI,cI])
				{
					data <- rbind (data, c (nI, s, searchI, shapeI))
					valueFound <- 1
					break
				}
			}
			if (valueFound == 0)
			{
				print (sprintf ("no value found sys = %i n = %i max opmphmSearchInput = %i binaryInput = %i", s, nI, opmphmSearchData[rI, ncol (opmphmSearchData)],
				binarySearchData[rI, ncol (binarySearchData)]))
			}
		}
	}

}


colnames (data) <- c ("n","system", "k", "shapeI")

data <- aggregate (data, by=list (data$n, data$system), FUN=function(x) mean(x))

data$n <- NULL
data$system <- NULL
data$shapeI <- NULL

colnames (data) <- c ("n","system", "k")

# add heuristic lines
maxSystem <- tail (systemId, n = 1)
for (nI in seq (50, 19550, by = 500))
{
	r <- optR (nI);
	f0 <- (nI + 3 * nI * r) / log2 (nI);
	data <- rbind (data, c (nI, maxSystem + 1, f0))

	f1 <- nI + 5000
	data <- rbind (data, c (nI, maxSystem + 2, f1))
}

outfile <- "output/opmphm_vs_binary_benchmark.tex"

tikz(file = outfile, width = 4.26, height = 3.2, engine = "pdftex")

l <- c ("i7-6700K", "i7-3517U", "1800X", "$(n + 3nr) / log_2(n)$", "$n + 5000$")
b <- c ("0", "1", "2", "3", "4")

plot <- ggplot (data, aes (x = n, y = k, color = factor (system))) +
	geom_line (aes (linetype = factor (system))) +
	geom_point (aes (shape = factor (system))) +
	scale_shape_manual (values = c ("0" = 0, "1" = 1, "2" = 2, "3" = 12, "4" = 13), breaks = b, labels = l) +
	scale_linetype_manual (values = c ("0" = "solid", "1" = "solid", "2" = "solid", "3" = "dotted", "4" = "dotted"), breaks = b, labels = l) +
	scale_color_manual (values = c ("0" = "black", "1" = "black", "2" = "black", "3" = "gray", "4" = "gray"), breaks = b, labels = l) +
	scale_x_continuous (name = "Keyset size ($n$)") +
	scale_y_continuous (name = "number of searches ($k$)") +
	theme_bw () +
	theme(legend.position=c(0.2, 0.75),
			panel.border = element_rect(colour = "black", fill=NA),
			legend.box.background = element_rect(colour = "black"),
			legend.title = element_blank ())

print(plot)

dev.off()
