%PENALTYMETHOD
clear

startingPoint = [1 2]';
muValues = [1 3 10 30 100 300 1000];
stepLength = 1e-4;
threshold = 1e-6;

f = @(x1, x2) 4*x1.^2 - x1.*x2 + 4*x2.^2 -6*x2;
g = @(x1, x2) x1.^2 + x2.^2 - 1;

outputTable = nan(numel(muValues), 3);
outputTable(:,1) = muValues;

currentPoint = startingPoint;
nPhases = numel(muValues);

h = waitbar(0, 'Please wait...');
for phase = 1:nPhases
  mu = muValues(phase);
    
  [currentPoint, nSteps] = GradientDescent(currentPoint, mu, ...
      stepLength, threshold);
  outputTable(phase,[2 3]) = currentPoint';
  
  fprintf('Optimization phase %i completed in %i steps\n', phase, nSteps);
  waitbar(phase/nPhases,h);
end
close(h);

[fig1, fig2] = FancyPlots(outputTable, f, g);
format short g
outputTable
disp('First column of output table are mu values used in each phase.');
disp('Second and third column are (improved) minima locations');