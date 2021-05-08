%% Fast Stereo Disparity Estimator
% Function "normalize.m"
%% Description:
% Normalizes input disparity matrix.
%% Input:
% x - input disparity.
%
%% Output:
% y - output disparity.
function y = normalize(x)
maximum=max(max(x));
minimum=min(min(x));
y = 255.*(x-minimum)./(maximum-minimum);
end

