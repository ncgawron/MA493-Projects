function OvCo=oaco(XDataf,IndexSetf,c)
    % output overall coherence 
        % calculated by summing the coherence from each 
        %cluster sum_{1 to k } ||x_i-c_i||
    % input final indexSet after K-Means is run!
    % input final set of clusters
    % input orginal data of form nxm for n rows of m dimensional data
    OvCo =0; 
    for i=1:length(c) % number of k clusters
        % gets the i-th final cluster points  
        Dist_i =sum(sum((XDataf(IndexSetf==i,:)-c(i,:)).^2,2));
        OvCo = Dist_i + OvCo;
    end 
    
end 