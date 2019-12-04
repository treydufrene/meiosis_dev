function [thetad,thetaddot] = Meiosis_pathgen(xDes,yDes,zDes,t)

    r = [xDes.',yDes.',zDes.'];

    ii = 1;

    while (ii < length(xDes))
        coeff(:,ii) = cubicSpline(t(ii), r(ii,:), [0 0 0], t(ii+1), r(ii+1,:), [0 0 0]);
        ii = ii + 1;
    end

    jj = 1;

    for tt = 0 : 1 : 300
        if ((tt/10) == t(jj) && (tt ~= 300))
            c = coeff(:,jj);
            jj = jj+1;
        end

        x(tt + 1) = c(1) + c(4)*(tt/10) + c(7)*((tt/10)^2) + c(10)*((tt/10)^3);
        xdot(tt + 1) = c(4)/10 + c(7)*tt/5 + c(10)*(3*(tt/10)^2);
        y(tt + 1) = c(2) + c(5)*(tt/10) + c(8)*((tt/10)^2) + c(11)*((tt/10)^3);
        ydot(tt + 1) = c(5)/10 + c(8)*tt/5 + c(11)*(3*(tt/10)^2);
        z(tt + 1) = c(3) + c(6)*(tt/10) + c(9)*((tt/10)^2) + c(12)*((tt/10)^3);
        zdot(tt + 1) = c(6)/10 + c(9)*tt/5 + c(12)*(3*(tt/10)^2);
        

    end

    
    %Calculate Joint Angles
    for ii = 1:length(x)
        [thetad(:,ii),errorCheck] = MeiosisIK([xDes(ii);yDes(ii);zDes(ii)],R);
        
        if errorCheck == 1
            break
        end
        thetaddot(:,ii) = Meiosis_InverseVelocity(
    end

 


end