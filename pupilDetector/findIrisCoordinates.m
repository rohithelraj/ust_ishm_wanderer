function irisCoordinates = findIrisCoordinates(pupilPoint,centroid,radii_spatial)
%FINDIRISCOORDINATES Summary of this function goes here
%Eucledian Distance between two points (x,y) and (X,Y) is D.
% In case of points |E|,|F|,|G|,|H|.
% To find coordinates of |€|,|n|,|L|,|z|.
%               cent.
%                 |
%                 |
%                 |
%        |E|      |
%                |A|
%                 |
%                 |
%                 |
%                 |
%   |€|           |
%                |a|            
%Let v=(x1,y1)?(x0,y0). Normalize this to u=v/|v||.

%The point along your line at a distance d from (x0,y0) is then (x0,y0)+du, 
%if you want it in the direction of (x1,y1), or (x0,y0)?du, if you want it in 
%the opposite direction. One advantage of doing the calculation this way is that 
%you won't run into a problem with division by zero in the case that x0=x1. 
line_vector = [(pupilPoint(1)-centroid(1)) (pupilPoint(2)-centroid(2))];
normal = sqrt((line_vector(1)^2)+(line_vector(2)^2));
line_vector_normal = [(line_vector(1)/normal) (line_vector(2)/normal)];
line_vector_normal_D = radii_spatial * line_vector_normal;
irisCoordinates = abs(ceil(line_vector_normal_D + pupilPoint));
end

