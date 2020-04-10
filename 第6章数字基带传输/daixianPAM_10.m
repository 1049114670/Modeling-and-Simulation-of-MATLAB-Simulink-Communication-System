% �д�����
clear all
nsymbol = 100000; %ÿ��SNR�·��͵ķ�����

Fd = 1; %���Ų���Ƶ��
Fs = 10; %�˲�������Ƶ��
rolloff = 0.25; %�˲�������ϵ��
delay = 5; %�˲���ʱ��
M=4; %4-PAM
graycode = [0 1 3 2];
EsN0 = 0:15;
msg = randi([0,1],1,nsymbol);
msg1 = graycode(msg+1); % Grayӳ��
msgmod = pammod(msg1, M); %4-PAM����
rrcfilter = rcosine(Fd,Fs,'fir/sqrt',rolloff,delay); %��Ƹ��������˲���
s = rcosflt(msgmod,Fd,Fs,'filter',rrcfilter);

for indx=1:length(EsN0)
    demsg = zeros(1,nsymbol);
    r = awgn(real(s),EsN0(indx)-7, "measured");
    rx = rcosflt(r,Fd,Fs,'filter',rrcfilter);
    rx1 = downsample(rx,Fs);
    rx2 = rx1(2*delay+1:end-2*delay);
    msg_demod=pamdemod(rx2,M); %�о�
    demsg = graycode(msg_demod+1);
    [err,ber(indx)] = biterr(msg,demsg,log2(M));
    [err,ser(indx)] = symerr(msg,demsg);
end

semilogy(EsN0,ber,"-ko", EsN0, ser, "-k*", EsN0, 1.5*qfunc(sqrt(0.4*10.^(EsN0/10))), "-ro");
title("4-PAM�ź���AWGN�ŵ��µ������������")
xlabel("EbN0");
ylabel("�������P���������");
legend("�������", "�������", "�����������")