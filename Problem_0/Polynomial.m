function [functionValue] = Polynomial(polynomialCoefficients, x)
%POLYNOMIAL Evaluate polynomial.
%   Y = POLYNOMIAL(P,X) returns the value of a polynomial P evaluated at X.
%   P is a vector of length N+1 containing the polynomial coefficients in
%   ascending order.

% Check for errors
if ~exist('polynomialCoefficients','var') || ~exist('x','var')
  fprintf('ERROR in function Polynomial.m\nNot enough input arguments. Execution will stop now. Returning NaN.\n');
  functionValue = nan;
  return
elseif ~isreal(polynomialCoefficients) || ~isreal(x) || ~isscalar(x)
  fprintf('ERROR in function Polynomial.m\nInvalid input argument. Execution will stop now. Returning NaN.\n');
  functionValue = nan;
  return
elseif isempty(polynomialCoefficients)
  fprintf('ERROR in function Polynomial.m\nThe given polynomial is empty. Execution will stop now. Returning NaN.\n');
  functionValue = nan;
  return
end

nCoefficients = length(polynomialCoefficients);
functionValue = polynomialCoefficients(1);

for i = 2:nCoefficients
    functionValue = functionValue + polynomialCoefficients(i)*x^i;
end

end

