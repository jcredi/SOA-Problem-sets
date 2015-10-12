function [surfaceFigureHandle, populationPlotHandle] = ...
    InitializeSurfacePlot(variableRange, populationSize, fitness)

surfaceFigureHandle = figure;
set(gcf,'color','w');
hold on;
set(surfaceFigureHandle, 'DoubleBuffer','on');
delta = 0.1;
limit = fix(2*variableRange/delta) + 1;
[xValues,yValues] = meshgrid(-variableRange:delta:variableRange,...
    -variableRange:delta:variableRange);
zValues = zeros(limit,limit);
for j = 1:limit
  for k = 1:limit
    zValues(j,k) = EvaluateIndividual([xValues(j,k) yValues(j,k)]);
  end
end
surfl(xValues,yValues,zValues)
colormap gray;
shading interp;
view([-7 -9 10]);
decodedPopulation = zeros(populationSize,2);
populationPlotHandle = plot3(decodedPopulation(:,1), ...
    decodedPopulation(:,2),fitness(:),'kp');
hold off;
xlabel('x_1');
ylabel('x_2');
zlabel('Fitness');
set(gca, 'FontSize', 14);
drawnow;


end
