% Develops least squares fits for T100 and T200 data, plots them, and
% outputs the coefficients to be used in the vehicle controllers

% First do the T100 data from BlueRobotics
load 'T100_data.mat'
% Column 1 is time-based duty cycle, column 2 is thrust in kgf
T100_data(:,2) = T100_data(:,2)*9.807;  % We want units of newtons
T100_reverse = T100_data(1:39,:);
T100_forward = T100_data(42:80,:);

T100_forward(:,1) = (T100_forward(:,1)-1525)*255/375;
T100_forward(1,1) = 0;

T100_reverse(:,1) = (T100_reverse(:,1)-1475)*255/375;
T100_reverse(39,1) = 0;
T100_reverse(:,2) = T100_reverse(:,2);

%% Forward T100

% Do some polyfits.  Force a zero intercept
[T100F, ConNum, theta] = polylsq(T100_forward(:,1),T100_forward(:,2),39,2);   
T100F = [flip(T100F);0];  % Remember we have to compress this horizontally
pwm = 0:255;   
T100f_fit = polyval(T100F,pwm);


% Plot the forward to see what it's like
close all
figure
hold on
box on
plot(pwm,T100f_fit,'k')
plot(T100_forward(:,1),T100_forward(:,2),'o')
xlabel('PWM')
ylabel('Thrust [N]')
title('Thrust curve for T100 at 12V Forward')

hold off

% Finds curve for 14.8V
T100F(1) = T100F(1)*(14.8/12)^2;
T100F(2) = T100F(2)*14.8/12

%% Now do the reverse

% Do some polyfits.  Force a zero intercept
[T100R, ConNum, theta] = polylsq(T100_reverse(:,1),T100_reverse(:,2),39,2);   
T100R = [flip(T100R);0];  % Remember we have to compress this horizontally
pwm = -(0:255);
T100r_fit = polyval(T100R,pwm);

figure
hold on
box on
plot(pwm,T100r_fit,'k')
plot(T100_reverse(:,1),T100_reverse(:,2),'o')
xlabel('PWM')
ylabel('Thrust [N]')
title('Thrust curve for T100 at 12V Reverse')

hold off

T100R(1) = T100R(1)*(14.8/12)^2;
T100R(2) = T100R(2)*14.8/12


%% T200

load 'T200_data.mat'
% Column 1 is time-based duty cycle, column 2 is thrust @12V, 3 at 16V
T200_data(:,2) = T200_data(:,2)*4.44822; % Convert from pounds to newtons
T200_data(:,3) = T200_data(:,3)*4.44822;
T200_reverse = T200_data(1:39,:);
T200_forward = T200_data(43:81,:);

T200_forward(:,1) = (T200_forward(:,1)-1525)*255/375;
T200_forward(1,1) = 0;

T200_reverse(:,1) = (T200_reverse(:,1)-1475)*255/375;
T200_reverse(39,1) = 0;
T200_reverse(:,2) = T200_reverse(:,2);


% T200 12V Forward Polyfit
[T200_12F, ConNum, theta] = polylsq(T200_forward(:,1),T200_forward(:,2),39,2);   
T200_12F = [flip(T200_12F);0]
T200_12F(1) = T200_12F(1)*16/9;
T200_12F(2) = T200_12F(2)*4/3;
pwm = 0:255;   
T200_12f_fit = polyval(T200_12F,pwm);

% T200 16V Forward Polyfit
[T200_16F, ConNum, theta] = polylsq(T200_forward(:,1),T200_forward(:,3),39,2);   
T200_16F = [flip(T200_16F);0];
T200_16f_fit = polyval(T200_16F,pwm);

figure
hold on
box on
plot(T200_forward(:,1),T200_forward(:,3),'o')
plot(pwm,T200_12f_fit)
plot(pwm,T200_16f_fit)
legend('Data','12V extrapolated','16V fit','location','northwest')
xlabel('PWM')
ylabel('Thrust [N]')
title('Thrust curve for T200 Forward at 16V')

hold off





% T200 12V Reverse Polyfit
[T200_12R, ConNum, theta] = polylsq(T200_reverse(:,1),T200_reverse(:,2),39,2);   
T200_12R = [flip(T200_12R);0]
T200_12R(1) = T200_12R(1)*16/9;
T200_12R(2) = T200_12R(2)*4/3;

pwm = -(0:255);   
T200_12r_fit = polyval(T200_12R,pwm);

% T200 16V Reverse Polyfit
[T200_16R, ConNum, theta] = polylsq(T200_reverse(:,1),T200_reverse(:,3),39,2);   
T200_16R = [flip(T200_16R);0];
T200_16r_fit = polyval(T200_16R,pwm);

figure
hold on
box on
plot(T200_reverse(:,1),T200_reverse(:,3),'o')
plot(pwm,T200_12r_fit)
plot(pwm,T200_16r_fit)
legend('Data','12V extrapolated','16V fit','location','northwest')
xlabel('PWM')
ylabel('Thrust [N]')
title('Thrust curve for T200 Reverse at 16V')

hold off


