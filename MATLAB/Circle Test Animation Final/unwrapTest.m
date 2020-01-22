clear all
close all
clc

t4 = pi;

while t4 > pi/2
    t4 = t4 - pi;
end

while t4 < -pi/2
    t4 = t4 + pi;
end

display(t4)