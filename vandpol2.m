clear all

global mu SimulationInput BSM BSF JM JG1 JF g Gc GR L R KE KF KG KI KR KS KT lF mF ctrl phi_ref time2 f theta_u
BSM = 0.01;
BSF = 1.5;
JM = 0.002;
JG1 = 0.001;
JF = 0.0204;
g = 9.81 ;
Gc = 6.1;
GR = 1.6;
L = 0.1 ;
R = 4 ;
KE = 0.35; 
KF = 0.5;
KG = 2.0;
%KI = 0 ;
KR = 1.5;
KS = 1.5;
KT = 0.35; 
lF = 0.35 ;
mF = 0.5 ;
phi_ref=0.785398163;
theta_u=0.087266462;
SimulationInput = 0;
mu = 1;




% Define parameters for the simulation

stepsize = 0.001;				% Integration step size
comminterval = 0.04;			% Communications interval
EndTime = 150;					% Duration of the simulation (final time)
i = 0;							% Initialise counter for data storage

% Initial conditions of all states and state derivatives

x = [0,0,0,0,0,0.087266462,0]';
xdot = [0,0,0,0,0,0,0]';

%
% END OF INITIAL SEGMENT - all parameters initialised
%
% DYNAMIC SEGMENT

%interpolation data import
M=csvread('interpol_data.txt');
r=M(:,1);
c=M(:,2);
index=1;
time2=r.';
f=c.';
f=f.*3.1415/180;


for time = 0:stepsize:EndTime,
   
    % store time state and state derivative data every communication interval
   
    if rem(time,comminterval)==0
      
        i = i+1;					% increment counter 
        tout(i) = time;	 	% store time
        xout(i,:) = x;			% store states
        xdout(i,:) = xdot;	% store state derivatives
      
    end							% end of storage      
   %need controller
   Gc = 0.175;
   KI = 0.827;
   theta_u=interpolation(time);
   delta = KR*phi_ref - KS*x(3);
   ctrl=Gc*(delta+KI*eulerint(delta,stepsize, delta));
    % DERIVATIVE SECTION

	
	xdot = model3(x,SimulationInput);


	% INTEG SECTION

    x = rk4int('model3',stepsize,x,SimulationInput);
    %x=eulerint(xdot,stepsize,x);
    % END OF INTEG SECTION
  
   
end

% END OF DYNAMIC SEGMENT
%
% TERMINAL SEGMENT
figure(1)
hold on
clf
plot(tout,xout(:,1),'b-')
xlabel('time [s]')
ylabel('Current [A]')

figure(2)
hold on
clf
plot(tout,xout(:,2),'b-')
xlabel('time [s]')
ylabel('Actuator angular velocity [rad/s]')

figure(3)
hold on
clf
plot(tout,xout(:,3),'b-')
xlabel('time [s]')
ylabel('Actuator deflection angle [rad]')

figure(4)
hold on
clf
plot(tout,xout(:,4),'b-')
xlabel('time [s]')
ylabel('Gear angular velocity [rad/s]')

figure(5)
hold on
clf
plot(tout,xout(:,5),'b-')
xlabel('time [s]')
ylabel('Forearm angular velocity [rad/s]')

figure(6)
hold on
clf
plot(tout,xout(:,6),'b-')
xlabel('time [s]')
ylabel('Forearm deflection angle [rad]')
figure(7)
hold on
clf
plot(tout,xout(:,7),'b-')
xlabel('time [s]')
ylabel('Gear deflection angle [rad]')

