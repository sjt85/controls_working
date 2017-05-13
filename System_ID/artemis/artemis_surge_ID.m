% TODO  some other plots

load drag_curves.mat

drag_curves = abs(drag_curves);
[B,I] = sort(drag_curves(:,1));
B(:,2) = drag_curves(I,2);
B(:,3) = drag_curves(I,3);


x = linspace(0,.9,500);
orig = 200*x.^2;
pfit = polyval([21.54, 88.25, 0],x);

% Drag(speed)
close all
figure(1)
hold on; box on
plot(B(:,1),B(:,2),'o')
plot(x,orig,'--k')
plot(x,pfit,'-k')

legend('Surge Magnitude','Originally Assumed',...
    sprintf( '%s\n%s','21.54v^2 + 88.25v', 'R^2 = 0.991')...
    ,'Location', 'NorthWest')

xlabel('|Speed| [m/s]')
ylabel('|Drag| [N]')
hold off


x = linspace(-100,100,500);
pfit = polyval([.04463, 1.92],x);

% Pitch wrench (drag)
figure(2)
hold on; box on
plot(B(:,2), B(:,3),'o')
plot(x,pfit,'-k')
legend('Pitch Torque',sprintf( '%s\n%s','.04463F + 1.92', 'R^2 = 0.945')...
    ,'Location', 'NorthWest')

xlabel('Drag [N]')
ylabel('Torque [Nm]')
hold off
