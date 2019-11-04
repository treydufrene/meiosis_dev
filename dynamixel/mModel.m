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
% find where the motor begins responding
start = M(find(diff(M(:,2)) > 1, 1, 'first'), 1);
% time to peak
Tp = 3424 - start;
% natural frequency
wn = (pi / sqrt(1 - damp^2))/Tp;

G = tf(wn^2, [1 2*damp*wn wn^2])

% [u,t] = gensig('square',2,10,0.1)
% lsim(G,u,t)

% figure()
% step(G)
% stepinfo(G)
