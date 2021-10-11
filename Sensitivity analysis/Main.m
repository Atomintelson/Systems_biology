x = [ 1.481; 2.222; 2.54; 4.868; 9.101; 12.698; 18.519; 23.915; 35.979; 48.042; 60; 72.063; 95.979];
y = [0.75; 0.601; 0.395; 0.235; 0.121; 0.094; 0.068; 0.064; 0.047; 0.028; 0.021; 0.006; 0.009];
timerange = linspace(min(x),max(x));
timerange = timerange.';
params = RatParam_Final;
idx = 1;    % This denotes param(1)
paramsiz = size(params);
len = paramsiz(1);
sensarray = [-0.8 -0.6 -0.4 -0.2 0 0.2 0.4 0.6 0.8]; % Percentages to test of a parameter
paramarray = zeros(18,9);
for i = 1:9
    paramarray(:,i) = [params(1:idx-1); (1 + sensarray(i)) * params(idx); params(idx+1:end)]; % New set of parameters to compare
end
disp('Parameter array succesfully created');

for j = 1:9
    Cfit(:,j) = kinetics5(paramarray(:,j), timerange); % Plotting curve of plasma conc for System of ODE wuth indivual parameter columns
    message = ['Plot ', num2str(j), ' created'];
    disp(message);
end
disp('Plots succesfully created');
    

figure(1)
plot(x, y, 'p', 'MarkerSize', 12)
set(gca, 'YScale', 'log')
hold on
plot(timerange, Cfit(:,1), 'LineWidth', 2);
plot(timerange, Cfit(:,2), 'LineWidth', 2);
plot(timerange, Cfit(:,3), 'LineWidth', 2);
plot(timerange, Cfit(:,4), 'LineWidth', 2);
plot(timerange, Cfit(:,5), 'LineWidth', 2);
plot(timerange, Cfit(:,6), 'LineWidth', 2);
plot(timerange, Cfit(:,7), 'LineWidth', 2);
plot(timerange, Cfit(:,8), 'LineWidth', 2);
plot(timerange, Cfit(:,9), 'LineWidth', 2);
hold off
grid
xlabel('Time')
ylabel('Concentration')
legend('Experimental','1','2','3','4','5','6','7','8','9')


