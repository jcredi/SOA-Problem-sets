function population = InitialisePopulation(populationSize, minNumberOfInstructions,...
  maxNumberOfInstructions, nVariableRegisters, nConstantRegisters)

population = [];
for i = 1:populationSize
 nInstructions = minNumberOfInstructions + fix(rand*(maxNumberOfInstructions-minNumberOfInstructions+1));
 
 tmpOperator = randi(4,[nInstructions,1]);
 tmpDestination = randi(nVariableRegisters,[nInstructions,1]);
 tmpOperand1 = randi(nVariableRegisters+nConstantRegisters,[nInstructions,1]);
 tmpOperand2 = randi(nVariableRegisters+nConstantRegisters,[nInstructions,1]);
 tmpChromosome = [tmpOperator,tmpDestination,tmpOperand1,tmpOperand2];
 
 tmpIndividual = struct('Chromosome',tmpChromosome);
 
 population = [population tmpIndividual];
end

end