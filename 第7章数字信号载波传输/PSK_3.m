%8PSK
clear all
nsymbol = 100000; %ÿ��SNR�·��͵ķ�����

T = 1; %��������
fs = 100; %ÿ�����ŵĲ�������
ts = 1/fs; %����ʱ����
t = 0:ts:T-ts; %ʱ������
fc = 10;%�ز�Ƶ��
c = sqrt(2/T)*exp(j*2*pi*fc*t); %�ز��ź�
c1 = sqrt(2/T)*cos(2*pi*fc*t);  %ͬ���ز�
c2 = sqrt(2/T)*sin(2*pi*fc*t);  %�����ز�

M=8; %8-PAM
graycode = [0 1 2 3 6 7 4 5];
EsN0 = 0:15;
snr1 = 10.^(EsN0/10); %�����ת��Ϊ����ֵ
msg = randi([0,1],1,nsymbol);
msg1 = graycode(msg+1); % Grayӳ��
msgmod = pskmod(msg1, M); %8-PSK����
tx = real(msgmod'*c); %�ز�����
tx1= reshape(tx.',1,length(msgmod)*length(c));
spow = norm(tx1).^2/nsymbol; %��ÿ�����ŵ�ƽ��gonglv

for indx=1:length(EsN0)
    sigma = sqrt(spow/(2*snr1(indx))); %���ݷ��Ź�������������
    rx = tx1+sigma*randn(1,length(tx1)); %�����˹������
    rx1 = reshape(rx,length(c),length(msgmod));
    r1 = (c1*rx1)/length(c1); %�������
    r2 = (c2*rx1)/length(c2); %�������
    r = r1+j*r2;
    y = pskdemod(r,M); %�о�
    demsg = graycode(y+1);
    [err,ber(indx)] = biterr(msg,demsg,log2(M));
    [err,ser(indx)] = symerr(msg,demsg);
end

ser1 = 2*qfunc(sqrt(2*snr1)*sin(pi/M));
ber1 = 1/log2(M)*ser1;
semilogy(EsN0,ber,"-ko", EsN0, ser, "-k*", EsN0, ser1, "-ro", EsN0, ber1, "-r*");
title("8-PSK�ز������ź���AWGN�ŵ��µ������������")
xlabel("EbN0");
ylabel("�������P���������");
legend("�������", "�������", "�����������", "�����������")