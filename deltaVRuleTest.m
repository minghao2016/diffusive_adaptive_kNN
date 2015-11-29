function accuracy_array = deltaVRuleTest(training_data, training_label, zv_max)


accuracy_array = [];
[filtered_data,~] = compute_mapping(horzcat(training_label,training_data), 'FDA', 9);

for class1 = 0:10
    for class2 = class1+1 : 10  
        accuracy = 0;
        max_accuracy_zv = 0;
        classes = [class1; class2];
        class1
        class2
        [x1, x2, y1, y2] = dataSplit(filtered_data, training_label, classes(1,1), classes(2,1));
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

        test_data = vertcat(test_x1, test_x2);
        test_label = vertcat(test_y1, test_y2);
        test_size = size(test_label, 1);

        for z = 0.0001:0.001:zv_max
            z
            predict = zeros(test_size, 1);
            success = 0;
            for i=1:test_size
                predict(i) = deltaVRule(x1, x2, z, test_data(i,:), classes);
                if test_label(i, 1) == predict(i, 1)
                    success = success + 1;
                end
            end
            zv_accuracy = success * 100 / test_size;
            if accuracy < zv_accuracy
                max_accuracy_zv = z
                accuracy = zv_accuracy
            end
        end
        accuracy_array = vertcat(accuracy_array, [class1, class2, max_accuracy_zv, accuracy]);
    end
end