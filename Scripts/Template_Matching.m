% This script performs the template matching procedure. 

% Set the working directory to the ICs folder, created by the
% "prepare_ICS_templatematching" script. 

%Copy the sensorimotor mask in functional space to the ICs folder (or edit
%the path to your local path). 
clear all; close all; clc;


%Code necessary for the interface between Matlab and FSL
fsld=['FSLDIR=/usr/local/fsl;'...
          '. ${FSLDIR}/etc/fslconf/fsl.sh;'...
          'PATH=${FSLDIR}/bin:${PATH};'...
          'export FSLDIR PATH;'];
%Code necessary for the interface between Matlab and FSL

%counts the number of .nii.gz files          
files = dir('*.nii.gz');
n = size(files,1);
      
%loop over the number of ICs
for i = 1:n
    
%size of the first mask
INPUT1 = [fsld,'fslstats zstat',num2str(i),'.nii.gz ?V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask1 = temp(1);

%size of the second mask
INPUT1 = [fsld,'fslstats sensorimotor_network_func.nii.gz ?V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask2 = temp(1);

%# of voxels that intersect
INPUT1 = [fsld,'fslstats zstat',num2str(i),'.nii.gz -k sensorimotor_network_func ?V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
intersect = temp(1);
%Calculates the Dice coefficient, outputting it on a matrix with n rows. 
matrix(n,1)=(2*intersect)/(sizemask1 + sizemask2);
end

%order the ICS by Dice, from highest to lowest. The indices are the IC
%number.
[b,temp] = sort(matrix,'descend');
selected = temp(1:5,:);
output = sort(selected);

%create a fslmerge command with the top 5 classified ICs
strinit = [fsld,'fslmerge ?t classification_motor'];
for i=1:5
str = [strinit,' thresh_zstat',num2str(output(i)),'.nii.gz'];
strinit = str;
end

%run the fslmerge command created previously. this will output a file
%"classification_motor" with 5 volumes corresponding to the top5 ICs, form
%highest to lowest 

INPUT1 = [fsld, strinit];
[status,result] = system(INPUT1);
