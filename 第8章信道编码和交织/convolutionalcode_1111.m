clear all
Lc = 7; %�����Լ������
BitRate=100000; %��������
EbN0 = 0:2:10; %SNR�ķ�Χ

for ii=1:length(EbN0)
    ii
    SNR=EbN0(ii); %��ֵ��AWGN�ŵ��е�SNR
    sim('convolutionalcode_11'); %���з���ģ��
    ber1(ii)=BER1(1);
    ber2(ii)=BER2(1);
end

ber = berawgn(EbN0,'psk',2,'nodiff'); %BPSK���Ƶ������������
semilogy(EbN0,ber,'-ko',EbN0,ber1,'-k*',EbN0,ber2,'-k+');
legend("BPSK���Ƶ������������","Ӳ�о��������","���о��������");
title("���������")
xlabel("Eb/N0");ylabel("�������");