%% Fast Stereo Disparity Estimator
% Function "disparity_estimator.m"
%% Description:
% Disparity estimator function.
%% Input:
% im_l - left image,
% im_r - right image,
% win - window size,
% max_dis - maimum distance,
% weight - gradient mean weight.
%
%% Output:
% disparity - disparity map.
function disparity = disparity_estimator(im_ol, im_or, win, max_dis, weight)
% input shape
[x,y,~]=size(im_ol);

% gradients
[gra_l_x, gra_l_y]=gradient(double(im_ol));
[gra_r_x, gra_r_y]=gradient(double(im_or));

% matrices
im_l=zeros(x,y,3);
im_r=zeros(x,y,3);

im_l(:,:,1)=im_ol;
im_r(:,:,1)=im_or;
im_l(:,:,2)=gra_l_x;
im_r(:,:,2)=gra_r_x;
im_l(:,:,3)=gra_l_y;
im_r(:,:,3)=gra_r_y;

% make disparity map
disparity=disparity_processor(im_l,im_r,win,max_dis,weight);
end
