function acceleration = GetAcceleration(slopeAngle, brakeTemperature, ...
    maxTemperature, pedalPressure, truckMass, gear, engineBreakConstant)

g = 9.8067;

gravityForce = truckMass*g*sin((pi/180)*slopeAngle);

foundationBrakesForce = truckMass*g/20*pedalPressure;
deltaT = brakeTemperature - maxTemperature + 100;
if (deltaT >= 0)
  foundationBrakesForce = foundationBrakesForce*exp(-deltaT/100);
end

switch gear
  case 1
    multiplier = 7.0;  
  case 2
    multiplier = 5.0;  
  case 3
    multiplier = 4.0;  
  case 4
    multiplier = 3.0;  
  case 5
    multiplier = 2.5;  
  case 6
    multiplier = 2.0;  
  case 7
    multiplier = 1.6;  
  case 8
    multiplier = 1.4;
  case 9
    multiplier = 1.2;
  case 10
    multiplier = 1.0;
end
engineBreakForce = multiplier*engineBreakConstant;

acceleration = (gravityForce - foundationBrakesForce - engineBreakForce)/truckMass;

end