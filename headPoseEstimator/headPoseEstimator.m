SamplePoints = load('sample1_facePoints.mat');
facePoints = getfield(SamplePoints,'facePoints');
[ leftEye, rightEye, nose, mouthLeft, mouthRight, chin ] = get2DPoints( facePoints );
