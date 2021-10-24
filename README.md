# histogram_plot
Usage: histogram_plot.pl LABEL meta_file min max size

This software aims to create histogram plots from several data files of windows generated through umbrella sampling simulation. This software generates an image with the help of the gnuplot free software. This last is available on:
http://www.gnuplot.info/

Usage: histogram_plot.pl LABEL meta_file min max size

Where:
- LABEL is a... label which will defined the output files.
- meta_file is a file similar to the input file of WHAM. Only the first column is read.
- min is the minimal value for the histogram generation (i.e. min of reaction coordinate)
- max is the maximal value for the histogram generation (i.e. max of reaction coordinate)
- size is the desired length of the histograms 

Two output files are generated: LABEL.dat and LABEL.gnu ; The first will contain all the values whereas the other one is a script for gnuplot visualization.

Florent Barbault october 2020.

If you use this software please cite:
Theoretical and Experimental Elucidation of the Adsorption Process of a Bioinspired Peptide on Mineral Surfaces
J. Touzeau, M. Seydou, F. Maurel, L. Tallet, A. Mutschler, P. Lavalle, and F. Barbault
Langmuir 2021, 37, 38, 11374–11385
