function [H, d, G] = Meiosis_HdG(gamma,gammadot)

    %Gear Ratio
    N = 10;
    
    %Variable reassignments
    theta1 = -(gamma(1) + gamma(2))/(2*N);
    theta2 = -(gamma(1) + gamma(2))/(2*N);
    theta3 = gamma(3)/N;
    theta4 = gamma(4);
    theta5 = (gamma(5) - gamma(6))/2;
    theta6 = -(gamma(5) + gamma(6))/2;
    
    %       Mass Parameters
    %Mass
    m{1} = 8.19264294;
    m{2} = 5.50781768;
    m{3} = 3.81978662;
    m{4} = 3.37865995;
    m{5} = 3.04430043;
    m{6} = 1.93085347;
    m{7} = 0.66211106;
    m{8} = 2.52094779;
    
    %Center of mass for each link
    rcm{1} = [0.02734797;-.00317970;0.15563460];
    rcm{2} = [0.02479837;0.09522711;0.00001324];
    rcm{3} = [0.14336135;-.00104665;-.00000231];
    rcm{4} = [0.02658902;-.09611792;-.00006966];
    rcm{5} = [0.14486497;0.00099740;0.00027129];
    rcm{6} = [0.01219767;0.07446539;-.00128796];
    rcm{7} = [0.03037622;-.01061201;-.00000331];
    rcm{8} = [0.00366851;0.00049050;0.11638732];
    
    Gam{1} = rcm{1}*m{1};
    Gam{2} = rcm{2}*m{2};
    Gam{3} = rcm{3}*m{3};
    Gam{4} = rcm{4}*m{4};
    Gam{5} = rcm{5}*m{5};
    Gam{6} = rcm{6}*m{6};
    Gam{7} = rcm{7}*m{7};
    Gam{8} = rcm{8}*m{8};
    
    %Inertia Matrices
    J{1} = [0.26607023 -.00038981 -.04801856;
            -.00038981 0.28078511 0.00174486;
            -.04801856 0.00174486 0.03266273];
    J{2} = [0.06807013 -.01811791 0.00000238;
            -.01811791 0.02398210 -.00001133;
            0.00000238 -.00001133 0.08122087];
    J{3} = [0.00458681 0.00169482 0.00000052;
            0.00169482 0.11052135 -.00000006;
            0.00000052 -.00000006 0.10995021];
    J{4} = [0.03973192 0.01142099 -.00000198;
            0.01142099 0.01197658 -.00003404;
            -.00000198 -.00003404 0.04758280];
    J{5} = [0.00284307 -.00117636 -.00008063;
            -.00117636 0.08916094 -.00000018;
            -.00008063 -.00000018 0.08895676];
    J{6} = [0.01427892 -.00224277 0.00003962;
            -.00224277 0.00311424 0.00019771;
            0.00003962 0.00019771 0.01544417];
    J{7} = [0.00082641 0.00022344 0.00000013;
            0.00022344 0.00103886 0.00000004;
            0.00000013 0.00000004 0.00134811];
    J{8} = [0.04954300 -.00001992 -.00086409;
            -.00001992 0.04540562 -.00012555;
            -.00086409 -.00012555 0.00621396];
    
    %          Forward kinematics
    %Relative Positions
    rBfromI = [      0;      0;     0];
    r1fromB = [      0;      0;0.0825];
    r2from1 = [  0.081;  0.062; 0.236];
    r3from2 = [   0.14; 0.1315;     0];
    r4from3 = [  0.263;  -.045;     0];
    r5from4 = [ 0.1265; -.1265;     0];
    r6from5 = [  0.277;0.03975;     0];
    r7from6 = [0.07637; 0.0958;     0];
    rEfrom7 = [0.06325;      0;     0];
    rSfrom1 = [      0;      0; 0.311];
    
    %Store orientations in cell array
    rn{1} = r1fromB;
    rn{2} = r2from1;
    rn{3} = r3from2;
    rn{4} = r4from3;
    rn{5} = r5from4;
    rn{6} = r6from5;
    rn{7} = r7from6;
    rn{8} = rSfrom1;

    %Orientations wrt I
    TB = eye(3);
    T{1} = TB*rotz(theta1);
    T{2} = T{1}*rotx(theta2);
    T{3} = T{2}*rotx(theta3);
    T{4} = T{3}*roty(theta4);
    T{5} = T{4}*rotx(theta5);
    T{6} = T{5}*roty(theta6);
    T{7} = T{1}*rotx(theta1);           %Gear 1
    T{8} = T{1}*rotx(-theta1);          %Gear 2
    T{9} = T{5}*rotx(-theta6);          %Gear 3
    T{10} = T{5}*rotx(theta6);          %Gear 4

    %Positions wrt I
    rB = rBfromI;
    r{1} = rB + TB*r1fromB;
    r{2} = r{1} + T{1}*r2from1;
    r{3} = r{2} + T{2}*r3from2;
    r{4} = r{3} + T{3}*r4from3;
    r{5} = r{4} + T{4}*r5from4;
    r{6} = r{5} + T{5}*r6from5;
    r{7} = r{6} + T{6}*r7from6;
    r{8} = r{1} + rSfrom1;
    
    %              Recursive Kinematics
    Jb0 = zeros(6,7);
    Jbdot0 = zeros(6,7);
    
    for ii = 1:8
        if ii == 1        
            Jmat = Jb0;
            wI = Jmat(1:3,:)*gammadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Sawyer(Jb0,Jbdot0,gamma,gammadot,TB,rn{ii},zeros(3,1),wI,ii);
        elseif ii == 7
            Jmat = Jb{1};
            wI = Jmat(1:3,:)*gammadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Sawyer(Jb{1},Jbdot{1},gamma,gammadot,T{1},rn{ii},zeros(3,1),wI,ii);
        elseif ii == 8
            Jmat = Jb{1};
            wI = Jmat(1:3,:)*gammadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Sawyer(Jb{1},Jbdot{1},gamma,gammadot,T{1},rn{ii},zeros(3,1),wI,ii);
        elseif ii == 9
            Jmat = Jb{5};
            wI = Jmat(1:3,:)*gammadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Sawyer(Jb{1},Jbdot{5},gamma,gammadot,T{5},rn{ii},zeros(3,1),wI,ii);
        elseif ii == 10
            Jmat = Jb{5};
            wI = Jmat(1:3,:)*gammadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Sawyer(Jb{1},Jbdot{5},gamma,gammadot,T{5},rn{ii},zeros(3,1),wI,ii);
        else
            Jmat = Jb{ii-1};
            wI = Jmat(1:3,:)*gammadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Sawyer(Jb{ii-1},Jbdot{ii-1},gamma,gammadot,T{ii-1},rn{ii},zeros(3,1),wI,ii);
        end
        
        Jmat = Jb{ii};
        wI = Jmat(1:3,:)*gammadot;
        
        Hmat = Jb{ii}.'*[J{ii},skew(Gam{ii})*T{ii}.';T{ii}*skew(Gam{ii}).',m{ii}*eye(3)]*Jb{ii};
        dvec = Jb{ii}.'*[J{ii},skew(Gam{ii})*T{ii}.';T{ii}*skew(Gam{ii}).',m{ii}*eye(3)]*Jbdot{ii}*gammadot + Jb{ii}.'*[cross(wI,J{ii}*wI);T{ii}*cross(wI,cross(wI,Gam{ii}))];
        g = -Jb{ii}.'*[cross(rcm{ii},T{ii}.'*[0;0;-m{ii}*9.81]);[0;0;-m{ii}*9.81]];
        
        if ii == 1
            H = Hmat;
            d = dvec;
            G = g;
        else
            H = H + Hmat;
            d = d + dvec;
            G = G + g;
        end  
    end

end