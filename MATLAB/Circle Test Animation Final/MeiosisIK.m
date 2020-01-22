function [gamma, error] = MeiosisIK(pos,R)
    
    eOff = [0;96;0];
    npos = pos - R*eOff;
    xc = npos(1);
    yc = npos(2);
    zc = npos(3);
    L1 = 122.75;
    d = 0;
    L2 = 260;
    L3 = 270;
    
    % Inverse Position
    if (xc^2 + yc^2 -d^2) < 0
        theta = 1000*[1;1;1;1;1;1];
        error = 1;
    else
        t1 = atan2(yc,xc) - atan2(d,sqrt(xc^2 + yc^2 -d^2)) - pi/2;
        if t1 < -pi
            t1 = t1 + 2*pi;
        end
        if t1 > pi
            t1 = t1 - 2*pi;
        end
        D = (xc^2 + yc^2 - d^2 + (zc - L1)^2 - L2^2 - L3^2)/(2*L2*L3);
        t3 = atan2(-sqrt(1-D^2),D);
        t2 = atan2(zc - L1,sqrt(xc^2 + yc^2 - d^2)) - atan2(L3*sin(t3),L2 + L3*cos(t3));

        % Inverse Orientation
        T3 = rotz(t1)*rotx(t2)*rotx(t3);
        T = T3.'*R;
        t6 = atan2(T(2,1),-T(2,3));
        t4 = atan2(T(1,2),T(3,2));
        while t4 > pi/2
            t4 = t4 - pi;
        end

        while t4 < -pi/2
            t4 = t4 + pi;
        end
        
        if t6 < 0
            t6 = t6 + 2*pi;
        end
        %t4 = atan2(sin(t4),cos(t4));
        
        if sin(t4) > -10e-6 && sin(t4) < 10e-6
            t5 = atan2(T(3,2)/cos(t4),T(2,2));
        else
            t5 = atan2(T(1,2)/sin(t4),T(2,2));
        end

        gamma = [t1,t2,t3,t4,t5,t6].';
        
%         %       Mapping between joint space and motor space 
%         N = 10;         %Gear Ratio
% %         B = [ N, N, 0, 0, 0, 0;
% %               N,-N, 0, 0, 0, 0;
% %               0, 0,-N, 0, 0, 0;
% %               0, 0, 0, 1, 0, 0;
% %               0, 0, 0, 0,-1, 1;
% %               0, 0, 0, 0, 1, 1];
%         A = [ 1/(2*N), 1/(2*N),   0, 0,   0,   0;
%           1/(2*N),-1/(2*N),   0, 0,   0,   0;
%                 0,       0,-1/N, 0,   0,   0;
%                 0,       0,   0, 1,   0,   0;
%                 0,       0,   0, 0,-1/2, 1/2;
%                 0,       0,   0, 0, 1/2, 1/2];
%   
%         theta = A\gamma;
        error = 0;
    end
end