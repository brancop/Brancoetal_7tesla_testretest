%calculates the Dice values for fixed z values, from z = 2 to z = 20
%please check the instructions file to setup the files corectly
clear all; close all; clc;

%Code necessary for the interface between Matlab and FSL
fsld=['FSLDIR=/usr/local/fsl;'...
          '. ${FSLDIR}/etc/fslconf/fsl.sh;'...
          'PATH=${FSLDIR}/bin:${PATH};'...
          'export FSLDIR PATH;']; 
      
%loops over the first mask
for a=1:37  
%loops over the second mask
for b=1:37
INPUT1 = [fsld,'fslstats ./Dice_fixedz/Protocol1/WB/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask1 = temp(1);
INPUT1 = [fsld,'fslstats  ./Dice_fixedz/Protocol2/WB/sensorimotor_',num2str(b),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask2 = temp(1);
INPUT1 = [fsld,'fslstats./Dice_fixedz/Protocol1/WB/sensorimotor_',num2str(a),'  -k ./Dice_fixedz/Protocol2/WB/sensorimotor_',num2str(b),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
intersect = temp(1);

%Calculate Dice for intrasession reliability
intrasession(a,b)= (2*intersect)/(sizemask1 + sizemask2);

INPUT1 = [fsld,'fslstats ./Dice_fixedz/Protocol1/WB/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask1 = temp(1);
INPUT1 = [fsld,'fslstats  ./Dice_fixedz/Protocol3/WB/sensorimotor_',num2str(b),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask2 = temp(1);
INPUT1 = [fsld,'fslstats./Dice_fixedz/Protocol1/WB/sensorimotor_',num2str(a),'  -k ./Dice_fixedz/Protocol3/WB/sensorimotor_',num2str(b),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
intersect = temp(1);

%Calculate Dice for intersession reliability
intersession(a,b)= (2*intersect)/(sizemask1 + sizemask2);

end
end

%now, it performs the same code for the ROI calculations

%loops over the first mask
for a=1:37  
%loops over the second mask
for b=1:37
INPUT1 = [fsld,'fslstats ./Dice_fixedz/Protocol1/ROI/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask1 = temp(1);
INPUT1 = [fsld,'fslstats  ./Dice_fixedz/Protocol2/ROI/sensorimotor_',num2str(b),' .V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask2 = temp(1);
INPUT1 = [fsld,'fslstats./Dice_fixedz/Protocol1/ROI/sensorimotor_',num2str(a),'  -k ./Dice_fixedz/Protocol2/ROI/sensorimotor_',num2str(b),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
intersect = temp(1);

%Calculate Dice for intrasession reliability
intrasession_ROI(a,b)= (2*intersect)/(sizemask1 + sizemask2);

INPUT1 = [fsld,'fslstats ./Dice_fixedz/Protocol1/ROI/sensorimotor_',num2str(a),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask1 = temp(1);
INPUT1 = [fsld,'fslstats  ./Dice_fixedz/Protocol3/ROI/sensorimotor_',num2str(b),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
sizemask2 = temp(1);
INPUT1 = [fsld,'fslstats./Dice_fixedz/Protocol1/ROI/sensorimotor_',num2str(a),'  -k ./Dice_fixedz/Protocol3/ROI/sensorimotor_',num2str(b),' -V'];
[status,result] = system(INPUT1);     
temp = str2num(result);
intersect = temp(1);

%Calculate Dice for intersession reliability
intersession_ROI(a,b)= (2*intersect)/(sizemask1 + sizemask2);

end
end
