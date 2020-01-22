function [r6,T6]= MeiosisFK(gamma)

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

end