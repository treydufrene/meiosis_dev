function [q, posErr, oriErr] = meiosisNR(o, phi, q0)
    
    % INPUT
    % o = Desired Position (mm)
    % phi = Desired Orientation (Euler Angles, radians)
    % q0 = Starting Angles (radians)
    
    % OUTPUT
    % q = angles for desired orientation and position (degrees)
    % posErr = magnitude of position error
    % oriErr = magnitude of orientation error
    
    phid = phi;     % Desired orientation
    od = o;         % Desired position
    qc = q0;        % Current angles
    iterMax = 200;  % Max number of iteration
    dt = 0.05;      % Time interval
    
    
    Kp = 3*eye(3);
    Ko = 3*eye(3);
    K = [Kp         zeros(3);
         zeros(3)   Ko];
     
    [Nd, Ed] = quat(phid);
    
    for i = 1:iterMax
        
        [oc, phic] = currentPO(qc);
        [Nc, Ec] = quat(phic);

        J = sixDofJ(qc);
        posErr(:,i) = od - oc;
        oriErr(:,i) = (-Nd)*Ec + Nc*Ed - cross(Ed,Ec);
        error = [posErr(:,i); oriErr(:,i)];
        qc = qc + dt.*(J^(-1)) * K*error;
        
        q(:,i) = rad2deg(qc);

        if ((norm(posErr(:,i)) < 10^-5) && (norm(oriErr(:,i)) < 10^-5))
            break;
        end
    end
      
end