clear all
ts = 0.001; %�źų���ʱ����
t = 0:ts:5-ts; %ʱ������
fs = 1/ts; %����Ƶ��
df = fs/length(t); %fft��Ƶ�ʷֱ���
msg = randi([-3,3],10,1); %������Ϣ����
msg1 = msg*ones(1,fs/2); %��չ��ȡ���ź���ʽ
msg2 = reshape(msg1.',1,length(t));
Pn = fft(msg2)/fs; %����Ϣ�źŵ�Ƶ��
f = -fs/2:df:fs/2-df;

subplot(2,1,1)
plot(t,fftshift(abs(Pn))) %������Ϣ�ź�Ƶ��
title("��Ϣ�ź�Ƶ��")

int_msg(1)=0;
for ii=1:length(t)-1
    int_msg(ii+1)=int_msg(ii)+msg2(ii)*ts
end

kf = 50;
fc=250;
Sfm = cos(2*pi*fc*t+2*pi*kf*int_msg); %��Ƶ�ź�
Pfm = fft(Sfm)/fs;

subplot(2,1,2)
plot(f,fftshift(abs(Pfm))); %�����ѵ��ź�Ƶ��
title("FM�ź�Ƶ��")


Pc = sum(abs(Sfm).^2)/length(Sfm); %�ѵ��źŹ���
Ps = sum(abs(msg2).^2)/length(msg2);  %��Ϣ�źŹ���

fn = 50;
betaf = kf/max(msg)/fn;  %����ָ��
W = 2*(betaf + 1)*fn; %���ƴ���
