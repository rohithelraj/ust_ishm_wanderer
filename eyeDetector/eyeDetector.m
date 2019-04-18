%This implementation requires find_face_landmarks-1.2-x64-vc14-release from
%Yuval Nirkin
clear all;
close all;
%%
mainPath = cd; % FaceDetection/Main path
landmarksFilePath = strcat(mainPath(1:max(strfind(mainPath,'\'))),'find_face_landmarks-1.2-x64-vc14-release');
addpath(genpath(landmarksFilePath))

%% read image
    %coordinates = imread('coordinates.PNG');
    %cam = ipcam('http://172.16.9.227:8080/stream'); %initializing webcam
    im = imread('sampleImage1.jpeg'); %loading image from camera
    %for idx = 1:10 %lazy loading image
     %   im = snapshot('http://172.16.9.227:8080/stream/snapshot.jpeg');
    %end
    %clear cam %disconnecting camera
    %% initilaize shapemodell
    modelFile = 'shape_predictor_68_face_landmarks.dat';
    find_face_landmarks(modelFile); 
    %im = imread('raspberryPIIRCAM1.jpg');

    %%  find facial landmarks 
    output = find_face_landmarks(im); %struct with Faces

    % u,v coordinates of the face
    if(~isempty(output.faces))
        u = output.faces.landmarks(:,1); %
        v = output.faces.landmarks(:,2);

        %% plot landmarks

        pntSize =3 ; % Size of Points

        % Shape-Feature-Points face
        facePoints = [u(1:end-20) v(1:end-20)];
        %tmpFace = pntSize * ones(size(facePoints,1),1); 
        % retrieving only eyes
        rightEyePoints = facePoints(37:42,:);
        tmpEyesRight = pntSize * ones(size(rightEyePoints,1),1); 
        leftEyePoints = facePoints(43:48,:);
        tmpEyesLeft = pntSize * ones(size(leftEyePoints,1),1);
        % Shape-Feature-Points mouth
        %mouthPoints = [u(end-19:end) v(end-19:end)];
        %tmpMouth = pntSize * ones(size(mouthPoints,1),1);

        im = im2double(im); 

        imnew = insertShape(im,'FilledCircle',[rightEyePoints tmpEyesRight],'Color', 'red'); % insert face Points
        imnew = insertShape(imnew,'FilledCircle',[leftEyePoints tmpEyesLeft],'Color', 'blue'); % insert face Points
        %imnew = insertShape(imnew,'FilledCircle',[mouthPoints tmpMouth],'Color', 'blue'); % insert mouth points
        %show figure
        figure;
        imshow(imnew);
        %figure;
        %imshow(coordinates);
        h = impoly(gca,double(rightEyePoints));
        BW = createMask(h);
        %idisp(BW);
        rightEyeSection = im .* BW;
        figure;
        imshow(rightEyeSection);
        gray = rgb2gray(rightEyeSection);
        cannyImageOutput = edge(gray,'Canny');
        figure;
        imshow(cannyImageOutput);
    else
        imshow(im);
    end
    






