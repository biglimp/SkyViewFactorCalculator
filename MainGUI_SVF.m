function varargout = MainGUI_SVF(varargin)
% MAINGUI_SVF M-file for MainGUI_SVF.fig
% Version 1.2
% Updates made: imageformats changed
% Bugfix of annuli part 20120517
%      MAINGUI_SVF, by itself, creates a new MAINGUI_SVF or raises the existing
%      singleton*.
%
%      H = MAINGUI_SVF returns the handle to a new MAINGUI_SVF or the handle to
%      the existing singleton*.
%
%      MAINGUI_SVF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI_SVF.M with the given input arguments.
%
%      MAINGUI_SVF('Property','Value',...) creates a new MAINGUI_SVF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainGUI_SVF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainGUI_SVF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainGUI_SVF

% Last Modified by GUIDE v2.5 09-Jun-2011 16:32:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MainGUI_SVF_OpeningFcn, ...
    'gui_OutputFcn',  @MainGUI_SVF_OutputFcn, ...
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


% --- Executes just before MainGUI_SVF is made visible.
function MainGUI_SVF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainGUI_SVF (see VARARGIN)

% Choose default command line output for MainGUI_SVF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainGUI_SVF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainGUI_SVF_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_loadimage.
function pushbutton_loadimage_Callback(hObject, eventdata, handles)

if get(handles.checkbox_multiple,'Value')==1
    set(handles.pushbutton_radius,'Enable','on')
    set(handles.slider2,'Enable','on')
    set(handles.text1,'Enable','on')
else
    set(handles.pushbutton_radius,'Enable','off')
    set(handles.slider2,'Enable','off')
    set(handles.text1,'Enable','off')
end

set(handles.pushbutton_fill,'Enable','off')
set(handles.pushbutton_svf,'Enable','off')
[inputfile directory]=uigetfile({'*.jpg;*.png;*.gif;*.tif;*.pgm'},'Select image file');
set(handles.filename,'String',inputfile)
if inputfile==0
else
    data=importdata([directory inputfile]);
    % I=imread([directory inputfile]);
    imagesc(data,'parent',handles.axes1);
    set(handles.axes1,'Visible','off')
    axis image
    set(handles.pushbutton_loadimage,'UserData',data);
    guidata(hObject, handles);
    if isempty(data)
    else
        set(handles.pushbutton_radius,'Enable','on')
    end
    set(handles.text_svf,'String','');
end

% --- Executes on button press in checkbox_multiple.
function checkbox_multiple_Callback(hObject, eventdata, handles)

get(hObject,'Value');
guidata(hObject, handles);

% --- Executes on button press in pushbutton_radius.
function pushbutton_radius_Callback(hObject, eventdata, handles)

camradie=str2double(get(handles.edit_camera,'String'));
data=get(handles.pushbutton_loadimage,'UserData');
imagesc(data,'parent',handles.axes1);
set(handles.axes1,'Visible','off')
axis image
hold on
point=0;posx=[];posy=[];
while point~=3
    [x,y]=ginput(1);
    y=floor(y);x=floor(x);
    plot(x,y,'r +');
    point=point+1;
    posx(point)=x;
    posy(point)=y;
end

% Calculate radius and centre
A=posx(1)^2-posx(2)^2+posy(1)^2-posy(2)^2;
B=2*(posx(2)-posx(1));
C=2*(posy(2)-posy(1));
D=posx(2)^2-posx(3)^2+posy(2)^2-posy(3)^2;
E=2*(posx(3)-posx(2));
F=2*(posy(3)-posy(2));
centerX=(D/F-A/C)/(B/C-E/F);
centerY=(D/E-A/B)/(C/B-F/E);
radie2(1)=sqrt((posx(1)-centerX)^2+(posy(1)-centerY)^2);
radie2(2)=sqrt((posx(2)-centerX)^2+(posy(2)-centerY)^2);
radie2(3)=sqrt((posx(3)-centerX)^2+(posy(3)-centerY)^2);
radie=mean(radie2);
radie=radie*(180/camradie);% correction for camera field of view

plot(centerX,centerY,'r *');
pause(1)
hold off

posdata=[centerX centerY radie];
set(handles.pushbutton_radius,'UserData',posdata);
guidata(hObject, handles);
set(handles.slider2,'Enable','on')
set(handles.text1,'Enable','on')
BW = im2bw(data, 0.5);
imagesc(BW),axis image,colormap(gray)
set(handles.axes1,'Visible','off')

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)

data=get(handles.pushbutton_loadimage,'UserData');
tres=get(hObject,'Value');
BW = im2bw(data, tres);
imagesc(BW),axis image,colormap(gray)
set(handles.axes1,'Visible','off')
set(handles.pushbutton_fill,'UserData',BW);
guidata(hObject, handles);
set(handles.pushbutton_fill,'Enable','on')
set(handles.pushbutton_svf,'Enable','on')

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pushbutton_fill.
function pushbutton_fill_Callback(hObject, eventdata, handles)

BW=get(handles.pushbutton_fill,'UserData');
BW=double(BW);
J=roipoly(BW);
J=J*-1+1;
BW=BW.*J;
imagesc(BW),axis image,colormap(gray)
set(handles.axes1,'Visible','off')
set(handles.pushbutton_fill,'UserData',BW);
guidata(hObject, handles);

function edit_camera_Callback(hObject, eventdata, handles)

get(hObject,'String');
% set(hObject,'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_camera_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Textfile.
function Textfile_Callback(hObject, eventdata, handles)

get(hObject,'Value');
guidata(hObject, handles);

% --- Executes on button press in pushbutton_svf.
function pushbutton_svf_Callback(hObject, eventdata, handles)

BW=get(handles.pushbutton_fill,'UserData');
posdata=get(handles.pushbutton_radius,'UserData');
centerX=posdata(1);
centerY=posdata(2);
radie=posdata(3);

%%%%% Pixel version %%%%%
weightmap=BW*0;
for i=1:size(BW,2)%columns
    for j=1:size(BW,1)%rows
        a=i-centerX;%i
        b=j-centerY;%j
        c=sqrt(a^2+b^2);
            weight=1/(2*pi*c)*sin(pi/(2*radie))*sin(pi*(2*c-1)/(2*radie));%*vf;
            weightmap(j,i)=weight;
    end
end
svfimage=weightmap.*BW;
svf=sum(svfimage(:));

%%%% Annuli version %%%%%
% figure
% imagesc(BW),colormap(gray),axis image,hold on
svf2=0;ring=1;
for i=1:2:89 % annuli
    annulusdist=round((i/90)*radie);
    skyangle=0;
    for j=0:5:359 % azimuths
        xdelta=sin(j*(pi/180))*annulusdist;
        ydelta=cos(j*(pi/180))*annulusdist;
        x=round(centerX+xdelta);
        y=round(centerY+ydelta);
        if y<=0, y=1;end 
        if y>size(BW,1), y=size(BW,1);end
        if x<=0, x=1;end
        if x>size(BW,2), x=size(BW,2);end
        skyangle=BW(y,x)+skyangle;
%         plot(x,y,'k.','MarkerSize',4)
    end
    skyangle=(skyangle*5)*pi/180;
    svf2=((1/(2*pi))*sin(pi/(2*44))*sin((pi*(2*ring-1))/(2*44))*skyangle)+svf2;
    ring=ring+1;
end

svftext=num2str(svf,3);
svftext2=num2str(svf2,3);

set(handles.text_svf,'String',svftext);
set(handles.text_svf2,'String',svftext2);

% writing to textfile
writefile=get(handles.Textfile,'Value');
if writefile==1
    if exist('SVF_results.txt','file')==0
        fn2=fopen('SVF_results.txt','a');
        fprintf(fn2,'%6s','Filename SVFpixel SVFAnnulus');
        fprintf(fn2,'\r\n');
        fclose(fn2);
    end
    fn2=fopen('SVF_results.txt','a');
    filename=get(handles.filename,'String');
    fprintf(fn2,'%6s',filename);
    fprintf(fn2,'%1s',' ');
    fprintf(fn2,'%5s ',[svftext,' ', svftext2]);
    fprintf(fn2,'\r\n');
    fclose(fn2);
end

guidata(hObject, handles);

% Menu options
% ----------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open([pwd '\SkyViewFactorCalculator-User manual.pdf'])

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
about()

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
