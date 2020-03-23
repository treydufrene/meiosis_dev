
close all;clear;clc

syms t1 t2 t3 t4 t5 t6 r1 r2 r3 r4 r5 r6

% gamma = [t1 t2 t3 t4 t5 t6];
gamma = [pi; 0; 0; 0; 0; 0];

T1 = rotz(gamma(1))*roty(sym(pi)/2);
T2 = T1*rotz(gamma(2));
T3 = T2*rotz(gamma(3))*rotx(-sym(pi)/2);
T4 = T3*rotz(gamma(4))*rotx(sym(pi)/2);
T5 = T4*rotz(gamma(5))*rotx(-sym(pi)/2);
T6 = T5*rotz(gamma(6));

r1 = [0;0;0];
r2 = r1 + T1 * [0;0;1];
r3 = r2 + T2 * [0;10;0];
r4 = r3 + T3 * [0;10;0];
r5 = r4 + T4 * [0;0;10];
r6 = r5 + T5 * [0;10;0];