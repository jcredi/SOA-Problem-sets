function functionError = ComputeError(chromosome, xData, yData, ...
  nVariableRegisters, constantRegisters, cMax)

nDataPoints = length(xData);
functionEstimates = NaN(nDataPoints,1);

for iData = 1:nDataPoints
  xValue = xData(iData);  
  functionEstimates(iData) = EvaluateChromosome(chromosome, xValue, ...
    nVariableRegisters, constantRegisters, cMax);
end

errorValues = (functionEstimates - yData).^2;

functionError = sqrt(sum(errorValues)/nDataPoints);

end