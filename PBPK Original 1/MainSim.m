clc; close all; clear all;

timerange = linspace(0, 120); % [0 2]
IC = [1.171; zeros(12,1)];
[t,y] = ode45(@(t,y) RatSim(t,y),timerange, IC);

% plot(t,y);
% plot(t,y(:,1));
% set(gca, 'YScale', 'log')
% xlabel('Time(h)');
% ylabel('AmB Concentration(mg/L)');
% title('Plasma')

figure
subplot(3,3,1);
plot(t,y);
plot(t,y(:,7));
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Liver')

subplot(3,3,2);
plot(t,y(:,8));
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Kidney')

subplot(3,3,3);
plot(t,y(:,4));
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Spleen')

subplot(3,3,4);
plot(t,y(:,11));
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Lung')

subplot(3,3,5);
plot(t,y(:,3));
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Heart')

subplot(3,3,6);
plot(t,y(:,2));
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('GI Tract')
