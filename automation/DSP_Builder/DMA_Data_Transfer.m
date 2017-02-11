function [status_register]=DMA_Data_Transfer(Master_Object,DMA_CNTRL_BASE_ADDRESS,READ_FROM_START_ADDRESS,READ_TO_START_ADDRESS,NUMBER_OF_WORDS_TO_TRANSFER,iocntrl_parameters)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  The DMA Controlle always uses 32 bit wide registers so you do not    %%%
%  need to overload this function for other uint cases and sizes        %%%
%  however, the data transfer from and transfer to can be any width     %%%
%  that the system has been designed for and therefore they mush be     %%%
%  overloaded.                                                          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%iocntrl_parameters                                                   %%%
%bit 0 Byte Transfers if 1 else write 0
%bit 1 Halfword Transfers if 1 else write 0
%bit 2 Word Transfers if 1 else write 0
%bit 3 Enables DMA transaction when 1 else set to 0 to stop transactions
    %from being inacted.
%bit 4 Enables IRQ when 1 else write 0
%bit 5 Ends transfer on receipt of end of packet from read side when 1
    %else write 0.
%bit 6 Ends transfer on receipt of end of packet from write side when 1
    %else write 0.
%bit 7 Ends transfer when length register reaches zero if 1, else write 0.
%bit 8 Read constant address when 1 (i.e. read address does not
    %increment).  If auto incrementing read address is desired write 0.
%bit 9  Write constant address when 1 (i.e. write address does not
    %increment).  If auto incrementing write address is desired write 0.
%bit 10 Doubleword Transfers if 1 else write 0
%bit 11 Quadword Transfers if 1 else write 0
%bit 12 SOFTWARERESET write 1 to this bit 2 times in a row to reset the
    %DMA controller.  Else just write 0 to this bit.
%bits 13-31 Write 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%First you want to clear the status register so you can read later to see
%results of transaction
Master_Object.write('uint32',sprintf('0x%08X',hex2dec(DMA_CNTRL_BASE_ADDRESS)),hex2dec('00000000'));
%Tell the DMA Controller the address to start reading data from
Master_Object.write('uint32',sprintf('0x%08X',hex2dec(DMA_CNTRL_BASE_ADDRESS)+4),hex2dec(READ_FROM_START_ADDRESS));
%Tell the DMA Controller the address to start reading data to
Master_Object.write('uint32',sprintf('0x%08X',hex2dec(DMA_CNTRL_BASE_ADDRESS)+8),hex2dec(READ_TO_START_ADDRESS));
%Tell the DMA Controller the number of words to transfer
Master_Object.write('uint32',sprintf('0x%08X',hex2dec(DMA_CNTRL_BASE_ADDRESS)+12),NUMBER_OF_WORDS_TO_TRANSFER);
%Set up the DMA Controller control parameters
Master_Object.write('uint32',sprintf('0x%08X',hex2dec(DMA_CNTRL_BASE_ADDRESS)+24),bin2dec(iocntrl_parameters));

%The following base offsets are reserved and should not be written
%hex2dec(DMA_CNTRL_BASE_ADDRESS)+16)
%hex2dec(DMA_CNTRL_BASE_ADDRESS)+20)
%hex2dec(DMA_CNTRL_BASE_ADDRESS)+28)

%Read the results of the status register out of the function
status_register=sprintf('0x%08X',(Master_Object.read('uint32',sprintf('0x%08X',hex2dec(DMA_CNTRL_BASE_ADDRESS)),1)));

end