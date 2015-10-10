function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)

nNodes = length(pheromoneLevel);
startingNode = randi(nNodes);

currentNode = startingNode;
path = zeros(1,nNodes);
path(1) = startingNode;
tabuList = false(1,nNodes);
tabuList(startingNode) = true;

for i = 2:nNodes
  nextNode = GetNode(currentNode,tabuList,pheromoneLevel,visibility,alpha,beta);
  tabuList(nextNode) = true;
  path(i) = nextNode;
  currentNode = nextNode;
end

if any(path) == 0
  save('errorWorkspace');
  error('Path contains a zero');
end


end