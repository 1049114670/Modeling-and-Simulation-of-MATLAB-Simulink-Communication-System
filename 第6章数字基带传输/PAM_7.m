clear all
nsamp = 10; %ÿ�������źŵĳ�������

nsymbol = 100000; %ÿ��SNR�·��͵ķ�����

M=4; %4-PAM
graycode = [0 1 3 2];
EsN0 = 0:15;
msg = randi([0,1],1,nsymbol);
msg1 = graycode(msg+1); % Grayӳ��
msg2 = pammod(msg1, M); %4-PAM����
s = rectpulse(msg2,nsamp); %�������岨��

for indx=1:length(EsN0)
    demsg = zeros(1,nsymbol);
    r = awgn(real(s),EsN0(indx)-7, "measured");
    r1 = intdump(r,nsamp); %��������
    msg_demod=pamdemod(r1,M); %�о�
    demsg = graycode(msg_demod+1);
    [err,ber(indx)] = biterr(msg,demsg,log2(M));
    [err,ser(indx)] = symerr(msg,demsg);
end

semilogy(EsN0,ber,"-ko", EsN0, ser, "-k*", EsN0, 1.5*qfunc(sqrt(0.4*10.^(EsN0/10))), "-ro");
title("4-PAM�ź���AWGN�ŵ��µ������������")
xlabel("EbN0");
ylabel("�������P���������");
legend("�������", "�������", "�����������")


