function [] = UpdateGraphics(iGeneration, bestPlotHandle, ...
    maximumFitness, textHandle, populationPlotHandle, ...
    decodedPopulation, fitness)

plotvector = get(bestPlotHandle,'YData');
plotvector(iGeneration) = maximumFitness;
set(bestPlotHandle,'YData',plotvector);
set(textHandle,'String',sprintf('best: %4.3f',maximumFitness));
set(populationPlotHandle,'XData',decodedPopulation(:,1),'YData', ...
      decodedPopulation(:,2),'ZData',fitness(:));
drawnow;

end