minChromosomeLength = 3;
maxChromosomeLength = 10;
populationSize = 10;
nVariableRegisters = 3;
nConstantRegisters = 3;

operatorsSet = ['+','-','*','/'];

functionData = LoadFunctionData;
xData = functionData(:,1);
yData = functionData(:,2);

population = InitializePopulation(populationSize,...
    minChromosomeLength,maxChromosomeLength, nVariableRegisters,...
    nConstantRegisters);


eval('x=1;');