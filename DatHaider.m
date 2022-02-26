function [XData] = DatHaider(NImages)

%:input the number of images to extract 
%output: XData a matrix with informtion on greyscale pictures from MNIST
% Note this matrix is NImages x 400 <=>


% Set the number of images to extract from the data set of test images


% Uses the script by S Hegde to extract the images ('testImages') and
% correct labels ('testLabels') from the two files in the active path
% file "readMNIST.m" should be in an active path

[imgs labels] = readMNIST('testImages','testLabels', NImages, 0);


% Example of how to convert the first 10 images into vectors for input into
% the clustering algorithm

m = 20*20;
v = zeros(1,m);
XData = zeros(NImages,m);


% n rows or images 
% 400 coloumns for 20*20 pixels! 

for i=1:NImages
    XData(i,:) = reshape(imgs(:,:,i),[1,m]);
end

end 