function params = RatParam_Final()

format long
% All constant parameters
% Plasma parameters
V_PL = 0.016;         % 0.016L Found from net
fu_PL = 0.11;         % Unitless Given in literature for rats
    
% Gastrointestinal tract parameters
V_GI = 0.0113;        % L Calculated from parameters google sheet
params(1) = 9.75;         % Unitless Given in literature for rats Unitless 
Q_GI = 0.71214/1000;        % L/h Calculated from parameters google sheet

% Heart parameters
V_HT = 0.0012;      % L Calculated from parameters google sheet
params(2) = 2.0;          % Unitless Given in literature for rats
Q_HT = 0.24402/1000;        % L/h

% Spleen parameters
V_SP_VAS = 0.000286;   % L Calculated from parameters google sheet
Q_SP = 0.0498/1000;       % L/h
params(3) = 7.47;         % L/h Given in literature for rats
params(4) = 0.0027;       % Unitless Given in literature for rats
V_SP_EXV = 0.001014;   % L Calculated from parameters google sheet
params(5) = 9.32;         % 1/h Given in literature for rats
params(6) = 0.0237;       % 1/h Given in literature for rats
params(18) = 40.7407;      % Unitless Calculated from formula Kp = fu_PL / fu_tissue

% Liver parameters
V_LI = 0.0196;       % L Calculated from parameters google sheet
params(7) = 24.4;         % Unitless Given in literature for rats
Q_LI = 0.91134/1000;        % L/h
params(8) = 0.313;         % L/h Given in literature for rats

% Kidney parameters
V_KD_VAS = 0.000592;  % L Calculated from parameters google sheet
Q_KD = 0.70218/1000;        % L/h
params(9) = 0.115;        % L/h Given in literature for rats
params(10) = 0.0043;       % Unitless Given in literature for rats
V_KD_EXV = 0.003108;  % L Calculated from parameters google sheet
params(12) = 0.258;        % 1/h  --FIXED--
params(13) = 0.00129;      % 1/h  --FIXED--
params(11) = 0.995;          % L/h  Given in literature for rats

% Lung parameters
V_LU = 0.0021;       % L Calculated from parameters google sheet
params(14) = 15.035;         % Unitless Given in literature for rats

% Remainder parameters
V_RM_VAS = 0.0196; % L Calculated from parameters google sheet
Q_RM = 2.36052/1000;       % L/h
params(15) = 2.12;        % L/h Given in literature for rats
params(16) = 0.998;        % Unitless Given in literature for rats
V_RM_EXV = 0.4704; % L Calculated from parameters google sheet
params(17) = 0.0018;        % L/h Given in literature for rats

% Other parameters
Q_CO = 4.98/1000;         % 4.98 L/h  CO(rat) = 14.1 * (body weight)^0.75
Q_HA = 0.1139/1000;        % L/h


params = params(:);
