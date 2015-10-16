function neuralNetwork = DecodeChromosome(chromosome,weightRange)

neuralNetwork{1} = -weightRange + 2*weightRange.*chromosome{1};
neuralNetwork{2} = -weightRange + 2*weightRange.*chromosome{2};

end
