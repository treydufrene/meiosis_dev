function [dotr,w] = MeiosisVelocity(T,r,gamma,dotgamma)

    dotr = simplify(jacobian(r,gamma)*dotgamma);
    
    Jw = [T(:,3).'*jacobian(T(:,2),gamma);...
          T(:,1).'*jacobian(T(:,3),gamma);...
          T(:,2).'*jacobian(T(:,1),gamma)];

    M = simplify(Jw,'steps',200,'criterion','preferReal');

    w = simplify(M*dotgamma);

end



