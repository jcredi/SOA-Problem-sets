function [derivativeCoefficients] = PolynomialDifferentiation(polynomialCoefficients, derivativeOrder)
%POLYNOMIALDIFFERENTIATION Compute derivative of polynomial function.
%   Q = PolynomialDifferentiation(P,k) returns an array containing the
%   polynomial coefficients (in ascending order) of the k-th order
%   derivative of the polynomial function having coefficients specified in
%   input array P.

% Check for errors
if ~exist('polynomialCoefficients','var') || ~exist('derivativeOrder','var')
  fprintf('ERROR in function PolynomialDifferentiation.m\nNot enough input arguments. Execution will stop now. Returning NaN.\n');
  derivativeCoefficients = nan;
  return
elseif ~isreal(polynomialCoefficients) || mod(derivativeOrder,1) || derivativeOrder < 0
  fprintf('ERROR in function PolynomialDifferentiation.m\nInvalid input argument. Execution will stop now. Returning NaN.\n');
  derivativeCoefficients = nan;
  return
elseif isempty(polynomialCoefficients)
  fprintf('ERROR in function PolynomialDifferentiation.m\nThe given polynomial is empty. Execution will stop now. Returning empty polynomial.\n');
  derivativeCoefficients = [];
  return
end

nCoefficients = length(polynomialCoefficients);
derivativeCoefficients = nan(1,nCoefficients-1);

if derivativeOrder == 0 % trivial case
  derivativeCoefficients = polynomialCoefficients;  
  
elseif derivativeOrder == 1 % base case
  for i = 1:nCoefficients-1
      derivativeCoefficients(i) = i*polynomialCoefficients(i+1);
  end    
  
else % recursive case
  derivativeCoefficients = PolynomialDifferentiation(PolynomialDifferentiation(polynomialCoefficients, derivativeOrder-1), 1);
end

end