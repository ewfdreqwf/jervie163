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
E=9.214*1e4;                            %生长活化能
Ts=[];                                 %存储各个发酵罐的发酵温度
sr=0.9886;                           %无水乙醇和水混合后为10%左右的溶液体积缩减比
R=8.314;                             %气体常数
A=8.78*1e14;                         %生长常数
Yxs=0.1604;                          %菌体相对于基质的得率
Yps=0.4986;                          %产物乙醇相对于基质的得率
umax=0.1132;                         %菌体最大比生长率
vmax=0.9982;                         %乙醇最大比生长率
Ks=101.276;                          %饱和常数
Kps=9.916;                           %
Kp=28.779;
Kpp=660.54;
Ksi=106500;
Kpsi=296540;
Kpi=5968;
Kppi=16.658;
CO2rjd=1.21*325;        %CO2溶解质量(kg/m3)溶解体积*密度
jd=0.0187;         %CO2夹带出的乙醇质量
% flowy=0.886;        %预发酵罐的流速
% flow0=7.02;         %SPL0的流速
% flow1=73;           %SPL1的流速
% flow2=22.28;        %SPL2的流速
% flow3=11.14;        %SPL3的流速  
% flowr=7.62;          %RCY的流速

% E=9.23*1e4;                             %活化能
% Ts=[];                                 %存储各个发酵罐的发酵温度
% %Temp=30;                             %摄氏温度
% R=8.314;                             %气体常数
% A=8.46*1e14;                        %生长常数
% Yxs=0.1604;                          %菌体相对于基质的得率
% Yps=0.4986;                          %产物乙醇相对于基质的得率
% % umax=0.1132;                         %菌体最大比生长率
% vmax=0.9982;                         %乙醇最大比生长率
% Ks=101.276;                          %饱和常数
% Kps=9.916;                           %
% Kp=28.779;
% Kpp=660.54;
% Ksi=106500;
% Kpsi=296540;
% Kpi=5968;
% Kppi=16.658;
% sr=0.9886;          %无水乙醇和水混合后为10%左右的溶液体积缩减比
% CO2rjd=1.96;        %CO2溶解度
% huifa=0.95;         %乙醇挥发后的残留量
flowy=str2num(get(handles.edit1,'string'));        %预发酵罐的流速
flow0=str2num(get(handles.edit2,'string'));          %SPL0的流速
flow1=str2num(get(handles.edit3,'string'));             %SPL1的流速
flow2=str2num(get(handles.edit4,'string'));          %SPL2的流速
flow3=str2num(get(handles.edit5,'string'));       %SPL3的流速  
flowr=str2num(get(handles.edit6,'string'));           %RCY的流速
if flow3<6|flow3>15
    errordlg('请输入符合实际的SPL3流量','Error');
end
if flow2<10|flow2>30
    errordlg('请输入符合实际的SPL2流量','Error');
end
if flow1<50|flow1>90
    errordlg('请输入符合实际的SPL1流量','Error');
end
if flow0<5|flow0>9
    errordlg('请输入符合实际的SPL0流量','Error');
end
if flowy<0.5|flowy>1.1
    errordlg('请输入符合实际的1号口流量','Error');
end
if flowr<0|flowr>8
    errordlg('请输入符合实际的RCY流量','Error');
end
T0=str2num(get(handles.edit22,'string'));               %从输入框中得到各个罐子的发酵温度
T1=str2num(get(handles.edit11,'string'));
T2=str2num(get(handles.edit17,'string'));
T3=str2num(get(handles.edit18,'string'));
T4=str2num(get(handles.edit19,'string'));
T5=str2num(get(handles.edit20,'string'));
T6=str2num(get(handles.edit21,'string'));
time0=165/(flowy+flow0);                                %停留时间等于发酵罐体积除以流量
time1=600/(flowy+flow0+flow1+flowr);
time4=600/(flowy+flow0+flow1+flow2+flowr+flow3);
time5=500/(flowy+flow0+flow1+flow2+flowr+flow3);
time6=500/(flowy+flow0+flow1+flow2+flowr+flow3);
% %料液平均停留时间发酵罐体积除以流量
results=[];                       %结果矩阵初始化
dresults=[];
x0=37.47;     %1号口进料的菌体浓度
p0=45.12;     %1号口进料乙醇的浓度
s0=1.07;      %1号口进料葡萄糖的浓度
              %求出三种量，每种物质的单位时间进量等于流量*浓度
Vy=(flowy+flow0)*sr;      %求单位时间SPL0和1的混合液进料后的体积(考虑互溶）
                             
xs=flowy*x0;        %单位时间进料的质量（菌体、乙醇、葡萄糖）
ps=flowy*p0;
ss=flowy*s0;     
ss=ss+flow0*217;      %从SPL0补充进来的葡萄糖,217是补充进来糖类的浓度
x0=xs/Vy;         %进料管中混合体中各成分的浓度
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func',[0 0.5 time0],[x0 p0 s0]);   %调用ode45来求解 
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,1,150,T0);    %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                        %发酵罐中停留时间的最后时刻浓度值流入混合器的初始值
p0=F(end,2);
s0=F(end,3);
% disp('预发酵罐出来的浓度')
% results=[results;x0,p0/790,x0];                       %将该罐的结果保存为一列
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)                                   %显示该罐发酵结果
axes(handles.axes1);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('预发酵罐')
%legend('菌体','乙醇','糖类',-1)
xs=(flowy+flow0)*x0;       
ps=(flowy+flow0)*p0;
ss=(flowy+flow0)*s0;     %单位时间从预发酵罐出来的葡萄糖的质量,流量是1与SPL0的和
ss=ss+flow1*217;      %单位时间从SPL1补充进来的葡萄糖
xs=xs+flowr*147;     %反馈回来的质量
ps=ps+flowr*100;
ss=ss+0.5*flowr;
Vy=(flow1+flowr+Vy)*sr;          %增加了SPL1和RCY的流量
x0=xs/Vy;       %混合后各成分的浓度
p0=ps/Vy;   
s0=ss/Vy;
m_ethan_fin1=p0*600*time1;%流入1号发酵罐的乙醇的质量

%[T,F]=ode45('func1',[0 time1],[x0 p0 s0]);  
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time1,600,T1);    %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积   %调用自编函数求解，调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';                                                    %为了保持与ode风格相似转置成列向量

x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入混合器的初始值
p0=F(end,2);
s0=F(end,3);

m_ethan_final1=p0*600*time1; %1号发酵罐发酵完毕后的乙醇质量
m_sum1=((852.21+1.07+45.12+37.47)*flowy+(850+217)*(flow0+flow1)+(752.92+0.5+100+147)*flowr)*time1;%1号发酵罐中液体的总质量
m_CO2_1=(m_ethan_final1-m_ethan_fin1)*44/46%生成CO2的质量
m_CO2_melt1=CO2rjd*600;                      %溶解在发酵罐子中的质量
mCO2_run1=m_CO2_1-m_CO2_melt1;                %求跑掉的气体质量
methan_run1=mCO2_run1*jd;                %CO2带走的乙醇气体的质量
huifa=(m_ethan_final1-methan_run1)/m_ethan_final1;    %挥发后剩余质量比
yita1=(m_sum1-mCO2_run1)/m_sum1;             %物料保留率
p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
% disp('发酵罐1出来的浓度')
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
dresults=[dresults;F];
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes2);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')               %每一列是一种成分的浓度序列
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('发酵罐1')
% legend('菌体','乙醇','葡萄糖')
xs=(flowy+flow1+flow0+flowr)*x0*yita1;      %气体排除导致流量有亏损
ps=(flowy+flow1+flow0+flowr)*p0*yita1;
ss=(flowy+flow1+flow0+flowr)*s0*yita1;     %单位时间从发酵罐1出来的葡萄糖的质量
ss=ss+flow2*217;      %单位时间从SPL2补充进来的葡萄糖
Vy=flow2+Vy*yita1;  %SPL2单位时间混合后的体积,流出量有亏损
x0=xs/Vy;       %单位时间混合体中各成分的浓度
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time2],[x0 p0 s0]); 
time2=600/Vy;             %因为流量减少，平均发酵时间也有所增加
m_ethan_fin2=p0*600*time2;%流入2号发酵罐的乙醇的质量
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time2,600,T2);    %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积   %调用自编函数求解，调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                            %该发酵罐最后时刻浓度值是进入混合器的初始值
p0=F(end,2);
s0=F(end,3);
% disp('发酵罐2出来的浓度')

m_ethan_final2=p0*600*time2;                        %2号发酵罐发酵完毕后的乙醇质量
m_sum2=m_sum1*yita1+((850.02+217)*flow2)*time2;     %2号发酵罐中液体的总质量
m_CO2_2=(m_ethan_final2-m_ethan_fin2)*44/46;        %生成CO2的质量
m_CO2_melt2=CO2rjd*600;                      %溶解在发酵罐子中的质量
mCO2_run2=m_CO2_2-m_CO2_melt2;                %求跑掉的气体质
methan_run2=mCO2_run2*jd;                %CO2带走的乙醇气体的质量
huifa=(m_ethan_final2-methan_run2)/m_ethan_final2;    %挥发后剩余质量比
yita2=(m_sum2-mCO2_run2)/m_sum2;        %物料保留率
%p0=p0*yita2;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
dresults=[dresults;F];
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes3);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('发酵罐2')
%%%因为发酵罐内混合是均匀的，所以单位时间流出的流量也是亏损的
xs=x0*(flowy+flow1+flow0+flowr+flow2)*yita2;          %单位时间从发酵罐2罐出来的菌体的质量
ps=p0*(flowy+flow1+flow0+flowr+flow2)*yita2;          %单位时间从发酵罐2罐出来的乙醇的质量
ss=s0*(flowy+flow1+flow0+flowr+flow2)*yita2;          %单位时间从发酵罐2罐出来的葡萄糖的质量
ss=ss+flow3*217;                                %从SPL3补充进来的葡萄糖
Vy=flow3+Vy*yita2;                                    %每个发酵罐入口的流量等于它之前的所有发酵罐流量和再加上进料口的流量
x0=xs/Vy;                                       %混合后各成分的浓度
p0=ps/Vy;   
s0=ss/Vy;
%[T,F]=ode45('func1',[0 time3],[x0 p0 s0]);  
time3=600/Vy;
m_ethan_fin3=p0*600*time3;%流入3号发酵罐的乙醇的质量
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time3,600,T3);    %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积   %调用自编函数求解，调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入下一个罐子的进料值,从3号罐子之后不再有混合器
p0=F(end,2);      
s0=F(end,3);
% disp('发酵罐3出来的浓度')

m_ethan_final3=p0*600*time3;                        %3号发酵罐发酵完毕后的乙醇质量
m_sum3=m_sum2*yita2+((850.02+217)*flow3)*time3;     %3号发酵罐中液体的总质量
m_CO2_3=(m_ethan_final3-m_ethan_fin3)*44/46;        %生成CO2的质量
m_CO2_melt3=CO2rjd*600;                      %溶解在发酵罐子中的质量
mCO2_run3=m_CO2_3-m_CO2_melt3;                %求跑掉的气体质
methan_run3=mCO2_run3*jd;                %CO2带走的乙醇气体的质量
huifa=(m_ethan_final3-methan_run3)/m_ethan_final3;    %挥发后剩余质量比
yita3=(m_sum3-mCO2_run3)/m_sum3;        %物料保留率
%p0=p0*yita3;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
dresults=[dresults;F];
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes4);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('发酵罐3')
%[T,F]=ode45('func1',[0 time4],[x0 p0 s0]);
%600/time4=yita3*600/time3
%time4=time3/yita3;                
m_ethan_fin4=p0*600*time4;%流入4号发酵罐的乙醇的质量
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time4,600,T4);     %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入下一个罐子的进料值
p0=F(end,2);
s0=F(end,3);
% disp('发酵罐4出来的浓度')
m_ethan_final4=p0*600*time4;                        %4号发酵罐发酵完毕后的乙醇质量
m_sum4=m_sum3*yita3;                                %4号发酵罐中液体的总质量
m_CO2_4=(m_ethan_final4-m_ethan_fin4)*44/46;        %生成CO2的质量
m_CO2_melt4=CO2rjd*600;                      %溶解在发酵罐子中的质量
mCO2_run4=m_CO2_4-m_CO2_melt4;                %求跑掉的气体质
methan_run4=mCO2_run4*jd;                %CO2带走的乙醇气体的质量
huifa=(m_ethan_final4-methan_run4)/m_ethan_final4;    %挥发后剩余质量比
yita4=(m_sum4-mCO2_run4)/m_sum4;        %物料保留
%yita4=(m_sum4-m_CO2_4)/m_sum4;                      %物料保留率(影响流量)
%p0=p0*yita4;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分
p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
dresults=[dresults;F];
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes5);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('发酵罐4')
%[T,F]=ode45('func2',[0 time5],[x0 p0 s0]); 
%time5=time4/yita4;
m_ethan_fin5=p0*500*time5;%流入5号发酵罐的乙醇的质量
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time5,600,T5); ;   %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
F=F';
x0=F(end,1);                                            %该发酵罐最后时刻浓度值是进入下一个罐子的进料值
p0=F(end,2);                                                 
s0=F(end,3);
% disp('发酵罐5出来的浓度')
m_ethan_final5=p0*500*time5;                        %5号发酵罐发酵完毕后的乙醇质量
m_sum5=m_sum4*yita4;                                %5号发酵罐中液体的总质量
m_CO2_5=(m_ethan_final5-m_ethan_fin5)*44/46;        %生成CO2的质量
m_CO2_melt5=CO2rjd*500;                      %溶解在发酵罐子中的质量
mCO2_run5=m_CO2_5-m_CO2_melt5;                %求跑掉的气体质
methan_run5=mCO2_run5*jd;                %CO2带走的乙醇气体的质量
huifa=(m_ethan_final5-methan_run5)/m_ethan_final5;    %挥发后剩余质量比
p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
yita5=(m_sum5-mCO2_run5)/m_sum5;        %物料保留
%yita5=(m_sum5-m_CO2_5)/m_sum5;                      %物料保留率
%p0=p0*yita5;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
dresults=[dresults;F];
% disp('乙醇的体积比是'),disp(p0/790)                      
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
axes(handles.axes6);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')             %用不同颜色标记不同组分的曲线
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('发酵罐5')
%time6=time5/yita5;
m_ethan_fin6=p0*500*time6;%流入5号发酵罐的乙醇的质量
[T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time6,600,T6);     %调用自编函数求解
F=F';
%[T,F]=ode45('func2',[0 time6],[x0 p0 s0]);       
x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入下一个罐子的进料值
p0=F(end,2);
s0=F(end,3);
m_ethan_final6=p0*500*time6;                        %5号发酵罐发酵完毕后的乙醇质量
m_sum6=m_sum5*yita5;                                %5号发酵罐中液体的总质量
m_CO2_6=(m_ethan_final6-m_ethan_fin6)*44/46;        %生成CO2的质量
m_CO2_melt6=CO2rjd*500;                      %溶解在发酵罐子中的质量
mCO2_run6=m_CO2_6-m_CO2_melt6;                %求跑掉的气体质
methan_run6=mCO2_run6*jd;                %CO2带走的乙醇气体的质量
huifa=(m_ethan_final6-methan_run6)/m_ethan_final6;    %挥发后剩余质量比
p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
axes(handles.axes7);
plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
xlabel('time(h)')
ylabel('thickness(kg/m3)')
title('发酵罐6')
results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
dresults=[dresults;F];
% disp('乙醇的体积比是'),disp(p0/790)                        %显示最后反应的结果
% disp('菌体的浓度是'),disp(x0)
% disp('葡萄糖的浓度是'),disp(s0)
% time2=600/(flowy+flow0+flow1+flow2+flowr);
% time3=600/(flowy+flow0+flow1+flowr+flow2+flow3);
% time4=600/(flowy+flow0+flow1+flow2+flowr+flow3);
% time5=500/(flowy+flow0+flow1+flow2+flowr+flow3);
% time6=500/(flowy+flow0+flow1+flow2+flowr+flow3);        %料液平均停留时间发酵罐体积除以流量
% results=[];   %显示六个发酵罐的最后浓度用的矩阵
% dresults=[];   %显示六个发酵罐的所有时刻浓度用的矩阵
% x0=37.47;     %1号口进料的菌体浓度
% p0=45.12;     %1号口进料乙醇的浓度
% s0=1.07;      %1号口进料葡萄糖的浓度
%               %求出三种量，每种物质的单位时间进量等于流量*浓度
% Vy=(flowy+flow0)/sr;      %求单位时间SPL0和1的混合液进料后的体积(不考虑互溶）
%                              
% xs=flowy*x0;        %单位时间进料的质量（菌体、乙醇、葡萄糖）
% ps=flowy*p0;
% ss=flowy*s0;     
% ss=ss+flow0*217;      %从SPL0补充进来的葡萄糖,217是补充进来糖类的浓度
% x0=xs/Vy;         %进料管中混合体中各成分的浓度
% p0=ps/Vy;   
% s0=ss/Vy;
% %[T,F]=ode45('func',[0 0.5 time0],[x0 p0 s0]);   %调用ode45来求解 
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,1,150,T0);    %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
% F=F';
% x0=F(end,1);                                        %发酵罐中停留时间的最后时刻浓度值流入混合器的初始值
% p0=F(end,2);
% s0=F(end,3);
% 
% % disp('预发酵罐出来的浓度')
% % results=[results;x0,p0/790,x0];                       %将该罐的结果保存为一列
% % disp('乙醇的体积比是'),disp(p0/790)                      
% % disp('菌体的浓度是'),disp(x0)
% % disp('葡萄糖的浓度是'),disp(s0)                                   %显示该罐发酵结果
% axes(handles.axes1);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('预发酵罐')
% xs=(flowy+flow0)*x0;       
% ps=(flowy+flow0)*p0;
% ss=(flowy+flow0)*s0;     %单位时间从预发酵罐出来的葡萄糖的质量,流量是1与SPL0的和
% ss=ss+flow1*217;      %单位时间从SPL1补充进来的葡萄糖
% xs=xs+flowr*147;     %反馈回来的质量
% ps=ps+flowr*100;
% ss=ss+0.5*flowr;
% Vy=(flow1+flowr+Vy)/sr;          %增加了SPL1和RCY的流量
% x0=xs/Vy;       %混合后各成分的浓度
% p0=ps/Vy;   
% s0=ss/Vy;
% %[T,F]=ode45('func1',[0 time1],[x0 p0 s0]);  
% m_ethan_fin1=p0*600*time1;%流入1号发酵罐的乙醇的质量
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time1,600,T1);    %调用自编函数求解，调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
% F=F';                                                    %为了保持与ode风格相似转置成列向量
% x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入混合器的初始值
% p0=F(end,2);
% s0=F(end,3);
% 
% m_ethan_final1=p0*600*time1; %1号发酵罐发酵完毕后的乙醇质量
% m_sum1=((852.21+1.07+45.12+37.47)*flowy+(850+217)*(flow0+flow1)+(752.92+0.5+100+147)*flowr)*time1;%1号发酵罐中液体的总质量
% m_CO2_1=(m_ethan_final1-m_ethan_fin1)*44/46;%生成CO2的质量
% m_CO2_melt1=CO2rjd*600;                      %溶解在发酵罐子中的质量
% mCO2_run1=m_CO2_1-m_CO2_melt1;                %求跑掉的气体质量
% yita1=(m_sum1-mCO2_run1)/m_sum1;             %物料保留率
% p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
% % disp('发酵罐1出来的浓度')
% results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一列
% dresults=[dresults;F];
% % disp('乙醇的体积比是'),disp(p0/790)                      
% % disp('菌体的浓度是'),disp(x0)
% % disp('葡萄糖的浓度是'),disp(s0)
% axes(handles.axes2);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')               %每一列是一种成分的浓度序列
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('发酵罐1')
% % legend('菌体','乙醇','葡萄糖')
% xs=(flowy+flow1+flow0+flowr)*x0;
% ps=(flowy+flow1+flow0+flowr)*p0;
% ss=(flowy+flow1+flow0+flowr)*s0;     %单位时间从发酵罐1出来的葡萄糖的质量
% ss=ss+flow2*217;      %单位时间从SPL2补充进来的葡萄糖
% Vy=flow2+Vy*yita1;  %SPL2单位时间混合后的体积,流出量有亏损
% %Vy=flow2+Vy;  %SPL2单位时间混合后的体积
% x0=xs/Vy;       %单位时间混合体中各成分的浓度
% p0=ps/Vy;   
% s0=ss/Vy;
% %[T,F]=ode45('func1',[0 time2],[x0 p0 s0]);   
% time2=600/Vy;             %因为流量减少，平均发酵时间也有所增加
% m_ethan_fin2=p0*600*time2;%流入2号发酵罐的乙醇的质量
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time2,600,T2);   %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
% F=F';
% x0=F(end,1);                                            %该发酵罐最后时刻浓度值是进入混合器的初始值
% p0=F(end,2);
% s0=F(end,3);
% % disp('发酵罐2出来的浓度')
% m_ethan_final2=p0*600*time2;                        %2号发酵罐发酵完毕后的乙醇质量
% m_sum2=m_sum1*yita1+((850.02+217)*flow2)*time2;     %2号发酵罐中液体的总质量
% m_CO2_2=(m_ethan_final2-m_ethan_fin2)*44/46;        %生成CO2的质量
% m_CO2_melt2=CO2rjd*600;                      %溶解在发酵罐子中的质量
% mCO2_run2=m_CO2_2-m_CO2_melt2;                %求跑掉的气体质
% yita2=(m_sum2-mCO2_run2)/m_sum2;        %物料保留率
% %p0=p0*yita2;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
% p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
% results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
% dresults=[dresults;F];
% % disp('乙醇的体积比是'),disp(p0/790)                      
% % disp('菌体的浓度是'),disp(x0)
% % disp('葡萄糖的浓度是'),disp(s0)
% axes(handles.axes3);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('发酵罐2')
% xs=x0*(flowy+flow1+flow0+flowr+flow2);          %单位时间从发酵罐2罐出来的菌体的质量
% ps=p0*(flowy+flow1+flow0+flowr+flow2);          %单位时间从发酵罐2罐出来的乙醇的质量
% ss=s0*(flowy+flow1+flow0+flowr+flow2);          %单位时间从发酵罐2罐出来的葡萄糖的质量
% ss=ss+flow3*217;                                %从SPL3补充进来的葡萄糖
% Vy=flow3+Vy*yita2;                               %每个发酵罐入口的流量等于它之前的所有发酵罐流量和再加上进料口的流量(有衰减)
% x0=xs/Vy;                                       %混合后各成分的浓度
% p0=ps/Vy;   
% s0=ss/Vy;
% time3=600/Vy;
% %[T,F]=ode45('func1',[0 time3],[x0 p0 s0]); 
% m_ethan_fin3=p0*600*time3;%流入3号发酵罐的乙醇的质量
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time3,600,T3);   %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
% F=F';
% x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入下一个罐子的进料值,从3号罐子之后不再有混合器
% p0=F(end,2);      
% s0=F(end,3);
% % disp('发酵罐3出来的浓度')
% m_ethan_final3=p0*600*time3;                        %3号发酵罐发酵完毕后的乙醇质量
% m_sum3=m_sum2*yita2+((850.02+217)*flow3)*time3;     %3号发酵罐中液体的总质量
% m_CO2_3=(m_ethan_final3-m_ethan_fin3)*44/46;        %生成CO2的质量
% m_CO2_melt3=CO2rjd*600;                      %溶解在发酵罐子中的质量
% mCO2_run3=m_CO2_3-m_CO2_melt3;                %求跑掉的气体质
% yita3=(m_sum3-mCO2_run3)/m_sum3;        %物料保留率
% %p0=p0*yita3;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
% p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
% 
% results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
% dresults=[dresults;F];
% % disp('乙醇的体积比是'),disp(p0/790)                      
% % disp('菌体的浓度是'),disp(x0)
% % disp('葡萄糖的浓度是'),disp(s0)
% axes(handles.axes4);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('发酵罐3')
% axes(handles.axes8);
% imshow('legend.jpg');
% %[T,F]=ode45('func1',[0 time4],[x0 p0 s0]);   
% time4=time3/yita3;   
% m_ethan_fin4=p0*600*time4;%流入4号发酵罐的乙醇的
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time4,600,T4);    %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
% F=F';
% x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入下一个罐子的进料值
% p0=F(end,2);
% s0=F(end,3);
% m_ethan_final4=p0*600*time4;                        %4号发酵罐发酵完毕后的乙醇质量
% m_sum4=m_sum3*yita3;                                %4号发酵罐中液体的总质量
% m_CO2_4=(m_ethan_final4-m_ethan_fin4)*44/46;        %生成CO2的质量
% m_CO2_melt4=CO2rjd*600;                      %溶解在发酵罐子中的质量
% mCO2_run4=m_CO2_4-m_CO2_melt4;                %求跑掉的气体质
% yita4=(m_sum4-mCO2_run4)/m_sum4;        %物料保留
% %yita4=(m_sum4-m_CO2_4)/m_sum4;                      %物料保留率(影响流量)
% %p0=p0*yita4;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分
% p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
% % disp('发酵罐4出来的浓度')
% results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
% dresults=[dresults;F];
% % disp('乙醇的体积比是'),disp(p0/790)                      
% % disp('菌体的浓度是'),disp(x0)
% % disp('葡萄糖的浓度是'),disp(s0)
% axes(handles.axes5);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('发酵罐4')
% %[T,F]=ode45('func2',[0 time5],[x0 p0 s0]);   
% time5=time4/yita4;
% m_ethan_fin5=p0*500*time5;%流入5号发酵罐的乙醇的质量
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time5,500,T5);   %调用自编函数求解参数分别是动力学函数入口，方程组初始值，步长，时间起点，时间终点，发酵液体积
% F=F';
% x0=F(end,1);                                            %该发酵罐最后时刻浓度值是进入下一个罐子的进料值
% p0=F(end,2);                                                 
% s0=F(end,3);
% m_ethan_final5=p0*500*time5;                        %5号发酵罐发酵完毕后的乙醇质量
% m_sum5=m_sum4*yita4;                                %5号发酵罐中液体的总质量
% m_CO2_5=(m_ethan_final5-m_ethan_fin5)*44/46;        %生成CO2的质量
% m_CO2_melt5=CO2rjd*500;                      %溶解在发酵罐子中的质量
% mCO2_run5=m_CO2_5-m_CO2_melt5;                %求跑掉的气体质
% p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰减
% yita5=(m_sum5-mCO2_run5)/m_sum5;        %物料保留
% % disp('发酵罐5出来的浓度')
% results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
% dresults=[dresults;F];
% % disp('乙醇的体积比是'),disp(p0/790)                      
% % disp('菌体的浓度是'),disp(x0)
% % disp('葡萄糖的浓度是'),disp(s0)
% axes(handles.axes6);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')             %用不同颜色标记不同组分的曲线
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('发酵罐5')
% time6=time5/yita5;
% m_ethan_fin6=p0*500*time6;%流入5号发酵罐的乙醇的质量
% [T,F]=runge_kuttaT(@Tfunc,[x0 p0 s0],0.1,0,time6,500,T6);    %调用自编函数求解
% F=F';
% %[T,F]=ode45('func2',[0 time6],[x0 p0 s0]);       
% x0=F(end,1);                                             %该发酵罐最后时刻浓度值是进入下一个罐子的进料值
% p0=F(end,2);
% s0=F(end,3);
% m_ethan_final6=p0*500*time6;                        %5号发酵罐发酵完毕后的乙醇质量
% m_sum6=m_sum5*yita5;                                %5号发酵罐中液体的总质量
% m_CO2_6=(m_ethan_final6-m_ethan_fin6)*44/46;        %生成CO2的质量
% m_CO2_melt6=CO2rjd*500;                      %溶解在发酵罐子中的质量
% mCO2_run6=m_CO2_6-m_CO2_melt6;                %求跑掉的气体质
% p0=p0*huifa;                         %由于CO2放出的同时也会有乙醇气体溢出，而且两个气体分子量基本相同，所以要考虑其浓度衰
% results=[results;x0,p0/790,s0];                       %将该罐的结果保存为一行
% dresults=[dresults;F];
% axes(handles.axes7);
% plot(T,F(:,1),'r',T,F(:,2),'b',T,F(:,3),'g')
% xlabel('time(h)')
% ylabel('concentration(kg/m3)')
% title('发酵罐6')
dresults(:,2)=dresults(:,2)/790;
set(handles.edit7,'string',num2str(time1+time2+time3+time4+time5+time6));     %显示发酵时间
set(handles.edit8,'string',num2str(x0));
set(handles.edit9,'string',num2str(p0/7.9));
set(handles.edit10,'string',num2str(s0));

flag=get(handles.checkbox1,'value');                  %检测详细显示是不是被选中了
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
set(0,'currentfigure',start_interface);
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
xlswrite('dataT.xls',str2num(data));
msgbox('已经保存为dataT.xls文件');
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
delete('dataT.xls');
msgbox('已经清除dataT.xls文件');
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


