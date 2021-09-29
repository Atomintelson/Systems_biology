function PBPK = RatSim(t,y)

format long

% All constant parameters

% Gastrointestinal tract parameters
V_GI = 0.00675;       % L
Kp_GI = 10.7;         % Unitless   --FIXED--
V_GI_VAS = 0.0012825; % L
Q_GI = 71.286/100;        % L/h
V_GI_EXV = 0.00546;   % L
Up_GI = 0.000204;     % L/h ---- Changeable

% Heart parameters
V_HT = 0.000825;      % L
Kp_HT = 2.0;          % Unitless  --FIXED--
V_HT_VAS = 0.0002145; % L
Q_HT = 24.427/100;        % L/h
V_HT_EXV = 0.00061;   % L
Up_HT = 0.000001;            % L/h ---- Changeable

% Spleen parameters
V_SP_VAS = 0.00011;   % L
Q_SP = 4.9851/100;        % L/h
PS_SP = 0.598;        % L/h   --FIXED--
fu_SP = 0.00171;      % Unitless  --FIXED--
C_SP_MAX = 270;       % mg/L ----- Changeable
V_SP_EXV = 0.00039;   % L
Ka_SP = 0.905;        % 1/h   --FIXED--
Kd_SP = 0.00456;      % 1/h   --FIXED--
Up_SP = 0.0000595;    % L/h ---- Changeable

% Liver parameters
V_LI = 0.00915;       % L
Kp_LI = 33.0;         % Unitless  --FIXED--
V_LI_VAS = 0.001921;  % L
Q_LI = 91.22738/100;      % L/h
C_LI_MAX = 121;       % mg/L ---- Changeable
V_LI_EXV = 0.007228;  % L
Cl_LI = 0.06;         % L/h   --FIXED--
Up_LI = 0.000462;     % L/h ---- Changeable

% Kidney parameters
V_KD_VAS = 0.000292;  % L
Q_KD = 70.28994/100;      % L/h
PS_KD = 0.075;        % L/h   --FIXED--
fu_KD = 0.00726;      % Unitless  --FIXED--
V_KD_EXV = 0.001533;  % L
Ka_KD = 0.258;        % 1/h  --FIXED--
Kd_KD = 0.00129;      % 1/h  --FIXED--
Cl_KD = 0.1;          % L/h  --FIXED--
Up_KD = 0.000001;            % L/h ---- Changeable

% Lung parameters
V_LU = 0.00125;       % L
Kp_LU = 34.3;         % Unitless  --FIXED--
V_LU_VAS = 0.00004;   % L
V_LU_EXV = 0.0008;    % L
Up_LU = 0.000001;            % L/h ---- Changeable

% Remainder parameters
V_RM_VAS = 0.01;      % L
Q_RM = 1.38;             % L/h
PS_RM = 0.547;        % L/h   --FIXED--
fu_RM = 0.016;        % Unitless  --FIXED--
V_RM_EXV = 0.24;      % L
Cl_RM = 0.158;        % L/h   --FIXED--
Up_RM = 0.0000197;    % L/h ---- Changeable

% Plasma parameters
V_PL = 0.001;         % L
fu_PL = 0.11;         % Unitless

% Other parameters
Q_CO = 4.98;          % L/h  -- FIXED
rel = 0.0035;         % 1/h
Q_HA = 11.403/100;        % L/h

% Nonliposomal compartments

% Plasma equation 1
PBPK(1) = ((Q_CO * ((y(11)/Kp_LU) - y(1))) + (rel * ((y(14) * V_PL) + (y(21) * V_LI_VAS) + (y(15) * V_GI_VAS) + (y(25) * V_LU_VAS) + (y(17) * V_HT_VAS))))/V_PL; 

% Gastrointestinal tract equation 2
PBPK(2) = ((Q_GI * (y(1) - (y(2)/Kp_GI))) + (rel * y(16) * V_GI_EXV))/V_GI;

% Heart equation 3
PBPK(3) = ((Q_HT * (y(1) - (y(3)/Kp_HT))) + (rel * y(18) * V_HT_EXV))/V_HT;

% Spleen equation 4,5,6
PBPK(4) = ((Q_SP * (y(1) - y(4))) - (PS_SP * ((fu_PL * y(4)) - (fu_SP * y(5)))) + (rel * y(19) * V_SP_VAS))/V_SP_VAS;
PBPK(5) = ((PS_SP * ((fu_PL * y(4)) - (fu_SP * y(5)))) - (Ka_SP * fu_SP * y(5) * V_SP_EXV) + (Kd_SP * y(6)) + (rel * y(20) * V_SP_EXV))/V_SP_EXV;
PBPK(6) = (Ka_SP * fu_SP * y(5) * V_SP_EXV) - (Kd_SP * y(6));

% Liver equation 7
PBPK(7) = ((Q_HA * y(1)) + (Q_SP * y(4)) + (Q_GI * (y(2)/Kp_GI)) - (Q_LI * (y(7)/Kp_LI)) - (Cl_LI * fu_PL * (y(7)/Kp_LI)) + (rel * y(22) * V_LI_EXV))/V_LI;

% Kidney equation 8,9,10
PBPK(8) = ((Q_KD * (y(1) - y(8))) - (PS_KD * ((fu_PL * y(8)) - (fu_KD * y(9)))) - (Cl_KD * fu_PL * y(8)) + (rel * y(23) * V_KD_VAS))/V_KD_VAS;
PBPK(9) = ((PS_KD * ((fu_PL * y(8)) - (fu_KD * y(9)))) - (Ka_KD * fu_KD * y(9) * V_KD_EXV) + (Kd_KD * y(10)) + (rel * y(24) * V_KD_EXV))/V_KD_EXV;
PBPK(10) = (Ka_KD * fu_KD * y(9) * V_KD_EXV) - (Kd_KD * y(10));

% Lung equation 11
PBPK(11) = ((Q_LI * (y(7)/Kp_LI)) + (Q_HT * (y(3)/Kp_HT)) + (Q_KD * y(8)) + (Q_RM * y(12)) - (Q_CO * (y(11)/Kp_LU)) + (rel * y(26) * V_LU_EXV))/V_LU;

% Remainder equation 12,13
PBPK(12) = ((Q_RM * (y(1) - y(12))) - (PS_RM * ((fu_PL * y(12)) - (fu_RM * y(13)))) + (rel * y(27) * V_RM_VAS))/V_RM_VAS;
PBPK(13) = ((PS_RM * ((fu_PL * y(12)) - (fu_RM * y(13)))) - (Cl_RM * fu_RM * y(13)) + (rel * y(28) * V_RM_EXV))/V_RM_EXV;

% Liposomal compartments

% Plasma equation 14
PBPK(14) = ((Q_CO * (y(25) - y(14))) - (rel * y(14) * V_PL))/V_PL;

% GI tract equation 15,16
PBPK(15) = ((Q_GI * (y(14) - y(15))) - (Up_GI * y(15)) - (rel * y(15) * V_GI_VAS))/V_GI_VAS;
PBPK(16) = ((Up_GI * y(15)) - (rel * y(16) * V_GI_EXV))/V_GI_EXV;

% Heart equation 17,18
PBPK(17) = ((Q_HT * (y(14) - y(17))) - (Up_HT * y(17)) - (rel * y(17) * V_HT_VAS))/V_HT_VAS;
PBPK(18) = ((Up_HT * y(17)) - (rel * y(18) * V_HT_EXV))/V_HT_EXV;

% Spleen equation 19,20
PBPK(19) = ((Q_SP * (y(14) - y(19))) - (Up_SP * (1 - (y(20)/C_SP_MAX)) * y(19)) - (rel * y(19) * V_SP_VAS))/V_SP_VAS;
PBPK(20) = ((Up_SP * (1 - (y(20)/C_SP_MAX)) * y(19)) - (rel * y(20) * V_SP_EXV))/V_SP_EXV;

% Liver equation 21,22
PBPK(21) = ((Q_HA * y(14)) + (Q_SP * y(19)) + (Q_GI * y(15)) - (Q_LI * y(21)) - (Up_LI * (1 - (y(22)/C_LI_MAX)) * y(21)) - (rel * y(21) * V_LI_VAS))/V_LI_VAS;
PBPK(22) = ((Up_LI * (1 - (y(22)/C_LI_MAX)) * y(21)) - (rel * y(22) * V_LI_EXV))/V_LI_EXV;

% Kidney equation 23,24
PBPK(23) = ((Q_KD * (y(14) - y(23))) - (Up_KD * y(23)) - (rel * y(23) * V_KD_VAS))/V_KD_VAS;
PBPK(24) = ((Up_KD * y(23)) - (rel * y(24) * V_KD_EXV))/V_KD_EXV;

% Lungs equation 25,26
PBPK(25) = ((Q_LI * y(21)) + (Q_HT * y(17)) + (Q_KD * y(23)) + (Q_RM * y(27)) - (Q_CO * y(25)) - (Up_LU * y(25)) - (rel * y(25) * V_LU_VAS))/V_LU_VAS;
PBPK(26) = ((Up_LU * y(25)) - (rel * y(26) * V_LU_EXV))/V_LU_EXV;

% Remainder equation 27,28
PBPK(27) = ((Q_RM * (y(14) - y(27))) - (Up_RM * y(27)) - (rel * y(27) * V_RM_VAS))/V_RM_VAS;
PBPK(28) = ((Up_RM * y(27)) - (rel * y(28) * V_RM_EXV))/V_RM_EXV;

PBPK = PBPK(:);