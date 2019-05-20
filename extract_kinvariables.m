function [ kinematic_var ] = extract_kinvariables( data_left,data_right )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    mod_vel_cut=2.5;
    trial=1;
    startposition=20;
    peak_vel_left=[];peak_vel_right=[];v_end_left=[];v_end_right=[];
    deliberationtime_left=[];deliberationtime_right=[];mt_realleft=[];mt_realright=[];
    for i=1:1:length(data_left)
      for count=1:1:data_left{i}.Trials
          starttime=find(data_left{i}.FrameData.State(count,:)==5,1)-1         
          mo_onset=find(data_left{i}.FrameData.State(count,:)==6,1)
        if(isempty(mo_onset))
            mo_onset=starttime
        end
        mo_end=find(data_left{i}.FrameData.State(count,:)==7,1)-1;
        if(isempty(mo_end))
            mo_end=mo_onset;%find(data_left{i}.FrameData.State(count,:)==6,1,'last')
        end
         mo_onset_mod=find((abs(data_left{i}.FrameData.RobotVelocity(count,starttime:mo_end,1))>=mod_vel_cut),1)
%         mo_end_bijvel=find((-1*(data_left{i}.FrameData.RobotVelocity(count,mo_end:end,1))>=mod_vel_cut),1)
%         if(isempty(mo_end_bijvel))
%             mo_end_bijvel=1
%         end
        mo_end_mod=find((abs(data_left{i}.FrameData.RobotVelocity(count,starttime:mo_end,1))>=mod_vel_cut),1,'last')
% %         st_left(trial,1)=mo_onset-starttime;%(mo_onset_mod)%-starttime)   
%         st_test_left(trial,1)=(find(data_left{i}.FrameData.State(count,:)==6,1)-starttime);
%         velatst_left(trial,1)= -1*(data_left{i}.FrameData.RobotVelocity(count,mo_onset,1))
        
        %starttime+mo_onset_mod,1))
        %pause;
         velatend_left(trial,1)=-1*(data_left{i}.FrameData.RobotVelocity(count,mo_end,1));
%          timetoend_left(trial,1)=mo_end-starttime;%_mod;-starttime;
        [vmax vind]=max(abs(data_left{i}.FrameData.RobotVelocity(count,mo_onset:mo_end,1)))
        
            if(~isempty(vmax))
                peak_vel_left(trial,1)=vmax;
%                 timetopeak_left(trial,1)=mo_onset+ vind-starttime;
%                 correctposition_left(trial,1)= abs(data_left{i}.BallFinishPosition(count,1)-startposition);
%                 indicatedposition_left(trial,1)=abs(data_left{i}.FrameData.RobotVelocity(count,mo_end,1)-startposition)/correctposition_left(trial,1);
%                 positionatvmax_left(trial,1)=  abs(data_left{i}.FrameData.RobotPosition(count,mo_onset+vind,1)-startposition)/correctposition_left(trial,1);
%                 positionatst_left(trial,1)=abs(data_left{i}.FrameData.RobotPosition(count,mo_onset,1)-startposition)/correctposition_left(trial,1);
%                 %positionatendofmovemnet_left(trial,1)=abs(data_left{i}.FrameData.RobotPosition(count,mo_end+mo_end_bijvel,1)-startposition)/correctposition_left(trial,1)
%                 velatmoend_left(trial,1)=-1*data_left{i}.FrameData.RobotVelocity(count,mo_end+mo_end_bijvel,1)
%                 mt_realleft(trial,1)=mo_end-mo_onset+mo_end_bijvel;
            else
                figure;plot((data_left{i}.FrameData.RobotVelocity(count,:,1)),'.k');
                hold on;plot((data_left{i}.FrameData.State(count,:)),'.r');
                peak_vel_left(trial,1)=NaN;
            end
            if(~isempty(mo_end))
                v_end_left(trial,1)=data_left{i}.FrameData.RobotVelocity(count,mo_end,1);
            else
                v_end_left(trial,1)=NaN;
            end
            
            if(~isempty(mo_onset_mod))
            deliberationtime_left(trial,1)=mo_onset_mod;
            else
            deliberationtime_left(trial,1)=-100
            end
        
        trial=trial+1;
      end
    end
if (nargin==2)
     trial=1;
    for i=1:1:length(data_right)
      for count=1:1:data_right{i}.Trials
          starttime=find(data_right{i}.FrameData.State(count,:)==5,1)-1;
        mo_onset=find(data_right{i}.FrameData.State(count,:)==6,1);
% %         if(isempty(mo_onset))
% %             mo_onset=1
% %         end
        mo_end=find(data_right{i}.FrameData.State(count,:)==7,1)-1;
% %         if(isempty(mo_end))
% %             mo_end=find(data_right{i}.FrameData.State(count,:)==6,1,'last')
% %         end
% %         mo_end_bijvel=find((-1*(data_right{i}.FrameData.RobotVelocity(count,mo_end:end,1))>=mod_vel_cut),1)
% %         if(isempty(mo_end_bijvel))
% %             mo_end_bijvel=find(data_right{i}.FrameData.State(count,:)==6,1,'last')
% %         end
        mo_onset_mod=find((abs(data_right{i}.FrameData.RobotVelocity(count,starttime:mo_end,1))>=mod_vel_cut),1);
        mo_end_mod=find((abs(data_right{i}.FrameData.RobotVelocity(count,starttime:mo_end,1))>=mod_vel_cut),1,'last');
% %         st_right(trial)=(mo_onset-starttime)%_mod)%- starttime)
% %         st_test_right(trial)=(find(data_right{i}.FrameData.State(count,:)==6,1)- starttime)
% %           velatst_right(trial)= -1*(data_right{i}.FrameData.RobotVelocity(count,starttime+mo_onset,1));
% %           
% %           velatend_right(trial)= -1*(data_right{i}.FrameData.RobotVelocity(count,starttime+mo_end,1));
% %           timetoend_right(trial,1)=mo_end-starttime;
        [vmax vind]=max(abs(data_right{i}.FrameData.RobotVelocity(count,mo_onset:mo_end,1)));
        
        %add if(checkon,pauseon,plot)
            if(~isempty(vmax))
                peak_vel_right(trial,1)=vmax;
%                 timetopeak_right(trial,1)=mo_onset+vind-starttime;
%                 correctposition_right(trial,1)= abs(data_right{i}.BallFinishPosition(count,1)-startposition);
%                 indicatedposition_right(trial,1)=abs(data_right{i}.FrameData.RobotVelocity(count,mo_end,1)-startposition)/correctposition_right(trial,1);
%                 positionatvmax_right(trial,1)=  abs(data_right{i}.FrameData.RobotPosition(count,mo_onset+vind,1)-startposition)/correctposition_right(trial,1);
%                 positionatst_right(trial,1)=abs(data_right{i}.FrameData.RobotPosition(count,mo_onset,1)-startposition)/correctposition_right(trial,1);
%                 %positionatendofmovemnet_right(trial,1)=abs(data_right{i}.FrameData.RobotPosition(count,mo_end+mo_end_bijvel,1)-startposition)/correctposition_left(trial,1)
%                 velatmoend_right(trial,1)=-1*data_right{i}.FrameData.RobotVelocity(count,mo_end+mo_end_bijvel,1)
%                 mt_realright(trial,1)=mo_end-mo_onset+mo_end_bijvel;
            else
                figure;plot((data_right{i}.FrameData.RobotVelocity(count,:,1)),'.k');
                hold on;plot((data_right{i}.FrameData.State(count,:)),'.r');
                peak_vel_right(trial,1)=NaN;
            end
           if(~isempty(mo_end))
                v_end_right(trial,1)=data_right{i}.FrameData.RobotVelocity(count,mo_end,1);
            else
              v_end_right(trial,1)=NaN;
            end
        
        if(~isempty(mo_onset_mod))
        deliberationtime_right(trial,1)=mo_onset_mod;
        else
        deliberationtime_right(trial,1)=-100
        end
        trial=trial+1;    
      end
    end
end
%generate plots here
figure;
% hold on; subplot(2,1,1)
% %plot on time
% title('temporal evolution of velocity');xlabel('time (ms)');ylabel('velocity (cm/s)');hold on
% plot(st_left,velatst_left,'x k');hold on;plot(timetopeak_left,peak_vel_left,'x b');hold on;
% plot(timetoend_left,velatend_left,'x r');hold on;%plot(movementend_left,velactend_left,'x k');
% %pause;
% plot(st_right,velatst_right,'o y');hold on;plot(timetopeak_right,peak_vel_right,'o c');hold on;
% plot(timetoend_right,velatend_right,'o m');hold on;%plot(movementend_right,velactend_right,'o k');
% subplot(2,1,2)
% title('Velocity profile with amplitude');xlabel('Amplitude (scaled to correct amplitude)');ylabel('velocity (cm/s)');hold on
% plot(positionatst_left,velatst_left,'x k');hold on;plot(positionatvmax_left,peak_vel_left,'x b');hold on;
% plot(indicatedposition_left,velatend_left,'x r');hold on;%plot(positionatendofmovemnet_left,velatmoend_left,'x k');
% 
% %pause;
% plot(positionatst_right,velatst_right,'o k');hold on;plot(positionatvmax_right,peak_vel_right,'o b');hold on;
% plot(indicatedposition_right,velatend_right,'o r');hold on;%plot(positionatendofmovemnet_right,velatmoend_right,'o k');
% %figure;
%plot(abs(st_left(:)-st_test_left(:)),correctposition_left,'o b');hold on;plot(abs(st_right(:)-st_test_right(:)),correctposition_right,'o r');pause;
kinematic_var=horzcat((vertcat(peak_vel_left,peak_vel_right)),(vertcat(v_end_left,v_end_right)), ...
                       (vertcat(deliberationtime_left,deliberationtime_right)));
                   size(kinematic_var)
end

