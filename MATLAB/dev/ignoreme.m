% Desired orientation and position (gamma = 0)
% R = [0 1 0;...
%      0 0 1;...
%      1 0 0];
% od = [0;...
%       58.25;...
%       22.0800];
% R = T(1:3,1:3,6);
% od = T(1:3,4,6);
% % Wrist Center:
% oc = od - l6*R*[0;0;1];
% xc = (oc(1));
% yc = (oc(2));
% zc = (oc(3));

% Left Arm:
% t1 = atan2(yc,xc) - atan2(offset,sqrt(xc^2 + yc^2 - offset^2));
% % Right Arm:
% % t1 = atan2(yc,xc) - atan2(-offset,-sqrt(xc^2 + yc^2 - offset^2))
% % 
% D = round((xc^2 + yc^2 - offset^2 + (zc - l1)^2 - (l2)^2 - (l3+l4)^2) / (2*(l2)*(l3+l4)),4);
% t3 = atan2(sqrt(1-D^2),D);
% t2 = atan2(zc-l1,sqrt(xc^2 + yc^2 - offset^2)) - atan2(l3*sin(t3),l2 + l3*cos(t3));
% 
% R03 = [cos(t1)*cos(t2+t3), -cos(t1)*sin(t2+t3), sin(t1);...
%        sin(t1)*cos(t2+t3), -sin(t1)*sin(t2+t3), -cos(t1);...
%        sin(t2+t3), cos(t2+t3), 0];
% 
% R36 = R03'*R;
% 
% R = euler;
% % 
% % Inverse Orientation
% t4 = atan2(-cos(t1)*sin(t2+t3)*R(1,3)-sin(t1)*sin(t2+t3)*R(2,3)+cos(t2+t3)*R(3,3),...
%             cos(t1)*cos(t2+t3)*R(1,3)+sin(t1)*cos(t2+t3)*R(2,3)+sin(t2+t3)*R(3,3));
% 
% t5 = atan2(sqrt(1-(sin(t1)*R(1,3)-cos(t1)*R(2,3))^2),sin(t1)*R(1,3)-cos(t1)*R(2,3));
% 
% t6 = atan2(sin(t1)*R(1,2)-cos(t1)*R(2,2),-sin(t1)*R(1,1)+cos(t1)*R(2,1));
% % 
% gamma = [t1;t2;t3;t4;t5;t6];
% fprintf('gamma = \t q = \n')
% disp([gamma,q])
% % meiosis_draw(gamma)