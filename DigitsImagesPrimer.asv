%% MA 493 - Project#1 - Part 3 - Intro Script for visualizing and resizing
%% images of handwritten digits from MNIST data set. Each image is a 20x20 
%% matrix of greyscale values
%% Data downloaded from: http://yann.lecun.com/exdb/mnist/
%%
%% by Dr. Mansoor Haider - NCSU Mathematics
%%

clear all
close all

% Set the number of images to extract from the data set of test images
NImages = 100;

% Uses the script by S Hegde to extract the images ('testImages') and
% correct labels ('testLabels') from the two files in the active path
% file "readMNIST.m" should be in an active path

[imgs labels] = readMNIST('testImages','testLabels', NImages, 0);

% Example of how to images 6 through 10 in separate figures

for i=6:10
   figure(i) 
   imshow(imgs(:,:,i),'InitialMagnification',1000) 
end

% Example of how to convert the first 10 images into vectors for input into
% the clustering algorithm

m = 20*20;
v = zeros(1,m);
XData = zeros(NImages,m);

for i=1:NImages
    XData(i,:) = reshape(imgs(:,:,i),[1,m]);
end

% Now let's convert the vectors for images 11 through 15 back to arrays 
% and plot them in separate figures

for i=11:15
   figure(i) 
   currImg = reshape(XData(i,:),[20,20]);
   imshow(currImg,'InitialMagnification',1000) 
end

% Last, lets plot the correct labels for each image and the histogram of
% labels in images extracted from the data set
figure(101)
plot(labels)
figure(102)
hist(labels)