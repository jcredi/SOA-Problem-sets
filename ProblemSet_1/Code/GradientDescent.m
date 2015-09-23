function [newMinimum, nSteps] = GradientDescent(startingPoint, mu, stepLength, threshold)
%GRADIENTDESCENT Performs gradient descent optimization.
%   xStar = GradientDescent( x0, mu, eta, T) performs a gradient descent
%   search for the minimum of f(x,mu) starting from point x0 in input and
%   refining the candidate value for the minimum with step-length eta until
%   the gradient drops below the threshold value T.

thresholdNotReached = true;
currentPoint = startingPoint;
nSteps = 0;

while thresholdNotReached
    
  nSteps = nSteps + 1;
  
  % compute gradient
  currentGradient = Gradient(currentPoint, mu);
  
  if abs(currentGradient) < threshold
    thresholdNotReached = false;
  else
    % update minimum
    currentPoint = currentPoint - stepLength*currentGradient;
  end
  
end

newMinimum = currentPoint;

end

