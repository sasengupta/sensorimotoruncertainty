function [ kinematic_var ] = extract_kinvariables_pd7( data_left,data_right )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    mod_vel_cut=2.5;
    trial=1;
    startposition=20;
    peak_vel_left=[];peak_vel_right=[];v_end_left=[];v_end_right=[];
    deliberationtime_left=[];deliberationtime_right=[];mt_realleft=[];mt_realright=[];
    for i=1:1:length(data_left)
      for count=1:1:data_left{i}.Trials
          starttime=find(data_left{i}.FrameData.State(count,:)==5,1)-1;         
        mo_onset=find(data_left{i}.FrameData.State(count,:)==6,1)
        mo_end=find(data_left{i}.FrameData.State(count,:)==7,1)-1;
        mo_end_bijvel=find((abs(data_left{i}.FrameData.RobotVelocity(count,mo_end:end,1))>=mod_vel_cut),1)
        if(isempty(mo_end_bijvel))
            mo_end_bijvel=0
        end
        %_________modified onset detection_________________________%
        mo_onset_mod=find((abs(data_left{i}.FrameData.RobotVelocity(count,starttime:mo_end,1))>=mod_vel_cut),1)
        mo_end_mod=find((abs(data_left{i}.FrameData.RobotVelocity(count,starttime:mo_end,1))>=mod_vel_cut),1,'last')
        st_left(trial,1)=mo_onset-starttime;%(mo_onset_mod)%-starttime)   
        st_test_left(trial)=(find(data_left{i}.FrameData.State(count,:)==6,1)-starttime);
        velatst_left(trial,1)= -1*(data_left{i}.FrameData.RobotVelocity(count,mo_onset,1))
        
        %starttime+mo_onset_mod,1))
        %pause;
         velatend_left(trial,1)=-1*(data_left{i}.FrameData.RobotVelocity(count,mo_end,1));
         timetoend_left(trial,1)=mo_end-starttime;%_mod;-starttime;
        [vmax vind]=max(abs(data_left{i}.FrameData.RobotVelocity(count,mo_onset:mo_end,1)))
        
            if(~isempty(vmax))
                peak_vel_left(trial,1)=vmax;
                timetopeak_left(trial,1)=mo_onset+ vind-starttime;
                correctposition_left(trial,1)= abs(data_left{i}.BallFinishPosition(count,1)-startposition);
                indicatedposition_left(trial,1)=abs(data_left{i}.FrameData.RobotVelocity(count,mo_end,1)-startposition)/correctposition_left(trial,1);
                positionatvmax_left(trial,1)=  abs(data_left{i}.FrameData.RobotPosition(count,mo_onset+vind,1)-startposition)/correctposition_left(trial,1);
                positionatst_left(trial,1)=abs(data_left{i}.FrameData.RobotPosition(count,mo_onset,1)-startposition)/correctposition_left(trial,1);
                positionatendofmovemnet_left(trial,1)=abs(data_left{i}.FrameData.RobotPosition(count,mo_end+mo_end_bijvel,1)-startposition)/correctposition_left(trial,1)
                velatmoend_left(trial,1)=-1*data_left{i}.FrameData.RobotVelocity(count,mo_end+mo_end_bijvel,1)
                mt_realleft(trial,1)=mo_end-mo_onset+mo_end_bijvel;
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
%generate plots here
figure;
% hold on; subplot(2,1,1)
% %plot on time
% title('temporal evolution of velocity');xlabel('time (ms)');ylabel('velocity (cm/s)');hold on
% plot(st_left,velatst_left,'x k');hold on;plot(timetopeak_left,peak_vel_left,'x b');hold on;
% plot(timetoend_left,velatend_left,'x r');hold on;%plot(movementend_left,velactend_left,'x k');
% %pause;
title('Velocity profile with amplitude');xlabel('Amplitude (scaled to correct amplitude)');ylabel('velocity (cm/s)');hold on
plot(positionatst_left,velatst_left,'x k');hold on;plot(positionatvmax_left,peak_vel_left,'x b');hold on;
plot(indicatedposition_left,velatend_left,'x r');hold on;plot(positionatendofmovemnet_left,velatmoend_left,'x k');

%plot(abs(st_left(:)-st_test_left(:)),correctposition_left,'o b');hold on;plot(abs(st_right(:)-st_test_right(:)),correctposition_right,'o r');pause;
kinematic_var=horzcat((vertcat(peak_vel_left,peak_vel_right)),(vertcat(v_end_left,v_end_right)), ...
                       (vertcat(deliberationtime_left,deliberationtime_right)));%,...
                       %(vertcat(mt_realleft,mt_realright)));
                   size(kinematic_var)
end

