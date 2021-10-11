x1 = [ 1.481; 2.222; 2.54; 4.868; 9.101; 12.698; 18.519; 23.915; 35.979; 48.042; 60; 72.063; 95.979];
y1 = [0.75; 0.601; 0.395; 0.235; 0.121; 0.094; 0.068; 0.064; 0.047; 0.028; 0.021; 0.006; 0.009];
timerange = linspace(0,120);
timerange = timerange.';
plasma_interpolated = interp1(x1,y1,timerange,'cubic');
disp('interpolation done')
params = RatParam_Final;
Cfit = kinetics5(params, timerange);


figure(1)
plot(x1, y1, 'p', 'MarkerSize', 12)
set(gca, 'YScale', 'log')
hold on
hlp = plot(timerange, Cfit, 'LineWidth', 3);
hold off
grid
xlabel('Time')
ylabel('Concentration')
legend('Experimental','Simulated')


