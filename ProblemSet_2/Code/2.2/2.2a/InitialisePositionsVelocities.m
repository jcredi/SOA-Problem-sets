function [positions, velocities] = InitialisePositionsVelocities(swarmSize,...
  spaceDimension, xMin, xMax, alpha, deltaT)

xRange = xMax-xMin;

positions = zeros(swarmSize,spaceDimension);
velocities = zeros(swarmSize,spaceDimension);

for iParticle = 1:swarmSize
  r = rand(1,spaceDimension);
  positions(iParticle,:) = xMin + r.*xRange;
  r = rand(1,spaceDimension);
  velocities(iParticle,:) = alpha/deltaT*(-xRange/2 + r.*xRange);
end

end