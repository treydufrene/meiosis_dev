clear all
close all
clc

theta1 = linspace(-pi/2, pi/2, 20);
mat = [theta1;zeros(5,length(theta1))];

for ii = 1:length(theta1)
%    for jj = 1:delta_t:29%(length(b))
%for jj = (length(b)-1):length(b)
    clf(gcf)
    %plot3(x(1:jj),y(1:jj),z(1:jj),'r.')
    hold on
    Meiosis_draw2(mat(:,ii))
    F(ii) = getframe(gcf);
    %pause(0.001)
    %ii = ii + 1;
end