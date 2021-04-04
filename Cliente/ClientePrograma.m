function varargout = ClientePrograma(varargin)
% CLIENTEPROGRAMA MATLAB code for ClientePrograma.fig
%      CLIENTEPROGRAMA, by itself, creates a new CLIENTEPROGRAMA or raises the existing
%      singleton*.
%
%      H = CLIENTEPROGRAMA returns the handle to a new CLIENTEPROGRAMA or the handle to
%      the existing singleton*.
%
%      CLIENTEPROGRAMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLIENTEPROGRAMA.M with the given input arguments.
%
%      CLIENTEPROGRAMA('Property','Value',...) creates a new CLIENTEPROGRAMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ClientePrograma_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ClientePrograma_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ClientePrograma

% Last Modified by GUIDE v2.5 04-Aug-2018 14:11:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ClientePrograma_OpeningFcn, ...
                   'gui_OutputFcn',  @ClientePrograma_OutputFcn, ...
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


% --- Executes just before ClientePrograma is made visible.
function ClientePrograma_OpeningFcn(hObject, eventdata, handles, varargin)
global tcpipClient;
global estadoConexion;
estadoConexion=2211;
disp ('Inicializacion del cliente');
disp ('Validacion del la conexion atenticada');
global direccionServidor;
direccionServidor='127.0.0.1';
%direccionServidor='192.168.10.3';
tcpipClient = tcpip(direccionServidor,55000,'NetworkRole','Client');
s=25;
set(tcpipClient,'InputBufferSize',s);
set(tcpipClient,'Timeout',30);
fopen(tcpipClient);
valorconexion=100
fwrite(tcpipClient,valorconexion,'double');
set(handles.txtConexion,'string','Conexion COnfiable');

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ClientePrograma (see VARARGIN)

% Choose default command line output for ClientePrograma
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ClientePrograma wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ClientePrograma_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnconectar.
function btnconectar_Callback(hObject, eventdata, handles)
global estadoConexion;
if(estadoConexion==2211)
disp (' Estado de recepcion de archivo');
global tcpipClient;
    %tcpipClient = tcpip('127.0.0.1',55000,'NetworkRole','Client');
    %s=25;
    %set(tcpipClient,'InputBufferSize',s);
    %set(tcpipClient,'Timeout',30);
    %fopen(tcpipClient);
%global m1;
%m1 = fread(tcpipClient,4,'int');
%fwrite(tcpipClient,m1,'int');

% Se procede a hacer una categorizacion del tipo de archivo a recibir
global opcionDatos;
opcionDatosRx = fread(tcpipClient,1,'double');
opcionDatos=double(opcionDatosRx);
if(opcionDatos==20)
    set(handles.txtTipoArchivo,'string',' Archivo Recibido : IMAGEN');
    %El valor de 20 indica q es una imagen
r = fread(tcpipClient,1,'double');
disp('R recibido');
r
c = fread(tcpipClient,1,'double');
disp('C recibido');
c
fclose(tcpipClient);
s=800000;
disp('tamanio recibir bytes');
zimg=r*c*8;
zimg2=r*c;
zimg=zimg+10;
set(tcpipClient,'InputBufferSize',zimg);
set(tcpipClient,'Timeout',30);
fopen(tcpipClient);
rawData = fread(tcpipClient,zimg2,'double');
%fclose(tcpipClient);
%axes(handles.Pantalla);

B=rawData';
r2=c/3;
%BA=B(2:750000)
reshapedData = reshape(B,[r,r2,3]);

H=reshapedData*0;
V=reshapedData*0;
D=reshapedData*0;
XR1 = idwt2(reshapedData,H,V,D,'db4');

%CA=uint8(reshapedData);
%CA=uint8(XR1);



%XD=im2double(reshapedData);
%[cA,cH,cV,cD] = dwt2(XD,'db4');
%B(1:100)
%surf(reshapedData);
%imshow(reshapedData);
%imagesc(CA);
global datosRecividos;
datosRecividos=XR1;
imshow(XR1);
end
if(opcionDatos==10)
    set(handles.txtTipoArchivo,'string',' Archivo Recibido : AUDIO');
    imagen2=imread('imagenAudio.png');
    imshow(imagen2);
    r = fread(tcpipClient,1,'double');
    c = fread(tcpipClient,1,'double');
    global Fs;
    Fs = fread(tcpipClient,1,'double');
    
    fclose(tcpipClient);
    
    disp('tamanio recibir bytes');
    zimg=r*c*8;
    zimg2=r*c;
    set(tcpipClient,'InputBufferSize',zimg);
    set(tcpipClient,'Timeout',30);
    fopen(tcpipClient);
    MusicRx = fread(tcpipClient,zimg2,'double');
    %fclose(tcpipClient);
    global z;
    z=reshape(MusicRx,[r,c]);
    sound(z,Fs);
    % Espero recibir un audio
end
if(opcionDatos==0)
    set(handles.txtTipoArchivo,'string',' Archivo Recibido : FUNCION');
    Mensaje = fread(tcpipClient,zimg2,'string');
    set(handles.listboxMensajes,Mensaje);
end
end
if(estadoConexion==10)
   msgbox(' Error .... No se ha establecido una conexion'); 
    
end
% hObject    handle to btnconectar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
imagen=imread('imagenPortada.jpg');
imshow(imagen);
disp('Hola.... Bienvenido Cliente');
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in btnGuardar.
function btnGuardar_Callback(hObject, eventdata, handles)
global datosRecividos;
global opcionDatos;
global z;
global Fs;
if(opcionDatos==20)
%nombreArchivo = get(handles.txtNombre,'String')
%saveas(datosRecividos,nombreArchivo,'jpg');
%imwrite(datosRecividos,nombreArchivo,'jpg');
formatos = {'*.jpg','JPEG (*.jpg)';'*.tif','TIFF (*.tif)'};
[nomb,ruta] = uiputfile(formatos,'GUARDAR IMAGEN');
if nomb==0, return, end
fName = fullfile(ruta,nomb);
imwrite(datosRecividos,fName);
elseif(opcionDatos==10)
%nombreArchivo = get(handles.txtNombre,'String');
formatos = {'*.wav'};
[nomb,ruta] = uiputfile(formatos,'GUARDAR IMAGEN');
audiowrite(nomb,z,Fs);
end





% hObject    handle to btnGuardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txtNombre_Callback(hObject, eventdata, handles)
% hObject    handle to txtNombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtNombre as text
%        str2double(get(hObject,'String')) returns contents of txtNombre as a double


% --- Executes during object creation, after setting all properties.
function txtNombre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
