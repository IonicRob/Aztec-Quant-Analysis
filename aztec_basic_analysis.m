% for this code to work you need to export the composition as wt%
%first do a trumap, then a quant map -> export h5iona file (right click on
%the site you want, it saves automatically into a new folder)

%make sure to predefine the colours you want in Aztec
%the longer you leave your map the better this code works!

% Written by Rebecca Tearle with help from Rob Scales and Phani 
clc
close all
clear
clearvars
addpath src
addpath Colormaps % from https://uk.mathworks.com/matlabcentral/fileexchange/51986-perceptually-uniform-colormaps
% stuff to add:
% get the pie chart to remove labels <1%
%% user inputs
%input the file path for the h5 file
h5_file="C:\Users\mans3428\Downloads\EDS 04112024 Specimen 1 Site 1 Map Data 1\EDS 04112024 Specimen 1 Site 1 Map Data 1.h5oina";
%input the file path of where you would like the figures to be saved
output_file_directory="C:\Users\mans3428\OneDrive - Nexus365\PostDoc\Group\James Bignell";
%convert to atomic: "yes" or "no"

%image without colour bar as png "yes" or "no" - this saves the raw output
%without a colour bar (and the k-means clustered image if you have
%selected
%this)
no_colour_bar_image="no";

%smoothing of data "yes" or "no" - for other functionality this must be
%done in at% 
smoothing="yes";

%smoothing types
%Info about decision: 

% try them all? yes/no
all_smoothing="no";

%know your fave? (0) I want them all, (1) MedFilt (median filter), 
% (2) Wiener, (3) Combine, 
fave_filter=1;

%smoothing size - this must be an odd number greater than or equal to 3. The larger the
%number, the more the image is smoothed. I recommend starting at 3 and
%increasing only if necessary.
smoothing_size=3;

%% Reading the file and creating file extensions
basicMap = EDXMap;
basicMap.file = h5_file;
basicMap = basicMap.setupMap;
basicMap = basicMap.getWindowInterval;

basicMap.plotMap("O")
basicMap.plotMap("Cr")
% imagesc(uint8(basicMap.windowIntervalData.O)); axis image;

seMap = SEMap;
seMap.file = h5_file;
seMap = seMap.setupMap;

figure;
imagesc(seMap.SE), axis image; colormap gray;
