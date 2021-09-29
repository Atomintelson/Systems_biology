y0 = [0.5; 1.0];
tspan = [0 10];
[t, y] = ode45(@odefun, tspan, y0);
plot(t,y)