sample = load('sampleImage3.mat');
rightEye = getfield(sample,'rightEyeSection');
%thresholding to obtain pupil
rightEye_YCbCr = rgb2ycbcr(rightEye);
preprocessedEye = rightEye_YCbCr;
rounded_y = rightEye_YCbCr(:,:,1);
[YCounts,YValues]  = imhist(rounded_y,1000);
% in most cases where the angle is not too far away or the pupil is not hindered by reflections, the threshold for Y is 0.2 
dimensions = size(rightEye_YCbCr(:,:,1));
for x = 1:dimensions(1)
    for y = 1:dimensions(2)
        if rightEye_YCbCr(x,y,1) < 0.2
            rightEye(x,y,:) = 0.0;
        end    
    end
end    
[all_blobs,pupil] = findPupil( rightEye );
[outputBlob,pupilFlag] = blobNoiseReduction( all_blobs, 900, 50 );
figure,imshow(rightEye);
outputBlob.plot_box;
box_side = sqrt(outputBlob.bboxarea);
result = outputBlob.bbox;
hEllipse = imellipse(gca,[result(1) result(2) box_side box_side]);
binaryImage = hEllipse.createMask();
pupil = imcomplement(pupil);
rgbImage = cat(3, pupil, pupil, pupil);
[row,col]=find(binaryImage);
PupilPixels = [row,col];
img_nopupil = (uint8(rgbImage)*255) + uint8(rightEye);
edged_canny_image = cannyEdgeDetector_forEye(img_nopupil); 
edged_pupil_image = cannyEdgeDetector_forEye(uint8(rgbImage)); 
[iris,standard_count,plus_count,minus_count,plus_count_2,minus_count_2] = irisRetriever(edged_canny_image,edged_pupil_image);
rgbImage_iris = cat(3, iris, iris, iris);
edged_canny_iris = cannyEdgeDetector_forEye(uint8(rgbImage_iris));
tracedIris = TraceCompleter(TraceCompleter(TraceCompleter(TraceCompleter(TraceCompleter(TraceCompleter(iris))))));
tracedIris_blobs = iblobs(tracedIris,'boundary');
[tracedIris_blobs_up,irisFlag] = blobNoiseReduction(tracedIris_blobs,30000,1900);