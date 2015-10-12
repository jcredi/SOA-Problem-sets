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
    % TO-DO: generate slopes 5-9
  elseif (iSlope== 10)
   alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);
  end 
 
elseif (iDataSet == 2)                            % Validation
  if (iSlope == 1) 
    alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);
        % TO-DO: generate slopes 2-4
  elseif (iSlope == 5) 
    alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);
  end 
  
elseif (iDataSet == 3)                           % Test
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50);
        % TO-DO: generate slopes 2-4
 elseif (iSlope == 5)
   alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100);
 end
end
