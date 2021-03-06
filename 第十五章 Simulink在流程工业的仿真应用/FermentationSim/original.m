function varargout = original(varargin)
% ORIGINAL M-file for original.fig
%      ORIGINAL, by itself, creates a new ORIGINAL or raises the existing
%      singleton*.
%
%      H = ORIGINAL returns the handle to a new ORIGINAL or the handle to
%      the existing singleton*.
%
%      ORIGINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ORIGINAL.M with the given input arguments.
%
%      ORIGINAL('Property','Value',...) creates a new ORIGINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before original_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to original_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help original

% Last Modified by GUIDE v2.5 27-Apr-2009 11:06:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @original_OpeningFcn, ...
                   'gui_OutputFcn',  @original_OutputFcn, ...
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


% --- Executes just before original is made visible.
function original_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to original (see VARARGIN)

% Choose default command line output for original
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes original wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = original_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global x0 p0 s0 Yxs Yps umax vmax Ks Kps Kp Kpp Ksi Kpsi Kpi Kppi T F Vy
Yxs=0.1604;                          %????????????????????
Yps=0.4986;                          %????????????????????????
umax=0.1132;                         %????????????????
vmax=0.9982;                         %????????????????
Ks=101.276;                          %????????
Kps=9.916;                           %
Kp=28.779;
Kpp=660.54;
Ksi=106500;
Kpsi=296540;
Kpi=5968;
Kppi=16.658;
sr=0.9886;          %????????????????????10%????????????????????
flowy=str2num(get(handles.edit1,'string'));        %??????????????
flow0=str2num(get(handles.edit2,'string'));          %SPL0??????
flow1=str2num(get(handles.edit3,'string'));             %SPL1??????
flow2=str2num(get(handles.edit4,'string'));          %SPL2??????
flow3=str2num(get(handles.edit5,'string'));       %SPL3??????  
flowr=str2num(get(handles.edit6,'string'));           %RCY??????
if flow3<6|flow3>15
    errordlg('????????????????SPL3????','Error');
end
if flow2<10|flow2>30
    errordlg('????????????????SPL2????','Error');
end
if flow1<50|flow1>90
    errordlg('????????????????SPL1????','Error');
end
if flow0<5|flow0>9
    errordlg('????????????????SPL0????','Error');
end
if flowy<0.5|flow>1.1
    errordlg('????????????????1????????','Error');
end
if flowr<0|flowr>8
    errordlg('????????????????RCY????','Error');
end
sr=0.9886;          %????????????????????10%????????????????????
time0=165/(flowy+flow0);                                %??????????????????????????????
time1=600/(flowy+flow0+flow1+flowr);
time2=600/(flowy+flow0+flow1+flow2+flowr);
time3=600/(flowy+flow0+flow1+flowr+flow2+flow3);
time4=600/(flowy+flow0+flow1+flow2+flowr+flow3);
time5=500/(flowy+flow0+flow1+flow2+flowr+flow3);
time6=500/(flowy+flow0+flow1+flow2+flowr+flow3);        %??????????????????????????????????
timesum=time1+time2+time3+time4+time5+time6;            %??????????????
results=[];   %????????????????????????????????
dresults=[];   %????????????????????????????????????
x0=37.47;     %1??????????????????
p0=45.12;     %1??????????????????
s0=1.07;      %1????????????????????
              %??????????????????????????????????????????*????
Vy=(flowy+flow0)/sr;      %??????????SPL0??1????????????????????(????????????
                             
xs=flowy*x0;        %????????????????????????????????????????
ps=flowy*p0;
ss=flowy*s0;     
ss=ss+flow0*217;      %??SPL0????????????????,217????????????????????
x0=xs/Vy;         %????????????????????????????
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func',[0 0.5 time0],[x0 p0 s0]);   %????ode45?????? 
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,1,150);    %????????????????????????????????????????????????????????????????????????????????????????????
F=F';
x0=F(end,1);                                        %??????????????????????????????????????????????????
p0=F(end,2);
s0=F(end,3);
% disp('??????????????????')
% results=[results;x0,p0/790,x0];                       %??????????????????????
% disp('??????????????'),disp(p0/790)                      
% disp('????????????'),disp(x0)
% disp('??????????????'),disp(s0)                                   %????????????????
axes(handles.axes1);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('????????')
%legend('????','????','????',-1)
xs=(flowy+flow0)*x0;       
ps=(flowy+flow0)*p0;
ss=(flowy+flow0)*s0;     %????????????????????????????????????,??????1??SPL0????
ss=ss+flow1*217;      %??????????SPL1????????????????
xs=xs+flowr*147;     %??????????????
ps=ps+flowr*100;
ss=ss+0.5*flowr;
Vy=(flow1+flowr+Vy)/sr;          %??????SPL1??RCY??????
x0=xs/Vy;       %??????????????????
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time1],[x0 p0 s0]);  
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time1,600);    %??????????????????????????????????????????????????????????????????????????????????????????????????????????????
F=F';                                                    %??????????ode????????????????????
x0=F(end,1);                                             %??????????????????????????????????????????
p0=F(end,2);
s0=F(end,3);
% disp('??????1??????????')
results=[results;x0,p0/790,s0];                       %??????????????????????
dresults=[dresults;F];     
% disp('??????????????'),disp(p0/790)                      
% disp('????????????'),disp(x0)
% disp('??????????????'),disp(s0)
axes(handles.axes2);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')               %??????????????????????????
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('??????1')
% legend('????','????','??????')
xs=(flowy+flow1+flow0+flowr)*x0;
ps=(flowy+flow1+flow0+flowr)*p0;
ss=(flowy+flow1+flow0+flowr)*s0;     %????????????????1??????????????????
ss=ss+flow2*217;      %??????????SPL2????????????????
Vy=flow2+Vy;  %SPL2????????????????????
x0=xs/Vy;       %????????????????????????????
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time2],[x0 p0 s0]);   
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time2,600);   %????????????????????????????????????????????????????????????????????????????????????????????
F=F';
x0=F(end,1);                                            %??????????????????????????????????????????
p0=F(end,2);
s0=F(end,3);
% disp('??????2??????????')
results=[results;x0,p0/790,s0];                       %??????????????????????
dresults=[dresults;F];    
% disp('??????????????'),disp(p0/790)                      
% disp('????????????'),disp(x0)
% disp('??????????????'),disp(s0)
axes(handles.axes3);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('??????2')
xs=x0*(flowy+flow1+flow0+flowr+flow2);          %????????????????2??????????????????
ps=p0*(flowy+flow1+flow0+flowr+flow2);          %????????????????2??????????????????
ss=s0*(flowy+flow1+flow0+flowr+flow2);          %????????????????2????????????????????
ss=ss+flow3*217;                                %??SPL3????????????????
Vy=flow3+Vy;                                    %??????????????????????????????????????????????????????????????????
x0=xs/Vy;                                       %??????????????????
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time3],[x0 p0 s0]);       
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time3,600);   %????????????????????????????????????????????????????????????????????????????????????????????
F=F';
x0=F(end,1);                                             %??????????????????????????????????????????????,??3??????????????????????
p0=F(end,2);      
s0=F(end,3);
% disp('??????3??????????')
results=[results;x0,p0/790,s0];                       %??????????????????????
dresults=[dresults;F];    
% disp('??????????????'),disp(p0/790)                      
% disp('????????????'),disp(x0)
% disp('??????????????'),disp(s0)
axes(handles.axes4);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('??????3')

%[T,F]=ode45('func1',[0 time4],[x0 p0 s0]);   
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time4,600);    %????????????????????????????????????????????????????????????????????????????????????????????
F=F';
x0=F(end,1);                                             %??????????????????????????????????????????????
p0=F(end,2);
s0=F(end,3);
% disp('??????4??????????')
results=[results;x0,p0/790,s0];                       %??????????????????????
dresults=[dresults;F];    
% disp('??????????????'),disp(p0/790)                      
% disp('????????????'),disp(x0)
% disp('??????????????'),disp(s0)
axes(handles.axes5);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('??????4')
%[T,F]=ode45('func2',[0 time5],[x0 p0 s0]);   
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time5,500);   %????????????????????????????????????????????????????????????????????????????????????????????
F=F';
x0=F(end,1);                                            %??????????????????????????????????????????????
p0=F(end,2);                                                 
s0=F(end,3);
% disp('??????5??????????')
results=[results;x0,p0/790,s0];                       %????????????????????????
dresults=[dresults;F];    
% disp('??????????????'),disp(p0/790)                      
% disp('????????????'),disp(x0)
% disp('??????????????'),disp(s0)
axes(handles.axes6);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')             %????????????????????????????
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('??????5')
[T,F]=runge_kutta1(@func,[x0 p0 s0],0.1,0,time6,500);    %????????????????
F=F';
%[T,F]=ode45('func2',[0 time6],[x0 p0 s0]);       
x0=F(end,1);                                             %??????????????????????????????????????????????
p0=F(end,2);
s0=F(end,3);
results=[results;x0,p0/790,s0];                       %??????????????????????
dresults=[dresults;F];    
axes(handles.axes7);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('concentration(kg/m3)')
title('??????6')
axes(handles.axes8);
imshow('legend.jpg');
set(handles.edit9,'string',num2str(timesum)); %????????????
flag=get(handles.checkbox1,'value');
dresults(:,2)=dresults(:,2)/790;
if flag==0
    set(handles.listbox1,'string',num2str(results)); %????????????????????????????????????
else
    set(handles.listbox1,'string',num2str(dresults)); %??????????????????????????????????????????????
end
set(handles.edit10,'string',num2str(x0));
set(handles.edit11,'string',num2str(p0/7.9));
set(handles.edit12,'string',num2str(s0));
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
close(gcf);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
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




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
data=get(handles.listbox1,'string');
xlswrite('data.xls',str2num(data));
msgbox('??????????data.xls????');
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1




% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
delete('data.xls');
msgbox('????????data.xls????');
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


