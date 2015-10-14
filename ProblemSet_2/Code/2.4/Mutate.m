function mutatedChromosome = Mutate(originalChromosome,mutationProbability,...
  nVariableRegisters, nConstantRegisters)

nInstructions = size(originalChromosome,2);
nOperators = 4; % assumes basic operators {+,-,*,/}
nRegisters = nVariableRegisters + nConstantRegisters;

mutatedChromosome = originalChromosome;

for i = 1:nInstructions
  for j = 1:4
    r = rand;
    if (r < mutationProbability)
      switch j
        case 1
          mutatedChromosome(i,j) = randi(nOperators);
        case 2
          mutatedChromosome(i,j) = randi(nVariableRegisters);
        otherwise
          mutatedChromosome(i,j) = randi(nRegisters);
      end
    end
  end
end

end

