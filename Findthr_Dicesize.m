%this script calculates the thresholds such that a given mask has a fixed
%size in # of voxels

% It iteratively loops the fslstats command, to calculate the volume with a
% given threshold. 

%working directory should be set to the folder with the outputs of the dual regression
%step.

fsld=['FSLDIR=/usr/local/fsl;'...
          '. ${FSLDIR}/etc/fslconf/fsl.sh;'...
          'PATH=${FSLDIR}/bin:${PATH};'...
          'export FSLDIR PATH;'];
      
%indi sets the "index" of the for loop.       
indi=0;

%flag signals a break within the nested "for" loops once the correct
%threshold has been estimated

flag =0;
 
%loops over the target # of voxels
for target = 1000:1000:20000
indi = indi+1;
%sets a starting threshold for the search
thr = 2;  

%loops 20 times, increasing the threshold in steps of 1.
for i = 1:20
    
%calculates the volume with a given threshold. Decimal numbers set to 8.
INPUT1 = ([fsld,'fslstats sensorimotor_zmap -l ',mat2str(thr, 8),' -V']);
[status,result] = system(INPUT1);
vol = str2num(result);
vol = vol(1)      
%if the volume is lower than the target, breaks this for loop and starts
%searching at the next decimal number. 
      if vol < target
          break
%if the volume is equal to the target, the threshold is transfered to the
%"final" variable, the flag is set to 1 (breaking the next for loops), and
%this for loop is stopped.

      elseif vol == target
          final = thr;flag = 1;break
      end          
thr = thr+1;    
end
thr = thr-1;

%repeats the process, now increasing the threshold in steps of 0.1

for i = 1:100
if flag==1;break;end
INPUT1 = ([fsld,'fslstats sensorimotor_zmap -l ',mat2str(thr, 8),' -V']);
[status,result] = system(INPUT1);
      vol = str2num(result);
      vol = vol(1)              
      
if vol < target
         break
         elseif vol == target
         final = thr;flag = 1;break
      end
thr = thr+0.1 
end
thr = thr-0.1;


%repeats the process, now increasing the threshold in steps of 0.01

for i = 1:1000
if flag==1;break;end
INPUT1 = ([fsld,'fslstats sensorimotor_zmap -l ',mat2str(thr, 8),' -V']);
[status,result] = system(INPUT1);
vol = str2num(result);
vol = vol(1);              
          
if vol < target
          break   
      elseif vol == target
          final = thr; flag = 1; break
      end
      thr = thr+0.01;
end
thr = thr-0.01;
      

%repeats the process, now increasing the threshold in steps of 0.001

for i = 1:1000
if flag==1;break;end

INPUT1 = ([fsld,'fslstats sensorimotor_zmap -l ',mat2str(thr, 8),' -V']);
[status,result] = system(INPUT1);
vol = str2num(result);
vol = vol(1)              
         
      
if vol < target
break
        
elseif vol == target
final = thr; flag = 1; break
end
      thr = thr+0.001; 
end
           
      thr = thr-0.001;
                    
      
%repeats the process, now increasing the threshold in steps of 0.0001

for i = 1:1000
        if flag==1;break;end

      INPUT1 = ([fsld,'fslstats sensorimotor_zmap -l ',mat2str(thr, 8),' -V']);
      [status,result] = system(INPUT1);
      vol = str2num(result);
      vol = vol(1)              
             
     if vol < target
     break
     elseif vol == target
     final = thr; flag = 1; break
     end
       thr = thr+0.0001; 
end
           
thr = thr-0.0001;     
     
%repeats the process, now increasing the threshold in steps of 0.00001

for i = 1:10000
if flag==1;break;end

INPUT1 = ([fsld,'fslstats sensorimotor_zmap -l ',mat2str(thr, 8),' -V']);
[status,result] = system(INPUT1);
vol = str2num(result);
vol = vol(1)              
            
if vol < target
break
          
elseif vol == target
final = thr; flag = 1; break
end
thr = thr+0.00001
end        
thr = thr-0.00001;


%repeats the process, now increasing the threshold in steps of 0.000001

for i = 1:10000
if flag==1;break;end
INPUT1 = ([fsld,'fslstats sensorimotor_zmap -l ',mat2str(thr, 8),' -V']);
[status,result] = system(INPUT1);
vol = str2num(result);
vol = vol(1)             
if vol < target
break  
elseif vol == target
final = thr; flag = 1; break
end
end

%sets the final threshold, for each target (from 1000 to 20000 in steps of
%1000). Matrix will have 20 rows in ascending # of voxels order.
matrix(indi,1)=final;
end

%After estimating the thresholds for a given mask volume, the files
%themselves need to be generated. This will create a folder "size",
%containing the masks ordered from 1 to 20. 

mkdir size

for i = 1:20
INPUT1 = [fsld,'fslmaths sensorimotor_zmap -thr ',mat2str(matrix(i,1),8),' -bin ./size/sensorimotor_',num2str(i)];
[status,result] = system(INPUT1);
end
