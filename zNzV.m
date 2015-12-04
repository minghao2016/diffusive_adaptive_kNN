load filtered_data;
zKs = [];
A=[];
for i=0:8
    for j=1:9
        if i<j
            A = vertcat(A, [i j]);
        end
    end
end
algorithm = 'DV';
for alpha =1.01:0.01:1.2
    zNs = [];
    for i =1:size(A,1)
        [x1, x2, y1, y2] = dataSplit(mappedX, labels, A(i,1), A(i,2));
        temp_size = size(x1, 1);
        test_x1 = x1( 4 * temp_size /5 + 1 : temp_size, :); 
        x1 = x1(1:4 * temp_size /5, :);
        temp_size = size(x2, 1);
        test_x2 = x2( 4 * temp_size/5 + 1 : temp_size, :);
        x2 = x2(1 : 4 * temp_size /5, :);
        temp_size = size(y1, 1);
        test_y1 = y1(4 * temp_size/5 + 1 : temp_size, :);
        y1 = y1(1:4 * temp_size /5, :);
        temp_size = size(y2, 1);
        test_y2 = y2( 4 * temp_size/5 + 1 : temp_size, :);
        y2 = y2(1:4 * temp_size /5, :);

        test = vertcat(test_x1, test_x2);
        testY= vertcat(test_y1, test_y2);
        test_size = size(test_labels, 1);

        lambda1 = estimateRateParameter(x1,mean(x1));
        lambda2 = estimateRateParameter(x2,mean(x2));

        zN = compute_z(lambda1,lambda2,alpha,algorithm);
        zNs = vertcat(zNs,zN);
    end
    zKs = horzcat(zKs,zNs);
end