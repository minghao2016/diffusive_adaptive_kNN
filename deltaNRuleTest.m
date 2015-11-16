function predict = deltaNRuleTest(TrainingData, TrainingLabel, TestData, TestLabel, Zn)
testSize = size(TestData,1);
predict = zeros(testSize,1);
success = 0;
[X1, X2, Y1, Y2] = dataSplit(TrainingData, TrainingLabel, 1, 2);
for i=1:testSize
    predict(i) = deltaNRule(X1, X2, Zn, TestData(i, :));
    if TestLabel(i) == predict(i, 1)
        success = success + 1;
    end
end
accuracy = success * 100 / testSize;