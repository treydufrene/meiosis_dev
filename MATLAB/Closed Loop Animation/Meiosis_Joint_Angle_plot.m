function Meiosis_Joint_Angle_plot(b,gammad,t,Title)
    
    % Plot joint angle 1
    subplot(4,2,1)
    hold on
    plot(t, b(1,:),'b');
    plot(t, gammad(1,:),'r--')
    title('First Joint Angle vs. Time');
    xlabel('Time (s)');
    ylabel('\theta_1 (rad)');
    legend('\theta','\theta_d')

    % Plot joint angle 2
    subplot(4,2,2)
    hold on
    plot(t, b(2,:),'b')
    plot(t, gammad(2,:),'r--')
    title('Second Joint Angle vs. Time');
    xlabel('Time (s)');
    ylabel('\theta_2 (rad)');
    legend('\theta','\theta_d','Location','Southeast')

    % Plot joint 3 movment
    subplot(4,2,3)
    hold on
    plot(t, b(3,:),'b')
    plot(t, gammad(3,:),'r--')
    title('Third Joint Angle vs. Time');
    xlabel('Time (s)');
    ylabel('\theta_3 (rad)');
    legend('\theta','\theta_d')

    % Plot joint 4 movment
    subplot(4,2,4)
    hold on
    plot(t, b(4,:),'b')
    plot(t, gammad(4,:),'r--')
    title('Fourth Joint Angle vs. Time');
    xlabel('Time (s)');
    ylabel('\theta_4 (rad)');
    legend('\theta','\theta_d','Location','Southeast')

    % Plot joint 5 movment
    subplot(4,2,5)
    hold on
    plot(t, b(5,:),'b')
    plot(t, gammad(5,:),'r--')
    title('Fifth Joint Angle vs. Time');
    xlabel('Time (s)');
    ylabel('\theta_5 (rad)');
    legend('\theta','\theta_d','Location','Southeast')
    
    % Plot joint 6 movment
    subplot(4,2,6)
    hold on
    plot(t, b(6,:),'b')
    plot(t, gammad(6,:),'r--')
    title('Sixth Joint Angle vs. Time');
    xlabel('Time (s)');
    ylabel('\theta_6 (rad)');
    legend('\theta','\theta_d','Location','Southeast')

    
%     annotation('textbox', [0 0.9 1 0.1], ...
%     'String', Title, ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')

end