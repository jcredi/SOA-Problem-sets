%GA23
clear

% Feed-forward neural network parameters
nInput = 3;
nHidden = 5;
nOutput = 2;
weightsRange = [-1, 1];

% Genetic algorithm parameters
populationSize = 100;
maxNumberOfGenerations = 50;
tournamentSelectionParameter = 0.8;
tournamentSize = 3;
crossoverProbability = 0.8;
intermediateRecombinationRange = [-0.25, 1.25]; 
mutationProbability = 2/(nHidden*(nInput+1)+nOutput*(nHidden+1)); % 2 genes mutate per individual, on average
creepMutationParameter = 0.2;
elitismCopies = 1;

% Initialisations
fitnessTraining = zeros(populationSize,1);
fitnessValidation = zeros(populationSize,1);
%maximumFitnessTraining = zeros(1,numberOfGenerations);
%averageFitnessTraining = zeros(1,numberOfGenerations);
%maximumFitnessValidation = zeros(1,numberOfGenerations);
%averageFitnessValidation = zeros(1,numberOfGenerations);
population = InitializePopulation(nInput, nHidden, nOutput, ...
  populationSize, weightsRange);
isStoppingFlagOff = true;

% Main GA loop
iGeneration = 0;
h = waitbar(0,'Running GA - please wait...');
while iGeneration < maxNumberOfGenerations

  iGeneration = iGeneration + 1;
  
  % Evaluation  
  for i = 1:populationSize
    neuralNetwork = population(i,:);
    fitnessTraining(i) = EvaluateNetwork(neuralNetwork, 1);
    fitnessValidation(i) = EvaluateNetwork(neuralNetwork, 2);
  end
  [maximumFitnessTraining(iGeneration), iBestNetwork] = max(fitnessTraining);
  bestNetwork = population(iBestNetwork,:);
  averageFitnessTraining(iGeneration) = mean(fitnessTraining);
  averageFitnessValidation(iGeneration) = mean(fitnessValidation);
  
  if iGeneration > 1
    if averageFitnessValidation(iGeneration) < averageFitnessValidation(iGeneration-1) && isStoppingFlagOff
      savedBestNetwork = bestNetwork;
      disp('Fitness of validation set decreasing! Training will continue 5 more generations and then stop.');
      maxNumberOfGenerations = iGeneration + 5;
      isStoppingFlagOff = false;
    end
  end
  
  tempPopulation = population;
  % Elitism
  tempPopulation = InsertBestIndividual(tempPopulation, bestNetwork, elitismCopies); 

  for i = elitismCopies+1:populationSize
    % Selection
    i1 = TournamentSelect(fitnessTraining,tournamentSelectionParameter, ...
        tournamentSize);
    i2 = TournamentSelect(fitnessTraining,tournamentSelectionParameter, ...
        tournamentSize);
    selectedNetwork1 = population(i1,:);
    selectedNetwork2 = population(i2,:);
    
    % Crossover 
    % TO-DO: try discrete crossover
    r = rand;
    if (r < crossoverProbability)
      offspringNetwork = Crossover(selectedNetwork1,selectedNetwork2,...
          intermediateRecombinationRange);
      tempPopulation(i,:) = offspringNetwork;
    else 
      tempPopulation(i,:) = selectedNetwork1; % selected  #1 survives by default (could use #2, doesn't really matter)
    end
  end
  
  % Mutation 
  for i = 1:populationSize
    originalNetwork = tempPopulation(i,:);
    mutatedNetwork = Mutate(originalNetwork,mutationProbability,...
        creepMutationParameter);
    tempPopulation(i,:) = mutatedNetwork;
  end
  
  population = tempPopulation;
  waitbar(iGeneration/maxNumberOfGenerations,h);
  
  plot(averageFitnessTraining)
  hold on
  plot(averageFitnessValidation)
  hold off
  
end % end loop over generations
close(h);

plot(averageFitnessTraining)
hold on
plot(averageFitnessValidation)
hold off

