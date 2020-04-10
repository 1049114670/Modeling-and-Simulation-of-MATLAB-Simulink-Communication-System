function [h] = reyleigh(fd,t)
%REYLEIGH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
N=40;
wn=2*pi*fd;
N0=N/4;
Tc = zeros(1,length(t));
Ts = zeros(1,length(t));
P_nor = sqrt(1/N0);
theta = 2*pi*rand(1,1)-pi;
for ii=1:N0
    alfa(ii)=(2*pi*ii-pi+theta)/N;
    fi_tc = 2*pi*rand(1,1)-pi;
    fi_ts = 2*pi*rand(1,1)-pi;
    Tc = Tc+cos(cos(alfa(ii))*wn*t+fi_tc);
    Ts = Ts+cos(sin(alfa(ii))*wn*t+fi_ts);
end

h = P_nor*(Tc+j*Ts);

