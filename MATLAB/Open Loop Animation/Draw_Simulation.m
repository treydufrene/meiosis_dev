% MEIOSIS Open-Loop Animation
%
% Created 10/28/2019

clear all
close all
clc

%Define Desired Workspace Coordinates
xDes(1:100) = -50;
yDes(1:100) = 301:400;

xDes(101:150) = -50;
yDes(101:150) = 399:-1:350;

xDes(151:200) = -49:0;
yDes(151:200) = 350;

xDes(201:250) = 0;
yDes(201:250) = 351:400;

xDes(251:350) = 0;
yDes(251:350) = 400:-1:301;

xDes(351:400) = 1:50;
yDes(351:400) = 300;

xDes(401:500) = 50;
yDes(401:500) = 301:400;
zDes = zeros(1,length(xDes));
R = rotx(-pi/2);


%Calculate Joint Angles
for ii = 1:500
    [gamma(:,ii),errorCheck] = MeiosisIK([xDes(ii);yDes(ii);0],R);
    if errorCheck == 1
        break
    end
end

%Animate
if errorCheck == 1
    error('Joint angles cannot be determined.')
else
    for ii = 1:10:500
        meiosis_draw(gamma(:,ii))
        hold on
        plot3(xDes(1:ii),yDes(1:ii),zDes(1:ii),'r.')
        pause(.001)
    end
end

