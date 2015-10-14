function networkFitness = EvaluateNetworkPlot(neuralNetwork, iDataSet)
%EvaluateNetwork

% Parameters to experiment with
timeStep = 0.1;

% Truck model parameters
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
bonusFitness = 1;
beta = 1;
activationFunction = @(x) 1./(1+exp(-beta*x));
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
      %fprintf('Slope %i of dataset %i failed (maximum temperature reached).\n',iSlope, iDataSet);
      isTruckOk = false;
      break
    end
    
    acceleration = GetAcceleration(slopeAngle(iStep), brakeTemperature(iStep), ...
      maxTemperature, pedalPressure(iStep), truckMass, gear(iStep), ...
      engineBreakConstant, engineBreakMultipliers, g);
    newSpeed = speed(iStep) + timeStep*acceleration;
    if newSpeed > maxSpeed
      %fprintf('Slope %i of dataset %i failed (maximum speed reached).\n',iSlope, iDataSet);
      isTruckOk = false;
      break
    elseif newSpeed < 0
      bonusForCompletion = 0.5;
      %fprintf('Slope %i of dataset %i failed (truck stopped!!).\n',iSlope, iDataSet);
      break
    end
  
    newPosition = position(iStep) + timeStep*newSpeed;
    if newPosition > finalPosition
      %fprintf('Slope %i of dataset %i completed.\n',iSlope, iDataSet);
      bonusFitness = 2; % network takes a fitness bonus for slope completion
      break
    end
  
    newSlopeAngle = GetSlopeAngle(newPosition, iSlope, iDataSet);
    if newSlopeAngle > maxSlope
      %fprintf('Slope %i of dataset %i invalid. Check!\n',iSlope, iDataSet);
      break
    end
  
    % If everything is fine, update output vectors
    brakeTemperature(iStep+1) = newTemperature;
    speed(iStep+1) = newSpeed;
    position(iStep+1) = newPosition;
    slopeAngle(iStep+1) = newSlopeAngle;
  
    % Now set new pressure and gear
    [newPedalPressure, requestedGear] = RunFFNN(neuralNetwork,...
      newSpeed/maxSpeed, newSlopeAngle/maxSlope, ...
      newTemperature/maxTemperature, activationFunction);
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

  fitnessInSlopes(iSlope) = bonusFitness*sqrt(mean(speed))*position(end);
  figureHandle = PlotData(position, pedalPressure, gear, speed, ...
    brakeTemperature);
  pause;
  close all;
end % end loop over different slopes

networkFitness = mean(fitnessInSlopes)

end
