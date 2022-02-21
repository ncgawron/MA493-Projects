%% 
close all; clear all; 
% for funsies attempt at k++ initalization 

% 100 2-dimensional points, each points is a vector! 
%hopefully this is like quakes data
dataVec_whole = randi(100,2,100);
dataVec = dataVec_whole; 
%number of clusters; 
k =6; 

% num of data points 
n=length(dataVec); 

%haider likes zero initalization! 
C_values = zeros(size(dataVec,1),k);


% first step of k++
randIndex = randi(n);
% first cluster rep vector!
Cvalues(:,1)= dataVec(:,randIndex);

% eliminates data point
dataVec(:,randIndex)= []; 

for l=2:k
      % computes ecu. norm
    D_x = sqrt(sum((dataVec-Cvalues(:,l-1)).^2));
        % gets max value and index
    [Val,NewIndex] = max(D_x);
        %puts it in the list
    Cvalues(:,l) = dataVec(:,NewIndex);
        % trashes it from being selected again; 
    dataVec(:,NewIndex) = []; 
end


plot1 = plot(dataVec_whole(1,:),dataVec_whole(2,:));
grid on;
plot1.Marker = '*';
plot1.LineStyle = 'none'; 
hold on; 
plot2 = plot(Cvalues(1,:),Cvalues(2,:),'r');
plot2.Marker = 'O'; 
plot2.MarkerSize = 16; 
plot2.LineStyle='none';


%%

% going wild here!
%%
% Topic I.6 - Alternating Minimization Scheme Algorithm for k-Means Clustering*
% 
% Clear the workspace and close all figure windows
clear all
close all
% 
% Set the number of data vectors (n) and the dimension of the data space (m)
n=12; % Example 1
%n=100; %random data 
m=2;

% Set the number of clusters (k)
k=7;

% Initialize the data - either as in Example 1 or using random data
XData = zeros(n,m);
XData = [1/sqrt(2) 1/sqrt(2); -1/sqrt(2) 1/sqrt(2); 1/sqrt(2) -1/sqrt(2); -1/sqrt(2) -1/sqrt(2);...
        1/2 sqrt(3)/2; -1/2 sqrt(3)/2; 1/2 -sqrt(3)/2; -1/2 -sqrt(3)/2;...
        sqrt(3)/2 1/2; -sqrt(3)/2 1/2; sqrt(3)/2 -1/2; -sqrt(3)/2 -1/2; ];
%XData = -1*ones(n,m) + 2*rand(n,m);

% Assign each data vector, randomly to one of the k clusters
IndexSet = randi(k,n,1);

% Plot the data
scatter(XData(:,1),XData(:,2),64,IndexSet,'filled');
hold on

% Create data structures to store the weight vectors for cluster (c), and the 
% weight vectors from the previous iteration (cPrev)
c = zeros(k,m);
cPrev = zeros(k,m);

% Randomly initialize the weight vectors so that each component is sampled from 
% the interval [-1,1]
c = -1 + 2*rand(k,m);

% Plot the initial weight vectors
scatter(c(:,1),c(:,2),200,linspace(1,k,k))
hold off
pause

%% The Alternating Minimization Scheme
doneFlag=0;

% Keep alternating updates to weight vectors and cluster assignments until weight 
% vectors no longer change their locations

while (~doneFlag)

    % Update the weight vectors in each cluster via the centroid formula
    for i=1:k 

        % Find the indices for all data vectors currently in cluster i
        ClusterIndices = find(IndexSet==i);

        % Find the number of data vectors currently in cluster i
        NumVecsInCluster = size(ClusterIndices,1);

        % Create a data structure to store weight vector for the current
        % cluster
        c(i,:)=0; 

        % Update cluster vector using the centroid formula
        for j=1:NumVecsInCluster
            for l=1:m
                c(i,l) = c(i,l) + XData(ClusterIndices(j,1),l)/NumVecsInCluster;
            end
        end

    end

    % Plot the updated weight vectors for each cluster
    scatter(XData(:,1),XData(:,2),64,IndexSet,'filled')
    hold on
    scatter(c(:,1),c(:,2),200,linspace(1,k,k))
    pause
    
    % Now reassign all data vectors to the closest weight vector (cluster)

    % Create a data structure to store closest weight vector for each data
    % point
    closestCluster=zeros(n,1);

    % Reassign each data vector to the new, closest cluster
    for d=1:n

        % Store the coordinates of the current data vector
        xD = XData(d,:);

        % Set the minimum distance tracker to be a very large number
        sqDistMin=1e16;

        % Find the closest weight vector (cluster) to the current data
        % vector
        for i=1:k
            sqDist = norm(c(i,:)-xD,2);

            % If the distance is less than the current min, assign the
            % current data vector to this cluster
            if sqDist<sqDistMin
                closestCluster(d)=i;
                sqDistMin=sqDist;
            end

        end
    end

    % Update the assignments of the data vectors to their new clusters
    IndexSet = closestCluster;
    
    % Plot the data and the updated weight vectors
    hold off
    scatter(XData(:,1),XData(:,2),64,IndexSet,'filled')
    hold on
    scatter(c(:,1),c(:,2),200,linspace(1,k,k))
    hold off
    pause
    
    % Terminate the alternating scheme if the weight vectors are unaltered
    % relative to the previous iteration
    if c==cPrev
        doneFlag=1;
    else
        cPrev=c;
    end
end