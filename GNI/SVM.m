function [ACC] = SVM(M_HE,M_PD)
ACC_1 = [];
ACC_2 = [];
num_M = size(M_PD,2);
for j =1:num_M
PD_datalabel = [M_PD(:,j) ones(size(M_PD,1),1)];
HC_datalabel = [M_HE(:,j) zeros(size(M_HE,1),1)];
sample = [PD_datalabel;HC_datalabel];
[N_sample,M]=size(sample);
K = N_sample;
P = size(PD_datalabel,1);
Q = size(HC_datalabel,1);
for n = 1:K
    TEST_pd=sample(n,:);
    sample1 = sample;
    sample1(n,:)=[];
    TRAIN_pd = sample1;
    eval(['train_data', num2str(n) , '=[TRAIN_pd(:,1:M-1)];' ])
    eval(['train_label', num2str(n) , '=[TRAIN_pd(:,M)];' ])
    eval(['test_data', num2str(n) , '=[TEST_pd(:,1:M-1)];' ])
    eval(['test_label', num2str(n) , '=[TEST_pd(:,M)];' ])
end
for n = 1:K
    eval(['[train_data' num2str(n) ', m, s]= zscore(train_data' num2str(n) ');'])
    eval(['test_data' num2str(n) ' = (test_data' num2str(n) '-m)./s;'])
options=['-s 0 -t 2'];
    eval(['model',num2str(n), '= libsvmtrain(train_label',num2str(n), ',train_data',num2str(n),',options);'])
    eval(['[predicted_label' num2str(n) ', accuracy,~] = libsvmpredict(test_label' num2str(n) ',test_data' num2str(n) ',model' num2str(n) '); '])
    RA_All(n) = eval('accuracy(1)');
    SEN_All(n) = eval(['sum(predicted_label' num2str(n) '==1 & test_label' num2str(n) '==1)']);
    SPE_All(n) = eval(['sum(predicted_label' num2str(n) '==0 & test_label' num2str(n) '==0)']);
    PRE_All(n) = eval(['sum(predicted_label' num2str(n) '==1 & test_label' num2str(n) '==0)']);
    ERROR_PD(n) = eval(['sum(predicted_label' num2str(n) '==0 & test_label' num2str(n) '==1)']);
end
RA_Mean = mean(RA_All); 
SEN_Mean = sum(SEN_All);
SPE_Mean = sum(SPE_All);
PRE_Mean = sum(PRE_All);
ERROR_PD_Mean = sum(ERROR_PD);
ACC_1 = [RA_Mean SEN_Mean SPE_Mean PRE_Mean ERROR_PD_Mean];
ACC_2 = [ACC_2;ACC_1];
end
ACC = ACC_2;