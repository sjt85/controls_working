% Thor surge model fitting

load 'surge_vel.mat'

%surge_vel_neg = -surge_vel(1:6,:);

P1 = polylsq(surge_vel(6:12,1),surge_vel(6:12,2),7,1)

P2 = polylsq(surge_vel(1:6,1),surge_vel(1:6,2),6,1)



close all
figure
hold on; box on
plot(surge_vel(:,1), surge_vel(:,2))
%plot(surge_vel_neg(:,1), surge_vel_neg(:,2))
axis([-0.6, 0.6, -80, 80])

line([0,.5],[0,.5*P1],'Linestyle','--','Color','k')
line([0,-.5],[0,-.5*P2],'Linestyle','--','Color','k')

line([-0.6, 0.6],[0, 0],'Linestyle',':','Color','k')
line([0, 0],[-80, 80],'Linestyle',':','Color','k')

xlabel('Velocity [m/s]')
ylabel('Thruster Force [N]')
title('Thor Surge Drag Curve')
hold off

