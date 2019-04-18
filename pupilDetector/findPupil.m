function [all_blobs,pupil] = findPupil( whole_eye )
%FINDPUPIL Summary of this function goes here
%   Detailed explanation goes here
grey = imono(whole_eye);
pupil = grey > 0;
all_blobs = iblobs(pupil,'boundary');



