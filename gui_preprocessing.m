function varargout = gui_preprocessing(varargin)
% GUI_PREPROCESSING MATLAB code for gui_preprocessing.fig
%      GUI_PREPROCESSING, by itself, creates a new GUI_PREPROCESSING or raises the existing
% %      singleton*.
%
%      H = GUI_PREPROCESSING returns the handle to a new GUI_PREPROCESSING or the handle to
%      the existing singleton*.
%
%      GUI_PREPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function1 named CALLBACK in GUI_PREPROCESSING.M with the given input arguments.
%
%      GUI_PREPROCESSING('Property','Value',...) creates a new GUI_PREPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_preprocessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_preprocessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_preprocessing

% Last Modified by GUIDE v2.5 28-Apr-2018 21:13:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_preprocessing_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_preprocessing_OutputFcn, ...
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


% --- Executes just before gui_preprocessing is made visible.
function gui_preprocessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_preprocessing (see VARARGIN)

% Choose default command line output for gui_preprocessing
handles.output = hObject;
%Initializing axes to empty
blank = ones(200,200);
axes(handles.axes1);
imshow(blank);
axes(handles.axes2);
imshow(blank);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_preprocessing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_preprocessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadimage.
function loadimage_Callback(hObject, eventdata, handles)
% hObject    handle to loadimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.jpg;*.png;*.bmp','Pick a MRI Image');
if isequal(FileName,0)||isequal(PathName,0)
    warndlg('User Press Cancel');
else
    image = imread([PathName,FileName]);
    image = imresize(image,[200,200]);
    axes(handles.axes1);
    imshow(image); 
  %title('Brain MRI Image');
  handles.ImgData = image;
  guidata(hObject,handles);
end
% --- Executes on button press in Classify.
function Classify_Callback(hObject, eventdata, handles)
% hObject    handle to Classify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'ImgData')
    img = handles.ImgData;
    img2=preprocess(img);
    features=calculatefeatures(img2);
    % subpixel edge detection
    % axes(handles.axes2)
    threshold = 1;
    edges = subpixelEdges(img2, threshold, 'SmoothingIter', 0); 
    % show edges   
    axes(handles.axes2)
    imshow(img2/255,'InitialMagnification', 'fit');
    visEdges(edges);
    axes(handles.axes2)
    species=classifier(features);
    display(features);
    display(species);
    set(handles.edit,'string',species);
end



function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit as text
%        str2double(get(hObject,'String')) returns contents of edit as a double


% --- Executes during object creation, after setting all properties.
function edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COx`   MPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
