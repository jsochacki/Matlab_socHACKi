function [coefficients X]=Least_Squares_Linear_Approximation(Y,X)
% The equation is y1=a*x1+b .... yn=a*xn+b
% In matrix form Y=X*coefficients
% | y1 | _ |  x1  1  | | a |
% | y2 | - |  x2  1  | | b |
%  .
%  .
% | yn | - |  xn  1  |
% Y : These are the output points for the local linear interpolation
% X : %These are the input points for the local linear interpolation
trn1=0; trn2=0;
if size(Y,2)> size(Y,1), trn1=1; Y=Y.', end;
if size(X,2)> size(X,1), trn2=1; X=X.', end;
X=[X ones(max([size(X,1) size(X,2)]),1)];
coefficients=inv(X'*X)*X'*Y;
if trn1, Y=Y.', end;
if trn2, X=X.', end;
end