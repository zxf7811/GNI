function  RD  = GetRecurrenceMetrix( data_chonggou )

for i = 1:size(data_chonggou,2)
    for j = 1:size(data_chonggou,2)
        dis(i,j) = norm(data_chonggou(:,i)-data_chonggou(:,j));

    end
end
max_dis = max(max(dis));
for i = 1:size(data_chonggou,2)
    for j = 1:size(data_chonggou,2)
        if   0.1*max_dis > dis(i,j)
            RD(i,j) = 1;
        elseif 0.1*max_dis < dis(i,j)
            RD(i,j) = 0;
        end
    end
end

end

