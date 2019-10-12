clear;
% Angles in Radians
syms q6
q0 = [0 0 0 0 0 0]';
T0 = TmatrixCapstone(q0);
R0 = T0(1:3, 1:3);
P0 = T0(1:3,4);
theta0 = acos((trace(R0)-1)/2);
q1 = [.1 .05 .05 .29 .29 .29]*pi/180;
% Anything below .1degree for t1 doesn't help much more
% .01 degree for t2 and t3
% t4, t5, t6 are pretty much set

T1 = TmatrixCapstone(q1);
R1 = T1(1:3, 1:3);
P1 = T1(1:3,4);
theta1 = acos((trace(R1)-1)/2);
ThetaErrorDegrees = (theta0 - theta1)*180/pi
R01 = R1*R0^-1;
thetarelative = acos((trace(R01)-1)/2)*180/pi
PositionErrorMillimeters = sqrt((P0(1)-P1(1))^2 + (P0(2)-P1(2))^2 + (P0(3)-P1(3))^2)

% Angles in Degrees
% q0 = [0 0 0 0 0 0]';
% T0 = TmatrixCapstoneDegrees(q0);
% R0 = T0(1:3, 1:3);
% P0 = T0(1:3,4);
% theta0 = acosd((trace(R0)-1)/2);
% q1 = [q6 q6 q6 q6 q6 q6];
% T1 = TmatrixCapstoneDegrees(q1);
% R1 = T1(1:3, 1:3);
% P1 = T1(1:3,4);
% theta1 = acosd((trace(R1)-1)/2);
% %k2 = (1/(2*sin(theta1)))*[R1(3,2)-R1(2,3);R1(1,3)-R1(3,1);R1(2,1)-R1(1,2)]
% % From base to end effector
% ThetaErrorDegrees = (theta0 - theta1)
% % error from desired end effector orientation to actual
% R01 = R1*R0^-1;
% thetarelative = acosd((trace(R01)-1)/2)
% PositionErrorMillimeters = sqrt((P0(1)-P1(1))^2 + (P0(2)-P1(2))^2 + (P0(3)-P1(3))^2)

