function gradient = Gradient( currentPoint, mu)

gradient(1) = 2*currentPoint(1) - 2;
gradient(2) = 4*currentPoint(2) - 8;

constraint = currentPoint(1)^2 + currentPoint(2)^2 - 1;
isConstraintSatisfied = constraint <= 0;

if ~isConstraintSatisfied
  gradient(1) = gradient(1) + 4*mu*constraint*currentPoint(1);
  gradient(2) = gradient(2) + 4*mu*constraint*currentPoint(2);
end

gradient = gradient';
 
end

