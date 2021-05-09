%% Fast Stereo Disparity Estimator
% Function "disparity_processor.m"
%% Description:
% Process disparity map from the two image matrices:
% {x-gradient, y-gradient, grayscale image}.
%% Input:
% im_l - left image matrix,
% im_r - right image matrix,
% win - window size,
% max_dis - maimum distance,
% weight - gradient mean weight.
%
%% Output:
% disparity - disparity map.
function disparity = disparity_processor(im_l, im_r, win, max_dis, weight)
% input shape
[x,y,z]=size(im_l);

% params
min2_dis=Inf(x,y);
disparity=zeros(x,y);

for i=1:max_dis
    % baseline
    min3_dis=zeros(x,y,z);
    
    % decomposition
    min3_dis(:,i:y,:)=(im_l(:,i:y,:)-im_r(:,1:y-i+1,:)).^2;
    min3_dis(:,1:i,:)=(im_l(:,1:i,:)-0.000000000000001).^2;
    
    % mean gradients
    flat_dis=min3_dis(:,:,1)+weight.*(min3_dis(:,:,2)+min3_dis(:,:,3));
    
    % box filter
    if (win > 1)
        box=ones(win,win);
        flat_dis=conv2(flat_dis,box,'same');
    end
    
    % mapping
    ind=find(flat_dis<min2_dis);
    disparity(ind)=i;
    min2_dis(ind)=flat_dis(ind);
end

% median filter
if (win > 1)
    disparity=medfilt2(disparity, [win win]);
end

% convert to image
disparity=normalize(disparity./max_dis);
disparity=uint8(disparity);
end

