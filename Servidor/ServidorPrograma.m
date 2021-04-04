function varargout = ServidorPrograma(varargin)
% SERVIDORPROGRAMA MATLAB code for ServidorPrograma.fig
%      SERVIDORPROGRAMA, by itself, creates a new SERVIDORPROGRAMA or raises the existing
%      singleton*.
%
%      H = SERVIDORPROGRAMA returns the handle to a new SERVIDORPROGRAMA or the handle to
%      the existing singleton*.
%
%      SERVIDORPROGRAMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SERVIDORPROGRAMA.M with the given input arguments.
%
%      SERVIDORPROGRAMA('Property','Value',...) creates a new SERVIDORPROGRAMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ServidorPrograma_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ServidorPrograma_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ServidorPrograma

% Last Modified by GUIDE v2.5 03-Aug-2018 18:54:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ServidorPrograma_OpeningFcn, ...
                   'gui_OutputFcn',  @ServidorPrograma_OutputFcn, ...
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


% --- Executes just before ServidorPrograma is made visible.
function ServidorPrograma_OpeningFcn(hObject, eventdata, handles, varargin)
global tcpipServer;
global opcionDatosx;
global opcionDatosy;
opcionDatosx=0;
opcionDatosy=0;
s=25
disp ('Inicializacion Servidor');
global direccionCliente;
direccionCliente='0.0.0.0';
tcpipServer = tcpip(direccionCliente,55000,'NetworkRole','Server');
set(tcpipServer,'OutputBufferSize',s);
fopen(tcpipServer);
estadoConexion=0;
estadoConexion = fread(tcpipServer,1,'double');
if(estadoConexion==0)
set(handles.txtConexion,'string','Sin Conexion')
end
if(estadoConexion==100)
set(handles.txtConexion,'string','Conexion Confiable')
end
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ServidorPrograma (see VARARGIN)

% Choose default command line output for ServidorPrograma
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ServidorPrograma wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ServidorPrograma_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnAbrir.
function btnAbrir_Callback(hObject, eventdata, handles)
global tamanioArchivoOriginal;
global data;
global opcionDatos;
global opcionDatosx;
global opcionDatosy;
global y;
global Fs;
global nombre;
opcionDatos=0;

if(opcionDatosx==0)
opcionDatos=opcionDatosy;
end
if(opcionDatosy==0)
opcionDatos=opcionDatosx;
end


if (opcionDatos==20)
[nombre dire]=uigetfile('*.jpg','Abrir');
if nombre == 0
    return
end
global imagen;
imagen=imread(fullfile(dire,nombre));
global NombreArchivoEnviado;
NombreArchivoEnviado=nombre;
[M,N]=size(imagen);
tamanioArchivoOriginal=M*N;
%axes(handles.Pantalla);
imshow(imagen);
data = imagen;
end
if (opcionDatos==10)
    [nombre dire]=uigetfile('*.wav','Abrir');
    if nombre == 0
    return
    end
%audio=imread(fullfile(dire,nombre));
global player;
[y,Fs] = audioread(nombre);
player=audioplayer(y,Fs);
imagen2=imread('imagenAudio.png');
imshow(imagen2);
 %audio=audioread(fullfile(dire,nombre)); 
end
if (opcionDatos==0)
   msgbox('Error, no ha seleccionado el tipo de archivo, proceda a seleccionar'); 
end
% hObject    handle to btnAbrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
global opcionDatosx;
if(opcionDatosx==0)
opcionDatosx=10;
elseif(opcionDatosx==10)
opcionDatosx=0;
end
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
global opcionDatosy;
if(opcionDatosy==0)
opcionDatosy=20;
elseif(opcionDatosy==20)
opcionDatosy=0;
end
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
global opcionDatosz;
if(opcionDatosz==0)
opcionDatosz=30;
elseif(opcionDatosz==30)
opcionDatosz=0;
end
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global y;
global Fs;
global player;
play(player);

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global y;
global Fs;
global player;
pause(player);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global tamanioArchivoOriginal;
global tcpipServer;
global data;
global opcionDatos;
if(opcionDatos==0)
    disp('El tamano Original del Archivo; ');
    %tamanioArchivoOriginal
    disp('El tamano Comprimido del Archivo a enviar es; ');
    %tamanioArchivoComprimido
    %fwrite(tcpipServer,opcionDatos,'double');
    %fwrite(tcpipServer,data(:),'double');
end
if(opcionDatos==20)
    %envio imagen
    global imagen;
    
    fwrite(tcpipServer,opcionDatos,'double');
    
    %PArte de compresion con la transformada WAVELET
    XD=im2double(imagen);
    [cA,cH,cV,cD] = dwt2(XD,'db4');
    %**************************************************
    %[r,c]=size(imagen); cambio imagen por cA
    [r,c]=size(cA);
    B=reshape(cA,1,[]);
    fwrite(tcpipServer,r,'double');
    %pause (5);
    fwrite(tcpipServer,c,'double');
    %global m2;
    %m2=fread(tcpipServer,4,'int');
    %if(m2==100)
     %   msgbox('Mensaje confirmado');
    %end
    disp('El tamano Original del Archivo; ');
    %tamanioArchivoOriginal
    disp('El tamano Comprimido del Archivo a enviar es; ');
    %tamanioArchivoComprimido=B.bytes;
    %tamanioArchivoComprimido
    fclose(tcpipServer);
    s=r*c*8;
    set(tcpipServer,'OutputBufferSize',s);
    fopen(tcpipServer);
    
    
    %fwrite(tcpipServer,data(:),'double');
    %fwrite(tcpipServer,B,'uint8');
    fwrite(tcpipServer,B,'double');
    %disp('B : ');
    %ListBoxElementos
    global NombreArchivoEnviado;
    set(handles.ListBoxElementos,'String',NombreArchivoEnviado);
    
end
if(opcionDatos==10)
    %envio mp3
    global y;
    global Fs;
    y2=y;
    XD=im2double(y2);
    [r,c]=size(XD);
    [cA,cH,cV,cD] = dwt2(XD,'db4');
    r2=r/2;
    %imagenN=reshape(B,r2,4);
    %XR1 = idwt2(cA,cH,cV,cD,'db4');
    %sound(y,Fs);
    
    [r,c]=size(y);
    MusicEnviar=reshape(y,1,[]);
      fwrite(tcpipServer,opcionDatos,'double');
    fwrite(tcpipServer,r,'double');
    fwrite(tcpipServer,c,'double');
    fwrite(tcpipServer,Fs,'double');
    fclose(tcpipServer);
    s=r*c*8;
    set(tcpipServer,'OutputBufferSize',s);
    fopen(tcpipServer);
    
    fwrite(tcpipServer,MusicEnviar,'double');
    
end
if(opcionDatos==30)
   %Envio Un Archivo 
end
% hObject    handle to pushbutton4 (see GCBO)
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


% --- Executes on selection change in ListBoxElementos.
function ListBoxElementos_Callback(hObject, eventdata, handles)
% hObject    handle to ListBoxElementos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListBoxElementos contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListBoxElementos


% --- Executes during object creation, after setting all properties.
function ListBoxElementos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListBoxElementos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
