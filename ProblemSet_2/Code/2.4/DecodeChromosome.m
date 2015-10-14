function instructions = DecodeChromosome(chromosome,operatorsSet,nVariableRegisters)

nInstructions = size(chromosome,1);
instructions = cell(nInstructions,1);

for iInstruction = 1:nInstructions
  tmpOperator = operatorsSet(chromosome(iInstruction,1));  
  tmpDestination = ['variableRegisters(',num2str(chromosome(iInstruction,2)),')'];
  idOperand1 = chromosome(iInstruction,3);
  if idOperand1 <= nVariableRegisters
    tmpOperand1 = ['variableRegisters(',num2str(idOperand1),')'];
  else
    idOperand1 = idOperand1 - nVariableRegisters;
    tmpOperand1 = ['constantRegisters(',num2str(idOperand1),')']; 
  end
  idOperand2 = chromosome(iInstruction,4);
  if idOperand2 <= nVariableRegisters
    tmpOperand2 = ['variableRegisters(',num2str(idOperand2),')'];
  else
    idOperand2 = idOperand2 - nVariableRegisters;
    tmpOperand2 = ['constantRegisters(',num2str(idOperand2),')']; 
  end
 
  tmpInstruction = [tmpDestination,'=',tmpOperand1,tmpOperator,tmpOperand2,';'];
  
  if tmpOperator == '/'; % protected division
    ifCondition = ['if ', tmpOperand2, ' ~= 0, '];
    elseStatement = [' else, ', tmpDestination, ' = cMax; end'];
    tmpInstruction = [ifCondition, tmpInstruction, elseStatement];
  end
  
  instructions{iInstruction} = tmpInstruction;
end

end