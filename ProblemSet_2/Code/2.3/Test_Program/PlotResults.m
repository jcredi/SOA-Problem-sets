function figureHandle = PlotResults(position, slopeAngle, pedalPressure,...
  gear, speed, brakeTemperature)

figureHandle = figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'color','w');

subplot(2, 3, 1);
plot(position,slopeAngle,'LineWidth',2);
title('Slope angle');
set(gca, 'FontSize', 24);
xlabel('Position (m)');
ylabel('Slope angle (degree)')

subplot(2, 3, 2);
plot(position,pedalPressure,'LineWidth',2);
title('Pedal pressure');
set(gca, 'FontSize', 24);
xlabel('Position (m)');
ylabel('Pedal pressure (a.u.)')

subplot(2, 3 , 3);
plot(position,gear,'LineWidth',2);
title('Gear');
set(gca, 'FontSize', 24);
xlabel('Position (m)');
ylabel('Gear')

subplot(2, 3, 4);
plot(position,speed,'LineWidth',2);
title('Speed');
set(gca, 'FontSize', 24);
xlabel('Position (m)');
ylabel('Speed (m/s)')

subplot(2, 3, 5);
plot(position,brakeTemperature,'LineWidth',2);
title('Brake temperature');
set(gca, 'FontSize', 24);
xlabel('Position (m)');
ylabel('Temperature (K)')

end