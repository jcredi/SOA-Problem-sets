function [pedalPressure,requestedGear] = RunFFNN(neuralNetwork, input1,...
    input2, input3)

weightsInputHidden = neuralNetwork{1};
weightsHiddenOutput = neuralNetwork{2};
nHidden = size(weightsInputHidden,1);
nOutput = 2;

beta = 1;
activationFunction = @(x) 1/(1+exp(-beta*x));

inputState = [input1; input2; input3; -1]; % including dummy neuron for threshold

hiddenState = weightsInputHidden*inputState;
for iNeuron = 1:nHidden % pass through activation function
  hiddenState(iNeuron) = activationFunction(hiddenState(iNeuron));
end
hiddenState = [hiddenState; -1]; % add dummy

outputState = weightsHiddenOutput*hiddenState;
for iNeuron = 1:nOutput % pass through activation function
  outputState(iNeuron) = activationFunction(outputState(iNeuron));
end

pedalPressure = outputState(1);
if outputState(2) < 0.3
  requestedGear = -1;
elseif (outputState(2) >= 0.3) && (outputState(2) < 0.7)
  requestedGear = 0;
else
  requestedGear = +1;
end

end
