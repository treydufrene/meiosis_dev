clear all
close all
clc

syms t1 t2 t3 t4 t5 t6 t1dot t2dot t3dot t4dot t5dot t6dot
gamma = [t1;t2;t3;t4;t5;t6];
gammadot = [t1dot;t2dot;t3dot;t4dot;t5dot;t6dot];

%Relative Positions
rBfromI =  [ 0.00000000; 0.00000000; 0.00000000];
r1fromB =  [ 0.00000000; 0.00000000; 0.12275000];
r2from1 =  [ 0.00000000; 0.00000000; 0.00000000];
r3from2 =  [ 0.00000000; 0.26000000; 0.00000000];
r4from3 =  [ 0.00000000; 0.20000000; 0.00000000];
r5from4 =  [ 0.00000000; 0.07000000; 0.00000000];
r6from5 =  [ 0.00000000; 0.09600000; 0.00000000];

%Orientations wrt I:     
T1 = rotz(gamma(1));
T2 = T1*rotx(gamma(2));
T3 = T2*rotx(gamma(3));
T4 = T3*roty(gamma(4));
T5 = T4*rotx(gamma(5));
T6 = T5*roty(gamma(6));

%Positions wrt I:
%rB = rBfromI;
r1 = r1fromB;
r2 = r1 + T1*r2from1;
r3 = r2 + T2*r3from2;
r4 = r3 + T3*r4from3;
r5 = r4 + T4*r5from4;
r6 = r5 + T5*r6from5;

T = T6;
r = r6;

Jw = [T(:,3).'*jacobian(T(:,2),gamma);...
      T(:,1).'*jacobian(T(:,3),gamma);...
      T(:,2).'*jacobian(T(:,1),gamma)];

Jw = simplify(Jw,'steps',20,'criterion','preferReal');

Jr = jacobian(r,gamma);

Jr = simplify(Jr,'steps',20,'criterion','preferReal');

J = [Jw;Jr];

Jdot = [jacobian(J(:,1),gamma)*gammadot,jacobian(J(:,2),gamma)*gammadot,jacobian(J(:,3),gamma)*gammadot,jacobian(J(:,4),gamma)*gammadot,jacobian(J(:,5),gamma)*gammadot,jacobian(J(:,6),gamma)*gammadot];

Jdot = simplify(Jdot,'steps',20,'criterion','preferReal')

