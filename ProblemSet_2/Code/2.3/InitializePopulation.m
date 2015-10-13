function population = InitializePopulation(nInput, nHidden, nOutput, ...
  populationSize, weightsRange)

populationInputHidden = rand(nHidden,nInput+1,populationSize);
populationInputHidden = weightsRange(1)+diff(weightsRange)*populationInputHidden; % rescale
populationHiddenOutput = rand(nOutput,nHidden+1,populationSize);
populationHiddenOutput = weightsRange(1)+diff(weightsRange)*populationHiddenOutput; % rescale

population = cell(populationSize, 2);
for iNetwork = 1:populationSize
  population{iNetwork,1} = populationInputHidden(:,:,iNetwork);
  population{iNetwork,2} = populationHiddenOutput(:,:,iNetwork);
end

end