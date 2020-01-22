function Meiosis_draw2(gamma,clr)
    
    if exist('clr','var')
        if (clr == 'clear') | (clr == 'Clear')
            clf(gcf);
        end
    end
    
    Floor_v = [-.3 .4 0;...
                .3 .4 0;...
               -.3 .2 0;...
                .3 .2 0];
    Floor_f = [1 2 4 3];

    set(gcf, 'Position', [50, 50, 950, 900])
     axis equal
    camlight(180,90)
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'XColor','none')
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'YColor','none')
    set(gca,'ztick',[])
    set(gca,'zticklabel',[])
    set(gca,'ZColor','none')
    set(gca,'Color','none')
    
    set(gca,'projection','perspective')
    view(140,45)
    axis([-0.4 0.4 -0.2 0.7 0 0.4])
    hold on
    patch('Faces',Floor_f,'Vertices',Floor_v,'EdgeColor','None','FaceColor','white');%,'FaceAlpha',.5);
    
   
    [Base,  Base_f]    = stlread('STL/Base.stl');
    [Link1, Link1_f]   = stlread('STL/Link1.stl');
    [Link2, Link2_f]   = stlread('STL/Link2new.stl');
    [Link3, Link3_f]   = stlread('STL/Link3.stl');
    [Link4, Link4_f]   = stlread('STL/Link4.stl');
    [Link5, Link5_f]   = stlread('STL/Link5.stl');
    [Link6, Link6_f]   = stlread('STL/Link6.stl');
    [Gear1, Gear1_f]   = stlread('STL/Gear1.stl');
    [Gear2, Gear2_f]   = stlread('STL/Gear2.stl');
    [Gear3, Gear3_f]   = stlread('STL/Gear3.stl');
    [Gear4, Gear4_f]   = stlread('STL/Gear4.stl');
    [Link2tube, Link2tube_f]   = stlread('STL/Link2tube.stl');
    [Link3tube, Link3tube_f]   = stlread('STL/Link3tube.stl');
    [Pulley1, Pulley1_f] = stlread('STL/Pulley1.stl');
    [Pulley2, Pulley2_f] = stlread('STL/Pulley2.stl');
    [Link4motors, Link4motors_f]   = stlread('STL/Link4motors.stl');
    [Link6motor, Link6motor_f]   = stlread('STL/Link6motor.stl');
    [Link2belt, Link2belt_f]   = stlread('STL/Link2belt.stl');
    [Link3belt, Link3belt_f]   = stlread('STL/Link3belt.stl');
    
    %          Forward kinematics
    %Relative Positions
    rBfromI =  [ 0.00000000; 0.00000000; 0.00000000];
    r1fromB =  [ 0.00000000; 0.00000000; 0.12275000];
    r2from1 =  [ 0.00000000; 0.00000000; 0.00000000];
    r3from2 =  [ 0.00000000; 0.26000000; 0.00000000];
    r4from3 =  [ 0.00000000; 0.20000000; 0.00000000];
    r5from4 =  [ 0.00000000; 0.07000000; 0.00000000];
    r6from5 =  [ 0.00000000; 0.09600000; 0.00000000];
    rG1from1 = [ 0.09055000; 0.00000000; 0.00000000];
    rG2from1 = [-0.09055000; 0.00000000; 0.00000000];
    rG3from5 = [ 0.04700000; 0.00000000; 0.00000000];
    rG4from5 = [-0.04700000; 0.00000000; 0.00000000];
    
    %Orientations wrt I
    TB = eye(3);
    T{1} = TB*rotz(gamma(1));
    T{2} = T{1}*rotx(gamma(2));
    T{3} = T{2}*rotx(gamma(3));
    T{4} = T{3}*roty(gamma(4));
    T{5} = T{4}*rotx(gamma(5));
    T{6} = T{5}*roty(gamma(6));
    T{7} = T{1}*rotx(-gamma(1));        %Gear 1
    T{8} = T{1}*rotx(gamma(1));         %Gear 2
    T{9} = T{5}*rotx(-gamma(6));        %Gear 3
    T{10} = T{5}*rotx(gamma(6));        %Gear 4

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
   
    %Transform the stl coordinates based upon FK
    Base_v   = repmat(rB,1,length(Base)) + Base';
    Link1_v  = repmat(r{1},1,length(Link1)) + T{1}*Link1';
    Link2_v  = repmat(r{2},1,length(Link2)) + T{2}*Link2';
    Link2tube_v  = repmat(r{2},1,length(Link2tube)) + T{2}*Link2tube';
    Link3_v  = repmat(r{3},1,length(Link3)) + T{3}*Link3';
    Link3tube_v  = repmat(r{3},1,length(Link3tube)) + T{3}*Link3tube';
    Link4_v  = repmat(r{4},1,length(Link4)) + T{4}*Link4';
    Link5_v  = repmat(r{5},1,length(Link5)) + T{5}*Link5';
    Link6_v  = repmat(r{6},1,length(Link6)) + T{6}*Link6';
    Gear1_v  = repmat(r{7},1,length(Gear1)) + T{7}*Gear1';
    Gear2_v  = repmat(r{8},1,length(Gear2)) + T{8}*Gear2';
    Gear3_v  = repmat(r{9},1,length(Gear3)) + T{9}*Gear3';
    Gear4_v  = repmat(r{10},1,length(Gear4)) + T{10}*Gear4';
    Pulley1_v  = repmat(r{7},1,length(Pulley1)) + T{7}*Pulley1';
    Pulley2_v  = repmat(r{8},1,length(Pulley2)) + T{8}*Pulley2';
    Link4motors_v  = repmat(r{4},1,length(Link4motors)) + T{4}*Link4motors';
    Link6motor_v  = repmat(r{6},1,length(Link6motor)) + T{6}*Link6motor';
    Link2belt_v  = repmat(r{2},1,length(Link2belt)) + T{2}*Link2belt';
    Link3belt_v  = repmat(r{3},1,length(Link3belt)) + T{3}*Link3belt';
    
    patch('Faces',Base_f, 'Vertices',Base_v', 'EdgeColor','None','FaceColor',[0 0.082353 1]);
    patch('Faces',Link1_f,'Vertices',Link1_v','EdgeColor','None','FaceColor',[0.901961 0.756863 0.035294]);
    patch('Faces',Link2_f,'Vertices',Link2_v','EdgeColor','None','FaceColor',[0 0.082353 1]);
    patch('Faces',Link2tube_f,'Vertices',Link2tube_v','EdgeColor','None','FaceColor',[0.5774    0.5774    0.5774]);
    patch('Faces',Link3_f,'Vertices',Link3_v','EdgeColor','None','FaceColor',[0.901961 0.756863 0.035294]);
    patch('Faces',Link3tube_f,'Vertices',Link3tube_v','EdgeColor','None','FaceColor',[0.5774    0.5774    0.5774]);
    patch('Faces',Link4_f,'Vertices',Link4_v','EdgeColor','None','FaceColor',[0 0.082353 1]);
    patch('Faces',Link5_f,'Vertices',Link5_v','EdgeColor','None','FaceColor',[0.901961 0.756863 0.035294]);
    patch('Faces',Link6_f,'Vertices',Link6_v','EdgeColor','None','FaceColor',[1 0.082353 0.082353]);
    patch('Faces',Gear1_f,'Vertices',Gear1_v','EdgeColor','None','FaceColor',[1 0.082353 0.082353]);
    patch('Faces',Gear2_f,'Vertices',Gear2_v','EdgeColor','None','FaceColor',[1 0.082353 0.082353]);
    patch('Faces',Gear3_f,'Vertices',Gear3_v','EdgeColor','None','FaceColor',[1 0.082353 0.082353]);
    patch('Faces',Gear4_f,'Vertices',Gear4_v','EdgeColor','None','FaceColor',[1 0.082353 0.082353]);
    patch('Faces',Pulley1_f,'Vertices',Pulley1_v','EdgeColor','None','FaceColor',[0.5774    0.5774    0.5774]);
    patch('Faces',Pulley2_f,'Vertices',Pulley2_v','EdgeColor','None','FaceColor',[0.5774    0.5774    0.5774]);
    patch('Faces',Link4motors_f,'Vertices',Link4motors_v','EdgeColor','None','FaceColor',[0.5774    0.5774    0.5774]);
    patch('Faces',Link6motor_f,'Vertices',Link6motor_v','EdgeColor','None','FaceColor',[0.5774    0.5774    0.5774]);
    patch('Faces',Link2belt_f,'Vertices',Link2belt_v','EdgeColor','None','FaceColor',[0 0 0]);
    patch('Faces',Link3belt_f,'Vertices',Link3belt_v','EdgeColor','None','FaceColor',[0 0 0]);
    
%     axis equal
%     camlight(180,90)
%     set(gca,'xtick',[])
%     set(gca,'xticklabel',[])
%     set(gca,'XColor','none')
%     set(gca,'ytick',[])
%     set(gca,'yticklabel',[])
%     set(gca,'YColor','none')
%     set(gca,'ztick',[])
%     set(gca,'zticklabel',[])
%     set(gca,'ZColor','none')
%     set(gca,'Color','none')
%     
%     set(gca,'projection','perspective')
%     view(140,45)
%     axis([-0.4 0.4 -0.2 0.7 0 0.4])
    %axis([-.1 .1 -.1 .1 0 .2])

    hold off
end