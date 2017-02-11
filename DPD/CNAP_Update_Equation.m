function [coefficient_update] = CNAP_Update_Equation(linearizer_basis_functions,pa_basis_functions,pa_coefficients,error_signal,order,memory)
%%%Equation 4.28 in Jakes Dissertation is wrong!!!!
%%%In his unpublished paper he has it correct as below
%%%I have hardcoded memory to 0 for now
memory=0;

%IF YOU USE ORDER IN THE WAY THAT JAKE DOES AND NOT AS AN INDEX
porder=(order*2)-1;
k1=1:2:porder; k2=3:2:porder;
i1=1:1:order; i2=2:1:order;

coefficient_update=(sum((error_signal).*((pa_coefficients(i1)'.').*...
    ((k1+1)./2).*abs(power(pa_basis_functions(1),k1-1))))+...
    sum((error_signal').*((pa_coefficients(i2)).*...
    ((k2-1)./2).*power(pa_basis_functions(1),2).*...
    abs(power(pa_basis_functions(1),k2-3))))).*linearizer_basis_functions';

end
