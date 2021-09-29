%ode45
clc; close all; clear all;

timerange = [0 96];
IC = [1.1; zeros(27,1)];
[t,y] = ode45(@(t,y) RatSim(t,y),timerange, IC);

y_plasmatotal = y(:,2) + y(:,15) + y(:,16); 
y_livertotal = y(:,7) + y(:,21) + y(:,22);
y_kidneytotal = y(:,8) + y(:,9) + y(:,23) + y(:,24);
y_hearttotal = y(:,3) + y(:,17) + y(:,18);
y_spleentotal = y(:,4) + y(:,5) + y(:,19) + y(:,20);
y_lungtotal = y(:,11) + y(:,25) + y(:,26);


figure
subplot(2,3,1);
plot(t,y_plasmatotal);
hold on;
plot(t,y(:,1));
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Plasma')
hold off;

subplot(2,3,2);
plot(t,y_livertotal);
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Liver')

subplot(2,3,3);
plot(t,y_kidneytotal);
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Kidney')

subplot(2,3,4);
plot(t,y_hearttotal);
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Heart')

subplot(2,3,5);
plot(t,y_spleentotal);
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Spleen')

subplot(2,3,6);
plot(t,y_lungtotal);
set(gca, 'YScale', 'log')
xlabel('Time(h)');
ylabel('AmB Concentration(mg/L)');
title('Lung')




