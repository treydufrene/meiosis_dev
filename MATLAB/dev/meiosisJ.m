close all;clear;clc

l1 = 80 + 133.3;
l2 = 250;
l3 = 200;
l4 = 132.5;

% Joint Rotations (theta):
q = [0;0;0;0;0;0];

% Constant manip offsets:
qA = [pi/2;0;pi/2;0;0;0];
d = [l1;0;0;l3;0;l4];
a = [-14.5;-l3;0;0;0;0];
alpha = [pi/2;0;pi/2;-pi/2;pi/2;0];

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

J = zeros(6);
J(1:3,1) = cross([0;0;1],(o(1:3,6) - o(1:3,1)));
J(1:3,2) = cross(z(1:3,1),(o(1:3,6) - o(1:3,1)));
J(1:3,3) = cross(z(1:3,2),(o(1:3,6) - o(1:3,2)));
J(1:3,4) = cross(z(1:3,3),(o(1:3,6) - o(1:3,3)));
J(1:3,5) = cross(z(1:3,4),(o(1:3,6) - o(1:3,4)));
J(1:3,6) = cross(z(1:3,5),(o(1:3,6) - o(1:3,5)));

% J(4:6,1) = [0;0;1];

for i = 1:6
    J(4:6,i) = z(1:3,i);
end