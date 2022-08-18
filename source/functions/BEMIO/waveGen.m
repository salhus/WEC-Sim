function [] = waveGen(waveObj,simuObj,bemFreq,bemWaterDepth) 
simuObj.time = (simuObj.startTime:simuObj.dt:simuObj.endTime);
if ~isequal(waveObj.type,'regular') 
setup(waveObj,bemFreq,bemWaterDepth,...
      simuObj.rampTime,simuObj.dt,length(simuObj.time),simuObj.time,...
      simuObj.gravity,simuObj.rho);
elseif isequal(waveObj.type,'regular') 
      waveObj.amplitude = waveObj.height/2;
      waveObj.omega     = 2*pi/waveObj.period;
end
calculateElevation(waveObj,simuObj.rampTime,simuObj.time);
end
