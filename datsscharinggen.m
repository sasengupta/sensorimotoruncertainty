%used to generate data to be shared
mvfields={'FrameData'};
svfields={'FrameData'};
comfields={'FrameData'};
for i=1:1:10
currfilenamemvl=strcat(folder{i},sublist{i},type{1},'.dat');
currfilenamemvr=strcat(folder{i},sublist{i},type{2},'.dat');
currfilenamesvl=strcat(folder{i},sublist{i},type{3},'.dat');
currfilenamesvr=strcat(folder{i},sublist{i},type{4},'.dat');
currfilenamecoml=strcat(folder{i},sublist{i},type{5},'.dat');
currfilenamecomr=strcat(folder{i},sublist{i},type{6},'.dat');
data_mvl=DATAFILE_Read(currfilenamemvl);
data_mvl = rmfield(data_mvl,mvfields);
data_mvr=DATAFILE_Read(currfilenamemvr);
data_mvr = rmfield(data_mvr,mvfields);
data_svl=DATAFILE_Read(currfilenamesvl);
data_svl = rmfield(data_svl,svfields);
data_svr=DATAFILE_Read(currfilenamesvr);
data_svr = rmfield(data_svr,svfields);
data_coml=DATAFILE_Read(currfilenamecoml);
data_coml = rmfield(data_coml,comfields);
data_comr=DATAFILE_Read(currfilenamecomr);
data_comr = rmfield(data_comr,comfields);
save(strcat(num2str(i),'.mat'), 'data_svl', 'data_svr','data_mvr','data_mvl','data_coml','data_comr');
clearvars -except folder participants sublist type i mvfields svfields comfields
end