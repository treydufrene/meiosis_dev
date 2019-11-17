clear all
close all
clc

%Define Symbolic Variables
syms t1 t2 t3 t4 t5 t6 dt1 dt2 dt3 dt4 dt5 dt6 L1 L2 L3 L4 L5 L6
q = [t1 t2 t3 t4 t5 t6].';
dotq = [dt1 dt2 dt3 dt4 dt5 dt6].';

%Relative Positions
rBfromI = [  0;  0;  0];
r1fromB = [  0;  0; L1];    % Frame 1 is 122.75mm away from the Base frame in the Z direction
r2from1 = [  0;  0;  0];    % Frame 2 is centered on Frame 1
r3from2 = [  0; L2;  0];    % Frame 3 is 250mm away from Frame 2 in the Y direction
r4from3 = [  0; L3;  0];    % Frame 4 is 200mm away from Frame 3 in the Y direction
r5from4 = [  0; L4;  0];    % Frame 5 is 70mm away from Frame 4 in the Y direction
r6from5 = [  0; L6;  0];    % Frame 6 is 47.5mm away from Frame 5 in the Y direction

%Orientations wrt I:     
T(:,:,1) = rotz(t1);
T(:,:,2) = T(:,:,1)*rotx(t2);
T(:,:,3) = T(:,:,2)*rotx(t3);
T(:,:,4) = T(:,:,3)*roty(t4);
T(:,:,5) = T(:,:,4)*rotx(t5);
T(:,:,6) = T(:,:,5)*roty(t6);

%Positions wrt I:
rB = rBfromI;
r(:,1) = rB + r1fromB;
r(:,2) = r(:,1) + T(:,:,1)*r2from1;
r(:,3) = r(:,2) + T(:,:,2)*r3from2;
r(:,4) = r(:,3) + T(:,:,3)*r4from3;
r(:,5) = r(:,4) + T(:,:,4)*r5from4;
r(:,6) = r(:,5) + T(:,:,5)*r6from5;


for ii = 1:6
    [dotr(:,ii),w(:,ii)] = MeiosisVelocity(T(:,:,ii),r(:,ii),q,dotq);
    disp(ii)
    disp(dotr(:,ii))
    disp(w(:,ii))
    
end
