function accuracy_array = deltaVRuleTest(training_data, training_label, test_data, test_label, zv_max)

accuracy_array = [];
[filtered_data,~] = compute_mapping(horzcat(training_label,training_data), 'FDA', 9);
[filtered_test_data,~] = compute_mapping(horzcat(test_label,test_data),'FDA',9);
for class1 = 0:9
    for class2 = class1+1 : 9
        accuracy = 0;
        max_accuracy_zv = 0;
        classes = [class1; class2];
        class1
        class2
        [x1, x2, y1, y2] = dataSplit(filtered_data, training_label, classes(1,1), classes(2,1));
        [test_x1, test_x2, test_y1, test_y2] = dataSplit(filtered_test_data, test_label, classes(1,1), classes(2,1));
        test_data = vertcat(test_x1, test_x2);
        test_label_for_classes = vertcat(test_y1, test_y2);
        test_size = size(test_label_for_classes, 1);

        for z = 1:zv_max
            predict = zeros(test_size, 1);
            success = 0;
            for i=1:test_size
                predict(i) = deltaVRule(x1, x2, z, test_data(i,:), classes);
                if test_label_for_classes(i, 1) == predict(i, 1)
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