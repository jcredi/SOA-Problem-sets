function figureHandle = PlotResults(position, slopeAngle, pedalPressure,...
  gear, speed, brakeTemperature)

figureHandle = figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'color','w');

subplot(2, 3, [1 4]);
plot(position,slopeAngle);
title('Slope angle');
set(gca, 'FontSize', 16);
xlabel('Position (m)');
ylabel('Slope angle (degree)')

subplot(2, 3, 2);
plot(position,pedalPressure);
title('Pedal pressure');
set(gca, 'FontSize', 16);
xlabel('Position (m)');
ylabel('Pedal pressure (a.u.)')

subplot(2, 3 , 3);
plot(position,gear);
title('Gear');
set(gca, 'FontSize', 16);
xlabel('Position (m)');
ylabel('Gear')

subplot(2, 3, 5);
plot(position,speed);
title('Speed');
set(gca, 'FontSize', 16);
xlabel('Position (m)');
ylabel('Speed (m/s)')

subplot(2, 3, 6);
plot(position,brakeTemperature);
title('Brake temperature');
set(gca, 'FontSize', 16);
xlabel('Position (m)');
ylabel('Temperature (K)')

end