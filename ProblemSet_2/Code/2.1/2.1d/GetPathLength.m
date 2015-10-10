function pathLength = GetPathLength(path,cityLocation)
%GetPathLength

nCities = size(cityLocation,1);
pathLength = 0.0;

for iCity = 1:nCities-1
  cityA = cityLocation(path(iCity),:);
  cityB = cityLocation(path(iCity+1),:);
  roadLength = sqrt((cityA(1)-cityB(1))^2+(cityA(2)-cityB(2))^2);
  pathLength = pathLength + roadLength;
end

% Back to first city
cityA = cityLocation(path(end),:);
cityB = cityLocation(path(1),:);
roadLength = pdist([cityA; cityB]);
pathLength = pathLength + roadLength;

end