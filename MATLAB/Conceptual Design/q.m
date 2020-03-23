function [qR] = q(theta,axis)
qR = [cos(theta/2);0;0;0];

if axis == 'x'
  k = 2;
else
    if axis == 'y'
    k = 3;
    else
        if axis == 'z'
            k = 4;
        end
    end
end

qR(k) = sin(theta/2);

end