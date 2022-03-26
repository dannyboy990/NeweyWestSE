# NeweyWestSE
Newey-West standard errors in Matlab
The main file you want to use is fastnw.m.
These are the following inputs: fastnw(Y,x_t,b_int,q,waldlag),
where Y is the dependent Tx1 array variable, x_t are the independent variables (TxM), b_int is a scalar
you can set to either 0 (no intercept) or 1 (intercept). q sets the number of lags you want to set for the errors. If you don't 
set it, it would be set automatically. Waldlag is the amount of coefficients you want to test for the Wald test (coefficients 
begin equal to zero) from the first coefficient to the nth (which is for you to set).

As outputs, you have [b,tstat,adjrsquare,n,resid,pred,wald,pwald,V_T]
where b: coefficients, tstat, adjusted R-sqaured, number of obs., Tx1 array of residuals, Tx1 array of explained values,
wald test statistic, p-statistic of the Wald test and the var-covar matrix.
