function [outputArg1] = makePointCloud(inputArg1, inputArg2)
% Turns Depth Image into Pointcloud
% inputArg1 is Depth Image, inputArg2 is Color Image
[s1, s2] = size(inputArg1);
% Preallocate 3D Matrix to put x,y and Depth Data
Punkte = zeros(s2, s1, 3);
for i = 1:s1
    for j = 1:s2
        Punkte(j,i,1) = j;
        Punkte(j,i,2) = i;
        Punkte(j,i,3) = inputArg1(i,j)*255;
    end
end
% Transpose Image to fit Pointcloud data dimensions
rgbtranspose = pagetranspose(inputArg2);
outputArg1 = pointCloud(Punkte, 'Color',rgbtranspose);
end