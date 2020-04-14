% Checks inverse kinematics to verify MEIOSIS robot has the correct
%   dextrous workspace.

clear all
close all
clc

%define resolutions and constants
xres = 28/15;                   %Cartesion resolution in x direction
tres = 15;                  %Rotational resolution
rInner = 7;                %Inner radius of dexterous workspace
rOuter = rInner + 28;                %Outer radius of dexterous workspace
theta = linspace(0,90,91);  %Elevation angle
L = rInner:xres:rOuter;     %Line of points to check
errorPos = zeros(3,length(L),length(theta));
desPos = zeros(3,length(L),length(theta));

for jj = 1:length(theta)
    %Define desired cartesion end effector positions
    desX = cosd(theta(jj)).*L;
    desY = zeros(1,length(desX));
    desZ = sind(theta(jj)).*L + 16.15;

    %Iterate through all positions and orientations
    count = 1;
    for ii = 1:length(desX)
        for tx = deg2rad(0:tres:180)
            for tz = deg2rad(0:tres:360)
                desR = rotz(tz)*rotx(tx);
                desPos(:,ii,jj) = [desX(ii);desY(ii);desZ(ii)];
                [gamma{count},error] = MeiosisIK2(desPos(:,ii,jj),desR);
                if error == 1
                    errorPos(:,ii,jj) = [desX(ii);desY(ii);desZ(ii)];
                    break
                else
                    count = count + 1;
                end
            end
            if error == 1
                break
            end
        end
        if error == 1
            count = count + 1;
        end  
    end
    if error == 0
        gammaM(:,:,jj) = cell2mat(gamma);
        for ii = 1:6
            jointMin(ii) = rad2deg(min(gammaM(ii,:,jj)));
            jointMax(ii) = rad2deg(max(gammaM(ii,:,jj)));
        end
        limits(:,:,jj) = [jointMin;jointMax];
    end
end

%Determine the maximum and minimum joint angle requirements
for ii = 1:6
    totalJointLimits(1,ii) = min(limits(1,ii,:));
    totalJointLimits(2,ii) = max(limits(2,ii,:));
end
totalJointLimits

%Error plot
figure(1)
axis equal
axis([-3 52 20 75])
hold on
title('MEIOSIS Dexterous Workspace')
xlabel('x [cm]')
ylabel('z [cm]')

for jj = 1:length(theta)
    for ii = 1:length(L)
        plot(desPos(1,ii,jj),desPos(3,ii,jj),'b.');
        plot(errorPos(1,ii,jj),errorPos(3,ii,jj),'r.');
        
    end
end

pd = plot(0,0,'b.');
pe = plot(0,1,'r.');
pd.DisplayName = 'Dexterous';
pe.DisplayName = 'Not Dexterous';
legend([pd;pe],'Location','northeast')

print('DexterityWithOffset.pdf','-dpdf')
% 
% % Uncomment to animate
% for ii = 1:length(gamma)
%     meiosis_draw(gamma{ii})
%     hold on
%     plot3(desX,desY,desZ,'r.')
%     pause(0.01)
% end

