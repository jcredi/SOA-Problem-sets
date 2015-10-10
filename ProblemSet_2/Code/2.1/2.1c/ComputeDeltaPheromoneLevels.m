function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)

[nAnts, nNodes] = size(pathCollection);
deltaPheromoneLevel = zeros(nNodes,nNodes,nNodes); % 3d matrix

pheromoneToDeposit = 1./pathLengthCollection;

for k = 1:nAnts
  for j = 1:nNodes-1
    ii = pathCollection(k,j+1);
    jj = pathCollection(k,j);
    deltaPheromoneLevel(ii,jj,k) = pheromoneToDeposit(k);    
  end
  ii = pathCollection(k,1);
  jj = pathCollection(k,end);
  deltaPheromoneLevel(ii,jj,k) = pheromoneToDeposit(k); % and back
end

deltaPheromoneLevel = sum(deltaPheromoneLevel,3); % collapse 3rd dim

end