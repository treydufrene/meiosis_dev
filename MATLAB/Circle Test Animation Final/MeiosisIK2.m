function [gammadmat, gammadotdmat, gammaddotdmat] = MeiosisIK2(rd,rdotd,rddotd,R)

    for ii = 1:length(rd)
        
        gammad = MeiosisIK(rd(:,ii),R);
        
        J = Meiosis_GeoJac(gammad);
        we = zeros(3,1);
        wedot = zeros(3,1);
        gammadotd = J\[we;rdotd(:,ii)];

        Jdot = Meiosis_GeoJacdot(gammad,gammadotd);

        gammaddotd = J\([wedot;rddotd(:,ii)] - Jdot*gammadotd);
        
        gammadmat(:,ii) = gammad;
        gammadotdmat(:,ii) = gammadotd;
        gammaddotdmat(:,ii) = gammaddotd;
        
    end

end