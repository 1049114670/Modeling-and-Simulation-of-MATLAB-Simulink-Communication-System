clear all
EbN0 = 0:2:10; %SNR��Χ
N = 1000000; %��Ϣ���ظ���
M = 2; %BPSK����
L = 7; %Լ������
tre1 = poly2trellis(L,[171 133]); %���������ɶ���ʽ
tblen = 6*L; %Viterbi�������������
msg = randi([0,1],1,N); %��Ϣ��������
msg1 = convenc(msg,tre1); %�������
x1 = pskmod(msg1,M); %BPSK����
for ii=1:length(EbN0)
    ii
    y = awgn(x1,EbN0(ii)-3); %�����˹����������Ϊ����Ϊ1/2������ÿ�����ŵ�����Ҫ�ȱ�����������3dB
    y1 = pskdemod(y,M); %Ӳ�о�
    y1 = vitdec(y1,tre1,tblen,'cont','hard'); %Viterbi����
    [err ber1(ii)] = biterr(y1(tblen+1:end),msg(1:end-tblen)); %�������
    
    y2 = vitdec(real(y),tre1,tblen,'cont','unquant'); %Viterbi����
    [err ber2(ii)] = biterr(y2(tblen+1:end),msg(1:end-tblen)); %�������
end
ber = berawgn(EbN0,'psk',2,'nodiff'); %BPSK���Ƶ������������
semilogy(EbN0,ber,'-ko',EbN0,ber1,'-k*',EbN0,ber2,'-k+');
legend("BPSK���Ƶ������������","Ӳ�о��������","���о��������");
title("���������")
xlabel("Eb/N0");ylabel("�������");
    
    
    