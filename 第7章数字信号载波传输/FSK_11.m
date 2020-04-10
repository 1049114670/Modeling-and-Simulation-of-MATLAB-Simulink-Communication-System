%4-QAM��4-FSKͨ��rayleigh˥���ŵ�����
clear all
nsymbol = 100000; %ÿ��SNR�·��͵ķ�����
SymbolRate = 1000; %fuhaosulv
nsamp = 50; %ÿ�����ŵ�ȡ������
fs = nsamp*SymbolRate; %����Ƶ��
fd = 100; % Rayleigh˥���ŵ�����������Ƶ��
chan = rayleighchan(1/fs,fd); %����Rayleigh˥���ŵ�

M=4; 
graycode = [0 1 3 2];
EsN0 = 0:2:20;
snr1 = 10.^(EsN0/10); %�����ת��Ϊ����ֵ
msg = randi([0,1],1,nsymbol);
msg1 = graycode(msg+1); % Grayӳ��
x1 = qammod(msg1,M); %����4-QAM����
x1 = rectpulse(x1,nsamp);
x2 = fskmod(msg1,M, SymbolRate, nsamp,fs); %4-FSK����
spow1 = norm(x1).^2/nsymbol; %��ÿ�����ŵ�ƽ������
spow2 = norm(x2).^2/nsymbol; %��ÿ�����ŵ�ƽ������

for indx=1:length(EsN0)
    sigma1 = sqrt(spow1/(2*snr1(indx))); %���ݷ��Ź�������������
    sigma2 = sqrt(spow2/(2*snr1(indx))); %���ݷ��Ź�������������
    fadeSig1 = filter(chan,x1);
    fadeSig2 = filter(chan,x2);
    rx1 = fadeSig1+sigma1*(randn(1,length(x1))+j*randn(1,length(x1))); %�Ӹ�˹������
    rx2 = fadeSig2+sigma1*(randn(1,length(x2))+j*randn(1,length(x2))); %�Ӹ�˹������
    y1 = intdump(rx1,nsamp); %���
    y1 = qamdemod(y1,M);
    demsg1 = graycode(y1+1);
    [err,ber1(indx)] = biterr(msg,demsg1,log2(M));
    [err,ser1(indx)] = symerr(msg,demsg1);
    y2 = fskdemod(rx2,M,SymbolRate,nsamp,fs);
    demsg2 = graycode(y2+1);
    [err,ber2(indx)] = biterr(msg,demsg2,log2(M));
    [err,ser2(indx)] = symerr(msg,demsg2);
end

semilogy(EsN0,ber1,"-ko", EsN0, ser1, "-k*", EsN0, ser2, "-ro", EsN0, ber2, "-r*");
title("4-QAM��4-FSK�����ź���rayleigh˥���ŵ�������")
xlabel("EbN0");
ylabel("�������P���������");
legend("4-QAM�������", "4-QAM�������", "4-FSK�������", "4-FSK�������")