function varargout = SkyViewFactorCalculator(varargin)
% SKYVIEWFACTORCALCULATOR M-file for SkyViewFactorCalculator.fig
%      SKYVIEWFACTORCALCULATOR, by itself, creates a new SKYVIEWFACTORCALCULATOR or raises the existing
%      singleton*.
%
%      H = SKYVIEWFACTORCALCULATOR returns the handle to a new SKYVIEWFACTORCALCULATOR or the handle to
%      the existing singleton*.
%
%      SKYVIEWFACTORCALCULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SKYVIEWFACTORCALCULATOR.M with the given input arguments.
%
%      SKYVIEWFACTORCALCULATOR('Property','Value',...) creates a new SKYVIEWFACTORCALCULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SkyViewFactorCalculator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SkyViewFactorCalculator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SkyViewFactorCalculator

% Last Modified by GUIDE v2.5 09-Jun-2011 20:05:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SkyViewFactorCalculator_OpeningFcn, ...
                   'gui_OutputFcn',  @SkyViewFactorCalculator_OutputFcn, ...
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


% --- Executes just before SkyViewFactorCalculator is made visible.
function SkyViewFactorCalculator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SkyViewFactorCalculator (see VARARGIN)

% Choose default command line output for SkyViewFactorCalculator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SkyViewFactorCalculator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SkyViewFactorCalculator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_close.
function pushbutton_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
MainGUI_SVF()
