%% TESTPROGRAM
% 
% This program allows the user to run the best FFNN found (hard-coded
% below) as a truck braking control system on an arbitrary slope, specified
% below. The results of the simulation are plotted at the end.
clear; clc; close all;

%% Slope to run
alpha = @(x) 4 + sin(x/50) - 2*cos(sqrt(3)*x/50);
slopeLength = 10000;

%% Load best network
bestNetwork = LoadBestNetwork;

%% Truck model parameters
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
initialPedalPressure = 0;
engineBreakMultipliers = [7.0, 5.0, 4.0, 3.0, 2.5, 2.0, 1.6, 1.4, 1.2, 1.0];
beta = 1;
activationFunction = @(x) 1./(1+exp(-beta.*x)); % for FFNN

%% Initialisations
brakeTemperature = initialBrakeTemperature;
speed = initialSpeed;
position = initialPosition;
slopeAngle = alpha(initialPosition);
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
    fprintf('Run failed after %4.2f m (maximum temperature reached).\n',position(iStep));
    isTruckOk = false;
    break
  end

  acceleration = GetAcceleration(slopeAngle(iStep), brakeTemperature(iStep), ...
    maxTemperature, pedalPressure(iStep), truckMass, gear(iStep), ...
    engineBreakConstant, engineBreakMultipliers);
  newSpeed = speed(iStep) + timeStep*acceleration;
  if newSpeed > maxSpeed
    fprintf('Run failed after %4.2f m (maximum speed reached).\n',position(iStep));
    isTruckOk = false;
    break
  elseif newSpeed < 0
    fprintf('Run failed after %4.2f m (truck stopped).\n',position(iStep));
    break
  end

  newPosition = position(iStep) + timeStep*newSpeed;
  if newPosition > slopeLength
    disp('Run completed successfully!');
    break
  end

  newSlopeAngle = alpha(newPosition);
  if newSlopeAngle > maxSlope
    disp('Slope angle invalid (greater than maximum). Modify slope or increase maximum.\n');
    break
  end

  % If everything is fine, update output vectors
  brakeTemperature(iStep+1) = newTemperature;
  speed(iStep+1) = newSpeed;
  position(iStep+1) = newPosition;
  slopeAngle(iStep+1) = newSlopeAngle;

  % Now set new pedal pressure and gear using FFNN
  [newPedalPressure, requestedGear] = RunFFNN(bestNetwork, newSpeed/maxSpeed,...
    newSlopeAngle/maxSlope, newTemperature/maxTemperature, activationFunction);
  pedalPressure(iStep+1) = newPedalPressure;
  % Check if gear update is allowed
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

fitness = sqrt(mean(speed))*position(end);
fprintf('Network fitness = %4.3f\n',fitness);

figureHandle = PlotResults(position, slopeAngle, pedalPressure, gear, speed, brakeTemperature);