function [ z ] = compute_z( lambda1,lambda2,alpha,algorithm )
switch algorithm
    case 'DN'
        if lambda1>lambda2
            z = log10(alpha)/log10(lambda1/lambda2);
        else
            z = log10(alpha)/log10(lambda2/lambda1);
        end
    otherwise
        if lambda1>lambda2
            z = log10(alpha)/(lambda1-lambda2);
        else
            z = log10(alpha)/(lambda2-lambda1);
        end
    
        
end
end

