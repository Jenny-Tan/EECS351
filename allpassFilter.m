% y (array of double): output signal in the t-domain
% x (array of double): input signal in the t-domain
% Fs (int): sample rate of the input signal
% delay (double): desired delay time in seconds
% gain (double): desired amplitude gain ( < 0 )

function [y] = allpassFilter(x, Fs, delay, gain, delay_by_second)
% number of samples to delay based on total audio length in seconds
if delay_by_second
    m = Fs * delay;
else
    m = delay;
end

% generate the coefficients for the filter
b = zeros(m + 1, 1);
b(1) = -1 * gain; b(m + 1) = 1;
a = zeros(m + 1, 1);
a(1) = 1; a(m + 1) = -1 * gain;

% zero-pad the input signal
% x_in = zeros(length(x) + m, 1);
% x_in(1: length(x)) = x;

% send the signal into 1-D filter
y = filter(b, a, x);