function [coefficients X]=test_1(Y,X)
%least_squares_coaxial_cable_constants_approximation
    % The equation is
    % y1 = ( E * (a*sqrt(x1)+b*x1) ) + c*sqrt(x1) + d*sqrt(x1)
    % ....
    % yn = ( E * (a*sqrt(xn)+b*xn) ) + c*sqrt(xn) + d*sqrt(xn)
    %
    % Which simplifies to
    % yn= E*a*sqrt(xn)+ c*sqrt(xn) + d*sqrt(xn) + E*b*xn
    %
    % and further still
    % yn = (E*b)*xn + (E*a + c + d)*sqrt(xn)
    % In matrix form Y=X*coefficients
    % | y1 | - |  x1  sqrt(x1)  | | E*b |
    % | y2 | - |  x2  sqrt(x2)  | | E*a + c + d |
    %  .
    %  .
    % | yn | - |  xn  sqrt(xn)  |
    %
    % Y : These are the output points for the local non-linear interpolation
    % X : %These are the input points for the local non-linear interpolation
    % coefficients : coefficients(1) = E*b
    %              : coefficients(2) = E*a + c + d
    trn1=0; trn2=0;
    if size(Y,2)> size(Y,1), trn1=1; Y=Y.', end;
    if size(X,2)> size(X,1), trn2=1; X=X.', end;
    X=[X sqrt(X)];
    coefficients=inv(X'*X)*X'*Y;
    if trn1, Y=Y.', end;
    if trn2, X=X.', end;
end