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


fc = 100; %�ز�Ƶ��
Sdsb=msg2.*cos(2*pi*fc*t); %DSB�ź��ź�
Pdsb = fft(Sdsb)/fs; %DSB�ź�Ƶ��
f_stop = 100; %��ͨ�˲����Ľ�ֹƵ��
n_stop = floor(f_stop/df);
Hlow = zeros(size(f));
Hlow(1:n_stop)=2; %��Ƶ�ͨ�˲���
Hlow(length(f)-n_stop+1:end)=2;
Plssb = Pdsb.*Hlow;
subplot(2,1,2)
plot(f,fftshift(abs(Plssb))); %�����ѵ��ź�Ƶ��
title("LSSB�ź�Ƶ��")
axis([-200 200 0 2])

S1ssb = real(ifft(Plssb))*fs;
Pc = sum(abs(S1ssb).^2)/length(S1ssb); %�ѵ��źŹ���
Ps = sum(abs(msg2).^2)/length(msg2);  %��Ϣ�źŹ���