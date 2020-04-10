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
subplot(2,1,1)
plot(f,fftshift(abs(Pn))) %������Ϣ�ź�Ƶ��
title("��Ϣ�ź�Ƶ��")


A=4;
fc = 100; %�ز�Ƶ��
Sam=(A+msg2).*cos(2*pi*fc*t); %�ѵ��ź�
Pam = fft(Sam)/fs;
subplot(2,1,2)
plot(f,fftshift(abs(Pam))); %�����ѵ��ź�Ƶ��
title("AM�ź�Ƶ��")
axis([-200 200 0 23])
Pc = sum(abs(Sam).^2)/length(Sam) %�ѵ��źŹ���
Ps = Pc-A^2/2
eta = Ps/Pc