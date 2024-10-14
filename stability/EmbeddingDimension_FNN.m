function ED = EmbeddingDimension_FNN(data,tau,r_tol,a_tol,m_max) 
lenSIG=length(data); 
mest=mean(data); 
RA2=0; 
for i=1:lenSIG 
    RA2=(data(i)-mest).^2+RA2; 
end 
RA2=RA2/lenSIG; 
RA=sqrt(RA2); 
for m=1:m_max 
    X1=PhaSpaRecon(data,tau,m);                         
    M=lenSIG-m*tau;            
    for i=1:M          
        Distance_inter=1e+5;                                        
        for j=1:M 
            if i~=j 
                Distanceij=norm(X1(:,i)-X1(:,j));                 
                if Distanceij<Distance_inter 
                    Distance_inter=Distanceij; 
                    j_index=j; 
                end 
            end 
        end 
        Rd(1,i)=Distance_inter;                                 
        Rd(2,i)=j_index;                                 
    end 
 false=0; 
    for i=1:M 
        increase=abs(data(i+tau*m)-data(Rd(2,i)+tau*m));   
        Rd(3,i)=Rd(1,i).^2+increase.^2;                         
        if increase/Rd(1,i)>r_tol 
            false=false+1;  
        elseif sqrt(Rd(3,i))/RA>a_tol 
            false=false+1; 
         
        end   
    end 

    ratio(1,m)=100*false/M; 
end 
ED= ratio'; 
end

