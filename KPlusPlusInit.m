close all ; clear all; clc;

load Q1data.mat

[n,m]=size(XData)

dataVec = XData;


k=5; 


IndexSet = randi(k,n,1);


%haider likes zero initalization! 
Cvalues = zeros(k,size(XData,2));

%%%%%%% Gets C_1


% first step of k++
randIndex = randi(n);

% first cluster rep vector!
Cvalues(1,:)= dataVec(randIndex,:);

% eliminates data point
dataVec(randIndex,:)= [];



%% determine 2nd cluster



%% Plots initalized Values

plot2 = plot(Cvalues(:,1),Cvalues(:,2));
    plot2.LineStyle = 'none' ;
    plot2.Marker = 'O';
    plot2.MarkerSize = 10;
    plot2.MarkerFaceColor = 'r';
hold on;
plot1 = scatter(XData(:,1),XData(:,2),50,IndexSet,'filled');

