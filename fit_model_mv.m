function [logL_mv]=fit_model_mv(parms,x,t,err)


a=parms(1);
b=parms(2);

s=2*x(:)./2.^((t(:)-a)/b);


P=max(normpdf(err(:),0,s(:)),1e-6);
plot(x,s,'o'); shg;
logL_mv=sum(-log(P));