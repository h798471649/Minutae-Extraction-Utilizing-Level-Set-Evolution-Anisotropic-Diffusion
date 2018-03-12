% Date: 2/8/2018
% Finger print image analysis

%% Clean Workspace
clc;
clear all;
close all;

directory = pwd;
addpath(genpath('./'));
% run c functions for optimized edge enhancement
run_cfunctions;
%% Read and Process Image
Iz = im2double(imread('Images/f0002_05.png'));

figure; imshow(Iz);

I = Iz;
%% apply anistropic edge enhancement algorithm
JS = CoherenceFilter(I,struct('T',15,'rho',10,'Scheme','S', 'eigenmode',0));
JN = CoherenceFilter(I,struct('T',15,'rho',10,'Scheme','N', 'eigenmode',1));
JR = CoherenceFilter(I,struct('T',15,'rho',10,'Scheme','R', 'eigenmode',2));
JI = CoherenceFilter(I,struct('T',15,'rho',10,'Scheme','I', 'eigenmode',3));
JO = CoherenceFilter(I,struct('T',15,'rho',10,'Scheme','O', 'eigenmode',4));
figure, 
subplot(2,3,1), imshow(I), title('Before Filtering');
subplot(2,3,2), imshow(JI), title('Standard Scheme');
subplot(2,3,3), imshow(JN), title('Non Negative Scheme');
subplot(2,3,4), imshow(JS), title('Implicit Scheme');
subplot(2,3,5), imshow(JR), title('Rotation Invariant Scheme');
subplot(2,3,6), imshow(JO), title('Optimized Scheme');

%% Image set analysis

im = edge(I, 'canny');
im_js = edge(JS, 'canny');
im_jn = edge(JN, 'canny');
im_jr = edge(JR, 'canny');
im_ji = edge(JI, 'canny');
im_jo = edge(JO, 'canny');

figure, 
subplot(2,3,1), imshowpair(im, im_js , 'ColorChannels', 'red-cyan'), title('standard Scheme');
subplot(2,3,2), imshowpair(im, im_jn , 'ColorChannels', 'red-cyan'), title('Non Negative Scheme');
subplot(2,3,3), imshowpair(im, im_jr , 'ColorChannels', 'red-cyan'), title('Rotation Invariant Scheme');
subplot(2,3,4), imshowpair(im, im_ji , 'ColorChannels', 'red-cyan'), title('Implicit Scheme');
subplot(2,3,5), imshowpair(im, im_jo , 'ColorChannels', 'red-cyan'), title('Optimized Scheme');

% Thin images edges
I = bwmorph(im, 'thin', Inf);
JO = bwmorph(im_jo, 'thin', Inf);
figure;imshowpair(JO,im, 'ColorChannels', 'red-cyan');


%% extract minutae
imm1 = MinutaieExtraction(I);
imm2 = MinutaieExtraction(JO);
% display images
figure; imshowpair(imm1, imm2, 'montage'), title('Minutae Extraction');
%% Extract Minutae from the original image and the anisotropic image
% display differences

im = levelSet(Iz,Iz);
%%
immm = edge(imsharpen(im), 'canny');
figure; imshow(immm);
immm = bwmorph(immm, 'thin', Inf);
immm = MinutaieExtraction(immm);
figure; imshowpair(imm1, immm, 'montage'), title('Minutae Extraction');





