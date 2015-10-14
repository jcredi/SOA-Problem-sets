function functionValue = EvaluateInstructions(instructions, xValue,...
    nVariableRegisters, constantRegisters, cMax)

variableRegisters = zeros(1,nVariableRegisters);
variableRegisters(1) = xValue;
nInstructions = length(instructions);

for iInstruction = 1:nInstructions
  eval(instructions{iInstruction});
end

functionValue = variableRegisters(1);

end