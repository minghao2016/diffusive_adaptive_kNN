%filtered_load
clear;
load filtered_data;
mappedTest = mappedX(40001:50000,:);
test_labels = labels(40001:50000,:);
mappedX = mappedX(1:40000,:);
labels = labels(1:40000,:);

%code from here runs delta V rule.
A=[];
for i=0:8
    for j=1:9
        if i<j
            A = vertcat(A, [i j]);
        end
    end
end
lambdas = [];
for i=0:9
    [X,~,~,~] = dataSplit(mappedX,labels,i,i);
    lambda1 = estimateRateParameter(X,mean(X));
    lambdas = vertcat(lambdas,lambda1);
end

k=[];
alpha = 1.01:0.01:1.2;
[a,k] = runForAllClassPairs(A,mappedX,labels,mappedTest,test_labels,alpha,'DV');
kprme = reshape(k,20,45);
k = (mean(kprme,2));
kalpha = horzcat(k,a);
plot(sorted_kalpha(1,:),sorted_kalpha(2,:));
xlabel('Average nearest no of neighbours');
ylabel('Accuracy');


