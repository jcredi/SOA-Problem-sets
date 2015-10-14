%GA23
clear
close all

% Feed-forward neural network parameters
nInput = 3;
nHidden = 8;
nOutput = 2;
weightsMinMax = [-10, 10];
weightRange = diff(weightsMinMax);

% Genetic algorithm parameters
populationSize = 50;
maxNumberOfGenerations = 100;
tournamentSelectionParameter = 0.8;
tournamentSize = 3;
nGenes = (nHidden*(nInput+1)+nOutput*(nHidden+1));
mutationProbability = 1/nGenes;
creepMutationProbability = 0.8;%0.8;
creepRate = 0.2; % expressed in percentage of the weight range
elitismCopies = 1;

% Initialisations
fitnessTraining = zeros(populationSize,1);
fitnessValidation = zeros(populationSize,1);
%maximumFitnessTraining = zeros(1,numberOfGenerations);
%averageFitnessTraining = zeros(1,numberOfGenerations);
%maximumFitnessValidation = zeros(1,numberOfGenerations);
%averageFitnessValidation = zeros(1,numberOfGenerations);
population = InitializePopulation(nInput, nHidden, nOutput, ...
  populationSize, weightsMinMax);
isStoppingFlagOff = true;

% Main GA loop
iGeneration = 0;
h = waitbar(0,'Running GA - please wait...');
while iGeneration < maxNumberOfGenerations
  
  tic  
  iGeneration = iGeneration + 1;
  
  %% Evaluation  
  for iNetwork = 1:populationSize
    neuralNetwork = population(iNetwork,:);
    fitnessTraining(iNetwork) = EvaluateNetwork(neuralNetwork, 1);
    fitnessValidation(iNetwork) = EvaluateNetwork(neuralNetwork, 2);
  end
  [maximumFitnessTraining(iGeneration), iBestNetworkTraining] = max(fitnessTraining);
  [maximumFitnessValidation(iGeneration), iBestNetworkValidation] = max(fitnessValidation);
  bestNetworkTraining(iGeneration,:) = population(iBestNetworkTraining,:);
  bestNetworkValidation(iGeneration,:) = population(iBestNetworkValidation,:);
  averageFitnessTraining(iGeneration) = mean(fitnessTraining);
  averageFitnessValidation(iGeneration) = mean(fitnessValidation);
  
  %% Plot
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
  for iNetwork = elitismCopies+1:populationSize
    iSelected = TournamentSelect(fitnessTraining,...
      tournamentSelectionParameter, tournamentSize);
    tempPopulation(iNetwork,:) = population(iSelected,:);
  end
  
  %% Mutation 
  for iNetwork = elitismCopies+1:populationSize
    originalNetwork = tempPopulation(iNetwork,:);
    mutatedNetwork = Mutate(originalNetwork, mutationProbability,...
      creepMutationProbability, creepRate, weightRange);
    tempPopulation(iNetwork,:) = mutatedNetwork;
  end
  
  %% Elitism
  tempPopulation = InsertBestIndividual(tempPopulation, ...
    population(iBestNetworkTraining,:), elitismCopies);
  
  population = tempPopulation;
  waitbar(iGeneration/maxNumberOfGenerations,h);
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

myBestNetwork1 = bestNetworkTraining(end,:);
myBestNetwork2 = bestNetworkValidation(end,:);
