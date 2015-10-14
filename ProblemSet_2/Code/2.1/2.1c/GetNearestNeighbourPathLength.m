function nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocation)

nNodes = size(cityLocation,1);
startingNode = randi(nNodes);

distances = zeros(nNodes);
for i = 1:nNodes
  cityA = cityLocation(i,:);
  for j = i+1:nNodes
    cityB = cityLocation(j,:);
    distances(i,j) = sqrt((cityA(1)-cityB(1))^2+(cityA(2)-cityB(2))^2);
  end
end
distances = distances + distances';

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