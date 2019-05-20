function [ stat_table_mod,opt_mv,errorsummary,r2,exclu] = motor_main(folder,sublist,type,subno,diagnostic,codingmode  )
%,errorsummary,outliersummary readin phase
%dispalys total number of trials and total number of conditions

fileid1=1;fileid2=2;nooftrials=280;       %comes from runal_init that initialises folders and file names
currfilename_l=strcat(folder{subno},sublist{subno},type{fileid1});
currfilename_r=strcat(folder{subno},sublist{subno},type{fileid2});
if(subno~=7)
 [ data_left,data_right ] = extract(currfilename_l,currfilename_r,nooftrials);
 [ mvtable ] = make_mvtable( data_left,data_right);
 size(mvtable)
 [ kinematic_var ] = extract_kinvariables( data_left,data_right );
end
if(subno==7)
[ data_left] = extract_pd7(currfilename_l,currfilename_r,nooftrials,subno);
[ mvtable ] = make_mvtable( data_left);
[ kinematic_var ] = extract_kinvariables_pd7( data_left);
end
mvtable=horzcat(mvtable,kinematic_var);
size(mvtable)
figure;hold on;
[errorsummary1, outliersummary,stat_table] = behavior_output_mv(mvtable,diagnostic,'k');
[ mod_datatable ] = pre_model_mv( mvtable);

clear errorsummary
[errorsummary, outliersummary,stat_table_mod] = behavior_output_mv(mod_datatable,diagnostic,'r');
exclu=size(mvtable)-size(mod_datatable)
%pause;
%modelfit
figure;
[ opt_mv ] = motoruncertainty( mod_datatable)
[r2]=calculate_goodnessoffit_mv(opt_mv,errorsummary,mod_datatable)
 
end

