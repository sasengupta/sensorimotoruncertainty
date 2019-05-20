function [ data_left,data_right ] = extract(currfilename_l,currfilename_r,nooftrials,subno)
%this function will read svl and svr uptill 440 trials in each case
%and give a table with trlno, ballspeed, direction,landingdist,error,
%landinghit, and extra measures
%ballfinsihposition(:,1),paddlefinishposition(:,1)
filename=strcat(currfilename_l,'.dat');
data_left{1}=DATAFILE_Read(filename);
trialcount_curr=data_left{1}.Trials;
i=2;
        while(trialcount_curr<nooftrials)
           currfilename_l2=strcat(currfilename_l,num2str(2),'.dat');
           data_left{i}=DATAFILE_Read(currfilename_l2);
           trialcount_curr=trialcount_curr+data_left{i}.Trials;
           i=i+1;
        end
%if (nargin==4)
filename=strcat(currfilename_r,'.dat');        
data_right{1}=DATAFILE_Read(filename);
trialcount_curr=data_right{1}.Trials;
i=2;
        while(trialcount_curr<nooftrials)
           currfilename_r2=strcat(currfilename_r,num2str(2),'.dat');
           data_right{i}=DATAFILE_Read(currfilename_r2);
           trialcount_curr=trialcount_curr+data_right{i}.Trials;
           i=i+1;
        end
%end
end

