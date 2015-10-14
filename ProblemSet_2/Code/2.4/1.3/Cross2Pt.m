function [newChromosome1, newChromosome2] = Cross2Pt(parent1,parent2)

nInstructions1 = size(parent1,1);
nInstructions2 = size(parent2,1);

cutPositions1 = sort(randi(nInstructions1-1,[2 1]));
cutPositions2 = sort(randi(nInstructions2-1,[2 1]));

firstPortion = parent1(1:cutPositions1(1),:);
secondPortion = parent2(cutPositions1(1):cutPositions1(2),:);
thirdPortion = parent1(cutPositions1(2):end,:);
newChromosome1 = [firstPortion; secondPortion; thirdPortion];

firstPortion = parent2(1:cutPositions2(1),:);
secondPortion = parent1(cutPositions2(1):cutPositions2(2),:);
thirdPortion = parent2(cutPositions2(2):end,:);
newChromosome2 = [firstPortion; secondPortion; thirdPortion];

end

