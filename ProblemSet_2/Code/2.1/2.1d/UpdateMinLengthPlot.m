function UpdateMinLengthPlot(iGeneration, minLengthFigure, textHandle, minimumLength)

plotvector = get(minLengthFigure,'YData');
plotvector(iGeneration) = minimumLength;
set(minLengthFigure,'YData',plotvector);

set(textHandle,'String',sprintf('Minimum path length: %4.5f',minimumLength),'FontSize',16);

drawnow;

end