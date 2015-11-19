function accuracy_array = deltaNRuleTest(training_data, training_label, test_data, test_label, zn_max, classes)
accuracy = 0;
accuracy_array = [];
max_accuracy_zn = 0;
[filtered_data,~] = compute_mapping(horzcat(training_label,training_data), 'FDA', 9);
[filtered_test_data,~] = compute_mapping(horzcat(test_label,test_data),'FDA',9);
[x1, x2, y1, y2] = dataSplit(filtered_data, training_label, classes(1,1), classes(2,1));
[test_x1, test_x2, test_y1, test_y2] = dataSplit(filtered_test_data, test_label, classes(1,1), classes(2,1));
test_data = vertcat(test_x1, test_x2);
test_label = vertcat(test_y1, test_y2);
test_size = size(test_label, 1);
for z = 1:zn_max
    predict = zeros(test_size, 1);    
    success = 0;    
    for i=1:test_size
        predict(i) = deltaNRule(x1, x2, z, test_data(i,:), classes(1,1), classes(2,1));
        if test_label(i, 1) == predict(i, 1)
            success = success + 1;
        end
    end
    zn_accuracy = success * 100 / test_size;
    if accuracy < zn_accuracy
        max_accuracy_zn = z
        accuracy = zn_accuracy        
    end
end
accuracy_array = vertcat(accuracy_array, [accuracy, max_accuracy_zn]);
