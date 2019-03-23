% Michael Morgan
% EE 491
% Senior Design Drone Project
clear all; close all; clc;

btInfo = instrhwinfo('Bluetooth','HC-05');
B = Bluetooth('btspp://98D331F58DF9', 1) %to open bluetooth port
fopen(B); %to open bluetooth port
fwrite(B,'l'); %send controls to arduino via bluetooth, commands can be 'l' 'r' 'b' 's'
pause(3);
fwrite(B,'s');
pause(2);
fwrite(B,'r');
pause(3);
fwrite(B,'s');
pause(2);
fwrite(B,'f');
pause(3);
fwrite(B,'s');
pause(2);
fwrite(B,'b');
B
fclose(B);

B = Bluetooth('btspp://001403067E25', 1) %to open bluetooth port
fopen(B); %to open bluetooth port
fwrite(B,'l'); %send controls to arduino via bluetooth, commands can be 'l' 'r' 'b' 's'
pause(3);
fwrite(B,'s');
pause(2);
fwrite(B,'r');
pause(3);
fwrite(B,'s');
pause(2);
fwrite(B,'f');
pause(3);
fwrite(B,'s');
pause(2);
fwrite(B,'b');
B
fclose(B);

%HC - O modules
%btspp://98D331F58DF9 HC-05
%btspp://001403067E25 DSD TECH HC-06



