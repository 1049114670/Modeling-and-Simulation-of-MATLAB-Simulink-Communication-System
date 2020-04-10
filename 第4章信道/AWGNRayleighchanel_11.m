clear all
snr=-3:3;
Simulationtime=10;
AWGNchanel_7;
ser1 = ser;ber1 = ber;
for ii=1:length(snr)
    SNR=snr(ii)
    sim("awgnrayleighmodel");
    ber(ii)=BER(1);
    ser(ii)=SER(1);
end
figure
semilogy(snr,ber,"-ro", snr,ser,"-r*",snr,ber1,"-r.", snr,ser1,"-r+")
legend("Rayleigh˥��+AWGN�ŵ�BER","Rayleigh˥��+AWGN�ŵ�SER","AWGN�ŵ�BER","AWGN�ŵ�SER")
title("QPSK��AWGN�ŵ���Rayleigh˥���ŵ��µ�����")
xlabel("�����(dB)")
ylabel("������ʺ�������")