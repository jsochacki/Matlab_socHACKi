function [handle]=Trueform_33622A()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Device Declarations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DECLARATION: START
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DECLARATION: HWID ADDRESSES AND WRAPPED DRIVERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DECLARATION: HWID ADDRESSES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Trueform_33622A_USB_HWID='USB0::2391::22279::MY53800673::0::INSTR';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DECLARATION: IVI-COM WRAPPED DRIVERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Trueform_33622A_IVI_COM_WRAPPED_DRIVER='Ag33622A_IVICOM_Driver';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DECLARATION: IVI-C WRAPPED DRIVERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Trueform_33622A_IVI_C_WRAPPED_DRIVER='Ag33622A_IVIC_Driver';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DECLARATION: END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


handle=struct('HardwareId',...
                struct('USB',Trueform_33622A_USB_HWID),...
              'Drivers',...
                struct('IAg3352x4',instrument.driver.Ag3352x(),...
                       'IVI_COM_Matlab_Wrapped',Trueform_33622A_IVI_COM_WRAPPED_DRIVER,...
                       'IVI_C_Matlab_Wrapped',Trueform_33622A_IVI_C_WRAPPED_DRIVER),...
              'Global',...
                struct('Enumerations',eval('@() Global_Enums_For_Trueform_33622A()'),...
                       'Types',eval('@() Global_Types()'),...
                       'Casts',eval('@() Global_Casts()')));
                   
end