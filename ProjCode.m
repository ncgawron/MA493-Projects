%% Random Initalization
% yeet
% Topic I.6 - Alternating Minimization Scheme Algorithm for k-Means Clustering*
% 
% Clear the workspace and close all figure windows     

close all; clear all;

load Q1data.mat; 

[n,m]= size(XData); 

% Set the number of clusters (k)
k=5;

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

% computes overall coherence AFTER K-Means! 
OvCo=oaco(XData,IndexSet,c)



%% 10 initalizations

close all; clear all; clc;



% 50  2-dimensional points, each points is a vector! 
%hopefully this is like quakes data
load Q1data.mat



rng(33)

% initalization :) heh
OvCO_forkPP = zeros(1,10);
OvCO_forRand = zeros(1,10); 
% number of clusters


k=5; 


% random initalization;

for realz = 1:10
    [n,m]= size(XData);
    IndexSeti = randi(k,n,1);
    ci = -1.2 + 2.4*rand(k,m);
    
    % scatter(XData(:,1),XData(:,2),64,IndexSeti,'filled')
    %     hold on
    %     scatter(ci(:,1),ci(:,2),200,linspace(1,k,k))
    %     hold off
    %     pause 
    %     
    
    % this runs the k-means algorithim
    [IndexSetf,cf]= kmeans493(XData,k,IndexSeti,ci);
    OvCo=oaco(XData,IndexSetf,cf);
    OvCO_forRand(:,realz) = OvCo ; % this creates a vector of the overall coherence
    
    %   scatter(XData(:,1),XData(:,2),64,IndexSetf,'filled')
    %     hold on
    %     scatter(cf(:,1),cf(:,2),200,linspace(1,k,k))
    %     hold off


end 


%k++ initalization 
for realz = 1:10  

    [ci,IndexSeti]=KPlusPlusInit(XData,k);
    
    %  scatter(XData(:,1),XData(:,2),64,IndexSeti,'filled')
    %     hold on
    %     scatter(ci(:,1),ci(:,2),200,linspace(1,k,k))
    %     hold off
    %     pause 
        
        %runs k means
   
    %uses a random     scheme for intial index
    %[IndexSetf,cf]= kmeans493(XData,k,randi(k,size(XData,1),1),ci);    
    [IndexSetf,cf]= kmeans493(XData,k,IndexSeti,ci);
    
    OvCo=oaco(XData,IndexSetf,cf);
    OvCO_forkPP(:,realz) = OvCo ; 
    
    %   scatter(XData(:,1),XData(:,2),64,IndexSetf,'filled')
    %     hold on
    %     scatter(cf(:,1),cf(:,2),200,linspace(1,k,k))
    %     hold off
end 




mean(OvCO_forkPP)
mean(OvCO_forRand)



%% Elbow Method

clc; clear all; close all; 

load Q1data.mat

suck =8; 
initalz =5; 

% rows is number of initlizations we use, coloumns is values of k 
% for each initilization scheme
mat2PlotKPP = zeros(initalz,suck); 
mat2PlotRand =zeros(initalz,suck); 

for k=1:suck
   
    
    for realz = 1:initalz

    [ci,IndexSeti]=KPlusPlusInit(XData,k);
        
        %runs k means
        
    [IndexSetf,cf]= kmeans493(XData,k,IndexSeti,ci);
    
    OvCo=oaco(XData,IndexSetf,cf);
    mat2PlotKPP(realz,k) = OvCo; 
    end 
    
    
    
     for realz = 1:initalz

    [n,m]= size(XData);
    IndexSeti = randi(k,n,1);
    ci = -1.2 + 2.4*rand(k,m);
        
        %runs k means
        
    [IndexSetf,cf]= kmeans493(XData,k,IndexSeti,ci);
    
    OvCo=oaco(XData,IndexSetf,cf);
    mat2PlotRand(realz,k) = OvCo; 
     end 
    
    
    
end 



subplot(1,2,1)
for iter = 1:5
    plot(1:suck, mat2PlotKPP(iter,:),'LineWidth',1.5,'Marker',"*",'LineStyle','--')
    hold on;
    title('Elbow Plot for K++ Initalization')
    xlabel('Number of Clusters (k)')
    ylabel('Overall Coherence y')
    %rectangle('Position',[4-1 7-1 1 1],'Curvature',[.5 .5]) 
    %legend('Realiz 1','Realiz 4','Realiz 3','Realiz 4','Realiz 5')
    grid on;
end 



hold on; 

subplot(1,2,2)
for iter = 1:5
    plot(1:suck, mat2PlotRand(iter,:),'LineWidth',1.5,'Marker',"*",'LineStyle','--')
     hold on;
    title('Elbow Plot for Random Initalization')
    xlabel('Number of Clusters (k)')
    ylabel('Overall Coherence y')
    legend('Realiz 1','Realiz 4','Realiz 3','Realiz 4','Realiz 5')
    grid on;
end 




%% MNIST PART 3

close all; 
numim = 100; % number of images
% use parts of Haider Code to extract data frame from 100 images 
% 400 cols for 20 x 20 pizels 

%ovco badd at large k FYI

[XDataM ,labels2test]= DatHaider(numim);

% use k = 6 from jamie elbow! 
k_fromelbow=6;
    

%initalizes and does kmeans 
[c,IndexSeti]=KPlusPlusInit(XDataM,k_fromelbow,42);
[IndexSetf, cf] = kmeans493(XDataM,k_fromelbow,IndexSeti,c);

% for the  cluster we...
for val_k= 1:k_fromelbow 

    figure(val_k)    

    str = sprintf('Images associated with Cluster %d', val_k);



% look at all the points in this cluster from k means 
    for i=1:sum(IndexSetf==val_k)
       % creates the rows and coloumns for images in a cluster
        rows_img = round(numim/10);
        cols_img = round(numim/10);
       %creates a subplot for a certain cluster k
       subplot(rows_img,cols_img,i)
       title(str)
       %and shows all the images associated with that cluster
       Cluster_image = XDataM(IndexSetf==val_k,:);
       currImg = reshape(Cluster_image(i,:),[20,20]);
       imshow(currImg,'InitialMagnification',1000) 
    end
    
    
% cluster 1 is 1     
% cluster 2 is zero 
% cluster 3 is 3
% cluster 4 is 2 
% cluster 5 is 4  
% cluster 6 is 0


end 

%% Success score

% done with my eyeball 
% we see the number that occurs the most in each figure!
ClusterMostOccurNum = [1 0 3 2 4 0];


expLabs = zeros(100,1); 

for val_k = 1:k_fromelbow
    WhereImagesR=IndexSetf==val_k;
    expLabs = ClusterMostOccurNum(val_k).*(WhereImagesR)+expLabs ;
end 


SucScore = sum(expLabs == labels2test)/100;

SucScore*100;

%% Bonus Part


BonusSuck = 10; 

  
numim = 100; % number of images
% use parts of Haider Code to extract data frame from 100 images 
% 400 cols for 20 x 20 pizels 

%ovco badd at large k FYI

[XDataM ,labels2test]= DatHaider(numim);

SucScoresforAll = zeros(1,8);

for k_to_test =3:BonusSuck
    


        %initalizes and does kmeans 
        [c,IndexSeti]=KPlusPlusInit(XDataM,k_to_test,42);
        [IndexSetf, cf] = kmeans493(XDataM,k_to_test,IndexSeti,c);
        
        
        MostOccurNum = zeros(1,k_to_test);
        
        % for the  cluster we...
        for val_k= 1:k_to_test
         % computes the number 
         MostOccurNum(val_k)  =  mode(labels2test(IndexSetf==val_k));
        end 

        
        expLabs = zeros(100,1); 

        for val_k = 1:k_to_test
            WhereImagesR=IndexSetf==val_k;
            expLabs = MostOccurNum(val_k).*(WhereImagesR)+expLabs ;
        end 

        % computes the success score!
        SucScore = sum(expLabs == labels2test)/100;

        SucScoresforAll(val_k-2)= SucScore; 
        
end 

