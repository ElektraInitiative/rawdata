#!/usr/bin/env Rscript

if(!require (ggplot2)) install.packages ('ggplot2', dep = TRUE, repos = "http://cran.us.r-project.org")
if(!require (tikzDevice)) install.packages ('tikzDevice', dep = TRUE, repos = "http://cran.us.r-project.org")

library (ggplot2)
library (scales)
library (grid)
library (tikzDevice)

systemId <- c (0, 1, 2)
historyLength <- c (127, 31, 7, 1)

dataFaster <-  data.frame (n = integer (), system = integer (), f = factor ())
dataSlower <-  data.frame (n = integer (), system = integer (), f = factor ())

for (h in historyLength)
{
	for (s in systemId)
	{
		print (s)

		inputData <- read.csv (sprintf ("data/system_%i/benchmark_prediction_time%i.csv", s, h) , header = TRUE, sep = ";")

		for (rI in 1:nrow (inputData))
		{
			n <- inputData[rI,1]
			predictiontime <- inputData[rI,2]
			binarytime <- inputData[rI,3]

			if (predictiontime <= binarytime)
			{
				# hybrid faster
				diff <- 1 - (predictiontime / binarytime)
				dataFaster <- rbind (dataFaster, c (n, s, diff))
			}
			else
			{
				# binary faster
				diff <- 1 - (binarytime / predictiontime)
				dataSlower <- rbind (dataSlower, c (n, s, diff))
			}
		}
	}
	colnames (dataFaster) <- c ("n","system", "fac")
	colnames (dataSlower) <- c ("n","system", "fac")

	dataFaster <- aggregate (dataFaster, by=list (dataFaster$n, dataFaster$system), FUN=function(x) mean(x))
	dataSlower <- aggregate (dataSlower, by=list (dataSlower$n, dataSlower$system), FUN=function(x) mean(x))


	colnames (dataFaster) <- c ("n","system", "oldn","oldsystem", "fac")
	colnames (dataSlower) <- c ("n","system", "oldn","oldsystem", "fac")

	dataFaster$oldn <- NULL
	dataFaster$oldsystem <- NULL
	dataSlower$oldn <- NULL
	dataSlower$oldsystem <- NULL

	# average calculation
	analyzeData0 <- subset (dataFaster, system == 0)
	analyzeData1 <- subset (dataFaster, system == 1)
	analyzeData2 <- subset (dataFaster, system == 2)
	print (sprintf ("faster history = %i system = 0 mean percentage = %f", h, mean(analyzeData0$fac)))
	print (sprintf ("faster history = %i system = 1 mean percentage = %f", h, mean(analyzeData1$fac)))
	print (sprintf ("faster history = %i system = 2 mean percentage = %f", h, mean(analyzeData2$fac)))
	analyzeData0 <- subset (dataSlower, system == 0)
	analyzeData1 <- subset (dataSlower, system == 1)
	analyzeData2 <- subset (dataSlower, system == 2)
	print (sprintf ("slower history = %i system = 0 mean percentage = %f", h, mean(analyzeData0$fac)))
	print (sprintf ("slower history = %i system = 1 mean percentage = %f", h, mean(analyzeData1$fac)))
	print (sprintf ("slower history = %i system = 2 mean percentage = %f", h, mean(analyzeData2$fac)))

	outfile <- sprintf ("output/prediction_benchmark_factor_faster_%i.tex", h)

	tikz(file = outfile, width = 4.26, height = 3.2, engine = "pdftex")

	l <- c ("i7-6700K", "i7-3517U", "1800X")
	b <- c ("0", "1", "2")

	plot <- ggplot (dataFaster, aes (x = n, y = fac, color = factor (system))) +
		geom_line (aes (linetype = factor (system))) +
		geom_point (aes (shape = factor (system))) +
		scale_shape_manual (values = c ("0" = 0, "1" = 1, "2" = 2), breaks = b, labels = l) +
		scale_linetype_manual (values = c ("0" = "solid", "1" = "solid", "2" = "solid"), breaks = b, labels = l) +
		scale_color_manual (values = c ("0" = "black", "1" = "black", "2" = "black"), breaks = b, labels = l) +
		scale_y_continuous (name = "Hybrid search faster (\\%)") +
		scale_x_continuous (name = "Keyset size ($n$)") +
		theme_bw () +
		theme(legend.position="bottom",
			panel.border = element_rect(colour = "black", fill=NA),
			legend.box.background = element_rect(colour = "black"),
			legend.title = element_blank ())

	print(plot)

	outfile <- sprintf ("output/prediction_benchmark_factor_slower_%i.tex", h)

	tikz(file = outfile, width = 4.26, height = 3.2, engine = "pdftex")

	plot <- ggplot (dataSlower, aes (x = n, y = fac, color = factor (system))) +
		geom_line (aes (linetype = factor (system))) +
		geom_point (aes (shape = factor (system))) +
		scale_shape_manual (values = c ("0" = 0, "1" = 1, "2" = 2), breaks = b, labels = l) +
		scale_linetype_manual (values = c ("0" = "solid", "1" = "solid", "2" = "solid"), breaks = b, labels = l) +
		scale_color_manual (values = c ("0" = "black", "1" = "black", "2" = "black"), breaks = b, labels = l) +
		scale_y_continuous (name = "Binary search faster (\\%)") +
		scale_x_continuous (name = "Keyset size ($n$)") +
		theme_bw () +
		theme(legend.position="bottom",
			panel.border = element_rect(colour = "black", fill=NA),
			legend.box.background = element_rect(colour = "black"),
			legend.title = element_blank ())

	print(plot)
}

dev.off()




