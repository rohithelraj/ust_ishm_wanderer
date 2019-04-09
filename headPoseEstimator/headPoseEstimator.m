SamplePoints = load('landmarksSample2.mat');
face = getfield(SamplePoints,'landmarks');
[ leftEye, rightEye, nose, mouthLeft, mouthRight, chin ] = get2DPoints( face );
image_points = [nose;chin;leftEye;rightEye;mouthLeft;mouthRight];
model_points = [0,0,0;0,-330,-65;-225,-170,-135;225,170,-135;-150,-150,-125;150,-150,-125];
img = imread('sample2.jpg');
img_size = size(img);
focalLength = img_size(2);
camera_matrix = [focalLength,0,img_size(2)/2;0,focalLength,img_size(1)/2;0,0,1];
[rvec, tvec, success] = cv.solvePnP(model_points, image_points, camera_matrix);
posePoints = cv.projectPoints(model_points, rvec, tvec, camera_matrix);
img = cv.line(img, image_points(1,:),posePoints(1,:));
imshow(img);