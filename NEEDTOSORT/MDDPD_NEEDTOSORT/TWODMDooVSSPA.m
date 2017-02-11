function [voltage_out]=TWODooVSSPA(voltage_in_1,voltage_in_2,coefficients)

VP_1=[voltage_in_1;...
    (voltage_in_1.*(voltage_in_1.*voltage_in_1'.'));...
    (voltage_in_1.*(voltage_in_2.*voltage_in_2'.'));...
    (voltage_in_1.*(voltage_in_1.*voltage_in_1'.').*(voltage_in_1.*voltage_in_1'.'));...
    (voltage_in_1.*(voltage_in_2.*voltage_in_2'.').*(voltage_in_2.*voltage_in_2'.'));...
    4.*(voltage_in_1.*(voltage_in_1.*voltage_in_1'.').*(voltage_in_2.*voltage_in_2'.'))];
  

voltage_out=coefficients*VP_1;

end