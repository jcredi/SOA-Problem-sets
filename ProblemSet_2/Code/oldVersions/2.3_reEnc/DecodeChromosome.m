function neuralNetwork = DecodeChromosome(chromosome,weightRange)

neuralNetwork = chromosome;

neuralNetwork.InputToHidden = -weightRange + 2*weightRange.*neuralNetwork.InputToHidden;
neuralNetwork.HiddenToOutput = -weightRange + 2*weightRange.*neuralNetwork.HiddenToOutput;

end
