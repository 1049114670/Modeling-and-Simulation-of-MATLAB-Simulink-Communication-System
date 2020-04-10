clear all
N = 100000; %��Ϣ���ص�����
M = 4; %QPSK����
n = 7; %Hamming���鳤��n=2^m-1
m = 3; %�ලλ����
graycode = [0 1 3 2];

msg = randi([0,1],N,n-m); %������������
msg1 = reshape(msg.',log2(M),N*(n-m)/log2(M)).';
msg1_de = bi2de(msg1,'left-msb'); %��Ϣ����ת��Ϊ10������ʽ
msg1 = graycode(msg1_de+1); %Gray����
msg1 = pskmod(msg1,M); %QPSK����
Eb1 = norm(msg1).^2/(N*(n-m)); %�����������
msg2 = encode(msg,n,n-m); %Hamming����
msg2 = reshape(msg2.',log2(M),N*n/log2(M)).';
msg2_de = bi2de(msg2,'left-msb'); %��Ϣ����ת��Ϊ10������ʽ
msg2 = graycode(msg2_de+1); %Gray����
msg2 = pskmod(msg2,M); %QPSK����
Eb2 = norm(msg2).^2/(N*(n-m)); %�����������
EbN0 = 0:2:20; %�����
EbN0_lin = 10.^(EbN0/10); %����ȵ�����ֵ
for index=1:length(EbN0_lin)
    index
    sigma1 = sqrt(Eb1/(2*EbN0_lin(index))); %δ�����������׼��
    rx1 = msg1+sigma1*(randn(1,length(msg1))+j*randn(1,length(msg1))); %�����˹������
    y1 = pskdemod(rx1,M); %δ����QPSK���
    y1_de = graycode(y1+1); %δ�����Gray��ӳ��
    [err ber1(index)] = biterr(msg1_de.',y1_de,log2(M)); %δ������������
    
    sigma2 = sqrt(Eb2/(2*EbN0_lin(index))); %�����������׼��
    rx2 = msg2+sigma2*(randn(1,length(msg2))+j*randn(1,length(msg2))); %�����˹������
    y2 = pskdemod(rx2,M); %����QPSK���
    y2 = graycode(y2+1); %�����Gray��ӳ��
    y2 = de2bi(y2,'left-msb'); %ת��Ϊ��������ʽ
    y2 = reshape(y2.',n,N).';
    y2 = decode(y2,n,n-m); %����
    [err ber2(index)] = biterr(msg,y2); %δ������������
end

semilogy(EbN0,ber1,'-ko',EbN0,ber2,'-k*');
legend("δ����","Hamming(7,4)����");
title("δ�����Hamming(7,4)�����QPSK��AWGN�ŵ��µ�����")
xlabel("Eb/N0");ylabel("�������");

%����ֽ�ԭ���Ǳ������濪ʼС������ȴ�����Ӱ��

