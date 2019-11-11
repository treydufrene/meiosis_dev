% dynamixel motor model experiment

close all;clear;clc

% test loads mass moments of inertia
m = [1 .146 .088];       % mass (kg)
b = [1 .61277 .37227];   % length (m)
h = [1 .01915 0.01915];     % height (m)
% moment of inertia about z'
J = (1/12)*m.*(h.^2 + b.^2);

% path to csv files relative to script
datapath = 'data/AX12A/';
files = dir(strcat(datapath,'*.csv'));
numFiles = length(files);
% initialize variables
[damp, wn] = deal(zeros(numFiles,1));

for ii = 1:numFiles
    % load experimental data, skip 5 header lines
        M = csvread(strcat(datapath, files(ii).name),5,0);
    % show response
%         figure();
%         plot(M(:,1),M(:,2))
%         title('Experimental Data')
    % find % OS
        peak = max(M(:,2));                        % peak value
        peaki = find(M(:,2)==peak, 1, 'first');    % peak value index
        ss = M(end,2);                             % steady state 
        os = ((peak - ss) / ss) * 100;             % % OS
    % damping ratio
        damp(ii) = -log(os/100) / sqrt(pi^2 + log(os/100)^2);
    % find where the motor begins responding
        start = M(find(diff(M(:,2)) > 1, 1, 'first'), 1);
    % time to peak
        Tp = M(peaki,1) - start;
    % natural frequency
        wn(ii) = pi / (sqrt(1 - damp(ii)^2)*Tp);
end

damp = [mean(damp(1:2));mean(damp(3:4));mean(damp(5:6))];
wn = [mean(wn(1:2));mean(wn(3:4));mean(wn(5:6))];

a = 2.*damp.*wn;
b = wn.^2;
A = zeros(3,2);
B = zeros(3,1);
for jj = 1:3
    A(jj,:) = [1, -(a(jj)*J(jj) + b(jj)*J(jj))];
    B(jj) = a(jj) + b(jj);
end

ls = rref(cat(2,A.'*A,A.'*B));

one = a(end);
two = b(end);
three = ls(1,3);
four = ls(2,3);

syms thetaddot thetadot theta thetad tau

eqn = (1/four) * thetaddot + (one/four)*thetadot - (two/four)*theta + (two/four)*thetad == tau


% transfer function
%     G = tf(wn(ii)^2, [1 2*damp(ii)*wn(ii) wn(ii)^2])
% [u,t] = gensig('square',2,10,0.1)
% lsim(G,u,t)

% figure()
% step(G)
% stepinfo(G)















