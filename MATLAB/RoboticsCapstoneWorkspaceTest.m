% Lengths in mm
clc;
clear;
close all;

L2 = 250;
L3 = 280;
LE = 52.5;
% x = L2*cosd(t2) + L3*cosd(t3) + LE*cosd(tE)
% y = L2*sind(t2) + L3*sind(t3) + LE*sind(tE)
% r = sqrt(x^2 + y^2)
% % plot r values and see if there is a gap
i = 1;
% for t1 = 0:360
    for t2 = -10:189
        for t3 = -114:1:114
            for tE = -114:1:114
                x(i) = L2*cosd(t2) + L3*cosd(t2+t3) + LE*cosd(t2+t3+tE);
                y(i) = L2*sind(t2) + L3*sind(t2+t3) + LE*sind(t2+t3+tE);
%                 z(i) = 
    %             r(i) = sqrt(x^2 + y^2);
    %             y1(i) = i;
                 i = i + 1;
            end
        end     
    end
% end
figure(1)
plot(x, y, 'b.')
hold on
