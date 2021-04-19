function [y] = pre_delay(x, Fs, delay, gain, delay_by_second)
% number of samples to delay based on total audio length in seconds
if delay_by_second
    m = Fs * delay;
else
    m = delay;
end

% generate the coefficients for the delay filter

b = [zeros(1, m) gain];
a = [1 zeros(1, m)];

N = 18;
y = x;
% apply 18 delays to the original signal and add each of them to the output
for i = 1:N
   x = filter(b, a, x); 
   y = y + x;
end
