clear all
close all
clc

syms xc(t) yc(t) zc(t) t t1(t) t2(t) t3(t) t4(t) t5(t) t6(t) xdot ydot zdot

% Inverse Position
d = 0;
L1 = 122.75;
L2 = 260;
L3 = 270;
t1 = atan(yc/xc);% - atan2(d,sqrt(xc^2 + yc^2 -d^2)) - pi/2;

D = (xc^2 + yc^2 - d^2 + (zc - L1)^2 - L2^2 - L3^2)/(2*L2*L3);
t3 = atan(-sqrt(1-D^2)/D);
t2 = atan((zc - L1)/sqrt(xc^2 + yc^2 - d^2)) - atan(L3*sin(t3)/(L2 + L3*cos(t3)));
% 
% Inverse Orientation
syms r11 r12 r13 r21 r22 r23 r31 r32 r33
R = [r11 r12 r13;
     r21 r22 r23;
     r31 r32 r33];

T3 = rotz(t1)*rotx(t2)*rotx(t3);
T = T3.'*R;
T = T(t);
t6 = atan(T(2,1)/-T(2,3));
t4 = atan(T(1,2)/T(3,2));
t5 = atan((T(3,2)/cos(t4))/T(2,2));

t1dot = diff(t1,t);
t2dot = diff(t2,t);
t3dot = diff(t3,t);
t4dot = diff(t4,t);
t5dot = diff(t5,t);
t6dot = diff(t6,t);

t1dot = subs(t1dot,[diff(xc(t), t),diff(yc(t), t),diff(zc(t), t)],[xdot,ydot,zdot]);
t2dot = subs(t2dot,[diff(xc(t), t),diff(yc(t), t),diff(zc(t), t)],[xdot,ydot,zdot]);
t3dot = subs(t3dot,[diff(xc(t), t),diff(yc(t), t),diff(zc(t), t)],[xdot,ydot,zdot]);
t4dot = subs(t4dot,[diff(xc(t), t),diff(yc(t), t),diff(zc(t), t)],[xdot,ydot,zdot]);
t5dot = subs(t5dot,[diff(xc(t), t),diff(yc(t), t),diff(zc(t), t)],[xdot,ydot,zdot]);
t6dot = subs(t6dot,[diff(xc(t), t),diff(yc(t), t),diff(zc(t), t)],[xdot,ydot,zdot]);

t1dot = simplify(t1dot);
disp('1')
t2dot = simplify(t2dot);
disp('2')
t3dot = simplify(t3dot);
disp('3')
t4dot = simplify(t4dot);
disp('4')
t5dot = simplify(t5dot);
disp('5')
t6dot = simplify(t6dot);
disp('6')





