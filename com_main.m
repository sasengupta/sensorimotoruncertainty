function [ mod_table,fitval,summ_table_com] =com_main(folder,sublist,type,subno,sensory_para,motor_para,diagnostic,codingmode  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
fileid1=5;fileid2=6;nooftrials=400;
currfilename_l=strcat(folder{subno},sublist{subno},type{fileid1});
currfilename_r=strcat(folder{subno},sublist{subno},type{fileid2});
[ data_left,data_right ] = extract(currfilename_l,currfilename_r,nooftrials);
[ comtable ] = make_comtable( data_left,data_right);
size(comtable)
[ kinematic_var ] = extract_kinvariables( data_left,data_right );
size(kinematic_var)
comtable=horzcat(comtable,kinematic_var);
[ mod_table ] = com_predict(comtable,sensory_para,motor_para)
make_figure( subno,mod_table,sensory_para,motor_para)
 [ fitval,summ_table_com] = com_fits(mod_table)
%optimal switching time
%variability in switching time analysis
%inputs: model parameters which can either be read in from memory or as an
%output of a previous piece of code
end

