function xdot = model3(x,u);
global SimulationInput BSM BSF JM JG1 JF g Gc GR L R KE KF KG KI KR KS KT lF mF ctrl phi_ref theta_u

xdot(1,1) = (1/L)*(KG*ctrl-R*x(1)-KE*x(2));
xdot(2,1) =(1/JM)*(KT*x(1)-BSM*(x(2)-x(4)));
xdot(3,1) =x(2);
xdot(4,1) = (1/JG1)*(BSM*(x(2)-x(4)));
xdot(5,1) =(GR*KF*x(7)-(mF*lF)/2*g*sin(theta_u+x(6))-BSF*x(5))*1/JF;
xdot(6,1) =x(5);
xdot(7,1) =x(4);
end


