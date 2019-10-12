function meiosis_draw(gamma) %meiosis drawer
theta1=gamma(1); 
theta2=gamma(2); 
theta3=gamma(3);
theta4=gamma(4); 
theta5=gamma(5); 
theta6=gamma(6);

h=clf(gcf); %get current figure and clear current figure
Floor_v=[-1 1 0;... 
        1 1 0;...
        -1 -1 0;...
        1 -1 0]; 
Floor_f=[1 2 4 3];

% patch('Faces',Floor_f,'Vertices',Floor_v,'EdgeColor','None','FaceColor',[0 0 .8],'FaceAlpha',.5); 
hold on
set(gcf, 'Position', [50, 50, 950, 900])

[Base, Base_f, n, c, stltitle] = stlread('Base.stl'); 
[Link1, Link1_f, n, c, stltitle] = stlread('Link1.stl'); 
[Link2, Link2_f, n, c, stltitle] = stlread('Link2.stl'); 
[Link3, Link3_f, n, c, stltitle] = stlread('Link3.stl'); 

%Relative Positions:
rBfromI=[0;0;0]; %place inertial frame at base 
r1fromB=[0;0;8];
r2from1=[0;...
        -2;...
        14]; 
r3from2=[0;...
        25;... 
        0];

%Orientations wrt I:
T1 = rotz(gamma(1));%roty((pi)/2);
T2 = T1*rotz(gamma(2))*roty((pi)/2);
T3 = T2*rotz(gamma(3));

% T4 = T3*rotz(gamma(4))*rotx((pi)/2);
% T5 = T4*rotz(gamma(5))*rotx(-(pi)/2);
% T6 = T5*rotz(gamma(6));

%Positions wrt I:
rB=rBfromI; 
r1=rB+r1fromB; 
r2=r1+T1*r2from1; 
r3=r2+T2*r3from2;

%Transform the stl coordinates based upon FK
Base_v=repmat(rB,1,length(Base))+Base'; 
Link1_v=repmat(r1,1,length(Link1))+T1*Link1'; 
Link2_v=repmat(r2,1,length(Link2))+T2*Link2'; 
Link3_v=repmat(r3,1,length(Link3))+T3*Link3';

patch('Faces',Base_f,'Vertices',Base_v','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]); 
patch('Faces',Link1_f,'Vertices',Link1_v','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]); 
patch('Faces',Link2_f,'Vertices',Link2_v','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]); 
patch('Faces',Link3_f,'Vertices',Link3_v','EdgeColor','None','FaceColor',[0.792157 0.819608 0.933333]);

axis equal
camlight left 
set(gca,'projection','perspective') 
view(3)
hold off
end