clc
clear all
filepath='C:\Users\ASUS\Desktop\Github开源\Data\';
ALL=[];

i=1;
Data=load([filepath,'Result_',num2str(i),'SingleWalk','.mat']);  

StL_W_LB = Data.StWalk2.JointAng.Data.L.LB;
StR_W_LB = Data.StWalk2.JointAng.Data.R.LB;
[R_SW_sta,L_SW_sta]= GetAngleStability(StR_W_LB,StL_W_LB);
   
TL_W_LB = Data.Turn.JointAng.Data.L.LB;
TR_W_LB = Data.Turn.JointAng.Data.R.LB;
[R_T_sta,L_T_sta]= GetAngleStability(TR_W_LB,TL_W_LB);