function gamma = MeiosisInverseKinematics(p,o)
    if sum(p == [0;0;0]) == 3
        gamma = 'error';
    else
        gamma = [0;0;0;0;0;0];
    end
end