%����������������
clear all
EbN0 = 0:2:10; %SNR�ķ�Χ
ber = berawgn(EbN0,'qam',16);
for ii=1:length(EbN0)
    ii
    BER=ber(ii); %��ֵ��BSC�ŵ��е�BER
    sim('RS_7'); %���з���ģ��
    ber1(ii)=BER(1);
end
semilogy(EbN0,ber,'-ko',EbN0,ber1,'-k*');
legend("δ����","RS(15,11)����");
title("δ�����RS(15,11)�����16-QAM��AWGN�ŵ��µ�����")
xlabel("Eb/N0");ylabel("�������");