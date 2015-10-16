%% BrakingSystemOptimisation
clear; clc; close all;

%% Feed-forward neural network parameters
nInput = 3;
nHidden = 8;
nOutput = 2;
weightsMinMax = [-10, 10];
weightRange = diff(weightsMinMax);
beta = 1;
activationFunction = @(x) 1./(1+exp(-beta*x));

%% GA parameters
populationSize = 10;
numberOfGenerations = 10;
tournamentSelectionParameter = 0.8;
tournamentSize = 3;
nGenes = (nHidden*(nInput+1)+nOutput*(nHidden+1));
mutationProbability = 1/nGenes;
creepMutationProbability = 0.3;
creepRate = 0.2;
elitismCopies = 1;

%% Initialisations
fitnessTraining = zeros(populationSize,1);
fitnessValidation = zeros(populationSize,1);
population = InitialisePopulation(nInput, nHidden, nOutput, ...
  populationSize);

%% Main GA loop
iGeneration = 0;
disp('Training FFNN braking system with GA...');
h = waitbar(0,'Training FFNN with GA - please wait...'); tic;
while iGeneration < numberOfGenerations
  
  iGeneration = iGeneration + 1;
  
  %% Evaluation  
  for iChromosome = 1:populationSize
    neuralNetwork = DecodeChromosome(population(iChromosome,:),weightRange);
    fitnessTraining(iChromosome) = EvaluateNetwork(neuralNetwork, 1,...
      activationFunction);
    fitnessValidation(iChromosome) = EvaluateNetwork(neuralNetwork, 2,...
      activationFunction);
  end
  [maximumFitnessTraining(iGeneration), iBestChromosomeTraining] = max(fitnessTraining);
  [maximumFitnessValidation(iGeneration), iBestChromosomeValidation] = max(fitnessValidation);
  bestChromosomeTraining(iGeneration,:) = population(iBestChromosomeTraining,:);
  bestChromosomeValidation(iGeneration,:) = population(iBestChromosomeValidation,:);
  
  %% Plot
  maxTrainingPlot = plot(maximumFitnessTraining);
  hold on
  maxValidationPlot = plot(maximumFitnessValidation);
  title('Maximum fitness');
  legend('Max fitness training','Max fitness validation','Location','SouthEast');
  hold off 
  
  %% Selection
  tempPopulation = population;
  for iChromosome = elitismCopies+1:populationSize
    iSelected = TournamentSelect(fitnessTraining,...
      tournamentSelectionParameter, tournamentSize);
    tempPopulation(iChromosome,:) = population(iSelected,:);
  end
  
  %% Mutation 
  for iChromosome = elitismCopies+1:populationSize
    originalChromosome = tempPopulation(iChromosome,:);
    mutatedChromosome = Mutate(originalChromosome, mutationProbability,...
      creepMutationProbability, creepRate);
    tempPopulation(iChromosome,:) = mutatedChromosome;
  end
  
  %% Elitism
  tempPopulation = InsertBestIndividual(tempPopulation, ...
    population(iBestChromosomeTraining,:), elitismCopies);
  
  population = tempPopulation;
  waitbar(iGeneration/numberOfGenerations,h);
  
end % end loop over generations
close(h);

clc
fprintf('\n%i training generations completed in %4.3f seconds.\n',...
  numberOfGenerations,toc);