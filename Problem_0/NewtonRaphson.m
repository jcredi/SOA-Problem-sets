function [iterationValues] = NewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
%NEWTONRAPHSON Newton-Raphson solver for polynomial functions
%   [points] = NewtonRaphson(P, x, t) performs a Newton-Raphson search of
%   the nearest stationary point, starting from point x, of the polynomial
%   function whose coefficients are provided in input array P. The search
%   stops automatically when the specified tolerance t is reached.


currentValue = startingPoint;
iterationValues = currentValue;
%nextValue = Inf;
nIterates = 0;
outputFrequency = 3;
nOfOutputDigits = length(num2str(tolerance))-1;
outputString = strcat('Current estimate of stationary point is x* = %.',num2str(nOfOutputDigits),'f\n');

while 1
    
  firstDerivative = Polynomial(PolynomialDifferentiation(polynomialCoefficients, 1), currentValue);
  secondDerivative = Polynomial(PolynomialDifferentiation(polynomialCoefficients, 2), currentValue);
  currentValue = NewtonRaphsonStep(currentValue, firstDerivative, secondDerivative);  
  
  % if no errors
  
  iterationValues(end+1) = currentValue;
  
  if abs(iterationValues(end)-iterationValues(end-1))<tolerance
    disp('Tolerance reached');
    break
  end
  
  nIterates = nIterates + 1;
  if ~mod(nIterates, outputFrequency)
    fprintf(outputString',currentValue)
  end
  
  
  
end
  
end
