clear all
EbN0 = 0:2:10; %SNR�ķ�Χ
ber = berawgn(EbN0,'qam',16);
for ii=1:length(EbN0)
    ii
    BER=ber(ii); %��ֵ��BSC�ŵ��е�BER
    sim('CRC_8'); %���з���ģ��
    pmissed(ii)=MissedFrame(end)/length(MissedFrame);
end
semilogy(EbN0,pmissed)
title("CRC-16�������")
xlabel("Eb/N0");ylabel("©�����");
% axis([0 8 10.^(-6) 10.^(-3)])