% requires the ICC and rmanova functions, downloable from:
% https://www.mathworks.com/matlabcentral/fileexchange/22099-intraclass-correlation-coefficient--icc-)

%Set the main folder as the working directory

%loads the structural mask and finds indexes which coordinates are not
%part of the brain (==0);

% Use strucfunc00000 for WB analysis
% Replace with motorROI00000 for ROI analysis. 
t = load('./ICC/strucfunc00000');
t = t(:);
indices = find(t==0);

%loads the intensity information for the sensorimotor mask
%from protocol 1
a = load('./ICC/Protocol1/WB/sm_network00000');
intra = a(:);
%deletes all rows that are not within the brain
intra(indices)= [];
inter = a(:);
%deletes all rows that are not within the brain
inter(indices)= [];

%loads the intensity information for the sensorimotor mask
%from protocol 2
a = load('./ICC/Protocol2/WB/sm_network00000');
temp = a(:);
%deletes all rows that are not within the brain
temp(indices)=[];
intra(:,2) = temp;

%loads the intensity information for the sensorimotor mask
%from protocol 3
a = load('./ICC/Protocol3/WB/sm_network00000');
temp = a(:);
%deletes all rows that are not within the brain
temp(indices)=[];
inter(:,2) = temp;

%performs the call to the function ICC, case A-1

[r, LB, UB, F, df1, df2, p] = ICC(intra, 'A-1', .05, 0)

%creates the results matrix for intrasession
%column 1 = ICC, column 2, F value, column 3 = pvalues

Intrasession(1,1) = r;
Intrasession(1,2) = F;
Intrasession(1,3) = p;

[r, LB, UB, F, df1, df2, p] = ICC(inter, 'A-1', .05, 0)

%creates the results matrix for intersession
%column 1 = ICC, column 2, F value, column 3 = pvalues

Intersession(1,1) = r;
Intersession(1,2) = F;
Intersession(1,3) = p;

