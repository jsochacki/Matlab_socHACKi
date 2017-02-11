function [output]=TWODSSPA(vector_input_1,vector_input_2,coefficients)

trn_1=0;
trn_2=0;
if size(coefficients,1) > 1, coefficients=coefficients.';, end;
if size(vector_input_1,1) > 1, trn_1=1; vector_input_1=vector_input_1.';, end;
if size(vector_input_2,1) > 1, trn_2=1; vector_input_2=vector_input_2.';, end;

output=coefficients*[vector_input_1;...
    (vector_input_1.*(vector_input_1.*vector_input_1'.'))+...
    (vector_input_1.*(vector_input_2.*vector_input_2'.'));...
    (vector_input_1.*(vector_input_1.*vector_input_1'.').*(vector_input_1.*vector_input_1'.'))+...
    (vector_input_1.*(vector_input_2.*vector_input_2'.').*(vector_input_2.*vector_input_2'.'))+...
    4.*(vector_input_1.*(vector_input_1.*vector_input_1'.').*(vector_input_2.*vector_input_2'.'))];

if trn_1, vector_input_1=vector_input_1.';, end;
if trn_2, vector_input_2=vector_input_2.';, end;

end