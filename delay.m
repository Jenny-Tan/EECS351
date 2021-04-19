% y (array of double): output signal in the t-domain
% x (array of double): input signal in the t-domain
% Fs (int): sample rate of the input signal
% delay (double): delay time in seconds
% gain (double): amplitude multiplier

function [y] = delay(x, Fs, delay, gain)
x = x(:, 1);
% number of samples to delay based on total audio length in seconds
time = length(x) / Fs;
n = length(x) / time * delay;

% create, fill, and apply a gain to the shifted signal
y = zeros(length(x) + n, 1);
y(1 + n : length(x) + n) = x;
y = gain .* y;

% sum and normalize the original signal with the delayed version
y(1 : length(x)) = x + y(1 : length(x));
y = y ./ max(abs(y));