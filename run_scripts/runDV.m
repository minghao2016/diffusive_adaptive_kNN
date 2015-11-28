function [ accuracy, N ] = runDV(x1,x2,test_data,test_label,classes, zv_max )
accuracy = [];
test_size = size(test_data,1);
N = [];
for z = 0.0001:0.001:zv_max
    K=[];
    predict = zeros(test_size, 1);
    success = 0;
    for i=1:test_size
        [predict(i),k] = deltaVRule(x1, x2, z, test_data(i,:), classes);
        if test_label(i, 1) == predict(i, 1)
            success = success + 1;
        end
        K = vertcat(K,k);
    end
    N = vertcat(N, mean(K));
    zv_accuracy = success * 100 / test_size;
    accuracy = vertcat(accuracy,zv_accuracy);
end
end

