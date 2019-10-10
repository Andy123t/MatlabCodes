% Legendre-collocation Method for the model equation: 
% -u''(y)+u(y)=f(y) in [0,1] with boundary condition: u(0)=1, u'(1)=0; 
% test function : u(y)=(1-y)^2*exp(y);
% RHS : f(y)=(2-4*y)*exp(y); 
% Rmk: Use routines legslb(); legslbdiff(); 
clear all;  clf
Nvec=4:18;
Errv=[]; condnv=[];
for N=Nvec
    xv=legslb(N);              % compute LGL nodes and weights
    yv=1/2*(xv+1);            % variable substitution
    u=(1-yv).^2.*exp(yv);   % test solution in [0,1]
    f=(2-4*yv).*exp(yv);      % RHS in [0,1] 
    
    % Setup and solve the collocation system
    D1=legslbdiff(N,xv);     % 1st order differentiation matrices
    D2=D1*D1;                  % 2nd order differentiation matrices
    D=-4*D2+eye(N);         % coefficient matrix
    D(1,:)=[1,zeros(1,N-1)];  D(N,:)=D1(N,:);
    b=[1; f(2:N-1); 0];         % RHS
    un=D\b;                      % Solve the system 
    
    error=norm(abs(un-u),2);   % L^2 error
    Errv=[Errv;error];
    condnv=[condnv,cond(D)];
end
% Plot the L^2 error 
plot(Nvec,log10(Errv),'s-','color',[0 0.5 0],'MarkerFaceColor','w','LineWidth',1.5)
grid on, xlabel('N','fontsize', 14), ylabel('log_{10}(Error)','fontsize',14),
title('L^2 error of Legendre-collocation method','fontsize',12)


print -dpng -r600  LegenCM3_error.png
