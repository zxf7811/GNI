function [LBAngR,LBAngL] = GetAngleStability(LBAng_TR,LBAng_TL)
 RR=cellfun(@(N1) RQA(N1),LBAng_TR','UniformOutput',0);
LBAngR = reshape(cell2mat(RR),[],size(LBAng_TR{1},2),1);
 RR=cellfun(@(N1) RQA(N1),LBAng_TL','UniformOutput',0);
LBAngL = reshape(cell2mat(RR),[],size(LBAng_TL{1},2),1);

end

