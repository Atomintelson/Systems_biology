function PBPK = RatSim(t,y,params)

format long

% All constant parameters

% New Parameters given in value and literature estimated in comments

% Plasma parameters
V_PL = 0.24;          % 0.016 L Found from net
fu_PL = 0.11;         % Unitless Given in literature for rats

% Gastrointestinal tract parameters
V_GI = 0.00675;       % L Calculated from parameters google sheet
params(1) = 14.655;   % 10.7;         % Unitless Given in literature for rats Unitless 
Q_GI = 0.7128;        % L/h Calculated from parameters google sheet

% Heart parameters
V_HT = 0.000825;      % L Calculated from parameters google sheet
params(2) = 2.455;    % 2.0;          % Unitless Given in literature for rats
Q_HT = 0.2442;        % L/h

% Spleen parameters
V_SP_VAS = 0.00011;   % L Calculated from parameters google sheet
Q_SP = 0.04985;       % L/h
params(3) = 0.598;    % 0.598;         % L/h Given in literature for rats estimated = 9.276
params(4) = 0.00171;  % 0.00171; Unitless Given in literature for rats
V_SP_EXV = 0.00039;   % L Calculated from parameters google sheet
params(5) = 0.9038;   % 0.905; 1/h Given in literature for rats
params(6) = 0.4569;   % 0.0456; 1/h Given in literature for rats
params(18) = 38.206;  % 40.7407; Unitless Calculated from formula Kp = fu_PL / fu_tissue

% Liver parameters
V_LI = 0.00915;       % L Calculated from parameters google sheet
params(7) = 35.842;   % 33; Unitless Given in literature for rats
Q_LI = 0.9122;        % L/h
params(8) = 0.06;   % 0.06; L/h Given in literature for rats estimated = 0.0216

% Kidney parameters
V_KD_VAS = 0.000292;  % L Calculated from parameters google sheet
Q_KD = 0.7028;        % L/h
params(9) = 0.075;    % 0.075; L/h Given in literature for rats estimated = 9.633
params(10) = 0.00726;  % 0.00726; Unitless Given in literature for rats estimated = 35.347
V_KD_EXV = 0.001533;  % L Calculated from parameters google sheet
params(12) = 0.258;   % 0.258; 1/h  --FIXED--
params(13) = 0.00129; % 0.00129; 1/h  --FIXED--
params(11) = 0.1;     % 0.1;          % L/h  Given in literature for rats estimated = 0.00015

% Lung parameters
V_LU = 0.00125;       % L Calculated from parameters google sheet
params(14) = 34.693;  % 34.3;         % Unitless Given in literature for rats

% Remainder parameters
V_RM_VAS = 0.009188; % L Calculated from parameters google sheet
Q_RM = 2.3629;       % L/h
params(15) = 0.5062; % 0.547; L/h Given in literature for rats
params(16) = 0.016;  % 0.016; Unitless Given in literature for rats estimmated = 50.44
V_RM_EXV = 0.220512; % L Calculated from parameters google sheet
params(17) = 0.055;  % 0.158; L/h Given in literature for rats

% Other parameters
Q_CO = 4.98;         % 4.98 L/h  CO(rat) = 14.1 * (body weight)^0.75  
Q_HA = 0.104;        % L/h


% Plasma equation 1
PBPK(1) = (Q_CO * ((y(11)/params(14)) - y(1)))/V_PL; 

% Gastrointestinal tract equation 2
PBPK(2) = (Q_GI * (y(1) - (y(2)/params(1))))/V_GI;

% Heart equation 3
PBPK(3) = (Q_HT * (y(1) - (y(3)/params(2))))/V_HT;

% Spleen equation 4,5,6
PBPK(4) = ((Q_SP * (y(1) - y(4))) - (params(3) * ((fu_PL * y(4)) - (params(4) * y(5)))))/V_SP_VAS;
PBPK(5) = ((params(3) * ((fu_PL * y(4)) - (params(4) * y(5)))) - (params(5) * params(4) * y(5) * V_SP_EXV) + (params(6) * y(6)))/V_SP_EXV;
PBPK(6) = (params(5) * params(4) * y(5) * V_SP_EXV) - (params(6) * y(6));

% Liver equation 7
PBPK(7) = ((Q_HA * y(1)) + (Q_SP * ((y(4) + y(5) + y(6))/params(18))) + (Q_GI * (y(2)/params(1))) - (Q_LI * (y(7)/params(7))) - (params(8) * fu_PL * (y(7)/params(7))))/V_LI;

% Kidney equation 8,9,10
PBPK(8) = ((Q_KD * (y(1) - y(8))) - (params(9) * ((fu_PL * y(8)) - (params(10) * y(9)))) - (params(11) * fu_PL * y(8)))/V_KD_VAS;
PBPK(9) = ((params(9) * ((fu_PL * y(8)) - (params(10) * y(9)))) - (params(12) * params(10) * y(9) * V_KD_EXV) + (params(13) * y(10)))/V_KD_EXV;
PBPK(10) = (params(12) * params(10) * y(9) * V_KD_EXV) - (params(13) * y(10));

% Lung equation 11
PBPK(11) = ((Q_LI * (y(7)/params(7))) + (Q_HT * (y(3)/params(2))) + (Q_KD * y(8)) + (Q_RM * y(12)) - (Q_CO * (y(11)/params(14))))/V_LU;

% Remainder equation 12,13
PBPK(12) = ((Q_RM * (y(1) - y(12))) - (params(15) * ((fu_PL * y(12)) - (params(16) * y(13)))))/V_RM_VAS;
PBPK(13) = ((params(15) * ((fu_PL * y(12)) - (params(16) * y(13)))) - (params(17) * params(16) * y(13)))/V_RM_EXV;

PBPK = PBPK(:);