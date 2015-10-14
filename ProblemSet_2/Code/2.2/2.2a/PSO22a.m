%PSO22a
clear
close all
clc

functionToMinimise = LoadFunction22a;

%====================================%
% Parameters
%====================================%
swarmSize = 20;
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
maximumVelocity = alpha/deltaT*(xMax-xMin);
nIterations = 1000;

%====================================%
% Initialisations
%====================================%
[positions, velocities] = InitialisePositionsVelocities(swarmSize,...
  spaceDimension, xMin, xMax, alpha, deltaT);
particleBest = positions;
particleBest(:,end+1) = Inf;
swarmBest = nan(1,spaceDimension+1);
swarmBest(end) = Inf;

%====================================%
% PSO loop
%====================================%
fprintf('Running Particle Swarm Optimizer with %i particles...',swarmSize);
tic
for iIteration = 1:nIterations
    
  functionValues = EvaluateParticles(positions, functionToMinimise);
  
  [particleBest,swarmBest] = UpdateBestPositions(particleBest,swarmBest,...
    positions,functionValues);
  
  velocities = UpdateVelocities(velocities,positions,inertiaWeight,c1,...
    c2,particleBest,swarmBest,deltaT,maximumVelocity);
  positions = positions + velocities*deltaT;
  
  inertiaWeight = UpdateInertiaWeight(inertiaWeight,...
    inertiaWeightDecreaseRate,minInertiaWeight);
end

fprintf('\n  %i iterations completed in %4.3f seconds.',iIteration,toc);
fprintf('\n\nMinimum: %4.3f at point (%4.3f, %4.3f).\n',...
  swarmBest(end,end),swarmBest(end,1),swarmBest(end,2));


