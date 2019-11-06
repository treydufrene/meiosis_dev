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

    %Relative Positions:
    r1fromB = [0;       0;      LB]; % base is 8 cm tall
    r2from1 = [0;       0;      L1]; % link 1 is 14.08 tall and displaced by 1.54 cm in the neg. y-direction
    r3from2 = [0;      L2;       0]; % link 2 is 25 cm long
    r4from3 = [0;      L3;       0]; % link 3 is 20 cm long
    r5from4 = [0;      L4;       0]; % distance from 1st wrist coor. frame to 2nd is 8 cm
    r6from5 = [0;      L5;       0]; % no distance between 2nd and 3rd
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