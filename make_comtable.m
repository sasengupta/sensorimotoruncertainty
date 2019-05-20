function [ datatable ] = make_comtable( data_left,data_right)
%each subject has one svtable with trlno(indexno) ballspeed dir st error
%and check variables 
ballspeed_r=[];st_r=[];error_r=[];paddlefinish_r=[];correctposition_r=[];ballfinishposition_r=[];hitrate_l=[];
ballspeed_l=[];st_l=[];error_l=[];paddlefinish_l=[];correctposition_l=[];ballfinishposition_l=[];hitrate_r=[];
    
    for i=1:1:length(data_left)
        ballspeed_l=vertcat(ballspeed_l,data_left{i}.BallSpeed(:,1));
        paddlefinish_l=vertcat(paddlefinish_l,data_left{i}.PaddleFinishPosition(:,1));
        ballfinishposition_l=vertcat(ballfinishposition_l,data_left{i}.BallFinishPosition(:,1));
        correctposition_l=vertcat(correctposition_l,data_left{i}.LandingDistance);
        st_l=vertcat(st_l,data_left{i}.SensingDuration);
        error_l=vertcat(error_l,data_left{i}.LandingError); 
        hitrate_l=vertcat(hitrate_l,data_left{i}.LandingHit);
    end

    for i=1:1:length(data_right)
        ballspeed_r=vertcat(ballspeed_r,data_right{i}.BallSpeed(:,1));
        paddlefinish_r=vertcat(paddlefinish_r,data_right{i}.PaddleFinishPosition(:,1));
        ballfinishposition_r=vertcat(ballfinishposition_r,data_right{i}.BallFinishPosition(:,1));
        st_r=vertcat(st_r,data_right{i}.SensingDuration);
        error_r=vertcat(error_r,data_right{i}.LandingError);
        correctposition_r=vertcat(correctposition_r,data_right{i}.LandingDistance); 
        hitrate_r=vertcat(hitrate_r,data_right{i}.LandingHit);
    end
    
    ballspeed=vertcat(ballspeed_l,ballspeed_r);
    paddlefinish=vertcat(paddlefinish_l,paddlefinish_r);
    indicatedposition=abs(paddlefinish-20);
    correctposition=vertcat(correctposition_l,correctposition_r); 
    ballfinishposition=vertcat(ballfinishposition_l,ballfinishposition_r);
    hitrate=vertcat(hitrate_l,hitrate_r);
    st=vertcat(st_l,st_r);
    error=vertcat(error_l,error_r);
    dir=ballspeed./abs(ballspeed);
    
datatable=horzcat(ballspeed,st,error,paddlefinish,indicatedposition,correctposition,ballfinishposition,hitrate,dir);
end

