function [Master_Object]=Find_and_Open_Master()

result_1={}; result_2=0; result_3=0; n=0;
while (isempty(result_1)&~result_2)
    result_1=SystemConsole.refreshMasters;
    if isempty(result_1)
        result_2=input([['No compatible device detected!\n'] ...
        ['If this is NOT an error, please type 1 and then press enter.\n'] ...
        ['If this IS an error, please type 0 and then press enter.\n']]);
    end
end

if ~isempty(result_1)
    fprintf(1,'%s\n',['The following device(s) were/was detected:']);
    for n=1:1:length(result_1)
        fprintf(1,'Device %i: %s\n',n,result_1{n});
    end
    result_3=input([['If you would like to connect to this/(any of these) master(s), please type the device number and then press enter.\n'] ...
        ['If you do not want to connect to this/(any of these) master(s), please type 0 and then press enter.\n']]);
end

if result_3
    Master_Object=SystemConsole.openMaster(result_3);
elseif ~isempty(result_1)
    fprintf(1,'%s\n',['Ok. Well I don''t know why you are running this program then.  See you!']);
    Master_Object=[];
else
    Master_Object=[];
end

end