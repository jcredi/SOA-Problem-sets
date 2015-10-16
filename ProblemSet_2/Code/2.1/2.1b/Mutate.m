function mutatedChromosome = Mutate(selectedChromosome, nGenes, mutationProbability)

mutatedChromosome = selectedChromosome;

for iGene = 1:nGenes
  r = rand;
  if (r < mutationProbability)
    iSwap = randi(nGenes);
    while iSwap == iGene
      iSwap = randi(nGenes);
    end
    tmp = mutatedChromosome(iSwap);
    mutatedChromosome(iSwap) = mutatedChromosome(iGene);
    mutatedChromosome(iGene) = tmp;
  end
end