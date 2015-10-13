function functionValue = EvaluateInstructions(instructions, xValue,...
    variableRegisters, constantRegisters)

variableRegisters(1) = xValue;
nInstructions = length(instructions);

for iInstruction = 1:nInstructions
  eval(instructions{iInstruction});
end

functionValue = variableRegisters(1);

end