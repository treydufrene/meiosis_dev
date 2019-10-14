% y-z plane
% quarter circle

clc;
clear;
close all;

iDex = 1;
iNon = 1;
res = 1;

    for t2 = -0.174533:res:1.507 %limited to vertical full range 3.29867
        for t3 = -1.98968:res:1.98968
            for t4 = 0:res:1.507
                for t5 = 0:res:1.507
                    for tE = -1.98968:res:1.98968

                        X = FK([0 t2 t3 t4 t5 tE]);
                        X(1) = 0;                        
%                         meiosis_draw([0 t2 t3 t4 t5 tE])

                        if %arbitrary orientaion for position
                            xDex(iDex) = X(5);%y
                            yDex(iDex) = X(6);%z
                            iDex = iDex + 1;
                        else
                            xNon(iNon) = X(5);%y
                            yNon(iNon) = X(6);%z
                            iNon = iNon + 1;
                        end
                        
                    end
                end
            end
        end     
    end


figure(1)
plot(xDex, yDex, 'b.')
hold on
plot(xNon, yNon, 'r.')
