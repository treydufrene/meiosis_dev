% INPUT
% q = joint angles

% OUTPUT
% o = Position
% phi = Orientation

function [o, phi] = currentPO(gamma)
l1 = 8 + 14.08;
l2 = 25;
l3 = 20;
l4 = 8;
l6 = 5.25;
offset = 1;

qA    = [0;     0; pi/2;      0;   0;  0];
d     = [  l1;     -offset;    0;     l3+l4;   0; l6];
a     = [0; l2;    0;     0;    0; 0];
alpha = [pi/2;     0; pi/2; -pi/2; pi/2;  0];

for i = 1:6
    A(:,:,i) = rotzh(gamma(i) + qA(i)) * transzh(d(i)) * transxh(a(i)) * rotxh(alpha(i)); 
end

T(:,:,1) = A(:,:,1);

for i = 1:5
    T(:,:,i+1) = T(:,:,i)*A(:,:,i+1);
end

    o = T(1:3,4,6);
%     phi = [atan2(T(3,2,6),T(3,3,6));
%            atan2(-T(3,1,6),sqrt(T(3,2,6)^2 + T(3,3,6)^2));
%            atan2(T(2,1,6),T(1,1,6))];
    phi = rotm2eul(rotz(0)*roty(0)*rotz(0));
end