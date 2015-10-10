function population = InitializePopulation(populationSize,nCities)

population = zeros(populationSize, nCities);
for iChromosome = 1:populationSize
  population(iChromosome,:) = randperm(nCities);
end

end