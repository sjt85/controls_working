load bollard.mat
bollard(:,2) = bollard(:,2).*9.807;
bollard(:,2) = bollard(:,2).*0.4161;

% Coefficients at 12V
T200_12F = [0.000250136874736; 0.076253010080822; 0];        
T200_12R = [-0.000246067240275; 0.057220152975021; 0];             
                   
                   
% BlueRobotics vs. Bollard Pull Thrusts

T200_148F(1) = T200_12F(1)*(14.8/12)^2;
T200_148F(2) = T200_12F(2)*(14.8/12);
T200_148F(3) = 0;
pwm = linspace(0,255);

T200_148F_fit = polyval(T200_148F,pwm);
T200_148F_act = polyval([0.0002362; 0.09939; 0],pwm);

close all
figure
hold on; box on;
axis([0,300,0,60])
plot(pwm,T200_148F_fit,'--k')
plot(bollard(1:28,1),bollard(1:28,2),'o')
plot(pwm,T200_148F_act,'-k')

legend('BlueRobotics Data','Bollard Pull Results',...
    sprintf( '%s\n%s','0.000236x^2 + 0.0994x', 'R^2 = 0.988'),...
    'Location', 'NorthWest')
xlabel('PWM')
ylabel('Thruster Force [N]')
hold off


% Reverse

T200_148R(1) = T200_12R(1)*(14.8/12)^2;
T200_148R(2) = T200_12R(2)*(14.8/12);
T200_148R(3) = 0;
pwm = linspace(0,-255);


bollard(36:59,2) = -bollard(36:59,2);
T200_148R_fit = polyval(T200_148R,pwm);
T200_148R_act = polyval([-0.0002312; 0.05456; 0],pwm);



figure
hold on; box on;
%axis([0,300,0,60])
plot(pwm,T200_148R_fit,'--k')
plot(bollard(36:59,1),bollard(36:59,2),'o')
plot(pwm,T200_148R_act,'-k')

legend('BlueRobotics Data','Bollard Pull Results',...
    sprintf( '%s\n%s','-0.000231x^2 + 0.0546x', 'R^2 = 0.976'),...
    'Location', 'NorthWest')
xlabel('PWM')
ylabel('Thruster Force [N]')
hold off



