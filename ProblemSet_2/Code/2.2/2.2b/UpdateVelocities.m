function velocities = UpdateVelocities(velocities,positions,inertiaWeight,...
  c1,c2,particleBest,swarmBest,deltaT,crazinessProbability,maximumVelocity)

[swarmSize, spaceDimension] = size(positions);

for iParticle = 1:swarmSize
  r = rand;
  if r < crazinessProbability
    tmpRand = rand(1,spaceDimension);
    velocities(iParticle,:) = -maximumVelocity + 2*tmpRand.*maximumVelocity;
  else
    inertiaTerm = inertiaWeight*velocities(iParticle,:);
    particleBestTerm = c1/deltaT*rand*(particleBest(iParticle,1:end-1)-positions(iParticle,:));
    swarmBestTerm = c2/deltaT*rand*(swarmBest(end,1:end-1)-positions(iParticle,:));
    tmpVelocities = inertiaTerm + particleBestTerm + swarmBestTerm;
    
    tmpVelocities(tmpVelocities > maximumVelocity) = maximumVelocity;
    tmpVelocities(tmpVelocities < -maximumVelocity) = -maximumVelocity;
    
    velocities(iParticle,:) = tmpVelocities;
  end
end
    
end