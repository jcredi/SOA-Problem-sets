function [minLengthFigure, textHandle] = InitialiseMinLengthPlot(numberOfGenerations)

figureHandle = figure(2);
set(figureHandle, 'DoubleBuffer','on');
set(figureHandle, 'Position', [200,180,680,640], 'Color','w');
hold on;

minLengthFigure = plot(1:numberOfGenerations, nan(1,numberOfGenerations),'LineWidth',1.5);
xlim([1 numberOfGenerations]);
xlabel('Generation');
ylabel('Minimum Path Length');
set(gca, 'FontSize', 16);
axis square;

textHandle = text(0.4,0.9,sprintf('Minimum path length: %4.3f',0.0),'FontSize',16,'Units','normalized');

drawnow;
hold off;

end

