function varargout = Encoder(varargin)
% Encoder MATLAB code for Encoder.fig
%      Encoder, by itself, creates a new Encoder or raises the existing
%      singleton*.
%
%      H = Encoder returns the handle to a new Encoder or the handle to
%      the existing singleton*.
%
%      Encoder('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Encoder.M with the given input arguments.
%
%      Encoder('Property','Value',...) creates a new Encoder or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Encoder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Encoder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Encoder

% Last Modified by GUIDE v2.5 20-Oct-2018 12:00:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Encoder_OpeningFcn, ...
                   'gui_OutputFcn',  @Encoder_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Encoder is made visible.
function Encoder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Encoder (see VARARGIN)

% Choose default command line output for Encoder
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
clc
ab=ones(640,480);
axes(handles.axes1);
imshow(ab);

ab1=ones(640,480);
axes(handles.axes2);
imshow(ab1);

ab2=ones(640,480);
axes(handles.axes3);
imshow(ab2);
cla(handles.axes2);
cla(handles.axes3);
cla(handles.axes1);


% UIWAIT makes Encoder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Encoder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% hObject    handle to pushbutton8 (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I2=handles.I2;
imwrite(I2,'Watermark.bmp')
msgbox('Watermark Saved');


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.*','Select the MATLAB code file');
img=imread(strcat(PathName,FileName));
axes(handles.axes1);
imshow(img);
imwrite(img,'original.bmp')

handles.img=img;



guidata(hObject, handles);
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.img;
ab=get(handles.popupmenu1,'value');
R= img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);
switch (ab)
    case 1
        [LL1,LH1,HL1,HH1] = qwt2(R, 'db1');
        [LL,LH,HL,HH] = qwt2(LH1, 'db1');
        D=dct2(LH);        
    case 2
        [LL1(:,:,1),LH1(:,:,1),HL1(:,:,1),HH1(:,:,1)] = dwt2(R, 'haar');
        D(:,:,1)=dct2(LH1(:,:,1));
        [LL1(:,:,2),LH1(:,:,2),HL1(:,:,2),HH1(:,:,2)] = dwt2(G, 'haar');
        D(:,:,2)=dct2(LH1(:,:,2));
        [LL1(:,:,3),LH1(:,:,3),HL1(:,:,3),HH1(:,:,3)] = dwt2(B, 'haar');
        D(:,:,3)=dct2(LH1(:,:,3));    
        
end      
axes(handles.axes2);
imshow(([LL1,LH1;HL1,HH1]));
pause(0.8);
axes(handles.axes2);
imshow(D);            

guidata(hObject, handles);
% --- Executes on button press in pushbutton3.

function pushbutton3_Callback(hObject, eventdata, handles)
ab=get(handles.popupmenu1,'value');
img=handles.img;
save('ipm','ab')
switch (ab)
    case 1
I=imresize(img,[1024 1024]);

I1=rgb2ntsc(I);
[cA,cH,cV,cD] = qwt2(I(:,:,1),'haar');
[cA1,cH1,cV1,cD1] = qwt2(cA,'haar');
cA1=dct2(cA1);
[file path]=uigetfile('*.*','Select data');
message0=imresize(imread([path file]),[64 64]);
message=im2bw(message0);
axes(handles.axes2);
imshow(message);
s=message;
k=4;
delta=32;
[mc,nc]=size(cA1);
c=mc/k;d=nc/k;
[mm,nm]=size(s);
for i=1:c
    for j=1:d
        p=cA1(1+k*(i-1):i*k,1+k*(j-1):j*k);
        lemda1=p(1,1);
        lemda2=p(2,2);
        lemda3=p(3,3);
        lemda4=p(4,4);
        Yi=[lemda1 lemda2 lemda3 lemda4];
        sumlemda=(lemda1^2)+(lemda2^2)+(lemda3^2)+(lemda4^2);
        NormYi=sqrt(sumlemda);
        N=floor(NormYi/delta);
        bit=s(i,j);
        if bit==1
            if mod(N,2)==0
                newN=N;
            else
                newN=N+1;
            end
        else
            if mod(N,2)==0
                newN=N+1;
            else
                newN=N;
            end
        end
        newNormYi=newN*delta+(delta/2);
        newYi=Yi.*(newNormYi/NormYi);
        newp=p;
        newp(1,1)=newYi(1);
        newp(2,2)=newYi(2);
        newp(3,3)=newYi(3);
        newp(4,4)=newYi(4);
        cA1(1+k*(i-1):i*k,1+k*(j-1):j*k)=newp;
    end
end
cA1=idct2(cA1);
cA = iqwt2(cA1,cH1,cV1,cD1,'haar');
watermarkimage = uint8(iqwt2(cA,cH,cV,cD,'haar'));
watermarkimage(:,:,2:3)=I(:,:,2:3);
watermarkimagee=ntsc2rgb((I1));
[psnr mse]=psnr_mse_maxerr(I,watermarkimage);
save arnod.mat I s
    case 2
%read image
I=imresize(img,[1024 1024]);
cover_object=I(:,:,1);
cover_object2=I(:,:,2);
cover_object3=I(:,:,3);
[cA1,cH1,cV1,cD1] = dwt2(cover_object,'haar');
[cA,cH,cV,cD] = dwt2(cH1,'haar');
cH=dct2(cH);
k=4;
delta=32;
[mc,nc]=size(cH);
c=mc/k;d=nc/k;
[file path]=uigetfile('*.*','Select data');
message0=imresize(imread([path file]),[64 64]);
message=im2bw(message0);
axes(handles.axes2);
imshow(message);
s=message;

[mm,nm]=size(message);
for i=1:c
    for j=1:d
        p=cH(1+k*(i-1):i*k,1+k*(j-1):j*k);
        [U, S, V]=svd(p);
        lemda1=S(1,1);
        lemda2=S(2,2);
        lemda3=S(3,3);
        lemda4=S(4,4);
        Yi=[lemda1 lemda2 lemda3 lemda4];
        sumlemda=(lemda1^2)+(lemda2^2)+(lemda3^2)+(lemda4^2);
        NormYi=sqrt(sumlemda);
        N=floor(NormYi/delta);
        bit=message(i,j);
        if bit==1
            if mod(N,2)==0
                newN=N;
            else
                newN=N+1;
            end
        else
            if mod(N,2)==0
                newN=N+1;
            else
                newN=N;
            end
        end
        newNormYi=newN*delta+(delta/2);
        newYi=Yi.*(newNormYi/NormYi);
        newS=S;
        newS(1,1)=newYi(1);
        newS(2,2)=newYi(2);
        newS(3,3)=newYi(3);
        newS(4,4)=newYi(4);
        newP=U*newS*V';
        cH(1+k*(i-1):i*k,1+k*(j-1):j*k)=newP;
    end
end
cH=idct2(cH);
watermarkimage = iqwt2(cA,cH,cV,cD,'haar');
watermarkimage = iqwt2(cA1,watermarkimage,cV1,cD1,'haar');
watermarkimage=uint8(watermarkimage);
watermarkimage(:,:,2)=cover_object2;
watermarkimage(:,:,3)=cover_object3; 
[psnr mse]=psnr_mse_maxerr(I,watermarkimage);
save arnod.mat I s watermarkimage
end

axes(handles.axes3);
imshow(watermarkimage);
handles.I2=watermarkimage;
set(handles.edit1,'String',num2str(psnr));
set(handles.edit2,'String',num2str(mse));
guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% % --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
%img=handles.img;
I2=handles.I2;
ip= get(handles.popupmenu2,'value');
save('ipn','ip')
switch ip
    case 1
prompt = {'Enter noise value 1-gaussian 2-salt & pepper 3-poisson 4-speckle'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'1'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
switch(str2num(cell2mat(answer)))
    case 1
    nimg=imnoise(I2,'gaussian',0.01);
    case 2
    nimg= imnoise(I2,'salt & pepper',0.01);
    case 3
    nimg=imnoise(I2,'poisson');    
    case 4
    nimg=imnoise(I2,'speckle',0.01);    
end
case 2
prompt = {'Enter Rotation angel'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'10'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
nimg= imrotate(I2,str2num(cell2mat(answer)));   

    case 3
prompt = {'Enter Scale between 0.5-1'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'0.8'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
 nimg= imresize(I2,str2num(cell2mat(answer)));   
        
    case 4
prompt = {'Enter translation between 1-2'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
%  [m n d] = size(img);
%  a= unit8(zeros(512,str2num(cell2mat(answer)),3));
 nimg= imtranslate(I2,[25.3, -10.1],'FillValues',255);
    case 5
prompt = {'Enter noise value 1-gaussian 2-salt & pepper 3-poisson 4-speckle'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'1'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
switch(str2num(cell2mat(answer)))
    case 1
    nimg=imnoise(I2,'gaussian',0.01);
    case 2
    nimg= imnoise(I2,'salt & pepper',0.01);
    case 3
    nimg=imnoise(I2,'poisson');    
    case 4
    nimg=imnoise(I2,'speckle',0.01);    
end
prompt = {'Enter Rotation angel'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'10'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
nimg= imrotate(nimg,str2num(cell2mat(answer)));   
    case 6      
prompt = {'Enter translation between 1-2'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
ximg= imtranslate(I2,[25.3, -10.1],'FillValues',255);
prompt = {'Enter Rotation angel'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'10'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
nimg= imrotate(ximg,str2num(cell2mat(answer)));   

    case 7
prompt = {'Enter Scale between 0.5-1'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'0.8'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
nimg= imresize(I2,str2num(cell2mat(answer)));   
prompt = {'Enter Rotation angel'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'10'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
nimg= imrotate(nimg,str2num(cell2mat(answer)));   

    case 8
prompt = {'Enter translation between 1-2'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
%  [m n d] = size(img);
%  a= unit8(zeros(512,str2num(cell2mat(answer)),3));
 ximg= imtranslate(I2,[25.3, -10.1],'FillValues',255);
prompt = {'Enter Scale between 0.5-1'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'0.8'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
nimg= imresize(ximg,str2num(cell2mat(answer)));
end
axes(handles.axes3);
imshow(nimg);
handles.I2=nimg;
guidata(hObject, handles);


% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
