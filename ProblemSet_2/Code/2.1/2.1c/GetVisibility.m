function visibility = GetVisibility(cityLocation)

distances = squareform(pdist(cityLocation));
distances(1:size(distances,1)+1:end) = NaN;

visibility = 1./distances;

end