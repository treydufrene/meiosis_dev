function T = TmatrixCapstoneDegrees(q)
l1 = 220.8;
l2 = 250;
l3 = 280;
l4 = 52.5;
Off = 15.4;

DH = [l1, q(1)+90, -Off, 90;
      0, q(2), l2, 0;
      0, q(3)+90, 0, 90;
      l3, q(4), 0, -90;
      0, q(5), 0, 90;
      l4, q(6), 0, 0];

A1 = rotzd4(DH(1,2))*transz(DH(1,1))*transx(DH(1,3))*rotxd4(DH(1,4));
A2 = rotzd4(DH(2,2))*transz(DH(2,1))*transx(DH(2,3))*rotxd4(DH(2,4));
A3 = rotzd4(DH(3,2))*transz(DH(3,1))*transx(DH(3,3))*rotxd4(DH(3,4));
A4 = rotzd4(DH(4,2))*transz(DH(4,1))*transx(DH(4,3))*rotxd4(DH(4,4));
A5 = rotzd4(DH(5,2))*transz(DH(5,1))*transx(DH(5,3))*rotxd4(DH(5,4));
A6 = rotzd4(DH(6,2))*transz(DH(6,1))*transx(DH(6,3))*rotxd4(DH(6,4));

T0 = eye(4);
T1 = T0*A1;
T2 = T1*A2;
T3 = T2*A3;
T4 = T3*A4;
T5 = T4*A5;
T = T5*A6;
end