function population = InitialisePopulation(nInput, nHidden, nOutput, populationSize)

for iChromosome = 1:populationSize
  tmp1 = rand(nHidden,nInput+1);    % including biases column
  tmp2 = rand(nOutput,nHidden+1);	% including biases column
  
  population(iChromosome) = struct('InputToHidden',tmp1,'HiddenToOutput',tmp2);
end

end