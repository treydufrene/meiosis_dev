function [H, d, G] = Meiosis_HdG(theta,thetadot)

%     %Gear Ratio
%     N = 10;
%     
%     %Variable reassignments
%     theta = zeros(6,1);
%     theta(1) = -(gamma(1) + gamma(2))/(2*N);
%     theta(2) = -(gamma(1) + gamma(2))/(2*N);
%     theta(3) = gamma(3)/N;
%     theta(4) = gamma(4);
%     theta(5) = (gamma(5) - gamma(6))/2;
%     theta(6) = -(gamma(5) + gamma(6))/2;
%     
%     thetadot = zeros(6,1);
%     thetadot(1) = -(gammadot(1) + gammadot(2))/(2*N);
%     thetadot(2) = -(gammadot(1) + gammadot(2))/(2*N);
%     thetadot(3) = gammadot(3)/N;
%     thetadot(4) = gammadot(4);
%     thetadot(5) = (gammadot(5) - gammadot(6))/2;
%     thetadot(6) = -(gammadot(5) + gammadot(6))/2;
    
    %       Mass Parameters
    %Mass(kg)
    m{1} = 0.05633136;      %Link 1
    m{2} = 0.82917024;      %Link 2
    m{3} = 0.57207271;      %Link 3
    m{4} = 0.26834265;      %Link 4
    m{5} = 0.03933179;      %Link 5
    m{6} = 0.06573759;
    m{7} = 0.08088869;      %Gear 1
    m{8} = 0.08088869;      %Gear 2
    m{9} = 0.06573759;      %Gear 3
    m{10} = 0.06573759;
    
    %Center of mass for each link (m)
    rcm{1} = [ 0.00000000; 0.00000000;-0.01493226];     %Link 1
    rcm{2} = [ 0.00028150; 0.12460831;-0.00002867];     %Link 2    
    rcm{3} = [-0.00193108; 0.04401200;-0.00051261];     %Link 3
    rcm{4} = [ 0.00000000; 0.03163485; 0.00000000];     %Link 4
    rcm{5} = [ 0.00000000; 0.00630115; 0.00000000];     %Link 5
    rcm{6} = [ 0.00000000;-0.00694852; 0.00000000];     %Link 6
    rcm{7} = [ 0.00592778; 0.00000000; 0.00000000];     %Gear 1
    rcm{8} = [-0.00592778; 0.00000000; 0.00000000];     %Gear 2
    rcm{9} = [-0.00694852; 0.00000000; 0.00000000];     %Gear 3
    rcm{10}= [ 0.00694852; 0.00000000; 0.00000000];     %Gear 4
    
    Gam{1} = rcm{1}*m{1};
    Gam{2} = rcm{2}*m{2};
    Gam{3} = rcm{3}*m{3};
    Gam{4} = rcm{4}*m{4};
    Gam{5} = rcm{5}*m{5};
    Gam{6} = rcm{6}*m{6};
    Gam{7} = rcm{7}*m{7};
    Gam{8} = rcm{8}*m{8};
    Gam{9} = rcm{9}*m{9};
    Gam{10} = rcm{10}*m{10};
    
    %Inertia Matrices
	J{1} = [ 0.00003152  0.00000000  0.00000000;        %Link 1
	         0.00000000	 0.00004375  0.00000000;
	         0.00000000	 0.00000000  0.00001847];
    J{2} = [ 0.01862641 -0.00005105  0.00000000;        %Link 2
            -0.00005105  0.00195551  0.00000297;
             0.00000000  0.00000297  0.01993154];
    J{3} = [ 0.00360891  0.00000000  0.00000000;        %Link 3
	         0.00000000	 0.00055844  0.00003790;
	         0.00000000	 0.00003790  0.00371090];
    J{4} = [ 0.00063966  0.00000000  0.00000000;        %Link 4
	         0.00000000	 0.00069715  0.00000000;
	         0.00000000	 0.00000000  0.00108401];
    J{5} = [ 0.00000851  0.00000000  0.00000000;        %Link 5
	         0.00000000	 0.00001467  0.00000000;
	         0.00000000	 0.00000000  0.00002081];
    J{6} = [ 0.00002131  0.00000000  0.00000000;        %Link 6
	         0.00000000	 0.00003438  0.00000000;
	         0.00000000	 0.00000000  0.00002131];
    J{7} = [ 0.00004462  0.00000000  0.00000000;        %Gear 1
	         0.00000000	 0.00002740  0.00000000;
	         0.00000000	 0.00000000  0.00002740];
    J{8} = [ 0.00004462  0.00000000  0.00000000;        %Gear 2
	         0.00000000	 0.00002740  0.00000000;
	         0.00000000	 0.00000000  0.00002740];
    J{9} = [ 0.00003438  0.00000000  0.00000000;        %Gear 3
	         0.00000000	 0.00002131  0.00000000;
	         0.00000000	 0.00000000  0.00002131];
    J{10}= [ 0.00003438  0.00000000  0.00000000;        %Gear 4
	         0.00000000	 0.00002131  0.00000000;
	         0.00000000	 0.00000000  0.00002131];
    
    
    %          Forward kinematics
    %Relative Positions
    rBfromI = [ 0.00000000; 0.00000000; 0.00000000];
    r1fromB = [ 0.00000000; 0.00000000; 0.12275000];
    r2from1 = [ 0.00000000; 0.00000000; 0.00000000];
    r3from2 = [ 0.00000000; 0.25000000; 0.00000000];
    r4from3 = [ 0.00000000; 0.20000000; 0.00000000];
    r5from4 = [ 0.00000000; 0.07000000; 0.00000000];
    r6from5 = [ 0.00000000; 0.04750000; 0.00000000];
    rG1from1 = [ 0.03590000; 0.00000000;  0.00000000];
    rG2from1 = [-0.03590000; 0.00000000; 0.00000000];
    rG3from5 = [ 0.04750000; 0.00000000; 0.00000000];
    rG4from5 = [-0.04750000; 0.00000000; 0.00000000];
    
    %Store orientations in cell array
    rn{1} = r1fromB;
    rn{2} = r2from1;
    rn{3} = r3from2;
    rn{4} = r4from3;
    rn{5} = r5from4;
    rn{6} = r6from5;
    rn{7} = rG1from1;
    rn{8} = rG2from1;
    rn{9} = rG3from5;
    rn{10} = rG4from5;

    %Orientations wrt I
    TB = eye(3);
    T{1} = TB*rotz(theta(1));
    T{2} = T{1}*rotx(theta(2));
    T{3} = T{2}*rotx(theta(3));
    T{4} = T{3}*roty(theta(4));
    T{5} = T{4}*rotx(theta(5));
    T{6} = T{5}*roty(theta(6));
    T{7} = T{1}*rotx(theta(1));           %Gear 1
    T{8} = T{1}*rotx(-theta(1));          %Gear 2
    T{9} = T{5}*rotx(-theta(6));          %Gear 3
    T{10} = T{5}*rotx(theta(6));          %Gear 4

    %Positions wrt I
    rB = rBfromI;
    r{1} = rB + TB*r1fromB;
    r{2} = r{1} + T{1}*r2from1;
    r{3} = r{2} + T{2}*r3from2;
    r{4} = r{3} + T{3}*r4from3;
    r{5} = r{4} + T{4}*r5from4;
    r{6} = r{5} + T{5}*r6from5;
    r{7} = r{1} + T{1}*rG1from1;        %Gear 1 
    r{8} = r{1} + T{1}*rG2from1;        %Gear 2
    r{9} = r{5} + T{5}*rG3from5;        %Gear 3 
    r{10}= r{5} + T{5}*rG4from5;        %Gear 4 
    
    
    %              Recursive Kinematics
    Jb0 = zeros(6);
    Jbdot0 = zeros(6);
    
    for ii = 1:10
        if ii == 1        
            Jmat = Jb0;
            wI = Jmat(1:3,:)*thetadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Meiosis(Jb0,Jbdot0,theta,thetadot,TB,rn{ii},zeros(3,1),wI,ii);
        elseif ii == 7
            Jmat = Jb{1};
            wI = Jmat(1:3,:)*thetadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Meiosis(Jb{1},Jbdot{1},theta,thetadot,T{1},rn{ii},zeros(3,1),wI,ii);
        elseif ii == 8
            Jmat = Jb{1};
            wI = Jmat(1:3,:)*thetadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Meiosis(Jb{1},Jbdot{1},theta,thetadot,T{1},rn{ii},zeros(3,1),wI,ii);
        elseif ii == 9
            Jmat = Jb{5};
            wI = Jmat(1:3,:)*thetadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Meiosis(Jb{1},Jbdot{5},theta,thetadot,T{5},rn{ii},zeros(3,1),wI,ii);
        elseif ii == 10
            Jmat = Jb{5};
            wI = Jmat(1:3,:)*thetadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Meiosis(Jb{1},Jbdot{5},theta,thetadot,T{5},rn{ii},zeros(3,1),wI,ii);
        else
            Jmat = Jb{ii-1};
            wI = Jmat(1:3,:)*thetadot;
            [Jb{ii},Jbdot{ii}] = Next_GeoJac_Meiosis(Jb{ii-1},Jbdot{ii-1},theta,thetadot,T{ii-1},rn{ii},zeros(3,1),wI,ii);
        end
        
        Jmat = Jb{ii};
        wI = Jmat(1:3,:)*thetadot;
        
        Hmat = Jb{ii}.'*[J{ii},skew(Gam{ii})*T{ii}.';T{ii}*skew(Gam{ii}).',m{ii}*eye(3)]*Jb{ii};
        dvec = Jb{ii}.'*[J{ii},skew(Gam{ii})*T{ii}.';T{ii}*skew(Gam{ii}).',m{ii}*eye(3)]*Jbdot{ii}*thetadot + Jb{ii}.'*[cross(wI,J{ii}*wI);T{ii}*cross(wI,cross(wI,Gam{ii}))];
        g = Jb{ii}.'*[cross(rcm{ii},T{ii}.'*[0;0;-m{ii}*9.81]);[0;0;-m{ii}*9.81]];
        
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