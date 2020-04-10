clear all
ts = 0.0025; %�źų���ʱ����
t = 0:ts:10-ts; %ʱ������
fs = 1/ts; %����Ƶ��
df = fs/length(t); %fft��Ƶ�ʷֱ���
msg = randi([-3,3],100,1); %������Ϣ����
msg1 = msg*ones(1,fs/10); %��չ��ȡ���ź���ʽ
msg2 = reshape(msg1.',1,length(t));
Pn = fft(msg2)/fs; %����Ϣ�źŵ�Ƶ��
f = -fs/2:df:fs/2-df;
subplot(3,1,1)
plot(f,msg2) %������Ϣ�ź�
title("��Ϣ�ź�")

A=4;
fc=100;
Sam=(A+msg2).*cos(2*pi*fc*t); %�ѵ��ź�

dems = abs(hilbert(Sam))-A;
subplot(3,1,2)
plot(t,dems)
title("�������Ľ���ź�")

y=awgn(Sam,20,"measured");
dems2 = abs(hilbert(y))-A;
subplot(3,1,3)
plot(t,dems2)
title("�����Ϊ20ʱ�ĵĽ���ź�")

