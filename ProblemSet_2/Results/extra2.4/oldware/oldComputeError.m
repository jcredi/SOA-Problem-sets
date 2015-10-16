function functionError = ComputeError(chromosome, xData, yData, ...
  operatorsSet, nVariableRegisters, constantRegisters, cMax)

nDataPoints = length(xData);
functionEstimates = NaN(nDataPoints,1);

instructions = DecodeChromosome(chromosome,operatorsSet,nVariableRegisters);

for iData = 1:nDataPoints
  xValue = xData(iData);  
  functionEstimates(iData) = EvaluateInstructions(instructions, xValue, ...
  nVariableRegisters, constantRegisters, cMax);
end

errorValues = (functionEstimates - yData).^2;

functionError = sqrt(sum(errorValues)/nDataPoints);

end