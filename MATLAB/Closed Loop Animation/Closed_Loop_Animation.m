    % Closed Loop Animation
    % 11/11/2019
    %   Adapted from code written by: Zack Johnson and Edward Pierce

clear all
close all
clc

dt = 0.01;                    %Integration timestep
delta_t = 4;                  %Animation timestep
t = 0:dt:40;                  %Simulation time array
b = zeros(12);                %Pre-allocate state variable for all time

%Define Desired Coordinates and Desired Joint angles
[xDes,yDes,zDes,gammad] = Meiosis_Name();
r6d = MeiosisFK(gammad(:,1));

%Define initial conditions
b(:,1) = [0;0;0;0;0;0;0;0;0;0;0;0];     %Initial position and velocity

%Define Control Parameters
tolerance = .001*ones(3,1);

jj = 1;

for ii = 1:(length(t)-1)

    gamma = b(1:6,ii);
    r6 = MeiosisFK(gamma);
    if (abs(r6(3)) < .001)
        ink(:,ii) = r6;         %Keep track of where the marker writes
        draw(ii) = 1;           %Keep track of when the marker writes
    else
        ink(:,ii) = [0;0;0];
        draw(ii) = 0;
    end
    Xe = r6 - r6d;

    if (abs(Xe) <= tolerance)
        jj = jj + 1;
        if jj > length(gammad)
            break
        end
        r6d = MeiosisFK(gammad(:,jj));
    end
    gammadMat(:,ii) = gammad(:,jj);
     
    k1 = Meiosis_robot1(b(:,ii),gammad(:,jj));
    k2 = Meiosis_robot1(b(:,ii) + k1.*dt/2,gammad(:,jj));
    k3 = Meiosis_robot1(b(:,ii) + k2.*dt/2,gammad(:,jj));
    k4 = Meiosis_robot1(b(:,ii) + k3.*dt,gammad(:,jj));
    b(:,ii+1) = b(:,ii) + dt*(k1./6 + k2./3 + k3./3 + k4./6);
    
   
end

 % Animation
x = ink(1,:);
y = ink(2,:);
%z = r6Mat(3,:);
z = zeros(size(x));

figure('Name','Closed-Loop Animation','NumberTitle','off')
ii = 1;
for jj = 1:delta_t:29%(length(b))
%for jj = (length(b)-1):length(b)
    clf(gcf)
    plot3(x(1:jj),y(1:jj),z(1:jj),'r.')
    hold on
    Meiosis_draw2(b(1:6,jj))
    F(ii) = getframe(gcf);
    pause(0.001)
    ii = ii + 1;
end

%      % Uncomment the following section to store the animation as a video
% writerObj = VideoWriter('DifferentialAnimation.avi');
% writerObj.FrameRate = 1/(dt*delta_t);
% open(writerObj);
% 
% % write the frames to the video
% for i=1:length(F)
%     writeVideo(writerObj, F(i));
% end

close(writerObj);

figure('Renderer', 'painters', 'Position', [10 100 700 700],'Name','Joint Angles vs. Time','NumberTitle','off')
Meiosis_Joint_Angle_plot(b(1:6,1:length(gammadMat)),gammadMat,t(1:length(gammadMat)),'Joint Angles vs. Time')
print('JointAnglePlot.pdf','-dpdf')