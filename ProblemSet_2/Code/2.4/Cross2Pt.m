function [newChromosome1, newChromosome2] = Cross2Pt(parent1,parent2)
%Cross2Pt

nInstructions1 = size(parent1,1);
nInstructions2 = size(parent2,1);

cutsInvalid = true;
while cutsInvalid
  cutsInParent1 = sort(randi(nInstructions1+1,[2 1])-1);
  cutsInParent2 = sort(randi(nInstructions2+1,[2 1])-1);
  % TO FIX
  if (diff(cutsInParent1) ~= 0 || diff(cutsInParent2) ~= nInstructions2) && (diff(cutsInParent2) ~= 0 || diff(cutsInParent1) ~= nInstructions1)
    cutsInvalid = false;
  end
end
  

% Generate offspring 1
firstPortion = parent1(1:cutsInParent1(1),:);
secondPortion = parent2(cutsInParent2(1)+1:cutsInParent2(2),:);
thirdPortion = parent1(cutsInParent1(2)+1:end,:);
newChromosome1 = [firstPortion; secondPortion; thirdPortion];

% Generate offspring 2
firstPortion = parent2(1:cutsInParent2(1),:);
secondPortion = parent1(cutsInParent1(1)+1:cutsInParent1(2),:);
thirdPortion = parent2(cutsInParent2(2)+1:end,:);
newChromosome2 = [firstPortion; secondPortion; thirdPortion];

end

