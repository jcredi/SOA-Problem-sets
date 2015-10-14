%LGP24
clear
close all

%% Parameters
populationSize = 20;
numberOfGenerations = 50;
tournamentSize = 2;
tournamentSelectionParameter = 0.8;
crossoverProbability = 0.8;
mutationProbability = 1/(4*10);
elitismCopies = 1;

nVariableRegisters = 3;
nConstantRegisters = 3;
constantRegisters = [1 -1 3];
minChromosomeLength = 3; % use at least 3
maxChromosomeLength = 10;
operatorsSet = ['+','-','*','/'];
cMax = 1e10;

%% Initialisations and preliminary operations
functionData = LoadFunctionData;
xData = functionData(:,1);
yData = functionData(:,2);
population = InitializePopulation(populationSize, minChromosomeLength,...
  maxChromosomeLength, nVariableRegisters, nConstantRegisters);
fitness = zeros(populationSize,1);
maximumFitness = zeros(numberOfGenerations,1);
%[errorPlotHandle, textHandle] = InitializeErrorPlot(numberOfGenerations);


% Main LGP loop
h = waitbar(0,'Running GA - please wait...');
for iGeneration = 1:numberOfGenerations
  
  tic
  %% Evaluation  
  for iChromosome = 1:populationSize
    chromosome = population(iChromosome).Chromosome;
    functionError = ComputeError(chromosome, xData, yData, operatorsSet,...
      nVariableRegisters, constantRegisters, cMax);
    fitness(iChromosome) = 1/functionError;
  end
  [maximumFitness(iGeneration), iBestChromosome] = max(fitness);
  bestChromosome = population(iBestChromosome).Chromosome;
  
  %% Plot error
  minError(iGeneration) = 1/maximumFitness(iGeneration);
  %UpdateErrorPlot(iGeneration, errorPlotHandle, textHandle, minError);
  maxTrainingPlot = plot(minError,'LineWidth',1.5);
  
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
  toc
end
close(h);