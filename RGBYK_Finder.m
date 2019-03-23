% Michael Morgan
% EE 491
% Senior Design Drone Project
clear all; close all; clc;

% Notes
% Bots are Red and Yellow
% Goals are Green and Blue
% Obstacles are Black

% Constants
TwisterCircle=186; %Measured 186mm 
WheelDiameter=67; %Measured 69mm
WheelPerimiter= pi*(WheelDiameter/2);

I=imread('RGBY_Twister.jpg'); % Read Image
imshow(I) % Show Image
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
BLUE = zeros(s(1),s(2));
IMGOUT = zeros(s(1),s(2),3); % Initialize Output image matrix
z = 1;
Bx = zeros(s(1)*s(2),1);
By = zeros(s(1)*s(2),1);
while i <= s(1)
    while j <= s(2)
        if (R(i,j)>=G(i,j)*2) && (R(i,j)>=B(i,j)*2) % Adjust multiple to tune color to image 
            RED(i,j) = 1;
            IMGOUT(i,j,1) = 255;
            IMGOUT(i,j,2) = 0;
            IMGOUT(i,j,3) = 0;
        else
            %Produce white background
            IMGOUT(i,j,1) = 255;
            IMGOUT(i,j,2) = 255;
            IMGOUT(i,j,3) = 255;
        end
        if (B(i,j)>=G(i,j)*1.2) && (B(i,j)>=R(i,j)*1.2)% Adjust multiple to tune color to image
            %Blue Finder
            BLUE(i,j) = 1; %collect blue values
            Bx(z,1) = j;
            By(z,1) = i;
            z = z+1;
            IMGOUT(i,j,1) = 0;
            IMGOUT(i,j,2) = 0;
            IMGOUT(i,j,3) = 255;
        end
        if (G(i,j)>=B(i,j)*1.3) && (G(i,j)>=R(i,j)*1.3)% Adjust multiple to tune color to image
            %Green Finder
            IMGOUT(i,j,1) = 0;
            IMGOUT(i,j,2) = 255;
            IMGOUT(i,j,3) = 0;
        end
        if (R(i,j)>=B(i,j)*1.3) && (G(i,j)>=B(i,j)*1.3)% Adjust multiple to tune color to image
            %Yellow Finder
            IMGOUT(i,j,1) = 255;
            IMGOUT(i,j,2) = 255;
            IMGOUT(i,j,3) = 0;
        end
        if (R(i,j) <= 55) && (G(i,j) <= 55) && (B(i,j) <= 55)
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

x = 1;
Bxi = inf;
Byi = 0;
Bxf = 0;
Byf = 0;
ex = 0;
xi = 0;
xf = 0;
while x <= s(1)*s(2)
   if (Bx(x,1) < Bxi) && (Bx(x,1) > 0)
       Bxi = Bx(x,1);
       Byi = By(x,1);
       xi = x;
   else
       if (Bx(x,1) > Bxf) && (By(x,1) == Byi) && (Bx(x,1) < 5000)
            Bxf = Bx(x,1);
            Byf = By(x,1);
            xf = x;
       end
       
   end
   if (x == s(1)*s(2) - 2)
       y = Bxi;
       Btest = 0;
       while (y <= Bxf)
           Btest = Btest + BLUE(Byf,y);
           y = y+1;
       end
       TestRange = Bxf - Bxi + 1;
       if (Btest/TestRange < 0.9) || (TestRange < 600)
           Bx(xi,1) = 5000;
           Bx(xf,1) = 5000;
           Bxi = inf;
           Byi = 0;
           Bxf = 0;
           Byf = 0;
           xi = 0;
           xf = 0;
           x = 1;
           ex = ex + 1;
       end
       
   end
    
    x = x+1;
end
PixelRange = Bxf - Bxi + 1;
Pixel_per_mm = PixelRange / TwisterCircle 

% Display Red, Black, and Blue only
figure
imshow(IMGOUT);

% Estimated Image size based on measurements
PixPerMM_est = 4032 * 18 / (TwisterCircle * 85); % All millimeters
EstimatedWidth=(4032/PixPerMM_est)*0.00328084; % converted to feet
EstimatedHeight=(3024/PixPerMM_est)*0.00328084; % converted to feet
