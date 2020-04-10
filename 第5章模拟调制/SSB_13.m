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
plot(t,msg2) %������Ϣ�ź�
title("��Ϣ�ź�")


fc = 100; %�ز�Ƶ��
s1 = 0.5*msg2.*cos(2*pi*fc*t); %USSB�źŵ�ͬ�����
hmsg = imag(hilbert(msg2)); %��Ϣ�źŵ�Hilbert�仯
s2 = 0.5*hmsg.*sin(2*pi*fc*t); %USSB�źŵ���������
Sussb = s1-s2; %������USSB�ź�
y = Sussb.*cos(2*pi*fc*t); %��ɽ��
Y = fft(y)./fs; %������Ƶ��
f_stop = 100; %��ͨ�˲����Ľ�ֹƵ��
n_stop = floor(f_stop/df);
Hlow = zeros(size(f));
Hlow(1:n_stop)=2; %��Ƶ�ͨ�˲���
Hlow(length(f)-n_stop+1:end)=2;
DEM = Y.*Hlow; %����ź�ͨ����ͨ�˲���
dem = real(ifft(DEM))*fs; %���յõ��Ľ���ź�
subplot(3,1,2)
plot(t,dem)
title("�������Ľ���ź�")

y1=awgn(Sussb,20,"measured"); %�����ź�ͨ��AWGN�ŵ�
y2 = y1.*cos(2*pi*fc*t); %��ɽ��
Y2 = fft(y2)./fs;%������Ƶ��
DEM1 = Y2.*Hlow;%����ź�ͨ����ͨ�˲���
dem1 = real(ifft(DEM1))*fs;%���յõ��Ľ���ź�
subplot(3,1,3)
plot(t,dem1)
title("�����Ϊ20ʱ�ĵĽ���ź�")