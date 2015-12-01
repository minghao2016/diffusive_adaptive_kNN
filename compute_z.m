function [ z ] = compute_z( lambda1,lambda2,alpha,algorithm )
switch algorithm
    case 'DN'
        if lambda1>lambda2
            z = log(alpha)/log(lambda1/lambda2);
        else
            z = log(alpha)/log(lambda2/lambda1);
        end
    otherwise
        if lambda1>lambda2
            z = log(alpha)/(lambda1-lambda2);
        else
            z = log(alpha)/(lambda2-lambda1);
        end
    
        
end
end

