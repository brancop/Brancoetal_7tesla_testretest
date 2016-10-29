%This code prepares the ICs for the template matching procedure.

fsld=['FSLDIR=/usr/local/fsl;'...
          '. ${FSLDIR}/etc/fslconf/fsl.sh;'...
          'PATH=${FSLDIR}/bin:${PATH};'...
          'export FSLDIR PATH;'];
%counts the number of .nii.gz files          
files = dir('*.nii.gz');
nfiles = size(files,1);
%divide by 2 (there are two versions of each IC, a thresholded version and
%one mixture modelling probability map)
n = round(nfiles/2); 
%creates the output directory IC
mkdir ICs

for i = 1:n
INPUT1 = [fsld,'fslmaths thresh_zstat?,num2str(i)?.nii.gz ?thr 0 ?bin ./ICs/zstat',num2str(i),'.nii.gz'];
[status,result] = system(INPUT1);     
end
