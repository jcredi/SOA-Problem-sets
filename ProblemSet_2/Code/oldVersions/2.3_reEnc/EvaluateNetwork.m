function networkFitness = EvaluateNetwork(neuralNetwork, iDataSet, activationFunction)
%EvaluateNetwork

% Truck model parameters
timeStep = 0.1;
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
initialPosition = 0;
finalPosition = 1000;
initialPedalPressure = 0;
engineBreakMultipliers = [7.0, 5.0, 4.0, 3.0, 2.5, 2.0, 1.6, 1.4, 1.2, 1.0];
g = 9.8067;
switch iDataSet
  case 1
    nSlopes = 10;
  case 2
    nSlopes = 5;
  case 3
    nSlopes = 5;
end

fitnessInSlopes = zeros(nSlopes,1);

for iSlope = 1:nSlopes

  % Initialisations
  brakeTemperature = initialBrakeTemperature;
  speed = initialSpeed;
  position = initialPosition;
  slopeAngle = GetSlopeAngle(initialPosition, iSlope, iDataSet);
  isTruckOk = true;
  lastGearChange = 0;
  gear = initialGear;
  pedalPressure = initialPedalPressure;

  iStep = 0;
  time = 0;
  while isTruckOk

    iStep = iStep + 1;
    time = time + timeStep;

    newTemperature = UpdateBrakeTemperature(brakeTemperature(iStep), timeStep, ...
      ambientTemperature, coolingConstant, heatingConstant, pedalPressure(iStep));
    if newTemperature > maxTemperature
      break
    end
    
    acceleration = GetAcceleration(slopeAngle(iStep), brakeTemperature(iStep), ...
      maxTemperature, pedalPressure(iStep), truckMass, gear(iStep), ...
      engineBreakConstant, engineBreakMultipliers, g);
    newSpeed = speed(iStep) + timeStep*acceleration;
    if newSpeed > maxSpeed || newSpeed < 0
      break
    end
  
    newPosition = position(iStep) + timeStep*newSpeed;
    if newPosition > finalPosition
      break
    end
  
    newSlopeAngle = GetSlopeAngle(newPosition, iSlope, iDataSet);
    if newSlopeAngle > maxSlope
      break
    end
  
    brakeTemperature(iStep+1) = newTemperature;
    speed(iStep+1) = newSpeed;
    position(iStep+1) = newPosition;
    slopeAngle(iStep+1) = newSlopeAngle;
  
    [newPedalPressure, requestedGear] = RunFFNN(neuralNetwork, newSpeed/maxSpeed, ...
      newSlopeAngle/maxSlope, newTemperature/maxTemperature, activationFunction);
    pedalPressure(iStep+1) = newPedalPressure;
    
    if (requestedGear ~= 0) && (time - lastGearChange >= 2)
      if (requestedGear == +1) && (gear(iStep) < 10)
        gear(iStep+1) = gear(iStep) + 1;
        lastGearChange = time;
      elseif (requestedGear == -1) && (gear(iStep) > 1)
        gear(iStep+1) = gear(iStep) - 1;
        lastGearChange = time;
      else
        gear(iStep+1) = gear(iStep);
      end
    else    
      gear(iStep+1) = gear(iStep);
    end
  end % end truck run

  fitnessInSlopes(iSlope) = sqrt(mean(speed))*position(end);
end % end loop over slopes

networkFitness = mean(fitnessInSlopes);

end
