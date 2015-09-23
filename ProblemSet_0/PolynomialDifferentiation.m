function [derivativeCoefficients] = PolynomialDifferentiation(polynomialCoefficients, k)
%POLYNOMIALDIFFERENTIATION Compute derivative of polynomial function.
%   Q = PolynomialDifferentiation(P,k) returns an array containing the
%   polynomial coefficients (in ascending order) of the k-th order
%   derivative of the polynomial function having coefficients specified in
%   input array P.


% Check for errors
if nargin < 2 || ~isreal(polynomialCoefficients) || mod(k,1) || k < 0
  fprintf('ERROR in function PolynomialDifferentiation.m : not enough or invalid input arguments.\n');
  derivativeCoefficients = nan;
  return
end

nCoefficients = length(polynomialCoefficients);
derivativeCoefficients = zeros(1,max(1,nCoefficients-1));

if k == 0 % trivial case
  derivativeCoefficients = polynomialCoefficients;  
elseif k == 1 % base case
  for i = 1:nCoefficients-1
      derivativeCoefficients(i) = i*polynomialCoefficients(i+1);
  end     
else % recursive case
  kMinusOneThDerivative = PolynomialDifferentiation(polynomialCoefficients, k-1);
  derivativeCoefficients = PolynomialDifferentiation(kMinusOneThDerivative, 1);
end

end