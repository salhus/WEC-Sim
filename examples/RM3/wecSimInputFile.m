%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'RM3.slx';      % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer = 'on';                   % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 10;                    % Wave Ramp Time [s]
simu.endTime = 500;                     % Simulation End Time [s]
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.1; 							% Simulation time-step [s]

%% Wave Information 


bemFreq = 0.02:0.02:5.2;
bemWaterDepth = 100;

% % % noWaveCIC, no waves with radiation CIC  
waves = waveClass('irregular');       % Initialize Wave Class and Specify Type  
waves.height = 0.0;                     % Wave Height [m]
waves.period = 3; 
waves.spectrumType = 'PM';
% % Regular Waves  
waves1 = waveClass('irregular');           % Initialize Wave Class and Specify Type                                 
waves1.height = 5.0;                     % Wave Height [m]
waves1.period = 2;                       % Wave Period [s]
waves1.spectrumType = 'PM';
waveGen(waves1,simu,bemFreq,bemWaterDepth) 
w1 = waves1.waveAmpTime;


waves2 = waveClass('irregular');           % Initialize Wave Class and Specify Type                                 
waves2.height = 0.25;                     % Wave Height [m]
waves2.period = 4;                       % Wave Period [s]
waves2.spectrumType = 'PM';


waveGen(waves2,simu,bemFreq,bemWaterDepth) 
w2 = waves2.waveAmpTime;


waves3 = waveClass('irregular');           % Initialize Wave Class and Specify Type                                 
waves3.height = .75;                     % Wave Height [m]
waves3.period = 2;                       % Wave Period [s]
waves3.spectrumType = 'PM';


waveGen(waves3,simu,bemFreq,bemWaterDepth) 
w3 = waves3.waveAmpTime;

waves4 = waveClass('irregular');           % Initialize Wave Class and Specify Type                                 
waves4.height = 2;                     % Wave Height [m]
waves4.period = 5;                       % Wave Period [s]
waves4.spectrumType = 'PM';


waveGen(waves4,simu,bemFreq,bemWaterDepth) 
w4 = waves4.waveAmpTime;

waveGroup = [waves1;waves2;waves3;waves4];
SwellandChop(:,1) = w1(:,1); 
SwellandChop(:,2) = w1(:,2) + w2(:,2) + w3(:,2) + w4(:,2);

save('SwellandChop.mat','SwellandChop')

% 
% waves = waveClass('spectrumImport');           % Initialize Wave Class and Specify Type                                 
% waves.spectrumFile ='SwellandChop.mat';
% load(waves.spectrumFile);
% waveElevUser(waves,simu.rampTime,length(simu.time)-1,SwellandChop,simu.time)



% % Regular Waves with CIC
% waves = waveClass('regularCIC');          % Initialize Wave Class and Specify Type                                 
% waves.height = 2.5;                       % Wave Height [m]
% waves.period = 8;                         % Wave Period [s]

% % Irregular Waves using PM Spectrum 
% waves = waveClass('irregular');           % Initialize Wave Class and Specify Type
% waves.height = 2.5;                       % Significant Wave Height [m]
% waves.period = 8;                         % Peak Period [s]
% waves.spectrumType = 'PM';                % Specify Wave Spectrum Type



% % Irregular Waves using JS Spectrum with Equal Energy and Seeded Phase
% waves = waveClass('irregular');           % Initialize Wave Class and Specify Type
% waves.height = 2.5;                       % Significant Wave Height [m]
% waves.period = 8;                         % Peak Period [s]
% waves.spectrumType = 'JS';                % Specify Wave Spectrum Type
% waves.bem.option = 'EqualEnergy';         % Uses 'EqualEnergy' bins (default) 
% waves.phaseSeed = 1;                      % Phase is seeded so eta is the same

% % Irregular Waves using PM Spectrum with Traditional and State Space 
% waves = waveClass('irregular');           % Initialize Wave Class and Specify Type
% waves.height = 2.5;                       % Significant Wave Height [m]
% waves.period = 8;                         % Peak Period [s]
% waves.spectrumType = 'PM';                % Specify Wave Spectrum Type
% simu.stateSpace = 1;                      % Turn on State Space
% waves.bem.option = 'Traditional';         % Uses 1000 frequnecies

% % Irregular Waves with imported spectrum
% waves = waveClass('spectrumImport');      % Create the Wave Variable and Specify Type
% waves.spectrumFile = 'spectrumData.mat';  % Name of User-Defined Spectrum File [:,2] = [f, Sf]

% % Waves with imported wave elevation time-history  
% waves = waveClass('elevationImport');          % Create the Wave Variable and Specify Type
% waves.elevationFile = 'elevationData.mat';     % Name of User-Defined Time-Series File [:,2] = [time, eta]


%% Body Data
% Float
body(1) = bodyClass('hydroData/rm3.h5');      
    % Create the body(1) Variable, Set Location of Hydrodynamic Data File 
    % and Body Number Within this File.   
body(1).geometryFile = 'geometry/float.stl';    % Location of Geomtry File
body(1).mass = 'equilibrium';                   
    % Body Mass. The 'equilibrium' Option Sets it to the Displaced Water 
    % Weight.
body(1).inertia = [20907301 21306090.66 37085481.11];  % Moment of Inertia [kg*m^2]     

% Spar/Plate
body(2) = bodyClass('hydroData/rm3.h5'); 
body(2).geometryFile = 'geometry/plate.stl'; 
body(2).mass = 'equilibrium';                   
body(2).inertia = [94419614.57 94407091.24 28542224.82];

%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('Constraint1'); % Initialize Constraint Class for Constraint1
constraint(1).location = [0 0 0];               % Constraint Location [m]

% Translational PTO
pto(1) = ptoClass('PTO1');                      % Initialize PTO Class for PTO1
pto(1).stiffness = 0;                           % PTO Stiffness [N/m]
pto(1).damping = 1200000;                       % PTO Damping [N/(m/s)]
pto(1).location = [0 0 0];                      % PTO Location [m]
