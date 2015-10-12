function [fitnessFigureHandle, bestPlotHandle, textHandle] = ...
    InitializeFitnessPlot(numberOfGenerations)

fitnessFigureHandle = figure;
set(gcf,'color','w');
hold on;
set(fitnessFigureHandle, 'Position', [50,50,800,400]);
set(fitnessFigureHandle, 'DoubleBuffer','on');
xlim([1 numberOfGenerations]);
ylim([0 0.35]);
xlabel('Generation');
ylabel('Fitness');
set(gca, 'FontSize', 14);
bestPlotHandle = plot(1:numberOfGenerations, ...
    zeros(1,numberOfGenerations), 'LineWidth',1.5);
textHandle = text(85,0.3,sprintf('best: %4.3f',0.0));
hold off;
drawnow;


end

