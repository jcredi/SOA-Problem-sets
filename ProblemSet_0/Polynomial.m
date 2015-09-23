function [functionValue] = Polynomial(polynomialCoefficients, x)
%POLYNOMIAL Evaluate polynomial.
%   Y = POLYNOMIAL(P,X) returns the value of a polynomial P of degree N
%   evaluated at X. P is a 1d-array of length N+1 containing the polynomial
%   coefficients in ascending order. X can also be a 1d-array.

% Check for errors
if nargin < 2 || ~isreal(polynomialCoefficients) || ~isreal(x)
  fprintf('ERROR in function Polynomial.m : not enough or invalid input arguments.\n');
  functionValue = [];
  return
end

nCoefficients = length(polynomialCoefficients);
nPoints = length(x);
functionValue = zeros(size(x));

for ii = 1:nPoints
  for jj = 1:nCoefficients
    functionValue(ii) = functionValue(ii) + polynomialCoefficients(jj)*x(ii).^(jj-1);
  end
end

end