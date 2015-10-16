function invadedPopulation = InsertTopN(population,fitness, numberOfElites)

invadedPopulation = population;
tmpFitness = fitness;

for i = 1:numberOfElites
  [~,iElite] = max(tmpFitness);
  invadedPopulation(i).Chromosome = population(iElite).Chromosome;
  tmpFitness(iElite) = 0;
end

end
