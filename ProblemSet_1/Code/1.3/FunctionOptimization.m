%FUNCTIONOPTIMIZATION
clear

numberOfRuns = 50;
numberOfGenes = 64;
numberOfVariables = 2;
variableRange = 5.0;
numberOfGenerations = 100;
numberOfCopies = 1;
populationSize = 50;
crossoverProbability = 0.8;
mutationProbability = 1/(numberOfGenes);
tournamentSelectionParameter = 0.75;
tournamentSize = 2;

fitness = zeros(populationSize,1);
maximumFitness = 0.0;

% Initialize plots
[fitnessFigureHandle, bestPlotHandle, textHandle] = ...
  InitializeFitnessPlot(numberOfGenerations);
[surfaceFigureHandle, populationPlotHandle] = ...
InitializeSurfacePlot(variableRange, populationSize, fitness);
disp('Running GA...');

population = InitializePopulation(populationSize, numberOfGenes);
decodedPopulation = zeros(populationSize,numberOfVariables);

for iGeneration = 1:numberOfGenerations

maximumFitness = 0.0;
xBest = zeros(1,2);
bestIndividualIndex = 0;

for i = 1:populationSize
  chromosome = population(i,:);
  x = DecodeChromosome(chromosome, numberOfVariables, variableRange);
  decodedPopulation(i,:) = x;
  
  fitness(i) = EvaluateIndividual(x);
  if (fitness(i) > maximumFitness)
    maximumFitness = fitness(i);
    bestIndividualIndex = i;
    xBest = x;
  end
end % Loop over population (evaluation)
bestChromosome = population(bestIndividualIndex, :);

tempPopulation = population;

for i = 1:2:populationSize
  i1 = TournamentSelect(fitness,tournamentSelectionParameter, ...
      tournamentSize);
  i2 = TournamentSelect(fitness,tournamentSelectionParameter, ...
      tournamentSize);
  chromosome1 = population(i1,:);
  chromosome2 = population(i2,:);

  r = rand;
  if (r < crossoverProbability)
    newChromosomePair = Cross(chromosome1,chromosome2);
    tempPopulation(i,:) = newChromosomePair(1,:);
    tempPopulation(i+1,:) = newChromosomePair(2,:);
  else
    tempPopulation(i,:) = chromosome1;
    tempPopulation(i+1,:) = chromosome2;
  end
end % Loop over population (selection and crossover)

for i = 1:populationSize
  originalChromosome = tempPopulation(i,:);
  mutatedChromosome = Mutate(originalChromosome,mutationProbability);
  tempPopulation(i,:) = mutatedChromosome;
end % Loop over population (mutation)

tempPopulation = InsertBestIndividual(tempPopulation, bestChromosome, ...
    numberOfCopies); % Elitism
population = tempPopulation;

UpdateGraphics(iGeneration, bestPlotHandle, ...
    maximumFitness, textHandle, populationPlotHandle, ...
    decodedPopulation, fitness);

end % Loop over generations

fprintf('GA completed. %i individuals evaluated.\n',...
    numberOfGenerations*populationSize);
fprintf('\nMaximum fitness found: %4.3f\n', maximumFitness);
fprintf('Minimum value of g found: %4.3f\n', 1/maximumFitness);
fprintf('Location of minimum: (%4.3f ; %4.3f)\n', xBest(1), xBest(2));
