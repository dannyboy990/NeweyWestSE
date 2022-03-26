%%% date: 14/04/2012
%%% Function builds Gamma


function Gamma=Gammat(x_t, u_t,q,K,T)

u_t=repmat(u_t, 1, K);
A=x_t.*u_t;
A=A';

Gamma=A(:,q+1:T)*A(:,1:T-q)';

