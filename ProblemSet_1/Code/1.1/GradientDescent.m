function [newMinimum, nSteps] = GradientDescent(startingPoint, mu, ...
    stepLength, threshold)

thresholdNotReached = true;
currentPoint = startingPoint;
nSteps = 0;

while thresholdNotReached
  nSteps = nSteps + 1;
  
  currentGradient = Gradient(currentPoint, mu);
  if abs(currentGradient) < threshold
    thresholdNotReached = false;
  else
    currentPoint = currentPoint - stepLength*currentGradient;
  end
end

newMinimum = currentPoint;

end

