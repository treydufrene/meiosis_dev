clear all
close all
clc

%Define Symbolic Variables
syms t1 t2 t3 t4 t5 t6 dt1 dt2 dt3 dt4 dt5 dt6
q = [t1 t2 t3 t4 t5 t6].';
dotq = [dt1 dt2 dt3 dt4 dt5 dt6].';

%Define Constants
% LB = ;
% L1 = ;
% L2 = ;
% L3 = ;
% L4 = ;
% LE = ;
syms LB L1 L2 L3 L4 LE

%Relative Positions:
rBfromI = [0;       0;       0];
r1fromB = [0;       0;      LB]; % base is 8 cm tall
r2from1 = [0;       0;      L1]; % link 1 is 14.08 tall and displaced by 1.54 cm in the neg. y-direction
r3from2 = [0;      L2;       0]; % link 2 is 25 cm long
r4from3 = [0;      L3;       0]; % link 3 is 20 cm long
r5from4 = [0;      L4;       0]; % distance from 1st wrist coor. frame to 2nd is 8 cm
r6from5 = [0;       0;       0]; % no distance between 2nd and 3rd
r7from6 = [0;      LE;       0]; % dist. from 3rd wrist coor. frame to the end effector is 5.25 cm

%Orientations wrt I:     
T{1} = rotz(t1);
T{2} = T{1}*rotx(t2);
T{3} = T{2}*rotx(t3);
T{4} = T{3}*roty(t4);
T{5} = T{4}*rotx(t5);
T{6} = T{5}*roty(t6);

%Positions wrt I:
rB = rBfromI;
r{1} = rB + r1fromB;
r{2} = r{1} + T{1}*r2from1;
r{3} = r{2} + T{2}*r3from2;
r{4} = r{3} + T{3}*r4from3;
r{5} = r{4} + T{4}*r5from4;
r{6} = r{5} + T{5}*r6from5;


for i = 1:6
    [dotr(:,i),w(:,i)] = MeiosisVelocity(T{i},r{i},q,dotq);
    disp(i)
    disp(dotr(:,i))
    disp(w(:,i))
    
end
