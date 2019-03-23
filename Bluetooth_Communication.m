% Michael Morgan
% EE 491
% Senior Design Drone Project
% Bluetooth Communication

function dev=connect_bluetooth
g=msgbox('scanning bluetooth devices');
pause(.1);
if(ishandle(g))
delete(g);
end
r=instrhwinfo('Bluetooth');
d=r.RemoteNames;
[m,n] = listdlg('PromptString','Select Your Bluetooth device:','SelectionMode','single','ListString',d);
if(n==1)
dn=cell2mat(d(m));
di=instrhwinfo('Bluetooth',dn);
if(~isempty(cell2mat(di.Channels)))
dev= Bluetooth(dn,str2double(di.Channels));
fopen(dev);
else
msgbox('Not able to connect, Restart Device And Connect Again');
end
else
msgbox('Atleast one bluetooth Device Must be connected');
end

fwrite(dev,'1010101000000001000000010000011001010000000000000101100001010101');
end
%B = Bluetooth('dsd tech hc-06', 1); %to open bluetooth port
%btInfo = instrhwinfo('Bluetooth','dsd tech hc-06')







