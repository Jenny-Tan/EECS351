clear all; close all;
[wave, Fs] = audioread('Mozart.wav');

% bass boost parameters
G = 30;
bass_boost_fc = 600;
type = 'l';

% get the coefficients and use filter to generate desired output
[b, a] = shelving(Fs, G, bass_boost_fc, type);
y_bass_boost = filter(b, a, wave);

% normalize the output signal and write to file
y_bass_boost = y_bass_boost ./ max(abs(y_bass_boost));
audiowrite('Mozart Low Boost.wav', y_bass_boost, Fs);

% bass cut parameters
G = -30;
bass_cut_fc = 600;
type = 'l';

% get the coefficients and use filter to generate desired output
[b, a] = shelving(Fs, G, bass_cut_fc, type);
y_bass_cut = filter(b, a, wave);

% normalize the output signal and write to file
y_bass_cut = y_bass_cut ./ max(abs(y_bass_cut));
audiowrite('Mozart Low Cut.wav', y_bass_cut, Fs);

% treble boost parameters
G = 30;
treble_boost_fc = 2400;
type = 'h';

% get the coefficients and use filter to generate desired output
[b, a] = shelving(Fs, G, treble_boost_fc, type);
y_treble_boost = filter(b,a, wave);

% normalize the output signal and write to file
y_treble_boost = y_treble_boost ./ max(abs(y_treble_boost));
audiowrite('Mozart High Boost.wav', y_treble_boost, Fs);

% treble cut parameters
G = -30;
treble_cut_fc = 2400;
type = 'h';

% get the coefficients and use filter to generate desired output
[b, a] = shelving(Fs, G, treble_cut_fc, type);
y_treble_cut = filter(b,a, wave);

% normalize the output signal and write to file
y_treble_cut = y_treble_cut ./ max(abs(y_treble_cut));
audiowrite('Mozart High Cut.wav', y_treble_cut, Fs);

wavefft = fft(wave);
wavefft = abs(wavefft);
wavefft = wavefft ./ max(abs(wavefft));

tbfft = fft(y_treble_boost);
tbfft = abs(tbfft);
tbfft = tbfft ./ max(abs(tbfft));

bbfft = fft(y_bass_boost);
bbfft = abs(bbfft);
bbfft = bbfft ./ max(abs(bbfft));

tcfft = fft(y_treble_cut);
tcfft = abs(tcfft);
tcfft = tcfft ./ max(abs(tcfft));

bcfft = fft(y_bass_cut);
bcfft = abs(bcfft);
bcfft = bcfft ./ max(abs(bcfft));

subplot(3,2,1)
plot(wavefft(1 : 700000));
title('Input')
xlabel('Frequency')
ylabel('Magnitude (Normalized)')

subplot(3,2,3)
plot(tbfft(1 : 700000));
title('High Boost')
xlabel('Frequency')
ylabel('Magnitude (Normalized)')

subplot(3,2,4)
plot(tcfft(1 : 700000));
title('High Cut')
xlabel('Frequency')
ylabel('Magnitude (Normalized)')

subplot(3,2,5)
plot(bbfft(1 : 700000));
title('Low Boost')
xlabel('Frequency')
ylabel('Magnitude (Normalized)')

subplot(3,2,6)
plot(bcfft(1 : 700000));
title('Low Cut')
xlabel('Frequency')
ylabel('Magnitude (Normalized)')