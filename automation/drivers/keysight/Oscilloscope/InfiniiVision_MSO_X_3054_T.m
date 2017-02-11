function [handle]=InfiniiVision_MSO_X_3054_T()
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

InfiniiVision_MSO_X_3054_T_USB_HWID='USB0::10893::6002::MY54440203::INSTR';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DECLARATION: IVI-COM WRAPPED DRIVERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

InfiniiVision_MSO_X_3054_T_IVI_COM_WRAPPED_DRIVER='AgInfiniiVision_IVICOM_Driver';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DECLARATION: IVI-C WRAPPED DRIVERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

InfiniiVision_MSO_X_3054_T_IVI_C_WRAPPED_DRIVER='AgInfiniiVision_IVIC_Driver';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%DECLARATION: END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handle=struct('HardwareId',...
                struct('USB',InfiniiVision_MSO_X_3054_T_USB_HWID),...
              'Drivers',...
                struct('IAgInfiniiVision5',instrument.driver.AgInfiniiVision(),...
                       'IVI_COM_Matlab_Wrapped',InfiniiVision_MSO_X_3054_T_IVI_COM_WRAPPED_DRIVER,...
                       'IVI_C_Matlab_Wrapped',InfiniiVision_MSO_X_3054_T_IVI_C_WRAPPED_DRIVER),...
              'Global',...
                struct('Enumerations',eval('@() Global_Enums_For_InfiniiVision_MSO_X_3054_T()'),...
                       'Types',eval('@() Global_Types()'),...
                       'Casts',eval('@() Global_Casts()')));
                   
end