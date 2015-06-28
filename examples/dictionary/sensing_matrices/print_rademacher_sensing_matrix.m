% This script plots the Rademacher sensing matrices generated by
% ex_generate_sample_sensing_matrices.m script. 
% Please run the dependencies before running this script.

%% Initialization code
clear all; close all; clc;
% Let us load sample Rademacher sensing matrices
load('bin/radamacher_sensing_matrices.mat');

[numMatrices, numSets] = size(radamacherSensingMatrices);

% We pickup the first set
phis = radamacherSensingMatrices(:, 1);
SPX_Figures.full_screen_figure;
for i=1:numMatrices
    % We pickup the matrix
    phi  = phis{i};
    % We get its size
    [M, N]  = size(phi);
    % We draw the matrix
    subplot(111);
    imagesc(phi) ;
    colormap(gray);
    axis image;
    xlabel(sprintf('\\Phi [%dx%d]', M, N));
    pause;
end