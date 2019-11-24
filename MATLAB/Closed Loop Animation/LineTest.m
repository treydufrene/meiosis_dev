function thetad = LineTest()

% %Define Desired Workspace Coordinates
% xDes(1:100) = -50;
% yDes(1:100) = 301:400;
% 
% xDes(101:150) = -50;
% yDes(101:150) = 399:-1:350;
% 
% xDes(151:200) = -49:0;
% yDes(151:200) = 350;
% 
% xDes(201:250) = 0;
% yDes(201:250) = 351:400;
% 
% xDes(251:350) = 0;
% yDes(251:350) = 400:-1:301;
% 
% xDes(351:400) = 1:50;
% yDes(351:400) = 300;
% 
% xDes(401:500) = 50;
% yDes(401:500) = 301:400;
% %zDes = zeros(1,length(xDes));

%Define Desired Workspace Coordinates
xDes = -50:.001:50;
yDes = 350*ones(1,length(xDes));
zDes = zeros(1,length(xDes));

R = rotx(-pi/2);


%Calculate Joint Angles
for ii = 1:length(xDes)
    [thetad(:,ii),errorCheck] = MeiosisIK([xDes(ii);yDes(ii);zDes(ii)],R);
    if errorCheck == 1
        break
    end
end