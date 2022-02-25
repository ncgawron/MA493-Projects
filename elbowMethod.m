
function elbowMethod = elbowMethod(xData,ncluster)
% input xData: the inital x and y values of the data points
% input ncluster: the numbers of clusters (successive numbers)
    for i=1:size(ncluster)
        % this initializes the points and creates a ci (centroid
        % initalized) and indexset
        [ci,IndexSeti]=KPlusPlusInit(XData,k);

        % this next step will compute the alternating minimization scheme,
        % creating the final index set and the final centroid data
        [IndexSetf,cf]= kmeans493(XData,ncluster[i],IndexSeti,ci); % centroid initialized

        % this will compute the overall coherence of the cluster
        OvCo=oaco(XData,IndexSetf,cf); % centroid finalized
        OvCo

        % now we will plot the overall coherence 
        plot()


    end
    
end