#!/usr/bin/env Rscript

if(!require (ggplot2)) install.packages ('ggplot2', dep = TRUE, repos = "http://cran.us.r-project.org")
if(!require (tikzDevice)) install.packages ('tikzDevice', dep = TRUE, repos = "http://cran.us.r-project.org")

library (ggplot2)
library (scales)
library (grid)
library (tikzDevice)

systemId <- c (0, 1, 2)

for (s in systemId)
{
	opmphmBuildInput <- read.csv (sprintf ("data/system_%i/benchmark_opmphm_build_time0.csv", s), header = TRUE, sep = ";")
	opmphmBuild <- aggregate (opmphmBuildInput, by=list (opmphmBuildInput$n, opmphmBuildInput$ks), FUN=function(x) quantile(x, 0.5))
	opmphmBuild <- aggregate (opmphmBuild, by=list (opmphmBuild$n), FUN=function(x) quantile(x, 0.5))

	colnames (opmphmBuild) <- c ("n","oldn", "oldks", "oldoldn", "ks", "time")

	opmphmBuild$oldn <- NULL
	opmphmBuild$oldks <- NULL
	opmphmBuild$oldoldn <- NULL
	opmphmBuild$ks <- NULL

	hsearchInput <- read.csv (sprintf ("data/system_%i/benchmark_hsearch_build_time0.csv", s), header = TRUE, sep = ";")
	hsearch <- aggregate (hsearchInput, by=list (hsearchInput$n, hsearchInput$load), FUN=function(x) quantile(x, 0.5))

	colnames (hsearch) <- c ("n","load", "oldn", "oldks", "oldload", "time")

	hsearch$oldn <- NULL
	hsearch$oldks <- NULL
	hsearch$oldload <- NULL

	# find max factor opmphm slower
	maxData <- aggregate (hsearch, by=list (hsearch$n), FUN=function(x) max(x))
	colnames (maxData) <- c ("n", "oldn", "oldload", "time")
	maxData$oldn <- NULL
	maxData$oldload <- NULL
	factorData <- data.frame (n = integer(), factor = numeric())
	for (rI in 1:nrow (maxData))
	{
		maxN <- maxData[rI,1]
		maxTime <- maxData[rI,2]
		opmphmN <- opmphmBuild[rI,1]
		opmphmTime <- opmphmBuild[rI,2]
		if (opmphmTime > maxTime)
		{
			fac <- 1 - (maxTime / opmphmTime)
			factorData <- rbind (factorData, c (maxN, fac))
		}
	}
	colnames (factorData) <- c ("n", "fac")
	print (sprintf ("system = %i mean percentage = %f", s, mean(factorData$fac)))

#~ 	unite data load 2 = OPMPHM
	for (rI in 1:nrow (opmphmBuild))
	{
		n <- opmphmBuild[rI,1]
		time <- opmphmBuild[rI,2]
		hsearch <- rbind (hsearch, c (n,2,time))
	}

	outfile <- sprintf ("output/opmphm_compare_%i.tex", s)

	tikz(file = outfile, width = 4.26, height = 3.2, engine = "pdftex")

	b <- c (2, 1, 0.75, 0.5, 0.25)
	l <- c ("OPMPHM", "hsearch $\\alpha = 1$", "hsearch $\\alpha = 0.75$", "hsearch $\\alpha = 0.5$", "hsearch $\\alpha = 0.25$")

	if (s != 1)
	{
		plot <- ggplot (hsearch, aes (x = n, y = time, color = factor (load))) +
			geom_line (aes (linetype = factor (load))) +
			scale_linetype_manual (values = c ("2" = "solid", "1" = "dotted", "0.75" = "dotdash", "0.5" = "dashed", "0.25" = "solid"), breaks = b, labels = l) +
			scale_color_manual (values = c ("2" = "gray", "1" = "black", "0.75" = "black", "0.5" = "black", "0.25" = "black"), breaks = b, labels = l) +
			scale_x_continuous (name = "Keyset size ($n$)", breaks = seq (0, 20000, by = 2000), limit = c(0,20000)) +
			scale_y_continuous (name = "time (microseconds)") +
			theme_bw () +
			theme(legend.position=c(0.2, 0.75),
				panel.border = element_rect(colour = "black", fill=NA),
				legend.box.background = element_rect(colour = "black"),
				legend.title = element_blank ())
	}
	else
	{
		plot <- ggplot (hsearch, aes (x = n, y = time, color = factor (load))) +
			geom_line (aes (linetype = factor (load))) +
			scale_linetype_manual (values = c ("2" = "solid", "1" = "dotted", "0.75" = "dotdash", "0.5" = "dashed", "0.25" = "solid"), breaks = b, labels = l) +
			scale_color_manual (values = c ("2" = "gray", "1" = "black", "0.75" = "black", "0.5" = "black", "0.25" = "black"), breaks = b, labels = l) +
			scale_x_continuous (name = "Keyset size ($n$)", breaks = seq (0, 30000, by = 3000), limit = c(0,30000)) +
			scale_y_continuous (name = "time (microseconds)") +
			theme_bw () +
			theme(legend.position=c(0.2, 0.75),
				panel.border = element_rect(colour = "black", fill=NA),
				legend.box.background = element_rect(colour = "black"),
				legend.title = element_blank ())
	}

	print(plot)
}

dev.off()
