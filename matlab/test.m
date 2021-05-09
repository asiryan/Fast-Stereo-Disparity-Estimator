%% Fast Stereo Disparity Estimator
% Function "test.m"
%% Description:
% Test script for making disparity map from the stereo pair.
%% Input stereo pair of images
im_ol=rgb2gray(imread('images/left.png'));
im_or=rgb2gray(imread('images/right.png'));

%% Disparity filter
win=10;
max_dis=50;
weight=5;

tic;
im_dm = disparity_estimator(im_ol, im_or, win, max_dis, weight);
toc;

%% Show result
figure(1);
imshow(im_dm);
title('disparity map');