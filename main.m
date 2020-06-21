%initialize variables
%there are three types of files sv,mv and com, each for two session l and
%r.So, six files in total svl, mvl,coml and svr,mvr,comr. In case of a
%break between sessions, you can have svl2. The extract data steps will
%ensure all the trials are taken into account.
PD=1; EHC=2; 
population=PD;
switch population
    case PD
        run runal_init_pd
    case EHC
        run runal_init_ehc
end
diagnostic=1;  %1=on; 2=off
codingmode=1;  %1=matlab; 2=python
combined=1;sensing=2;motor=3;%all_in_seq=4;
experiment=combined;
subject=[1,2,3,4,5,6,7,8,9,10]
for subs=1:1:1%
    subno=subject(subs);%
switch experiment
    case combined
           %load('model_parameters.mat')
          [ mod_table,fitval,summ_table_com ] = com_main(folder,sublist,type,subno,sensory_para(subno,:),motor_para(subno,:),diagnostic,codingmode);
          comdata(subno).mod_table=mod_table;
          comdata(subno).fitval=fitval;
          comdata(subno).summ_table_com=summ_table_com;
    case sensing
           [a,b,c,r2]= sensing_main(folder,sublist,type,subno,diagnostic,codingmode);           
           sensorydata(subno).rawdata=c;
           sensory_para(subno,:)= b
           r2_va(subno,:)=r2;
           
   case motor
            [ a,b,c,r2,exclu ]= motor_main(folder,sublist,type,subno,diagnostic,codingmode);
             motordata(subno).rawdata=c;
             motor_para(subno,:)=b
             r2_va(subno,:)=r2
             remtrial(subno,1)=exclu(1,1)
             % to generate figure on motor uncertainty
             % run plot_motorerrorss outside the loop
    case all_in_seq
              
% %             [a,b,c]= sensing_main(folder,sublist,type,subno,diagnostic,codingmode);
% %             [ a,b,c ]= motor_main(folder,sublist,type,subno,diagnostic,codingmode);
% %             [ comtable ] = com_main(folder,sublist,type,subno,diagnostic,codingmode);
end
%pause;
end
