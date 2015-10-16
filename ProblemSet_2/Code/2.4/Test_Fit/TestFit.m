%% TestFit
clear; clc; close all;

functionData = LoadFunctionData;
xData = functionData(:,1);
yData = functionData(:,2);
nDataPoints = size(xData,1);

evolvedFunction = @(x) -(6*(- x^17 + 7*x^16 - 44*x^15 + 184*x^14 ...
  - 668*x^13 + 1936*x^12 - 4910*x^11 + 10369*x^10 - 19175*x^9 ...
  + 29414*x^8 - 38832*x^7 + 40044*x^6 - 32814*x^5 + 13302*x^4 ...
  + 3294*x^3 - 18387*x^2 + 14094*x - 10935))/(6*x^18 - 37*x^17 ...
  + 231*x^16 - 900*x^15 + 3192*x^14 - 8748*x^13 + 21696*x^12 ...
  - 43830*x^11 + 81045*x^10 - 123363*x^9 + 176566*x^8 - 206592*x^7 ...
  + 244500*x^6 - 228150*x^5 + 250542*x^4 - 182682*x^3 + 188325*x^2 ...
  - 79218*x + 64881);

yFit = zeros(nDataPoints,1);
for iData = 1:nDataPoints
  yFit(iData) = evolvedFunction(xData(iData));
end

dataPlot = plot(xData,yData,'.','MarkerSize',16);
hold on
fitPlot = plot(xData,yFit,'LineWidth',1.5);
hold off

set(gcf,'Color','w');
set(gca,'FontSize',20);
legend([dataPlot,fitPlot],'Original data','Best fit','Location','SouthEast');
xlabel('x');
ylabel('y');

% Output error to console
errorValues = (yFit - yData).^2;
fitError = sqrt(sum(errorValues)/nDataPoints);
fprintf('\nError of the best fitting function found: %4.5f\n',fitError);

