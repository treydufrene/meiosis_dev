function AnimationCheck()

    gamma = zeros(6,200);
    dtheta = pi/100;
    for ii = 2:200
        gamma(1,ii) = gamma(1,ii-1) + dtheta;

        Meiosis_draw2(gamma(:,ii));
        pause(0.001)
    end

end