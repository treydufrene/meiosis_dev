function [rd, rdotd, rddotd] = Circle_path()

    n = 100;
    r = 50;
    centerX = 0;
    centerY = 350;
    t0 = 0;
    tf = 10;
    %t = linspace(t0,tf,n);
    t = t0:0.01:tf;
    w = 4*pi/(tf - t0);
    
    for ii = 1:length(t)
       xd(ii) = centerX + r*cos(w*t(ii));
       yd(ii) = centerY + r*sin(w*t(ii));
       zd(ii) = 0;
       
       xdotd(ii) = -r*w*sin(w*t(ii))/1000;
       ydotd(ii) = r*w*cos(w*t(ii))/1000;
       zdotd(ii) = 0;
       
       xddotd(ii) = -r*w^2*cos(w*t(ii))/1000;
       yddotd(ii) = -r*w^2*sin(w*t(ii))/1000;
       zddotd(ii) = 0;
       
    end
    
    rd = [xd;yd;zd];
    rdotd = [xdotd;ydotd;zdotd];
    rddotd = [xddotd;yddotd;zddotd];

end 