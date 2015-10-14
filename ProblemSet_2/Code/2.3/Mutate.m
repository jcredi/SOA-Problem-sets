function mutatedNetwork = Mutate(originalNetwork,mutationProbability,...
  creepMutationProbability, creepRate, weightsRange)

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
      if q < creepMutationProbability % creep mutation
        mutatedWeight = originalWeight + creepRate*weightsRange*(rand-0.5);
      else % full range mutation
        mutatedWeight = -weightsRange/2 + rand*weightsRange;    
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
      if q < creepMutationProbability % creep mutation
        mutatedWeight = originalWeight + creepRate*weightsRange*(rand-0.5);
      else % full range mutation
        mutatedWeight = -weightsRange/2 + rand*weightsRange;    
      end
      mutatedHiddenToOutput(i,j) = mutatedWeight;
    end
  end
end
    
mutatedNetwork = {mutatedInputToHidden, mutatedHiddenToOutput};

end

