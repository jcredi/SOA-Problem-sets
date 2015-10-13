function figureHandle = PlotData(position, pedalPressure, gear, speed, ...
    brakeTemperature)
%PlotData

figureHandle = figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'color','w');

subplot(2,2,1);
plot(position,pedalPressure);
title('Pedal pressure');
set(gca, 'FontSize', 16);

subplot(2,2,2);
plot(position,gear);
title('Gear');
set(gca, 'FontSize', 16);

subplot(2,2,3);
plot(position,speed);
title('Speed');
set(gca, 'FontSize', 16);

subplot(2,2,4);
plot(position,brakeTemperature);
title('Brake temperature');
set(gca, 'FontSize', 16);


end