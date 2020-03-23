function [pos,R] = FK(gamma)
    T = zeros(3,3,6);
    T(:,:,1) = rotz(gamma(1));
    T(:,:,2) = T(:,:,1)*rotx(pi/2)*rotz(gamma(2));
    T(:,:,3) = T(:,:,2)*rotz(gamma(3));
    T(:,:,4) = T(:,:,3)*roty(pi/2)*rotz(pi/2)*rotz(gamma(4));
    T(:,:,5) = T(:,:,4)*rotx(-pi/2)*rotz(gamma(5));
    T(:,:,6) = T(:,:,5)*rotx(pi/2)*rotz(gamma(6));
    
    jointr(:,1) = [0;       0;       8];
    jointr(:,2) = [0;       0;   14.08];
    jointr(:,3) = [25;      0;      -1];
    jointr(:,4) = [20;      0;       0];
    jointr(:,5) = [0;       0;       8];
    jointr(:,6) = [0;       0;       0];
    jointr(:,7) = [0;       0;    5.25];

    r = zeros(3,7);
    r(:,1) = jointr(:,1);
    for i = 2:7
        r(:,i) = r(:,i-1) + T(:,:,i-1)*jointr(:,i);
    end
    
    q_0 = sqrt(trace(T(:,:,6) + 1))/2;
    if(q_0 ~= 0)
        q_1 = (T(3,2,6) - T(2,3,6))/(4*q_0);
        q_2 = (T(1,3,6) - T(3,1,6))/(4*q_0);
        q_3 = (T(2,1,6) - T(1,2,6))/(4*q_0);
    end
    if(q_0 == 0)
        q_1 = sqrt((T(1,1,6) + 1)/2);
        q_2 = sqrt((T(2,2,6) + 1)/2);
        q_3 = sqrt((T(3,3,6) + 1)/2);
    end
    
    pos = r(:,7);
    R = T(:,:,6);
%     ori = [q_0;q_1; q_2; q_3];
%     X = [ori;pos];
end