function [pedalPressure,requestedGear] = RunFFNN(neuralNetwork, input1,...
    input2, input3, activationFunction)

inputState = [input1; input2; input3; -1]; % including dummy neuron for threshold

tmpHiddenState = neuralNetwork.InputToHidden*inputState;
hiddenState = activationFunction(tmpHiddenState);
hiddenState = [hiddenState; -1]; % add dummy

tmpOutputState = neuralNetwork.HiddenToOutput*hiddenState;
outputState = activationFunction(tmpOutputState);

pedalPressure = outputState(1);
if outputState(2) < 0.3
  requestedGear = -1;
elseif (outputState(2) >= 0.3) && (outputState(2) < 0.7)
  requestedGear = 0;
else
  requestedGear = +1;
end

end
