function PlotDataFunction(xData,yData,evolvedFunction)

functionHandle = matlabFunction(evolvedFunction);

nDataPoints = length(xData);

yFit = zeros(nDataPoints,1);
for iData = 1:nDataPoints
  yFit(iData) = functionHandle(xData(iData));
end

dataPlot = plot(xData,yData,'.','MarkerSize',16);
hold on
fitPlot = plot(xData,yFit,'LineWidth',1.5);
hold off

set(gcf,'Color','w');
set(gca,'FontSize',16);
legend([dataPlot,fitPlot],'Original data','Best fit','Location','SouthEast');
xlabel('x');
ylabel('y');
end