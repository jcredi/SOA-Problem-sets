function [newChromosome1, newChromosome2] = backupCross2Pt(parent1,parent2)

nInstructions1 = size(parent1,1);
nInstructions2 = size(parent2,1);

cutsInParent1 = sort(randi(nInstructions1-1,[2 1]));
cutsInParent2 = sort(randi(nInstructions2-1,[2 1]));

firstPortion = parent1(1:cutsInParent1(1),:);
secondPortion = parent2(cutsInParent2(1):cutsInParent2(2),:);
thirdPortion = parent1(cutsInParent1(2):end,:);
newChromosome1 = [firstPortion; secondPortion; thirdPortion];

firstPortion = parent2(1:cutsInParent2(1),:);
secondPortion = parent1(cutsInParent1(1):cutsInParent1(2),:);
thirdPortion = parent2(cutsInParent2(2):end,:);
newChromosome2 = [firstPortion; secondPortion; thirdPortion];



end

