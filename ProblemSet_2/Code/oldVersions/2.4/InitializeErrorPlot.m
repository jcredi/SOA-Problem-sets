function [errorPlotHandle, textHandle] = InitializeErrorPlot(numberOfGenerations)

figureHandle = figure('units','normalized','outerposition',[0.25 0.2 0.5 0.6]);
set(figureHandle, 'DoubleBuffer','on','Color','w');
hold on;

errorPlotHandle = plot(nan, nan,'LineWidth',1.5);
xlabel('Generation');
ylabel('Error of best individual');
set(gca, 'FontSize', 16);

textHandle = text(0.4,0.9,sprintf('Error of best individual: %4.3f',NaN),'FontSize',16,'Units','normalized');

drawnow;
hold off;

end
