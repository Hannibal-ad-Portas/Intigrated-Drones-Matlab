% Michael Morgan
% EE 491
% Senior Design Drone Project
clear all; close all; clc;

I1=imread('TwisterStitch1.jpg'); % Read First Image
s1=size(I1);
I2=imread('TwisterStitch2.jpg'); % Reads second image
s2=size(I2);

I3 = imresize(I2,[3024 NaN]); % Resize second image

I= [I1 I3]; % Stiched Image
imshow(I) % Show Stiched Image

R = I(:,:,1); % Get matrix of "red" values
G = I(:,:,2); % Get matrix of "green" values
B = I(:,:,3); % Get matrix of "blue" values

% Size of photo
s=size(I);
% Backround color
m=mode(I);
m=mode(m); 

% Find Color Red
i = 1; % Initialize ticker to count rows
j = 1; % Initialize ticker to count columns
RED = zeros(s(1),s(2)); % Initilize output matrix where red is 2x of green and Blue. Output 1 if true.
IMGOUT = zeros(s(1),s(2),3); % Initialize Output image matrix
while i <= s(1)
    while j <= s(2)
        if (R(i,j)>=G(i,j)*2) && (R(i,j)>=B(i,j)*2)
            RED(i,j) = 1;
            IMGOUT(i,j,1) = 255;
            IMGOUT(i,j,2) = 0;
            IMGOUT(i,j,3) = 0;
        else
            %Produce white bgrd
            IMGOUT(i,j,1) = 255;
            IMGOUT(i,j,2) = 255;
            IMGOUT(i,j,3) = 255;
        end
        if (R(i,j) <= 50) && (G(i,j) <= 50) && (B(i,j) <= 50)
            %Produce black obstacles
            IMGOUT(i,j,1) = 0;
            IMGOUT(i,j,2) = 0;
            IMGOUT(i,j,3) = 0;
        end
    j = j+1;
    end
    j = 1;
    i = i+1;
    
end

% Display Red & Black image
figure
imshow(IMGOUT);