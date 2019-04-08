
%upper body detector based on viola and jones algorithm
bodyDetector = vision.CascadeObjectDetector('UpperBody');    
bodyDetector.MinSize = [60 60];
bodyDetector.MergeThreshold = 1;
bodyDetector.UseROI = false;

I2 = imread('COCO_test2015_000000000780.jpg'); 

% Search for objects in the top half of the image.
[height, width, ~] = size(I2);
%roi = [1 1 width height/2];     
bboxBody = step(bodyDetector, I2); % Detect upper bodies
% Annotate detected upper bodies   
IBody = insertObjectAnnotation(I2, 'rectangle', ...
                                 bboxBody, 'Upper Body');
figure, imshow(IBody), title('Detected upper bodies');