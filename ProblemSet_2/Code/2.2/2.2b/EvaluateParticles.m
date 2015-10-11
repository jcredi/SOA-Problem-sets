function functionValues = EvaluateParticles(positions, functionHandle)

swarmSize = size(positions,1);
functionValues = zeros(swarmSize,1);

for iParticle = 1:swarmSize
  functionValues(iParticle) = functionHandle((positions(iParticle,:))');
end

end