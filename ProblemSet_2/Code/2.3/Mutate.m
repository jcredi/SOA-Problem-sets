function mutatedNetwork = Mutate(originalNetwork,mutationProbability,...
        creepMutationParameter)

originalInputToHidden = originalNetwork{1};
originalHiddenToOutput = originalNetwork{2};
mutatedInputToHidden = originalInputToHidden;
mutatedHiddenToOutput = originalHiddenToOutput;

for i = 1:size(originalInputToHidden,1)
  for j = 1:size(originalInputToHidden,2)
    r = rand;
    if r < mutationProbability
      originalWeight = originalInputToHidden(i,j);
      q = rand;
      creepMutation = -creepMutationParameter+2*q*creepMutationParameter;
      mutatedWeight = originalWeight + creepMutation;
      mutatedInputToHidden(i,j) = mutatedWeight;
    end
  end
end

for i = 1:size(originalHiddenToOutput,1)
  for j = 1:size(originalHiddenToOutput,2)
    r = rand;
    if r < mutationProbability
      originalWeight = originalHiddenToOutput(i,j);
      q = rand;
      creepMutation = -creepMutationParameter+2*q*creepMutationParameter;
      mutatedWeight = originalWeight + creepMutation;
      mutatedHiddenToOutput(i,j) = mutatedWeight;
    end
  end
end
    
mutatedNetwork = {mutatedInputToHidden, mutatedHiddenToOutput};

end

