% IRK2s_order
% Implicit Runge-Kutta(Gauss method) 2 stage and order 4
% u'=u in [0,1] with initial condition u(0)=1
% exact solution: ue=exp(x)
clear all; close all
Nvec=[10 50 100 200 500 1000];
MErr=[];
for n=1:length(Nvec)
    N=Nvec(n);
    h=1/N;
    x=[0:h:1];
    u(1)=1;
    X0=[1;1];
    % Newton iteration
    for i=1:N
        k=u(i);
        r=X0;
        tol=1;
        while tol>1.0e-6
            X=r;
            D=[1-0.25*h,-h*(0.25-(sqrt(3))/6);...
            -h*( 0.25+(sqrt(3))/6),1-h*0.25];    % Jacobian matrix
            F=[X(1)-k-h*(0.25*X(1)+(0.25-(sqrt(3))/6)*X(2));...
            X(2)-k-h*((0.25+(sqrt(3))/6)*X(1)+0.25*X(2))];   % RHS
            r=X-D\F;
            tol=norm(r-X);
        end
        k1=r(1);
        k2=r(2);
        u(i+1)=k+(h/2)*(k1+k2);
    end
    ue=exp(x);                   % exact solution
    Merr=max(abs(u-ue));  % maximum error
    MErr=[MErr,Merr];
end
plot(log10(Nvec),log10(MErr),'r*-','LineWidth',1.5)
hold on,
plot(log10(Nvec), log10(Nvec.^(-4)), '--')
grid on,
xlabel('N','fontsize', 16), ylabel('Error','fontsize',16)
title('Convergence order of Gauss method ','fontsize',14)
set(gca,'fontsize',14)

for i=1:length(Nvec)-1     % computating convergence order
    order(i)=-log(MErr(i)/MErr(i+1))/(log(Nvec(i)/Nvec(i+1)));
end
MErr
order
