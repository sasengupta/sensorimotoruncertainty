function [logL]=fit_model_sv(parms,err,t,v)


a=parms(1);
b=parms(2);
c=parms(3);

s=a*(((v(:).^c).*((t(:))).^b));

P=max(normpdf(err(:),0,s(:)),1e-6);
plot(t,s,'o'); shg;
logL=sum(-log(P));

