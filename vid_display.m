function varargout = vid_display(varargin)
% VID_DISPLAY MATLAB code for vid_display.fig
%      VID_DISPLAY, by itself, creates a new VID_DISPLAY or raises the existing
%      singleton*.
%
%      H = VID_DISPLAY returns the handle to a new VID_DISPLAY or the handle to
%      the existing singleton*.
%
%      VID_DISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VID_DISPLAY.M with the given input arguments.
%
%      VID_DISPLAY('Property','Value',...) creates a new VID_DISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vid_display_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vid_display_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vid_display

% Last Modified by GUIDE v2.5 20-Apr-2019 16:46:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vid_display_OpeningFcn, ...
                   'gui_OutputFcn',  @vid_display_OutputFcn, ...
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


% --- Executes just before vid_display is made visible.
function vid_display_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vid_display (see VARARGIN)

% Choose default command line output for vid_display
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vid_display wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vid_display_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in file_select.
function file_select_Callback(hObject, eventdata, handles)
% hObject    handle to file_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fname = uigetfile({'*.tif','*.tiff'},'File Selector');
info = imfinfo(fname);
num_img = numel(info);
[n,m] = size(imread(fname,1));

zfishRe = zeros(m,n,num_img);

for k = 1:num_img
    
      zfishRe(:,:,k) = imread(fname, k);
      
end  

zfishRe = uint8(zfishRe);
zfishRe = imcomplement(zfishRe);



% Use a user defined function to go through pixel by pixel
% this function will define each pixel based on it relative coloring
% function name par_fil
zfishI = part_fil(zfishRe);

% function for zebra fish identity
SE=strel('square',6);

dilated_im = imdilate(zfishI, SE);

zfish_iso = bwareaopen(dilated_im, 7);

zfishRe = imcomplement(zfishRe);

handles.dilate = zfish_iso;

handles.filt = zfishI;

handles.orig = zfishRe;

guidata(hObject, handles);


% --- Executes on selection change in type_select.
function type_select_Callback(hObject, eventdata, handles)
% hObject    handle to type_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns type_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from type_select
contents = cellstr(get(hObject,'String'));
switch contents{get(hObject,'Value')}
    case 'Original Video'
        handles.plot = 1;
    case 'Filtered Video'
        handles.plot = 2;
    case 'Dilated Video'
        handles.plot = 3;
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function type_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch handles.plot
    case 1
        zfish_track(handles.dilate,handles.orig)
    case 2
        zfish_track2(handles.dilate,handles.filt)
    case 3
        zfish_track3(handles.dilate)
end
guidata(hObject,handles);
        
