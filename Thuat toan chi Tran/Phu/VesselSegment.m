function varargout = VesselSegment(varargin)
% VESSELSEGMENT MATLAB code for VesselSegment.fig
%      VESSELSEGMENT, by itself, creates a new VESSELSEGMENT or raises the existing
%      singleton*.
%
%      H = VESSELSEGMENT returns the handle to a new VESSELSEGMENT or the handle to
%      the existing singleton*.
%
%      VESSELSEGMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VESSELSEGMENT.M with the given input arguments.
%
%      VESSELSEGMENT('Property','Value',...) creates a new VESSELSEGMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VesselSegment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VesselSegment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VesselSegment

% Last Modified by GUIDE v2.5 10-Jan-2015 01:52:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VesselSegment_OpeningFcn, ...
                   'gui_OutputFcn',  @VesselSegment_OutputFcn, ...
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


% --- Executes just before VesselSegment is made visible.
function VesselSegment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VesselSegment (see VARARGIN)

% Choose default command line output for VesselSegment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.icon);
imshow('images/huyetapcao.png');
axis off;
axes(handles.author1);
imshow('images/author.png');
axis off;
axes(handles.author2);
imshow('images/author.png');
axis off;
axes(handles.vessel);
axis off;



% UIWAIT makes VesselSegment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VesselSegment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile({'*.bmp;*.gif;*.jpg;*.png'},'pick an image file');
 link = strcat(path,name);
 if(isempty(link))
     return;
 end
 img = imread(link);
 axes(handles.vessel);
 imshow(img,[]);
 axis off;
set(handles.link,'String',link);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
link = get(handles.link,'String');
cla(handles.vessel,'reset');
axes(handles.vessel);
processing(link);
% processing2(link);
axis off;
