%PENALTYMETHOD 
%   Main script for Problem 1.1
clear
tic

% ======================================================================= %
% Parameters
% ======================================================================= %

startingPoint = [1 2]';
nPhases = 10;
muValues = logspace(0,3,nPhases)';
stepLength = 1e-4;
threshold = 1e-6;

% ======================================================================= %

% Define function and constraint anonymously
f = @(x1, x2) 4*x1.^2 - x1.*x2 + 4*x2.^2 -6*x2;
g = @(x1, x2) x1.^2 + x2.^2 - 1;

% Initialise output data
outputData = nan(numel(muValues), 4);
outputData(:,1) = muValues;

currentPoint = startingPoint;

% Main loop
h = waitbar(0, 'Gliding on gradients here. Please wait...');

for phase = 1:nPhases
  
  mu = muValues(phase);
    
  [currentPoint, nSteps] = GradientDescent(currentPoint, mu, ...
      stepLength, threshold);
  outputData(phase,[2 3]) = currentPoint';
  outputData(phase, 4) = nSteps;
  
  fprintf('Phase %i completed in %i steps\n', phase, nSteps);
  
  waitbar(phase/nPhases,h);
end
close(h);

[fig1, fig2, fig3] = FancyPlot(outputData, f, g);



toc
