function offspringNetwork = CrossoverIntermediateRecombination(...
    selectedNetwork1,selectedNetwork2,intermediateRecombinationRange)

weightsInputToHidden1 = selectedNetwork1{1};
weightsInputToHidden2 = selectedNetwork2{1};
weightsHiddenToOutput1 = selectedNetwork1{2};
weightsHiddenToOutput2 = selectedNetwork2{2};

offspringInputToHidden = zeros(size(weightsInputToHidden1));
offspringHiddenToOutput = zeros(size(weightsHiddenToOutput1));

minAlpha = intermediateRecombinationRange(1);
deltaAlpha = diff(intermediateRecombinationRange);

for i = 1:size(weightsInputToHidden1,1)
  for j = 1:size(weightsInputToHidden1,2)
    weight1 = weightsInputToHidden1(i,j);
    weight2 = weightsInputToHidden2(i,j);
    alpha = minAlpha + rand*deltaAlpha; % must be resampled for EACH variable!

    newWeight = weight1 + alpha*(weight2-weight1);
    offspringInputToHidden(i,j) = newWeight;
  end
end

for i = 1:size(weightsHiddenToOutput1,1)
  for j = 1:size(weightsHiddenToOutput1,2)
    weight1 = weightsHiddenToOutput1(i,j);
    weight2 = weightsHiddenToOutput2(i,j);
    alpha = minAlpha + rand*deltaAlpha; % must be resampled for EACH variable!

    newWeight = weight1 + alpha*(weight2-weight1);
    offspringHiddenToOutput(i,j) = newWeight;
  end
end

offspringNetwork = {offspringInputToHidden, offspringHiddenToOutput};

end