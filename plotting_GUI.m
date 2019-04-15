function varargout = plotting_GUI(varargin)
% PLOTTING_GUI MATLAB code for plotting_GUI.fig
%      PLOTTING_GUI, by itself, creates a new PLOTTING_GUI or raises the existing
%      singleton*.
%
%      H = PLOTTING_GUI returns the handle to a new PLOTTING_GUI or the handle to
%      the existing singleton*.
%
%      PLOTTING_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTTING_GUI.M with the given input arguments.
%
%      PLOTTING_GUI('Property','Value',...) creates a new PLOTTING_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotting_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotting_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotting_GUI

% Last Modified by GUIDE v2.5 15-Apr-2019 17:14:51
% ORIGINAL ZFISH_DRIVER CODE
% Read in .tif file
% read in with a for loop
% 396 frames in file
% input('File name', 's')
fname = 'Startle1.tif';
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

% for i = 1:num_img
%     imshow(zfishI(:,:,i));
% end 
% function for zebra fish identity
SE=strel('square',6);

dilated_im= imdilate(zfishI, SE);

zfish_iso=bwareaopen(dilated_im, 7);

zfishRe = imcomplement(zfishRe);

zfish_track(zfish_iso,zfishRe)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotting_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @plotting_GUI_OutputFcn, ...
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


% --- Executes just before plotting_GUI is made visible.
function plotting_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotting_GUI (see VARARGIN)

% Choose default command line output for plotting_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plotting_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotting_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clf 


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot(zfishRe,zfishI);
