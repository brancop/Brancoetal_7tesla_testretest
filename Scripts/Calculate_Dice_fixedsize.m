%this script calculates the Dice values for fixed mask sizes.
%please check the instructions file to setup the files corectly
clear all; close all; clc;

%Code necessary for the interface between Matlab and FSL
fsld=['FSLDIR=/usr/local/fsl;'...
          '. ${FSLDIR}/etc/fslconf/fsl.sh;'...
          'PATH=${FSLDIR}/bin:${PATH};'...
          'export FSLDIR PATH;']; 
      
      
%loops over the 20 mask sizes (from 1000 to 20000 in steps of 1000)
for a=1:20
    
INPUT1 = [fsld,'fslstats ./Dice_fixedz/Protocol1/WB/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask1 = temp(1);
INPUT1 = [fsld,'fslstats  ./Dice_fixedz/Protocol2/WB/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask2 = temp(1);
INPUT1 = [fsld,'fslstats./Dice_fixedz/Protocol1/WB/sensorimotor_',num2str(a),'  -k ./Dice_fixedz/Protocol2/WB/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
intersect = temp(1);

%calculates the Dice for intrasession reliability
intrasession(a,1)= (2*intersect)/(sizemask1 + sizemask2);

INPUT1 = [fsld,'fslstats ./Dice_fixedz/Protocol1/WB/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask1 = temp(1);
INPUT1 = [fsld,'fslstats  ./Dice_fixedz/Protocol3/WB/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask2 = temp(1);
INPUT1 = [fsld,'fslstats./Dice_fixedz/Protocol1/WB/sensorimotor_',num2str(a),'  -k ./Dice_fixedz/Protocol3/WB/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
intersect = temp(1);

%calculates the Dice for interesession reliability

intersession(a,1)=(2*intersect)/(sizemask1 + sizemask2);

%now, it performs the same code for the ROI calculations
   
INPUT1 = [fsld,'fslstats ./Dice_fixedz/Protocol1/ROI/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask1 = temp(1);
INPUT1 = [fsld,'fslstats  ./Dice_fixedz/Protocol2/ROI/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask2 = temp(1);
INPUT1 = [fsld,'fslstats./Dice_fixedz/Protocol1/ROI/sensorimotor_',num2str(a),'  -k ./Dice_fixedz/Protocol2/ROI/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
intersect = temp(1);

%calculates the Dice for intrasession reliability
intrasession_ROI(a,1)= (2*intersect)/(sizemask1 + sizemask2);

INPUT1 = [fsld,'fslstats ./Dice_fixedz/Protocol1/ROI/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask1 = temp(1);
INPUT1 = [fsld,'fslstats  ./Dice_fixedz/Protocol3/ROI/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask2 = temp(1);
INPUT1 = [fsld,'fslstats./Dice_fixedz/Protocol1/ROI/sensorimotor_',num2str(a),'  -k ./Dice_fixedz/Protocol3/ROI/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
intersect = temp(1);

%calculates the Dice for interesession reliability

intersession_ROI(a,1)=(2*intersect)/(sizemask1 + sizemask2);

end