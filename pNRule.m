function [ prediction, k ] = pNRule(X1, X2, zN, test, classes)
%pNRule Classify when pN reaches zN
%   Adaptive rule for nearest neighbour classification.
%   X1, X2 - training data for class1 and class2 respectively
%   test - test sample
%   zN - confidence level
    
    %compute distance to the two classes
    dist_X1 = sortedEuclideanDistance(X1, test);
    dist_X2 = sortedEuclideanDistance(X2, test);

    %initially take one neighbour to each class
    N1 = 1;
    N2 = 1;
    
    k=N1+N2;
    prediction =classes(1,1);
    while  N1<=size(dist_X1,1) || N2<=size(dist_X2,1) 
        %find the nearer neighbor and include more of nearer class
        if(dist_X1(N1, 1) > dist_X2(N2, 1))
            N2 = N2+1;
        else
            N1 = N1+1;
        end
        
        %measuring total no. of neighbors
        k = N1+N2;
        
        delN = abs(N1-N2);
        
        % pN = (12)
        L =N1+N2+1;
        K1_1 = ( evalin(symengine,['1/(2^(',int2str(L),'))']) );
        K1_2=[];
        K2_2=[];
        for i=0:N1

            K1_2 = vertcat(K1_2, evalin(symengine,['binomial(',int2str(L),',',int2str(i),')']));
        end
        for i=0:N2
            K2_2 = vertcat(K2_2, evalin(symengine,['binomial(',int2str(L),',',int2str(i),')']));
        end
        PN1_2 = K1_1*sum(K1_2);
        PN2_1 = K1_1*sum(K2_2);
        pn12 = double(PN1_2);
        pn22 = double(PN2_1);
        %[PN1_2 PN2_1]
        %[N1 N2]
        %check if evidence reached confidence level and classify
        if max(pn12,pn22) >= zN || N1>size(dist_X1,1) || N2>size(dist_X2,1)            
            if pn12 > pn22
                prediction = classes(1,1);
            else
                prediction = classes(2,1);
            end
            break;
        end
    end
    if N1 ==1
        prediction = classes(2,1);
        return;
    elseif N2 == 1
        prediction = classes(1,1);
        return;
    end    
    if N1 < N2
        prediction = classes(2,1);
    else
        prediction = classes(1,1);
    end
end

