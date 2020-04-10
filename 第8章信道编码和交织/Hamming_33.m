clear all
EbN0 = 0:2:10; %SNR��Χ
SymbolRate = 50000; %��������
for ii=1:length(EbN0)
    ii
    SNR=EbN0(ii); %��ֵ��AWGN�ŵ�ģ���е�SNR
    sim('Hamming_3'); %���з���ģ��
    ber1(ii)=BER1(1);
    ber2(ii)=BER2(2);
end

semilogy(EbN0,ber1,'-ko',EbN0,ber2,'-k*');
legend("δ����","Hamming(7,4)����");
title("δ�����Hamming(7,4)�����QPSK��AWGN�ŵ��µ�����")
xlabel("Eb/N0");ylabel("�������");
