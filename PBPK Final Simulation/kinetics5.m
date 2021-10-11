function C=kinetics5(params, timerange)
IC = [1.171; zeros(12,1)];
[T,y] = ode45(@RatSim, timerange, IC);
%
disp('solving ODE')
    function PBPK = RatSim(timerange, y)
        format long

        % All constant parameters

        % Plasma parameters
        V_PL = 0.016;         % L Found from net
        fu_PL = 0.11;         % Unitless Given in literature for rats
    
        % Gastrointestinal tract parameters
        V_GI = 0.0113;       % L Calculated from parameters google sheet
        % params(1) = 9.75;         % Unitless Given in literature for rats Unitless 
        Q_GI = 0.71214/1000;        % L/h Calculated from parameters google sheet

        % Heart parameters
        V_HT = 0.0012;      % L Calculated from parameters google sheet
        % params(2) = 2.0;          % Unitless Given in literature for rats
        Q_HT = 0.24402/1000;        % L/h

        % Spleen parameters
        V_SP_VAS = 0.000286;   % L Calculated from parameters google sheet
        Q_SP = 0.0498/1000;       % L/h
        % params(3) = 7.47;         % L/h Given in literature for rats
        % params(4) = 0.989950205708831; %0.0027;       % Unitless Given in literature for rats
        V_SP_EXV = 0.001014;   % L Calculated from parameters google sheet
        % params(5) = 9.32;         % 1/h Given in literature for rats
        % params(6) = 0.0237;       % 1/h Given in literature for rats
        % params(18) = 19.0717669866853; %40.7407;      % Unitless Calculated from formula Kp = fu_PL / fu_tissue

        % Liver parameters
        V_LI = 0.0196;       % L Calculated from parameters google sheet
        % params(7) = 24.4;         % Unitless Given in literature for rats
        Q_LI = 0.91134/1000;        % L/h
        % params(8) = 0.06;         % L/h Given in literature for rats

        % Kidney parameters
        V_KD_VAS = 0.000592;  % L Calculated from parameters google sheet
        Q_KD = 0.70218/1000;        % L/h
        % params(9) = 0.115;        % L/h Given in literature for rats
        % params(10) = 0.0043;       % Unitless Given in literature for rats
        V_KD_EXV = 0.003108;  % L Calculated from parameters google sheet
        % params(12) = 0.258;        % 1/h  --FIXED--
        % params(13) = 0.00129;      % 1/h  --FIXED--
        % params(11) = 0.1;          % L/h  Given in literature for rats

        % Lung parameters
        V_LU = 0.0021;       % L Calculated from parameters google sheet
        % params(14) = 70.1;         % Unitless Given in literature for rats

        % Remainder parameters
        V_RM_VAS = 0.0196; % L Calculated from parameters google sheet
        Q_RM = 2.36052/1000;       % L/h
        % params(15) = 2.12;        % L/h Given in literature for rats
        % params(16) = 0.05;        % Unitless Given in literature for rats
        V_RM_EXV = 0.4704; % L Calculated from parameters google sheet
        % params(17) = 0.11;        % L/h Given in literature for rats

        % Other parameters
        Q_CO = 4.98/1000;         % L/h  CO(rat) = 14.1 * (body weight)^0.75
        Q_HA = 0.1139/1000;        % L/h


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
        PBPK(7) = ((Q_HA * y(1)) + (Q_SP * ((y(4) + y(5))/params(18))) + (Q_GI * (y(2)/params(1))) - (Q_LI * (y(7)/params(7))) - (params(8) * fu_PL * (y(7)/params(7))))/V_LI;

        % Kidney equation 8,9,10
        PBPK(8) = ((Q_KD * (y(1) - y(8))) - (params(9) * ((fu_PL * y(8)) - (params(10) * y(9)))) - (params(11) * fu_PL * y(8)))/V_KD_VAS;
        PBPK(9) = (params(9) * ((fu_PL * y(8)) - (params(10) * y(9))))/V_KD_EXV;
        PBPK(10) = 0;
        % Lung equation 11
        PBPK(11) = ((Q_LI * (y(7)/params(7))) + (Q_HT * (y(3)/params(2))) + (Q_KD * y(8)) + (Q_RM * y(12)) - (Q_CO * (y(11)/params(14))))/V_LU;

        % Remainder equation 12,13
        PBPK(12) = ((Q_RM * (y(1) - y(12))) - (params(15) * ((fu_PL * y(12)) - (params(16) * y(13)))))/V_RM_VAS;
        PBPK(13) = ((params(15) * ((fu_PL * y(12)) - (params(16) * y(13)))) - (params(17) * params(16) * y(13)))/V_RM_EXV;
        
        PBPK = PBPK(:);
    end

C = y(:,1);
end

