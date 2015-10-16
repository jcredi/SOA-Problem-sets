%BrakingSystemOptimisation
clear
close all

%% FFNN parameters
nInput = 3;
nHidden = 8;
nOutput = 2;
weightsMinMax = [-10, 10];
weightRange = diff(weightsMinMax);
beta = 1;
activationFunction = @(x) 1./(1+exp(-beta*x));

%% GA parameters
populationSize = 20;
numberOfGenerations = 20;
tournamentSelectionParameter = 0.8;
tournamentSize = 3;
nGenes = (nHidden*(nInput+1)+nOutput*(nHidden+1));
mutationProbability = 1/nGenes;
creepMutationProbability = 0.3;
elitismCopies = 1;
creepRate = 0.2;

outputFileName = 'Run_500_fingerscrossed.mat';

%% Initialisations
population = InitialisePopulation(nInput, nHidden, nOutput, populationSize);
fitnessTraining = zeros(populationSize,1);
fitnessValidation = zeros(populationSize,1);

%% Main GA loop
iGeneration = 0;
h = waitbar(0,'Running GA - please wait...');
while iGeneration < numberOfGenerations
  
  tic  
  iGeneration = iGeneration + 1;
  
  %% Evaluation  
  for iChromosome = 1:populationSize
    neuralNetwork = DecodeChromosome(population(iChromosome),weightRange);
    fitnessTraining(iChromosome) = EvaluateNetwork(neuralNetwork, 1,...
      activationFunction);
    fitnessValidation(iChromosome) = EvaluateNetwork(neuralNetwork, 2,...
      activationFunction);
  end
  [maximumFitnessTraining(iGeneration), iBestChromosomeTraining] = max(fitnessTraining);
  [maximumFitnessValidation(iGeneration), iBestChromosomeValidation] = max(fitnessValidation);
  bestChromosomeTraining(iGeneration) = population(iBestChromosomeTraining);
  bestChromosomeValidation(iGeneration) = population(iBestChromosomeValidation);
  averageFitnessTraining(iGeneration) = mean(fitnessTraining);
  averageFitnessValidation(iGeneration) = mean(fitnessValidation);
  
  %% Plot while running
  maxTrainingPlot = plot(maximumFitnessTraining);
  hold on
  maxValidationPlot = plot(maximumFitnessValidation);
  avgTrainingPlot = plot(averageFitnessTraining);
  avgValidationPlot = plot(averageFitnessValidation);
  legend('Max fitness training','Max fitness validation', ...
    'Average fitness training', 'Average fitness validation','Location',...
    'SouthEast');
  hold off 
  
  %% Selection
  tempPopulation = population;
  for iChromosome = elitismCopies+1:populationSize
    iSelected = TournamentSelect(fitnessTraining,...
      tournamentSelectionParameter, tournamentSize);
    tempPopulation(iChromosome) = population(iSelected);
  end
  
  %% Mutation 
  for iChromosome = elitismCopies+1:populationSize
    originalChromosome = tempPopulation(iChromosome);
    mutatedNetwork = Mutate(originalChromosome, mutationProbability,...
      creepMutationProbability, creepRate);
    tempPopulation(iChromosome) = mutatedNetwork;
  end
  
  %% Elitism
  tempPopulation = InsertBestIndividual(tempPopulation, ...
    bestChromosomeTraining(iGeneration), elitismCopies);
  
  population = tempPopulation;
  waitbar(iGeneration/numberOfGenerations,h);
  toc
  
  
end % end loop over generations
close(h);

%% Final plot
maxTrainingPlot = plot(maximumFitnessTraining);
hold on
maxValidationPlot = plot(maximumFitnessValidation);
avgTrainingPlot = plot(averageFitnessTraining);
avgValidationPlot = plot(averageFitnessValidation);
legend('Max fitness training','Max fitness validation', ...
'Average fitness training', 'Average firness validation');
hold off 

myBestChromosomeTraining = bestChromosomeTraining(end,:);
myBestChromosomeValidation = bestChromosomeValidation(end,:);

save(outputFileName);
