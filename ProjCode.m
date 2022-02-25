
close all; clear all; 
% for funsies attempt at k++ initalization 

% 100 2-dimensional points, each points is a vector! 
%hopefully this is like quakes data
load Q1data.mat


%number of clusters; 
k =5; 

[n,m]=size(XData);

IndexSet = randi(k,n,1);

c= KPlusPlusInit(XData,k);
% 
% % num of data points 
% n=length(dataVec); 
% 
% %randomly assigned all 100 data points to k clusters
% IndexSet = randi(k,n,1);
% 
% %haider likes zero initalization! 
% Cvalues = zeros(size(dataVec,1),k);
% 
% rng(314)
% 
% % first step of k++
% randIndex = randi(n);
% 
% % first cluster rep vector!
% Cvalues(:,1)= dataVec(:,randIndex);
% 
% % eliminates data point
% dataVec(:,randIndex)= []; 
% 
% %%
% 
% for l=2:k
%       % computes ecu. norm
%       %intialize val vec for all furtherst poitns from each centriod
%       %already made....there are l-1 centriods already made
%       % the distance is in the left coloumn and the index for data point is
%       % on the right
%       Val_Vec = zeros(l-1,2)
%       for i = 1:l-1 
%          % computes the distance from every point to the i-th centriod 
%         D_x = sum( (dataVec-Cvalues(:,i)).^2 )
%         % gets max value and index for the point from the i-th centriod
%         [Fur_dist,PotIndex] = max(D_x)
%         % stoes the max distance and the index where this point was located
%         % in data vec
%         Val_Vec(i,:) = [Fur_dist,PotIndex] ;
%       end 
%      % gets the minimum value of the furthest distnaces, all in first
%      % coloumn 
%     [mindist_ofFurthest, WhereisNewCent ] = max(Val_Vec(:,1));
%         %takes the value of the index in corresponding coloumn 
%     NewIndex =  Val_Vec(WhereisNewCent,2);
%         % we input the new centriod in the Cvalues vector
%     Cvalues(:,l) = dataVec(:,NewIndex);
%         % trashes it from being selected again; 
%     dataVec(:,NewIndex) = [];
% end


 
plot2 = plot(c(:,1),c(:,2));
    plot2.LineStyle = 'none' ;
    plot2.Marker = 'O';
    plot2.MarkerSize = 10;
    plot2.MarkerFaceColor = 'r';
hold on;
plot1 = scatter(XData(:,1),XData(:,2),50,IndexSet,'filled');


%%

% going wild here!
%% Random Initalization
% Topic I.6 - Alternating Minimization Scheme Algorithm for k-Means Clustering*
% 
% Clear the workspace and close all figure windows

close all; clear all;

load Q1data.mat; 

[n,m]= size(XData); 

% Set the number of clusters (k)
k=4;

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
c = -1.2 + 2.4*rand(k,m);

% Plot the initial weight vectors
scatter(c(:,1),c(:,2),200,linspace(1,k,k))
hold off
pause



%% K++ initalization 

close all; clear all; clc;
% for funsies attempt at k++ initalization 

% 100 2-dimensional points, each points is a vector! 
%hopefully this is like quakes data
load Q1data.mat


%number of clusters; 
k =4; 

[n,m]=size(XData);



[c,IndexSet]= KPlusPlusInit(XData,k);

% intialized C_prev 
cPrev = zeros(k,m);


% Plot the data
scatter(XData(:,1),XData(:,2),64,IndexSet,'filled');
hold on
scatter(c(:,1),c(:,2),200,linspace(1,k,k))
hold off

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
    %pause
    
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
    %pause
    
    % Terminate the alternating scheme if the weight vectors are unaltered
    % relative to the previous iteration
    if c==cPrev
        doneFlag=1;
    else
        cPrev=c;
    end
end


%% Calculation of Overall Coherence

% computes overall coherence
OvCo=oaco(XData,IndexSet,c)
