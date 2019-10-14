function [N, E] = quat(phi)
    
    % INPUT
    % phi = Euler Angles
    
    % OUTPUT
    % N = q0
    % E = [q1; q2; q3]
    
    R = rotzr(phi(1))*rotyr(phi(2))*rotzr(phi(3));
    N = sqrt(trace(R)+1)/2;
    E = [(R(3,2) - R(2,3))/(4*N);
          (R(1,3) - R(3,1))/(4*N);
          (R(2,1) - R(1,2))/(4*N)];
end