function [ leftEye, rightEye, nose, mouthLeft, mouthRight, chin ] = get2DPoints( facePoints )
%GET2DPOINTS Summary of this function goes here
%   Detailed explanation goes here
    leftEye = facePoints(46,:);
    rightEye = facePoints(37,:);
    nose = facePoints(34,:);
    mouthLeft = facePoints(55,:);
    mouthRight = facePoints(49,:);
    chin = facePoints(9,:);
end

