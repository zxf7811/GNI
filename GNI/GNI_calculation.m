clear all;
close all;
clc;
%%
M_HE=[];
M_PD=[];

filepath1='C:\Users\ASUS\Desktop\Github开源\HE_baseline\';
filepath2='C:\Users\ASUS\Desktop\Github开源\HE\';
filepath3='C:\Users\ASUS\Desktop\Github开源\PD\';
filepath = {filepath1, filepath2, filepath3};

for i = 1:length(filepath)
    matFiles = dir(fullfile(filepath{i}, '*.mat'));
    for k = 1:length(matFiles)
        filePath = fullfile(filepath{i}, matFiles(k).name);
        data = load(filePath);
        Name = fieldnames(data); 
        for j = 1:length(Name)
            assignin('base', Name{j}, data.(Name{j}));
        end
    end
end
%%
[DTSTD_HE_Spa_L] = DT_STD(HE_Spa_L,baseline_HE_Spa_L);
[DTSTD_HE_Spa_R] = DT_STD(HE_Spa_R,baseline_HE_Spa_R);
[DTSTD_HE_ROM_L] = DT_STD(HE_ROM_L,baseline_HE_ROM_L);
[DTSTD_HE_ROM_R] = DT_STD(HE_ROM_R,baseline_HE_ROM_R);
[DTSTD_HE_ROM_Sta_L] = DT_STD(HE_ROM_Sta_L,baseline_HE_ROM_Sta_L);
[DTSTD_HE_ROM_Sta_R] = DT_STD(HE_ROM_Sta_R,baseline_HE_ROM_Sta_R);
[DTSTD_HE_Spa_Var_L] = DT_STD(HE_Spa_Var_L,baseline_HE_Spa_Var_L);
[DTSTD_HE_Spa_Var_R] = DT_STD(HE_Spa_Var_R,baseline_HE_Spa_Var_R);
[DTSTD_HE_Spa_Sym] = DT_STD(HE_Spa_Sym,baseline_HE_Spa_Sym);
[DTSTD_HE_ROM_Sym] = DT_STD(HE_ROM_Sym,baseline_HE_ROM_Sym);

[DTSTD_PD_Spa_L] = DT_STD(PD_Spa_L,baseline_HE_Spa_L);
[DTSTD_PD_Spa_R] = DT_STD(PD_Spa_R,baseline_HE_Spa_R);
[DTSTD_PD_ROM_L] = DT_STD(PD_ROM_L,baseline_HE_ROM_L);
[DTSTD_PD_ROM_R] = DT_STD(PD_ROM_R,baseline_HE_ROM_R);
[DTSTD_PD_ROM_Sta_L] = DT_STD(PD_ROM_Sta_L,baseline_HE_ROM_Sta_L);
[DTSTD_PD_ROM_Sta_R] = DT_STD(PD_ROM_Sta_R,baseline_HE_ROM_Sta_R);
[DTSTD_PD_Spa_Var_L] = DT_STD(PD_Spa_Var_L,baseline_HE_Spa_Var_L);
[DTSTD_PD_Spa_Var_R] = DT_STD(PD_Spa_Var_R,baseline_HE_Spa_Var_R);
[DTSTD_PD_Spa_Sym] = DT_STD(PD_Spa_Sym,baseline_HE_Spa_Sym);
[DTSTD_PD_ROM_Sym] = DT_STD(PD_ROM_Sym,baseline_HE_ROM_Sym);
%% 
for i = 1:1
P1_HE = DTSTD_HE_Spa_L(:,5*i-4:5*i);
P2_HE = DTSTD_HE_Spa_R(:,5*i-4:5*i);
P3_HE = DTSTD_HE_ROM_L(:,10*i-9:10*i); 
P4_HE = DTSTD_HE_ROM_R(:,10*i-9:10*i);
P5_HE = DTSTD_HE_ROM_Sta_L(:,10*i-9:10*i);
P6_HE = DTSTD_HE_ROM_Sta_R(:,10*i-9:10*i);
P7_HE = DTSTD_HE_Spa_Var_L(:,5*i-4:5*i);
P8_HE = DTSTD_HE_Spa_Var_R(:,5*i-4:5*i); 
P9_HE = DTSTD_HE_Spa_Sym(:,5*i-4:5*i);
P10_HE = DTSTD_HE_ROM_Sym(:,10*i-9:10*i);

P1_PD = DTSTD_PD_Spa_L(:,5*i-4:5*i);
P2_PD = DTSTD_PD_Spa_R(:,5*i-4:5*i);
P3_PD = DTSTD_PD_ROM_L(:,10*i-9:10*i);
P4_PD = DTSTD_PD_ROM_R(:,10*i-9:10*i);
P5_PD = DTSTD_PD_ROM_Sta_L(:,10*i-9:10*i);
P6_PD = DTSTD_PD_ROM_Sta_R(:,10*i-9:10*i);
P7_PD = DTSTD_PD_Spa_Var_L(:,5*i-4:5*i);
P8_PD = DTSTD_PD_Spa_Var_R(:,5*i-4:5*i);
P9_PD = DTSTD_PD_Spa_Sym(:,5*i-4:5*i);
P10_PD = DTSTD_PD_ROM_Sym(:,10*i-9:10*i);

for i = 1:10
arrayName_HE = sprintf('P%d_HE', i);
arrayName_PD = sprintf('P%d_PD', i);
M_HE = [M_HE eval(arrayName_HE)]; 
M_PD = [M_PD eval(arrayName_PD)]; 
end
num_Part = size(M_PD,1)/7;

M_HE_1 = M_HE;
M_PD_1 = M_PD;

mean_M_HE_w = mean(M_HE);
mean_M_PD_w = mean(M_PD);
for k = 1:size(M_PD,2)
    [H,P] = ttest(M_HE(:,k),M_PD(:,k));
    if mean_M_HE_w(:,k)>mean_M_PD_w(:,k) || P>0.05
        M_HE_1(:,k) = 0;
        M_PD_1(:,k) = 0;
        Para_s(:,k)=0;
    else
        Para_s(:,k)=1;
    end       
end

M_HE_1 = M_HE_1.*Para_s;
M_PD_1 = M_PD_1.*Para_s;
M_HE_1(:,find(all(M_HE_1==0))) = [];
M_PD_1(:,find(all(M_PD_1==0))) = [];

for a = 1:num_Part
    GNI_HE_p = GNI_cov1(M_HE_1(7*(a-1)+1:7*a,:));
    GNI_PD_p = GNI_cov1(M_PD_1(7*(a-1)+1:7*a,:));
    GNI_HEALL_p(7*(a-1)+1:7*a,:) = GNI_HE_p;
    GNI_PDALL_p(7*(a-1)+1:7*a,:) = GNI_PD_p;
end

for a = 1:num_Part
    GNI_HE1_p(a,:) = sum(GNI_HEALL_p(7*(a-1)+1:7*a,:))/7;
    GNI_PD1_p(a,:) = sum(GNI_PDALL_p(7*(a-1)+1:7*a,:))/7;
end

end


ACC = SVM(GNI_HE1_p,GNI_PD1_p)
