% a & b (array of double): shelving filter transfer function coefficients
% Fs: sampling frequency
% G (double): gain
% fc (int): cutoff frequency
% type (char): can be 'b' for bass or 't' for treble

function [b, a]  = shelving(Fs, G, fc, type)
K = tan((pi * fc) / Fs);
V = 10 ^ (G / 20);

% invert the gain for a cut
if (V < 1)
    V = 1 / V;
end

% case: bass boost
if (( G > 0 ) && (strcmp(type, 'b')))
    b0 = (1 + sqrt(V) * sqrt(2) * K + V * K ^ 2) / (1 + sqrt(2) * K + K ^ 2);
    b1 = (2 * (V * K ^ 2 - 1)) / (1 + sqrt(2) * K + K ^ 2);
    b2 = (1 - sqrt(V) * sqrt(2)* K + V * K ^ 2) / (1 + sqrt(2) * K + K ^ 2);
    a1 = (2 * (K ^ 2 - 1)) / (1 + sqrt(2) * K + K ^ 2);
    a2 = (1 - sqrt(2) * K + K ^ 2) / (1 + sqrt(2) * K + K ^ 2);

% case: bass cut
elseif (( G < 0 ) && (strcmp(type, 'b')))
    b0 = (1 + sqrt(2) * K + K ^ 2) / (1 + sqrt(2) * sqrt(V) * K + V * K ^ 2);
    b1 = (2 * (K ^ 2 - 1)) / (1 + sqrt(2) * sqrt(V) * K + V * K ^ 2);
    b2 = (1 - sqrt(2) * K + K ^ 2) / (1 + sqrt(2) * sqrt(V) * K + V * K ^ 2);
    a1 = (2 * (V * K ^ 2 - 1)) / (1 + sqrt(2) * sqrt(V) * K + V * K ^ 2);
    a2 = (1 - sqrt(2) * sqrt(V) * K + V * K ^ 2) / (1 + sqrt(2) * sqrt(V) * K + V * K ^ 2);

% case: treble boost
elseif (( G > 0 ) && (strcmp(type, 't')))
    b0 = (V + sqrt(2) * sqrt(V) * K + K ^ 2) / (1 + sqrt(2) * K + K ^ 2);
    b1 = (2 * (K ^ 2 - V)) / (1 + sqrt(2) * K + K ^ 2);
    b2 = (V - sqrt(2) * sqrt(V) * K + K ^ 2) / (1 + sqrt(2) * K + K ^ 2);
    a1 = (2 * (K ^ 2 - 1)) / (1 + sqrt(2) * K + K ^ 2);
    a2 = (1 - sqrt(2) * K + K ^ 2) / (1 + sqrt(2) * K + K ^ 2);

% case: treble cut
elseif (( G < 0 ) && (strcmp(type, 't')))
    b0 = (1 + sqrt(2) * K + K ^ 2) / (V + sqrt(2) * sqrt(V) * K + K ^ 2);
    b1 = (2 * (K ^ 2 - 1) ) / (V + sqrt(2) * sqrt(V) * K + K ^ 2);
    b2 = (1 - sqrt(2) * K + K ^ 2) / (V + sqrt(2) * sqrt(V) * K + K ^ 2);
    a1 = (2 * ((K ^ 2) / V - 1)) / (1 + sqrt(2) / sqrt(V) * K + (K ^ 2) / V);
    a2 = (1 - sqrt(2) / sqrt(V) * K + (K ^ 2) / V) / (1 + sqrt(2) / sqrt(V) * K + (K ^ 2) / V);

% case: G = 0
else
    b0 = V;
    b1 = 0;
    b2 = 0;
    a1 = 0;
    a2 = 0;
end

% returns
a = [1, a1, a2];
b = [b0, b1, b2];
