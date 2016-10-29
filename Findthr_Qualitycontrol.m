%this script performs a quality control step to make sure the thesholds
%form the "find_threshold" script are accurate. We recomend manually
%overriding the files where the accurate threshold is not correctly estimated. 

%set the working directory to the folder "size", created by the
%"find_threshold" script.

for i = 1:20

INPUT1 = ([fsld,'fslstats sensorimotor_',num2str(i),' -V']);
[status,result] = system(INPUT1);
vol = str2num(result);
vol = vol(1);      
matrix_qualcontrol(i,1) = vol;    

end
