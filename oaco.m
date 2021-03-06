function OvCo=oaco(XDataf,IndexSetf,c)
% The oaco function caluclates the overall coherence by summing the
% distance of each point in a cluster from is cluster representative. 
% inputs: XDataf  is input data n by m for m dimensional 
% inputs: IndexSetf is the final partition of the XData points after
% running k-means 
% inputs: c is the final opitmal centroid arrangement after running k-means
% outputs: OvCo is real value giving the coherence of the points from their
% respective centroid 

    % output overall coherence 
        % calculated by summing the coherence from each 
        %cluster sum_{1 to k } ||x_i-c_i||
    % input final indexSet after K-Means is run!
    % input final set of clusters
    % input orginal data of form nxm for n rows of m dimensional data
    OvCo =0; 
    for i=1:size(c,1) % number of k clusters
        % gets the i-th final cluster points  
        Dist_i =sum(sum((XDataf(IndexSetf==i,:)-c(i,:)).^2,2));
        OvCo = Dist_i + OvCo;
    end 
    
end 