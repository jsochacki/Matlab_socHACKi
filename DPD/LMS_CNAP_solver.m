function [solution coefficients_progression e]=LMS_CNAP_solver(Mu,Order,pa_coefficients,lin_initial_coefficients,input,desired_output,channel_noise)

Muopt=Mu;
Ncoefficients=Order;
PAcoefficients=pa_coefficients;

if isvector(lin_initial_coefficients)
    LINEARIZERcoefficients=lin_initial_coefficients;
else
    LINEARIZERcoefficients=zeros(1,Ncoefficients);
end

n=0; currentbasis=0; pa_input_basis=0; lin_input_basis=0;
for n=1:1:length(input)
    [currentlinbasis LINEARIZERcoefficients lin_input_basis]...
        =ooSSPA(input(n),LINEARIZERcoefficients,[]);
    [currentbasis PAcoefficients pa_input_basis]...
        =ooSSPA(currentlinbasis,PAcoefficients,[]);
    currentbasis=currentbasis+channel_noise(n);
    e(n)=desired_output(n)-currentbasis;
    LINEARIZERcoefficients=LINEARIZERcoefficients+Muopt*...
        (CNAP_Update_Equation(lin_input_basis,pa_input_basis,PAcoefficients,e(n),Ncoefficients,[]));
    coefficients_progression(n,1:1:length(LINEARIZERcoefficients))=LINEARIZERcoefficients;
end

solution=LINEARIZERcoefficients;
