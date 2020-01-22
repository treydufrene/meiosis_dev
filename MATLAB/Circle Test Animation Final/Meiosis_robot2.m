function bdot = Meiosis_robot2(b,gammad,gammadotd,gammaddotd)
    %Define Control Parameters
    zeta = 1;
    wn = 1;
    Kd = -2*zeta*wn*eye(6);
    Kp = -wn^2*eye(6);
    
    %Preallocate variables
    bdot = zeros(12,1);
    
    %Variable reassignments
    gamma = b(1:6);
    gammadot = b(7:12);

    [H,d,G] = Meiosis_HdG(gamma,gammadot);
    C1 = diag((1 / 82.5459264810444)*[1 1 1 1 1 1]);
    C2 = diag((13.4787019763844 / 82.5459264810444)*[1 1 1 1 1 1]);
    C3 = diag((88.3252169803572 / 82.5459264810444)*[1 1 1 1 1 1]);
    
    N = 10;  %Gear Ratio
    A = [ 1/(2*N), 1/(2*N),   0, 0,   0,   0;
          1/(2*N),-1/(2*N),   0, 0,   0,   0;
                0,       0,-1/N, 0,   0,   0;
                0,       0,   0, 1,   0,   0;
                0,       0,   0, 0,-1/2, 1/2;
                0,       0,   0, 0, 1/2, 1/2];
    
    bdot(1:6) = b(7:12);
    
    %u = (A.'\C3)\(G + d) + A\gammad;
    %n = (A.'\C3)\(G + d);
    %u = H*(gammaddotd + Kd*(gammadot - gammadotd) + Kp*(gamma - gammad)) + n;
    u = gammaddotd + Kd*(gammadot - gammadotd) + Kp*(gamma - gammad);
    n = (A.'\C3)\(H*u + G + d) + A\gammad;
    bdot(7:12) = (H + A.'\C1/A)\(-d - G - A\C2/A*gammadot - A.'\C3/A*gamma + A.'\C3*n);
    %bdot(7:12) = (A.'\C1/A)\(H*u + d + G + A.'\C2/A*gammadot + A.'\C3/A*(gammad - gamma));
end