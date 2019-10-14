close all;clear;clc
% function [J] = meiosisJ(q)
l1 = 8 + 14.08;
l2 = 25;
l3 = 20;
l4 = 8;
l6 = 5.25;
offset = 1;

% Joint Rotations (theta):
q = [0;0;0;0;0;0];

% Constant manip offsets:
% qA    = [pi;     0; pi/2;      0;   0;  0];
% d     = [  l1;     0;    0;     l3+l4;   0; l6];
% a     = [offset; l2;    0;     0;    0; 0];
% alpha = [pi/2;     0; pi/2; -pi/2; pi/2;  0];

qA    = [pi/2;     0; pi/2;      0;   0;  0];
d     = [  l1;     -offset;    0;     l3+l4;   0; l6];
a     = [0; l2;    0;     0;    0; 0];
alpha = [pi/2;     0; pi/2; -pi/2; pi/2;  0];


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

% Desired orientation and position (gamma = 0)
% R = [0 1 0;...
%      0 0 1;...
%      1 0 0];
% od = [0;...
%       58.25;...
%       22.0800];
R = T(1:3,1:3,6);
od = T(1:3,4,6);
% Wrist Center:
oc = od - l6*R*[0;0;1];
xc = round(oc(1),5);
yc = round(oc(2),5);
zc = round(oc(3),5);

% Left Arm:
t1 = atan2(yc,xc) - atan2(offset,sqrt(xc^2 + yc^2 - offset^2))
% Right Arm:
% t1 = atan2(yc,xc) - atan2(-offset,-sqrt(xc^2 + yc^2 - offset^2))
% 
D = (xc^2 + yc^2 - offset^2 + (zc - l1)^2 - (l2)^2 - (l3+l4)^2) / (2*(l2)*(l3+l4));
t3 = atan2(sqrt(1-D^2),D);
t2 = atan2(zc-l1,sqrt(xc^2 + yc^2 - offset^2)) - atan2(l3*sin(t3),l2 + l3*cos(t3));

% R03 = [cos(t1)*cos(t2+t3), -cos(t1)*sin(t2+t3), sin(t1);...
%        sin(t1)*cos(t2+t3), -sin(t1)*sin(t2+t3), -cos(t1);...
%        sin(t2+t3), cos(t2+t3), 0];
% 
% R36 = R03.'*R;

% Inverse Orientation
t4 = atan2(-cos(t1)*sin(t2+t3)*R(1,3)-sin(t1)*sin(t2+t3)*R(2,3)+cos(t2+t3)*R(3,3),...
            cos(t1)*cos(t2+t3)*R(1,3)+sin(t1)*cos(t2+t3)*R(2,3)+sin(t2+t3)*R(3,3));

t5 = atan2(sqrt(1-(sin(t1)*R(1,3)-cos(t1)*R(2,3))^2),sin(t1)*R(1,3)-cos(t1)*R(2,3));

t6 = atan2(sin(t1)*R(1,2)-cos(t1)*R(2,2),-sin(t1)*R(1,1)+cos(t1)*R(2,1));
% 
gamma = [t1;t2;t3;t4;t5;t6]
% meiosis_draw(gamma)


% J = zeros(6);
% J(1:3,1) = cross([0;0;1],(o(1:3,6) - o(1:3,1)));
% J(1:3,2) = cross(z(1:3,1),(o(1:3,6) - o(1:3,1)));
% J(1:3,3) = cross(z(1:3,2),(o(1:3,6) - o(1:3,2)));
% J(1:3,4) = cross(z(1:3,3),(o(1:3,6) - o(1:3,3)));
% J(1:3,5) = cross(z(1:3,4),(o(1:3,6) - o(1:3,4)));
% J(1:3,6) = cross(z(1:3,5),(o(1:3,6) - o(1:3,5)));

% J(4:6,1) = [0;0;1];

% for i = 1:6
%     J(4:6,i) = z(1:3,i);
% end
% end
