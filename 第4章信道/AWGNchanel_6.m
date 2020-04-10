clear all
nSamp = 8; %���������ȡ������
numSymb = 1000000; %ÿ��snr�´���ķ�����
M=4; %QPSK�ķ���������
SNR=-3:3;
grayencod = [0 1 3 2] %Gray�����ʽ
for ii=1:length(SNR)
    msg = randsrc(1,numSymb,[0:3]);
    msg_gr = grayencod(msg+1);
    msg_tx = pskmod(msg_gr,M);
    msg_tx = rectpulse(msg_tx, nSamp);
    msg_rx = awgn(msg_tx,SNR(ii),"measured");
    msg_rx_down = intdump(msg_rx,nSamp);
    msg_gr_demod=pskdemod(msg_rx_down,M);
    [dumay graydecod] = sort(grayencod);graydecod = graydecod - 1;
    msg_demod = graydecod(msg_gr_demod+1);
    [errorBit BER(ii)] = biterr(msg, msg_demod,log2(M));
    [errorSym SER(ii)] = symerr(msg, msg_demod);
end
scatterplot(msg_tx(1:100))
title("�����ź�����ͼ")
xlabel("ͬ�����")
ylabel("��������")
scatterplot(msg_rx(1:100))
title("�����ź�����ͼ")
xlabel("ͬ�����")
ylabel("��������")
figure
semilogy(SNR,BER,"-ro", SNR,SER,"-r*")
legend("BER","SER")
title("QPSK��AWGN�ŵ��µ�����")
xlabel("����ȣ�dB��")
ylabel("������ʺ�������")