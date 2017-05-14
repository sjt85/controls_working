% Artemis sway ID
% Makes our pretty subplot
% Loads the drag and speed values
% Plots them, gets polynomial

load('f_y.mat');
load('t_z.mat');
load('t_x.mat');
load('vely.mat');

f_y = control_internal_wrenchf_y(1.67e4 : 2.35e4);
t_x = control_internal_wrencht_x(1.67e4 : 2.35e4);
t_z = control_internal_wrencht_z(1.67e4 : 2.35e4);
vely = kalmanvely(1.67e4 : 2.35e4);


close all
figure

subplot(4,1,1)
plot(vely);
grid on
ylabel('Sway [m/s]')

subplot(4,1,2)
plot(f_y)
grid on
ylabel('W_y [N]')

subplot(4,1,3)
plot(t_x)
grid on
ylabel('T_x [Nm]')
xlabel('Time')

subplot(4,1,4)
plot(t_z)
grid on
ylabel('T_z [Nm]')
xlabel('Time')

hold off



sway_speed = [0; .07; -.138; .35; -.5; .58; -.5; .55];
W_y = [0; 7.8; -18; 42; -79; 95; -79; 95];
T_z = [-1.5; -.33; 0; -1.38; 1.14; 4.5; -3.2; 4.9];
T_x = [1.4; 1.45; 1.5; 1.18; 1.99; 1.0; 1.83; .84];

x = linspace(0,.6,500);
pfit = polyval([152.1, 80.99, 0],x);
orig = 400*x.^2;

figure
hold on
box on
plot(abs(sway_speed), abs(W_y),'o')
plot(x,orig,'--k')
plot(x,pfit,'-k')
xlabel('Sway Speed [m/s]')
ylabel('Drag [N]')

legend('Sway Data','Originally Assumed',...
    sprintf( '%s\n%s','152.1v^2 + 80.99v', 'R^2 = 0.994'),...
    'Location', 'NorthWest')
hold off


figure
subplot(2,1,1)
plot(W_y,T_z,'o')
ylabel('Heading Torque [Nm]')

x = linspace(-100,100,500);
pfit2 = polyval([-.005668, 1.444],x);

subplot(2,1,2)
hold on; box on
plot(W_y,T_x,'o')
plot(x,pfit2,'-k')
legend('Roll Torque',sprintf( '%s\n%s','-.005668F + 1.444', 'R^2 = 0.968')...
    ,'Location', 'NorthEast')
ylabel('Roll Torque [Nm]')
xlabel('Sway Drag [N]')
hold off



