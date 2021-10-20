function varargout = temperatural(varargin)
% TEMPERATURAL M-file for temperatural.fig
%      TEMPERATURAL, by itself, creates a new TEMPERATURAL or raises the existing
%      singleton*.
%
%      H = TEMPERATURAL returns the handle to a new TEMPERATURAL or the handle to
%      the existing singleton*.
%
%      TEMPERATURAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEMPERATURAL.M with the given input arguments.
%
%      TEMPERATURAL('Property','Value',...) creates a new TEMPERATURAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before temperatural_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to temperatural_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help temperatural

% Last Modified by GUIDE v2.5 27-Apr-2009 13:20:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @temperatural_OpeningFcn, ...
                   'gui_OutputFcn',  @temperatural_OutputFcn, ...
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


% --- Executes just before temperatural is made visible.
function temperatural_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to temperatural (see VARARGIN)

% Choose default command line output for temperatural
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes temperatural wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = temperatural_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global x0 p0 s0 Yxs Yps umax vmax Ks Kps Kp Kpp Ksi Kpsi Kpi Kppi T F Vy Temp E A R Ts
E=9.52*1e4;                            %�������
Ts=[];                                 %�洢�������͹޵ķ����¶�
sr=0.9886;                           %��ˮ�Ҵ���ˮ��Ϻ�Ϊ10%���ҵ���Һ���������
R=8.314;                             %���峣��
A=8.78*1e14;                         %��������
Yxs=0.1604;                          %��������ڻ��ʵĵ���
Yps=0.4986;                          %�����Ҵ�����ڻ��ʵĵ���
umax=0.1132;                         %��������������
vmax=0.9982;                         %�Ҵ�����������
Ks=101.276;                          %���ͳ���
Kps=9.916;                           %
Kp=28.779;
Kpp=660.54;
Ksi=106500;
Kpsi=296540;
Kpi=5968;
Kppi=16.658;
CO2rjd=1.96;        %CO2�ܽ��
huifa=0.95;         %�Ҵ��ӷ���Ĳ�����
% flowy=0.886;        %Ԥ���͹޵�����
% flow0=7.02;         %SPL0������
% flow1=73;           %SPL1������
% flow2=22.28;        %SPL2������
% flow3=11.14;        %SPL3������  
% flowr=7.62;          %RCY������

% E=9.23*1e4;                             %���
% Ts=[];                                 %�洢�������͹޵ķ����¶�
% %Temp=30;                             %�����¶�
% R=8.314;                             %���峣��
% A=8.46*1e14;                        %��������
% Yxs=0.1604;                          %��������ڻ��ʵĵ���
% Yps=0.4986;                          %�����Ҵ�����ڻ��ʵĵ���
% % umax=0.1132;                         %��������������
% vmax=0.9982;                         %�Ҵ�����������
% Ks=101.276;                          %���ͳ���
% Kps=9.916;                           %
% Kp=28.779;
% Kpp=660.54;
% Ksi=106500;
% Kpsi=296540;
% Kpi=5968;
% Kppi=16.658;
% sr=0.9886;          %��ˮ�Ҵ���ˮ��Ϻ�Ϊ10%���ҵ���Һ���������
% CO2rjd=1.96;        %CO2�ܽ��
% huifa=0.95;         %�Ҵ��ӷ���Ĳ�����
flowy=str2num(get(handles.edit1,'string'));        %Ԥ���͹޵�����
flow0=str2num(get(handles.edit2,'string'));          %SPL0������
flow1=str2num(get(handles.edit3,'string'));             %SPL1������
flow2=str2num(get(handles.edit4,'string'));          %SPL2������
flow3=str2num(get(handles.edit5,'string'));       %SPL3������  
flowr=str2num(get(handles.edit6,'string'));           %RCY������
if flow3<6|flow3>15
    errordlg('���������ʵ�ʵ�SPL3����','Error');
end
if flow2<10|flow2>30
    errordlg('���������ʵ�ʵ�SPL2����','Error');
end
if flow1<50|flow1>90
    errordlg('���������ʵ�ʵ�SPL1����','Error');
end
if flow0<5|flow0>9
    errordlg('���������ʵ�ʵ�SPL0����','Error');
end
if flowy<0.5|flowy>1.1
    errordlg('���������ʵ�ʵ�1�ſ�����','Error');
end
if flowr<0|flowr>8
    errordlg('���������ʵ�ʵ�RCY����','Error');
end
T0=str2num(get(handles.edit22,'string'));               %��������еõ��������ӵķ����¶�
T1=str2num(get(handles.edit11,'string'));
T2=str2num(get(handles.edit17,'string'));
T3=str2num(get(handles.edit18,'string'));
T4=str2num(get(handles.edit19,'string'));
T5=str2num(get(handles.edit20,'string'));
T6=str2num(get(handles.edit21,'string'));
time0=165/(flowy+flow0);                                %ͣ��ʱ����ڷ��͹������������
time1=600/(flowy+flow0+flow1+flowr);
time4=600/(flowy+flow0+flow1+flow2+flowr+flow3);
time5=500/(flowy+flow0+flow1+flow2+flowr+flow3);
time6=500/(flowy+flow0+flow1+flow2+flowr+flow3);
% %��Һƽ��ͣ��ʱ�䷢�͹������������
results=[];                       %��������ʼ��
dresults=[];
x0=37.47;     %1�ſڽ��ϵľ���Ũ��
p0=45.12;     %1�ſڽ����Ҵ���Ũ��
s0=1.07;      %1�ſڽ��������ǵ�Ũ��
              %�����������ÿ�����ʵĵ�λʱ�������������*Ũ��
Vy=(flowy+flow0)*sr;      %��λʱ��SPL0��1�Ļ��Һ���Ϻ�����(���ǻ��ܣ�
                             
xs=flowy*x0;        %��λʱ����ϵ����������塢�Ҵ��������ǣ�
ps=flowy*p0;
ss=flowy*s0;     
ss=ss+flow0*217;      %��SPL0���������������,217�ǲ�����������Ũ��
x0=xs/Vy;         %���Ϲ��л�����и��ɷֵ�Ũ��
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func',[0 0.5 time0],[x0 p0 s0]);   %����ode45����� 
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,1,150,T0);    %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
F=F';
x0=F(end,1);                                        %���͹���ͣ��ʱ������ʱ��Ũ��ֵ���������ĳ�ʼֵ
p0=F(end,2);
s0=F(end,3);
% disp('Ԥ���͹޳�����Ũ��')
% results=[results;x0,p0/790,x0];                       %���ù޵Ľ������Ϊһ��
% disp('�Ҵ����������'),disp(p0/790)                      
% disp('�����Ũ����'),disp(x0)
% disp('�����ǵ�Ũ����'),disp(s0)                                   %��ʾ�ù޷��ͽ��
axes(handles.axes1);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('Ԥ���͹�')
%legend('����','�Ҵ�','����',-1)
xs=(flowy+flow0)*x0;       
ps=(flowy+flow0)*p0;
ss=(flowy+flow0)*s0;     %��λʱ���Ԥ���͹޳����������ǵ�����,������1��SPL0�ĺ�
ss=ss+flow1*217;      %��λʱ���SPL1���������������
xs=xs+flowr*147;     %��������������
ps=ps+flowr*100;
ss=ss+0.5*flowr;
Vy=(flow1+flowr+Vy)*sr;          %������SPL1��RCY������
x0=xs/Vy;       %��Ϻ���ɷֵ�Ũ��
p0=ps/Vy;   
s0=ss/Vy;
m_ethan_fin1=p0*600*time1;%����1�ŷ��͹޵��Ҵ�������

%[T,F]=ode45('func1',[0 time1],[x0 p0 s0]);  
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time1,600,T1);    %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���   %�����Աຯ����⣬�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
F=F';                                                    %Ϊ�˱�����ode�������ת�ó�������

x0=F(end,1);                                             %�÷��͹����ʱ��Ũ��ֵ�ǽ��������ĳ�ʼֵ
p0=F(end,2);
s0=F(end,3);

m_ethan_final1=p0*600*time1; %1�ŷ��͹޷�����Ϻ���Ҵ�����
m_sum1=((852.21+1.07+45.12+37.47)*flowy+(850+217)*(flow0+flow1)+(752.92+0.5+100+147)*flowr)*time1;%1�ŷ��͹���Һ���������
m_CO2_1=(m_ethan_final1-m_ethan_fin1)*44/46;%����CO2������
m_CO2_melt1=CO2rjd*600;                      %�ܽ��ڷ��͹����е�����
mCO2_run1=m_CO2_1-m_CO2_melt1;                %���ܵ�����������
yita1=(m_sum1-mCO2_run1)/m_sum1;             %���ϱ�����
p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
% disp('���͹�1������Ũ��')
results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
dresults=[dresults;F];
% disp('�Ҵ����������'),disp(p0/790)                      
% disp('�����Ũ����'),disp(x0)
% disp('�����ǵ�Ũ����'),disp(s0)
axes(handles.axes2);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')               %ÿһ����һ�ֳɷֵ�Ũ������
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('���͹�1')
% legend('����','�Ҵ�','������')
xs=(flowy+flow1+flow0+flowr)*x0*yita1;      %�����ų����������п���
ps=(flowy+flow1+flow0+flowr)*p0*yita1;
ss=(flowy+flow1+flow0+flowr)*s0*yita1;     %��λʱ��ӷ��͹�1�����������ǵ�����
ss=ss+flow2*217;      %��λʱ���SPL2���������������
Vy=flow2+Vy*yita1;  %SPL2��λʱ���Ϻ�����,�������п���
x0=xs/Vy;       %��λʱ�������и��ɷֵ�Ũ��
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time2],[x0 p0 s0]); 
time2=600/Vy;             %��Ϊ�������٣�ƽ������ʱ��Ҳ��������
m_ethan_fin2=p0*600*time2;%����2�ŷ��͹޵��Ҵ�������
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time2,600,T2);    %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���   %�����Աຯ����⣬�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
F=F';
x0=F(end,1);                                            %�÷��͹����ʱ��Ũ��ֵ�ǽ��������ĳ�ʼֵ
p0=F(end,2);
s0=F(end,3);
% disp('���͹�2������Ũ��')

m_ethan_final2=p0*600*time2;                        %2�ŷ��͹޷�����Ϻ���Ҵ�����
m_sum2=m_sum1*yita1+((850.02+217)*flow2)*time2;     %2�ŷ��͹���Һ���������
m_CO2_2=(m_ethan_final2-m_ethan_fin2)*44/46;        %����CO2������
m_CO2_melt2=CO2rjd*600;                      %�ܽ��ڷ��͹����е�����
mCO2_run2=m_CO2_2-m_CO2_melt2;                %���ܵ���������
yita2=(m_sum2-mCO2_run2)/m_sum2;        %���ϱ�����
%p0=p0*yita2;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
dresults=[dresults;F];
% disp('�Ҵ����������'),disp(p0/790)                      
% disp('�����Ũ����'),disp(x0)
% disp('�����ǵ�Ũ����'),disp(s0)
axes(handles.axes3);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('���͹�2')
%%%��Ϊ���͹��ڻ���Ǿ��ȵģ����Ե�λʱ������������Ҳ�ǿ����
xs=x0*(flowy+flow1+flow0+flowr+flow2)*yita2;          %��λʱ��ӷ��͹�2�޳����ľ��������
ps=p0*(flowy+flow1+flow0+flowr+flow2)*yita2;          %��λʱ��ӷ��͹�2�޳������Ҵ�������
ss=s0*(flowy+flow1+flow0+flowr+flow2)*yita2;          %��λʱ��ӷ��͹�2�޳����������ǵ�����
ss=ss+flow3*217;                                %��SPL3���������������
Vy=flow3+Vy*yita2;                                    %ÿ�����͹���ڵ�����������֮ǰ�����з��͹��������ټ��Ͻ��Ͽڵ�����
x0=xs/Vy;                                       %��Ϻ���ɷֵ�Ũ��
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time3],[x0 p0 s0]);  
time3=600/Vy;
m_ethan_fin3=p0*600*time3;%����3�ŷ��͹޵��Ҵ�������
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time3,600,T3);    %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���   %�����Աຯ����⣬�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
F=F';
x0=F(end,1);                                             %�÷��͹����ʱ��Ũ��ֵ�ǽ�����һ�����ӵĽ���ֵ,��3�Ź���֮�����л����
p0=F(end,2);      
s0=F(end,3);
% disp('���͹�3������Ũ��')

m_ethan_final3=p0*600*time3;                        %3�ŷ��͹޷�����Ϻ���Ҵ�����
m_sum3=m_sum2*yita2+((850.02+217)*flow3)*time3;     %3�ŷ��͹���Һ���������
m_CO2_3=(m_ethan_final3-m_ethan_fin3)*44/46;        %����CO2������
m_CO2_melt3=CO2rjd*600;                      %�ܽ��ڷ��͹����е�����
mCO2_run3=m_CO2_3-m_CO2_melt3;                %���ܵ���������
yita3=(m_sum3-mCO2_run3)/m_sum3;        %���ϱ�����
%p0=p0*yita3;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
dresults=[dresults;F];
% disp('�Ҵ����������'),disp(p0/790)                      
% disp('�����Ũ����'),disp(x0)
% disp('�����ǵ�Ũ����'),disp(s0)
axes(handles.axes4);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('���͹�3')
%[T,F]=ode45('func1',[0 time4],[x0 p0 s0]);
%600/time4=yita3*600/time3
%time4=time3/yita3;                
m_ethan_fin4=p0*600*time4;%����4�ŷ��͹޵��Ҵ�������
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time4,600,T4);     %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
F=F';
x0=F(end,1);                                             %�÷��͹����ʱ��Ũ��ֵ�ǽ�����һ�����ӵĽ���ֵ
p0=F(end,2);
s0=F(end,3);
% disp('���͹�4������Ũ��')
m_ethan_final4=p0*600*time4;                        %4�ŷ��͹޷�����Ϻ���Ҵ�����
m_sum4=m_sum3*yita3;                                %4�ŷ��͹���Һ���������
m_CO2_4=(m_ethan_final4-m_ethan_fin4)*44/46;        %����CO2������
m_CO2_melt4=CO2rjd*600;                      %�ܽ��ڷ��͹����е�����
mCO2_run4=m_CO2_4-m_CO2_melt4;                %���ܵ���������
yita4=(m_sum4-mCO2_run4)/m_sum4;        %���ϱ���
%yita4=(m_sum4-m_CO2_4)/m_sum4;                      %���ϱ�����(Ӱ������)
%p0=p0*yita4;                         %����CO2�ų���ͬʱҲ�����Ҵ�����������������������
p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
dresults=[dresults;F];
% disp('�Ҵ����������'),disp(p0/790)                      
% disp('�����Ũ����'),disp(x0)
% disp('�����ǵ�Ũ����'),disp(s0)
axes(handles.axes5);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('���͹�4')
%[T,F]=ode45('func2',[0 time5],[x0 p0 s0]); 
%time5=time4/yita4;
m_ethan_fin5=p0*500*time5;%����5�ŷ��͹޵��Ҵ�������
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time5,600,T5); ;   %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
F=F';
x0=F(end,1);                                            %�÷��͹����ʱ��Ũ��ֵ�ǽ�����һ�����ӵĽ���ֵ
p0=F(end,2);                                                 
s0=F(end,3);
% disp('���͹�5������Ũ��')
m_ethan_final5=p0*500*time5;                        %5�ŷ��͹޷�����Ϻ���Ҵ�����
m_sum5=m_sum4*yita4;                                %5�ŷ��͹���Һ���������
m_CO2_5=(m_ethan_final5-m_ethan_fin5)*44/46;        %����CO2������
m_CO2_melt5=CO2rjd*500;                      %�ܽ��ڷ��͹����е�����
mCO2_run5=m_CO2_5-m_CO2_melt5;                %���ܵ���������
p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
yita5=(m_sum5-mCO2_run5)/m_sum5;        %���ϱ���
%yita5=(m_sum5-m_CO2_5)/m_sum5;                      %���ϱ�����
%p0=p0*yita5;                         %����CO2�ų���ͬʱҲ�����Ҵ�����������������������
results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
dresults=[dresults;F];
% disp('�Ҵ����������'),disp(p0/790)                      
% disp('�����Ũ����'),disp(x0)
% disp('�����ǵ�Ũ����'),disp(s0)
axes(handles.axes6);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')             %�ò�ͬ��ɫ��ǲ�ͬ��ֵ�����
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('���͹�5')
%time6=time5/yita5;
m_ethan_fin6=p0*500*time6;%����5�ŷ��͹޵��Ҵ�������
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time6,600,T6);     %�����Աຯ�����
F=F';
%[T,F]=ode45('func2',[0 time6],[x0 p0 s0]);       
x0=F(end,1);                                             %�÷��͹����ʱ��Ũ��ֵ�ǽ�����һ�����ӵĽ���ֵ
p0=F(end,2);
s0=F(end,3);
p0=p0*huifa;                         %�Ҵ������ӷ�һ����
axes(handles.axes7);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('���͹�6')
results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
dresults=[dresults;F];
% disp('�Ҵ����������'),disp(p0/790)                        %��ʾ���Ӧ�Ľ��
% disp('�����Ũ����'),disp(x0)
% disp('�����ǵ�Ũ����'),disp(s0)
% time2=600/(flowy+flow0+flow1+flow2+flowr);
% time3=600/(flowy+flow0+flow1+flowr+flow2+flow3);
% time4=600/(flowy+flow0+flow1+flow2+flowr+flow3);
% time5=500/(flowy+flow0+flow1+flow2+flowr+flow3);
% time6=500/(flowy+flow0+flow1+flow2+flowr+flow3);        %��Һƽ��ͣ��ʱ�䷢�͹������������
% results=[];   %��ʾ�������͹޵����Ũ���õľ���
% dresults=[];   %��ʾ�������͹޵�����ʱ��Ũ���õľ���
% x0=37.47;     %1�ſڽ��ϵľ���Ũ��
% p0=45.12;     %1�ſڽ����Ҵ���Ũ��
% s0=1.07;      %1�ſڽ��������ǵ�Ũ��
%               %�����������ÿ�����ʵĵ�λʱ�������������*Ũ��
% Vy=(flowy+flow0)/sr;      %��λʱ��SPL0��1�Ļ��Һ���Ϻ�����(�����ǻ��ܣ�
%                              
% xs=flowy*x0;        %��λʱ����ϵ����������塢�Ҵ��������ǣ�
% ps=flowy*p0;
% ss=flowy*s0;     
% ss=ss+flow0*217;      %��SPL0���������������,217�ǲ�����������Ũ��
% x0=xs/Vy;         %���Ϲ��л�����и��ɷֵ�Ũ��
% p0=ps/Vy;   
% s0=ss/Vy;
% %[T,F]=ode45('func',[0 0.5 time0],[x0 p0 s0]);   %����ode45����� 
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,1,150,T0);    %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
% F=F';
% x0=F(end,1);                                        %���͹���ͣ��ʱ������ʱ��Ũ��ֵ���������ĳ�ʼֵ
% p0=F(end,2);
% s0=F(end,3);
% 
% % disp('Ԥ���͹޳�����Ũ��')
% % results=[results;x0,p0/790,x0];                       %���ù޵Ľ������Ϊһ��
% % disp('�Ҵ����������'),disp(p0/790)                      
% % disp('�����Ũ����'),disp(x0)
% % disp('�����ǵ�Ũ����'),disp(s0)                                   %��ʾ�ù޷��ͽ��
% axes(handles.axes1);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('Ԥ���͹�')
% xs=(flowy+flow0)*x0;       
% ps=(flowy+flow0)*p0;
% ss=(flowy+flow0)*s0;     %��λʱ���Ԥ���͹޳����������ǵ�����,������1��SPL0�ĺ�
% ss=ss+flow1*217;      %��λʱ���SPL1���������������
% xs=xs+flowr*147;     %��������������
% ps=ps+flowr*100;
% ss=ss+0.5*flowr;
% Vy=(flow1+flowr+Vy)/sr;          %������SPL1��RCY������
% x0=xs/Vy;       %��Ϻ���ɷֵ�Ũ��
% p0=ps/Vy;   
% s0=ss/Vy;
% %[T,F]=ode45('func1',[0 time1],[x0 p0 s0]);  
% m_ethan_fin1=p0*600*time1;%����1�ŷ��͹޵��Ҵ�������
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time1,600,T1);    %�����Աຯ����⣬�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
% F=F';                                                    %Ϊ�˱�����ode�������ת�ó�������
% x0=F(end,1);                                             %�÷��͹����ʱ��Ũ��ֵ�ǽ��������ĳ�ʼֵ
% p0=F(end,2);
% s0=F(end,3);
% 
% m_ethan_final1=p0*600*time1; %1�ŷ��͹޷�����Ϻ���Ҵ�����
% m_sum1=((852.21+1.07+45.12+37.47)*flowy+(850+217)*(flow0+flow1)+(752.92+0.5+100+147)*flowr)*time1;%1�ŷ��͹���Һ���������
% m_CO2_1=(m_ethan_final1-m_ethan_fin1)*44/46;%����CO2������
% m_CO2_melt1=CO2rjd*600;                      %�ܽ��ڷ��͹����е�����
% mCO2_run1=m_CO2_1-m_CO2_melt1;                %���ܵ�����������
% yita1=(m_sum1-mCO2_run1)/m_sum1;             %���ϱ�����
% p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
% % disp('���͹�1������Ũ��')
% results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
% dresults=[dresults;F];
% % disp('�Ҵ����������'),disp(p0/790)                      
% % disp('�����Ũ����'),disp(x0)
% % disp('�����ǵ�Ũ����'),disp(s0)
% axes(handles.axes2);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')               %ÿһ����һ�ֳɷֵ�Ũ������
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('���͹�1')
% % legend('����','�Ҵ�','������')
% xs=(flowy+flow1+flow0+flowr)*x0;
% ps=(flowy+flow1+flow0+flowr)*p0;
% ss=(flowy+flow1+flow0+flowr)*s0;     %��λʱ��ӷ��͹�1�����������ǵ�����
% ss=ss+flow2*217;      %��λʱ���SPL2���������������
% Vy=flow2+Vy*yita1;  %SPL2��λʱ���Ϻ�����,�������п���
% %Vy=flow2+Vy;  %SPL2��λʱ���Ϻ�����
% x0=xs/Vy;       %��λʱ�������и��ɷֵ�Ũ��
% p0=ps/Vy;   
% s0=ss/Vy;
% %[T,F]=ode45('func1',[0 time2],[x0 p0 s0]);   
% time2=600/Vy;             %��Ϊ�������٣�ƽ������ʱ��Ҳ��������
% m_ethan_fin2=p0*600*time2;%����2�ŷ��͹޵��Ҵ�������
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time2,600,T2);   %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
% F=F';
% x0=F(end,1);                                            %�÷��͹����ʱ��Ũ��ֵ�ǽ��������ĳ�ʼֵ
% p0=F(end,2);
% s0=F(end,3);
% % disp('���͹�2������Ũ��')
% m_ethan_final2=p0*600*time2;                        %2�ŷ��͹޷�����Ϻ���Ҵ�����
% m_sum2=m_sum1*yita1+((850.02+217)*flow2)*time2;     %2�ŷ��͹���Һ���������
% m_CO2_2=(m_ethan_final2-m_ethan_fin2)*44/46;        %����CO2������
% m_CO2_melt2=CO2rjd*600;                      %�ܽ��ڷ��͹����е�����
% mCO2_run2=m_CO2_2-m_CO2_melt2;                %���ܵ���������
% yita2=(m_sum2-mCO2_run2)/m_sum2;        %���ϱ�����
% %p0=p0*yita2;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
% p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
% results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
% dresults=[dresults;F];
% % disp('�Ҵ����������'),disp(p0/790)                      
% % disp('�����Ũ����'),disp(x0)
% % disp('�����ǵ�Ũ����'),disp(s0)
% axes(handles.axes3);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('���͹�2')
% xs=x0*(flowy+flow1+flow0+flowr+flow2);          %��λʱ��ӷ��͹�2�޳����ľ��������
% ps=p0*(flowy+flow1+flow0+flowr+flow2);          %��λʱ��ӷ��͹�2�޳������Ҵ�������
% ss=s0*(flowy+flow1+flow0+flowr+flow2);          %��λʱ��ӷ��͹�2�޳����������ǵ�����
% ss=ss+flow3*217;                                %��SPL3���������������
% Vy=flow3+Vy*yita2;                               %ÿ�����͹���ڵ�����������֮ǰ�����з��͹��������ټ��Ͻ��Ͽڵ�����(��˥��)
% x0=xs/Vy;                                       %��Ϻ���ɷֵ�Ũ��
% p0=ps/Vy;   
% s0=ss/Vy;
% time3=600/Vy;
% %[T,F]=ode45('func1',[0 time3],[x0 p0 s0]); 
% m_ethan_fin3=p0*600*time3;%����3�ŷ��͹޵��Ҵ�������
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time3,600,T3);   %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
% F=F';
% x0=F(end,1);                                             %�÷��͹����ʱ��Ũ��ֵ�ǽ�����һ�����ӵĽ���ֵ,��3�Ź���֮�����л����
% p0=F(end,2);      
% s0=F(end,3);
% % disp('���͹�3������Ũ��')
% m_ethan_final3=p0*600*time3;                        %3�ŷ��͹޷�����Ϻ���Ҵ�����
% m_sum3=m_sum2*yita2+((850.02+217)*flow3)*time3;     %3�ŷ��͹���Һ���������
% m_CO2_3=(m_ethan_final3-m_ethan_fin3)*44/46;        %����CO2������
% m_CO2_melt3=CO2rjd*600;                      %�ܽ��ڷ��͹����е�����
% mCO2_run3=m_CO2_3-m_CO2_melt3;                %���ܵ���������
% yita3=(m_sum3-mCO2_run3)/m_sum3;        %���ϱ�����
% %p0=p0*yita3;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
% p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
% 
% results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
% dresults=[dresults;F];
% % disp('�Ҵ����������'),disp(p0/790)                      
% % disp('�����Ũ����'),disp(x0)
% % disp('�����ǵ�Ũ����'),disp(s0)
% axes(handles.axes4);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('���͹�3')
% axes(handles.axes8);
% imshow('legend.jpg');
% %[T,F]=ode45('func1',[0 time4],[x0 p0 s0]);   
% time4=time3/yita3;   
% m_ethan_fin4=p0*600*time4;%����4�ŷ��͹޵��Ҵ���
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time4,600,T4);    %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
% F=F';
% x0=F(end,1);                                             %�÷��͹����ʱ��Ũ��ֵ�ǽ�����һ�����ӵĽ���ֵ
% p0=F(end,2);
% s0=F(end,3);
% m_ethan_final4=p0*600*time4;                        %4�ŷ��͹޷�����Ϻ���Ҵ�����
% m_sum4=m_sum3*yita3;                                %4�ŷ��͹���Һ���������
% m_CO2_4=(m_ethan_final4-m_ethan_fin4)*44/46;        %����CO2������
% m_CO2_melt4=CO2rjd*600;                      %�ܽ��ڷ��͹����е�����
% mCO2_run4=m_CO2_4-m_CO2_melt4;                %���ܵ���������
% yita4=(m_sum4-mCO2_run4)/m_sum4;        %���ϱ���
% %yita4=(m_sum4-m_CO2_4)/m_sum4;                      %���ϱ�����(Ӱ������)
% %p0=p0*yita4;                         %����CO2�ų���ͬʱҲ�����Ҵ�����������������������
% p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
% % disp('���͹�4������Ũ��')
% results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
% dresults=[dresults;F];
% % disp('�Ҵ����������'),disp(p0/790)                      
% % disp('�����Ũ����'),disp(x0)
% % disp('�����ǵ�Ũ����'),disp(s0)
% axes(handles.axes5);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('���͹�4')
% %[T,F]=ode45('func2',[0 time5],[x0 p0 s0]);   
% time5=time4/yita4;
% m_ethan_fin5=p0*500*time5;%����5�ŷ��͹޵��Ҵ�������
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time5,500,T5);   %�����Աຯ���������ֱ��Ƕ���ѧ������ڣ��������ʼֵ��������ʱ����㣬ʱ���յ㣬����Һ���
% F=F';
% x0=F(end,1);                                            %�÷��͹����ʱ��Ũ��ֵ�ǽ�����һ�����ӵĽ���ֵ
% p0=F(end,2);                                                 
% s0=F(end,3);
% m_ethan_final5=p0*500*time5;                        %5�ŷ��͹޷�����Ϻ���Ҵ�����
% m_sum5=m_sum4*yita4;                                %5�ŷ��͹���Һ���������
% m_CO2_5=(m_ethan_final5-m_ethan_fin5)*44/46;        %����CO2������
% m_CO2_melt5=CO2rjd*500;                      %�ܽ��ڷ��͹����е�����
% mCO2_run5=m_CO2_5-m_CO2_melt5;                %���ܵ���������
% p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥��
% yita5=(m_sum5-mCO2_run5)/m_sum5;        %���ϱ���
% % disp('���͹�5������Ũ��')
% results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
% dresults=[dresults;F];
% % disp('�Ҵ����������'),disp(p0/790)                      
% % disp('�����Ũ����'),disp(x0)
% % disp('�����ǵ�Ũ����'),disp(s0)
% axes(handles.axes6);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')             %�ò�ͬ��ɫ��ǲ�ͬ��ֵ�����
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('���͹�5')
% time6=time5/yita5;
% m_ethan_fin6=p0*500*time6;%����5�ŷ��͹޵��Ҵ�������
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time6,500,T6);    %�����Աຯ�����
% F=F';
% %[T,F]=ode45('func2',[0 time6],[x0 p0 s0]);       
% x0=F(end,1);                                             %�÷��͹����ʱ��Ũ��ֵ�ǽ�����һ�����ӵĽ���ֵ
% p0=F(end,2);
% s0=F(end,3);
% m_ethan_final6=p0*500*time6;                        %5�ŷ��͹޷�����Ϻ���Ҵ�����
% m_sum6=m_sum5*yita5;                                %5�ŷ��͹���Һ���������
% m_CO2_6=(m_ethan_final6-m_ethan_fin6)*44/46;        %����CO2������
% m_CO2_melt6=CO2rjd*500;                      %�ܽ��ڷ��͹����е�����
% mCO2_run6=m_CO2_6-m_CO2_melt6;                %���ܵ���������
% p0=p0*huifa;                         %����CO2�ų���ͬʱҲ�����Ҵ���������������������������������ͬ������Ҫ������Ũ��˥
% results=[results;x0,p0/790,s0];                       %���ù޵Ľ������Ϊһ��
% dresults=[dresults;F];
% axes(handles.axes7);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('���͹�6')
dresults(:,2)=dresults(:,2)/790;
set(handles.edit7,'string',num2str(time1+time2+time3+time4+time5+time6));     %��ʾ����ʱ��
set(handles.edit8,'string',num2str(x0));
set(handles.edit9,'string',num2str(p0/7.9));
set(handles.edit10,'string',num2str(s0));

flag=get(handles.checkbox1,'value');                  %�����ϸ��ʾ�ǲ��Ǳ�ѡ����
if flag==0
    set(handles.listbox1,'string',num2str(results));
else
    set(handles.listbox1,'string',num2str(dresults));
end
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close(gcf);

% hObject    handle to pushbutton2 (see GCBO)
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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
data=get(handles.listbox1,'string');
[filename,pathname]=uiputfile({'*.xls'},'���������ļ�');
xlswrite(filename,str2num(data));
msgbox('�������');
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
delete('dataS.xls');
msgbox('�Ѿ����dataT.xls�ļ�');
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



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



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


