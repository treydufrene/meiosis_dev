    % Closed Loop Animation
    % 11/11/2019
    %   Adapted from code written by: Zack Johnson and Edward Pierce

clear all
close all
clc

dt = 0.01;                    %Integration timestep
delta_t = 5;                  %Animation timestep
t = 0:dt:10;                  %simulation time array
b = zeros(12);      %pre-allocate motor angles for all time

%Define Desired Coordinates and Desired Joint angles
[xDes,yDes,zDes,gammad] = Meiosis_HI();
r6d = MeiosisFK(gammad(:,1));

%Define initial conditions
b(:,1) = [0;0;0;0;0;0;0;0;0;0;0;0];     %Initial position and velocity

%Define Control Parameters
tolerance = .001*ones(3,1);

jj = 1;
kk = 1;
drawStart = 0;

for ii = 1:(length(t)-1)

    gamma = b(1:6,ii);
    r6 = MeiosisFK(gamma);
    Xe = r6 - r6d;

    if (abs(Xe) <= tolerance)
        jj = jj + 1;
%         if drawStart == 0
%             drawIndex = ii;
%         end
        drawStart = 1;
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
    
    if drawStart == 1
        [r6Mat(:,kk),~] = MeiosisFK(b(1:6,ii));
        kk = kk + 1;
    end
end
    
 % Animation
x = r6Mat(1,:);
y = r6Mat(2,:);
z = r6Mat(3,:);

figure('Name','Closed-Loop Animation','NumberTitle','off')
ii = 1;
%for jj = 1:delta_t:(length(b))
for jj = 86:1:87
    clf(gcf)
    plot3(x,y,z,'r.')
    hold on
    Meiosis_draw2(b(1:6,jj))
%     if abs(z(jj)) < 0.001 
         
%     end
    F(ii) = getframe(gcf);
    pause(0.001)
    %drawnow
    ii = ii + 1;
end

% writerObj = VideoWriter('animation.avi');
% writerObj.FrameRate = 20;
% open(writerObj);
% 
% % write the frames to the video
% for i=1:length(F)
%     writeVideo(writerObj, F(i));
% end
% 
% close(writerObj);

figure('Renderer', 'painters', 'Position', [10 100 700 700],'Name','Joint Angles vs. Time','NumberTitle','off')
Meiosis_Joint_Angle_plot(b(1:6,1:length(gammadMat)),gammadMat,t(1:length(gammadMat)),'Joint Angles vs. Time')
print('JointAnglePlot.pdf','-dpdf')