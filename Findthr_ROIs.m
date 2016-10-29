%this script prepare the file for the calculation of ROI Dice fixed size calculation

%after the quality control step and making sure the masks are of the
%correct size, files for ROI statistics can be performed.

%set the working directory to the "size" folder, created by the
%"find_threshold" script. 

fsld=['FSLDIR=/usr/local/fsl;'...
          '. ${FSLDIR}/etc/fslconf/fsl.sh;'...
          'PATH=${FSLDIR}/bin:${PATH};'...
          'export FSLDIR PATH;'];   
      
%created a ROIs folder, and output ROI files there.      
mkdir ROIs

for i=1:20   
INPUT1 = [fsld,'fslmaths sensorimotor_network_',num2str(i),' ?mul sensorimotor_ROI_struct ./ROIs/sensorimotor_network_',num2str(i)];
[status,result] = system(INPUT1);   
end
