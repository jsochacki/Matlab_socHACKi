function [obj]=Create_Oscilloscope(obj_in)

    %Define Dynamic Parameters (Will Change With Change In Instrument)
    obj_internal.Setup.Driver=obj_in.Drivers.IAgInfiniiVision5;
    
    %Define Parameters
    obj.Setup.HardwareId.USB=obj_in.HardwareId.USB;
    obj.Setup.Definitions.Global.DeviceSpecific.Enumerations=obj_in.Global.Enumerations();
    obj.Setup.Definitions.Global.Generic.Types=obj_in.Global.Types();
    obj.Setup.Definitions.Global.Generic.Casts=obj_in.Global.Casts();
    
    obj.Setup.InitializationOptions.Reset.NoReset=logical(false);
    obj.Setup.InitializationOptions.Reset.FullReset=logical(true);
    obj.Setup.InitializationOptions.Id.DontQuery=logical(false);
    obj.Setup.InitializationOptions.Id.Query=logical(true);
    obj.Setup.InitializationOptions.OpperationMode.Test='simulate=false';
    obj.Setup.InitializationOptions.OpperationMode.Simulation='simulate=true';
    obj.Setup.OpperationMode.RunInTest='simulate=false';
    
    %Define Objects With Methods and Parameters
    obj.Opperation=obj_internal.Setup.Driver.DeviceSpecific;
    
    clear obj_internal;
    
    %Define Methods
    obj.Setup.Declarations.Global=@DeclareGlobal;
    obj.Setup.Initialization.CheckStatus=@CheckInitializationStatus;
    obj.Setup.Initialization.Initialize=@InitializeLink;
    obj.Setup.AddChannels=@AddChannels;
    obj.Channels.Initialize=@SetUpCommon;
    obj.Channels.Name=@ChannelName;
    obj.FFT.SetUpFFT=@SetUpFFT
    obj.FFT.SelectChannel=@ChangeFFTChannel;
    obj.Timebase.SetUpTimebase=@SetUpTimebase;
    obj.Triggers.SetUpTriggers=@SetUpTriggers;
    obj.Acquisition.SetUpAcquisition=@SetUpAcquisition;
    obj.Display.SetUpDisplay=@SetUpDisplay;
    obj.Waveform.SetUpWaveform=@SetUpWaveform;
    obj.Waveform.SetSource=@SetWaveformSource;
    obj.Waveform.MaximizeSNR=@MaximizeSNR;
    obj.Measurement.MeasureAllActiveChannels=@MeasureAllActiveChannels;
    obj.Measurement.Read=@ReadChannel;
    obj.Measurement.MeasureAndReadAllActiveChannels=@MeasureAndReadAllActiveChannels;
    obj.DisplayLocal=@DisplayLocalOscolloscopeValues;
    obj.UpdateLocal=@UpdateLocalOscolloscopeValues;
    obj.Wait=@WaitForOpperationToCompleteOrTimeout;
    
    %Define Functions For Methods
    function DeclareGlobal(varargin)
        useage_error='Useage Error.'',''Please Call either "Enumerations", "Types", or "Casts"';
        switch nargin
            case 0
                sprintf('%s',useage_error)
            case 1
                if strcmp(varargin{1},'Enumerations')
                    for i=1:1:length(obj.Setup.Definitions.Global.DeviceSpecific.Enumerations), evalin('caller',obj.Setup.Definitions.Global.DeviceSpecific.Enumerations{i}{1});,end;
                elseif strcmp(varargin{1},'Types')
                    for i=1:1:length(obj.Setup.Definitions.Global.Generic.Types), evalin('caller',obj.Setup.Definitions.Global.Generic.Types{i}{1});,end;
                elseif strcmp(varargin{1},'Casts')
                    for i=1:1:length(obj.Setup.Definitions.Global.Generic.Casts), evalin('caller',obj.Setup.Definitions.Global.Generic.Casts{i}{1});,end;
                else
                    sprintf('%s',useage_error)
                end
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function CheckInitializationStatus(varargin)
        useage_error='Useage Error.'',''Sorry';
        switch nargin
            case 0
                if obj.Opperation.Initialized
                    sprintf('%s','Initialization Was Successful.')
                else
                    sprintf('%s','Initialization Failed.')
                end
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function obj=InitializeLink(obj,HwId,QueryId,Reset,Mode)
        useage_error='Useage Error.'',''obj=InitializeLink(obj,HwId,QueryId,Reset,Mode) eg obj=InitializeLink(obj,obj.Setup.HardwareId.USB,obj.Setup.InitializationOptions.Id.Query,obj.Setup.InitializationOptions.Reset.FullReset,obj.Setup.InitializationOptions.OpperationMode.Simulation';
        switch nargin
            case 5
                if strcmp(Mode,obj.Setup.InitializationOptions.OpperationMode.Test)
                        obj.Opperation.Initialize(HwId,QueryId,Reset,Mode);
                        obj.Setup.OpperationMode=Mode;
                elseif strcmp(Mode,obj.Setup.InitializationOptions.OpperationMode.Simulation)
                        obj.Opperation.Initialize(HwId,QueryId,Reset,Mode);
                        obj.Setup.OpperationMode=Mode;
                else
                    sprintf('%s',useage_error)                    
                end
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function obj=AddChannels(obj)
        useage_error='Useage Error.'',''Pass In Object Please and Assign On Output eg obj=AddChannels(obj)';
        switch nargin
            case 0
                sprintf('%s',useage_error)
            case 1
                if obj.Opperation.Initialized
                    if strcmp(obj.Setup.OpperationMode,obj.Setup.InitializationOptions.OpperationMode.Test)
                        obj.Channels.Channel1=obj.Opperation.Channels.Item(obj.Opperation.Channels.Name(1));
                        obj.Channels.Channel2=obj.Opperation.Channels.Item(obj.Opperation.Channels.Name(2));
                        obj.Channels.Channel3=obj.Opperation.Channels.Item(obj.Opperation.Channels.Name(3));
                        obj.Channels.Channel4=obj.Opperation.Channels.Item(obj.Opperation.Channels.Name(4));
                    elseif strcmp(obj.Setup.OpperationMode,obj.Setup.InitializationOptions.OpperationMode.Simulation)
                        obj.Channels.Channel1=obj.Opperation.Channels.Item(obj.Opperation.Channels.Name(1));
                        obj.Channels.Channel2=obj.Opperation.Channels.Item(obj.Opperation.Channels.Name(2));
                    end
                else
                    sprintf('%s','Initialization Must Be Completed First')
                end
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function SetUpCommon(obj,Channel_Number)
       useage_error='Useage Error.'',''Pass In Object Channel Pointer and Channel Number Please eg. obj.Channels.Initialize(obj,Channel_Number)';
       switch nargin
            case 2
                global DISABLED AIVC_DC VRANGE_PTP AICUV
                switch Channel_Number
                    case 1
                        obj=obj.Channels.Channel1;
                    case 2
                        obj=obj.Channels.Channel2;
                    case 3
                        obj=obj.Channels.Channel3;
                    case 4
                        obj=obj.Channels.Channel4;
                    otherwise
                        sprintf('%s',useage_error)
                end
                obj.Enabled=DISABLED;
                obj.Coupling=AIVC_DC;
                obj.InputFrequencyMax=double(5e8);
                obj.InputImpedance=double(50.0);  %NOTE: only supported when using DC couping option, else scope will force to 1e6.
                obj.Invert=logical(false);
                obj.Label=['BLANK'];
                obj.Offset=double(0.0);
                obj.ProbeAttenuation=double(1.0);
                obj.ProbeSkew=double(0.0);
                %You do either range or scale but not both
                obj.Range=VRANGE_PTP;
                %obj.Scale=double(5.0);
                obj.Units=AICUV;
                %obj.Enabled=double(1.0);

            otherwise
                sprintf('%s',useage_error)
        end
    end

    function val=ChannelName(obj,Channel_Number)
       useage_error='Useage Error.'',''Pass In Object and Channel Number And Assign External Please eg. val=obj.Channels.Initialize(obj,Channel_Number)';
       switch nargin
            case 2
            	val=obj.Opperation.Channels.Name(Channel_Number);
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function SetUpFFT(obj,Span,StartFrequency,Offset,Range,AverageCount)
       useage_error='Useage Error.'',''Pass In Object eg. obj.FFT.SetUpFFT(obj,Span,StartFrequency,Offset,Range,AverageCount)';
       switch nargin
            case 6
                global AIMFDMA AIMFVU_DB AIMFWTR ENABLED
                obj.Opperation.FFT.Span=double(Span);
                obj.Opperation.FFT.StartFrequency=double(StartFrequency);
                obj.Opperation.FFT.DisplayMode=AIMFDMA;
                obj.Opperation.FFT.VerticalUnits=AIMFVU_DB;
                obj.Opperation.FFT.WindowType=AIMFWTR;
                obj.Opperation.FFT.Offset=double(Offset);
                obj.Opperation.FFT.Range=Range;
                obj.Opperation.FFT.AverageCount=int64(AverageCount);
                obj.Opperation.FFT.Enabled=ENABLED;
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function ChangeFFTChannel(obj,Channel_Number)
       useage_error='Useage Error.'',''eg. obj.FFT.SelectChannel(obj,Channel_Number)';
       switch nargin
            case 2
                global AIMFDMN AIMFDMA
                obj.Opperation.FFT.DisplayMode=AIMFDMN;
            	obj.Opperation.FFT.Source=obj.Channels.Name(obj,Channel_Number);
                obj.Opperation.FFT.DisplayMode=AIMFDMA;
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function SetUpTimebase(obj,HorizontalScale)
       useage_error='Useage Error.'',''eg. obj.Timebase.SetUpTimebase(obj,HorizontalScale)';
       switch nargin
            case 2
                global AITBMM AITBRC L_FALSE
                obj.Opperation.Timebase.Mode=AITBMM;
                obj.Opperation.Timebase.HorizontalScale=double(HorizontalScale); %1e-9 is limit. It is in Seconds (can use #e#)
                obj.Opperation.Timebase.TimeReference=AITBRC;
                obj.Opperation.Timebase.VernierEnabled=L_FALSE;
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function SetUpTriggers(obj,ChannelNumber,Level,Holdoff)
       useage_error='Useage Error.'',''eg. obj.Triggers.SetUpTriggers(obj,ChannelNumber,Level,Holdoff)';
       switch nargin
            case 4
                global AITTE AITC_DC AITMN L_TRUE L_FALSE
                obj.Opperation.Trigger.Type=AITTE;
                obj.Opperation.Trigger.Source=ChannelName(obj,ChannelNumber);
                obj.Opperation.Trigger.Coupling=AITC_DC;
                obj.Opperation.Trigger.Continuous=L_TRUE;
                obj.Opperation.Trigger.Level=double(Level); %In Volts.  Initial setting.  Will be swept for peak xcor later
                obj.Opperation.Trigger.Modifier=AITMN;
                obj.Opperation.Trigger.Holdoff=double(Holdoff); %4e-8 is the limit but it would be best if BATCH_SAMPLE_TIME/2 were used/achieveable
                obj.Opperation.Trigger.HFRejectFilterEnabled=L_FALSE; %Will not function at high rate if true
                obj.Opperation.Trigger.NoiseRejectFilterEnabled=L_FALSE;  %Will not function at high rate if true
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function SetUpAcquisition(obj,NumberOfAverages,NumberOfSamplesPerTrigger,BatchSampleTime)
       useage_error='Useage Error.'',''eg. obj.Acquisition.SetUpAcquisition(obj,NumberOfAverages,NumberOfSamplesPerTrigger,BatchSampleTime)';
       switch nargin
            case 4
                global AIAT_N
                obj.Opperation.Acquisition.Interpolation='AgInfiniiVisionInterpolationSineX'; %No other options
                obj.Opperation.Acquisition.NumberOfAverages=int64(NumberOfAverages);
                obj.Opperation.Acquisition.Type=AIAT_N;
                obj.Opperation.Acquisition.NumberOfPointsMin=int64(NumberOfSamplesPerTrigger);
                obj.Opperation.Acquisition.StartTime=double(0.0);
                obj.Opperation.Acquisition.TimePerRecord=double(BatchSampleTime);
                %obj.Opperation.Acquisition.RecordLength;
                %Switched from continuous to single, not useful for me
                %obj.Opperation.Acquisition.SingleAcquisition;
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function SetUpDisplay(obj)
       useage_error='Useage Error.'',''eg. obj.Acquisition.SetUpDisplay(obj)';
       switch nargin
            case 1
                global L_TRUE AIDPM_M
                obj.Opperation.Display.LabelEnabled=L_TRUE;
                obj.Opperation.Display.Persistence=AIDPM_M;
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function obj_out=SetUpWaveform(obj)
       useage_error='Useage Error.'',''eg. obj_out=obj.Acquisition.SetUpWaveform(obj)';
       switch nargin
            case 1
                global AIWBO_LSB AIWDF_ASCII AIWPM_RAW L_FALSE
                obj.Opperation.Waveform.ByteOrder=AIWBO_LSB;
                obj.Opperation.Waveform.DataFormat=AIWDF_ASCII;
                obj.Opperation.Waveform.PointMode=AIWPM_RAW;
                obj.Opperation.Waveform.UnsignedModeEnable=L_FALSE;
               % obj.Opperation.Waveform.PointCount=obj.Opperation.Acquisition.RecordLength;
                obj_out.OSCOPE_SAMPLE_TIME_RESOLUTION=obj.Opperation.Waveform.XIncrement;
                obj_out.OSCOPE_VOLTAGE_RESOLUTION=obj.Opperation.Waveform.YIncrement;
                obj_out.OSCOPE_SAMPLE_TIME_REFERENCE=obj.Opperation.Waveform.XReference;
                obj_out.OSCOPE_VOLTAGE_REFERENCE=obj.Opperation.Waveform.YReference;
                obj_out.OSCOPE_SAMPLE_TIME_ORIGIN=obj.Opperation.Waveform.XOrigin;
                obj_out.OSCOPE_VOLTAGE_ORIGIN=obj.Opperation.Waveform.YOrigin;
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function SetWaveformSource(obj,ChannelNumber)
       useage_error='Useage Error.'',''eg. obj.Waveform.SetSource(obj,ChannelNumber)';
       switch nargin
            case 2
                obj.Opperation.Waveform.Source=obj.Opperation.Channels.Name(ChannelNumber);
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function Local=MaximizeSNR(obj1,obj2,Local)
       useage_error='Useage Error.'',''eg. Local=obj.Waveform.MaximizeSNR(obj,obj2,Local)';
       MIN_RANGE_INCREMENT=Local.Oscilloscope.Parameters.Set.MIN_RANGE_INCREMENT;
       MIN_OFFSET_INCREMENT=Local.Oscilloscope.Parameters.Set.MIN_OFFSET_INCREMENT;
       Local=obj2.UpdateLocal(obj2,Local);
       switch nargin
            case 3
                if strcmp(obj1.Setup.OpperationMode,obj1.Setup.InitializationOptions.OpperationMode.Test)
                    obj1.Channels.Channel1.Range=Local.AWG.Parameters.Read.CHANNEL_1_PEAK_TO_PEAK_VOLTAGE_MAX+MIN_RANGE_INCREMENT;
                    obj1.Channels.Channel2.Range=Local.AWG.Parameters.Read.CHANNEL_2_PEAK_TO_PEAK_VOLTAGE_MAX+MIN_RANGE_INCREMENT;
                    obj1.Channels.Channel3.Range=Local.AWG.Parameters.Read.CHANNEL_1_PEAK_TO_PEAK_VOLTAGE_MAX+Local.AWG.Parameters.Read.CHANNEL_2_PEAK_TO_PEAK_VOLTAGE_MAX+(2*MIN_RANGE_INCREMENT);
                    obj1.Channels.Channel4.Range=double(0.2);
                    obj1.Channels.Channel1.Offset=Local.AWG.Parameters.Read.CHANNEL_1_DC_OFFSET;
                    obj1.Channels.Channel2.Offset=Local.AWG.Parameters.Read.CHANNEL_2_DC_OFFSET;
                    obj1.Channels.Channel3.Offset=Local.AWG.Parameters.Read.CHANNEL_1_DC_OFFSET+Local.AWG.Parameters.Read.CHANNEL_2_DC_OFFSET;
                    obj1.Channels.Channel4.Offset=(obj1.Channels.Channel4.Range)/2;
                elseif strcmp(obj1.Setup.OpperationMode,obj1.Setup.InitializationOptions.OpperationMode.Simulation)
                    obj1.Channels.Channel1.Range=Local.AWG.Parameters.Read.CHANNEL_1_PEAK_TO_PEAK_VOLTAGE_MAX+MIN_RANGE_INCREMENT;
                    obj1.Channels.Channel2.Range=Local.AWG.Parameters.Read.CHANNEL_2_PEAK_TO_PEAK_VOLTAGE_MAX+MIN_RANGE_INCREMENT;
                    obj1.Channels.Channel1.Offset=Local.AWG.Parameters.Read.CHANNEL_1_DC_OFFSET;
                    obj1.Channels.Channel2.Offset=Local.AWG.Parameters.Read.CHANNEL_2_DC_OFFSET;
                end
            otherwise
                sprintf('%s',useage_error)
        end
    end

%{
    function Local=MaximizeSNR(obj,Local)
       useage_error='Useage Error.'',''eg. Local=obj.Waveform.MaximizeSNR(obj,Local)';
       switch nargin
            case 2
                OFFSET_PER_RANGE=Local.Oscilloscope.Parameters.Set.OFFSET_PER_RANGE;
                MIN_RANGE=Local.Oscilloscope.Parameters.Set.MIN_RANGE;
                MIN_RANGE_INCREMENT=Local.Oscilloscope.Parameters.Set.MIN_RANGE_INCREMENT;
                MIN_OFFSET_INCREMENT=Local.Oscilloscope.Parameters.Set.MIN_OFFSET_INCREMENT;
                %SCALE
                for i=1:1:(obj.Opperation.Channels.Count)
                    Done=0; FP=0; MTMIH=[];
                    obj.Channels.(obj.Channels.Name(obj,i)).Range=3*MIN_RANGE;
                    obj.Channels.(obj.Channels.Name(obj,i)).Offset=0;
                    Local=obj.Measurement.MeasureAndReadAllActiveChannels(obj,Local);
                    if i==1 
                        MTMI=max(Local.Output.Measurements.Channel.c1.Waveform)-min(Local.Output.Measurements.Channel.c1.Waveform);
                    elseif i==2
                        MTMI=max(Local.Output.Measurements.Channel.c2.Waveform)-min(Local.Output.Measurements.Channel.c2.Waveform);
                    elseif i==3
                        MTMI=max(Local.Output.Measurements.Channel.c3.Waveform)-min(Local.Output.Measurements.Channel.c3.Waveform);
                    elseif i==4
                        MTMI=max(Local.Output.Measurements.Channel.c4.Waveform)-min(Local.Output.Measurements.Channel.c4.Waveform);        
                    end
                    obj.Channels.(obj.Channels.Name(obj,i)).Range=obj.Channels.(obj.Channels.Name(obj,i)).Range+MIN_RANGE;
                    while ~(Done)
                        TRV1=[]; TRV2=[]; TRV3=[];
                        %obj.Channels.(obj.Channels.Name(obj,i)).Offset=obj.Channels.(obj.Channels.Name(obj,i)).Offset+obj.Opperation.Waveform.YIncrement;
                        Local=obj.Measurement.MeasureAndReadAllActiveChannels(obj,Local);
                        if i==1
                            MTMC=max(Local.Output.Measurements.Channel.c1.Waveform)-min(Local.Output.Measurements.Channel.c1.Waveform);
                        elseif i==2
                            MTMC=max(Local.Output.Measurements.Channel.c2.Waveform)-min(Local.Output.Measurements.Channel.c2.Waveform);
                        elseif i==3
                            MTMC=max(Local.Output.Measurements.Channel.c3.Waveform)-min(Local.Output.Measurements.Channel.c3.Waveform);
                        elseif i==4
                            MTMC=max(Local.Output.Measurements.Channel.c4.Waveform)-min(Local.Output.Measurements.Channel.c4.Waveform);
                        end
                        if FP==0
                            FP=1;
                            MTMIH=MTMI;
                        end
                        if (MTMC < (MTMI*1.03)) && (MTMC > MTMIH)
                            Done=1;
                        else
                            obj.Channels.(obj.Channels.Name(obj,i)).Range=obj.Channels.(obj.Channels.Name(obj,i)).Range*1.2;
                        end
                        MTMI=MTMC;        
                        end
                    %obj.Channels.(obj.Channels.Name(obj,i)).Offset
                end
                %OFFSET
                Local=obj.Measurement.MeasureAndReadAllActiveChannels(obj,Local);
                for i=1:1:(obj.Opperation.Channels.Count)
                    if i==1 
                        MPI=max(Local.Output.Measurements.Channel.c1.Waveform)-(max(Local.Output.Measurements.Channel.c1.Waveform)-min(Local.Output.Measurements.Channel.c1.Waveform))/2;
                    elseif i==2
                        MPI=max(Local.Output.Measurements.Channel.c2.Waveform)-(max(Local.Output.Measurements.Channel.c2.Waveform)-min(Local.Output.Measurements.Channel.c2.Waveform))/2;
                    elseif i==3
                        MPI=max(Local.Output.Measurements.Channel.c3.Waveform)-(max(Local.Output.Measurements.Channel.c3.Waveform)-min(Local.Output.Measurements.Channel.c3.Waveform))/2;
                    elseif i==4
                        MPI=max(Local.Output.Measurements.Channel.c4.Waveform)-(max(Local.Output.Measurements.Channel.c4.Waveform)-min(Local.Output.Measurements.Channel.c4.Waveform))/2;
                    end
                    obj.Channels.(obj.Channels.Name(obj,i)).Offset=MPI;
                end
                %SCALE
                for i=1:1:(obj.Opperation.Channels.Count)
                    Done=0; FP=0; MTMIH=[];
                    Local=obj.Measurement.MeasureAndReadAllActiveChannels(obj,Local);
                    if i==1 
                        MTMI=max(Local.Output.Measurements.Channel.c1.Waveform)-min(Local.Output.Measurements.Channel.c1.Waveform);
                    elseif i==2
                        MTMI=max(Local.Output.Measurements.Channel.c2.Waveform)-min(Local.Output.Measurements.Channel.c2.Waveform);
                    elseif i==3
                        MTMI=max(Local.Output.Measurements.Channel.c3.Waveform)-min(Local.Output.Measurements.Channel.c3.Waveform);
                    elseif i==4
                        MTMI=max(Local.Output.Measurements.Channel.c4.Waveform)-min(Local.Output.Measurements.Channel.c4.Waveform);        
                    end
                    obj.Channels.(obj.Channels.Name(obj,i)).Range=obj.Channels.(obj.Channels.Name(obj,i)).Range-MIN_RANGE;
                    while ~(Done)
                        TRV1=[]; TRV2=[]; TRV3=[];
                        %obj.Channels.(obj.Channels.Name(obj,i)).Offset=obj.Channels.(obj.Channels.Name(obj,i)).Offset+obj.Opperation.Waveform.YIncrement;
                        Local=obj.Measurement.MeasureAndReadAllActiveChannels(obj,Local);
                        if i==1
                            MTMC=max(Local.Output.Measurements.Channel.c1.Waveform)-min(Local.Output.Measurements.Channel.c1.Waveform);
                        elseif i==2
                            MTMC=max(Local.Output.Measurements.Channel.c2.Waveform)-min(Local.Output.Measurements.Channel.c2.Waveform);
                        elseif i==3
                            MTMC=max(Local.Output.Measurements.Channel.c3.Waveform)-min(Local.Output.Measurements.Channel.c3.Waveform);
                        elseif i==4
                            MTMC=max(Local.Output.Measurements.Channel.c4.Waveform)-min(Local.Output.Measurements.Channel.c4.Waveform);
                        end
                        if FP==0
                            FP=1;
                            MTMIH=MTMI;
                        end
                        if (MTMC < (MTMIH*0.98))
                            Done=1;
                            obj.Channels.(obj.Channels.Name(obj,i)).Range=obj.Channels.(obj.Channels.Name(obj,i)).Range+MIN_RANGE;
                        else
                            obj.Channels.(obj.Channels.Name(obj,i)).Range=obj.Channels.(obj.Channels.Name(obj,i)).Range-MIN_RANGE;
                        end
                       % MTMI=MTMC;
                        end
                    %obj.Channels.(obj.Channels.Name(obj,i)).Offset
                end
                %OFFSET
                Local=obj.Measurement.MeasureAndReadAllActiveChannels(obj,Local);
                for i=1:1:(obj.Opperation.Channels.Count)
                    if i==1 
                        MPI=max(Local.Output.Measurements.Channel.c1.Waveform)-(max(Local.Output.Measurements.Channel.c1.Waveform)-min(Local.Output.Measurements.Channel.c1.Waveform))/2;
                    elseif i==2
                        MPI=max(Local.Output.Measurements.Channel.c2.Waveform)-(max(Local.Output.Measurements.Channel.c2.Waveform)-min(Local.Output.Measurements.Channel.c2.Waveform))/2;
                    elseif i==3
                        MPI=max(Local.Output.Measurements.Channel.c3.Waveform)-(max(Local.Output.Measurements.Channel.c3.Waveform)-min(Local.Output.Measurements.Channel.c3.Waveform))/2;
                    elseif i==4
                        MPI=max(Local.Output.Measurements.Channel.c4.Waveform)-(max(Local.Output.Measurements.Channel.c4.Waveform)-min(Local.Output.Measurements.Channel.c4.Waveform))/2;
                    end
                    obj.Channels.(obj.Channels.Name(obj,i)).Offset=MPI;
                end
            otherwise
                sprintf('%s',useage_error)
        end
    end
%}

    function MeasureAllActiveChannels(obj)
       useage_error='Useage Error.'',''eg. obj.Measurement.MeasureAllActiveChannels(obj)';
       switch nargin
            case 1
                obj.Opperation.Measurements.Initiate;
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function [waveform,delay_trigger_to_first_point,time_step]=ReadChannel(obj,ChannelNumber)
       useage_error='Useage Error.'',''eg. [waveform,delay_trigger_to_first_point,time_step]=obj.Measurement.ReadChannel(obj,ChannelNumber)';
       switch nargin
            case 2
                [waveform delay_trigger_to_first_point time_step]=obj.Opperation.Measurements.Item(obj.Opperation.Channels.Name(ChannelNumber)).FetchWaveform;
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function Local=MeasureAndReadAllActiveChannels(obj,Local)
       useage_error='Useage Error.'',''eg. Local=obj.Measurement.MeasureAndReadAllActiveChannels(obj,Local)';
       switch nargin
            case 2
                obj.Opperation.Measurements.Initiate;
                for i=1:1:(obj.Opperation.Channels.Count)
                    TRV1=[]; TRV2=[]; TRV3=[];
                    [TRV1 TRV2 TRV3]=obj.Measurement.Read(obj,i);
                    if i==1
                        Local.Output.Measurements.Channel.c1.Waveform=TRV1;
                        Local.Output.Measurements.Channel.c1.delay_to_first_trigger_point=TRV2;
                        Local.Output.Measurements.Channel.c1.time_step=TRV3;
                    elseif i==2
                        Local.Output.Measurements.Channel.c2.Waveform=TRV1;
                        Local.Output.Measurements.Channel.c2.delay_to_first_trigger_point=TRV2;
                        Local.Output.Measurements.Channel.c2.time_step=TRV3;                        
                    elseif i==3
                        Local.Output.Measurements.Channel.c3.Waveform=TRV1;
                        Local.Output.Measurements.Channel.c3.delay_to_first_trigger_point=TRV2;
                        Local.Output.Measurements.Channel.c3.time_step=TRV3;                        
                    elseif i==4
                        Local.Output.Measurements.Channel.c4.Waveform=TRV1;
                        Local.Output.Measurements.Channel.c4.delay_to_first_trigger_point=TRV2;
                        Local.Output.Measurements.Channel.c4.time_step=TRV3;                        
                    else
                        sprintf('%s',useage_error)
                    end
                end
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function DisplayLocalOscolloscopeValues(Local)
       useage_error='Useage Error.'',''obj.DisplayLocal(Local)';
       switch nargin
            case 1
                name_list=fieldnames(Local.Oscolloscope.Parameters.Set);
%                 updateible_names_list={'SAMPLE_RATE'...
%                     ;'CHANNEL_1_PEAK_TO_PEAK_VOLTAGE';'CHANNEL_2_PEAK_TO_PEAK_VOLTAGE'...
%                     ;'CHANNEL_1_DC_OFFSET';'CHANNEL_2_DC_OFFSET'...
%                     ;'CHANNEL_1_PHASE_OFFSET';'CHANNEL_2_PHASE_OFFSET'...
%                     ;'CHANNEL_1_PHASE_OFFSET_MAX';'CHANNEL_2_PHASE_OFFSET_MAX'...
%                     ;'CHANNEL_1_PHASE_OFFSET_MIN';'CHANNEL_2_PHASE_OFFSET_MIN'};
                fprintf(1,'Set Values \n');
                for i=1:1:length(name_list)
%                    if sum(strcmp(updateible_names_list(:),name_list(i)))
                        [temp_name]=sprintf('%s%s','Local.Oscolloscope.Parameters.Set.',name_list{i});
                        %sprintf('%s\n','Local.Oscolloscope.Parameters.Set.',name_list{i})
                        [temp_val]=eval(sprintf('%s%s','Local.Oscolloscope.Parameters.Set.',name_list{i}));
                        fprintf(1,'%s = %5.5e \n',temp_name,temp_val);
%                    end
                end
                fprintf(1,'Read Values \n');
                name_list=fieldnames(Local.Oscolloscope.Parameters.Read);
                for i=1:1:length(name_list)
%                    if sum(strcmp(updateible_names_list(:),name_list(i)))
                        [temp_name]=sprintf('%s%s','Local.Oscolloscope.Parameters.Read.',name_list{i});
                        %sprintf('%s\n','Local.Oscolloscope.Parameters.Set.',name_list{i})
                        [temp_val]=eval(sprintf('%s%s','Local.Oscolloscope.Parameters.Read.',name_list{i}));
                        fprintf(1,'%s = %5.5e \n',temp_name,temp_val);
%                    end
                end
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function Local=UpdateLocalOscolloscopeValues(obj,Local)
       useage_error='Useage Error.'',''Pass In Object Pointer and Local Please eg. Local=obj.UpdateLocalAWGValues(obj,Local)';
       switch nargin
            case 2
                %Incorporate sample rate so you can monitor and set
%                Local.Oscolloscope.Parameters.Set.SAMPLE_RATE=
                Local.Oscolloscope.Parameters.Read.SCOPE_SAMPLE_RATE=obj.Opperation.Acquisition.SampleRate;
                Local.Oscolloscope.Parameters.Read.NUMBER_OF_SAMPLES_PER_TRIGGER=obj.Opperation.Acquisition.RecordLength;
                Local.Oscolloscope.Parameters.Read.BATCH_SAMPLE_TIME=obj.Opperation.Acquisition.TimePerRecord;
                Local.Oscolloscope.Parameters.Read.OFFSET_PER_RANGE=[];
            otherwise
                sprintf('%s',useage_error)
        end
    end

    function WaitForOpperationToCompleteOrTimeout(baseobj,Local)
       useage_error='Useage Error.'',''eg. WaitForOpperationToCompleteOrTimeout(obj,Local)';
       switch nargin
            case 2
                baseobj.Opperation.System.WaitForOperationComplete(Local.Oscilloscope.Parameters.Set.TIMEOUT);
            otherwise
                sprintf('%s',useage_error)
        end
    end

end