%LGP24
clear
close all

%% Parameters
populationSize = 100;
numberOfGenerations = 2000;
tournamentSize = 5;
tournamentSelectionParameter = 0.75;
crossoverProbability = 0.2;
mutationProbability = 0.01;
elitismCopies = 1;
outputFileName = 'run2000_02_001.mat';

nVariableRegisters = 3; % M
nConstantRegisters = 3; % N
constantRegisters = [1 3 -1];
minNumberOfInstructions = 5; % use at least 3
maxNumberOfInstructions = 25;
cMax = 1e10;

%% Initialisations and preliminary operations
functionData = LoadFunctionData;
xData = functionData(:,1);
yData = functionData(:,2);
population = InitializePopulation(populationSize, minNumberOfInstructions,...
  maxNumberOfInstructions, nVariableRegisters, nConstantRegisters);
fitness = zeros(populationSize,1);
minError = zeros(numberOfGenerations,1);
maximumFitness = zeros(numberOfGenerations,1);
% errorPlot = animatedline;

% Main LGP loop
h = waitbar(0,'Running GA - please wait...');
for iGeneration = 1:numberOfGenerations
  
  %% Evaluation  
  for iChromosome = 1:populationSize
    chromosome = population(iChromosome).Chromosome;
    functionError = ComputeError(chromosome, xData, yData, ...
      nVariableRegisters, constantRegisters, cMax);
    fitness(iChromosome) = 1/functionError;
  end
  [maximumFitness(iGeneration), iBestChromosome] = max(fitness);
  bestChromosome = population(iBestChromosome).Chromosome;
  
  %% Plot error
  minError(iGeneration) = 1/maximumFitness(iGeneration);
  if iGeneration >1 && minError(iGeneration) < minError(iGeneration-1)
    fprintf('\nNew min error found: %4.5f at iteration %i',minError(iGeneration),iGeneration);
  end
  %maxTrainingPlot = plot(minError,'LineWidth',1.5);
%   addpoints(errorPlot,iGeneration,minError(iGeneration));
%   drawnow limitrate;
  
  %% Tournament selection and 2-pt crossover
  tempPopulation = population;
  for iChromosome = 1:2:populationSize
    iSelected1 = TournamentSelect(fitness, tournamentSelectionParameter, ...
    tournamentSize);
    iSelected2 = TournamentSelect(fitness, tournamentSelectionParameter, ...
    tournamentSize);
    selectedChromosome1 = population(iSelected1).Chromosome;
    selectedChromosome2 = population(iSelected2).Chromosome;

    r = rand;
    if (r < crossoverProbability)
      [newChromosome1, newChromosome2] = Cross2Pt(selectedChromosome1,selectedChromosome2);
      tempPopulation(iChromosome).Chromosome = newChromosome1;
      tempPopulation(iChromosome+1).Chromosome = newChromosome2;
    else
      tempPopulation(iChromosome).Chromosome = selectedChromosome1;
      tempPopulation(iChromosome+1).Chromosome = selectedChromosome2;
    end
  end
  
  %% Mutation
  for iChromosome = 1:populationSize
    originalChromosome = tempPopulation(iChromosome).Chromosome;
    mutatedChromosome = Mutate(originalChromosome,mutationProbability,...
      nVariableRegisters, nConstantRegisters);
    tempPopulation(iChromosome).Chromosome = mutatedChromosome;
  end
  
  %% Elitism
  tempPopulation = InsertBestIndividual(tempPopulation, bestChromosome, ...
    elitismCopies);

  population = tempPopulation;

  waitbar(iGeneration/numberOfGenerations,h);
end
close(h);

finalMinError = minError(end);
evolvedFunction = TranslateChromosome(bestChromosome, nVariableRegisters, constantRegisters, cMax);
save(outputFileName)

