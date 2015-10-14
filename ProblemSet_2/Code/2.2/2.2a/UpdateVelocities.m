function velocities = UpdateVelocities(velocities,positions,...
  inertiaWeight,c1,c2,particleBest,swarmBest,deltaT,maximumVelocity)

swarmSize = size(positions,1);

for iParticle = 1:swarmSize
  inertiaTerm = inertiaWeight*velocities(iParticle,:);
  particleBestTerm = c1/deltaT*rand*(particleBest(iParticle,1:end-1)-...
    positions(iParticle,:));
  swarmBestTerm = c2/deltaT*rand*(swarmBest(end,1:end-1)-positions(...
    iParticle,:));
  tmpVelocity = inertiaTerm + particleBestTerm + swarmBestTerm;
    
  tmpVelocity(tmpVelocity > maximumVelocity) = maximumVelocity;
  tmpVelocity(tmpVelocity < -maximumVelocity) = -maximumVelocity;
    
  velocities(iParticle,:) = tmpVelocity;
end
    
end