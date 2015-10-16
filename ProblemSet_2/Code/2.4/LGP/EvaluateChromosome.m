function functionValue = EvaluateChromosome(chromosome, xValue, ...
  nVariableRegisters, constantRegisters, cMax)

variableRegisters = zeros(1,nVariableRegisters);
variableRegisters(1) = xValue;
combinedRegisters = [variableRegisters, constantRegisters];

nInstructions = size(chromosome,1);

for iInstruction = 1:nInstructions
  
  idOperand1 = chromosome(iInstruction,3);
  tmpOperand1 = combinedRegisters(idOperand1);
  
  idOperand2 = chromosome(iInstruction,4);
  tmpOperand2 = combinedRegisters(idOperand2);
  
  idOperator = chromosome(iInstruction,1);
  switch idOperator
    case 1 
      tmpDestination = tmpOperand1 + tmpOperand2;
    case 2
      tmpDestination = tmpOperand1 - tmpOperand2;    
    case 3
      tmpDestination = tmpOperand1 * tmpOperand2;
    case 4
      if tmpOperand2 ~= 0 % protected division
        tmpDestination = tmpOperand1 / tmpOperand2;  
      else
        tmpDestination = cMax;
      end
  end
  
  idDestination = chromosome(iInstruction,2);
  combinedRegisters(idDestination) = tmpDestination;
end

functionValue = combinedRegisters(1);

end