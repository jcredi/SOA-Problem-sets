function x = DecodeChromosome(chromosome, numberOfVariables, variableRange)

nGenes = size(chromosome,2);
genesPerVariable = nGenes/numberOfVariables; % assumes integer ratio

tmpChromosome = reshape(chromosome, [genesPerVariable, numberOfVariables]);
tmpChromosome = tmpChromosome';

x = zeros(1, numberOfVariables);
for k = 1:numberOfVariables
  for j = 1:genesPerVariable
    x(k) = x(k) + tmpChromosome(k,j)*2^(-j);
  end
end
x = -variableRange + 2*variableRange*x/(1 - 2^(-genesPerVariable));

end

