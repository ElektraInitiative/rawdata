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

optR <- function (n)
{
	r = ifelse (n < 15, 6, ifelse (n < 30, 5, ifelse (n < 240, 4, 3)))
	return (r)
}

labelFunction <- function (n)
{
	return (paste(n,optR(n),sep = "\n"))
}

#~ max Mapping invocations
maxMappings <- 10

#~ load data

parts <- c (0, 1, 3, 3, 3, 3, 3)
rUinPar <- 3:7

inputDatas <- list()

for (r in rUinPar)
{
	inputDataPart <- list()
	for (p in 1:parts[r])
	{
		inputDataPart[[p]] <- read.csv (sprintf ("data_mapping_benchmark/benchmark_opmphm_mapping%i_%i.csv", r, p), header = TRUE, sep = ";")
	}
	inputDatas[[r]] <- inputDataPart
}

# merge
for (r in rUinPar)
{
	if (!integerEqual (parts[r], 1))
	{
		for (p in 2:parts[r])
		{
			for (cI in 2:ncol (inputDatas[[r]][[1]]))
			{
				for (rI in 1:nrow (inputDatas[[r]][[1]]))
				{
					inputDatas[[r]][[1]][rI,cI] <- inputDatas[[r]][[1]][rI,cI] + inputDatas[[r]][[p]][rI,cI]
				}
			}
		}
	}
}

# analyse
data <- data.frame (n = integer(), c = numeric(), r = integer(), costs = integer(), q = integer())
id <- 0
# all have same n but not c
cValues <- list ()
nValues <- list ()

for (r in rUinPar)
{
	# process
	print (r)
	cValues[[r]] <- list()
	for (cI in 2:ncol (inputDatas[[r]][[1]]))
	{
		# expand data
		colData <- c ()
		for (rI in 1:nrow (inputDatas[[r]][[1]]))
		{
			colData <- c (colData, rep (rI,inputDatas[[r]][[1]][rI,cI]))
		}
		# parse n and c
		colName <-  strsplit (colnames (inputDatas[[r]][[1]])[cI], "c_")
		nIndex <- as.integer(substring (colName[[1]][1], first=3))
		cIndex <- as.numeric(colName[[1]][2])
		# save c and n
		if (!nIndex %in% nValues)
		{
			nValues[[length(nValues) + 1]] <- nIndex
		}
		if (!cIndex %in% cValues[[r]])
		{
			cValues[[r]][[length(cValues[[r]]) + 1]] <- cIndex
		}

		# actual analyse
		q <- quantile (colData, 0.995)

		# if quantile is maxMappings than the result in incorrect
		if (!integerEqual (q, maxMappings))
		{
			data <- rbind (data, c (nIndex, cIndex, r, nIndex * r * q, q))
		}
	}
}

colnames (data) <- c ("n", "c", "r", "costs", "q")

dataMin <- lapply(lapply(split(data,data$n),function(chunk) chunk[order(chunk$c),]),function(chunk) chunk[which.min(chunk$costs),])
dataAll <- lapply(lapply(split(data,data$n),function(chunk) chunk[order(chunk$c),]),function(chunk) chunk[order(chunk$costs),])

#~ print (dataAll)
#~ print (dataMin)

# extract a new data frame, based on the opmphmOptR(R)
drawData <- subset (data, (r == 6 & n <= 15) | (r == 5 & n >= 15 & n <= 30) | (r == 4 & n >= 30 & n <= 240) | (r == 3 & n >= 240))

# move interval end to not intercept other interval start
for (i in 1:nrow (drawData))
{
	# drawData[i,1] = n
	# drawData[i,3] = r
	if (integerEqual (drawData[i,3], 6) & integerEqual (drawData[i,1], 15))
	{
		drawData[i,1] <- drawData[i,1] - 2
	}
	# log scale overlaps
	if (integerEqual (drawData[i,3], 5) & integerEqual (drawData[i,1], 30))
	{
		drawData[i,1] <- drawData[i,1] - 4
	}
	if (integerEqual (drawData[i,3], 4) & integerEqual (drawData[i,1], 240))
	{
		drawData[i,1] <- drawData[i,1] - 30
	}
}

lineData0 <- data.frame(x=10, xend=15, y=3, yend=3)
lineData1 <- data.frame(x=15, xend=30, y=2.45, yend=1.95)
lineData2 <- data.frame(x=30, xend=240, y=2.35, yend=1.45)
lineData3 <- data.frame(x=240, xend=1280, y=2.25, yend=1.35)

outputFileName <- "output/all_mapping_benchmark.tex"

tikz(file = outputFileName, width = 4.8, height = 4, engine = "pdftex")

plot <- ggplot (drawData, aes (y = c, x = n)) +
	geom_point (show.legend = FALSE, size=5, color="black") +
	geom_point (aes (color = factor (q,ordered=TRUE)), show.legend = FALSE, size=4.5) +
	scale_color_grey (start=1, end=0.1) +
	geom_text (aes(label=q), size=3) +
	geom_segment(data=lineData0, aes(x=x, xend=xend, y=y, yend=yend), size=1) +
	geom_segment(data=lineData1, aes(x=x, xend=xend, y=y, yend=yend), size=1) +
	geom_segment(data=lineData2, aes(x=x, xend=xend, y=y, yend=yend), size=1) +
	geom_segment(data=lineData3, aes(x=x, xend=xend, y=y, yend=yend), size=1) +
	scale_x_continuous (name = "n\nr", trans = "log2", breaks = unlist (unique (nValues)), labels = labelFunction) +
#~  	scale_y_continuous (name = "c", breaks = round(seq(min(unlist(cValues)), max(unlist(cValues)), by = 0.1),2) +
 	scale_y_continuous (name = "c") +
	theme_classic ()

print(plot)
dev.off()
