function varargout = UI(varargin)
% UI MATLAB code for UI.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UI

% Last Modified by GUIDE v2.5 27-Apr-2016 12:30:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UI_OpeningFcn, ...
                   'gui_OutputFcn',  @UI_OutputFcn, ...
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


% --- Executes just before UI is made visible.
function UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI (see VARARGIN)

% Choose default command line output for UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function input_filename_Callback(hObject, eventdata, handles)


function input_filename_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton1_Callback(hObject, eventdata, handles)
filename=get(handles.input_filename,'String')
filepath=['01/',filename]
img=imread(filepath)
[featureVector,I,img_cut,add,polar_array,J,gaborArrayout]=test_gamma(img);
axes(handles.gamma);
imshow(adjgamma(I,0.3));
axes(handles.original_pic);
imshow(img);
title('原图')
pline_x_out=add{1};
pline_y_out=add{2};
pline_x_in=add{3};
pline_y_in=add{4};

axes(handles.extraction);
imshow(img);
title('霍夫变换定位两个圆')
hold on;

plot(pline_y_in,pline_x_in,'-w');
hold on;
plot(pline_y_out,pline_x_out,'-w');
 
axes(handles.cut);
imshow(img_cut);
title('截取圆环')

axes(handles.normalization);
imshow(polar_array);
title('归一化')

axes(handles.enhence);
imshow(J);
title('图像增强')
out1=load('DB.mat'); %out定义为全局变量用来调用变量空间中的东西;
out=out1.out;
same_name=[];
ouput_same_name=[];
for i=1:296
    if norm(out{2,i}-featureVector)/200-1<0;
        same_name=[same_name,out{1,i}]
        ouput_same_name=[ouput_same_name,' ',out{1,i}]
    end
end
set(handles.result_text,'string',ouput_same_name);
