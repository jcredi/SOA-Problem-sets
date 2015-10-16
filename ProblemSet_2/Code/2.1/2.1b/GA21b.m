%GA21b
clear
close all

% Data loading
cityLocation = LoadCityLocations;
nCities = size(cityLocation,1);

% GA parameters
populationSize = 100;
numberOfGenerations = 10000;
mutationProbability = 2/(nCities);
tournamentSelectionParameter = 0.8;
tournamentSize = 5;
elitismCopies = 1;

% Initialisations
fitness = zeros(populationSize,1);
maximumFitness = 0.0;
population = InitializePopulation(populationSize, nCities);
[minLengthFigure, textHandle] = InitialiseMinLengthPlot(numberOfGenerations);
tspFigure = InitializeTspPlot(cityLocation,[0 20 0 20]);
set(tspFigure, 'Position', [1000,180,680,640], 'Color','w');
connection = InitializeConnections(cityLocation); 

disp('Running GA...'); tic;
for iGeneration = 1:numberOfGenerations
    
  for iChromosome = 1:populationSize
    chromosome = population(iChromosome,:);
    fitness(iChromosome) = 1/GetPathLength(chromosome,cityLocation);
  end % Loop over population (evaluation)
  [maximumFitness, iBestChromosome] = max(fitness);
  bestChromosome = population(iBestChromosome,:);
  
  shortestPath = 1/maximumFitness;
  UpdateMinLengthPlot(iGeneration, minLengthFigure, textHandle, shortestPath);
  PlotPath(connection,cityLocation,bestChromosome);

  tempPopulation = population;

  for iChromosome = 1:populationSize
    winnerIndex = TournamentSelect(fitness,tournamentSelectionParameter,...
      tournamentSize);
    selectedChromosome = population(winnerIndex,:);
    
    mutatedChromosome = Mutate(selectedChromosome,nCities,mutationProbability);
    tempPopulation(iChromosome,:) = mutatedChromosome;
  end % Loop over population (selection and mutation)

  tempPopulation = InsertBestIndividual(tempPopulation, bestChromosome, ...
    elitismCopies); % Elitism   
  population = tempPopulation;

end % Loop over generations
fprintf('  %i generations completed in %4.3f seconds.',numberOfGenerations,toc);
fprintf('\n\nLength of best path found: %4.3f\n',shortestPath);