function UpdateErrorPlot(iGeneration, errorPlotHandle, textHandle, minimumError)

plotvector = get(errorPlotHandle,'YData');
plotvector(iGeneration) = minimumError;
set(errorPlotHandle,'YData',plotvector);

set(textHandle,'String',sprintf('Error of best individual: %4.3f',minimumError),'FontSize',16);

drawnow;

end