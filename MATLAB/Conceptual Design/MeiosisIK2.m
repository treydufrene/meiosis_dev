function [gamma, error] = MeiosisIK2(pos,R)
    
    eOff = [0;0;5.25];
    npos = pos - R*eOff;
    xc = npos(1);
    yc = npos(2);
    zc = npos(3);
    L1 = 22.08;
    d = 0;
    L2 = 25;
    L3 = 28;
    
    % Inverse Position
    if (xc^2 + yc^2 -d^2) < 0
        gamma = 1000*[1;1;1;1;1;1];
        error = 1;
    else
        t1 = atan2(yc,xc) - atan2(d,sqrt(xc^2 + yc^2 -d^2));
        D = (xc^2 + yc^2 - d^2 + (zc - L1)^2 - L2^2 - L3^2)/(2*L2*L3);
        t3 = atan2(-sqrt(1-D^2),D);
        t2 = atan2(zc - L1,sqrt(xc^2 + yc^2 - d^2)) - atan2(L3*sin(t3),L2 + L3*cos(t3));

        % Inverse Orientation
        R = [0 1 0;0 0 1;1 0 0]*rotz(t2+t3).'*[1 0 0;0 0 1;0 -1 0]*rotz(t1).'*R;
        eul = rotm2eul(R,'ZYZ');
        t4 = eul(1);
        t5 = eul(2);
        t6 = eul(3);

        gamma = [t1,t2,t3,t4,t5,t6].';
        error = 0;
    end
end