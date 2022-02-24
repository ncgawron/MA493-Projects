
function c= KPlusPlusInit(XData,k)


[n,m]=size(XData);


%haider likes zero initalization! 
c = zeros(k,size(XData,2));

%%%%%%% Gets C_1


% first step of k++
randIndex = randi(n);;

% first cluster rep vector!
c(1,:)= XData(randIndex,:);


%%
    % Create a data structure to store closest weight vector for each data
    % point
    closestCluster=zeros(n,1)
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
    DistanceANDClusterCani = zeros(l-1,3);
    
    
    % we have l-1 clusters looking for the l th cluster
    for y = 1:l-1
        % fetches points closest to y-th cluster
        PointsClosest2y = XData(IndexSet ==y,:);
        % computes the distance from closest points to the y-th cluster
        % gets the max!
        [Max_dist_forClosestClus,IndexInClosest] = max (sum( (PointsClosest2y -c(y,:)).^2,2));
        DistanceANDClusterCani(y,:)= [Max_dist_forClosestClus,PointsClosest2y(IndexInClosest,:)];
    end 
    [Dist2NextCentriod, NextCentriodLoc]= max(DistanceANDClusterCani(:,1));
    c(l,:) = DistanceANDClusterCani(NextCentriodLoc,2:end);
end 


end


