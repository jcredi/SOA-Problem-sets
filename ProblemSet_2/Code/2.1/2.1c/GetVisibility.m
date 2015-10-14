function visibility = GetVisibility(cityLocation)

nNodes = size(cityLocation,1);
distances = zeros(nNodes);
for i = 1:nNodes
  cityA = cityLocation(i,:);
  for j = i+1:nNodes
    cityB = cityLocation(j,:);
    distances(i,j) = sqrt((cityA(1)-cityB(1))^2+(cityA(2)-cityB(2))^2);
  end
end
distances = distances + distances';
distances(1:size(distances,1)+1:end) = NaN;

visibility = 1./distances;

end