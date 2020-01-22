    % Circle Animation Test
    % 1/15/2020
    %   Adapted from code written by: Zack Johnson and Edward Pierce

clear all
close all
clc

dt = 0.01;                    %Integration timestep
delta_t = 50;                 %Animation timestep
t = 0:dt:10;                  %Simulation time array
b = zeros(12,1);                %Pre-allocate state variable for all time

%Define Desired Coordinates and Desired Joint angles
%[xDes,yDes,zDes,gammad] = Meiosis_Name();
[rd, rdotd, rddotd] = Circle_path();
[gammad, gammadotd, gammaddotd] = MeiosisIK2(rd,rdotd,rddotd,rotx(-pi/2));
b(1:6,1) = gammad(:,1);
r6d = MeiosisFK(gammad(:,1));

%Define initial conditions
%b(:,1) = [0;0;0;0;0;0;0;0;0;0;0;0];     %Initial position and velocity

%Define Control Parameters
tolerance = .001*ones(3,1);

jj = 1;

for ii = 1:(length(t)-1)

    gamma = b(1:6,ii);
    r6 = MeiosisFK(gamma);
%     if (abs(r6(3)) < .001)
%         ink(:,ii) = r6;         %Keep track of where the marker writes
%         draw(ii) = 1;           %Keep track of when the marker writes
%     else
%         ink(:,ii) = [0;0;0];
%         draw(ii) = 0;
%     end
    Xe = r6 - r6d;

%     if (abs(Xe) <= tolerance)
%         jj = jj + 1;
%         if jj > length(gammad)
%             break
%         end
%         r6d = MeiosisFK(gammad(:,jj));
%     end
    jj=ii;
%     gammadMat(:,ii) = gammad(:,jj);
%     gammadotdMat(:,ii) = gammadotd(:,jj);
%     gammaddotdMat(:,ii) = gammaddotd(:,jj);
     
    k1 = Meiosis_robot2(b(:,ii),gammad(:,jj),gammadotd(:,jj),gammaddotd(:,jj));
    k2 = Meiosis_robot2(b(:,ii) + k1.*dt/2,gammad(:,jj),gammadotd(:,jj),gammaddotd(:,jj));
    k3 = Meiosis_robot2(b(:,ii) + k2.*dt/2,gammad(:,jj),gammadotd(:,jj),gammaddotd(:,jj));
    k4 = Meiosis_robot2(b(:,ii) + k3.*dt,gammad(:,jj),gammadotd(:,jj),gammaddotd(:,jj));
    b(:,ii+1) = b(:,ii) + dt*(k1./6 + k2./3 + k3./3 + k4./6);
    
   
end

%  % Animation
% x = ink(1,:);
% y = ink(2,:);
% %z = r6Mat(3,:);
% z = zeros(size(x));
% 
% figure('Name','Closed-Loop Animation','NumberTitle','off')
% ii = 1;
% for jj = 1:delta_t:(length(b))
% %for jj = (length(b)-1):length(b)
%     clf(gcf)
%     plot3(x(1:jj),y(1:jj),z(1:jj),'r.')
%     hold on
%     Meiosis_draw2(b(1:6,jj))
%     F(ii) = getframe(gcf);
%     pause(0.001)
%     ii = ii + 1;
% end

%      % Uncomment the following section to store the animation as a video
% writerObj = VideoWriter('DifferentialAnimation.avi');
% writerObj.FrameRate = 1/(dt*delta_t);
% open(writerObj);
% 
% % write the frames to the video
% for i=1:length(F)
%     writeVideo(writerObj, F(i));
% end
%close(writerObj);

figure('Renderer', 'painters', 'Position', [10 100 700 700],'Name','Joint Angles vs. Time','NumberTitle','off')
Meiosis_Joint_Angle_plot(b(1:6,1:length(gammad)),gammad,t(1:length(gammad)),'Joint Angles vs. Time')
%print('JointAnglePlot.pdf','-dpdf')

%figure;plot(ink(1,:),ink(2,:))