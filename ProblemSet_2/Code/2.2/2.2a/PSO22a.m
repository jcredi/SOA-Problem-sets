%PSO22a
clear
close all
clc

functionToMinimise = LoadFunction22a;

%====================================%
% Parameters
%====================================%
swarmSize = 50;
spaceDimension = 2;
inertiaWeight = 1.4; % starting value
inertiaWeightDecreaseRate = 0.99;
minInertiaWeight = 0.3;
c1 = 2;
c2 = 2;
xMin = -10;
xMax = 10;
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
    
  functionValues = EvaluateParticles(positions, functionToMinimise);
  
  [particleBest,swarmBest] = UpdateBestPositions(particleBest,swarmBest,...
    positions,functionValues);
    if size(swarmBest,1) > nImprovements
    fprintf('\nFound new minimum at iteration %i.',iIteration);
    nImprovements = nImprovements +1;
    end
  
  velocities = UpdateVelocities(velocities,positions,inertiaWeight,c1,...
    c2,particleBest,swarmBest,deltaT,crazinessProbability,maximumVelocity);
  positions = positions + velocities*deltaT;
  
  inertiaWeight = UpdateInertiaWeight(inertiaWeight,...
    inertiaWeightDecreaseRate,minInertiaWeight);

  quiver(positions(:,1),positions(:,2),velocities(:,1),velocities(:,2))
  pause(0.01);
end

if iIteration == maxIterations
  fprintf('\nProgram stopped after %i iterations (max number of iterations reached).',...
    iIteration);
end
fprintf('\n\nMinimum: %4.3f at point (%4.3f, %4.3f).\n',swarmBest(end,end),...
  swarmBest(end,1),swarmBest(end,2));


