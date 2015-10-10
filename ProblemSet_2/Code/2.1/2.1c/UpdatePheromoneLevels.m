function pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho)

pheromoneLevel = (1-rho).*pheromoneLevel;
pheromoneLevel = pheromoneLevel + deltaPheromoneLevel;


end