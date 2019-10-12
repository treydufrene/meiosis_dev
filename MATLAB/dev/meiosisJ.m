close all;clear;clc

l1 = 8 + 14.08;
l2 = 25;
l3 = 28;
l4 = 5.25;
offset = -1.54;

% Joint Rotations (theta):
q = [0;pi/2;0;0;0;0];
theta1 = q(1);
theta2 = q(2);
theta3 = q(3);
theta4 = q(4);
theta5 = q(5);
theta6 = q(6);

%Relative Positions:
rBfromI = [0;       0;       0];
r1fromB = [0;       0;       8]; % base is 8 cm tall
r2from1 = [0;    -1.54;  14.08]; % link 1 is 13.33 tall and displaced by 1.54 cm in the neg. y-direction
r3from2 = [0;       25;      0]; % link 2 is 25 cm long
r4from3 = [0;       20;      0]; % link 3 is 20 cm long
r5from4 = [0;       0;       8]; % distance from 1st wrist coor. frame to 2nd is 8 cm
r6from5 = [0;       0;       0]; % no distance between 2nd and 3rd
r7from6 = [0;       0;    5.25]; % dist. from 3rd wrist coor. frame to the end effector is 5.25 cm

%Orientations wrt I:     
T1 = rotz(theta1);
T2 = T1*rotx(theta2)*roty(pi/2);
T3 = T2*rotz(theta3);
T4 = T3*roty(theta4)*rotx(-pi/2);
T5 = T4*roty(theta5);
T6 = T5*rotz(theta6);

%Positions wrt I:
rB = rBfromI;
r1 = rB + r1fromB;
r2 = r1 + T1*r2from1;
r3 = r2 + T2*r3from2;
r4 = r3 + T3*r4from3;
r5 = r4 + T4*r5from4;
r6 = r5 + T5*r6from5;

% Constant manip offsets:
qA    = [pi/2;     0; pi/2;      0;   0;  0];
d     = [  l1;     0;    0;     l3;   0; l4];
a     = [offset; l2;    0;     0;    0; 0];
alpha = [pi/2;     0; pi/2; -pi/2; pi/2;  0];

% Computations
for i = 1:6
    A(:,:,i) = rotzh(q(i) + qA(i)) * transzh(d(i)) * transxh(a(i)) * rotxh(alpha(i)); 
end

T(:,:,1) = A(:,:,1);
z(1:3,1) = T(1:3,3,1);
o(1:3,1) = T(1:3,4,1);

for i = 1:5
    T(:,:,i+1) = T(:,:,i)*A(:,:,i+1);
    z(1:3,i+1) = T(1:3,3,i+1);
    o(1:3,i+1) = T(1:3,4,i+1);
end

% Desired Orientation:
R = [...
   0.0000    1.0000    0.0000;...
    0.0000   0.0000    1.0000;...
    1.0000    0.0000   0.0000];
% Desired EE XYZ:
od = [0.0000;...
      56.7100;...
      22.0800];
% od = od + [0;1.54;0];

% Wrist Center:
oc = od - d(6)*R*[0;0;1];
% oc = oc - R*[0;1.54;0];
xc = oc(1);
yc = oc(2);
zc = oc(3);

t1 = atan2(yc,xc) + pi;

xc = xc + 1.54*cos(t1);
yc = yc - 1.54*sin(t1);

D = (xc^2 + yc^2 + (zc - (l1))^2 - l2^2 - l3^2) / (2*l2*l3);
t3 = atan2(sqrt(abs(1-D^2)),D);
t2 = atan2(zc-l1,sqrt(xc^2 + yc^2)) - atan2(l3*sin(t3),l2 + l3*cos(t3));

r03 = [cos(t1)*cos(t2+t3), -cos(t1)*sin(t2+t3), sin(t1);...
       sin(t1)*cos(t2+t3), -sin(t1)*sin(t2+t3), -cos(t1);...
       sin(t2+t3), cos(t2+t3), 0];

r36 = r03.'*R;

% Inverse Orientation
t4 = atan2(cos(t1)*cos(t2+t3)*R(1,3)+sin(t1)*cos(t2+t3)*R(2,3)+sin(t2+t3)*R(3,3),-cos(t1)*sin(t2+t3)*R(1,3)-sin(t1)*sin(t2+t3)*R(2,3)+cos(t2+t3)*R(3,3));
t5 = atan2(sin(t1)*R(1,3)-cos(t1)*R(2,3),sqrt(1-(sin(t1)*R(1,3)-cos(t1)*R(2,3))^2));
t6 = atan2(-sin(t1)*R(1,1)+cos(t1)*R(2,1),sin(t1)*R(1,2)-cos(t1)*R(2,2));

gamma = [t1;t2;t3;t4;t5;t6];
meiosis_draw(gamma)










% J = zeros(6);
% J(1:3,1) = cross([0;0;1],(o(1:3,6) - o(1:3,1)));
% J(1:3,2) = cross(z(1:3,1),(o(1:3,6) - o(1:3,1)));
% J(1:3,3) = cross(z(1:3,2),(o(1:3,6) - o(1:3,2)));
% J(1:3,4) = cross(z(1:3,3),(o(1:3,6) - o(1:3,3)));
% J(1:3,5) = cross(z(1:3,4),(o(1:3,6) - o(1:3,4)));
% J(1:3,6) = cross(z(1:3,5),(o(1:3,6) - o(1:3,5)));
% 
% % J(4:6,1) = [0;0;1];
% 
% for i = 1:6
%     J(4:6,i) = z(1:3,i);
% end

