% function [gamma] = meiosisIK(od, phid, qc)
    
    % INPUT
    % o = Desired Position (mm)
    % phi = Desired Orientation (Euler Angles, radians)
    % q0 = Starting Angles (radians)
    
    % OUTPUT
    % q = angles for desired orientation and position (degrees)
    % posErr = magnitude of position error
    % oriErr = magnitude of orientation error
    
%     phid = phi;     % Desired orientation
%     od = o;         % Desired position
% od = [...
%    48.2500;...
%     1.0000;...
%    22.0800];
%     qc = q0;        % Current angles
% qc = [0;0;0;0;0;0];


clear;close all;clc
[od, phid, qc] = meiosisFK([pi/2;pi/2;pi/2;pi/2;pi/2;pi/2]);

    iterMax = 200;  % Max number of iteration
    dt = 0.05;      % Time interval
    
%     gains
    Kp = 3*eye(3);
    Ko = 3*eye(3);
    K = [Kp         zeros(3);
         zeros(3)   Ko];
     
    [Nd, Ed] = quat(phid);
    posErr = zeros(3, 200);
    oriErr = zeros(3, 200);
    
    for i = 1:iterMax
        
        [oc, phic] = currentPO(qc);
        [Nc, Ec] = quat(phic);

        J = meiosisJ(qc);
        
        posErr(:,i) = od - oc;
        oriErr(:,i) = (-Nd)*Ec + Nc*Ed - cross(Ed,Ec);
        error = [posErr(:,i); oriErr(:,i)];
        qc = qc + dt * (J^(-1)) * K*error

        if ((norm(posErr(:,i)) < 1e-10) && (norm(oriErr(:,i)) < 1e-10))
            break;
        end
    end
    gamma = qc
% end