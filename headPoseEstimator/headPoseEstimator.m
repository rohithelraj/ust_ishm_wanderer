%SamplePoints = load('landmarksSample2.mat');
%face = getfield(SamplePoints,'landmarks');
SamplePoints = load('landmarksSample6.mat');
output = getfield(SamplePoints,'output');
faces = getfield(output,'faces');
face = getfield(faces,'landmarks');
[ leftEye, rightEye, nose, mouthLeft, mouthRight, chin ] = get2DPoints( face );
image_points = [nose;chin;leftEye;rightEye;mouthLeft;mouthRight];
model_points = [0,0,0;0,-330,-65;-225,170,-135;225,170,-135;-150,-150,-125;150,-150,-125];
img = load('sample6.mat');
image = getfield(img,'im');
ret = load('matlab3D');
newret = getfield(ret,'cameraParams');
focalLength = getfield(newret,'FocalLength');
opticalCentre = getfield(newret,'PrincipalPoint');
img_size = size(image);
%focalLength = img_size(2);
camera_matrix = [focalLength(2),0,opticalCentre(2);0,focalLength(1),opticalCentre(1);0,0,1];
[rvec, tvec, inliers] = cv.solvePnPRansac(model_points, image_points, camera_matrix,'Method', 'UPnP','DistCoeffs',[0,0,0,0]);
[posePoints, jacobian] = cv.projectPoints(model_points, rvec, tvec, camera_matrix);
for i = 1:length(image_points) 
    image = cv.circle(image, [image_points(i,1),image_points(i,2)],5,'Color',[255,0,0],'Thickness',5);
end
point1 = [image_points(1,1),image_points(1,2)];
point2 = [fix(posePoints(1,1)),fix(posePoints(1,2))];
image = cv.line(image, point1,point2,'Color',[0,255,0],'Thickness',5);
imshow(image);
