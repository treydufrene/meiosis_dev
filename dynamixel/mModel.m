% dynamixel motor model experiment

close all;clear;clc

% test loads mass moments of inertia
m = [.146 .088 0.108];          % mass (kg)
b = [.61277 .37227 0.28257];    % length (m)
h = [.01915 0.01915 0.0299];    % height (m)
J = (1/12)*m.*(h.^2 + b.^2);

% path to csv files relative to script
datapath = 'data/AX12A/';
files = dir(strcat(datapath,'*.csv'));
numFiles = length(files);
% initialize variables
[damp, wn, Tp] = deal(zeros(numFiles,1));

for ii = 1:numFiles
    % load experimental data, skip 5 header lines
        M = csvread(strcat(datapath, files(ii).name),5,0);
    % clean data by removing outliers
        nani = (find(diff(M(:,1)) > 100));
        M(nani,:) = [];
    % show response
        figure();
        plot(M(:,1),M(:,2))
        title('Experimental Data')
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
        Tp(ii) = M(peaki,1) - start;
    % natural frequency
        wn(ii) = pi / (sqrt(1 - damp(ii)^2)*Tp(ii));
end

sol = zeros(4,1);
% no load case, 2*zeta*omega_n
sol(1) = 2*mean(damp(end-2:end))*mean(wn(end-2:end));
% no load case, omega_n^2
sol(2) = mean(wn(end-2:end))^2;

% obtain average damping ratio and natural frequencies for load cases
zeta = [mean(damp(1:3));mean(damp(4:6));mean(damp(7:9))];
omegan = [mean(wn(1:3));mean(wn(4:6));mean(wn(7:9))];

alpha = 2.*zeta.*omegan;
beta = omegan.^2;
A = zeros(3,2);
b = zeros(3,1);

for jj = 1:3
    A(jj,:) = [1, -(alpha(jj)*J(jj) + beta(jj)*J(jj))];
    b(jj) = alpha(jj) + beta(jj);
end

sol(3:4) = A \ b;















