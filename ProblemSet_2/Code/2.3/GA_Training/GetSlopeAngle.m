function alpha = GetSlopeAngle(x, iSlope, iDataSet)

if (iDataSet == 1)                                % Training
  if (iSlope == 1) 
    alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);
  elseif (iSlope == 2)
    alpha = 3 + (x/2000) + 2*sin(x/75) - cos(sqrt(3)*x/50);
  elseif (iSlope == 3)
    alpha = 4 + 3*sin(x/120) + cos(sqrt(2)*x/40);
  elseif (iSlope == 4)
    alpha = 5 + 2*sin(sqrt(3)*x/100) + cos(sqrt(5)*x/50);
  elseif (iSlope == 5)
    alpha = 4 - sin(sqrt(7)*x/100) + 2*cos(sqrt(3)*x/50);
  elseif (iSlope == 6)
    alpha = 3 + 3*(x/1000) + sin(2*x/50) + 2*cos(x/250);
  elseif (iSlope == 7)
    alpha = 5 - 2*(x/1000) - sin(sqrt(7)*x/50) + 2*cos(sqrt(3)*x/100);
  elseif (iSlope == 8)
    alpha = 4 + sin(x/30) + 2*cos(sqrt(5)*x/100);
  elseif (iSlope == 9)
    alpha = 3 + 4*(x/1000) - sin(x/100) + cos(sqrt(7)*x/50);
  elseif (iSlope== 10)
   alpha = 2 + 2*sin(x/50) + cos(sqrt(2)*x/100);
  end 
 
elseif (iDataSet == 2)                            % Validation
  if (iSlope == 1) 
    alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);
  elseif (iSlope == 2) 
    alpha = 3 + 2*sin(x/50) + cos(sqrt(5)*x/100);
  elseif (iSlope == 3) 
    alpha = 6 - 3*(x/1000) + 2*sin(sqrt(2)*x/50) + cos(x/100); 
  elseif (iSlope == 4) 
    alpha = 3 + 2*(x/1000) + 2*sin(sqrt(7)*x/100) + cos(x/50); 
  elseif (iSlope == 5) 
    alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);
  end 
  
elseif (iDataSet == 3)                           % Test
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50);
 elseif (iSlope == 2)
   alpha = 4 + sin(x/50) - 2*cos(sqrt(3)*x/50);
 elseif (iSlope == 3)
   alpha = 3 + 3*(x/1000) + 2*sin(x/70) - cos(sqrt(5)*x/50);
 elseif (iSlope == 4)
   alpha = 6 - 2*(x/1000) - sin(sqrt(2)*x/50) + cos(x/100);  
 elseif (iSlope == 5)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100);
 end
end
