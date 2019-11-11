function [r6,T6]= MeiosisFK(gamma)

    theta1 = gamma(1);
    theta2 = gamma(2);
    theta3 = gamma(3);
    theta4 = gamma(4);
    theta5 = gamma(5);
    theta6 = gamma(6);

    %Define Constants
    LB = 12.275;
    L1 = 0;
    L2 = 25;
    L3 = 20;
    L4 = 7.2;
    L5 = 0;
    L6 = 5.3;

    %Relative Positions
    rBfromI = [ 0.00000000; 0.00000000; 0.00000000];
    r1fromB = [ 0.00000000; 0.00000000; 0.12275000];
    r2from1 = [ 0.00000000; 0.00000000; 0.00000000];
    r3from2 = [ 0.00000000; 0.25000000; 0.00000000];
    r4from3 = [ 0.00000000; 0.20000000; 0.00000000];
    r5from4 = [ 0.00000000; 0.07000000; 0.00000000];
    r6from5 = [ 0.00000000; 0.04750000; 0.00000000];
    %r7from6 = [0;       0;       0]; % dist. from 3rd wrist coor. frame to the end effector is 5.25 cm

    %Orientations wrt I:     
    T1 = rotz(theta1);
    T2 = T1*rotx(theta2);
    T3 = T2*rotx(theta3);
    T4 = T3*roty(theta4);
    T5 = T4*rotx(theta5);
    T6 = T5*roty(theta6);

    %Positions wrt I:
    %rB = rBfromI;
    r1 = r1fromB;
    r2 = r1 + T1*r2from1;
    r3 = r2 + T2*r3from2;
    r4 = r3 + T3*r4from3;
    r5 = r4 + T4*r5from4;
    r6 = r5 + T5*r6from5;

end