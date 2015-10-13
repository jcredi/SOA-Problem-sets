function offspringNetwork = CrossoverDiscrete(selectedNetwork1,selectedNetwork2)

weightsInputToHidden1 = selectedNetwork1{1};
weightsInputToHidden2 = selectedNetwork2{1};
weightsHiddenToOutput1 = selectedNetwork1{2};
weightsHiddenToOutput2 = selectedNetwork2{2};

offspringInputToHidden = zeros(size(weightsInputToHidden1));
offspringHiddenToOutput = zeros(size(weightsHiddenToOutput1));

for i = 1:size(weightsInputToHidden1,1)
  for j = 1:size(weightsInputToHidden1,2)
    weight1 = weightsInputToHidden1(i,j);
    weight2 = weightsInputToHidden2(i,j);
    whichParent = round(1+rand);
    if whichParent == 1
      newWeight = weight1;
    else
      newWeight = weight2;
    end
    offspringInputToHidden(i,j) = newWeight;
  end
end

for i = 1:size(weightsHiddenToOutput1,1)
  for j = 1:size(weightsHiddenToOutput1,2)
    weight1 = weightsHiddenToOutput1(i,j);
    weight2 = weightsHiddenToOutput2(i,j);
    whichParent = round(1+rand);
    if whichParent == 1
      newWeight = weight1;
    else
      newWeight = weight2;
    end
    offspringHiddenToOutput(i,j) = newWeight;
  end
end

offspringNetwork = {offspringInputToHidden, offspringHiddenToOutput};

end