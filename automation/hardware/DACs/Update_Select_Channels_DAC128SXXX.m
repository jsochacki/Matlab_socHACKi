function [errors]=Update_Select_Channels_DAC128SXXX(Master_Object,BASE_ADDRESS,ONE_HOT_CHANNELS)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  The SPI Interface always uses 32 bit wide registers so you do not    %%%
%  need to overload this function for other uint cases and sizes        %%%
%  however, the memory offsets are always specified in bytes only       %%%
%  so care must be given when using non byte sized operation to the     %%%
%  address.                                                             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Check the status of the interface
status_register=Master_Object.read('uint32',sprintf('0x%08X',hex2dec(BASE_ADDRESS)+8),1);
status_register=fliplr(dec2bin(status_register,12)=='1');
%Clear Status Register
Master_Object.write('uint32',sprintf('0x%08X',hex2dec(BASE_ADDRESS)+8),hex2dec('00000000'));

%Update Selected Channels Only
if status_register(6) & status_register(7)
    Master_Object.write('uint32',sprintf('0x%08X',hex2dec(BASE_ADDRESS)+4),hex2dec(dec2hex(bin2dec(ONE_HOT_CHANNELS),8))+hex2dec('0000A000'));
else
   while ~(status_register(6) & status_register(7))
       %Check the status of the interface
        status_register=Master_Object.read('uint32',sprintf('0x%08X',hex2dec(BASE_ADDRESS)+8),1);
        status_register=fliplr(dec2bin(status_register,12)=='1');
        %Clear Status Register
        Master_Object.write('uint32',sprintf('0x%08X',hex2dec(BASE_ADDRESS)+8),hex2dec('00000000'));
   end
   Master_Object.write('uint32',sprintf('0x%08X',hex2dec(BASE_ADDRESS)+4),hex2dec(dec2hex(bin2dec(ONE_HOT_CHANNELS),8))+hex2dec('0000A000'));
end

errors={};

if status_register(4)
    errors{1}={{'ERROR: Recieve Overrun Error'}
        {'New data was received while the rxdata register was full,'}
        {'In other words you missed a word of data and it was overwritten.'}};
else
    errors{1}={{'OK: No recieve data has been missed.'}};
end

if status_register(5)
    errors{2}={{'ERROR: Transmit Overrun Error'}
        {'New Data written to txbuffer before old data could be transmit,'}
        {'The new data was ignored.'}};
else
    errors{2}={{'OK: No transmit data has been missed.'}};
end

if ~status_register(6)
    errors{3}={{'WARNING: Transmit shift register in use'}
        {'You are writing to the pre shift register buffer so there is no data loss,'}
        {'Slow down the rate at which you are updating the txbuffer.'}};
else
    errors{3}={{'OK: No transmit data has been missed.'}};
end

if status_register(8)
    errors{5}={{'WARNING: Recieve Buffer Full'}
        {'There is no data loss and the data has been pulled from the buffer,'}
        {'Data will be output.'}};
else
    errors{5}={{'OK: No recieve data has been missed.'}};
end

if ~status_register(7)
    errors{4}={{'ERROR: Transmit Buffer Full'}
        {'The txbuffer is full,'}
        {'The data you just attempted to write is being ignored.'}};
else
    %If this is not a 1 then the txbuffer is not ready for new transmit
    %data and the data that was to be written will not be written
    errors{4}={{'OK: No transmit data has been missed.'}};
end

end