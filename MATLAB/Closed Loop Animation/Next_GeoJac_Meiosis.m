function [JbN,JbNdot] = Next_GeoJac_Meiosis(Jb,Jbdot,gamma,gammadot,TI,rn,rndot,wI,link)

    Ihat = zeros(3,length(gamma));
    Itilda = zeros(3,length(gamma));
    
    %link = 8 corresponds to the screen
    %
    switch link
        case 1
            Ihat(3,1) = 1;
            Tn = rotz(gamma(1));
        case 2
            Ihat(1,2) = 1;
            Tn = rotx(gamma(2));
        case 3
            Ihat(1,3) = 1;
            Tn = rotx(gamma(3));
        case 4
            Ihat(2,4) = 1;
            Tn = roty(gamma(4));
        case 5
            Ihat(1,5) = 1;
            Tn = rotx(gamma(5));
        case 6
            Ihat(2,6) = 1;
            Tn = roty(gamma(6));
        case 7                      %Gear 1
            Ihat(1,1) = 1;
            Tn = rotx(gamma(1));
        case 8                      %Gear 2
            Ihat(1,1) = 1;
            Tn = rotx(-gamma(1));
        case 9                      %Gear 3
            Ihat(1,1) = 1;
            Tn = rotx(-gamma(6));
        case 10                     %Gear 4
            Ihat(1,1) = 1;
            Tn = rotx(gamma(6));
            
    end
    
    %GeoJac Matrices
    mat1 = [Tn.',zeros(3);-TI*skew(rn),eye(3)];
    mat2 = [Ihat;TI*Itilda];
    
    JbN = mat1*Jb + mat2;
    
    %GeoJacdot matrices
    mat1 = [           -skew(Ihat*gammadot)*(Tn.'), zeros(3);
            -TI*skew(wI)*skew(rn) - TI*skew(rndot), zeros(3)];
    mat2 = [        Tn.', zeros(3);
            -TI*skew(rn), eye(3)];
    mat3 = [           zeros(3,6);
            TI*skew(wI)*Itilda];
    
    JbNdot = mat1*Jb + mat2*Jbdot + mat3;
         
end