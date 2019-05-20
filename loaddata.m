function data =loaddata(datatype,subno,folder,sublist,type)

switch datatype
    case 1       %sensoryvariability
%create filename
   fileid1=3;fileid2=4;nooftrials=440;       %comes from runal_init that initialises folders and file names
   currfilename_l=strcat(folder{subno},sublist{subno},type{fileid1},'.dat');
   currfilename_r=strcat(folder{subno},sublist{subno},type{fileid2},'.dat');
%read data
data_left=DATAFILE_Read(currfilename_l);
if(data_left.Trials<440)
   currfilename_l2=strcat(folder{subno},sublist{subno},type{fileid1},num2str(2),'.dat');
   data_left2=DATAFILE_Read(currfilename_l2);
   IndicatedPosition_left=abs(vertcat(data_left.PaddleFinishPosition(:,1),data_left2.PaddleFinishPosition(:,1))-20);
   SensingTime_left=vertcat(data_left.SensingTime,data_left2.SensingTime);
   Sensingvelamp_left=abs(vertcat(data_left.BallSpeed(:,1),data_left2.BallSpeed(:,1)));
   CorrectPosition_left=vertcat(data_left.LandingDistance,data_left2.LandingDistance);
   LandingHit_left=vertcat(data_left.LandingHit,data_left2.LandingHit);
else
   IndicatedPosition_left=abs(data_left.PaddleFinishPosition(:,1)-20); 
   SensingTime_left= data_left.SensingTime;
   Sensingvelamp_left= abs(data_left.BallSpeed(:,1));
   CorrectPosition_left=  data_left.LandingDistance;
   LandingHit_left=data_left.LandingHit;
end
%mean_corrected
clear trial timecount ampcount count1 count2 casetrials meanIP;
trial=length(IndicatedPosition_left);
Error_left(1:length(IndicatedPosition_left))=NaN;
timecount=(unique(SensingTime_left));
ampcount=(unique(CorrectPosition_left));
for count1=1:1:length(timecount)
   for count2 =1:1:length(ampcount)
   casetrials=find((SensingTime_left==timecount(count1))& (CorrectPosition_left==ampcount(count2)));
    meanIP=mean(IndicatedPosition_left(casetrials));
    meanError_left(count1,count2)=meanIP;
    Error_left(casetrials)=IndicatedPosition_left(casetrials)-meanIP;
   end
end
data_right=DATAFILE_Read(currfilename_r);
if(data_right.Trials<440)
   currfilename_r2=strcat(folder{subno},sublist{subno},type{fileid2},num2str(2),'.dat');
   data_right2=DATAFILE_Read(currfilename_r2);
   IndicatedPosition_right=abs(vertcat(data_right.PaddleFinishPosition(:,1),data_right2.PaddleFinishPosition(:,1))-20);
   SensingTime_right=vertcat(data_right.SensingTime,data_right2.SensingTime);
   Sensingvelamp_right=abs(vertcat(data_right.BallSpeed(:,1),data_right2.BallSpeed(:,1)));
   CorrectPosition_right=vertcat(data_right.LandingDistance,data_right2.LandingDistance);
   LandingHit_right=vertcat(data_right.LandingHit,data_right2.LandingHit);
else
   IndicatedPosition_right=abs(data_right.PaddleFinishPosition(:,1)-20); 
   SensingTime_right= data_right.SensingTime;
   Sensingvelamp_right= abs(data_right.BallSpeed(:,1));
   CorrectPosition_right= data_right.LandingDistance;
   LandingHit_right=data_right.LandingHit;
end
clear trial timecount ampcount count1 count2 casetrials meanIP;
trial=length(IndicatedPosition_right);
Error_right(1:length(IndicatedPosition_right))=NaN;
timecount=(unique(SensingTime_right));
ampcount=(unique(CorrectPosition_right));
for count1=1:1:length(timecount)
   for count2 =1:1:length(ampcount)
   casetrials=find((SensingTime_right==timecount(count1))& (CorrectPosition_right==ampcount(count2)));
    meanIP=mean(IndicatedPosition_right(casetrials));
    meanError_right(count1,count2)=meanIP;
    Error_right(casetrials)=IndicatedPosition_right(casetrials)-meanIP;
   end
end
%uncomment for pooling the left and right data
data.IndicatedPosition=vertcat(IndicatedPosition_right,IndicatedPosition_left);
data.SensingTime= vertcat(SensingTime_right,SensingTime_left);
data.Sensingvelamp= vertcat(Sensingvelamp_right,Sensingvelamp_left);
data.CorrectPosition=vertcat(CorrectPosition_right,CorrectPosition_left);
data.Error=vertcat(Error_right',Error_left');
data.Score=sum(LandingHit_right)+sum(LandingHit_left);
data.meanError_right=meanError_right;
data.meanError_left=meanError_left;
% % %comment out for pooling the data, runs left and right separately for the
% % %reduced model fit
% % data.IndicatedPosition=IndicatedPosition_left;%,IndicatedPosition_left);
% % data.SensingTime= SensingTime_left;%,SensingTime_left);
% % data.Sensingvelamp= Sensingvelamp_left;%,Sensingvelamp_left);
% % data.CorrectPosition=CorrectPosition_left;%,CorrectPosition_left);
% % data.Error=Error_left';%,Error_left');
% % data.Score=sum(LandingHit_left);%+sum(LandingHit_left)
% % data.meanError_right=meanError_right;
% % data.meanError_left=meanError_left;

%%figure;plot(data.Sensingvelamp,data.IndicatedPosition,'.');%plot(data.SensingTime,data.Error,'.');
%%shg;
%pause;
%close all
    case 2
%read data
% is(nooftrials=required)
%yes
%extract requiredvariables
%no
%find otherfile
%vertcat required no of trials
    case 3    

%read data
% is(nooftrials=required)
%yes
%extract requiredvariables
%no
%find otherfile
%vertcat required no of trials
end