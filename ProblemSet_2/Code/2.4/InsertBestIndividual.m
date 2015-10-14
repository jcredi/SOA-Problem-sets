function invadedPopulation = InsertBestIndividual(population, ...
    bestChromosome, numberOfCopies)

invadedPopulation = population;
for i = 1:numberOfCopies
  invadedPopulation(i).Chromosome = bestChromosome;
end

end

