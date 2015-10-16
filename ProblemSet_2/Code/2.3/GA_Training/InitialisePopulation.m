function population = InitialisePopulation(nInput, nHidden, nOutput, ...
  populationSize)

population = cell(populationSize, 2);
for iChromosome = 1:populationSize
  population{iChromosome,1} = rand(nHidden,nInput+1);
  population{iChromosome,2} = rand(nOutput,nHidden+1);
end

end