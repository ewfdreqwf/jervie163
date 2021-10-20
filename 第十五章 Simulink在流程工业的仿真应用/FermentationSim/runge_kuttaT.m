function [x,y]=runge_kuttaT(ufunc,y0,h,a,b,Vg,tem)    %������˳��������΢�ַ�����ĺ������ƣ���ʼֵ������������ʱ����㣬ʱ���յ�,���͹����,�����¶�
global x0 p0 s0 Yxs Yps umax vmax Ks Kps Kp Kpp Ksi Kpsi Kpi Kppi T F Vy Temp A E R Ts
Temp=tem;                                           %�������¶Ȳ������ݸ�ȫ�ֱ���
Ts=[Ts,Temp];
n=floor((b-a)/h);                                    %����
x(1)=a;                                       %ʱ�����
y(:,1)=y0;                                    %����ֵ������������������Ҫע��ά��
for ii=1:n
   x(ii+1)=x(ii)+h;
   k1=ufunc(x(ii),y(:,ii),Vg);
   k2=ufunc(x(ii)+h/2,y(:,ii)+h*k1/2,Vg);
   k3=ufunc(x(ii)+h/2,y(:,ii)+h*k2/2,Vg);
   k4=ufunc(x(ii)+h,y(:,ii)+h*k3,Vg);
   y(:,ii+1)=y(:,ii)+h*(k1+2*k2+2*k3+k4)/6;       %���������������������ֵ���
end 
