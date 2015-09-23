function [iterationValues] = NewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
%NEWTONRAPHSON Newton-Raphson solver for polynomial functions
%   X* = NewtonRaphson(P, x0, t) performs a Newton-Raphson optimization of
%   the polynomial function whose coefficients (in ascending order) are
%   provided in one-dimensional input array P. The search starts from input
%   point x0 (real and scalar) and stops when the specified (positive)
%   tolerance is reached.

nIterates = 0;
stopMessage = 'Program stopped after %d Newton-Raphson iterates.\n';

% check for invalid input
if nargin < 3 || tolerance < 0
  fprintf('ERROR in function NewtonRaphson.m : not enough or invalid input arguments.\n');
  fprintf(stopMessage, nIterates);
  iterationValues = [];
  return    
end

fprintf('Starting point is x0 = %f\n',startingPoint);
iterationValues = startingPoint;
candidateValue = startingPoint;

disp('Performing Newton-Raphson optimization...');

while 1
  
  firstDerivativeCoefficients = PolynomialDifferentiation(polynomialCoefficients, 1);
  firstDerivative = Polynomial(firstDerivativeCoefficients, candidateValue);
  secondDerivativeCoefficients = PolynomialDifferentiation(polynomialCoefficients, 2);
  secondDerivative = Polynomial(secondDerivativeCoefficients, candidateValue);
  candidateValue = NewtonRaphsonStep(candidateValue, firstDerivative, secondDerivative);  
  
  if isnan(candidateValue) || isinf(candidateValue) % check for errors
    fprintf(stopMessage, nIterates-1);
    break
  else
    iterationValues(end+1) = candidateValue;
  end
  
  % check for convegence
  if abs(iterationValues(end)-iterationValues(end-1)) < tolerance
    fprintf('Tolerance reached!\n');
    fprintf(stopMessage, nIterates);
    %fprintf(strcat('Best estimate of stationary point is x* = %.',num2str(nOfOutputDigits),'f\n'), candidateValue);
    fprintf('Best estimate of stationary point is x* = %f\n',candidateValue);
    break
  end
  
  nIterates = nIterates + 1;

end
  
end
