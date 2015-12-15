load filtered_data;

%code from here runs delta N rule.
A=[];
for i=0:8
    for j=1:9
        if i<j
            A = vertcat(A, [i j]);
        end
    end
end

k=[];
alpha = 1.01:0.05:1.5;
[a1,k1] = runForAllClassPairs(A,mappedX,labels,mappedTest,test_labels,alpha,'DN');
alpha = 1.01:0.01:1.2;
[a2,k2] = runForAllClassPairs(A,mappedX,labels,mappedTest,test_labels,alpha,'DV');
[a3,k3] = runForAllClassPairs(A,mappedX,labels,mappedTest,test_labels,alpha,'CDV');
% kprme = reshape(k,,size(A,1),size(alpha,2))';
% k = (mean(kprme,2));
% kalpha = horzcat(k,a);
% sorted_kalpha = sort(kalpha);
% plot(sorted_kalpha(:,1),sorted_kalpha(:,2));
% xlabel('Average nearest no of neighbours');
% ylabel('Accuracy');
kprme1 = reshape(k1,size(A,1),10)';
k1 = (mean(kprme1,2));
kalpha1 = horzcat(k1,a1);
sorted_kalpha1 = sort(kalpha1);

kprme2 = reshape(k2,size(A,1),20)';
k2 = (mean(kprme2,2));
kalpha2 = horzcat(k2,a2);
sorted_kalpha2 = sort(kalpha2);

kprme3 = reshape(k3,size(A,1),20)';
k3 = (mean(kprme3,2));
kalpha3 = horzcat(k3,a3);
sorted_kalpha3 = sort(kalpha3);

kprme4 = reshape(k,size(A,1),6)';
k4 = (mean(kprme4,2));
kalpha4 = horzcat(k4,mean_accuracy);
sorted_kalpha4 = sort(kalpha4);

kprme5 = reshape(k,size(A,1),5)';
k5 = (mean(kprme5,2));
kalpha5 = horzcat(k5,mean_accuracy);
sorted_kalpha5 = sort(kalpha5);