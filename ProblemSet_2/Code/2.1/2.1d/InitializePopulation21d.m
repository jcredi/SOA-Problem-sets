function population = InitializePopulation21d(populationSize,nNodes,cityLocation,nInitialSwapMutations)

distances = zeros(nNodes);
for i = 1:nNodes
  cityA = cityLocation(i,:);
  for j = i+1:nNodes
    cityB = cityLocation(j,:);
    distances(i,j) = sqrt((cityA(1)-cityB(1))^2+(cityA(2)-cityB(2))^2);
  end
end
distances = distances + distances';

population = zeros(populationSize, nNodes);

for iChromosome = 1:populationSize
  startingNode = randi(nNodes);
  population(iChromosome,1) = startingNode;
  visitedNodes = false(1,nNodes);  
  visitedNodes(startingNode) = true;
  currentNode = startingNode;
  
  for iStep = 2:nNodes % nearest neighbour path
    distancesFromCurrent = distances(currentNode,:);
    distancesFromCurrent(visitedNodes) = NaN;
    distToNearest = min(distancesFromCurrent(~visitedNodes));
    nextNode = find(distancesFromCurrent == distToNearest,1);
    visitedNodes(nextNode) = true;
    population(iChromosome,iStep) = nextNode;
    currentNode = nextNode;
  end
  
  for i = 1:nInitialSwapMutations % some random swap mutations
    iSwap1 = randi(nNodes);  
    iSwap2 = randi(nNodes);
    while iSwap1 == iSwap2
      iSwap1 = randi(nNodes);  
      iSwap2 = randi(nNodes);   
    end
    tmpSwap = population(iChromosome,iSwap1);
    population(iChromosome,iSwap1) = population(iChromosome,iSwap2);
    population(iChromosome,iSwap2) = tmpSwap;
  end
end

end