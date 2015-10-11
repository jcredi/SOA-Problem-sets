function functionHandle = LoadFunction22a

functionHandle = @(x) 1 + (-13 + x(1) - x(2).^3 + 5*x(2).^2 - 2*x(2)).^2 ...
  + (-29 + x(1) + x(2).^3 + x(2).^2 - 14*x(2)).^2; % x(1) = x, x(2) = y

end