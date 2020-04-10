%8-DPSK
clear all
nsymbol = 100000; %ÿ��SNR�·��͵ķ�����

M=8; %8-DPSK
graycode = [0 1 2 3 6 7 4 5];
EsN0 = 5:20;
snr1 = 10.^(EsN0/10); %�����ת��Ϊ����ֵ
msg = randi([0,1],1,nsymbol);
msg1 = graycode(msg+1); % Grayӳ��
msgmod = pskmod(msg1, M); %8-PSK����
spow = norm(msgmod).^2/nsymbol; %��ÿ�����ŵ�ƽ��gonglv

for indx=1:length(EsN0)
    sigma = sqrt(spow/(2*snr1(indx))); %���ݷ��Ź�������������
    rx = msgmod+sigma*(randn(1,length(msgmod))+j*randn(1,length(msgmod))); %�����˹������
    y = dpskdemod(rx,M); %�о�
    demsg = graycode(y+1);
    [err,ber(indx)] = biterr(msg(2:end),demsg(2:end),log2(M));
    [err,ser(indx)] = symerr(msg(2:end),demsg(2:end));
end

ser1 = 2*qfunc(sqrt(2*snr1)*sin(pi/M));
ber1 = 1/log2(M)*ser1;
semilogy(EsN0,ber,"-ko", EsN0, ser, "-k*", EsN0, ser1, "-ro", EsN0, ber1, "-r*");
title("8-DPSK�ز������ź���AWGN�ŵ��µ������������")
xlabel("EbN0");
ylabel("�������P���������");
legend("�������", "�������", "�����������", "�����������")