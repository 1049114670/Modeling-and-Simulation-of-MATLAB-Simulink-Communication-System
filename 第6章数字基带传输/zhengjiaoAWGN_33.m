clear all

EbN0 = 0:12

for ii=1:length(EbN0)
    SNR=EbN0(ii);
    sim("zhengjiaoAWGN_3");
    ber(ii) = BER(1);
end

semilogy(EbN0,ber,"-ko", EbN0, qfunc(sqrt(10.^(EbN0/10))));
title("�����������ź���AWGN�ŵ��µ������������")
xlabel("EbN0");
ylabel("�������Pe");
legend("������", "���۽��");