function [R] = rotxd4(theta)
R = [1 0 0 0;
    0 cosd(theta) -sind(theta) 0;
    0 sind(theta) cosd(theta) 0;
    0 0 0 1];
end