function [b,tstat,adjrsquare,n,resid,pred,wald,pwald,V_T]=fastnw(Y,x_t,b_int,q,waldlag)

%% if q=0 -> white, no q, automatic, q=-1 -> OLS standard errors
%% get rid of NaN's
temp=[Y x_t];
mat=packr(temp);
Y=mat(:,1);
x_t=mat(:,2:end);
n=size(Y,1);

if b_int %% if intercept
    x_t=[ones( size(x_t,1), 1) ,x_t];
end

b=(x_t'*x_t)\(x_t'*Y); %% OLS reg
K=size(x_t,2);
T=size(x_t,1);
u_t=Y-x_t*b;
Y_tag=temp(:,1);
x_tag=temp(:,2:end);

if b_int %% if intercept
        x_tag=[ones( size(x_tag,1), 1) ,x_tag];
end
resid=Y_tag-x_tag*b; %% we use the before packr command so we have all obs.
pred=x_tag*b; 

if nargin < 4
q=floor( 4*( T/100)^(2/9) );
end

rsquare=( 1-(var(u_t)/var(Y) ) );

adjrsquare=(1-( (1-rsquare)*(T-1))/(T-K-1 ))*100;

if q~=-1

Gamma_0=Gammat(x_t,u_t,0,K,T);

S_t=Gamma_0;
for i=1:q
Gamma_t=Gammat(x_t,u_t,i,K,T);
S_t=S_t+( Gamma_t+Gamma_t') *( 1-i/(q+1) );
end

A=x_t';
Q=A*A';

V_T=(Q\S_t)/Q;

SE=sqrt( diag(V_T) );

tstat=b./SE;
else
    sigmasquared=(u_t'*u_t)/(T-K);
    Q=(x_t'*x_t);
    V_T=sigmasquared.*inv(Q);
    SE=sqrt( diag(V_T) );
   tstat=b./SE;
end

if nargin<5
waldlag=2;
wald=b(waldlag:end)'*inv(V_T(waldlag:end,waldlag:end))*b(waldlag:end);%% test for joint significance without the coefficient
dof=size(b,1); 
pwald=1-chi2cdf(wald,dof);
else
wald=b(waldlag:end)'*inv(V_T(waldlag:end,waldlag:end))*b(waldlag:end);%% test for joint significance without the coefficient
dof=size(b,1); 
pwald=1-chi2cdf(wald,dof);
end


