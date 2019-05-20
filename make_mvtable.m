function [ datatable ] = make_mvtable( data_left,data_right)
%each subject has one svtable with trlno(indexno) ballspeed dir st error
%and check variables 
ballspeed_r=[];mt_r=[];error_r=[];paddlefinish_r=[];correctposition_r=[];ballfinishposition_r=[];
ballspeed_l=[];mt_l=[];error_l=[];paddlefinish_l=[];correctposition_l=[];ballfinishposition_l=[];
    
    for i=1:1:length(data_left)
        paddlefinish_l=vertcat(paddlefinish_l,data_left{i}.PaddleFinishPosition(:,1));
        ballfinishposition_l=vertcat(ballfinishposition_l,data_left{i}.BallFinishPosition(:,1));
        correctposition_l=vertcat(correctposition_l,data_left{i}.LandingDistance);
        mt_l=vertcat(mt_l,data_left{i}.MovementTime);
        error_l=vertcat(error_l,data_left{i}.LandingError); 
        
    end
if (nargin==2)
    for i=1:1:length(data_right)
        paddlefinish_r=vertcat(paddlefinish_r,data_right{i}.PaddleFinishPosition(:,1));
        ballfinishposition_r=vertcat(ballfinishposition_r,data_right{i}.BallFinishPosition(:,1));
        mt_r=vertcat(mt_r,data_right{i}.MovementTime);
        error_r=vertcat(error_r,data_right{i}.LandingError);
        correctposition_r=vertcat(correctposition_r,data_right{i}.LandingDistance);        
    end
end
    
    paddlefinish=vertcat(paddlefinish_l,paddlefinish_r);
    correctposition=vertcat(correctposition_l,correctposition_r);
    ballfinishposition=vertcat(ballfinishposition_l,ballfinishposition_r);
    indicatedposition=abs(paddlefinish-20);
    mt=vertcat(mt_l,mt_r);
    error=vertcat(error_l,error_r);
    dir=vertcat(ones(length(error_l),1),-1*ones(length(error_r),1));%ballspeed./abs(ballspeed);
    
datatable=horzcat(1000*ones(length(mt),1),mt,error,paddlefinish,indicatedposition,correctposition,ballfinishposition,dir);
end

