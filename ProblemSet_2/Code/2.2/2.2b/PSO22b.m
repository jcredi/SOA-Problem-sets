%PSO22b
clear
close all
clc

functionToMinimise = LoadFunction22b;

%====================================%
% Parameters
%====================================%
swarmSize = 50;
spaceDimension = 5;
inertiaWeight = 1.4; % starting value
inertiaWeightDecreaseRate = 0.99;
minInertiaWeight = 0.3;
c1 = 2;
c2 = 2;
xMin = -30;
xMax = 30;
alpha = 1;
deltaT = 1;
crazinessProbability = 1/swarmSize;
maximumVelocity = alpha/deltaT*(xMax-xMin);
maxIterations = 1000;


%====================================%
% Initialisations
%====================================%
[positions, velocities] = InitialisePositionsVelocities(swarmSize,...
  spaceDimension, xMin, xMax, alpha, deltaT);
particleBest = positions;
particleBest(:,end+1) = Inf;
swarmBest = nan(1,spaceDimension+1);
swarmBest(end) = Inf;
terminationCriterion = false;
nImprovements = 0;

%====================================%
% PSO loop
%====================================%
fprintf('Running Particle Swarm Optimizer with %i particles...',swarmSize);
for iIteration = 1:maxIterations
  
  integerPositions = round(positions);
  functionValues = EvaluateParticles(integerPositions, functionToMinimise);
  
  [particleBest,swarmBest] = UpdateBestPositions(particleBest,swarmBest,...
    integerPositions,functionValues);
  if size(swarmBest,1) > nImprovements
    fprintf('\nFound new minimum at iteration %i.',iIteration);
    nImprovements = nImprovements +1;
  end

  velocities = UpdateVelocities(velocities,positions,inertiaWeight,c1,...
    c2,particleBest,swarmBest,deltaT,crazinessProbability,maximumVelocity);
  positions = positions + velocities*deltaT;
  
  inertiaWeight = UpdateInertiaWeight(inertiaWeight,...
    inertiaWeightDecreaseRate,minInertiaWeight);
end

if iIteration == maxIterations
  fprintf('\nProgram stopped after %i iterations (max number of iterations reached).',iIteration);
end
fprintf('\n\nMinimum: %i at point (%i, %i, %i, %i, %i)^T.\n',swarmBest(end,end),...
  swarmBest(end,1),swarmBest(end,2),swarmBest(end,3),swarmBest(end,4),swarmBest(end,5));


