function [curveHandle, pointsHandle] = PlotIterations(polynomialCoefficients, iterationValues)
%PLOTITERATIONS Plot polynomial curve and Newton-Raphson iterates
%   [f,g] = PlotIterations(P, V) plots the polynomial curve whose
%   coefficients are specified in input argument P in ascending order, and
%   the Newton-Raphson iterates specified in input array V. Outputs f and g
%   are the figure handles to these plots.

if nargin < 2
  fprintf('ERROR in function PlotIterations : not enough input arguments.\n');
  [curveHandle, pointsHandle] = deal([]);
  return
end

nPoints = 1000; % number of points of the polynomial curve to plot

% setting appropriate x-limits for the plots
minX = min(iterationValues);
maxX = max(iterationValues);
xLim1 = minX - 0.15*(maxX-minX);
xLim2 = maxX + 0.15*(maxX-minX);
deltaX = (xLim2 - xLim1) / nPoints;
xPoints = xLim1:deltaX:xLim2;

% computing corresponding y-values
yPoints = Polynomial(polynomialCoefficients, xPoints);
polyIterationValues = Polynomial(polynomialCoefficients,iterationValues);

% plotting
curveHandle = plot(xPoints, yPoints);
hold on
pointsHandle = plot(iterationValues, polyIterationValues,'ro');
hold off
set(gcf,'color','w')
xlabel('x');
ylabel('f(x)');
legend([curveHandle, pointsHandle], 'Polynomial curve', 'Newton-Raphson iterates');

end