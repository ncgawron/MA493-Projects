
close all; clear; clc; 
load Q1Data.mat 
k=6;
numf=10;

OvCO_forkPP=zeros(1,numf);

for realz = 1:numf
     %  [n,m]= size(XData);
    %IndexSeti = randi(k,n,1);
   %ci = -1.2 + 2.4*rand(k,m);
   
     % k ++ uncomment below    
    [ci,IndexSeti]=KPlusPlusInit(XData,k);
        %runs k means      
    [IndexSetf,cf]= kmeans493(XData,k,IndexSeti,ci);
    OvCo=oaco(XData,IndexSetf,cf);
    OvCO_forkPP(:,realz) = OvCo ; 
    

figure(realz) 

subplot(2,1,1)
  scatter(XData(:,1),XData(:,2),64,IndexSeti,'filled')
        hold on; 
        plot(ci(:,1),ci(:,2),'kx','MarkerSize',15,'LineWidth',3)
        title('K++ Initalized')
        
subplot(2,1,2)

    scatter(XData(:,1),XData(:,2),64,IndexSetf,'filled')
        hold on;
        plot(cf(:,1),cf(:,2),'kx','MarkerSize',15,'LineWidth',3)
      title('Post k-Means')
        
end         

% for figl = 6:8
%     
% figure(figl)
% opts = statset('Display','final');
% %[IndexSetf cf]= kmeans(XData,k,'Distance','cityblock',...
% %    'Replicates',5,'Options',opts );'uniform'
% [IndexSetf, cf]= kmeans(XData,k,'Start','uniform');
% scatter(XData(:,1),XData(:,2),64,IndexSetf,'filled')
%         hold on;
%         plot(cf(:,1),cf(:,2),'kx','MarkerSize',15,'LineWidth',3)
%       title('Post k-Means with MATLAB fn')
%       
% end 