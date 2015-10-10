function nextNode = GetNode(currentNode,tabuList,pheromoneLevel,visibility,alpha,beta)

nNodes = length(tabuList);
remainingNodes = 1:nNodes;
remainingNodes(tabuList) = [];


probabilities = pheromoneLevel(remainingNodes,currentNode).^beta ...
.* visibility(remainingNodes,currentNode).^alpha;
if all(probabilities) == 0
  iNode = randi(numel(remainingNodes));
  nextNode = remainingNodes(iNode);
  return
else
  probabilities = probabilities./sum(probabilities);
end
 
partialSums = cumsum(probabilities);
tempLogical = (rand < partialSums);
nextNodeIndex = find(tempLogical~=0, 1, 'first');
nextNode = remainingNodes(nextNodeIndex);


end