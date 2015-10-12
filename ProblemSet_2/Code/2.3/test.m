%test
clear
clc

iSlope = 1;
iDataSet = 1;

ambientTemperature = 283;
maxTemperature = 750;
truckMass = 20000;
coolingConstant = 30;
heatingConstant = 40;
engineBreakConstant = 3000;
maxSpeed = 25;
maxSlope = 10;
initialBrakeTemperature = 500;
initialSpeed = 20;
initialGear = 7;

timeStep = 0.1;
initialPosition = 0;
finalPosition = 1000;

% Initialisations
brakeTemperature = initialBrakeTemperature;
speed = initialSpeed;
position = initialPosition;
slopeAngle = GetSlopeAngle(initialPosition, iSlope, iDataSet);

isTruckOk = true;

gear = 1;
pedalPressure = 0;


iStep = 0;
while isTruckOk

  iStep = iStep + 1;

  newTemperature = UpdateBrakeTemperature(brakeTemperature(iStep), timeStep, ...
    ambientTemperature, coolingConstant, heatingConstant, pedalPressure);
  if newTemperature > maxTemperature
    fprintf('Slope %i of dataset %i failed (maximum temperature reached).\n',iSlope, iDataSet);
    isTruckOk = false;
    break
  end

  acceleration = GetAcceleration(slopeAngle(iStep), brakeTemperature(iStep), ...
    maxTemperature, pedalPressure, truckMass, gear, engineBreakConstant);
  newSpeed = speed(iStep) + timeStep*acceleration;
  if newSpeed > maxSpeed
    fprintf('Slope %i of dataset %i failed (maximum speed reached).\n',iSlope, iDataSet);
    isTruckOk = false;
    break
  elseif newSpeed < 0
    fprintf('Slope %i of dataset %i failed (truck stopped!!).\n',iSlope, iDataSet);
    break
  end
  
  newPosition = position(iStep) + timeStep*newSpeed;
  if newPosition > finalPosition
    fprintf('Slope %i of dataset %i completed.\n',iSlope, iDataSet);
    break
  end
  
  newSlopeAngle = GetSlopeAngle(newPosition, iSlope, iDataSet);
  if newSlopeAngle > maxSlope
    fprintf('Slope %i of dataset %i invalid. Check!\n',iSlope, iDataSet);
    break
  end
  
  % If everything is fine, update output vectors
  brakeTemperature(iStep+1) = newTemperature;
  speed(iStep+1) = newSpeed;
  position(iStep+1) = newPosition;
  slopeAngle(iStep+1) = newSlopeAngle;
  
  % Now set new pressure and gear
  
end

fitness = mean(speed)*position(end).^2