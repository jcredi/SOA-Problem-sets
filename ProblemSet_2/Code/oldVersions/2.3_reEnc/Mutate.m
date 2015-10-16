function mutatedChromosome = Mutate(originalChromosome,mutationProbability,...
  creepMutationProbability, creepRate)

originalInputToHidden = originalChromosome.InputToHidden;
originalHiddenToOutput = originalChromosome.HiddenToOutput;

mutatedInputToHidden = originalInputToHidden;
mutatedHiddenToOutput = originalHiddenToOutput;

for i = 1:size(originalInputToHidden,1)
  for j = 1:size(originalInputToHidden,2)
    r = rand;
    if r < mutationProbability
      originalWeight = originalInputToHidden(i,j);
      q = rand;
      if q < creepMutationProbability
        mutatedWeight = originalWeight + creepRate*(rand-0.5);
        mutatedWeight = max(0,min(1,mutatedWeight)); % make sure it's in [0,1]
      else
        mutatedWeight = rand;    
      end
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
      if q < creepMutationProbability
        mutatedWeight = originalWeight + creepRate*(rand-0.5);
        mutatedWeight = max(0,min(1,mutatedWeight)); % make sure it's in [0,1]
      else
        mutatedWeight = rand;    
      end
      mutatedHiddenToOutput(i,j) = mutatedWeight;
    end
  end
end
    
mutatedChromosome = struct('InputToHidden',mutatedInputToHidden,...
  'HiddenToOutput',mutatedHiddenToOutput);

end

