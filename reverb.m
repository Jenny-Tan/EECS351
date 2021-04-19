% y (array of double): output signal in the t-domain
% x (array of double): input signal in the t-domain
% Fs (int): sample rate of the input signal

function [y] = reverb(x, Fs, pre_delay_amount, pre_delay_gain, comb_delays, comb_gain, ap_delay, ap_gain, reverb_gain, er_gain, direct_gain, dbs)
% pre delay
x_pre_delay = pre_delay(x, Fs, pre_delay_amount, pre_delay_gain, dbs);

% comb filter in parallel
comb1_out = combFilter(x_pre_delay, Fs, comb_delays(1), comb_gain, dbs);
comb2_out = combFilter(x_pre_delay, Fs, comb_delays(2), comb_gain, dbs);
comb3_out = combFilter(x_pre_delay, Fs, comb_delays(3), comb_gain, dbs);
comb4_out = combFilter(x_pre_delay, Fs, comb_delays(4), comb_gain, dbs);
comb5_out = combFilter(x_pre_delay, Fs, comb_delays(5), comb_gain, dbs);
comb6_out = combFilter(x_pre_delay, Fs, comb_delays(6), comb_gain, dbs);

% add up the comb filter outputs
comb_out = comb1_out + comb2_out + comb3_out + comb4_out + comb5_out + comb6_out;

% all-pass filter
reverb_out = allpassFilter(comb_out, Fs, ap_delay, ap_gain, dbs);

x = x./max(x);
x_pre_delay = x_pre_delay ./ max(x_pre_delay);
reverb_out = reverb_out ./ max(reverb_out);
y = direct_gain .* x + er_gain .* x_pre_delay + reverb_gain .* reverb_out;

y = y / max(y);
