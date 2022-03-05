# MA493-Projects

This is a repo MA 493 projects in MATLAB! 

We have sevral scripts and functions:

- **Project1SNJA.mlx** is a live script containing the body of our PDF Report
- **ProjCode.m** is a file that contains sectioned off portions of code solving each of the three parts (4th if counting Bonus)
    - Part 1: k++ initalization Concept 
    - Part 2: Elbow Method
    - Part 3: MNIST Data
    - Part 4 : Bonus section 
- **KPlusPlusInit.m** is a function that takes in input of a Haider formated Data Matrix, the number of clusters k, and optional input of the index for the first centriod. This function establishes the ++ initalization for k-means clustering algorithm. 
- **k-means493.m** is a function that conducts the alternating minimzation
- **oaco.m** is a function that takes in the final indexSet after K-Means is run, the final set of centriods, the Haider formated Data Matrix, and outputs 
- **DatHaider.m** extracts n number of images from the mnist data set!
- **elbowMethod.m** uses overall coherence and plots the 
    -input ncluster: the numbers of clusters (successive numbers)
    -input varargin{1}: The 1st centriod assignment
    -output: a plot for elbow method across kvalues.
    -output OvCo: Overall coherence values in a vector

- **readMNIST**: Reads digits and labels from raw MNIST data files, provided. 

- **DigitsImagesPrimer.m**: Provided function 

- All other files are not needed for the ability to run the code present. 

## Maybe Describe all the files in the readme?
  

