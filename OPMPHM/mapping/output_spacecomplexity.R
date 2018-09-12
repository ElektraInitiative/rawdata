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

optC <- function (n)
{	
	c = ifelse (n < 15, 3, ifelse (n < 30, 2.45 - (n - 15) * 0.035, ifelse (n < 240, 2.35 - (n - 30) * 0.0043, ifelse (n < 1280, 2.25 - (n - 240) * 0.00086, 1.35))))
	return (c)
}


#~ int32_t * hashFunctionSeeds; \\ $r$ seeds for $f_1,\dotsc,f_r$
#~ uint8_t rUniPar; \\ actual value of $r$
#~ size_t componentSize; \\ $\lceil cn / r \rceil$
#~ size_t * graph; \\ stores the $g()$
#~ size_t size;

opmphmStore <- function (n)
{
	space <- 0
	space <- space + optR (n) * 4
	space <- space + 1
	space <- space + 8
	space <- space + ( ceiling ( n * optC (n) / optR (n) ) * optR (n) ) * 8
	space <- space + 8
	return (space/1024)
}


#~ typedef struct
#~ {
#~ 	uint32_t firstEdge;
#~ 	uint32_t degree;
#~ } OpmphmVertex;

#~ typedef struct
#~ {
#~ 	uint32_t order;
#~ 	uint32_t * nextEdge;
#~ 	uint32_t * vertices;
#~ } OpmphmEdge;

#~ OpmphmEdge * edges;
#~ OpmphmVertex * vertices;
#~ uint32_t * removeSeqence;
#~ uint32_t removeIndex;

opmphmBuild <- function (n)
{
	space <- 0
	space <- space + n * (4 + optR (n) * 4 + optR (n) * 4)
	space <- space + ( ceiling ( n * optC (n) / optR (n) ) * optR (n) ) * (4 + 4)
	space <- space + n * 4
	space <- space + 4
	return (space/1024)
}

outputFileName <- "output/space_complexity.tex"

tikz(file = outputFileName, width = 4.26, height = 3.2, engine = "pdftex")

plot <- ggplot(data.frame(x = c(1, 20000)), aes(x = x)) +
	stat_function (fun = opmphmStore, aes (color="opmphm")) +
	stat_function (fun = opmphmBuild, aes (color="graph")) +
	scale_color_manual (values = c ("opmphm" = "black", "graph" = "gray"), breaks = c ("opmphm", "graph"), labels = c ("$\\texttt{Opmphm}$", "$\\texttt{OpmphmGraph}$")) +
	scale_x_continuous (name = "Key Set size ($n$)", breaks = seq (0, 20000, by = 2000), limit = c(0,20000)) +
	scale_y_continuous (name="Memory in Kilo Byte") +
	theme_bw () +
	theme(legend.position="bottom",
		panel.border = element_rect(colour = "black", fill=NA),
		legend.box.background = element_rect(colour = "black"),
		legend.title = element_blank ())

print(plot)

dev.off()
