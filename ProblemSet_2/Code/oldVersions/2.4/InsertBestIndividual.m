function invadedPopulation = InsertBestIndividual(population, ...
    iBestChromosome, numberOfCopies)

invadedPopulation = population;
for i = 1:numberOfCopies
  invadedPopulation(i) = population(iBestChromosome);
end

end

