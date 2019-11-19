function bdot = Meiosis_robot1(b,thetad)

    %Preallocate variables
    bdot = zeros(12,1);
    
    %Variable reassignments
    theta = b(1:6);
    thetadot = b(7:12);
     
    %              Motor Dynamics
    %Define motor/gearbox/friction constants
%     Ra = 2.79*ones(1,7);        %Armature Resistance (Ohms)
%     La = 0*ones(1,7);           %Armature Inductance (H)
%     K  = 0.0525*ones(1,7);      %Motor Constant (Nm/A) or (V/rad*s)
%     Ja = 1.1e-5*ones(1,7);      %Armature Intertia (kg*m^2)
%     ba = 2.6e-6*ones(1,7);      %Armature Viscous Friction (Nm*s/rad)
%     ca = 1.1e-5*ones(1,7);      %Armature Coulombic Friction (Nm)
% 
%     N  = 1/19.7*ones(1,7);      %Gear Ratio 
%     n  = 0.73*ones(1,7);        %Gearbox Eficiency
% 
%     Jm = diag(Ra.*Ja./(K.*N));
%     Bm = diag(Ra.*ba./(K.*N) + K./N);
%     Cm = diag(Ra.*ca./K);
%     Rm = diag(Ra.*n.*N./K);

    [H,d,G] = Meiosis_HdG(theta,thetadot);
    one = diag((1 / 82.5459264810444)*[1 1 1 1 1 1]);
    %one = 10*one;
    two = diag((13.4787019763844 / 82.5459264810444)*[1 1 1 1 1 1]);
    %two = 10*two;
    three = diag((88.3252169803572 / 82.5459264810444)*[1 1 1 1 1 1]);
    %three = 10*three;
    
    bdot(1:6) = b(7:12);
    bdot(7:12) = (H+one)\(three*(thetad - b(1:6)) - (d+two*bdot(1:6)) - G);
%     bdot(8:14) = (Jm + Rm*H)\(Va - Rm*d - Cm*sign(gammadot) - Bm*gammadot - Rm*G);

end