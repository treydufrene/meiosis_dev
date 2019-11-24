function [xDes,yDes,zDes,thetad] = Meiosis_HI()

%Define Desired Workspace Coordinates
xDes = [-50,-50,-50,-50,  0,  0,  0,  0,  0, 50, 50, 50, 50, 50];
yDes = [300,350,400,350,350,400,350,300,300,300,300,350,400,400];
zDes = [  0,  0,  0,  0,  0,  0,  0,  0, 10, 10,  0,  0,  0, 10];

R = rotx(-pi/2);


%Calculate Joint Angles
for ii = 1:length(xDes)
    [thetad(:,ii),errorCheck] = MeiosisIK([xDes(ii);yDes(ii);zDes(ii)],R);
    if errorCheck == 1
        break
    end
end