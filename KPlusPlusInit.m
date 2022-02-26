
function [c,IndexSeti]= KPlusPlusInit(XData,k,varargin)


% returns the k num of clusters in the matrix c 
% IndexSeti  is the inital clustering for k means 

% XData  is input data n by m for m dimensional 
% k - num of clusters 
 %varargin{1} - set the inital centriod value!

[n,m]=size(XData);

% Establishes Index Set
% first is theinital index set
IndexSeti = randi(k,n,1);
IndexSet = IndexSeti; 
%haider likes zero initalization! 
c = zeros(k,m);

%%%%%%% Gets C_1

if nargin == 2
    % first step of k++
    randIndex = randi(n);

    % first cluster rep vector!
    c(1,:)= XData(randIndex,:);
else 
     SetInit42 = varargin{1}; 
     c(1,:) = XData(SetInit42,:);
end 


%%
% Create a data structure to store closest weight vector for each data
% point
closestCluster=zeros(n,1);


for l = 2:k
    
    % Reassign each data vector to the new, closest cluster
    for d=1:n

        % Store the coordinates of the current data vector
        xD = XData(d,:);

        % Set the minimum distance tracker to be a very large number
        sqDistMin=1e16;

        % Find the closest weight vector (cluster) to the current data
        % vector
        for i=1:l-1
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
    
    % sets up a matrix [distance , data point] for each max dist point per
    % cluster initalizes values to zero!
    % note we use 1+m dimensions since we need m dimensions to store the
    % cluster value 
    % AND the additional one is used to store the distnace
    DistanceANDClusterCani = zeros(l-1,1+m);
    
    
    % we have l-1 clusters looking for the l th cluster
    for y = 1:l-1
        % fetches points closest to y-th cluster
        PointsClosest2y = XData(IndexSet ==y,:);
        % computes the distance from closest points to the y-th cluster
        % gets the max!
        % 2 in the sum lets us sum by row!
        [Max_dist_forClosestClus,IndexInClosest] = max (sum( (PointsClosest2y -c(y,:)).^2,2));
        DistanceANDClusterCani(y,:)= [Max_dist_forClosestClus,PointsClosest2y(IndexInClosest,:)];
    end 
    [~, NextCentriodLoc]= max(DistanceANDClusterCani(:,1));
    c(l,:) = DistanceANDClusterCani(NextCentriodLoc,2:end);
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%REMOVE EVERYTHING BELOW BEFORE THE END IF WE NEED TO USE A TOTALLY
%%%%%RANDOM CLUSTERING  BEFOREHAND


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
    
   IndexSeti = closestCluster;
   
end


