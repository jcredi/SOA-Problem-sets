function [particleBest, swarmBest] = UpdateBestPositions(...
    particleBest, ...   % last column contains function evaluations
    swarmBest, ...      % last column contains function evaluation
    positions, functionValues)

swarmSize = size(positions,1);

for iParticle = 1:swarmSize
  if functionValues(iParticle) < particleBest(iParticle,end)
    particleBest(iParticle,1:end-1) = positions(iParticle,:);
    particleBest(iParticle,end) = functionValues(iParticle);
  end
end

[currentSwarmBestValue, iBestParticle] = min(functionValues);
if currentSwarmBestValue < swarmBest(end,end)
  swarmBest(end+1,1:end-1) = positions(iBestParticle,:);
  swarmBest(end,end) = currentSwarmBestValue;
end

end