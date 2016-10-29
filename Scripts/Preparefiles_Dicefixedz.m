%this script will prepare the necessry files to calculate Dice coefficient
%at different z values (from 2 to 20, in steps of 0.5). 

%working directory should be set to the folder with the outputs of the dual regression
%step.

clear all; close all; clc;

%Code necessary for the interface between Matlab and FSL
fsld=['FSLDIR=/usr/local/fsl;'...
          '. ${FSLDIR}/etc/fslconf/fsl.sh;'...
          'PATH=${FSLDIR}/bin:${PATH};'...
          'export FSLDIR PATH;'];   
thr = 2;
mkdir 3D

%loop for thresholding the network masks from z = 2 to z = 20 in steps of
%0.5. 
for i=1:37   
INPUT1 = [fsld,'fslmaths sensorimotor_zmap -thr ',num2str(thr),' -bin ./3D/sensorimotor_network_',num2str(i)];
[status,result] = system(INPUT1);   
thr = thr + 0.5;
end

cd 3D
%now prepare the files for ROI statistics
%this will output all files in a newly creates "ROIs" folder
 
mkdir ROIs
for i=1:37   
INPUT1 = [fsld,'fslmaths sensorimotor_network_',num2str(i),' ?mul sensorimotor_ROI_struct ./ROIs/sensorimotor_network_',num2str(i)];
[status,result] = system(INPUT1);   
end
