clear all
M=4;
msg = [1 2 3 0 3 2 1 1]; %��Ϣ�ź�
ts = 0.01; %����ʱ����
T = 1; %��������
t = 0:ts:T; %���ų���ʱ������
x = 0:ts:length(msg); %���з��ŵĴ���ʱ��
fc = 1; %�ز�Ƶ��
c = sqrt(2/T)*exp(j*2*pi*fc*t); %�ز��ź�
msg_psk = pskmod(msg,M).'; %����4-PSK����
msg_dpsk = dpskmod(msg,M).'; %����4-DPSK����
tx_psk = real(msg_psk*c); %�ز�����
tx_psk= reshape(tx_psk.',1,length(msg)*length(t));
tx_dpsk = real(msg_dpsk*c); %�ز�����
tx_dpsk= reshape(tx_dpsk.',1,length(msg)*length(t));
subplot(2,1,1)
plot(x,tx_psk(1:length(x)));
title("4PSK�źŲ���")
xlabel("ʱ��t");ylabel("�ز����");
subplot(2,1,2)
plot(x,tx_dpsk(1:length(x)));
title("4DPSK�źŲ���")
xlabel("ʱ��t");ylabel("�ز����");