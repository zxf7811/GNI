function [PDres] = DT_STD(PDmatrix, HE_baseline_matrix)
n = 7;
num_par_HE_baseline = size(HE_baseline_matrix,2)/2;
num_sub_PD = size(PDmatrix,1)/n;
num_par_PD = size(PDmatrix,2)/2;

ALL_std = std(HE_baseline_matrix(:,1*num_par_HE_baseline+1:2*num_par_HE_baseline),1);
ALL_mean = mean(HE_baseline_matrix(:,1*num_par_HE_baseline+1:2*num_par_HE_baseline),1);

for i = 1:num_sub_PD
ST_T = (PDmatrix(n*(i-1)+1:n*i, 1*num_par_PD+1:2*num_par_PD)-ALL_mean)./ALL_std;    
PDres(n*(i-1)+1:n*i,:) = ST_T;   
end

