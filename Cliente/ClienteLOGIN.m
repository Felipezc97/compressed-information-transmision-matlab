function varargout = ClienteLOGIN(varargin)
% CLIENTELOGIN MATLAB code for ClienteLOGIN.fig
%      CLIENTELOGIN, by itself, creates a new CLIENTELOGIN or raises the existing
%      singleton*.
%
%      H = CLIENTELOGIN returns the handle to a new CLIENTELOGIN or the handle to
%      the existing singleton*.
%
%      CLIENTELOGIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLIENTELOGIN.M with the given input arguments.
%
%      CLIENTELOGIN('Property','Value',...) creates a new CLIENTELOGIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ClienteLOGIN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ClienteLOGIN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ClienteLOGIN

% Last Modified by GUIDE v2.5 03-Aug-2018 17:54:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ClienteLOGIN_OpeningFcn, ...
                   'gui_OutputFcn',  @ClienteLOGIN_OutputFcn, ...
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


% --- Executes just before ClienteLOGIN is made visible.
function ClienteLOGIN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ClienteLOGIN (see VARARGIN)

% Choose default command line output for ClienteLOGIN
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ClienteLOGIN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ClienteLOGIN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
imagen=imread('imagenPortadaInicio02.png');
imshow(imagen);
disp('Hola.... Bienvenido Servidor');
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function txtboxUser_Callback(hObject, eventdata, handles)
% hObject    handle to txtboxUser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtboxUser as text
%        str2double(get(hObject,'String')) returns contents of txtboxUser as a double


% --- Executes during object creation, after setting all properties.
function txtboxUser_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtboxUser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtboxPassword_Callback(hObject, eventdata, handles)
% hObject    handle to txtboxPassword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtboxPassword as text
%        str2double(get(hObject,'String')) returns contents of txtboxPassword as a double


% --- Executes during object creation, after setting all properties.
function txtboxPassword_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtboxPassword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnConectarLogin.
function btnConectarLogin_Callback(hObject, eventdata, handles)
global dataUser;
global dataPassword;
errorUserPassword=0;
dataUser = get(handles.txtboxUser,'String');
dataPassword = get(handles.txtboxPassword,'String');
 if isempty(dataUser)
   fprintf('Error: Enter Text first\n');
   errorUserPassword=10;
 else
   % Write code for computation you want to do 
 end
 if isempty(dataPassword)
   fprintf('Error: Enter Text first\n');
   errorUserPassword=10;
 else
   % Write code for computation you want to do 
 end

if(errorUserPassword==0)
%controlada la exepcion de campos vacios, procedemos a enviar el user y
%password para hacer la autenticacion
global opcionDatos;
opcionDatos = 0;
s1 = whos('dataUser');
s2 = whos('dataPassword');
%seteamos la varable s con 4Mbytes para el tamaño del buffer
s=25;
disp ('Inicializacion Servidor');
%global tcpipServer;
global tcpipClient;
dataUser2= str2double(dataUser);
dataPassword2 = str2double(dataPassword);
%tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
%set(tcpipServer,'OutputBufferSize',s);
%fopen(tcpipServer);
global direccionServidor;
%direccion de prueba de servidor local
direccionServidor='127.0.0.1';
%direccionServidor='192.168.10.3';
tcpipClient=tcpip(direccionServidor,55000,'NetworkRole','Client');
fopen(tcpipClient);
dataPassword2Hash=DataHash(dataPassword2);
valorDouble=double(dataPassword2Hash);
fwrite(tcpipClient,dataUser2,'double');
fwrite(tcpipClient,dataPassword2,'double');
fwrite(tcpipClient,valorDouble,'double');
%recibo confirmacion de logeo exitoso
global ACKlogin;
ACKlogin = fread(tcpipClient,1,'double');
%numero 2211 configurado para confirmar el logeo
if(ACKlogin==2211)
    fclose(tcpipClient);
    
    set(handles.txtConexion,'string','Conexion Confiable');
    
    %open('cliente.fig');
    pause(5);
    msgbox(' Usuario logeado con exito ');
    ClientePrograma();
    %open('ClientePrograma.fig');
    close(handles.figure1);
    %delete(hObject);
end
if(ACKlogin==10)
    msgbox(' Error en la Autenticacion de Usuario ');
    set(handles.txtConexion,'string','Conexion Fallida');
end
end
% hObject    handle to btnConectarLogin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
