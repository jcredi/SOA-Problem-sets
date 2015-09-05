function [newValue] = NewtonRaphsonStep(currentValue, firstDerivative, secondDerivative)
%NEWTONRAPHSONSTEP Compute one Newton-Raphson step
%   x(j+1) = NewtonRaphsonStep(x(j), f'(x), f''(x)) returns a new estimate
%   for the closest stationary point to x(j) of the function f. 

newValue = currentValue - firstDerivative/secondDerivative;

if isinf(newValue)
  fprintf('ERROR in function NewtonRaphson.m\nSecond derivative is zero. Execution will stop now.\n');
  newValue = nan;
  return
end