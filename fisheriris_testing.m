load fisheriris;
X = meas(51:150,3:4);
Y = zeros(100,1);
for k=1:100
    if strcmp(species(k+50,1),'setosa')
        Y(k,:) = 3;
    elseif strcmp(species(k+50,1) ,'versicolor')
        Y(k,:) = 1;
    elseif strcmp(species(k+50,1), 'virginica')
        Y(k,:) = 2;
    end
end
clear meas species k;
[X1,X2,Y1,Y2] = dataSplit(X,Y,1,2);
gscatter(X(:,1),X(:,2),Y);
test = [5.5 2;6 2.25;5 1.6 ;6 1.6 ;4.6 1.4 ;4 1.5 ];
for i=1:size(test,1)
    line(test(i,1),test(i,2),'marker','pentagram','color','k',  'markersize',10,'linewidth',2);
end
truth = [ 2 2 1 2 1 1]';
clear i;