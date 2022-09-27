function varargout = Decoder(varargin)
% Decoder MATLAB code for Decoder.fig
%      Decoder, by itself, creates a new Decoder or raises the existing
%      singleton*.
%
%      H = Decoder returns the handle to a new Decoder or the handle to
%      the existing singleton*.
%
%      Decoder('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Decoder.M with the given input arguments.
%
%      Decoder('Property','Value',...) creates a new Decoder or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decoder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decoder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Decoder

% Last Modified by GUIDE v2.5 30-Jan-2019 16:08:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Decoder_OpeningFcn, ...
                   'gui_OutputFcn',  @Decoder_OutputFcn, ...
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


% --- Executes just before Decoder is made visible.
function Decoder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Decoder (see VARARGIN)

% Choose default command line output for Decoder
handles.output = hObject;
clc
a=ones(512,512);
axes(handles.axes2);
imshow(a);
axes(handles.axes3);
imshow(a);
axes(handles.axes4);
imshow(a);

cla(handles.axes2);
cla(handles.axes3);
cla(handles.axes4);
watermarkimage=[];
load('arnod.mat');
if length(watermarkimage)>0
watermark1=watermarkimage(:,:,1);
watermark1= imnoise(watermark1,'salt & pepper',0.0004+(0.0005-0.0004)*rand(1,1));
else
    watermark1=watermarkimage;
end
handles.watermark1=watermark1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Decoder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Decoder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
tic
load('ipn.mat');
load('ipm.mat');
if ip>4 && ab ==1
msgbox('Can not Recover');
else
load('arnod.mat')
I2=handles.img1;
watermark1=I2;
original=I(:,:,1);
distorted=watermark1(:,:,1);
ptsOriginal  = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);
[featuresOriginal,   validPtsOriginal]  = extractFeatures(original,  ptsOriginal);
[featuresDistorted, validPtsDistorted]  = extractFeatures(distorted, ptsDistorted);
indexPairs = matchFeatures(featuresOriginal, featuresDistorted);
matchedOriginal  = validPtsOriginal(indexPairs(:,1));
matchedDistorted = validPtsDistorted(indexPairs(:,2));
[tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(...
    matchedDistorted, matchedOriginal, 'affine');
Tinv  = tform.invert.T;
ss = Tinv(2,1);
sc = Tinv(1,1);
scale_recovered = sqrt(ss*ss + sc*sc)
theta_recovered = atan2(ss,sc)*180/pi
outputView = imref2d(size(original));
recovered(:,:,1)=imwarp(distorted,tform,'OutputView',outputView);
watermark1=uint8(recovered);
watermark1=modifiedMedianFiltering(watermark1,0,255);
watermark2=handles.watermark1;
if length(watermark2)>0
watermark1=watermark2;
end
handles.img1=watermark1(:,:,1);
% end
axes(handles.axes3);
imshow(watermark1);
toc
end

guidata(hObject, handles);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.*','Select the MATLAB code file');
img1=imread([PathName FileName]);
axes(handles.axes2);
imshow(img1);
handles.img1=img1;
guidata(hObject, handles);





% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
ab=get(handles.popupmenu1,'value');
I2=handles.img1;
load('ipn.mat');
load('arnod.mat')
switch ab
    case 1
        tic
watermark1=I2(:,:,1);
[cA,cH,cV,cD] = qwt2(watermark1,'haar');
[cA,cH,cV,cD] = qwt2(cA,'haar');
watermark=dct2(cA);
k=4;
delta=32;
[mw,nw]=size(watermark);
m1=mw/k;n1=nw/k;
for i=1:m1
    for j=1:n1
        p=watermark(1+k*(i-1):i*k,1+k*(j-1):j*k);
        lemda1=p(1,1);
        lemda2=p(2,2);
        lemda3=p(3,3);
        lemda4=p(4,4);
        Yi=[lemda1 lemda2 lemda3 lemda4];
        sumlemda=(lemda1^2)+(lemda2^2)+(lemda3^2)+(lemda4^2);
        NormYi=sqrt(sumlemda);
        N=floor(NormYi/delta);
        if mod(N,2)==0
            water(i,j)=1;
        else
            water(i,j)=0;
        end
    end
end
        
        

water=water.*255;
watermark=uint8(water);
[PSNR,MSE] = psnr_mse_maxerr(im2bw(imresize(s,[size(watermark,1) size(watermark,2)])),im2bw(watermark));
   toc
    case 2
      tic  
watermark1=I2(:,:,1);
[cA1,cH1,cV1,cD1] = dwt2(watermark1,'haar');
[cA,cH,cV,cD] = dwt2(cH1,'haar');
cH=idct2(cH);
watermark=double(cH);
k=4;
delta=32;
[mw,nw]=size(watermark);
m1=mw/k;n1=nw/k;
for i=1:m1
    for j=1:n1
        p=watermark(1+k*(i-1):i*k,1+k*(j-1):j*k);
        [U, S, V]=svd(p);
%         r=4;
        lemda1=S(1,1);
        lemda2=S(2,2);
        lemda3=S(3,3);
        lemda4=S(4,4);
        Yi=[lemda1 lemda2 lemda3 lemda4];
        sumlemda=(lemda1^2)+(lemda2^2)+(lemda3^2)+(lemda4^2);
        NormYi=sqrt(sumlemda);
        N=floor(NormYi/delta);
        if mod(N,2)==0
            water(i,j)=1;
        else
            water(i,j)=0;
        end
    end
end
water=water.*255;
watermark=uint8(water);
[PSNR,MSE] = psnr_mse_maxerr(imresize(s,[size(watermark,1) size(watermark,2)]),im2bw(watermark));
        
end
load('arnod.mat')
axes(handles.axes4);
imshow(im2bw(watermark));

set(handles.edit1,'String',num2str(PSNR));
set(handles.edit2,'String',num2str(MSE));
toc
guidata(hObject, handles);

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
