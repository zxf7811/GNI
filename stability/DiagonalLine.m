function  l  = DiagonalLine( RD )
start = [];  stop = []; l=[]; 
start(:,2) = find(RD(1,1:end-1)==1);
start(:,1) = ones(length(find(RD(1,1:end-1)==1)),1);
for x = 1:size(start,1)
    for n = 1 : min(size(RD,2)-start(x,1),size(RD,2)-start(x,2))
        if RD(start(x,1)+n,start(x,2)+n) == 0
            stop = [stop;[start(x,1)+n-1 start(x,2)+n-1]];
            l = [l ; n];
            break
        end
    end
    if n == min(size(RD,2)-start(x,1),size(RD,2)-start(x,2))
        stop = [stop ; [start(x,1)+n start(x,2)+n]];
        l = [l ; n+1];
    end
end

for i = 2:size(RD,2)-1
    tempj = find(RD(i,1:end-1)==1);
    flag = 0;
    for x = 1:length(tempj)  
        if x==1
            if tempj(x)==1
                flag = 1;
            end
        elseif x~=1
            if RD(i-1,tempj(x)-1) == 0
                flag = 1;
            end
        end
        
        if  flag ==1
            start = [start;[i,tempj(x)]];
            for n = 1 : min(size(RD,2)-i,size(RD,2)-tempj(x))
                if RD(i+n,tempj(x)+n) == 0
                    stop = [stop;[i+n-1, tempj(x)+n-1]];
                    l = [l ; n];
                    flag = 0;
                    break
                end
            end            
            if n == min(size(RD,2)-i,size(RD,2)-tempj(x)) && RD(i+n,tempj(x)+n) == 1
                stop = [stop ; [i+n, tempj(x)+n]];
                l = [l ; n+1];
                flag = 0;
            end
        end
        flag = 0;
    end 
end

end

