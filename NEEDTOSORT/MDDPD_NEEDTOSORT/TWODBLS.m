function [coefficients_1]=TWODBLS(current_1,current_2,desired_1)

voltage_in_1=current_1;
voltage_in_2=current_2;

VP_1=[voltage_in_1;...
    (voltage_in_1.*(voltage_in_1.*voltage_in_1'.'))+...
    (voltage_in_1.*(voltage_in_2.*voltage_in_2'.'));...
    (voltage_in_1.*(voltage_in_1.*voltage_in_1'.').*(voltage_in_1.*voltage_in_1'.'))+...
    (voltage_in_1.*(voltage_in_2.*voltage_in_2'.').*(voltage_in_2.*voltage_in_2'.'))+...
    4.*(voltage_in_1.*(voltage_in_1.*voltage_in_1'.').*(voltage_in_2.*voltage_in_2'.'))];
  
VP_1=VP_1.';
coefficients_1=(inv(transpose(VP_1)*VP_1)*transpose(VP_1)*desired_1.').';