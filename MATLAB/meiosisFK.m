function [o,R] = meiosisFK(gamma)
l1 = 8 + 14.08;
l2 = 25;
l3 = 20;
l4 = 8;
l6 = 5.25;
offset = 1;

% Joint parameters (theta):
% q = [0;0;0;0;0;0];
% theta4 = q(4);
% theta5 = q(5);
% theta6 = q(6);
% euler = rotz(theta4)*rotx(-(pi)/2)*rotz(theta5)*rotx((pi)/2)*rotz(theta6)
% euler = rotz(theta4)*roty(theta5)*rotz(theta6);

% Constant manip offsets:
qA    = [0;     0; pi/2;      0;   0;  0];
d     = [  l1;     -offset;    0;     l3+l4;   0; l6];
a     = [0; l2;    0;     0;    0; 0];
alpha = [pi/2;     0; pi/2; -pi/2; pi/2;  0];

for i = 1:6
    A(:,:,i) = rotzh(gamma(i) + qA(i)) * transzh(d(i)) * transxh(a(i)) * rotxh(alpha(i)); 
end

T(:,:,1) = A(:,:,1);
z(1:3,1) = T(1:3,3,1);
o(1:3,1) = T(1:3,4,1);

for i = 1:5
    T(:,:,i+1) = T(:,:,i)*A(:,:,i+1);
    z(1:3,i+1) = T(1:3,3,i+1);
    o(1:3,i+1) = T(1:3,4,i+1);
end

o = o(1:3,6);
R = T(1:3,1:3,6);
% phie = rotm2eul(T(1:3,1:3,6));
% qc = [0;0;0;0;0;0];



end
