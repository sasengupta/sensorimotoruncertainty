function [ svtable,sens_para,errorsummary,r2] = sensing_main(folder,sublist,type,subno,diagnostic,codingmode,experiment )
%readin phase
%dispalys total number of trials and total number of conditions

fileid1=3;fileid2=4;nooftrials=440;       %comes from runal_init that initialises folders and file names
currfilename_l=strcat(folder{subno},sublist{subno},type{fileid1});
currfilename_r=strcat(folder{subno},sublist{subno},type{fileid2});
[ data_left,data_right ] = extract(currfilename_l,currfilename_r,nooftrials,subno);
[ svtable ] = make_svtable( data_left,data_right);
[ kinematic_var ] = extract_kinvariables( data_left,data_right );
svtable=horzcat(svtable,kinematic_var);
%[cleandata,outliersummary]=detect_outlier( svtable,diagnostic,experiment);
figure;hold on;
[errorsummary, outliersummary,stat_table] = behavior_output(svtable,diagnostic,'k');
%data cleaning means, stddev, 
%detect outliers, choose removing outliers, return tables
[ mod_datatable ] = pre_model_sv( svtable);
[errorsummary, outliersummary,stat_table] = behavior_output(mod_datatable,diagnostic,'r');
%modelfit
figure;
[ opt_sv ] = sensoryuncertainty( mod_datatable)
[ opt_svl ] = sensoryuncertaintyleft( mod_datatable)
[ opt_svr ] = sensoryuncertaintyright( mod_datatable)
%determinig which underlying model will be called
sens_para=horzcat(opt_sv,opt_svl,opt_svr);
%output model parameters
%calculate R2 values
[r2]=calculate_goodnessoffit(opt_sv,opt_svl,opt_svr,errorsummary,mod_datatable)

end

