close all;clear;clc

% desired orientation command
c = 512;
% load experimental data
M = csvread('512.csv',1);
% show response
plot(M(:,1),M(:,2))
title('Experimental Data')
% find % OS
os = ((max(M(:,2)) - c) / c) * 100;
% damping ratio
damp = -log(os/100) / sqrt(pi^2 + log(os/100)^2);
% from data cursor, 2928 ms is start peak is 3440
start = M(find(diff(M(:,2)) > 1, 1, 'first'),1);
% time to peak
Tp = 3424 - start;
% natural freq
wn = (pi / sqrt(1 - damp^2))/Tp;
% transfer function
G = tf(wn^2, [1 2*damp*wn wn^2])

% figure()
stepinfo(G)
