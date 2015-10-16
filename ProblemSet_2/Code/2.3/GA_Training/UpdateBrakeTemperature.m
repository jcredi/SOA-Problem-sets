function newTemperature = UpdateBrakeTemperature(oldTemperature, ...
  timeStep,ambientTemperature,coolingConstant,heatingConstant,pedalPressure)

if pedalPressure < 0.01
  temperatureDerivative = -(oldTemperature-ambientTemperature)/coolingConstant;
else
  temperatureDerivative = heatingConstant*pedalPressure;
end

newTemperature = oldTemperature + timeStep*temperatureDerivative;
newTemperature = max(newTemperature,ambientTemperature);
    
end