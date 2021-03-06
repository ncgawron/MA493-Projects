
function [OvCo] = elbowMethod(xData,ncluster,varargin)
% input xData: the inital x and y values of the data points
% input ncluster: the numbers of clusters (successive numbers)
% input varargin{1}: The 1st centriod assignment
% output: a plot for elbow method across kvalues.
% Output OvCo: Overall coherence values in a vector

    for i=1:size(ncluster,2)
        % this initializes the points and creates a ci (centroid
        % initalized) and indexset
        [ci,IndexSeti]=KPlusPlusInit(XData,k,varargin{1});

        % this next step will compute the alternating minimization scheme,
        % creating the final index set and the final centroid data
        [IndexSetf,cf]= kmeans493(XData,ncluster[i],IndexSeti,ci); % centroid initialized

        % this will compute the overall coherence of the cluster
        OvCo=oaco(XData,IndexSetf,cf); % centroid finalized
        
        %stores coherence values in a vector
        OvCoVec = [OvCoVec OvCo];

    end
    plot(ncluster,OvCoVec)
end