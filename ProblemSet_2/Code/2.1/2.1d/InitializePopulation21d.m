function population = InitializePopulation21d(populationSize,nNodes,cityLocation,nInitialSwapMutations)

distances = squareform(pdist(cityLocation));
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
    tmpSwap = population(iChromosome,iSwap1);
    population(iChromosome,iSwap1) = population(iChromosome,iSwap2);
    population(iChromosome,iSwap2) = tmpSwap;
  end
end

end