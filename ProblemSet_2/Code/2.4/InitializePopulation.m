function population = InitializePopulation(populationSize,...
    minChromosomeLength,maxChromosomeLength, nVariableRegisters,...
    nConstantRegisters)

population = [];
for i = 1:populationSize
 chromosomeLength = minChromosomeLength + fix(rand*(maxChromosomeLength-minChromosomeLength+1));
 
 tmpOperator = randi(4,[chromosomeLength,1]);
 tmpDestination = randi(nVariableRegisters,[chromosomeLength,1]);
 tmpOperand1 = randi(nVariableRegisters+nConstantRegisters,[chromosomeLength,1]);
 tmpOperand2 = randi(nVariableRegisters+nConstantRegisters,[chromosomeLength,1]);
 tmpChromosome = [tmpOperator,tmpDestination,tmpOperand1,tmpOperand2];
 
 tmpIndividual = struct('Chromosome',tmpChromosome);
 
 population = [population tmpIndividual];
end

end