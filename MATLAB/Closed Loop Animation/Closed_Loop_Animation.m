    % Closed Loop Animation
    % 11/11/2019
    %   Adapted from code written by: Zack Johnson and Edward Pierce

clear all
close all
clc

dt = 0.01;                    %Integration timestep
delta_t = 10;                 %Animation timestep
t = 0:dt:10;                  %simulation time array
b = zeros(12,length(t));      %pre-allocate motor angles for all time
Va = zeros(6,length(t));      %pre-allocate input torque for all time

%Define Desired Joint angles
gammad = Meiosis_HI();
r6d = MeiosisFK(gammad(:,1));

%Define initial conditions
b(:,1) = [gammad(:,1);0;0;0;0;0;0];     %Initial position and velocity
%Va(1,1:100) = 24;                %Input torques in the motors

%Define Control Parameters
Ts = 0.02;
T_Last = -Ts;
zeta = 1;
wn = 7;
Kp = -wn^2*eye(6);
Kd = -2*zeta*wn*eye(6);
tolerance = .001*ones(3,1);

jj = 1;
for ii = 1:(length(t)-1)
    if (t(ii) - T_Last) >= Ts
        gamma = b(1:6,ii);
        gammadot = b(7:12,ii);
        r6 = MeiosisFK(gamma);
        %gammad(:,ii) = (pi/5)*t(ii)*ones(6,1);
        Xe = r6 - r6d; 
        if (abs(Xe) <= tolerance)
            jj = jj + 1;
            r6d = MeiosisFK(gammad(:,jj));
        end
        gammadotd = zeros(6,1);
        gammaddotd = zeros(6,1);
        gammae = gamma - gammad(:,jj);
        gammadote = gammadot - gammadotd;
        [H,d,G] = Meiosis_HdG(gamma,gammadot);
        u = Kp*gammae + Kd*gammadote + gammaddotd;
        %va = Rm*(H*u + d + G) + Cm*sign(gammadot) + Bm*gammadot;
        va = H*u + d + G;
        T_Last = t(ii);
    else
        %gammad(:,ii) = gammad(:,ii-1);
    end
 
    Va(:,ii) = va;
    
    k1 = Meiosis_robot1(b(:,ii),Va(:,ii));
    k2 = Meiosis_robot1(b(:,ii) + k1.*dt/2,Va(:,ii));
    k3 = Meiosis_robot1(b(:,ii) + k2.*dt/2,Va(:,ii));
    k4 = Meiosis_robot1(b(:,ii) + k3.*dt,Va(:,ii));
    b(:,ii+1) = b(:,ii) + dt*(k1./6 + k2./3 + k3./3 + k4./6);
end
    
figure(1)
for ii = delta_t:delta_t:(length(b))
    Meiosis_draw2(b(1:6,ii))
    pause(.001)
end

%figure('Renderer', 'painters', 'Position', [10 100 700 700])
%Meiosis_Joint_Angle_plot(b(1:6,1:end-1),gammad,t(1:end-1),'Computed Torque Trajectory Tracking Joint-Space Control')