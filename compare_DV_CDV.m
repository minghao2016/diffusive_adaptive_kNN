test_size = size(failed_test,1);
dv_predict = zeros(test_size, 1);  
cdv_predict = zeros(test_size, 1);  
K_dv = [];
K_cdv = [];
fail_dv =[]; 
fail_cdv =[]; 
for i=1:test_size    
    [dv_predict(i),K] = deltaVRule(x1,x2,dV_zV,failed_test(i,:),unique(failed_Y));
    K_dv = vertcat(K_dv,K);
    [cdv_predict(i),K] = conservativeDeltaVRule(x1,x2,cdV_zV,failed_test(i,:),unique(failed_Y));
    K_cdv = vertcat(K_cdv,K);
    if failed_Y(i, 1) ~= dv_predict(i, 1)
        fail_dv = vertcat(fail_dv,i);
    end
    if failed_Y(i, 1) ~= cdv_predict(i, 1)
        fail_cdv = vertcat(fail_cdv,i);
    end
end