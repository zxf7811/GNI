function [  RR,DET,LAM, Len,ENT ] = RQA( data  )
for i = 1:size(data,2)
    str_L = data(:,i);
n = size(data,1)/101;
RR(1,i)=0; DET(1,i)=0; LAM(1,i)=0; Len(1,i)=0; ENT(1,i)=0;

if n <= 1
   RR(1,i)=NaN; DET(1,i)=NaN; LAM(1,i)=NaN; Len(1,i)=NaN; ENT(1,i)=NaN;
   continue  
end

maxtau=50;

for k=1:maxtau
    mi_strL(k)=MutualInformation( str_L(1:end-maxtau),str_L(k:end-maxtau+k-1)); 
end 

[~,tau]= findpeaks(-mi_strL,'MINPEAKDISTANCE',5);
if isempty(tau)
Len(1,i) =NaN;
continue
end
tau_strL = tau(1);

if length(str_L)-1-(4-1)*tau_strL < 1
     RR(1,i)=NaN; DET(1,i)=NaN; LAM(1,i)=NaN; Len(1,i)=NaN; TT(1,i)=NaN;
    return 
end
ED_strL=EmbeddingDimension_FNN(str_L,tau_strL,15,2,4);
[~,dim_strL]=min(ED_strL);
data_chonggou_strL=PhaSpaRecon(str_L,tau_strL,dim_strL(1));




%% 
RD_strL = GetRecurrenceMetrix( data_chonggou_strL);

d_strL  = DiagonalLine( RD_strL );                     
v_strL  = VerticalLine( RD_strL );                       
N_strL = length(RD_strL);
RR(1,i) = length(find(RD_strL==1))/(N_strL*N_strL)*100;
DET(1,i) =  sum(d_strL(d_strL>4))/length(find(RD_strL==1))*100; 
LAM(1,i) =  sum(v_strL)/length(find(RD_strL==1))*100;
Len(1,i) = sum(d_strL(d_strL>10))/length(d_strL(d_strL>10));
ENT(1,i) = 1;
end

end

