    % Written by Edward Pierce and Zack Johnson
    % Me 406 Project Part 1 Animate
    % Due 5/1/2019

clear all
close all
clc

dt = 0.01;                    %Integration timestep
delta_t = 10;                 %Animation timestep
t = 0:dt:10;                  %simulation time array
b = zeros(12,length(t));      %pre-allocate motor angles for all time
Va = zeros(6,length(t));      %pre-allocate input torque for all time

%Define initial conditions
b(:,1) = [0;0;0;0;0;0;0;0;0;0;0;0];     %Initial position and velocity
%Va(1,1:100) = 24;                %Input torques in the motors

for ii = 1:(length(t)-1)
    k1 = Meiosis_robot1(b(:,ii),Va(:,ii));
    k2 = Meiosis_robot1(b(:,ii) + k1.*dt/2,Va(:,ii));
    k3 = Meiosis_robot1(b(:,ii) + k2.*dt/2,Va(:,ii));
    k4 = Meiosis_robot1(b(:,ii) + k3.*dt,Va(:,ii));
    b(:,ii+1) = b(:,ii) + dt*(k1./6 + k2./3 + k3./3 + k4./6);
end
    
for ii = delta_t:delta_t:(length(b))
    meiosis_draw(b(1:7,ii))
    pause(.001)
end