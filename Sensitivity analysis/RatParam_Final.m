function params = RatParam_Final()

format long

% All constant parameters

% Plasma parameters
V_PL = 0.016;         % 0.016 L Found from net
fu_PL = 0.11;         % Unitless Given in literature for rats

% Gastrointestinal tract parameters
V_GI = 0.00675;       % L Calculated from parameters google sheet
params(1) = 9.75;     % 10.7 Unitless Given in literature for rats Unitless 
Q_GI = 0.712/1000;        % L/h Calculated from parameters google sheet

% Heart parameters
V_HT = 0.000825;      % L Calculated from parameters google sheet
params(2) = 2;        % 2.0;          % Unitless Given in literature for rats
Q_HT = 0.244/1000;        % L/h

% Spleen parameters
V_SP_VAS = 0.00011;   % L Calculated from parameters google sheet
Q_SP = 0.0498/1000;       % L/h
params(3) = 7.47;     % 0.598;         % L/h Given in literature for rats
params(4) = 0.0027;   % 0.00171;       % Unitless Given in literature for rats
V_SP_EXV = 0.00039;   % L Calculated from parameters google sheet
params(5) = 9.32;     % 0.905;         % 1/h Given in literature for rats
params(6) = 0.0237;   % 0.0456;       % 1/h Given in literature for rats
params(18) = 40.7407; % 40.7407;      % Unitless Calculated from formula Kp = fu_PL / fu_tissue

% Liver parameters
V_LI = 0.00915;       % L Calculated from parameters google sheet
params(7) = 24.4;     % 33.0;         % Unitless Given in literature for rats
Q_LI = 0.911/1000;        % L/h
params(8) = 0.06;     % 0.06;         % L/h Given in literature for rats

% Kidney parameters
V_KD_VAS = 0.000292;  % L Calculated from parameters google sheet
Q_KD = 0.702/1000;        % L/h
params(9) = 0.115;    % 0.075;        % L/h Given in literature for rats
params(10) = 0.0043;  % Unitless Given in literature for rats
V_KD_EXV = 0.001533;  % L Calculated from parameters google sheet
params(12) = 0.258;   % 1/h  --FIXED--
params(13) = 0.00129; % 1/h  --FIXED--
params(11) = 0.1;     %0.1;          % L/h  Given in literature for rats

% Lung parameters
V_LU = 0.00125;       % L Calculated from parameters google sheet
params(14) = 70.1;    % Unitless Given in literature for rats

% Remainder parameters
V_RM_VAS = 0.009188; % L Calculated from parameters google sheet
Q_RM = 2.3629/1000;       % L/h
params(15) = 2.12;   % L/h Given in literature for rats
params(16) = 0.05;   % Unitless Given in literature for rats
V_RM_EXV = 0.220512; % L Calculated from parameters google sheet
params(17) = 0.11;   % 0.158;        % L/h Given in literature for rats

% Other parameters
Q_CO = 4.98/1000;         % 4.98 L/h  CO(rat) = 14.1 * (body weight)^0.75
Q_HA = 0.104/1000;        % L/h



params = params(:);
