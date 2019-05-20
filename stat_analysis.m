fulltable=[];
% for sub=1:1:9
% subdata=sensorydata(sub).rawdata;
% subdata=horzcat(sub*ones(120,1),subdata);
% fulltable=vertcat(fulltable,subdata);
%  end
for sub=1:1:1
subdata=vertcat(horzcat(sensorydata(sub).rawdata(1).stderror(:), ones(40,1)), ...
                 horzcat(sensorydata(sub).rawdata(2).stderror(:),-1*ones(40,1)));                                             ;
subdata=horzcat(groups,subdata);
fulltable=vertcat(fulltable,subdata);
end

dir_sep=find(fulltable(:,4)~=0);
dir_com=find(fulltable(:,4)==0);

dir_sep_table=fulltable;
dir_sep_table(dir_com,:)=[];


dir_com_table=fulltable;
dir_com_table(dir_sep,:)=[];

subject=dir_sep_table(:,1);
time=dir_sep_table(:,2);
vel=dir_sep_table(:,3);
dir=abs(dir_sep_table(:,4)+1);
bias=dir_sep_table(:,5);
var_s=dir_sep_table(:,6);
deltime=dir_sep_table(:,7);
peak_vel=dir_sep_table(:,8);

 [P,T,STATS,TERMS]=anovan(var_s,{subject,time,vel,dir},'random',1,'model','interaction','varnames',{'subject','time','velocity','dir'})