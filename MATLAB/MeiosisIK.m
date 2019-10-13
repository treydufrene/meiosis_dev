function gamma = meiosisIK(pos,R)
    
    eOff = [0;0;5.25];
    npos = pos - R*eOff;
    xd = npos(1);
    yd = npos(2);
    zd = npos(3);
    off = 1.54;
    zoff = 22.08;
    L2 = 25;
    L3 = 28;
    
    % Inverse Position
    t1 = atan2(xd,yd);
    xc = xd + off*cos(t1);
    yc = yd + off*sin(t1);
    zc = zd - zoff;
    D = (xc^2 + yc^2 + zc^2 - L2^2 - L3^2)/(2*L2*L3);
    t3 = atan2(D,sqrt(1-D^2));
    t2 = atan2(sqrt(xc^2 + yc^2),zc) - atan2(L2 + L3*cos(t3),L3*sin(t3));
    
    % Inverse Orientation
    t4 = atan2(cos(t1)*cos(t2+t3)*R(1,3)+sin(t1)*cos(t2+t3)*R(2,3)+sin(t2+t3)*R(3,3),-cos(t1)*sin(t2+t3)*R(1,3)-sin(t1)*sin(t2+t3)*R(2,3)+cos(t2+t3)*R(3,3));
    t5 = atan2(sin(t1)*R(1,3)-cos(t1)*R(2,3),sqrt(1-(sin(t1)*R(1,3)-cos(t1)*R(2,3))^2));
    t6 = atan2(-sin(t1)*R(1,1)+cos(t1)*R(2,1),sin(t1)*R(1,2)-cos(t1)*R(2,2));

    gamma = [t1,t2,t3,t4,t5,t6].';
    
    
end