%Example of MTMFH System Use
DSP_Builder_Setup(dsp_builder_path)
mobj=Find_and_Open_Master;
code=[]; value=[]; ADC_Bits=12; Vref_ADC=3.3; DAC_Bits=12; Vref_DAC=3.3;
ADC_factor=(Vref_ADC/(2^ADC_Bits)); DAC_factor=(Vref_DAC/(2^DAC_Bits));
factor=ADC_factor/DAC_factor;
step_size=32;
for i=1:step_size:4096
Write_and_Update_DAC128SXXX(mobj,'00000020',5,dec2hex(i,8));
Write_and_Update_LTC2656_X16(mobj,'00000040',5,dec2hex(i,8));
code(i)=Read_ADC128SXXX(mobj,'00000000',8);
end
value=downsample(code.*ADC_factor,step_size);
figure(1)
plot(value)