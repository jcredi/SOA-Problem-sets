function acceleration = GetAcceleration(slopeAngle, brakeTemperature, ...
    maxTemperature, pedalPressure, truckMass, gear, engineBreakConstant,...
    engineBreakMultipliers, g)

gravityForce = truckMass*g*sin((pi/180)*slopeAngle);

foundationBrakesForce = truckMass*g/20*pedalPressure;
deltaT = brakeTemperature - maxTemperature + 100;
if (deltaT >= 0)
  foundationBrakesForce = foundationBrakesForce*exp(-deltaT/100);
end

engineBreakForce = engineBreakMultipliers(gear)*engineBreakConstant;

acceleration = (gravityForce - foundationBrakesForce - engineBreakForce)/truckMass;

end