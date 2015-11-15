data =[];
labels =[];
for k=1:5
    A = load(sprintf('data_batch_%d.mat',k));
    data = vertcat(data,A.data);
    labels = vertcat(labels,A.labels);
end
