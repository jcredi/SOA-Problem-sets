function [newValue] = NewtonRaphsonStep(currentValue, firstDerivative, secondDerivative)
%NEWTONRAPHSONSTEP Compute one Newton-Raphson step
%   x(j+1) = NewtonRaphsonStep(x(j), f'(x), f''(x)) returns a new estimate
%   for the closest stationary point to x(j) of the function f. 

newValue = currentValue - firstDerivative/secondDerivative;

if isinf(newValue) || isnan(newValue)
  fprintf('ERROR in function NewtonRaphsonStep.m : new candidate value is NaN or Inf.\n');
end

end