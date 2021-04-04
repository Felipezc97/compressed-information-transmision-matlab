function varargout = ServidorLOGIN(varargin)
% SERVIDORLOGIN MATLAB code for ServidorLOGIN.fig
%      SERVIDORLOGIN, by itself, creates a new SERVIDORLOGIN or raises the existing
%      singleton*.
%
%      H = SERVIDORLOGIN returns the handle to a new SERVIDORLOGIN or the handle to
%      the existing singleton*.
%
%      SERVIDORLOGIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SERVIDORLOGIN.M with the given input arguments.
%
%      SERVIDORLOGIN('Property','Value',...) creates a new SERVIDORLOGIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ServidorLOGIN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ServidorLOGIN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ServidorLOGIN

% Last Modified by GUIDE v2.5 03-Aug-2018 17:00:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ServidorLOGIN_OpeningFcn, ...
                   'gui_OutputFcn',  @ServidorLOGIN_OutputFcn, ...
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


% --- Executes just before ServidorLOGIN is made visible.
function ServidorLOGIN_OpeningFcn(hObject, eventdata, handles, varargin)
imagen=imread('imagenPortadaInicio02.png');
imshow(imagen);
disp('Hola.... Bienvenido Servidor');

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ServidorLOGIN (see VARARGIN)

% Choose default command line output for ServidorLOGIN
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ServidorLOGIN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ServidorLOGIN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)

% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
msgbox('1234');
global estadoConexion;
disp ('Inicializacion del cliente');
disp ('Validacion del la conexion atenticada');
%global tcpipClient;
global tcpipServer;
%direccionCliente='192.168.10.2';
global direccionCliente;
%direccion para permitir la conexion de cualquier cliente
direccionCliente='0.0.0.0';
%tcpipClient = tcpip(direccionCliente,55000,'NetworkRole','Client');
tcpipServer=tcpip(direccionCliente,55000,'NetworkRole','Server');
s=257;
%set(tcpipClient,'InputBufferSize',s);
%set(tcpipClient,'Timeout',30);
%fopen(tcpipClient);
set(tcpipServer,'InputBufferSize',s);
fopen(tcpipServer);

r = fread(tcpipServer,1,'double');
disp('User recibido');
r
c = fread(tcpipServer,1,'double');
disp('Password recibido');
hash=fread(tcpipServer,32,'double');
hashRx=DataHash(c);
valorDouble=double(hashRx)
hash'
if(hash'==valorDouble)
disp('Firma Digital autenticada');
else
disp('No se ha autenticado al cliente');
end
%fclose(tcpipClient);
ackConfirmacion=0;
if(r==1001)
ackConfirmacion=20;
end
if(c==1234)
ackConfirmacion=ackConfirmacion+20;
end

if(ackConfirmacion==40)
%msgbox(' El Usuario remoto se ha auntenticado correctamente......');
ackRetorno=2211;
fwrite(tcpipServer,ackRetorno,'double');
set(handles.txtConexion,'string','Conexion Confiable');
fclose(tcpipServer);
%open('ServidorPrograma.fig');
ServidorPrograma();
estadoConexion=2211;
%fclose(tcpipClient);
delete(hObject); 
end
if(ackConfirmacion==20)
msgbox(' Error, el usuario remoto no se ha auntenticado correctamente');
ackRetorno=10;
fwrite(tcpipServer,ackRetorno,'double');
fclose(tcpipServer);
set(handles.txtConexion,'string','Conexion Fallida');
estadoConexion=10;
end
if(ackConfirmacion==0)
msgbox(' Error, el usuario remoto no se ha auntenticado correctamente');
ackRetorno=10;
fwrite(tcpipServer,ackRetorno,'double');
fclose(tcpipServer);
set(handles.txtConexion,'string','Conexion Fallida');
estadoConexion=10;
end
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
