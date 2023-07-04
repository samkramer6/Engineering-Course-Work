%% Controls Notes of a Time-Domain response of a system
% Learning to plot and model a time domain response of a system in order to
% find the transient response of the system.

% --define the model parameters
m = 10; k = 100; b = 7; 
wn = sqrt(k/m);  z = b/(2*m*wn);
wd = wn*sqrt(1-z^2);
N = 200;
t = linspace(0,10,N);
x0 = 1;  
x0dot = 50;
c = (x0dot + z*wn*x0)/wd;

%  --compute the Initial Condition Response
x_ana_IC = exp(-z*wn*t).*(x0*cos(wd*t)+c*sin(wd*t));

%  --plot the Analytic Initial Condition Response
set(0,'defaultaxesfontsize',9)
set(0,'defaultlinelinewidth',1)
figure
plot(t,x_ana_IC,'r.-')
    grid on
    xlabel('Time (sec)')
    ylabel('Displacement (m)')
    title('Analytic Solution for the Initial Condition Response')
    legend('x_{IC}')
