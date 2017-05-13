% Calibration curve for bollard pull

analogue = [2.5; 3; 3.5; 4; 4.5; 5; 2; 1.5; 1];
analogue = analogue*9.81;
dig = [5.41; 7.19; 8.5; 9.9; 10.91; 12.2; 4.3; 3.45; 2];
dig = dig*9.81;


x = linspace(0,120,100);
y = polyval([0.4161,0],x);

close all
figure
hold on
box on
plot(dig,analogue,'o')
plot(x,y,'-k')
axis([0,140,0,60])

legend('Calibration Data',...
    sprintf( '%s\n%s',' 0.4161x', 'R^2 = 0.989'),...
    'Location', 'NorthWest')

xlabel('Digital Scale Reading [N]')
ylabel('Force Applied [N]')

hold off

