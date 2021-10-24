#!/usr/bin/perl
# ***********************
# *  histogram_plot.pl  *
# ***********************
#
# usage: histogram_plot LABEL meta_file min max size
#
# Where:
# LABEL is a... label which will defined the output files.
# meta_file is a file similar to the input file of WHAM. Only the first column is read.
# min is the minimal value for the histogram generation (i.e. min of reaction coordinate)
# max is the maximal value for the histogram generation (i.e. max of reaction coordinate)
# size is the desired length of the histograms 
#
# There are two output files: LABEL.dat and LABEL.gnu ; The first will contain all the
# values whereas the other one is a script for getting an visualization.
#
# Florent Barbault october 2020
$| = 1;
use strict;
use Math::Trig;
#-----------------------------------------------------------------------------------------------------------------------------
# Get the input arguments and declarations
#
my $LABEL=$ARGV[0];
my $meta_file=$ARGV[1];
my $min=$ARGV[2];
my $max=$ARGV[3];
my $size=$ARGV[4];
my $Fichier="";
my $data="";
my $script="";
my @t=();
my @tv=();
my @val=();
my @Fichier_output=();
my $i=0;
my $f=0;
my $j=0;
my $end=0;
my $fich=0;
my $end_plus_one=0;
my $frame=0;
my $count=0;
my $script="";
my $image_histo="";
print "Usage: histogram_plot.pl LABEL meta_file min max size\n";
#-----------------------------------------------------------------------------------------------------------------------------
# Open the meta_file and get the data
#
{
	print "Open the meta file and make histogram computations\n";
	$data=$LABEL.".dat";
	open (FILE_INPUT, "< $meta_file");
	while (<FILE_INPUT>)
	{
		@t = split(' ',$_);
		$Fichier=$t[0]; #print "\n Open $Fichier";
		$Fichier_output[$fich]=$Fichier.".HIST";
		$i=0;
		print ".";
		open (FOUT, ">$Fichier_output[$fich]");
		open(FILE, "<$Fichier");
		while (<FILE>)
		{
			@tv = split(' ',$_);
			$val[$i]=$tv[1];
			$i=$i+1;
		}
		close(FILE);
		$end=$i;
		for ($j=$min;$j<=$max;$j=$j+$size)
		{
			$count=0;
			for ($i=0;$i<$end;$i++)
			{
				if ($val[$i] >= $j)
				{
					if ($val[$i] < $j+$size)
					{
						$count=$count+1;
					}
				}
			}
			print FOUT "$j $count\n";
		}
		close (FOUT);
		$f=$f+1;
		$fich=$fich+1;
	}
	close(FILE_INPUT);
	print "You have $f simulations of $end frames \n";
}
#-----------------------------------------------------------------------------------------------------------------------------
# Create a Gnuplot script file and image
#
{
	print "Creation of a gnuplot script file\n";
	$script=$LABEL.".gnuplot";
	open (FSCRIPT, "> $script");
	$image_histo=$LABEL."-histogram.png";
	print FSCRIPT "unset key\n";
	print FSCRIPT "set title \"$LABEL Histograms\"\n";
	print FSCRIPT "set xlabel \"Reaction coordinate\" \n";
	print FSCRIPT "set ylabel \"Population\" \n";
	print FSCRIPT "set term png enhanced size 1500,1500 font \"arial,20\"\n";
	print FSCRIPT "set output \"$image_histo\"\n";
	print FSCRIPT "plot \"$Fichier_output[0]\" u 1:2 w li,\\\n";
	for ($i=1;$i<$fich;$i++)
	{
		print FSCRIPT " \"$Fichier_output[$i]\" u 1:2 w li,\\\n";
	}
	print FSCRIPT "\n";
	close(FSCRIPT);
	print "Gnuplot generation of an image\n";
	system ("gnuplot < $script");
	print "Done, the file $image_histo has been created\n";
}


