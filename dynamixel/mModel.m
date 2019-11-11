close all;clear;clc

numFiles = 1;
% Initialize Variables
[damp, wn] = deal(zeros(numFiles,1));

for ii = 1:numFiles
    % load experimental data
    M = csvread(strcat('AX12A_LOAD1_', num2str(ii),'.csv'),5,0);
    % show response
    figure();
    plot(M(:,1),M(:,2))
    title('Experimental Data')
    % find % OS
    peak = max(M(:,2));
    peaki = find(M(:,2)==peak);
    ss = M(end,2);
    os = ((peak - ss) / ss) * 100;
    % damping ratio
    damp(ii) = -log(os/100) / sqrt(pi^2 + log(os/100)^2);
    % find where the motor begins responding
    start = M(find(diff(M(:,2)) > 1, 1, 'first'), 1);
    % % time to peak
    Tp = M(peaki,1) - start;
    % % natural frequency
    wn(ii) = (pi / sqrt(1 - damp(ii)^2))/Tp;

    G = tf(wn(ii)^2, [1 2*damp(ii)*wn(ii) wn(ii)^2])
end

% test load 1
m = .146;       % mass (kg)
b = .61277;     % length (m)
h = .01915;     % height (m)
% moment of inertia about z'
Iz = (1/12)*m*(h^2 + b^2);




% [u,t] = gensig('square',2,10,0.1)
% lsim(G,u,t)

% figure()
% step(G)
% stepinfo(G)















