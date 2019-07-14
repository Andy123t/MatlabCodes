% Euler2.m
% Modified Euler method for a first-order ODE
% u'=t^2+t-u,  t \in [0,1]
% Initial value : u(0)=0
% Exact solution : u(t)=-exp(-t)+t^2-t+1.
clear all
h=0.1;
x=0:h:1;                            % function interval
n=length(x)-1;
u(1)=0;                             % initial value
fun=@(t,u) t.^2+t-u;        % RHS
for i=1:n
    k1=fun(x(i),u(i));
    k2=fun(x(i+1),u(i)+h*k1);
    u(i+1)=u(i)+(h/2)*(k1+k2);
end
ue=-exp(-x)+x.^2-x+1;        % exact solution
plot(x,ue,'b-',x,u,'r+','LineWidth',1.5)
xlabel('x','fontsize', 16), ylabel('y','fontsize',16,'Rotation',0)
legend('Exact','Numerical','location','North')
title('Modified Euler Method','fontsize',14)
set(gca,'fontsize',14)