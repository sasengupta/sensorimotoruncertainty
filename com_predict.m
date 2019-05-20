function [ mod_table ] = com_predict(tablecom,opt_sv,opt_mv)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% datatable=horzcat(ballspeed,st,error,paddlefinish,indicatedposition,correctposition,ballfinishposition,hitrate,dir);

ball_start_left=30.5;
ball_start_right=10;
subject_start=0;
correct_position=tablecom(:,6);
ball_velocity=abs(tablecom(:,1));
st=linspace(0,1.4,1000);
amp=linspace(9.6,30.5,1000);

for count=1:1:length(correct_position)
    empvar(count,:)=(opt_sv(1)*((st.^(opt_sv(2)))).*(ball_velocity(count)).^(opt_sv(3))).^2  ...
                                        +(correct_position(count).*2.^(1-(((1.4-st)-opt_mv(1))/opt_mv(2)))).^2; 
    err_empvar(count,:)=sqrt(empvar(count,:));
    optempvar(count)=min(sqrt(empvar(count,:)));
    [empmin_t(count),empind(count)]=min(sqrt(empvar(count,:)));
    predicted_st(count)=st(empind(count));
    
    m1=(opt_sv(1)*opt_sv(2)*((predicted_st(count).^(opt_sv(2)-1))).*(ball_velocity(count)).^(opt_sv(3)));
    m2=(.693/opt_mv(1))*(correct_position(count).*2.^(1-(((1.4-st(empind(count)))-opt_mv(1))/opt_mv(2))));
    valleyangle(count)=(m1-m2)/(1+m1*m2);

end
mod_table=horzcat(tablecom,optempvar',predicted_st',valleyangle');


end

