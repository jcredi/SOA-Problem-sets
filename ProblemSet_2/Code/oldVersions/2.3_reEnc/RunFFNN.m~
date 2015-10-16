function [pedalPressure,requestedGear] = RunFFNN(neuralNetwork, input1,...
    input2, input3, activationFunction)

weightsInputToHidden = neuralNetwork{1};
weightsHiddenToOutput = neuralNetwork{2};

inputState = [input1; input2; input3; -1]; % including dummy neuron for threshold

hiddenState = activationFunction(weightsInputToHidden*inputState);
hiddenState = [hiddenState; -1]; % add dummy

outputState = activationFunction(weightsHiddenToOutput*hiddenState);

pedalPressure = outputState(1);
if outputState(2) < 0.3
  requestedGear = -1;
elseif (outputState(2) >= 0.3) && (outputState(2) < 0.7)
  requestedGear = 0;
else
  requestedGear = +1;
end

end
