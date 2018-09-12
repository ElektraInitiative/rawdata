#!/usr/bin/env Rscript

if(!require (ggplot2)) install.packages ('ggplot2', dep = TRUE, repos = "http://cran.us.r-project.org")
if(!require (tikzDevice)) install.packages ('tikzDevice', dep = TRUE, repos = "http://cran.us.r-project.org")

library (ggplot2)
library (scales)
library (grid)
library (tikzDevice)

systemId <- c (0, 1, 2)
historyLength <- c (127, 31, 7, 1)

data <-  data.frame (n = integer (), system = integer (), b = factor ())

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

			if (predictiontime < binarytime)
			{
				data <- rbind (data, c (n, s, 1))
			}
			else
			{
				data <- rbind (data, c (n, s, 0))
			}
		}
	}
	colnames (data) <- c ("n","system", "better")

	data <- aggregate (data, by=list (data$n, data$system), FUN=function(x) mean(x))

	colnames (data) <- c ("n","system", "oldn","oldsystem", "better")

	data$oldn <- NULL
	data$oldsystem <- NULL

	# average calculation
	analyzeData0 <- subset (data, system == 0)
	analyzeData1 <- subset (data, system == 1)
	analyzeData2 <- subset (data, system == 2)
	print (sprintf ("history = %i system = 0 mean percentage = %f", h, mean(analyzeData0$better)))
	print (sprintf ("history = %i system = 1 mean percentage = %f", h, mean(analyzeData1$better)))
	print (sprintf ("history = %i system = 2 mean percentage = %f", h, mean(analyzeData2$better)))

	outfile <- sprintf ("output/prediction_benchmark_%i.tex", h)

	tikz(file = outfile, width = 4.26, height = 3.2, engine = "pdftex")

	l <- c ("i7-6700K", "i7-3517U", "1800X")
	b <- c ("0", "1", "2")

	plot <- ggplot (data, aes (x = n, y = better, color = factor (system))) +
		geom_line (aes (linetype = factor (system))) +
		geom_point (aes (shape = factor (system))) +
		scale_shape_manual (values = c ("0" = 0, "1" = 1, "2" = 2), breaks = b, labels = l) +
		scale_linetype_manual (values = c ("0" = "solid", "1" = "solid", "2" = "solid"), breaks = b, labels = l) +
		scale_color_manual (values = c ("0" = "black", "1" = "black", "2" = "black"), breaks = b, labels = l) +
		scale_y_continuous (name = "\\% cases hybrid search faster") +
		scale_x_continuous (name = "Keyset size ($n$)") +
		theme_bw () +
		theme(legend.position="bottom",
			panel.border = element_rect(colour = "black", fill=NA),
			legend.box.background = element_rect(colour = "black"),
			legend.title = element_blank ())

	print(plot)

	outfile <- sprintf ("output/prediction_benchmark_zoom_%i.tex", h)

	tikz(file = outfile, width = 4.26, height = 3.2, engine = "pdftex")

	l <- c ("i7-6700K", "i7-3517U", "1800X")
	b <- c ("0", "1", "2")

	plot <- ggplot (data, aes (x = n, y = better, color = factor (system))) +
		geom_line (aes (linetype = factor (system))) +
		geom_point (aes (shape = factor (system))) +
		scale_shape_manual (values = c ("0" = 0, "1" = 1, "2" = 2), breaks = b, labels = l) +
		scale_linetype_manual (values = c ("0" = "solid", "1" = "solid", "2" = "solid"), breaks = b, labels = l) +
		scale_color_manual (values = c ("0" = "black", "1" = "black", "2" = "black"), breaks = b, labels = l) +
		scale_y_continuous (name = "\\% cases hybrid search faster") +
		scale_x_continuous (name = "Keyset size ($n$)",  limits = c(0, 1250)) +
		theme_bw () +
		theme(legend.position="bottom",
			panel.border = element_rect(colour = "black", fill=NA),
			legend.box.background = element_rect(colour = "black"),
			legend.title = element_blank ())

	print(plot)
}

dev.off()




