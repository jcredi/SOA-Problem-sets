function nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocation)

startingNode = 1; % arbitrary, changes length a bit, but not significantly

nNodes = size(cityLocation,1);
distances = squareform(pdist(cityLocation));

nnPath = zeros(1,nNodes);
visitedNodes = false(1,nNodes);
nearestNeighbourPathLength = 0;

currentNode = startingNode;
visitedNodes(startingNode) = true;
nnPath(1) = startingNode;

for i = 2:nNodes
  distancesFromCurrent = distances(currentNode,:);
  distancesFromCurrent(visitedNodes) = NaN;
  distToNearest = min(distancesFromCurrent(~visitedNodes));
  nextNode = find(distancesFromCurrent == distToNearest,1);
  visitedNodes(nextNode) = true;
  nnPath(i) = nextNode;
  nearestNeighbourPathLength = nearestNeighbourPathLength + distToNearest;
  currentNode = nextNode;
end

end