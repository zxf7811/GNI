function  v  = VerticalLine( RD )
start_v = [];  stop_v = []; v=[];
start_v(:,2) = find(RD(1,1:end-1)==1);
start_v(:,1) = ones(length(find(RD(1,1:end-1)==1)),1);
for x = 1:size(start_v,1)
    for n = 1 : size(RD,2)-start_v(x,1)
        if RD(start_v(x,1)+n,start_v(x,2)) == 0
            stop_v = [stop_v;[start_v(x,1)+n-1 start_v(x,2)]];
            v = [v ; n];
            break
        end
    end
    if n == size(RD,2)-start_v(x,1) 
        stop_v = [stop_v ; [start_v(x,1)+n start_v(x,2)]];
        v = [v ; n+1];
    end
end

for i = 2:size(RD,2)-1
    tempj = find(RD(i,1:end-1)==1);
   
    for x = 1:length(tempj)        
        if  RD(i-1,tempj(x)) == 0
            start_v = [start_v;[i,tempj(x)]];
            for n = 1 : size(RD,2)-i
                if RD(i+n,tempj(x)) == 0
                    stop_v = [stop_v;[i+n-1, tempj(x)]];
                    v = [v ; n];
                    break
                end
            end            
            if n == size(RD,2)-i && RD(i+n,tempj(x)) == 1
                stop_v = [stop_v ; [i+n, tempj(x)]];
                v = [v ; n+1];
            end
        end
    end 
end

end

