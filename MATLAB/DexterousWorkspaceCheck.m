% Checks inverse kinematics to verify MEIOSIS robot has the correct
%   dextrous workspace.

clear all
close all
clc

%define resolutions and constants
xres = .1;               %Cartesion resolution in x direction
tres = 4;               %Rotational resolution
eOff = [0;0;5.25];      %End effector offset in cm
theta = linspace(0,90,91);
L = 19:xres:47;

for jj = 1:length(theta)
    %Define desired cartesion end effector positions
    desX = cosd(theta(jj)).*(19:xres:47);
    desY = zeros(1,length(desX));
    desZ = sind(theta(jj)).*(19:xres:47) + 22.08;
    % desY = 19:xres:47;
    % desX = zeros(1,length(desY));
    % desZ = 22.08*ones(1,length(desX));

    %Iterate through all positions and orientations
    count = 1;
    for ii = 1:length(desX)
        for tx = deg2rad(0:tres:180)
            for tz = deg2rad(0:tres:360)
                desR = rotz(tz)*rotx(tx);
                desPos = [desX(ii);desY(ii);desZ(ii)];
                gamma{count} = MeiosisIK2(desPos,desR);
                if gamma{ii} == 'error'
                    fprintf('Error: Joint angles could not be found');
                    break
                else
                    count = count + 1;
                end
            end
            if gamma{ii} == 'error'
                break
            end
        end
        if gamma{ii} == 'error'
            break
        end
    end

    gammaM = cell2mat(gamma);

    for ii = 1:6
        jointMin(ii) = rad2deg(min(gammaM(ii,:)));
        jointMax(ii) = rad2deg(max(gammaM(ii,:)));
    end

    limits(:,:,jj) = [jointMin;jointMax];
end

% Uncomment to animate
% for ii = 1:length(gamma)
%     meiosis_draw(gamma{ii})
%     hold on
%     plot3(desX,desY,desZ,'r.')
%     pause(0.01)
% end

